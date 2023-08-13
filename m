Return-Path: <netdev+bounces-27099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D4C77A5F3
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 12:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D45280F59
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9311FDC;
	Sun, 13 Aug 2023 10:12:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFFF7E
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 10:12:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA741708
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 03:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2yKzA4ZAjQ1Z+YN/cmpqdnAoIKUWQWt6FCWAdvs1UMIGfGfHOKaCl1f0CrgAdBykDCdHi5ZWawCeadKMTofN4eRKflZscsgwyaK9Ddu8pLioCmlcEMsy8K/4PKp32sKcAUrlnnw8erwRTgNjJduZF/+bhsE7vxQ31jN8XxXKSHqp/hZZDb+dX/0R08RlaMMn/eB3IdiKdi2mq5KYMCKlOoq8dmiP9SQw6h7sIlr6k8iqCbb3uQn9/DjJbDjmeur7TwpJ1bmcqKOxt7TjOaYUDjwn5i8DeuXDP5AWeR4GfzcPxzUAzZ6komhjKbWaRTv171XvIGk/I1eLl/BFYhofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkCQpR+8OLnuPwNjFUfUyTh2Ij0sWaMSrHlwn+WXaXo=;
 b=H3fcDf+BLb+nUFCxKHR1Y3LjtpY/EwsJO5nmoWfDS384fKRwYEASgW8My27VM3UDhGUwG/wIC5zL9irdZHHb1o0Hs9C/phQ7/6t1/FuDmU6udV/Kxm20T03VsP6moNNL3MOoUQSVx9hjY9otHU+QmHpCvr3ljsMc+BUq2YgvcPL/laHP/2q25YqomKHiUyxyKxSklnY7+dVxH1kE8MxbUVACnhBJRrFUR+nMYUOdFfV3/yARnXKYjJBvlnua08LYondovwtJjwdhiil7qC7HOc72tRLwdYgoIzj4Z2tz+kAMZ6hG8ktghi+lQYmGqC7DhaxkbvOVamqg4o5RVb7uQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkCQpR+8OLnuPwNjFUfUyTh2Ij0sWaMSrHlwn+WXaXo=;
 b=jS+Sg7zSeO+Fkwd+CDZTMm0HaXEMm817zHGJCYaigCGDjQWd7GD/yTuFdzVcUA5tNG6hhhv9KpZsjvxAlVmaa51oc/orBifgBoK4w+VAOXxgun9tJdhTceC0F7FqqIdnM9r1JgohHsOvSDyoyDIpEWqW7DuOQKPBPh1hSinY+fPgyxGXWDiefjTv+MEAfVoxekUqExQl6l3K5At7Iy3hqFGQQeZKc1Ae6NlwpqpDdXVselIM1LJQYoA4e054QFyqZfxY3QbrU3R2I8dNPmNTFsukoIetQ/vM6n64HK9fglBZqIfIt92zyEV1UU48uABzt3xf4DGrpg6q9PNk5RThYw==
Received: from DM6PR14CA0059.namprd14.prod.outlook.com (2603:10b6:5:18f::36)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 10:12:53 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::ae) by DM6PR14CA0059.outlook.office365.com
 (2603:10b6:5:18f::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Sun, 13 Aug 2023 10:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.12 via Frontend Transport; Sun, 13 Aug 2023 10:12:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 13 Aug 2023
 03:12:41 -0700
Received: from [172.27.1.102] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 13 Aug
 2023 03:12:38 -0700
Message-ID: <922f30b7-69e0-77dc-6e21-8a16d7a4979a@nvidia.com>
Date: Sun, 13 Aug 2023 13:12:33 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net v2] devlink: Delay health recover notification until
 devlink registered
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, Jiri Pirko <jiri@nvidia.com>
References: <20230809203521.1414444-1-shayd@nvidia.com>
 <20230810103300.186b42c8@kernel.org> <ZNXrr7MspgDp8QfA@nanopsycho>
 <20230811144231.0cea3205@kernel.org> <20230811151403.127c8755@kernel.org>
Content-Language: en-US
From: Shay Drory <shayd@nvidia.com>
In-Reply-To: <20230811151403.127c8755@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e25cb8-01ae-441c-03b8-08db9be5db57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LmLUOwFRKT7HPW/ZAcluO0uciBBDKBJimd5vo66vuuKRDLGpe+ocunke8ZVZNVjZVK7K/35ltrEBANMa1uoL7bK4GiGFjiy8wlGn7pn713znQKrKdlUjT9LnQOuup0jwVOOwtQC7XbNQZUR+ShO2Ah+KUndUWSCfH03u0D3jEHsz6McmOt4oCf9AsKoI8rJIbZgvC6nsZhbOAvheOT88ubjVykV0WjelBRHD4kip/bqbaxO1jD8JdM4gBFuY8DOnbckxjW0wDQyVyhm0JGMSYT5FvsD21Ft5f3fuefA9n5HVTEMY1zWJlRlougxPhFVo/+jL+zbUM5oUlVOHt33Kf4xTIrBrCUTok5SUdwwCYD6qu/pGyo/bDYAKTefdjRELmq3Aa8ChWO3EEfS0inADuh9WyXUmA1n9TYrDHnIa551sIiCp2Vlt/vWVacev6EefaqQBx5Fqm9i9OfBXUpLnh9OyrOMp0ccRLcCRYwLp+uZo0slKmErXnhRnfK3lqI53qSjqGEOJ17fwCp7ujtf23aKvyTzBouF9nwaqlVb3cOwQxNyOXeoIDBwe9R8JIohut/S/9t/X2+aDv6kZE8hkWd7Hx4d50EH2ymS9kQ1en4WaMKC1U/NZmuhrQQ8+f2vf3Ft94tq49nXi3dbZ6UNdNDtDvGttfQwKMXnZaVRB0e4yCluIjccydGw1JIlKuvoWS2syCt0MbdHjCG1iz3OT7bF9mBxyv+KNAfvS3Xzq0gH3N2o9q9tdXzv9vwWcM0pZf6h9R/XmNyEhD0V/or0Cag==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(1800799006)(451199021)(82310400008)(186006)(36840700001)(40470700004)(46966006)(83380400001)(36756003)(16526019)(53546011)(107886003)(336012)(26005)(36860700001)(426003)(2616005)(47076005)(31686004)(40480700001)(16576012)(70586007)(316002)(4326008)(15650500001)(70206006)(6666004)(31696002)(5660300002)(41300700001)(82740400003)(8676002)(8936002)(4744005)(2906002)(40460700003)(86362001)(478600001)(110136005)(54906003)(356005)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 10:12:53.1692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e25cb8-01ae-441c-03b8-08db9be5db57
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 12/08/2023 1:14, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, 11 Aug 2023 14:42:31 -0700 Jakub Kicinski wrote:
>>> Limiting the creation of health reporter only when instance is
>>> registered does not seem like a good solution to me.
>>>
>>> As with any other object, we postpone the notifications only after
>>> register is done, that sounds fine, doesn't it?
>> No, it doesn't. Registering health reporters on a semi-initialized
>> device is a major foot gun, we should not allow this unless really
>> necessary.
> FWIW I mean that the recovery may race with the init and try to access
> things which aren't set up yet. Could lead to deadlocks or crashes at
> worst and sprinkling of "if (!initialized) return;" at best.
> All the same problems we had before reload was put under the instance
> lock basically.


Ack, will work on it and send a new patch.


