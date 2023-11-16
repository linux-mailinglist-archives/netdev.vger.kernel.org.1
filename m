Return-Path: <netdev+bounces-48474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD277EE7B6
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 20:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F77AB20A61
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 19:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F65495F2;
	Thu, 16 Nov 2023 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8d7FksS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62B2196
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 11:51:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMYbCJsOgDD7Ktvd7jGU0+GOf2l0MkPcqu6/IIkL2HwX0bWdrrtjFyVobLHqPNMyuIoX2QieJo99n7YpLvpchCDxeM72TOvCQXZT0lf2arNw2vBldqYyvitaPPghi/hqVb2LRaFuEUxs7Lzk47NtugJCzlJrICr148YhbtkNjYyomGOwCs6sUn0RLoJKNleWYbX2kdqhCg2ZpnsSa5mQA0BMybsxOiX1rC9QkloiYoDMTpAppfWfXgFH+byukUBBs+wPkzUiSns6ebp4+eDwBVRIK68QJd5ySCGWdkzukf1PS3MSShojBKEqqjuVXhq027lOzG6+1QhPK+gsRpU15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2Ew881jJc1ioN5Jtmwk2Pdq3Tqc6vxpuRirUw9iZAo=;
 b=keaxQHbw7W/u5E1uH+Hgsy4O6Kxz6v7xyiXp8V0Ut4hX1QPGxFA22Mzel2qF7oHDZsIteczXONw5uF2eZM6yfSaQROZ14/OZJZfzMAJW4bI4qFrd5UXQHp7PVlXKtjRJu+LYng7UUZcYoMQANsD4lTkc8cDA5NPp8ooXxrdc3Xz38I/bNauSWu6FvQEZQekRqPOcklwsj1PFFyFy8Q17qM3j95Za4ETfM2u7rG+2OYQa4qVdjGDSM2riFjbAPxVEQwCPf/pbi4sQzxWR1ORMcAzmM3g4uJOcaM9KZfz2JU4nhjQH1nJhfxfjw+gyHHA3LXBLIYl2JOfnh6pj6M4fXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2Ew881jJc1ioN5Jtmwk2Pdq3Tqc6vxpuRirUw9iZAo=;
 b=I8d7FksSXou6K52JBGolhsrH30FOrE+Ab99C77mOIdGfOZfD1CVI/P4PE7fYc9kau3PKnilb68IeMGI3Eqo/zWFLkovWLA7ofdxzhfL1voNthGqnfZvdaMErBpHZnqPqiHPtcQ5X9CECMCB44Gve2UwKJsLMFYFnTUmbMPnnb62u61Jpb54JymV+iZy9P6cPeMGWHbe38lHypNSz5GjmTb3xcynic0igcInv4lVXNFTGAzm32KRlDmmalXZztQt1C7jOSH6yAOhZDDaOkvReix5fBFTC2aSPsNgy5GiSShE6rjv3hquqcbfhuVhlhlE7dv93nn9viTY47nLpljg3/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 19:51:49 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 19:51:48 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Saeed Mahameed <saeed@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>,  netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>
Subject: Re: [net-next 08/14] net/mlx5e: Introduce lost_cqe statistic
 counter for PTP Tx port timestamping CQ
References: <20231113230051.58229-1-saeed@kernel.org>
	<20231113230051.58229-9-saeed@kernel.org>
	<b6f7e7b9-163b-4c84-ad64-53bb147e8684@linux.dev>
