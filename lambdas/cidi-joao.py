import boto3

client = boto3.client("ecs")

def FilterEvent(event):
    value = event["detail"]["repository-name"]
    return value

def describe_service():
    try:
        response = client.list_services(
        cluster='teste-ci-cd')
        filter_return = []    
        filter_services = response['serviceArns']
        for services in filter_services:
            slash = services.split("/")
            traco = slash[-1].split("-")
            filter_return.append(traco[-1])
        
        
        return filter_return
    except Exception as e:
        print(str(e))
        return False
                
def compareNames(eventFilter, services):
    if eventFilter in services:
        return eventFilter
    return False
def force_new_deployment(service_name):
    """
    Args:
        service_name (string): nome do serviço que vai ser atualizado
    """
    try:
        
        response = client.update_service(
        cluster='teste-ci-cd',
        service= f'service-{service_name}',
        forceNewDeployment=True
        )
        return print(f"Force Deployment Success!🚀 | service-{service_name}")
    except Exception as e:
        print(str(e))
        return False
    
def lambda_handler(event, context):
    print(event)
    filter_on = FilterEvent(event)
    services_on = describe_service()
    compare_on = compareNames(filter_on, services_on)
    if compare_on:
        forceDeployment = force_new_deployment(compare_on)
    else:
        print("ECR Repository dont have service on ECS! ❌")
    return {
        'statusCode': 200,
    }
