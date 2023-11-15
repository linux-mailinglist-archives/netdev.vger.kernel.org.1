Return-Path: <netdev+bounces-48004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6867EC3E3
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD14F1C204DA
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151271C6B0;
	Wed, 15 Nov 2023 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sACNQd0F"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16E18636
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 13:38:32 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E82A1;
	Wed, 15 Nov 2023 05:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAgUjqgAXicER97FYG8d5JB+fwRKMrWqt+B8oI/yzqZgxkKtgrJDlpqRUQmFz3TCRt2b7+E2KquP4vv1IsPQu8X2LHXXec1OUEWJoWtVLDoAIpP7koU+5dVzcadg+k/P46tdJ4Wj3UCMNHy2NLXvi2VeWEUv2EcJPXjRyMC6+eLQQ0Fcqq6hLTc5rEf9kLV7VTi9dwaalBgb77PnlQ/7207amUyZ+1bRsx7lz5sA9Ebl5k/0Zi7wDqj+3Ffx3rIIXbRCtbAwsPanY99XInUD+cACtkjxYGH6rdbGYTNA5e2/HeCHB1Z/7usAPXFeCTyOR+bJLXa1Dg+BLlclZMXwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDlxjag/87aD/QrHHf9WZad2TsFXihDcbl7CHppPvts=;
 b=hGT/VJoZ8rxJ62Ul64MjJBh8lhoMjPF2p7axGa2xfNHlrdfsb+qwI/hNWDJFOnhVMjnk38ZWw8qm953PoqboIyzqp6SmiPUWVnOEgmuo+ZPZMteQ6n2Hnu59ihteY1R//YLXdO6QKeNQyGsDwkfricO6/HtG65BHNP5odvteJL7eOygRzLC/KC/SYFolD/yOXOYj3Voo52xg6tZqsMHBtNeiNuB8oTRtD//hyLJIiMLP2z7v2t8mrnSkylMVa2Gx6cIOypB4NseJrW/SVPKw5Nr/d6mWEA5EuiEbXwjLPqelfc8MUnbcq9sW0EKYDx/Trj1YeyJ/8MTJNa4WMvKCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDlxjag/87aD/QrHHf9WZad2TsFXihDcbl7CHppPvts=;
 b=sACNQd0FG8WwPWmhx29IJInQvcekbp6lqkHJp3iEa5uaoa7QmA66QmUmrCSxi2cURODJVWUvewEcyVTKCef6oLSq/UuXgJnYWmu5tgqbsXsRIfQxKbhAHzg2q9Lx2Lkpag+Y6eXPD2DWznPAgcqOGlLAWae/wDMWF/hB19kivC2DujirEyvF3urMvfZkqRPS0Me2ZrjSPyQbNLbNXoL48YyFFVhhfxoQQ7lgUuDrqJw6n3mVx8+/SSxW/HicoAGWucSHk3rNy2D/wbYAN7VGAUwLv89SssTXc64NIfndktv1/uXjoZH9E9dpJQULPZy8v9lH6MRQ7bFnCjf5hth6Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 13:38:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 13:38:28 +0000
Date: Wed, 15 Nov 2023 09:38:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Matthew Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Message-ID: <ZVTJ0/lm1oUDzzHe@nvidia.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
 <20231113130041.58124-4-linyunsheng@huawei.com>
 <CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
 <20231113180554.1d1c6b1a@kernel.org>
 <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
 <CAHS8izNxkqiNbTA1y+BjQPAber4Dks3zVFNYo4Bnwc=0JLustA@mail.gmail.com>
 <ZVNzS2EA4zQRwIQ7@nvidia.com>
 <ed875644-95e8-629a-4c28-bf42329efa56@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed875644-95e8-629a-4c28-bf42329efa56@huawei.com>