Date: Thu, 16 Nov 2023 11:51:39 -0800
In-Reply-To: <b6f7e7b9-163b-4c84-ad64-53bb147e8684@linux.dev> (Vadim
	Fedorenko's message of "Tue, 14 Nov 2023 10:22:43 -0500")
Message-ID: <87bkbtpjck.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37)
 To BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a77d6b6-ad22-4f20-8469-08dbe6dd7882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BuHr0eN4NYAhcANebTUZUFIWjYS9aJHE4Cv3rogryf6bhnjBQjKPWJuzmDK2r4Lv3Rvx8/yqnSXpg9YP/8v77Tq29Cq776rPAB453q5VVNqHQvhcztWLAd1vzjXHv7EKoqZW2a/YI38k5hcsim6dDHvFX4gFgBgBE81UIBLstQidHgBPL5WUJUkiDSsGpkwgdFU72Z+Uml+BXzeTcTTczMddhSbHRHVK/lNjGUF0drxYJ0rG0No774NJvsnjrVcydhaYvXqKICpmjN8IvoXw/oVnnJDQD++UROj9C5G9lAd7zoN7GYyh0PAmcXixgx/ymzuWR96M/8i52Hq6/XF7hBqbIi8yMyGRy2Tm3qxlNIFWCZerS4F00bvJDDNZpEuOHdHPJyFVoSxlYl5DYUFmn5a43k6GQBxdxRu2UYlBBXK5a7/n92eiWGKsDZgDCP1jNYAaBakYQjzXt0Oz4V2RPU2047Blj5Ec6UHIZGbxUw9bdouU01+5XuZRMOVK6v9c8tlFs5Ljg7r7acmHkcoyx36PWGKzOOwvApz9SLYWmppqHtJItDSBIF1WlKielF42
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38100700002)(36756003)(26005)(6512007)(107886003)(2616005)(6506007)(53546011)(6666004)(6486002)(478600001)(86362001)(5660300002)(41300700001)(66556008)(66946007)(66476007)(54906003)(316002)(6916009)(4326008)(8936002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TcG7p/S28exSMWlSDrdcoYYrZeWGfp+10NfzM0I6Il+rnW/6Y60QhMXDqCsU?=
 =?us-ascii?Q?1Ai+wavIDSekfWJlqR0TyKfIeDaf3FO4GOMgxcfY8wffR/7nS+knCzvHFOeK?=
 =?us-ascii?Q?Hu17x7Mhe3qAmiK5quyhbhfjLyUYKunqouLkhypNdrM+pCMIHE0ZIlOoXjVl?=
 =?us-ascii?Q?XjCflTlT3DLk6SxY9yyjjAj/s8RwCeDWeIo8IZWm10Wtkt1xlp+udgGukxuA?=
 =?us-ascii?Q?hxTdkM9uGIqrP6K82gcwKLjcPcmDAWf84Rg2JitieVVAsIBTea0y8gK9PdZl?=
 =?us-ascii?Q?qJh7/SwB+6U5DV2zW8SxSJfucVTwT+bWe5HjdtgUpuOJXwiFZRfEowiJiiYN?=
 =?us-ascii?Q?4YKG8qleIlYbOl3VhywoIyz7QS5IlO0BmZXfwmusavQChN93pGrLyhzZT3xM?=
 =?us-ascii?Q?6jPbkzz+oC28rU/DtPH5SFgs1uQIkzYKlrHxDBDn7jGuxlYmYXENSP34nKg8?=
 =?us-ascii?Q?pIezSBaYCSwvMEbR2nxkZzw9YNr33BUzJYslvfvpgozyrb38Ag0MGXJG/Ye7?=
 =?us-ascii?Q?O4c+ezgGzxsnbQdD68hP2RwpWxlS3wo45YgVLHycQwghNhQsLz4D2l2jbWBD?=
 =?us-ascii?Q?G8xHXsbj4xcdUQJXu8oVTKfEmOX547CaLHVZkXEOeLVZvZ12L6E+bsgSnOUT?=
 =?us-ascii?Q?R5MvVvU1CR0mQVD4mauTwyO9UkuIp/1a9hKt9Cmoo/GXM6Mv531cicQWXRQV?=
 =?us-ascii?Q?QnPeWJ5KNo4CGyYzuK74g+ufL53ejxWPxqZ2ont35jih4dAwHz2dd1bQnJhE?=
 =?us-ascii?Q?8Rp/47niEd+r3WixlRG1KtBnb5uqUeofbiRwuF5LTip+mMxo9VnxK5QGTc7h?=
 =?us-ascii?Q?UqqgIA+46mW3Od1XGVDlBqv0ztcDJONd6y5ksfGd0Q6L6bLI1vbIq6Dtusfz?=
 =?us-ascii?Q?cADpyproNrtN02awwW/5btVgdnTh1tym/ALkQOx2u+EhFuB+YN3pTFczxt7i?=
 =?us-ascii?Q?AoQPoAsZOlkTHNxrIriKBpcxlqx66mdt4aTg92R0g0LDs1RBxU0gvuqN+Jyb?=
 =?us-ascii?Q?sjyhc5vZc/CoZkT4Dkyg/OCLvhR0Tn3yEODrAkczYwDzunlAp0ZtaVezA1UV?=
 =?us-ascii?Q?Z0fnBHj/anFkn6JDSE0hA9q4pc2i3BgRQwrkB9OuruaYHmxB492lG0aNIMM8?=
 =?us-ascii?Q?jDDUK+Vwh0YSFtEEmoZDEm3/lLuXT+ApCtVkNgmW2toOYVoIbCRjCdCzHVuc?=
 =?us-ascii?Q?P1r4Nsd/DVSdOVqWbdViC1AA/xwkSOIOrl3C6/UO6pex5Xdq+rq45c+ikRXm?=
 =?us-ascii?Q?ctsDLEJU0pE/U54cnipCWabJtqJwCq9502S/IPGSRsbqyEZDEcp7iPOONnwt?=
 =?us-ascii?Q?V4ynZvQXKTpPn5cwsDcJ4IQuPijStK4dZ3Dcypz9Q9uvhWfgn+D7jmucpkW3?=
 =?us-ascii?Q?KKV182UXgEgG39fYbo95wUtadrqLyLMx6GW6bo1xWsFlK/Q4+wEEF8oAqfRp?=
 =?us-ascii?Q?fv5KWQmNJsUIF8CzDzIeNJ3MdASlxWuWN0prUrfmO0uc30qtCy0eaehIu3nF?=
 =?us-ascii?Q?NMX0baTVt8kOLtQubIEP022GLN4xqAYybodxkKlntcE8VUQ/NXYkj1g8Lyn0?=
 =?us-ascii?Q?Zjvnn7rcHvMBAotiKnCWWYgFlbe85YjquE0B+8HF2GuWmb+4XN/3NRaeC4u/?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a77d6b6-ad22-4f20-8469-08dbe6dd7882
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 19:51:48.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjNLDMlaN2K0mvAkeYM6gbPDSSpUVtsEAEV1zaykI8pU6rALyXXzaV4IlNOyzbbAq4FB+lkbto0vb9k3ulIGkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

On Tue, 14 Nov, 2023 10:22:43 -0500 Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> On 13/11/2023 15:00, Saeed Mahameed wrote:
>> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> Track the number of times the a CQE was expected to not be delivered on PTP
>> Tx port timestamping CQ. A CQE is expected to not be delivered of a certain
>> amount of time passes since the corresponding CQE containing the DMA
>> timestamp information has arrived. Increment the late_cqe counter when such
>> a CQE does manage to be delivered to the CQ.
>> 
>
> It looks like missed/late timestamps is common problem for NICs. What do
> you think about creating common counters in ethtool to have general
> interface to provide timestamps counters? It may simplify things a lot.

Hi Vadim,

I just took a look at the tree and believe devices supported by the
following drivers have missed/late timestamps.

  - mlx5
  - i40e
  - ice
  - stmicro

The above is from a very precursory grep through the netdev tree and
maybe inaccurate/incomplete.

You probably saw that Saeed already pulled out our vendor specific stat
counters from his v2 submission. Lets discuss the more appropriate
common counters in ethtool.

Similar to fec-stat in Documentation/netlink/specs/ethtool.yaml, should
we make a new statistics group for these timestamp related counters
(timestamp-stat) as follows?

  1. Implement an ethtool_timestamp_stats struct in ethtool.h
  2. Add the relevant callback support in ethtool
  3. Add the correct spec changes in the ynl spec.
  4. Implement the callback in the appropriate drivers
  5. Separately prepare relevant userspace changes for ethtool.

If this seems reasonable, I can start preparing an RFC to send out to
the mailing list.

--
Thanks,

Rahul Rameshbabu

