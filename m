Return-Path: <netdev+bounces-12927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87C773972C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C868C1C20D23
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE44436;
	Thu, 22 Jun 2023 06:03:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31533C2A
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:03:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC4F10D
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FddTYOtliIM5uDJbUph4laLzy6AoUCTgmCCBs3Gn5PKPgq5mFROD3spzeSe3c+0SpQq6BcUokGFY+G8qIf9tjGZXc+ovZxF7W7nMo9d69O/qDolQyJoMb1bSdJDLil4pei3IycUdSaR/CDaBmRmax2x1T4LKctgL9Lx6S+PQvqfSwFalLjxd6h0gfQE8fsIhMDakMpuUrBIuj2DR0EDe/eTAcfDJM+N/MpIo4jLmjA0wL2VUYHmpk3UJuuBy1c1LPAAK8rVYtV6FXtL1TQwQqviavtK1smvFFjlzOjWue2kb/SnuaK2L2A3dhBwDYRyuy+51mhhthLyOzMvTBNI2qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zweJ4vRcMbWhBkmluE92XWlZzIoOJ4DMEoj/9HSzg5c=;
 b=EJDnK6ZzT87TkDyGUALn1rUaA049PY8Zx4Bl/TEpuU/fsDB8xkO+kmXSfjqipOB6t0akF+E3sDN4VA3w/cVyqx1rkoF1ZC4zRJIQh5xHidtlGPyb/zGwxmMAxQudcDxbvTIy4gRrY9UY398rEq+P8eBB5NhjQPIQTxp+a8l6H14O6gJitzOYTkLI/lXb7b+chfMGTEgSUfiYve0MGtoXu23eNcSlz5INPUVBsT3GRMB0qJemYkjQNjt5yzwTSt2ySaLIhEWYTRmPVbuN51IZGBBYgCB6AU77XaYgfMSZKMCGZhbXbPeXXMMUZPKzkmfl8kGEY6+iBRrHSnJEdYT8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zweJ4vRcMbWhBkmluE92XWlZzIoOJ4DMEoj/9HSzg5c=;
 b=S+poD3ablrCC3J/iWprtIrTwmiWjNM03wQAQE68PKYfKMofAtyKc+/flp6+VCvy78ujreUSJTieL8UqlNogO5QV2voPFPnBUpuTJsB/rGZ4LYQiJo7bZqxSDTgq6JeAy2RZAMooTS9lg8PqhyJ3s7O/y3KtxMW/Fm8nakZfe66c85/izctVIoTsz27/L2GT/huNPZyd9D/bjSxA2V014G/ZOfd3i/Cix64pJTnpQ7BMy0OqTiPhR1qWOG573Yj6QXDxrc78ULIxCRpKl82Z+K7KkV8htb/g5p6Kf9uN+qQuXB4kX+FOxwIjlzKw5w3OGm+njoyiQm+NZrlz4LRV+hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 06:03:21 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::66d8:40d2:14ed:7697%5]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 06:03:21 +0000
Date: Thu, 22 Jun 2023 09:03:14 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	petrm@nvidia.com
Subject: Re: [RFC PATCH net-next 1/2] devlink: Hold a reference on parent
 device
Message-ID: <ZJPkIrtKpgSMbMt4@shredder>
References: <20230619125015.1541143-1-idosch@nvidia.com>
 <20230619125015.1541143-2-idosch@nvidia.com>
 <ZJFF3gh6LNCVXPzd@nanopsycho>
 <ZJFPs8AiP+X6zdjC@shredder>
 <20230620104351.6debe7f1@kernel.org>
 <ZJKZT3LHBN3zEUd1@shredder>
 <20230621120357.7a5c4a17@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621120357.7a5c4a17@kernel.org>
