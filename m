Return-Path: <netdev+bounces-21877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F366D765218
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE1E28225C
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB10154A9;
	Thu, 27 Jul 2023 11:18:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859014A97
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 11:18:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2130.outbound.protection.outlook.com [40.107.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFAC110
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 04:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWFWBAaVHytUkKKvFZrFMEfhOR1DAFJIGk8Zr0qROCOVqjUNZvuAaVm5G18PyOGuZn4pvobzw+mOcA6MVt50l6GLpb1ePxFec8f8odFvOd1zVqa6YaHwEImLUXfPbMh0sAPCuRy3xNvWxwpBKenzUOsi2J1cN8nQoqt+ckxdueHw1AkDKCpiV0qTQkW2UmILYFuceLgxb1ppP5tyoVlDy6Z+TcpjqGNnvyENzGugPP1vUdfd6mVRza8wkFhrUbxcLD2dariTB+e6DNShC8WBIUKCIVlYvuo76tfYhsJA7vqk1WbXd6BEu5lewFVh8JFqHYH1wN3lVRA3U7JoaD4w3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YAMgg9vn7Y9L56yVJuIDw+G9XVlbZzqULsRBDBlvQ4=;
 b=Ad5xNMKNiQ8MJY1cl0SvlhEu4pLBrpLEorRX3KgqfWbPST45YaMqdqOJGrXqk0hLp+3q0el7dl2UeGzNirW2QVgzXQLKmG8+qDNfl9enJAwn4IdqAil3jfNme9OMhaC3m9xhH4uhMJLpAz0CkpZMkvOs1QJQ0k94JOX8J/XKckaDzXREfhdL0PBsv9WaXvIXkNssFuSam3f7U3vE5sjRNhfLD6hyFPDMFwwHr2bXXdLu7vbbMEJqYP85V5e9BTi2Md9w0ub8sFIyZwE0IfFKv4Gi073gHirDCBk7rEW+u6Acdrhc3e8Vn1e8i4bDu5aCkvmHRtI74SpkTqjos8cwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YAMgg9vn7Y9L56yVJuIDw+G9XVlbZzqULsRBDBlvQ4=;
 b=mfFeQYGtoEwwzVlz8uA77+pZm1KBN+xfdqD8QjxKrw6f9E8qtrzIvXqpCsNP62uRi0rNPoYBL4Ljg7qnY65kWEMl340LFnRKr6SqRqgDBvgHUeB/WH5raZ28WGQPp26eC5MoBINtCSaoZL2La6QFosjGMC96V3AXtpL5AnS7Q8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO6PR13MB6047.namprd13.prod.outlook.com (2603:10b6:303:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 11:18:11 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 11:18:11 +0000
Date: Thu, 27 Jul 2023 13:18:04 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Beniamino Galvani <bgalvani@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCHv4 net-next] IPv6: add extack info for IPv6 address
 add/delete
Message-ID: <ZMJSbIgDP3j1siMO@corigine.com>
References: <20230726023905.555509-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726023905.555509-1-liuhangbin@gmail.com>
X-ClientProxiedBy: AM0PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:208::33)
 To PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO6PR13MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bb7257-634b-4bfe-a82d-08db8e9328c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2zUifxeDB0nyhi0RnFnlTqbAGVlhJDshl8HeftwnLJpgW6hM//1JqIAvJvGpg04KTGzi7InxxspDCAvcuzHAMV1u1KlIvzSaCDwRugljd1sfqfv7ERLjwGP69lEB+IHuovhV3GxwdPKSNT+jUDAsfWK4eErQOb7oCr8ruOopVZmV9gPy7SHzSqIF9f54UIWF9U+UNjHSMvHnyvmPiN9dkTa77VUG/siqgwNHojHe4tagzrAaHVDVh5p8tAuTmLwlKDSIc+xlBPe+KsOShjOI4pDiYzn0KBDdTIjXztvu8gUlCl6SP8SNZmsts2PfaOMJVeR6JGrWnRvLZhZnwT2AcN7CB7jFsd7C8unN2XyztvUGab2nauzugf9dc9I7fzqjiTKwWjpII7ArzwL3mo0z2V5+5BDh+wU8lLLaw8SjtpmfKK5cCleUWs5GCn4uinAo5eCaDuroIVeoHGuxMkpmHGX3T3pp05zZrRaSQcXinvsnhELwarm6XNLtqUtY9kfnmVA6HO/PwV0TNozZymuGZjxkvJio6qH9vbQufj6nVDpPAmaPdys9arqhoiBzC5tG0AukO7pOVc+ErortK2MKhH1KPvzof0lHx6kqE0LJS2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39830400003)(396003)(376002)(451199021)(4744005)(2906002)(316002)(41300700001)(44832011)(7416002)(8676002)(8936002)(5660300002)(36756003)(86362001)(6512007)(6506007)(478600001)(6666004)(6486002)(83380400001)(186003)(2616005)(38100700002)(4326008)(6916009)(66476007)(66556008)(66946007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OrPVJhwMeqpsr5Nro5GaE2hItWOaOScc/zb/FwrKJqa99Kd78U4iilu1Uoro?=
 =?us-ascii?Q?rHig9Dkjj4JunIpN2DqrkCITeGQaNbWeR8r8S5j3tzBCUijnPBcbToMDNfUn?=
 =?us-ascii?Q?B4G0XrAcvgwMY7BhQGtIjZMhgDdSQgJng0u3x4cnxgArN5akEU6zXK4aZpPo?=
 =?us-ascii?Q?Kb4QS75OnXqXUgMhg+uYJPxsnFkkeUaF4Lytsry16EkQheK8LmEBAvdmU2P2?=
 =?us-ascii?Q?8QBjqrRCDZ4uSQqY6OuEP+PrlAkLUPlROad73pcdUrKvUaFXXB627A9bEcUC?=
 =?us-ascii?Q?2cDkZyY2c3lOpjbYdhNoIXJc8oWLZr7+c3hg+Co8ejPrJ1DhP8HfvTAUgrju?=
 =?us-ascii?Q?5/S6VsXYRpgBvlPeXZJANQmlrUY15KzY772nDbzUmL43hLER1+8RYl4B6/E6?=
 =?us-ascii?Q?dggPYj2hUoUTbYnF/1fWvoM0KIKY1HBUMwiiIPneHJgEF5jiX15uvE24TsXM?=
 =?us-ascii?Q?uiMfNUD0hGsdoIlzG9pTxQa4WJkXSu7748XTeeJAYH1HDJUlMLA8hRgyHDIw?=
 =?us-ascii?Q?XWRCiTJ5DFOFXQcBrc398Vt8oFusVJHyCfF4Sblv1KUgSCHaPN6A72ukO7XM?=
 =?us-ascii?Q?2PzVtgPLz5NszBkCxbn1oCUGlgZD1HZwRVpua+N3fOGo+5w7Rcc70jxnEHRp?=
 =?us-ascii?Q?zQ2rDpxPy9MLcq3FH24Ug7Op1Lh+6uMd7hMZ3IPwFtqMm6t/18r+KiCB+NvO?=
 =?us-ascii?Q?LRthv+Q71YOHvqZwegiprznJ6OksNaHc5Lp2+flvcj4F67ZdTDmEgN1qMNuO?=
 =?us-ascii?Q?M8WI8VELLL6v7MjzNvtza7I2JfDGQPoHz1/0j4cclZbDBfR5KnWdvGrUwmAP?=
 =?us-ascii?Q?DDf4HrrgWy8wu46H6GPigVCbweYoG+GvkYOvnwnr9aiE31SdB7OZ3qaW9+3s?=
 =?us-ascii?Q?+RZILezyo6cAamNorB7G+tTHKIyBy6O1oaGf0GtNjmJdK94I4VVgiegbfl9u?=
 =?us-ascii?Q?0M3vEndmQmzchVxC53k93wLxqnoZydDYmaT2OSwp2RE/8iG9zdgOOa5852KV?=
 =?us-ascii?Q?9ZSxdWaqsug9ybgdLTMeKMZQJyL4bvSN8YZO6Adx5d3K+updiJlveb1hr1yf?=
 =?us-ascii?Q?FEZ+kpnafz6MV1chSHFbz9QpWexmdtZZzsQ/c9W8W+3tWwOWwuvvbdcS4WwF?=
 =?us-ascii?Q?2ZU2ovmpjehP3OH2/hsnorgITLHECRVUAhaONua5HiIZy83zXyO5+cXDmSkM?=
 =?us-ascii?Q?za9nC2ikR3xiIRPyO80AuORGWvx65oISXvT6SsIsT6aa6vHCq+N8rFNRPc8z?=
 =?us-ascii?Q?LIYk7Oeqa3d76yoclhtRv2BA0sGoEcA5uztNsQh6ToHyi14Zh39YURRZuFTa?=
 =?us-ascii?Q?G1DKqXi4FZ/jRE+nJxbtyi0aU5reAxpaAOjCc3ZY3R6PiQLjN8+jVrJsndmr?=
 =?us-ascii?Q?V0GVcWmk7qhnUfRng2QCQvjXzl0Ej3q9Q63WB29MibNXxGMc0P62dSeD61hM?=
 =?us-ascii?Q?fUAM8OcQ/Pcj+2VYkGYwAL19gKnV/R62zYNpTzkfSosbtt0/9SUrMLjxHSih?=
 =?us-ascii?Q?5beOW35iwLHUpkAbtYH+rFWjNaPep5TI/JLV74kDGNbRy9HZYc2Q83MgYoIi?=
 =?us-ascii?Q?5GbkO9FBBsNczQlSM0fQ2SechWm60oLriyDsA1Zm6ZuwGLGuLAmUfYvkAn7V?=
 =?us-ascii?Q?ZdbBOiv6W2MM8ACrhSK+TjvCp1JK6GD6VPeDlTTW0wFWVmqbOK4kQo1gaOUn?=
 =?us-ascii?Q?/zSaeQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bb7257-634b-4bfe-a82d-08db8e9328c9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:18:10.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwOab/mW6zdLqCuWmfTxbvcnM4MrGjkWh8DdVuQunwqPJeoCJ3pwB5X+8IvhaBcQ2xtTK8aNu86wHlJ2Ukzx8MymuN3BV+A0/s1UYUKby6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB6047
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 10:39:05AM +0800, Hangbin Liu wrote:
> Add extack info for IPv6 address add/delete, which would be useful for
> users to understand the problem without having to read kernel code.
> 
> Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

