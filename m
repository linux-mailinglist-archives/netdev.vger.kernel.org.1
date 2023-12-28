Return-Path: <netdev+bounces-60517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1563E81FB36
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 21:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCD3284E3C
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 20:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2DC8E0;
	Thu, 28 Dec 2023 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TP37ypxy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DDC10781
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liJCIxDIagTsAMgU/XuJ+7p8VuuJOb8TXe2b2AOjDHuX/YiFr5Ewslp9oeRlAwTsPnEoS0vL+glBGkpuhX3OSH1Qspv66Pb9GIn8Cp19RwwzNtgLgcSyWkzzpY+IRAWHTTDmIqJfMqpTFgP/qCXKRboLl6PM4HGTLf5wLyI9EbrZM56LbjOsELdjv6chulDOqjl4Z7UCaHF7oPxz/zulSXYq8jcuOLFeY7/GiC0u9K7KD5Kt06SEthLRA5i4LIHRsFzGLJNwmcl6lFswN4tthqFw9Q8+TrvRfWMDDj2TZgpUJQiVFWZUVAnnyTuYCi1o7Fwjui+rCZJUGfzBblYXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW4m2rwI6K8tWvC8DpOs56htOMH9Pzo2p5zFe3wGcIw=;
 b=D70PSK9rl/Ato9JqKkmJc6cNGObJ4Glm7dScdRWy+/uSt/gV1QyMhRdGAAl3SCGSN9Y3UD94WsOGe7Zw2DG2uzD+bLtjbgClEciShh7Kug16YGAtOJtaKP+2KlZU6R1WVsLHVdAQqHbTP66n4YbZNUzV3S+XtaAhMf/JnILkGcie9hbLxQqMrwn1LQihClo9X7VSj/GdeigqfpueBqM9VYBuEtf+3CGG0dUgf1tw2JXkfVWI1dBO8+G/p0Z9804/Zor3C+3NKC/9fmVe1gHBImlO5ND5BCujKpiUlsMyKH0xso3Y7FdB/KaQgcc7KstAhaAEsv2iiN5AhovlbO+kJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW4m2rwI6K8tWvC8DpOs56htOMH9Pzo2p5zFe3wGcIw=;
 b=TP37ypxyd68pcId5G2JzK7ByDJzVPpjUH7njBd2K8NZwJ7+nceS5Jq7O3B930vJBmN+Ct0JoIiy8AGHsYxJF/VVBVrnjTxs1bOKVAumA/vW1Dvzd5h64p8cdUYJxuMC/1Cjte9Uy5xGBMyqX/4TCZNUdrxORhv0mWQg/gGJHo4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB9046.eurprd04.prod.outlook.com (2603:10a6:20b:441::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 20:33:47 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 20:33:46 +0000
Date: Thu, 28 Dec 2023 22:33:43 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Subject: Re: [RFC PATCH net-next 10/10] selftests: dsa: Replace symlinks by
 wrapper script
Message-ID: <20231228203343.qrrja6zxpl6ncrx2@skbuf>
References: <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-1-bpoirier@nvidia.com>
 <20231222135836.992841-11-bpoirier@nvidia.com>
 <20231222135836.992841-11-bpoirier@nvidia.com>
 <20231227201129.rvux4i5pklo5v5ie@skbuf>
 <ZY3OWvnuzk59TU2K@d3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZY3OWvnuzk59TU2K@d3>
X-ClientProxiedBy: FR3P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4f24ef-2f91-430b-fa12-08dc07e44aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8lip0aexHj9N+xoT5Pp/2Ns89+/uj+qHxaXg4dqKM4EdR9YH4tFK069p2sw11UUTpJJyubkgfXxt+kg6TbfsEkvdt9o5LPiBD0CaMyH4ZRlUEpsRcMi4QK5YdToQVB3zrOKWIiX+dchava/itiyu/8SoFvAgzrolUvdrvJYa1+iu1OOsnIdlNutgaC6eFTwAO5ESZN8rEX10pkI/KM0dThqq1vaIiBApC97cccYpPSoNiZfChg3nHjMrYJJqpJ0Gq6tciYiZtVeJMOGRWAFR9vasCwBsixhJ5qdlz8weuGctHYjfeBl4XxbZgzWgAfVIW+z8KBtpuxMt3rs1bvH4oLOo9pmUmnsBsKK1nDCLKjcteqnxCHwGFhbRNdGTlHY3ax3gutbG4XMOCRB2k93yTw3YmFvBdNZdLYkr6JYKIAkDpLLVEF3nk6zcnuQUVv4mPR1iYP80a9cfLtzNhpN7CgNlfBdsH4c7u6SvM1qV+kdxi7Q3BW3Htnx/azQXkA4GxvNljUPFj36o7CugyHG9eS9/yTudDpqbaRKmI9h7Y+o4mQGigefwljphe+ehFAUV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(1076003)(478600001)(44832011)(5660300002)(8676002)(8936002)(4326008)(4001150100001)(2906002)(6486002)(26005)(66946007)(54906003)(66556008)(66476007)(9686003)(6666004)(6916009)(316002)(6512007)(53546011)(6506007)(86362001)(41300700001)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/hpIoRBBpsjMNXGF68pR3+/ebb7t8UaLHsWnAMKNSAV/8BkgwwnJRzEH5RJ?=
 =?us-ascii?Q?5oJQiptGQJv7x0gllDEadWTSNSUis7Y+yN2DJy1YpkX8J/pb7dfHUSlxLUty?=
 =?us-ascii?Q?6Ft75IkrWFsNJz6RCoWxx2+yy0u4QHM7hUP9eiA0bzWvA3xu5nuLZqeVr9cz?=
 =?us-ascii?Q?POMjGFVHUp98eaZ0fn08ddbkxF2LAR9AZiL4JLZqMkd0oCS++qjjUT/SywUK?=
 =?us-ascii?Q?0H9dTYQVTdZUjRCSXT1CreILLOm/MRzXpxuIhMTqUisZUK+xIVploSSAXVYV?=
 =?us-ascii?Q?xZTofXC6b4GM3UcZEGIY+UQMuvcXlXjhuzGfEAtvo17vKwqezT6RRv9Q1T6v?=
 =?us-ascii?Q?mBOlKDPda6WPpnJPK86ZONCRXaXe9bEW3+3MfjNisd+dVIDPW1qi34F44TNq?=
 =?us-ascii?Q?ksGCOZcBNkY9L+DWtf4G3yxioBEt/r2SveuZ8M9v0ySkWDjE7dOktKrgu9SW?=
 =?us-ascii?Q?gJaIEdsn0vpmd7XCwgGO843ecqlQg5q8K/BxneGVcbNgUJ2r9lJhPxI+McxA?=
 =?us-ascii?Q?sZ31TxxZXaug0qEP7jYuFjTgcKAJnc0Q0AikeXuIoZN6GcF2JaMvysQW0GgC?=
 =?us-ascii?Q?D0G1l2bZu7tk2+0DN0jLQZjs1UxFM0GXVy38sCIaYKqq4oGX4VjhiLQW78Gp?=
 =?us-ascii?Q?wPuU4weGZjWT+z5u2ewAIoCcbE2Vi4uyofH9leDd0I9yFcrk6EYl9YUM0DxT?=
 =?us-ascii?Q?ASl8pjwDtQOp1a7uSbKdqIyVuj+9wIF9sXBDr0ovSb2xXikBbHFKg7R+Qw3F?=
 =?us-ascii?Q?UDKHIWm7NfssVSNm1eDEKPPAHlvtOFYEN+xK5fHFY+w1cshy3Y1nfXYzzdCO?=
 =?us-ascii?Q?TN1YM0It5CLSkVvFV04LvIKTD50/TLhMQJTtde349Bkwr1l3vUSxt2wFl4Em?=
 =?us-ascii?Q?l+IxnZ0D4mLZTtmtxIe5UZb0inCZcKOw4SmRqyFV0rnJsQSpDEqPwQ1g1VUn?=
 =?us-ascii?Q?daaoDhThBItPoJnK7f3eu+wvHbBYEzC+HSG1oKjJfGeqipLtA6JI9LabMx53?=
 =?us-ascii?Q?7QWXd5/F+aUt6vB2ujKWsGeU4rXA+/kCthww8TB/EAMWgwv8aXLz1D7UneUl?=
 =?us-ascii?Q?5rYyPvBHc4K1FKjUwsBVmf8UYuRbO7hqKO/bStXkxT+lASyKZ9PW6NJOlE9B?=
 =?us-ascii?Q?0S2Kg3y+jfQSATTk5469veAkeiBLjiKon2zxS7VOnkrAtEcqdB2zMyGKz7xK?=
 =?us-ascii?Q?3MciYe28JM9BUOzzAJ1USYedw1pi/ZNxRbAKsxJ1tz88rcOyoVGUgRWkqiU9?=
 =?us-ascii?Q?+l2LUUDbFue0INmeTrypkb998iSxyzyw4mxGPGMzYvCVIVw9kNOcm+JVKWJ0?=
 =?us-ascii?Q?CiVsJinQVZ5zSxWRhwjPJZm9QwB8KasDGb66P9arDiVOSxKDnx7iSCaEJ10O?=
 =?us-ascii?Q?I75BTXI3ZlSva0fAnWKQCD5FVRLU36okM0eOSNvR2WXI6sYHudGcVRHuJcD6?=
 =?us-ascii?Q?Flphs/RG+hmbe4UGpuJKV6L5G5kj9Vw5PBBOg+iffQwJoEJruRNF1Hu0q+P4?=
 =?us-ascii?Q?KTFJXJ2BZkIR+H5ckyI2TnGbobcBDf7DdV91S2jhjB58RWWJh4jbyKBrINbD?=
 =?us-ascii?Q?hY3CpWXKDsU3tpNFyq2EyHAm8mrLq8pz7aD66KwG55kYYcCohTy6BNfcgwMQ?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f24ef-2f91-430b-fa12-08dc07e44aa7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 20:33:46.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDq0vpEYzrKtPc4XVojtstVEInszEQHLtVRE4R9HUNvxVzSnoSbOt7nO3otopTVE1eSczecx4taL7Dnr1jJRCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9046

On Thu, Dec 28, 2023 at 02:36:58PM -0500, Benjamin Poirier wrote:
> On 2023-12-27 22:11 +0200, Vladimir Oltean wrote:
> > On Fri, Dec 22, 2023 at 08:58:36AM -0500, Benjamin Poirier wrote:
> > > diff --git a/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
> > > new file mode 100755
> > > index 000000000000..4106c0a102ea
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/drivers/net/dsa/run_net_forwarding_test.sh
> > > @@ -0,0 +1,9 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +libdir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
> > > +testname=$(basename "${BASH_SOURCE[0]}")
> > > +
> > > +source "$libdir"/forwarding.config
> > > +cd "$libdir"/../../../net/forwarding/ || exit 1
> > > +source "./$testname" "$@"
> > 
> > Thanks for working on this. I don't dislike the solution. Just one
> > question.  Can "run_net_forwarding_test.sh" be one day moved from
> > tools/testing/selftests/drivers/net/dsa/ without duplicating it,
> > should anyone else need the same setup?
> 
> Yes, it's possible. I didn't think about it before but I tested the
> approach below. It applies over the changes I just sent in my previous
> mail about patch 5.
> 
> Thank you for your review and suggestions.

Thanks. I tested it too and it works.

