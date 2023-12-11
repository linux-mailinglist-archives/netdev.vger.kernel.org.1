Return-Path: <netdev+bounces-55880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97580CAF0
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D491F2110B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A965D3E474;
	Mon, 11 Dec 2023 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iSsMm2Bd"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152C4CF
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 05:26:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl6lGvMUk24d7YE2cSpRTR9Xv1RhwN9ZFZB7v6Y7U6LLZgsdKe3OpYR3AFhEEgHFR2sJ+48aqQmBZ6ARgdqJsD/H2NKG0RVqYWis0QieX09ZuCDbrxQ2M/qFCVhLsa9pbR92GHGZlbLHCBh3fnCM6x8FsW8bIYRGlNgPt8DTIoXipsgxWLz5TX2Gc74gPJzqbIWKoDWcfl2RkASOmAkzrjjrY0xKhgP1NZn3Mh2eC9ecYWvhO7OoWB5ZNla0ZhhYKn/+iD8Pz6IXzIb5kZLHV24s7ccGhlcfZArJv2c0KUjhEr2XrhI1TPG9Vv4WEuYgn/nU2PxgMU5BYzAvq8XaPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu97KNg8Ad/WKhNj81ifOndjBlylHBD25vW8CcAvhiI=;
 b=DbP03mc2WGZJ70RqUHeidcNZUmFxupw7kQySsS4cGNgbldsi5tFAtngIroFkOILYaYX50bKqR1Om5ZkAPUdRl1k6JW7QMt5Q+dUQXUXiG/pwK4bv5reiMI6Jjlb+wN2p3bavY5mmIzLaquw73bwYIFTF3yN/pbaEoYdOeYXQFpPJ+59ySg7WNf2S8tcY36yPeunnksIzEosTsL3+ajqmcsnXFIHLtr6QpNgJQsPrOKCP6W/QofwuUWpJSguH57rkfbOr2KTDNjimE56tQ7gLpjZYJUwegwcS3XQQCWRGNQAE/eL5AuhZMWcHZMOklIv/2RsNHEGZXnYEPrblrFnNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu97KNg8Ad/WKhNj81ifOndjBlylHBD25vW8CcAvhiI=;
 b=iSsMm2BdAK3j95vlFw/VHEpzF9/Xpt0HbgT5sInMwaAimw+WWG+KtfoRg6Y+tMqvWBbgY7snXN+r5+qsjpPEjD2I/Ega9tSM+uSioyXws5qR3VIDvY3QuHaeYTXRCLoObg+o66DlsajrTMc3i0C4Zy4Ij5Q3uycDNawTSmZS5WM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB8388.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:26:23 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:26:23 +0000
Date: Mon, 11 Dec 2023 15:26:19 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
	vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 net-next 6/8] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231211132619.mq5jzyibva7ogrc3@skbuf>
References: <20231201135802.28139-1-rogerq@kernel.org>
 <20231201135802.28139-7-rogerq@kernel.org>
 <20231204123531.tpjbt7byzdnrhs7f@skbuf>
 <8caf8252-4068-4d17-b919-12adfef074e5@kernel.org>
 <7d8fb848-a491-414b-adb8-d26a16a499a4@kernel.org>
 <20231211121105.l5nk47b5uaptzhay@skbuf>
 <0d2bfc00-86e4-440b-95d2-d25afd15c69f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d2bfc00-86e4-440b-95d2-d25afd15c69f@kernel.org>
