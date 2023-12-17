Return-Path: <netdev+bounces-58347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD697815EEA
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 13:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312F01F21C4A
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF47328BF;
	Sun, 17 Dec 2023 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bZq9kPaF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998F32C67
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AooXMUsCbJ9jRQiDq2c9hVHOozyO9BQMXxW52EVLKNHx9kBAw+wq7JF5X7QEsUSkW6AZ+sO+RYmRTfTE+gg6pVYll9pqdeRtToF9QDo/7IJWDsgXKhcbRxKILZ6XF8RGV+H/ZM8iR7btTQ0fHpNxNueZ3tpcpbvAjNqbt3bF+ZaV5OnwzbNlQU9PJUuZLEgwZ1n1OnBm0XUqHEg/lR4tdtpxiNt7o5WFxhYmmlBFlHw3OlgvF+cZVBVWxCD4USKj1eKmiA1KEEtRTFJU9xG1gFHxqTzFxJY9x2kX9snmKIi9Mv+OfMBQhRTzDFJugZY2laMppVykKFQEBI5nh/t5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjdF22WNenCIp99DXJuK4ECLvZFp7hY8n7/CiySMXfM=;
 b=d8BHygjaJjcqlLVbsmXuA+kpS1lXiCXeNFtZJYAjrvMsbKQg3s+HN/KirdLaqjt2mFWX6U1nm5n/m2lUyMIEnHDh+OEAUEeunXrGSuJQ+nW8UX0GgPpARY/lTQbddv4MjxpztowiQd8Pgq8f5ZPXy/O4h3TOxNbdNnHFBAEPBvwRIBOEFNvPLzfAkpmrKTJJfe8ImrmhwoHcumkPY9FPntViw0stHcUsvQFbEZfOwzzsvGxnQOQF7+rlhqfRWc6QD0cDuwYFA5AgxBxCpEu4kp/RpI20jLRi/c6nLw8e/0J0DjmIJXWKL2z3Z8Jok+QCzn9SGdQjD6JiqqJOOxm2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjdF22WNenCIp99DXJuK4ECLvZFp7hY8n7/CiySMXfM=;
 b=bZq9kPaFbM+RhERkc+393nxfzUrxLFz/Po4vqm0QacA9jlCR6OSk0bZL1+nRd2dVGfVynZXQ51LP9Sdnq9CGIAxt3b0Klpdr4WhrgzfHsKp7XHgCxW41sFw3aLHqUvZC+EJrVm7blq9nYbcARI6GHZfBpTwtpzlT9cNZZaeSCiLLp6aco344FqfKRJ/lQgJxlKcjehI/UtswcrLsbko9rW/tR8K2BG3mFsnIYpQRJ/5Ojej5ywLGR55SXnzBUES/yCGGhd9xO5+ry8dynxWIUtGSkNmvuOPovIbuiHfWyPCnfHZ2AaZPtQU0i3hYqi0fm6gYMHrdmTT71rgiLbGPDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 12:17:42 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 12:17:42 +0000
Date: Sun, 17 Dec 2023 14:17:38 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jiri@resnulli.us, jhs@mojatatu.com, victor@mojatatu.com,
	martin@strongswan.org, razor@blackwall.org, lucien.xin@gmail.com,
	edwin.peer@broadcom.com, amcohen@nvidia.com
Subject: Re: [PATCH net-next 1/2] net: rtnl: introduce
 rcu_replace_pointer_rtnl
Message-ID: <ZX7m4rYR9Djl+J8V@shredder>
References: <20231215175711.323784-1-pctammela@mojatatu.com>
 <20231215175711.323784-2-pctammela@mojatatu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215175711.323784-2-pctammela@mojatatu.com>
