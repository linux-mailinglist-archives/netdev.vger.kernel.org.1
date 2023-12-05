Return-Path: <netdev+bounces-53956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A580565B
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A51C281AFA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884765DF1A;
	Tue,  5 Dec 2023 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LlwovfRi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70993197
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 05:47:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E230vwD88ktakaHJZowU/wagpmtfxUZG5ilI/5XE9Zgis9gXH2yISGAhL/csh1gWMXbB2IN71abfZqe+U22WGo6P4GExRY08lUb0IsXss5EJlDtYqZ19ZMv6tRu0Hh8jw6PJ56wAGcNNOEslNwK47hZTeQGV/WQyMcNbmisb6RvQK9W0iRIc7pEZqm3JJbqjBfkSPpLcAzqonz/61BKEiIsyP6ixAW8MUk+F1mT7xbzMj0j1G2IPNZQlOQoK6xFQjv8vps9/hyInHBOhz3DL3/Zh6ortW5E0RzfgucebQthHIdRiRC1scwrgPrxkT9k1NsH0WmIY/0vJ5OFBv98e3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7mYN8JR/IDz58HRP1Snf2zKnYwKNmXSZB5anPsmZTw=;
 b=NCdxjWYvOYMOIPB8OGg3ef4cgTrs4V2KeQ7wbj02Vdknleb6/cF0Ff8Nab6HFtVG6q4w8uoBwavEj+L/iCCjSwnF0AkkpTRNhRFPM5+haY7LWmiCPbniupvYTNstZnrGEOOnkM69uJnNt6+Kf+tXWWfq+2StFUm49u2UBTDxrjE0v7iXK1VCC2CSLwLoKM9L5wzURW0fOS0/8OmxuKfjGVQJ54Aa5VTNL+58iVfmLNijwd45XxYrjyd6p9fTILhN6EEQFbmGrZQhOEG/fpjE/I8bRv+oRgwlSwI0F1Cdhcvv1hi/2jZdzrvDWSOqZxBFL1hY5Iys5PYwEDYwWdYQQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7mYN8JR/IDz58HRP1Snf2zKnYwKNmXSZB5anPsmZTw=;
 b=LlwovfRinWPx5q2WeICEJAY32iGyFF1N9ZSU94W9sI3Ovdq2IFAtzUF8Uh/XjGWaDNvZiO4qRIhXdOtJuKPHa21CegHk9nM0KbZKMPkfE8L2H3TLrAY1h5zUk7vYdT7Fv9/avpuxS4OuvJQfRWXSY8XW2xPC2BlO/OF5qbiZo4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS4PR04MB9649.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 13:47:46 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Tue, 5 Dec 2023
 13:47:46 +0000
Date: Tue, 5 Dec 2023 15:47:42 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alex Austin <alex.austin@amd.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
	ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, lorenzo@kernel.org,
	memxor@gmail.com, alardam@gmail.com, bhelgaas@google.com