X-ClientProxiedBy: VI1P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::8) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|BL0PR12MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: da41f1eb-289a-4b9a-88e9-08db72e6619a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DZTJxHOeVpiNWyLb53qCAjFXzw49R3lgvjkB+NV/qdjom2hQCby19Enz/sPQDNc5XmASAA7s2pYLymWpTue+nYO3vaLsKMiQCsL9luJ/g04fG4qWZ3k4D2TC1+Yx0zltFk2uiOkHzd54H7vDHOaYnT8eZYXn1paoGUTT7N87osFkhQFFBvSKKJ9aQ9ZGhFDbc2C1hf+pIq6OChLF9aAvUXrQOJcHtl2vukDd5FlQBAILEBO37bb+VEA3fJKcWOkZYZUj6kLVeD0V9XvViqzna4zp/YIuTZPekqbLLesWh4bisUSV9snua6YcXCBMWOBEy+KV9mc2dGkYARajl7qD7groXmb5YbWyzuhv5xXpQ+4cgJCg+hakSs2HjKd6AJDAqiAaZbbCPkc/0q7bd1DkZyN+f8y8QPGvDqUkPvIz62Ycqq9PoxzWpI/wZop5r6d2ncDg2EBIHmu0UFRiRkGhrdI+Oh5Zg641uohS3ntAffuqRJeYeI6+Hr1pTPo3+8/uhmCC5aHYZ66l8viwrSPTn6YzIW6zbbHOkPw2w5TJwfO/7frYE/jWmjTIuuAmYNOg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(5660300002)(2906002)(6506007)(6512007)(8936002)(186003)(8676002)(41300700001)(26005)(9686003)(107886003)(478600001)(38100700002)(83380400001)(6916009)(66946007)(66476007)(66556008)(4326008)(86362001)(6666004)(316002)(6486002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?38m+865AqkI8XPZdbl+JqhUp3MtUXryBVSoeraIzdXO7H+ZMCqC0ETlNcefw?=
 =?us-ascii?Q?zRikG1/cuB7/GPDnhhtyJIMTWKWkUfEOEj0ViaOB6nQQQT+69SynBCAhcQXZ?=
 =?us-ascii?Q?uzR5Se7LoWZnqSBT2v1qJp407GKCenYVmYstrBMCVDEMhMprS/riB939EEjE?=
 =?us-ascii?Q?+1U3Pr10g7rwVtjFmkuU+FT+pS1K0qVOZkPlSW2QxzkRnQ5iAXe0KX4/Tbtt?=
 =?us-ascii?Q?K6P8XYKe8sDwPOLhsCCVsZuFYFC1te3JjRq9Uxw2dccwtXmEocQGt8iQUbAI?=
 =?us-ascii?Q?ofj06TiPnABYWckTf8X/ryVooN94HhBnA5r1HGQ2C3kaaJHlAhK/4DI8OdGr?=
 =?us-ascii?Q?uGJN5dKO6z64oBGVnLLdqL17r+feWw8fWqLY+FusDAB/1kxV0RQ1JCS5PLSs?=
 =?us-ascii?Q?DGHNPOqSzwU/Aren+4S64YzxbXzhg1TI/GyJq4VaH+X0Thi3a1NRU/GaHSRP?=
 =?us-ascii?Q?+1G9LC7Jj/hBm6ygb4FnpoMx9Oh+wMsXOnoCbYopXMT/JkuAe8PYTza8tBvH?=
 =?us-ascii?Q?BpzUk0mmNCQnbTjLnrJ7cjGpPlDsIXulO26FnapnC99r0/yMiDJ09ij9RfCj?=
 =?us-ascii?Q?mRcAE5Dx1hrl2jOcpT7QHken6nCF2lIfie+gctBq3KwESA2z6BQNLBvsNspr?=
 =?us-ascii?Q?aqudIUAqh8kMRVC+O6x90EKymVyFn4aiTgZo/WsWnnKpQ2LFaVP2JSXeJ8mE?=
 =?us-ascii?Q?Mk/jGWP1U9/CvvgzcFY5kwgJJrp9eMM/MCgH2koew7h41xGWMDiYZQG05Ao5?=
 =?us-ascii?Q?gcIajUbDrXwNz8NNtN+fWsMfi5hD8Uk0uazLgIufrRd1bOhEtBqB6xXsSrnK?=
 =?us-ascii?Q?tVCpkLczcoi4Sjg1sk2m5Ba+5zxk1kEK7F6DJXJU7x9B/2QTl+Mti2ex3cgq?=
 =?us-ascii?Q?H0qEwxkFjy1rxsvOlxj71xGIp+021dkgj/cfFoxe9jKTOFSD0woEXGyVdP10?=
 =?us-ascii?Q?4RA1StMyrQxMapKMKNq7tvALBNIyrijZniZCVJiTs2ZX+HY9ihKo15VVC6yA?=
 =?us-ascii?Q?2PBq/Snok0D3StqCURLNtqD/Aupt62vNk2oW7fZlNsP3WC+dZ18e5qADbuNa?=
 =?us-ascii?Q?cet5hh8m/aGPSzZ4Tmlkw76AaPdAiZ7TdENNnNgHzWgcEIPxRmLPoEIWxx3v?=
 =?us-ascii?Q?IBo0MedlfNbThcFClOcIHYnu4IaFedpWgjDiJ+CmxAOHnUHYtOZZdXakCj6P?=
 =?us-ascii?Q?cR69ZRbgRjKxCC1Qou4k0FTCxW+rLsxBgAQO0rbFIeSMnZx5A4nTD4ATiGng?=
 =?us-ascii?Q?L4ODZ36rTvxbb88soW6uSYYchhz3EYHlIaM8oGRDp6U7HQ7N6RnbNq+4oxKz?=
 =?us-ascii?Q?bTWAuPgmNDvrcPgbIxGxeQA29UKlRjQ4dsxDWeoSnGiUkZBlZA2qrBzdbuRY?=
 =?us-ascii?Q?nYq444bJgz7wf7esWe8wPsjrOqEfB0OvigJRbO/vGCZUSdwlhLcZLtojl8NI?=
 =?us-ascii?Q?GkiyOhkUYVCwRsrRPEAXCBG6d0sXIqJ1cpenW6ZkfftCd7gN7FRoK8Gl4UQT?=
 =?us-ascii?Q?PfLSQwP40rAx/XYDaIGbzh1bV5Ai+Y1qxXNIR5wsl8EyGFQZ57r4DfkCYzEN?=
 =?us-ascii?Q?XWUNyuIz5PoABFE1/N7rUwITw9I5YG1P8o3L6XtX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da41f1eb-289a-4b9a-88e9-08db72e6619a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 06:03:21.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBwhjrfoYSQR3Tzu91JXDpo2Xy50NRnOogTKPxTCfYT7hgdrKgBgp4dH3WUF0W5NnN8ojUPbROa38XPTapu4jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 12:03:57PM -0700, Jakub Kicinski wrote:
> Let's try to fix it at the netdevsim level then?

I think it's a good direction. I couldn't find a way to fix it in
devlink and the problem does seem specific to netdevsim.

> AFAIU we only need the bus to remain loaded for nsim_bus_dev_release
> to exist?

That's my understanding as well.

> What if we split netdevsim into two modules, put the bus stuff in a
> new module called netdevsim_bus, and leave the rest (driver) in just
> netdevsim. That way we can take a ref on netdevsim_bus until all
> devices are gone, and still load / unload netdevsim. With unload
> resulting in all devices getting auto-deleted.
> 
> I haven't looked in detail so maybe you'll immediately tell me it won't
> work, but I'm guessing this is how "real" buses work avoid the problem?

At least with PCI (which I believe is the bus backing most devlink
users), the release callback is builtin - not part of a module - so this
problem can't happen there.

Anyway, I will explore this direction.

Thanks!

