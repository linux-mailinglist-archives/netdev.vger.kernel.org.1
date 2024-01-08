Return-Path: <netdev+bounces-62415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87459827057
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 14:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6631C2280F
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F54644F;
	Mon,  8 Jan 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MAfeWlcR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C263A46431
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0dCdzhBfXCIQeTYfx+/FtPv1LUidDuEL2cBXFs/VTifM5qVnSfXTmkrBsaSdgI4LIJw6Td33moXJsQasytLMJp0HDxGkGtNSMYOlb8taJLrr8v7kbUW/r7hDTLxO7cdpXJR41Ehw1bFUkP6KCklMIX0BawV6PyhDZjgsNbECmg/A/AG4BJOCJb9XuA9MdsA0603E53vV/iMEpO/LR3+ydr8Say2iM5nP3TZ3NM+vAvBAemLTnhBXCVCGjK3Uv03dCGwf9YDQEZBYv9TPhxvADpY+Ojz7Wfy61zgKxAURGgIunYJVQcnlV2mqTI0PrTMWkkZ9F4SzkMHoW9JwcFshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSUNelq8m0B9jDIiYZ+6LRIhB4tNKeiYcp6eASiCae4=;
 b=Jyoip39V9g5LKWQ6wWR/rrIVukaZ5hU/tWZMLK9c4yYDW6kufV4X7Wd3Xyu6mRjjg3vfuqHS4dK266yYtZ8aiZP9VObrrGZ2ocp+MJs9IwwQ20m5mxmz9n6wP7Dx3L+naCAjGeoTNZVWXj6heY+61dOI14O2DzOTgs+RRx8Fct4+s8undghdQzfus2JoU1LDwlRcwfXe8+kLLQVugVhmumyqtnlArNv975cKBgeYfnn6plVk6DQjXvQJZTXPNKd8T0wkvddeDLrtUbqylnWRF+PFucd1QoyDnoFtMDmoSQYnyKkLFNDbvHLWO4k+xx87JdJQZmMs6FDt4o2FWpKXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSUNelq8m0B9jDIiYZ+6LRIhB4tNKeiYcp6eASiCae4=;
 b=MAfeWlcRoxG55+Xk8YEpLk7ah6WXcUjsEdew7hS0oeAyqqpbHlaXA4t8CEQSKq/GrLCryqza7APyFAJmiVTSCuIv3hArppMHFSa7p2KaG7Yq//x8La0ees+0SdT1EOlZ/qQGqg4rPjqXJ4p4G/FIg6TKa/a3hUmydmhAUVscmn7PhOqgdehO6wlumpC90bkDjiuwg252K3BNmqTbgMtqJX+agzU4N/F4XNsRaOhPW7/OY7XOlBHwh5kI8TFbgIy474ET/z7occTCVkNgJroB2kCzjCJ2l9OY5k+QJVEu+lPgpUDHfCrzYeZ7H7wg8JVn78NJC43QRIKAFYJxwjXVQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 13:50:16 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::1442:8457:183b:d231%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 13:50:16 +0000
