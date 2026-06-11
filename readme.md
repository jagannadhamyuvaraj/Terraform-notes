<h2> File structure followed in Terraform</h2>

- Generally we need to create separate files for variables, locals, providers for simplicity and use them for dev, prod, deployment. Always keep a <b>readme file </b> for better understanding.

- A typical enterprise level terraform file structure should be like this.


<ul> Environment-Specific Structure</ul>

```
          environments/
├── dev/
│   ├── backend.tf
│   ├── terraform.tfvars
│   └── main.tf
├── staging/
│   ├── backend.tf
│   ├── terraform.tfvars
│   └── main.tf
└── production/
    ├── backend.tf
    ├── terraform.tfvars
    └── main.tf

modules/
├── vpc/
├── security/
└── compute/

shared/
├── variables.tf
├── outputs.tf
└── locals.tf
```

<ul> Service-Based Structure</ul>

'''
infrastructure/
├── networking/
│   ├── vpc.tf
│   ├── subnets.tf
│   └── routing.tf
├── security/
│   ├── security-groups.tf
│   ├── nacls.tf
│   └── iam.tf
├── compute/
│   ├── ec2.tf
│   ├── autoscaling.tf
│   └── load-balancers.tf
├── storage/
│   ├── s3.tf
│   ├── ebs.tf
│   └── efs.tf
└── data/
    ├── rds.tf
    ├── dynamodb.tf
    └── elasticache.tf

```

Best Practices
1. **Consistent Naming

- Use clear, descriptive file names
- Follow team conventions
- Use lowercase with hyphens or underscores
2. **Logical Grouping

- Group related resources together
- Separate by AWS service or function
- Consider dependencies when organizing
3. **Size Management

- Keep files manageable (< 500 lines)
- Split large files by functionality
- Use modules for reusable components
4. **Dependencies

- Place provider and backend configs first
- Define variables before using them
- Output values at the end

5. **Documentation

- Include README.md
- Comment complex configurations
- Document variable purposes