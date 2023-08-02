Return-Path: <netdev+bounces-23623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD1176CC5A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DED7281D61
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681AA6FD9;
	Wed,  2 Aug 2023 12:11:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF57460
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:11:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E81BFD;
	Wed,  2 Aug 2023 05:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RF3r3q7JXq20i6sGqKryTir/vkOMvUIirPoNd7jwOXbsWKOr4/Y/OY0Jcnv042pWsuTMcHJUt91KTkyFmnuZYuh+g6LOHrccsVkgAo51XRCV3ASm/q81LtAcfokIKpfapjxsZmE27vhHp5cd6DpHUQ6j00p9DD/zjUTCe5diENqpPEUzNs3g6nZNRhtgzH+mdT8ZaF4Yy6mXUQQbVNRVQwAk8seppMNGxgYPIY1Wc1JgKrN50yk4640xCx+eeDk4QSJFJ7AZEOPFi5IP1n6ZZNpq8GVVSCiIrOpoidKjBI4yNpVZVy+PkiiUUAfRNmVTq5VVXFVswVKoVpUclXhSnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5EL05FF+i0/d/mWZssBydcaTcmI1K76e/mSL6dDCrg=;
 b=lfiO7nO1+0K6/E0w2W4/spH+nHVlkR/Z2kbw8LfLqu9u86KmfCfGGCIvMI0JDassyxZZDnQzYHUDWboDFuVpL4GJbP+glSMI2RaFuZZnIeof7MoiqS+ZN6wbZt7Y3GMnuchfNSkFooPvSmUydm5tv54jaS+HsoZHz4syyNg/uEUZXF7TVcv7H4ohVBl1AsHFhMLIK7s57Ye7JCXNJaIPpf5fkudwevYSscQ6guXSEOnhN3Pjr/u1LoFs2LxznQOje2kAnrtcK45F03guvSJMJtG6EdLBSreSRjHWaVcxDX78OAx/oBP5gG+vf22S2jU+o92dG846PdMxtJQW2I2MHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5EL05FF+i0/d/mWZssBydcaTcmI1K76e/mSL6dDCrg=;
 b=UjO3ZzeMgUWqGhVOL7xL++upwK6nH0TAHIAcWd7EcvM2sdHftXWOWzl6ExNSI9/NEiKWSOaGe4PxGzc8aT8yGdTZT3KhKWX4Flv4rXUm6NF2ioohuunjLeNlotY3i/GmRkTcvRLtFjx27Q4DWJK9jXmQtTytnn8PmTOaOj6Eh4IlXS8hcgNVavrbBCGpWd6ujoLzorVxP+RtkiAvQRy/hJmCDuvej8+9v54L9qtdK3+db3Jx6N+WDMBg8jjeKkUiFrFeN8Om+EePWd7zxPWZF9PvsKAPbwWkjXhrTz/3YhlFWjD8d5/kQMu1pVovboksvFxZchq4VC3AkqhbcdY4pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 12:10:58 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 12:10:58 +0000
Message-ID: <a3a996a3-81e3-5476-6cdf-ca034a7398e4@nvidia.com>
Date: Wed, 2 Aug 2023 15:10:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 2/2] net/mlx5: Expose NIC temperature via
 hardware monitoring kernel API
To: Guenter Roeck <linux@roeck-us.net>, Saeed Mahameed <saeed@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, linux-hwmon@vger.kernel.org,
 Jean Delvare <jdelvare@suse.com>, Adham Faris <afaris@nvidia.com>