X-ClientProxiedBy: BLAPR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:208:32a::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a3696e-b06d-40b6-94a8-08dbe5e0267d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yq/PvE1A+j+s/u3IPHl0FVqfDuCmdnMGxqPBAEiMAuMo3ahYf+r9G/fIAAljA1LG2qPfJVbNfLXuvb2cg/tvZ/F7/fYNgRt7ACu9hBbzRPPBXnKPBoJbnA3kNSCuiqxKCN0K0Goku/2wmvc6XkbTBajk+hhGA+4QPcalK+TQ90SEqWhclewRPLWmnaz0f9HTkmSROVJk1wVSXLw7rlAFqZNQZ+zlfL38KYhgEFLzAMvPi+/vAbqVu9RueNTDQuSEfF5wNbgDrokM/v6hQV7Z3JZqnZ52suKl0nhJV5zDJ9l3+VS9T3J+5K6oXrwZybBisG5j54j1QsAr+iyUWGLRNo7Wx6PLySfvcEj953B6fB6ohvQq/JNg6v2kyX6jOHzrE3eTkuX0xEsx7sJHy1to2gPYWeWaMYB4j60BK9Z00Vf1HurqC2gOGdTrAY2hxU/up7Ro3Q47+IuSbYbWBH5MVMpPI473nraBsoOH84x9ZP7PrKVvTFcAAW+PA2HhRxRfNKNNvmcCfaQ/+XffoLpbxQ+OwscoJKoKxQ66YJinjJ0hTJOnpiLGr/TqezvD+5wz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6506007)(38100700002)(2616005)(6512007)(7416002)(4744005)(41300700001)(2906002)(5660300002)(86362001)(36756003)(8676002)(4326008)(8936002)(66476007)(66556008)(66946007)(54906003)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRZwmAGl8b4yNfwhKI4jXvnOtJ0cIcruefraNBCPVMjTjQwsbPcz9QSLROln?=
 =?us-ascii?Q?b2TRWjYo4Qt2Mqijptb7f5vo6q9mP5QqEOCgz2+9n4OhLvGKOGITWKOMOasx?=
 =?us-ascii?Q?CcEjuEzXS9BWB+uBxyIXrp16FJjTQ6d4wBrmjPCzQyRGa63ooxcY3JB5r0mG?=
 =?us-ascii?Q?FjCZMTkq3NgFSWBm6ToJwHomOLMLw5dc+T5VhSnVXrBnl94OGgaQtZrOQQE1?=
 =?us-ascii?Q?NP4WT/gl/abP9JF0iX6Sya4/zPNuXp+LDTUnl6ataSZ3Uo/+g8OU74Ii18zG?=
 =?us-ascii?Q?tJFnyC/XgxESM0TWI4/KuMsWTJjHYLq3K+D84ZmeL3ZxA4GUQcaKiGu709Ds?=
 =?us-ascii?Q?6tJrhNBb2Q842TiKMqCKvQ3KQB30s9xcJtklAIQAIvuccCV3t0W17fJQl+2j?=
 =?us-ascii?Q?/yuDs+E9HIUyr93IlZ8keGD/YBbWo1cQ9X1vlJ/2oM67ScPkdZttwUYcgVug?=
 =?us-ascii?Q?vL77Og2JIdfJf9e8ScS1FilnfNzEN67FnjLBG8Hxv8u5cLDspUWeCmKa0eyZ?=
 =?us-ascii?Q?za3mSS4A6Gf2XoA2U+o869ku3P04MKmi58z6o4LWQeJbDyTml7J12Y/+CSSZ?=
 =?us-ascii?Q?rxnL4PEWdiPUAoSgXInF4OvdLT4ePu1dgCyr1sDAS/lNu33xv0aaSG4YyARm?=
 =?us-ascii?Q?+A2HOdwfGjFD6b5ZVB+Jk6S57u1jeyKrjM4KyIAFrJ6dRQ14MB8FA+nYLpxA?=
 =?us-ascii?Q?Hm7BQHZ2DPVvQM8Vb7REhSIQ2BTzE87lIS7xoIAXicSVj5aIySruR0YC2c/5?=
 =?us-ascii?Q?WFZZIXmpxU/rJiDIIx4h0u2Yz6zeLe4mZCWjvy7vq0vwsNA5kQVMWFzEIb9a?=
 =?us-ascii?Q?NdY7+VmMp6FQ+/W6ZaNDQbL8R/uZWrq36jHBEb4Xm+KGeSKRsYXd2W3tvecl?=
 =?us-ascii?Q?KL27704XaEXIlFZU1k4BJq1FyJZ7tPr2i0TZduvSVqoqW9SEiK8W7k49yZ6C?=
 =?us-ascii?Q?nu3/Gmh1bO38H5Phu20U4yGZhTw+shDj/ZdmHGDIwXSJa5gEtgBtuftwjQJW?=
 =?us-ascii?Q?GP70ewp1EdF5d42HlaapXM5PC5EBFQ+lp69zlRqzR97jwSssbf7akuY9hp8S?=
 =?us-ascii?Q?aCeHZXb+5CDL13iUE/ntYOnKm1ASQRkGY9Uk5B6P6rqUR48/VeU5K/RW8YgY?=
 =?us-ascii?Q?/802NDa+EQcWSTJ2S5am2eO8a0Hgx2SfTwCSiBMETBx2OgvGYfwCbmHk3pyj?=
 =?us-ascii?Q?Zuip7yUxp7DclqeOG/L47B97h8lxFg7E10FTiqqMHxOHyCQCDZLZR8jpNF1t?=
 =?us-ascii?Q?uheLyzXSny+SqwnVE3d/+4BP/xazjNmugieB3wBweiM7EyeUN7prc7BVAY1Y?=
 =?us-ascii?Q?Pb9uRksNb5fQG0gTqKTRKxJisPfD2lQRH3q/jAFcYw/sb63gUoScDRLnC20c?=
 =?us-ascii?Q?umKbD/ErsNZqZAFf3KPC3JmbTpYPaxic79ULD3WHDgRQvSrxdpv/2Rum2fPV?=
 =?us-ascii?Q?gHc2QUmtmh/OoRi66n5la8m1fjJ2zcdX/3AYqpJYwYzrl/RBy90TU6fJnUcj?=
 =?us-ascii?Q?xwqcPxpqhDYV5Z5q/JguoZodkk/ZDnkaOWfIdLwF/eJEpbaumwlDaFT/XDK3?=
 =?us-ascii?Q?llwG2LeQaNAZ2Qgx9b0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a3696e-b06d-40b6-94a8-08dbe5e0267d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 13:38:28.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tmZfMTwW850R15jcNEBW85QIyc4kF1GLNLBiJnotqeNnJkdfQh8NPgOW1uSD9As
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682

On Wed, Nov 15, 2023 at 05:21:02PM +0800, Yunsheng Lin wrote:

> >>> I would expect net stack, page pool, driver still see the 'struct page',
> >>> only memory provider see the specific struct for itself, for the above,
> >>> devmem memory provider sees the 'struct page_pool_iov'.
> >>>
> >>> The reason I still expect driver to see the 'struct page' is that driver
> >>> will still need to support normal memory besides devmem.
> > 
> > I wouldn't say this approach is unreasonable, but it does have to be
> > done carefully to isolate the mm. Keeping the struct page in the API
> > is going to make this very hard.
> 
> I would expect that most of the isolation is done in page pool, as far as
> I can see:

It is the sort of thing that is important enough it should have
compiler help via types to prove that it is being done
properly. Otherwise it will be full of mistakes over time.

Jason