Message-ID: <daaff866-b5f6-4fa8-a35b-8172d9ab9929@nvidia.com>
Date: Mon, 8 Jan 2024 15:50:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 08/15] net/mlx5e: Create single netdev per SD group
To: Aishwarya TCV <aishwarya.tcv@arm.com>, Saeed Mahameed <saeed@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Mark Brown <broonie@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-9-saeed@kernel.org>
 <89d33974-81fa-4926-9796-31bcd6d6cdc4@arm.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <89d33974-81fa-4926-9796-31bcd6d6cdc4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0024.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::10) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 31aed468-714c-4083-ab50-08dc1050be77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jCQ546qldVcPdX7bvwl/ynfXKghh0yLusG/SKsojj9INPHkzm7zSM22aVLEsfQPqHX0efqdmlob+ZvyxgRyBhcqu0bjH8lgKgKb0uvkqb3+YlPG13OSPRtDd4C/5oclJkLXZ/8apm3RBuyBXbVy5OdPEcpWnZ9o9tDtAaYyiJ+JEKgr/ervRnKn4aVrC2PwulTU47tgLh8XmaB9L1GnLiviI6TZn9yPh/ryhkRkla4z4OiWB3eQf/Tw9Lvaw+35GoMzoeSwhNMUKH+R4YjdM3kxqJyUB7PZQS23C1KmzIyRmHo3KI8mTg2W1XPxikKZ7JLtu2N15g/04H9oMXuvVit8/lriKGJr3vrYuqwHbmFBPDSOet1WGjefI0nf3CyLmvLZ4RQ1UQQqtr0urqBFhiz2N05I/FWEpd0zIBJuXU0MWUQ5wF8zrLesA1K3UYJJQTNQNfSQbaA0IyBz7KrE4PtagKgog9vT7I3RsYqjKlOSjJJmul3Rqo6I8HXEuTb8/Co4DrdWJUb3dt/IPUdFmA912DwrLgTW0rkMgyIzu9XOiroVVSSulXVq3D4mrFC3ml8R7jlgMex6HIw2v7VFAJ4pwRN0v1GPr6A4/We7W3SPZIgHdZr/t56kipKJhILTnfwl684Ib8tHsDS80+mi5lP+GDPYKSo6Dqbdd9JAvNggbs/T58eWNPQbdWnxQn7wi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36756003)(8676002)(8936002)(110136005)(6636002)(54906003)(316002)(6666004)(4326008)(5660300002)(83380400001)(478600001)(6506007)(53546011)(6512007)(66946007)(26005)(66476007)(66556008)(6486002)(2616005)(41300700001)(38100700002)(4001150100001)(2906002)(31686004)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkorVXlZL0RraGN2aUsvdUVuWEg0UFhpazJCeXU0b294MFFqRWtuRnEzZEY5?=
 =?utf-8?B?ODM5ZktaMnVGUmF6RVpSU2JoS3lPbVVWOUdTZWwwYzY0bEtlMTJEdVhHU0Fh?=
 =?utf-8?B?eTdTYWZTeExHVkJvZTMvSytydFBBTFhJenU2MVFKWEpyVHZ3M3Z3MWZJa3Mv?=
 =?utf-8?B?eGZualpJY3k1c0ttb2ljVk9Gcm1PU1R5MkxFTHVkcXp5N2dsUXRVcjhlbVB6?=
 =?utf-8?B?N3p5VVdYbTBTRHh1MjJMbVg4K1cxeXpqb0lpRHIyRHJYSVBQNXNRUEVTY1dM?=
 =?utf-8?B?YU1rRkpFMlA4aDBFYndXNTBJYUVpcDhPL3k1enBiSUFWcURRcEdtbmh0cU9O?=
 =?utf-8?B?SGNIQ1NqakpUQ3JtODUxcm8vRlV0TzlacjBkaXR1aFBDeElxTDVqaXJhUVVm?=
 =?utf-8?B?TlIxUzVMOGR1bWozVVpabmovZit0N0RCUzd3WGhtd3owZ0NsYmM5MVM1aE92?=
 =?utf-8?B?WUFwL2g2QndOVngyUE5vZmRmM0VlRmQyNEVjZDZzSFBWWVJLZEtTL3RBNk41?=
 =?utf-8?B?NDdTK2dGQVpwRWMrVTZkZzQyajhUY01KMTZ5OHhzTGgrU1lidU1pYXZOODRQ?=
 =?utf-8?B?bWtTSzhyakU1VytZOEc2RmFhd2FTRXVmck5jUzFVaDVjb09nalVrcjNUQ1gx?=
 =?utf-8?B?bmZmdlp1eHVDWkw1cTZpSHdHWW5uNnkza2IyRXBvdTdLamJFd1E5VVV2YUdX?=
 =?utf-8?B?SWs4L0VpTUhlQ2RnSDJtd0xSL1FpQVRxTWZvcm80N2k0OENnaUp3WmxjaWhN?=
 =?utf-8?B?cThRZ0dTZ1hJU1FEYmhWbkFvVTNBcFdzcmI0bzdtRmRzaXNOQWpVUlFhQ2x6?=
 =?utf-8?B?Vy94SHEwY2ZNSUs1VUl2Y3l2NGR2VlJQY1ZhQVhBQ2tpK28wcFpVRk1IWXh5?=
 =?utf-8?B?dE53Tks5anhCRDZ6TWVJZ1g0aWcyNExmNmJEc0pzYzdSbXZ0WFo4Slg3Vm9D?=
 =?utf-8?B?V3lyNVV2b216eGxTd2FMTWJESEdEOGYvcDZGdWV4d2hFREhpdGZnR0ZLMHZ1?=
 =?utf-8?B?Z0RJdnJ1ajdrdm1tVnJQWmdlSWc2UUpLeU80dUVHRUE3cjJkL3VsNUh0NWlk?=
 =?utf-8?B?cmNhVlE5YmxIdTM5RGhRaXdZUFFrV3AvWnJrUWpLQ0tkY2VTazNvZWgvVnZj?=
 =?utf-8?B?MndLZ1gxUi84eE92RXVsUU9wZFhpZzFDdnhiSCszSDlJR1BLdzNtMmYvTjFk?=
 =?utf-8?B?NHRyZGZzMDdXOWxxUk9Bc2hHWWR6RWpPckloL1VNS0J5NGlTdUY2NGFoUVhF?=
 =?utf-8?B?aGRibnYzS1ltekRyZmh6NTQ3ZG14VUpqUmlYeEU3OFlQdC9ZNWxBTEVqZ3BE?=
 =?utf-8?B?bEZLdnk5YWgzQ3BTN2lUc2dhNitia3p1VTh1cDFPaTlOMzNLZkRuaGpWVEhi?=
 =?utf-8?B?L284REMranh2ZGlOTHMzREQ2MUdKd3V4dGdrTUpNOW9BK3BmdjZCMW80UnJT?=
 =?utf-8?B?VzRrcCtEL1pNUjVWVUVVRHA5b1BvMmFZbFBrSTN5ckttUDJYbG1aaktJajYx?=
 =?utf-8?B?TFg4Ylhvb0xQcFE5YmcyVHdCMFEraWErSGNsai8vYlZ5ZTNmNU9zUmQ5QmRH?=
 =?utf-8?B?SkZJcDdRK2szMDN4NFdETjQzM2dYcWZsdVZnOUpSOG41UjhSandjVFlDYU0x?=
 =?utf-8?B?WWR2ckt2cFV1UWZhQkErOWpHclltUlJ5YWlDOHRzZStRa01nZ2FKUkhuWVBW?=
 =?utf-8?B?NFNpVmRGRWpkK05PQUhvR2xybHB3MGFhSThMbWwrN1BxaVp1RmRDY1dWL2NP?=
 =?utf-8?B?bkhycGtWR2hZdiszQkE1aXlOajdreEdkN2xUVHRtN1Y0UWVGZG84bUFjY1Fu?=
 =?utf-8?B?N0orWHNETFRlYUJIVm9lK2ppQnR0U2R6WlhrWWllNFFlQkdWL201MU4rOU9x?=
 =?utf-8?B?aEtDK3ZjVEQxNXFEK29GbEdTd3dRdEVvM0lWZXJXQ004NmpmakE1Zk5lLzBS?=
 =?utf-8?B?TlhSbWhObjVFUmZSZ2VHVG1iQ1VUZHJydGlPZnYxeXkyNU5Vc2hueWEwUlRp?=
 =?utf-8?B?cGNqSThzM3JEQ0pVZjNkS2FFcCt6VWVMd2ZsVkQ0NEFDSkZJcEV2Y0tYN2tO?=
 =?utf-8?B?NlJJNVQzTUFMRGRNV1JkYkxiY3RsRjdpYm1wN1FMWm5Dc2pJb1hPaFhVTlQv?=
 =?utf-8?Q?pW5ywQsQevoLT6CbuqvC7YJKc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aed468-714c-4083-ab50-08dc1050be77
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:50:16.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZbA3XXSLQtFRgUVur5mlnMz584NdIO5SKZUk1beKnCHknILacrbU3CqYLsRyyfA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