X-ClientProxiedBy: VI1PR10CA0110.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::39) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f69440-3fe3-4acd-b550-08dbfa4cc4c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hUbaGe7Uw1OxQtzDMUqmpA0OMOp7tyQ2hNYUydT4DhKFP0M+yMuvEeJ6vBn0R8Igm57XuGhdX6VlpiM5pdDen6W8MpL+EoScG9s+vA0M2hfYAe3cY9TEW+PhDwJesDVJfli34HbW5Dif2el9OoNqLTJwk/So3e/IaRyYuJ/ibfiaTSPNtSotTgUQaa+25Po2g5F9vKYC+0tSrSbpNAVq9o67WYGWh00mPV0TBTOVKHA38vT82hzTIsZY27xQwoarSTc5nkDv3FZxvbVDjDSK+Ee8GwXxTPn1sR6v79v5VD89j2MB70gTBNXx3WwZ7vLZdo6tBAbogBhl3U443h/KaGhLtbd6b5DHOgNOSdpPEq+IiizfEeQwvS6JhNrZU/LQp8i5fm7NPUrhXtj2tXng8HcYfcS6nVYItUE5av3ZEAsoO9ECd66CCvs/cdGsNS/KOKNopQB1OtYk2VVF8a/M3XYlX2BWR1IH1qTM4FGLfYHfJK3QVzdIPk9IiCjr4L1bIqEz9hkP3c94PbxXNgn0UwYcAX2n11SSPQPiVMuIIcsL4Jp3H4SVVGZHP9cMN1LS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(9686003)(26005)(6486002)(478600001)(1076003)(6666004)(6512007)(6506007)(7416002)(4744005)(44832011)(5660300002)(41300700001)(33716001)(66946007)(2906002)(66476007)(6916009)(316002)(8936002)(66556008)(8676002)(4326008)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AESmwrkOKVAsMZOeUYuC+nITuw5Y0EcSxN8GshfV5CwK4RuLKX7nTSMq0IES?=
 =?us-ascii?Q?bIr/x+PBlJqanBuOxo6lbWHOPb4LdvKHxyjV3TBgFw17EcxcXy9JqKmMUGBo?=
 =?us-ascii?Q?ilOs01oSp6sirioD5kLEBu6NKdIBX4AfCu78RH28S7ui+njX0jk+GFnzmn8B?=
 =?us-ascii?Q?gsPSxNELtsGvaUBe/onAJM8l7hxum41oBge3ZZhDruvdDXcmlvarVYeRTwqh?=
 =?us-ascii?Q?eWKj1ybS+ulu/2mzPjNOdCUGqt6XjtxzCe5MYBVEJkN17qYBVaHUtYSuLGrA?=
 =?us-ascii?Q?ShSeB2h4EfhuZiJbaGVeFy5ZGWPCDJd5sSu2/eiL4fq/a88UqV8mIzmOKk0f?=
 =?us-ascii?Q?kO4teA3Ej85rcctQuUO/3GVR+e5ytBNKc8vxd4GpfBNbTIT9wh4kYEyh39qA?=
 =?us-ascii?Q?imDpyjV1C+vtqAqCItQ5KgZpz/yElo/tvZQoW8OkPxHu8H/PymKGZnwPQAaW?=
 =?us-ascii?Q?HZJqGP69rtvkZ7M7xCOmpDAufKUUQY2Qi9duCKG1QkdDrljERtKjFmfXA/e/?=
 =?us-ascii?Q?NDnfnQuyarg6eTo/0hvsDBcRYm7ouM7MxW+tG5rHCmxS8dhoWBlLh1oP7Ckx?=
 =?us-ascii?Q?WokKteCscXwa5N9K2D8eyZaPskS538YYT/4KqnqLWIvydC2DezE6XAnHxBV9?=
 =?us-ascii?Q?zptnWOnzEwvbgmnZbMLEgqXw3+drVgd3I0W6s42056IsduiCTHRzd2eTlH5+?=
 =?us-ascii?Q?DuoJATJxrXpmy0MsRcQ+xZTu+4zQJLYTYL9ccD30ykpeY9QXCQEjSm608aGJ?=
 =?us-ascii?Q?q6NYdNscBwsuwZtPTiec1Zm1u5DZjNmS2691WQQB3b2do3nq+8CSB9DrqEE9?=
 =?us-ascii?Q?WrXCMW8iE+nx6d7ib4csilE3YII2Qg+s44BEbraFX283/UyhUfvn2UwiwgRt?=
 =?us-ascii?Q?WpsNl8hiSMjSy/JCv9WQ0p4T5FSjkyJGndEwHwG7VAemfJpcVQC7rTiJKW0p?=
 =?us-ascii?Q?KRskBrmz2HVik92VK+u+UusHtVwgHWSARFx+n91k6Ef18RwigV7Gg2zyL01r?=
 =?us-ascii?Q?plOaSqOgL6baGoWvV8gaw+tUwQBMzpUlAHB6WNbUNXwIvSwMJNq/h/3h/wE8?=
 =?us-ascii?Q?9OSYbflNh3CbiYxJFPnRavvelnLADhK6fIYzoH1tXuIRYcXnwH6LEjiagkrA?=
 =?us-ascii?Q?Ia98EFcXqW3etAkXqnykTGDO4+eX69gSBK9sv8VsgUqYcSct2pqyglM8fabB?=
 =?us-ascii?Q?rN5Xu9foqogKp+lxf+ULtFqGr55ypPHzss2305id+awUMkw12sPp1jHV2Ry0?=
 =?us-ascii?Q?pab/XN5MOeFGJ1htBiZZsqRMKxFh54PBFbOJB000vtwokQTCGQsRXwd2V3r1?=
 =?us-ascii?Q?2h9y2fQUM1NYIy3wmTkxM881Gh4YaLr90NJ4vGrQsK4o+r3uq4/8bVYIcSbn?=
 =?us-ascii?Q?QU6PY2LmmgymB6trKYf7eA6vCz53mAcw8ngwXg64P7SMIG9eUTAt975KJCS6?=
 =?us-ascii?Q?4vK53L+ZgFEUae3pf06RhxZW8Hy8FNAKEaM8GmMQLKG++n1gCVO2xObryYqS?=
 =?us-ascii?Q?ZYP164IQCwod1gBH6hIP3E00bqyLvZ3kJHOnvnS7Cyhs1tsM5FiAK8yIlSWf?=
 =?us-ascii?Q?d++PWu+vCEMEU0WGfv4+OchrLCbJE4YX5rLlBy2GT5HkpUUwpaf+j/bEEUOk?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f69440-3fe3-4acd-b550-08dbfa4cc4c0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:26:22.9790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z9kxzbiUqr1Ifuz/y4AmxsIOBe4K49g8JPtKlpDCoagZa7Sl0kkR3AxGNZP3YcYkjiAtPZ/8SOa1JPcDhfZ2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8388

On Mon, Dec 11, 2023 at 02:25:35PM +0200, Roger Quadros wrote:
> The config option mentions only about TAS/EST 802.1Qbv.
> Maybe it needs to be extended to include IET/Frame-preeption 802.1Qbu as well?
> 
> This is the simplest way as the file am65-cpsw-qos.c can be completely omitted if
> TI_AM65_CPSW_TSN is not set.

As long as you need to look no further than in "make menuconfig" to
figure out what you're enabling, it should be fine.

Furthermore, some consistency between the file name (-qos.c) and the
Kconfig option (_TAS/_TSN) would be nice.

