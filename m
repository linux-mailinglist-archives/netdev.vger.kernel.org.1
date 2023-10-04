Return-Path: <netdev+bounces-38099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F97B97FA
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 51BD62818A6
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEF325109;
	Wed,  4 Oct 2023 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WhM7O5xq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669D224D6
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 22:25:31 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987D8DC
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 15:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjKTQGTzhbPDdtYJeKzA2TfnCMdX12WArg502QAQUazaX2zr31uzmd+BcbCp9M5PyqYeGlLqhjq4gbtEadjU04pxgbZS86YvcEmCY+tLzPkDOIAST2i3V3MSFPqodUzf2w/iyvEXDBIxIz4EsmiTiw02y8/b0kP4dSvC5ZWhCA4KLx90mxDDbc2UR+QYvBH6/8rq/3HAqYMIYs7sexZGFm5QG2MXEyelf9bn4jTOw/iJrNuErAjHU2Fu777YP6H1ibjQ7fsS9cLouf3wIlHXQMz58akCOIZNkJCc63p0Y9g3CTZ2KFkVsSDFrciamMYtTz+qBwDpr7rWRqvvxnYHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccW3DpQyJNHPDoyULL+tcf00VJaH6ob8pgrgNIvDW8I=;
 b=iA9wAithADElvkgk3YK0LztO8W67mX4qMiTiAUsyuVLQM1HBtPYESkoceUalQgZJ8HQGfmhoOj2fzh75z6Kd8qh71B6o7PmlZh8GE4L+e+855gta5DW3MK/LLrVbJ2T2zKY1zAjla7NWNtYjFRBlOt4AfyNFfFiwwrJW584/hvoNPn2kzSpMcaLi6tPdyD0LuQw4fz0O5C4Rdx3/rphRuInQ87+0yFWUbc9fOXsf5H/GxB7tS7MvN96PTmQexAqyTorVN+DHG8lcqbsGm+NYOH5r2tTMrhXBkTHcTmGxw7rAZWxp0AJXz+4EoN+vVf6t+spQMC0R3oWO5s90HQzBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccW3DpQyJNHPDoyULL+tcf00VJaH6ob8pgrgNIvDW8I=;
 b=WhM7O5xq2DC4ApWDy5ZO6gpO+GWt16ms1JNhQWh5EieIlaLgQKtilSFQebA9s6+eHRq2T3K/SgEspx28YIjCLwdHSDiXUw6L6yQ7E23jc6KFExFvP8PnZeIWvg/GoXk9NZnRdZPKeFIJagJmCzTFk4tlfWvRYOwXchIt3kDvbEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9741.eurprd04.prod.outlook.com (2603:10a6:102:37e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 22:25:26 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 22:25:26 +0000
Date: Thu, 5 Oct 2023 01:25:23 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Subject: What is the purpose of the first phylink_validate() call from
 phylink_create()?
Message-ID: <20231004222523.p5t2cqaot6irstwq@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: FR0P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::6) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e5c142-d972-4136-bfe5-08dbc528cf07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GvydVYnzD9dLBu8FmsYOZ156J+aRFhgVi1l6bG1aDbAgge9d3EyFtdHZ3YAq8yvCdTLNq8+/mpgCilMZvawNwcp/diA0vYG30L+9cRf7hpcKpnL7ns6VXOLZEBBhboA/ar6BBxBCAi63Fkg1jrBYIpHWpQAPBPxuTil9sFTISrpzIJSQPpJCYxONJNqtF27LAlskcQj3nkmZxcQcJxYzAl0eFQBYZN5GLnqR54w906eB7ybkB9vuIxp/FQPxtM6qWFKaTjpEQaFKkPsqTCWY+mLNZGSrGEZStxC/fhprxmtek6NrrJYV7R6GRVAb1YZIKPL3FXbcWp4MzAuULByaezVt2xUiOOdpOwf0ddj3mHw44rtsMZ9boOQzW2Ftwx02ZxuTzbeAei6JvYVzudJl0vgJJmd9LkP6PR/z2k38d/Vzkh4FFlBdcvoKh0Fb9dtM+Aq56U5hcjeIaQU6NT4K03cikZQbMfkqVbFo7aqdzVywSvnEol03mhxUZU4ZO3aZa5a+FpRSYGj/mFS6xQjwOjQ5gMb91PcYVkkk7oQiWf7+vYU4MNUpDQHDLEb6T3lm3LyH0m69Cawe9zKbmAYOf5kV5wpkLlvI7E2Y0HwFEMah7z14N59oQBwHI7h1wmWa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(38100700002)(33716001)(316002)(6506007)(6512007)(6666004)(1076003)(6486002)(9686003)(66556008)(41300700001)(66476007)(8676002)(66946007)(478600001)(8936002)(4326008)(44832011)(83380400001)(26005)(86362001)(43170500006)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?33sRFFJ3irvKRU4TucQihBVC+88crp5rFjjAHZdAl0WLR5x2WtGOD1mHhEQq?=
 =?us-ascii?Q?zmXM7mV/oAqT4ln+2UySoDuZIU+lXKkhYArSJcl2Br4TPjskrAnYLoYQ7Jcd?=
 =?us-ascii?Q?C0J6BCgdQNC9HsPy2bFQL1aHripZqG31pmfxIOZwXZzNyz3dY5SQYbKaXpUD?=
 =?us-ascii?Q?VsYr5YmQUmVQ+sacO0Cv2WtI8uZ0+wdnlqYaSxCczpOa87Vrmd9v82e7RtUy?=
 =?us-ascii?Q?ql/tBb5pc8PqlQJL9HMiK35xZGjGjevXXdpwseMCSEx1tbxgk684O20GXYB+?=
 =?us-ascii?Q?g+l/A8tvflcM3MKP53PMujDxtR4ZPNzsKSruR3O3/KvsZEkUpLvdr8/xmZKC?=
 =?us-ascii?Q?EaqdVbwUQCBr0d0LMdGw3uJ94hUF1v6W/tBadWW6ZlJKQA7xy+Gr6fUjfQNO?=
 =?us-ascii?Q?F1nh+fUXG6vhPKWDnwEzN2AQItuTCfITTcS9aB0KjjACDSXx2EMxRiWGzUsq?=
 =?us-ascii?Q?mwbs28+mrytM6Y4pfzGRNT5tvmIqsyj3hg1c++u9RjK/wIHA9SguYk71o4P0?=
 =?us-ascii?Q?+igfjIGrwR1sPHjVF5fZpFECuVFHHwTad5zSG36DseXQ69nvwdopPfxYdeQu?=
 =?us-ascii?Q?AlBMbFX21+Wr7buGlSek1noHWqg4YiRzeJ2RVidULL68APrem2Xe6+kDBxMV?=
 =?us-ascii?Q?mfDyYJ8SrZNH0kOA/UxTDiPKV/R3VuavIROxOpH+Y/KMIHHXxjOJXotXZyYQ?=
 =?us-ascii?Q?P/gkuMftYLJqRPSuvFOfJ83AH7ZsvMDmipi38eLXwGuOrwTHs123cORuhXPc?=
 =?us-ascii?Q?ACS5UafCsdfPBVtEtryhDBFhUtJUQ+7eoQGKiLYA9EIphiMDSw//Iylux0Ui?=
 =?us-ascii?Q?XsssxHFmH8WY4nIkzO1LLZy0vIVdr5H4mTfl0T8ryIk3psF1ykWMK3TU/M1K?=
 =?us-ascii?Q?XD0/J42IbpA10qexTTUB/w8dSydITY71OPwsMeWyiJDxXuF5lRYO7jzFpLyT?=
 =?us-ascii?Q?iu8T7rw1uDifz1ICtD2LPQAbZy0JkBpVf+NGyE51W0z6jXH9Eaizc8t7ENpn?=
 =?us-ascii?Q?/A1HofkoIztUvwgdCgoGvHivPw7fdci8NLQhEoFImlyaIW2IjBuwgUWS4Cpy?=
 =?us-ascii?Q?kEnfNYPD7UC+sLpjtZgFcprBTxgNeylAYVw4rPeeWHBcFoIw9iG7wgAD4Vi8?=
 =?us-ascii?Q?+LCrKoS6z+YTbE2d7QdZ2NEnBFDRFDxvLiCNomZkJGfBjwywr+83dt4MFel8?=
 =?us-ascii?Q?aHGPbH+qeRWTGKb3YaTidvFoSDU7E4bms25+TdWp2Ot1DyQmJVO6DCkMQlgY?=
 =?us-ascii?Q?tz5i/HCeeVnB0PayDGzcQ5o6kLEaCx6nqjymhce6PA2wytYNKt9XnXWRHNnX?=
 =?us-ascii?Q?FYCR3YL8Jkq/IfbY8SZJUYnE/kN1BFMcw3wNOr/KL1zK1IHzNkl4h0iFOmJu?=
 =?us-ascii?Q?B8vU7GHt/gNazCINZMlWMvd94XHUJD4OmflmVNtXqT+ju05YbZNvO9LwwTUO?=
 =?us-ascii?Q?Hl4K738gN3wttOAZUWCB3I1zsFOj0ychOA291QtRzOwl15dRb+YtIfH03/QV?=
 =?us-ascii?Q?amJzfpGbNIPg5O7VFnEpeDe2bFHoczyn/qb+20e+Y09070Rhrv8af+5ZvjlZ?=
 =?us-ascii?Q?+juSMaLWnO4I6WBSthjez27wjVEPUsqPGWEJrkDsvjgoez3DeRQd6gg+9saL?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e5c142-d972-4136-bfe5-08dbc528cf07
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 22:25:26.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGPDeZ2BGXJXVoVoxDXtMpjyhGwoJ1tha44TuYVwMHC+PZyO5IQwxZt/30NDzcH5MJUHm8h6FuxW8D2xWTDBrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9741
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