On 08/01/2024 15:36, Aishwarya TCV wrote:
> 
> 
> On 21/12/2023 00:57, Saeed Mahameed wrote:
>> From: Tariq Toukan <tariqt@nvidia.com>
>>
>> Integrate the SD library calls into the auxiliary_driver ops in
>> preparation for creating a single netdev for the multiple devices
>> belonging to the same SD group.
>>
>> SD is still disabled at this stage. It is enabled by a downstream patch
>> when all needed parts are implemented.
>>
>> The netdev is created only when the SD group, with all its participants,
>> are ready. It is later destroyed if any of the participating devices
>> drops.
>>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> Reviewed-by: Gal Pressman <gal@nvidia.com>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> ---
> 
> Hi Tariq,
> 
> 
> Currently when booting the kernel against next-master(next-20240108)
> with Arm64 on Marvell Thunder X2 (TX2), the kernel is failing to probe
> the network card which is resulting in boot failures for our CI (with
> rootfs over NFS). I can send the full logs if required. Most other
> boards seem fine.
> 
> A bisect (full log below) identified this patch as introducing the
> failure. Bisected it on the tag "mlx5-updates-2023-12-20" at repo
> "https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/".
> 
> This works fine on Linux 6.7-rc5

Thanks Aishwarya!

We just stumbled upon this internally as well, I assume you are using a
(very) old firmware version?
If it's the same issue we should have a fix coming soon.