X-ClientProxiedBy: ZR0P278CA0066.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::17) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: b79727b8-9721-4832-52f1-08dbfefa2b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LLOHt00nlNik5d1aGyrn2NRmGbk08I4qlta3l7x/8923JXdH8I+d5X64lmO7FQkDVPNHC+Lj9YwqYLhJwX7eFdntOUGX/AcflFV+KotQeFcbXIArqSB0/iKbwpMBBLMqp6Lxk0InSx5d0dp22dtC8w9x4ICCsKV40Z1cpxx+oHV3vsRh5MF3Tv448mggitvPSafsITs/mG8sYyU6LjyhuatD7GS+F9iTPgtHVTmO8e7eEwl41JqgXsaHPIejQ4Adw5yxTgUOwmII25H2dRAAZB5hSm5EknoRtnrFvz5oEh3BEadRNtq9/c55snJ81GWPRfXdE1OsxKq5y+JQfNxe2xYkk8v5HnBO4kkTI1Z4Wk8B7FQ7SrEMqrbA41CbL8Fiw/CoErfFnkhCUloSfbBFUGRye0C4+SYUWQvRxC5EKHJxrS9swyInWEOz+zzV38w77Ryo+/92N5EbRPx5kEBBLo8f+0zYAKI2cY8ZrZMDLS4uDDRzjLHqyhfVwi96h6oJz6VSMyEoeLG/vVezNYdE8GhJ17jadDa04CkdW4NOY/KfyOgHG2pItEbsTfDS1XhPiRXq7pKd9DIsHL6ISZAqDs53ckZhDQWguQ73m7qk9CQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(376002)(396003)(39850400004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4744005)(2906002)(7416002)(5660300002)(41300700001)(86362001)(33716001)(38100700002)(26005)(6486002)(107886003)(83380400001)(66946007)(66556008)(6916009)(478600001)(316002)(66476007)(6506007)(6512007)(6666004)(9686003)(4326008)(8676002)(8936002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?03o4SdpsinpgrW39NR3nfiM4aZfQlVxaWzkWWMT+hqBKzywilFIYSBJfRapW?=
 =?us-ascii?Q?hH5StZDSXihZ3ae4iiUhhQ7FLvSgOymaim+3aTB4XOenu8TJO9E0DHwrT5Sg?=
 =?us-ascii?Q?Lqm3KF9mFNV+WZU4LzBdWMovJ0gp2d1+qbk+7khZbqfONEzXFtD7s0lszEe+?=
 =?us-ascii?Q?UTiC7x5FyYeEhDe5wa5yGTY77S91YUADr2GuAaDeTBSf0JB3tX1514mJEITP?=
 =?us-ascii?Q?UfqwHLaxPi7N6IT/r3cHlRKufkOREW4Y4kSbPTXD/cgxbSOlohGILZ9wHVZV?=
 =?us-ascii?Q?S+3zah5GMwbMqit1mNsM6FmgY4+iEJT5ooDjJukVlvDuC8WCjA5VRdR/6B2X?=
 =?us-ascii?Q?aiYt/9gNPnWRe5T+k2gHQcNCFqAkWKi+jTlR3X78Bf0R1M7Z7wOdrUHfWXsw?=
 =?us-ascii?Q?4tHNqtZ0sk/VQ3snFlXlC/R8PFsPQsjpeV4w4wUTtK9s+mcm4oCzffCapcv0?=
 =?us-ascii?Q?YrYQN1+Ya1WrT1k9oxG8DRDpEFFD5C2mdfXZYQGSESBjMp82+ijaoBoVbiyZ?=
 =?us-ascii?Q?ABSSsb7drush+FIlwvZQj3cUm5lGHLxL98rSrtYLA4PNzjci5q7N4mpzd/EY?=
 =?us-ascii?Q?OD2ZAs4M1eGw5JjylD4/MXwBtbQjncRz80DYEw2fcE2lHQNcQePj0324P5ob?=
 =?us-ascii?Q?cOEtZzSpCdCpWWa/tmZRpeqaMd/TSyUVV0vfpt5VvjT+RgHlza4Sf3ZfzfAL?=
 =?us-ascii?Q?fOuPm4uMN896qigYbRy3B82zeHiyOqDL+9LVmMcOJWHavzlVUVSsrH9YCz8o?=
 =?us-ascii?Q?O7AddB/EsaSk1p3b8V7vvbdC6f8sBUMM3M8jk2ITjaNKsBaanaZ54FGpV6YL?=
 =?us-ascii?Q?ATM6dE3RhgOObk0tZkt/rOTrEHbJVe2KK0AJBlYHMosAevQGAtLml0xfZAFH?=
 =?us-ascii?Q?0Z1cf4XTfLcco6u3WsPT9/C95s+nDaG8FtA2BNct0zuH2txddlKrw/bRJvoW?=
 =?us-ascii?Q?9rmSPMO/MoOLV6rMGwTcEY9WOFpMHyphjDzZFqz3v7AmOeN5coZoQNrUNf51?=
 =?us-ascii?Q?V3LEnVB39f3FcaraN1Ri4G/N5Qggo7nzWduIzxf0pK/RLE3jsbsJ84JBBiDl?=
 =?us-ascii?Q?lbdm8fE/u+OJtH7giJ/JkWa69PAMoSC4ff+iVtwU1HDH4aLLKJE1nWFeenwY?=
 =?us-ascii?Q?auk7xUaTM72jfYy/1q/ibT9IOuMDj3VUoQ/jwsT/U6cQEV8/O5mDF9DikMMu?=
 =?us-ascii?Q?4/5whcoBHiZxR2UciUGfXpvHyhb/rehMJQF/FmCQBlc5vxFGLuc3AmAb7Yli?=
 =?us-ascii?Q?jxnoaq0PsJQqLoU4sNf1FqIQ45QZ2+yDo3FY4x23A1bSYaXbfiW5YtPGMYX4?=
 =?us-ascii?Q?GZRqqDczT3Z66naZB/ai133MUZeqJxj8tzaa243DC/VvsoCDlqJqcK86j3T4?=
 =?us-ascii?Q?C1L6PzyrKNGPt9cUOolwziFdzVRKDosHlcgAnH96ZUeX2ETaFdCyVnvE/FK3?=
 =?us-ascii?Q?IjbSSWLCxk9Jv7MztyxzKx/MlkQSmlDcCY2vl4WWpBdlfuG4NoRTpK7AYV0o?=
 =?us-ascii?Q?V3tqiS+6kStGB95PGaviN+vhffSjb+hQc8AKQEWzcP8nfB841yuHQ1BqvUZh?=
 =?us-ascii?Q?ZtEMR4y7gWmK7Hy/yZchfLzgNMDVrkqNHI9VpDQZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79727b8-9721-4832-52f1-08dbfefa2b20
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 12:17:42.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSR1Xi2pRC8nNz7RKYKDcZfWhMvIpofH9XxDpKdJ7foRMDVguiOSc03e0ShZ7vVJZyR1z8KKRfRGA1WvfJzOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224

On Fri, Dec 15, 2023 at 02:57:10PM -0300, Pedro Tammela wrote:
> From: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> Introduce the rcu_replace_pointer_rtnl helper to lockdep check rtnl lock
> rcu replacements, alongside the already existing helpers.
> 
> This is a quality of life helper so instead of using:
>    rcu_replace_pointer(rp, p, lockdep_rtnl_is_held())
>    .. or the open coded..
>    rtnl_dereference() / rcu_assign_pointer()
>    .. or the lazy check version ..
>    rcu_replace_pointer(rp, p, 1)
> Use:
>    rcu_replace_pointer_rtnl(rp, p)
> 
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