In phylink_create() we have this code which populates pl->supported with
a maximal link mode configuration and then makes a best-effort attempt
to reduce it to what the physical port actually supports:

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3951e5af8cb5..1e89634ec8ae 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1677,10 +1677,6 @@ struct phylink *phylink_create(struct phylink_config *config,
 	__set_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state);
 	timer_setup(&pl->link_poll, phylink_fixed_poll, 0);
 
-	bitmap_fill(pl->supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
-	linkmode_copy(pl->link_config.advertising, pl->supported);
-	phylink_validate(pl, pl->supported, &pl->link_config);
-
 	ret = phylink_parse_mode(pl, fwnode);
 	if (ret < 0) {
 		kfree(pl);

However:

- in MLO_AN_FIXED mode, the later call to phylink_parse_fixedlink() will
  overwrite this pl->supported and pl->link_config.advertising with
  another set

- in MLO_AN_INBAND mode, the later call to phylink_parse_mode() will
  also overwrite pl->supported and pl->link_config.advertising

- with a PHY (either in MLO_AN_INBAND or MLO_AN_PHY modes),
  phylink_bringup_phy() will overwrite pl->supported and
  pl->link_config.advertising with stuff from the PHY

Of these 3 cases, phylink_bringup_phy() is the only one which
potentially does not come immediately after phylink_create().
So, the effect of the phylink_validate() from phylink_create() will be
visible only when it's not overwritten, for example when phylink_connect_phy()
(or one of variants) isn't called at probe time but is delayed until
ndo_open().

Since mvneta calls phylink_of_phy_connect() from mvneta_open() and I can
test that, I'm comparing the "ethtool" output produced before running
"ip link set dev eth0 up", in 2 cases:

- With the phylink_validate() from phylink_create() kept in place:

$ ethtool eth0
Settings for eth0:
        Supported ports: [ TP    AUI     MII     FIBRE   BNC     Backplane ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
                                1000baseKX/Full
                                1000baseX/Full
                                100baseT1/Full
                                1000baseT1/Full
                                100baseFX/Half 100baseFX/Full
                                10baseT1L/Full
                                10baseT1S/Full
                                10baseT1S/Half
                                10baseT1S_P2MP/Half
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Half
        Auto-negotiation: off
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Supports Wake-on: d
        Wake-on: d
        Link detected: no

- And with it removed (the diff from the beginning):

$ ethtool eth0
Settings for eth0:
        Supported ports: [  ]
        Supported link modes:   Not reported
        Supported pause frame use: No
        Supports auto-negotiation: No
        Supported FEC modes: Not reported
        Advertised link modes:  Not reported
        Advertised pause frame use: No
        Advertised auto-negotiation: No
        Advertised FEC modes: Not reported
        Speed: Unknown!
        Duplex: Half
        Auto-negotiation: off
        Port: MII
        PHYAD: 0
        Transceiver: internal
        Supports Wake-on: d
        Wake-on: d
        Link detected: no

But I'm not sure that this ethtool output is very valuable to user space?
At this stage it is essentially just the output of phylink_generic_validate()
for the MAC_10 | MAC_100 | MAC_1000FD | MAC_2500FD capabilities using a
gigabit phy_interface_t. It is subject to change as more link modes get
introduced. The output with no link modes reported until the PHY connects
seems at least equally reasonable, given that the PHY dictates the link modes.

So what is the purpose of the early phylink_validate() call and the
associated population of pl->supported? Is it just to report some link
modes until we have a PHY and we're not in-band, or am I missing something?

On a visual inspection, this code structure exists since commit
9525ae83959b ("phylink: add phylink infrastructure"), but I cannot test
as far back as that to be absolutely sure.

For reference, here is the ethtool output when the port has been brought up:

$ ethtool eth0
Settings for eth0:
        Supported ports: [ TP    MII     FIBRE ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Full
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Link partner advertised link modes:  10baseT/Half 10baseT/Full
                                             100baseT/Half 100baseT/Full
                                             1000baseT/Full
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Link partner advertised FEC modes: Not reported
        Speed: 1000Mb/s
        Duplex: Full
        Auto-negotiation: on
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: external
        MDI-X: Unknown
        Supports Wake-on: pg
        Wake-on: d
        Link detected: yes