Subject: Re: [PATCH net-next 2/2] sfc-siena: Implement ndo_hwtstamp_(get|set)
Message-ID: <20231205134742.47kp7tzmyu7osglq@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130135826.19018-3-alex.austin@amd.com>
X-ClientProxiedBy: FR4P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::12) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS4PR04MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f435c4c-52b7-462d-ec4d-08dbf598c2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0flV73i63u2P4VbzMJDuMsDP34CPdwLoajGiqYnu23g0ubqufOliwDot5zNf8S05U3OHvl73JVlr0bRygSwHaLMdJSVbqH7dY3n6QAxk1Xklk25qPKHzlAJD/lA4oCO5cdCEBB3NJ2LPh9jMaIc6E23oRA6At2MK5AUerb+Jia6XodFoQEJ7FD0SNYZMw8GvDoYw3y3xS87TueKNXJe5Vl0yIuNnh1hzf/1FhYchom10ndmAVDYnI1YjAhK22Er/liy6L1whH2DDi/4Djq7ay1bB1C5X5OHDzZPB20bYaKJDhc5FdEglRvm4eRHRtke9p9yZC+ewXK5S4KqaX3qnULJJ7HIUKGuLJPEiBjAzWiJEJnPi72SDgZAJKLC36X0GkJmUsWFUehvoyi2Iy7PD4lcQ1A/AIat3R+fwp23Lh7q2OREllVr7SeSIflK5V2hLMlTup28DmhgBQjlIzKMRPiKjVT4TYTDvYBnkOWli6FJLtD+cLuZjJITWatBeUNsIm+UBommBF0x647J3aC2UfJviMicq/cwdWxZRKTT0c86/fBof9OYX69IEphaXYeWt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(9686003)(6512007)(4326008)(478600001)(8936002)(6486002)(1076003)(6506007)(6666004)(26005)(6916009)(66946007)(8676002)(316002)(66476007)(66556008)(83380400001)(4744005)(7416002)(38100700002)(5660300002)(2906002)(33716001)(44832011)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uMuUDILzf9ZU52wx0SW1EElp2UfF/PIYNAYDoCOD0R1OsIrl7rxJ4OJH0rS8?=
 =?us-ascii?Q?RgrgAavG6VCoMD7QI7u2A8jW6CQSPwTpa7VE2A/Gm5yNMMDQThvRbGh/KQTp?=
 =?us-ascii?Q?5Fy4qXHBrc4EJTKGmkLEq+Oh5MgGpxsIowiLbIIyskSIvPKzSimN6Jn/87zF?=
 =?us-ascii?Q?4tIre3dAPaxM30do8t7abQ+4M3vLqcl5bxvCPE1pa5OyPncvFzRC+ngTcRLL?=
 =?us-ascii?Q?el0twIfqfAw1iI/fuQJcwO0HCYty5G0xgNJwIcYYN/EiGBeqvtrE92J3bC9t?=
 =?us-ascii?Q?8br1G8uGmSuJWpJASwYIjd2IMvjNu+625XXfd5J485EdgHlGaQIum4TUPu4c?=
 =?us-ascii?Q?jSYTiSbCtEU+sgPwjGGXlWOvwVSO+mfM8xsfKWBzqPSFGlQz3TXb0Zncog+I?=
 =?us-ascii?Q?T+DDJ8rSAFI/98AzjAcgnQ7VKYS1FSoIA+EjrWrYz+b+acOUOOn2jZiQwbXn?=
 =?us-ascii?Q?KS56BiPqXfGE682bOJsBZyPCydolVxCW9yxd1Soa6f6jbEUZTn/EPsHS0Azs?=
 =?us-ascii?Q?OxJiZTZiJEE0PHtqmDD/TYJiAlcYuNySsCmLYtxE4ELvZ4oK+IKVTsfIy5Of?=
 =?us-ascii?Q?AN5pI28N6TmkfYCgIC9HSvgka6PkzOZeUD3ea5rsmDfaQglkT4EJT5wujFim?=
 =?us-ascii?Q?HxHoajeRfJOjx6IT+JeXXgvNlMZbT5RFOJUDlBE3FiCdXijGedTht7ciK8zS?=
 =?us-ascii?Q?vJDY9iXsIMf5yd/MUa/LWSINioniGH3+zvWu4TkKjt2w00Iv4HuxXFU/Dq33?=
 =?us-ascii?Q?mBanU4OyoCbxs3N1wBK4GckHbbupk/G95272L1fA/242xT8ycCwnH4QoHzqX?=
 =?us-ascii?Q?F9i9qNsQbBtsncAgYhlg9d2bjyneVb0LHrKHH4eklrosVXokcfsGkBiNevZ6?=
 =?us-ascii?Q?jWdpV5DJRCUVk0lM1bNO+O+wQZPhZ9qcuEYtKgNroTsUbl3lbg4xTMyt7ViM?=
 =?us-ascii?Q?VyZ/HqLrLsWKwhV5YVTY9YKPLRdbpD9mBtcpW1N98D//TyzbaN+ldelTPWyg?=
 =?us-ascii?Q?ABRCCF+jUaLXnKIFLY7qdy2QtuRHgyV9mO+H6FFsdKSc6M5FHRmRYvp7Fm2T?=
 =?us-ascii?Q?Z4TnU256/Ibig9Q1Ov4+8pAbtztclX01CW8Ssagq/Ob0212JGRLspLvURAr5?=
 =?us-ascii?Q?zyg0pnaHSFcAur+yiiviV3pq31iq1PV/CSuEVH5ALcLse1adOhIQsKmDuRgw?=
 =?us-ascii?Q?/o4bgB+zBFLF/sh2AQ3VaXf8wxBXD3fMWe/s9IuiXdHkhPuEoPF2yd6GjZVF?=
 =?us-ascii?Q?zCz0bZ4IkyDaB+9lSJFXq0XAzcdKG58UFOe7cdWWVwH9SMXjpXWtAgpdO/6q?=
 =?us-ascii?Q?B4HFgRXiuMKe3KreiIoK5wQSqlMxV6UJa9BA8iHLxs2liH4BfHOiyTUXANtf?=
 =?us-ascii?Q?AALeZtx98Bm2prnr5wj6qdz601ifwSVcL4HYf9nqSo4L8WMckzhPk/xm8uPt?=
 =?us-ascii?Q?+rtAjeWTv//5TCTBFXbhbtNjs6QsUNpHBqSdH2XwsBXZixpZbBfNcWCDt2+5?=
 =?us-ascii?Q?t2/TCnTjKAjlQ40QqWkC+WIJGxweKqECnGIu/CkMV4SMoj0kvciMkyv0qtdU?=
 =?us-ascii?Q?rr1rJstjVTFLixEImczRU8tvU7dfUtglRfpHNyXJwdMTWG5gTVfvM5CX8sdu?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f435c4c-52b7-462d-ec4d-08dbf598c2f2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 13:47:45.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2qqQfrwv6t9PPxWNsNAg5giqUKeWz6m/QcRJ5B0l3iR4kphmEcHEbT1p7jCFJFIh/43jaW6iQdj0+HEXXT/pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9649

On Thu, Nov 30, 2023 at 01:58:26PM +0000, Alex Austin wrote:
> Update efx->ptp_data to use kernel_hwtstamp_config and implement
> ndo_hwtstamp_(get|set). Remove SIOCGHWTSTAMP and SIOCSHWTSTAMP from
> efx_ioctl.
> 
> Signed-off-by: Alex Austin <alex.austin@amd.com>
> Acked-by: Martin Habets <habetsm.xilinx@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