References: <20230727185922.72131-1-saeed@kernel.org>
 <20230727185922.72131-3-saeed@kernel.org>
 <9479d3cb-0e1c-a55a-ca07-97f4205c46c8@roeck-us.net>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <9479d3cb-0e1c-a55a-ca07-97f4205c46c8@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a5bdf5-3568-455c-2e48-08db935187df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kHcb/P9N3jnGhIvd7gQlWSCR4Jd0aT73rXg7Ni0RnST3tLV4YFjUbt9nye2UDzRy09XDJgvVNtTJ51P35QCypptHe43A3MnHHztFTI9x9N3jAQZW0oidkjl5rbPNquLBJs8EALL2npt+AyweCRX7VAjY+OGRoNzVwI7/RRu1bjV4859K9I8fY7WK4eSrytyL/ZTbtVwuPxQFXJr/5mZXHUEt2SA+hQDW+OZkjgJna+aBzrilivVNmlLX1CwYYzHQqcDG7OmAT5jw2bIQWQ76wslYliXI7KwgXJlw18Lj2lszc01wAt48n5QXVb3fe5h+xtcW+dWe/xL1cCM9IpXJGY/sQLxLGT/KMXJCCKbPBX/KzChcaP92N2dDzcQ83a+0XatkQD/UH7rPg4bIJWIaTk9ORtB8dS9UY62XBuHyOW+5e+ZjkIMU97L30H5qfuYjOBKAv1EPL0sSArYums9nEw1WIt7vmQ62YG+0W4OrtNY2T4S5S9EcOUokCkoC3P8sFmR4+DVy8kfvwIBcmgMoiCH2OfBRToocGs01wdSucz8dqYzx7Xs+w5oGRaEpOwC1CKSPANxOOLwJ0+GlLcJyzWiP44JPun0bar/weSRYDh0l94wDuYI1WFPqyt0jHkm39NtLXmkSOmT1VksXRHcllg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199021)(66556008)(4326008)(66476007)(2906002)(38100700002)(66946007)(2616005)(53546011)(186003)(6506007)(26005)(54906003)(110136005)(86362001)(31696002)(107886003)(36756003)(478600001)(6512007)(6666004)(6486002)(41300700001)(8936002)(8676002)(5660300002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJsdGczM2tlbDhsdUJwWTlmRFVFU3FxT3lsU0VOUWVKZnNSY2hDSHFrQlRw?=
 =?utf-8?B?Y2dTaWE3V3YrNy9sN3U2UTFNbnNFRHk3anpHemhPRXYweFRxSTNWdTF2YlB6?=
 =?utf-8?B?L3FuVTFHeUM1MVI1U1ZOcnU1cVU4TXZIb2ljQ3NjRXNWYnRFczUrbU1KUEdZ?=
 =?utf-8?B?SjdhbCtDRkhGd0I0c1orMVNidExYdG5lakVqbXN6REdBa05wZXp6UjVTWGU4?=
 =?utf-8?B?ZGZRcXg4UnFySDBTYWtJQ0k0MDFqSkhleEQ5eHpWWGdhVGkzUEo1Nk9JZFd0?=
 =?utf-8?B?MTE4dXliVU5xd2x2UmJTOWYxSjBFSWkxcmlHcVBKZHVFaDdJQ3J6YkFLaU81?=
 =?utf-8?B?SHhsQmVUajcyR1VTU2tUYTgyM1RhRmIxV1pHNTdFdEZPUC8xeGljVG5aYWh4?=
 =?utf-8?B?djM3eDM1eTJnbkE0UTRNcHMzRWxUSDc0NVNOTzFwV0VNSXo4Q3BmSEdIMDFH?=
 =?utf-8?B?VUhFQlFCWlQzOTJjKzU5amV4cEtJb0UvQTRwZk5kOWd6QTRKWnRwZ3lwbnZK?=
 =?utf-8?B?c0xXOVY5NUxvK1RVajVaTWthZlllVHdkK1p1cy9IbGVwcU1FMUlHQ0NzanQx?=
 =?utf-8?B?VGdEMlZCYkx5NUhZSWQ2UytRdTdNMEhkRGNEZzcwZk1YWmxNRnJqZGd6WlZn?=
 =?utf-8?B?UXI2bmxYS3lTNndOM3ZCU0JkcFZibEZXaDQ4aUJTUThqNWU3QzMrU3YwZHpF?=
 =?utf-8?B?RGxoa3l3MzBleTJWTks0MG1waUpuSm43S21uQzg1aHJiOXliUGcrdDRDRWdG?=
 =?utf-8?B?SUo0ZVdUTXh3b2FUSzh6SWdBUFN4VWF6SlQ3K1ZlVGRyMDZDaFFETnBMYStB?=
 =?utf-8?B?MnZPMEZlNUV3WTBEZDZpbU1FTWZMdmtXOTNTTnU5TTRyOERTV2JPaGQ5MUQ3?=
 =?utf-8?B?WnRFV2xVZGxVOHp6QXAwWXJLdCttdC9xdG9hZHdIRTJvL2ptUEtaR1k1dnBj?=
 =?utf-8?B?R3BKUjREaUVHaS9yY05DVVFCbVpvSnZiSW51VkJtWFhBeGV6cW5VRk1mM3Vn?=
 =?utf-8?B?NjVwRmpraElRQnlkVWhrUGV1RmZ0YmtldVhLS0NMVm1VRUVjMTBIUVFWMUdQ?=
 =?utf-8?B?eUtaTk1RMGE1OENTTjRxL2NMT3ByalgyM3ViRXovM0ZPVHM3Q3pIVTA1aWR4?=
 =?utf-8?B?U1NtV3oySmVpbVFucVBFMXo5Q084Q0NvTjZJaTdueGRXeDJjOG5iVitJTFlP?=
 =?utf-8?B?WStva2lzdkhBYkM5YUloOFJKSzJuTUN0MlU3RlNsUVh6MHQzNW1NUXlRVlNO?=
 =?utf-8?B?YzFzR3h6VUNFcVdiVkpheG1PWUplaTFoSWJUOENtWUhvaUo5UGh1SzdaQnhr?=
 =?utf-8?B?bmxJTGx0cVVkNkRDSS9VWi9UR2ttV2NYck1qb2o3bHo5ZTFTUkd4akZUT1Qz?=
 =?utf-8?B?NkRKS1BtY0dEb2tVREs4QmdxK3JaMlZCc3V6TlVObXVOeEpJczEyc0dubXZq?=
 =?utf-8?B?UlQ0WlVtOExUTXQyeGtNREdOcGx6QXI0U2VrUFNPL3gvcTdYRFBzcXBXMUpP?=
 =?utf-8?B?a0p2bHg0UlJsaDQ3ZW1aRjl0UGg1d1YyU2xzdCs5N09YQldHRVhOQ1BXVkNj?=
 =?utf-8?B?dmJza1l1QXFFMEhkSnpOcmx2VmtlNGpjandRV3RWa1A1c3RjZ0YyTGdOaUk0?=
 =?utf-8?B?MUlSbFQ3Yk1QUWxDeTNTWVQ1T1ZTZ1BIM29QaTdrMVJsdXNlNDZNUkpzWXhp?=
 =?utf-8?B?eFZuMStNSStBOWlaOVY2d0daMUwxeitSSGlYb1ZjejVLNCtpaEE4RjIyNWty?=
 =?utf-8?B?NEp3NHpMeUJoWW5nNE1ucFVVQXpSQWNsWUkySVBmaDVGNVYyWmZLRHhjNnhq?=
 =?utf-8?B?SnNsM3VBMDNCUjFHcHorMzhrb1RTME1ESEtGd3RWcUhmSXlXdVBzQlArZTVt?=
 =?utf-8?B?RGFsUW13bmJGYUwzU3ZvaUlwQ3BWWFkwRWlXVXF1UC84T3VtV0swS2FZeWdL?=
 =?utf-8?B?N0sxRGliSGE5clJoT29xNkk5dFhYblViUjloNk9kS2FDaXJQZ3FXOTE2dWIz?=
 =?utf-8?B?RkViOWNSaW9PanoxOEttMHp6SmR3MXR1eE1uMVNySDJHdEh3VDZxVHZIZHpP?=
 =?utf-8?B?dHllYW5GSEdMWEo3TXlKTlBMU1hIeWsvUGdBeFB2V3NtOXBKQzd1TE9McDlY?=
 =?utf-8?Q?WTDTHECktgc5Mv9bifA9reWbw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a5bdf5-3568-455c-2e48-08db935187df
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:10:58.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jz8Qwl9RfeB/Q2W9N3kMpEE7wNy/AbDtzLfsGhkcsbb0l6ZTJF9jO/RpC6R24Pvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Guenter,

On 27/07/2023 22:54, Guenter Roeck wrote:
> On 7/27/23 11:59, Saeed Mahameed wrote:
>> From: Adham Faris <afaris@nvidia.com>
>> $ grep -H -d skip . /sys/class/hwmon/hwmon0/*
>>
>> Output
>> =======================================================================
>> /sys/class/hwmon/hwmon0/name:0000:08:00.0
> 
> That name doesn't seem to be very useful. You might want to consider
> using a different name, such as a simple "mlx5". Since the parent is
> a pci device, the "sensors" command would translate that into something
> like "mlx5-pci-XXXX" which would be much more useful than the
> "0000:08:00.0-pci-0000" which is what you'll see with the current
> name.
> 
>> /sys/class/hwmon/hwmon0/temp1_crit:105000
>> /sys/class/hwmon/hwmon0/temp1_highest:68000
>> /sys/class/hwmon/hwmon0/temp1_input:68000
>> /sys/class/hwmon/hwmon0/temp1_label:sensor0
> 
> I don't really see the value of that label. A label provided by the driver
> should be meaningful and indicate something such as the sensor location.
> Otherwise the default of "temp1" seems to be just as useful to me.

Agree, will change.

>> +int mlx5_hwmon_dev_register(struct mlx5_core_dev *mdev)
>> +{
>> +    struct device *dev = mdev->device;
>> +    struct mlx5_hwmon *hwmon;
>> +    int err;
>> +
>> +    if (!MLX5_CAP_MCAM_REG(mdev, mtmp))
>> +        return 0;
>> +
>> +    hwmon = mlx5_hwmon_alloc(mdev);
>> +    if (IS_ERR(hwmon))
>> +        return PTR_ERR(hwmon);
>> +
>> +    err = mlx5_hwmon_dev_init(hwmon);
>> +    if (err)
>> +        goto err_free_hwmon;
>> +
>> +    hwmon->hwmon_dev = hwmon_device_register_with_info(dev, hwmon->name,
>> +                               hwmon,
>> +                               &hwmon->chip,
>> +                               NULL);
>> +    if (IS_ERR(hwmon->hwmon_dev)) {
>> +        err = PTR_ERR(hwmon->hwmon_dev);
>> +        goto err_free_hwmon;
>> +    }
>> +
>> +    mdev->hwmon = hwmon;
>> +    return 0;
>> +
>> +err_free_hwmon:
>> +    mlx5_hwmon_free(hwmon);
>> +    return err;
>> +}
>> +
> 
> At first glance it seems to me that the hwmon device lifetime matches
> the lifetime of the pci device. If so, it would be much easier and safe
> to use devm_ functions and to tie unregistration to pci device removal.
> Is there a reason for not doing that ?

You're right, but devm_ interface isn't used in anywhere mlx5, we'd
rather not mix it just for hwmon.

> 
> Thanks,
> Guenter
> 
>> +void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev)
>> +{
>> +    struct mlx5_hwmon *hwmon = mdev->hwmon;
>> +
>> +    if (!hwmon)
>> +        return;
>> +
>> +    hwmon_device_unregister(hwmon->hwmon_dev);
>> +    mlx5_hwmon_free(hwmon);
>> +    mdev->hwmon = NULL;
>> +}
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
>> b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
>> new file mode 100644
>> index 000000000000..999654a9b9da
>> --- /dev/null
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved
>> + */
>> +#ifndef __MLX5_HWMON_H__
>> +#define __MLX5_HWMON_H__
>> +
>> +#include <linux/mlx5/driver.h>
>> +
>> +#if IS_ENABLED(CONFIG_HWMON)
> 
> This may need IS_REACHABLE() - unless I am missing something, it is
> possible to configure the mlx5 core with =y even if hwmon is built
> as module. An alternative would be to add a dependency such as
>     depends on HWMON || HWMON=n
> to "config MLX5_CORE".

Ack.

