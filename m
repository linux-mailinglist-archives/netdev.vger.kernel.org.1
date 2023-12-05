Return-Path: <netdev+bounces-54044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39E0805C96
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D991F21203
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D866A329;
	Tue,  5 Dec 2023 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LjRMFqgi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84733122
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:50:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4RPNgUu0YHpn3sHw//mkY3SkylleXLjhfRluiOL4CaNY0oRLF6xwuxMoCIe4K2HGCTvC5McmHk1y708lhPh8+IRpOGPsHbC+aQLYoH+YKNzcVyXPB88NXaCqpbzMTphWoohjlWef4/m4BSd2/WO1Offko/B7Yvi9aXhupdo2d+pNv6D1BvCH1co2MnuLc3Y1yltCjYTZA6jW73efYtZtg4DkVCPazZUwEtfGjn1Rk74vKH56iEHTKvLb5RLLil2mxQ96ZAkZdc55mI5/igXMvhqF5rt5hczr04ehGmJVkjyGuPJL3YLZOKtLs/hp4d5JF+sRPlMP6bwVMQyOUpniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGWPBL8TjJD5kQp6ThGGk7qYOnGrfwfHkoPqx/hAKDE=;
 b=EN4KdIUvA6l9bvVShD0tJXHQvYHaDVKYuKhst/968eixuMeUtZZ62YlQOPC3OJyKKsvLcmI0vExRSFiv018eXpbwOmjqa1cu04rPA/YcckbXvlZZCbt6zgqjHaHR78RzmWvQjSrG66iR26qsSYtPoW6Q5sYw1shJhPfq8dh8tA61Y+J1PeyivQqkGnfoxB2PkvQrNO6YhEJL/FpaWISleRUkT5yHZp/AnoEPBTgTBW2gRmWYGGT78sxSoiEcx+aU/hVbjiwNQXHm/N03T2T0kqwvMWeEWOnw6ALa3hUxP05w88rQ/c5NDvtB2lWiAVQlBRQ7W48nSN5cRqbcIwZl0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGWPBL8TjJD5kQp6ThGGk7qYOnGrfwfHkoPqx/hAKDE=;
 b=LjRMFqgiTc9zldGm63cAqgKjpg9X1CCw2eViOJ0FMEt66j4xPLsS0SUSmHTl6sWrJPv3HmIxP64YgUsMtKv+Zqv+LBnqjmDyZvSxGuKB8mgPYjIvcWX98V+VBrdRGXJ/ZmAIO5iPHF8P1ymfXieVHJadamPLrjL5ueAZYUwE2eY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS4PR04MB9315.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 17:50:45 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7068.012; Tue, 5 Dec 2023
 17:50:44 +0000
Date: Tue, 5 Dec 2023 19:50:40 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/6] net: dsa: mv88e6xxx: Fix
 mv88e6352_serdes_get_stats error path
Message-ID: <20231205175040.mbpepmbtxjkrb4dq@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205160418.3770042-4-tobias@waldekranz.com>
X-ClientProxiedBy: AM0P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS4PR04MB9315:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef8d5ef-98fb-46e6-d4f7-08dbf5bab3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vlngTXD1IE/+TaeLV85uFm+fnwU2KpXYVsg6PIKBTqyLD4rztC8z7I4nQ1fLKLPUdKxfqjDN8zugXAU0UyG5ZZDuAQpZMFvb3h5n5x7y5dVz4Zd6dEVi33Es7jpJ/Hr82ORPGkdn3SIDD85aMSWI/AbALWW6XSixR4ZLSDPFy/2QDFm5Go7e53QrhlS11dKvy8wJ+/a9U4v9RCzhgpmsxC+dJmwppHfjYqGwMNo0wY5RjreP2bOTjEvXV4VZOxceBtbFzfRaM/v8dEKkdVPu6SD4vQIrgOIoIVFq29dW0mhH0suCrdxkyUglP+DHNShl3kJ3YxzLsJncD9EZ4SiNviXwLlx8yCvJobpdwC34ZeeEjd1ww/cPQsWJ25ys2lpwMcP8VDOFv7hsYhoT+8QnuB+bvnB+mdjC6R6uIhSDJU8hVK7uIU43tQYen+8IjivNHtx4ws5EYOQLhTxG+3KkeDf+6Jn+d7gyfuDzhstoNmbIQ+edf5RXYE6s2kRh+mbJBsa0U3T0GkM+DsVbr2LpLvpbNkIU/c97BVN2X5aDe6gdB9RAy8PWxRQooseuYckm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66946007)(6916009)(4326008)(8676002)(66556008)(66476007)(316002)(86362001)(8936002)(44832011)(6486002)(478600001)(41300700001)(26005)(2906002)(38100700002)(5660300002)(1076003)(6666004)(9686003)(6506007)(6512007)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uxaoq8TMN67WdWoefOkT/In26IpGBgd0IdV719uF8puRHAb1GX72uk72Zgg9?=
 =?us-ascii?Q?fWbDkAcZZYGNLWL+Jy2cpZxKBQ0cQyj4nEfVaDucJoJ+uI8jUaWCMT8pQ9id?=
 =?us-ascii?Q?VMi3qqv6KDIrN690KXhV4oz4I6ZvIIpe48XZ1/z78W+Ys9uyjg9yoH92SFig?=
 =?us-ascii?Q?1IwtPBdenhocu5BPCuqctGf4IWNIQd/MyG5Ucc6fo8L4b2lIab8+n/eBVDmy?=
 =?us-ascii?Q?kgHi21y1Wp3lPOBslahTkOfCbIMYVk7KZZ4CIhiBo2FH1vVo796DnisxJVTy?=
 =?us-ascii?Q?VJeG4lIsYLsNOhUGTZ92aEoljstQ0XMZxOIguzn8eSd3sr3lv+1QAbHlAqfq?=
 =?us-ascii?Q?fByVKcohnrW+HORI5wlZAAikVuXe2xn7Nz3zRUR0l2H7OSGJ2j7kK+cD8PH+?=
 =?us-ascii?Q?pAkbijJfqmeBhI6kwSSbyczllWKFrWngVAg5grZkhwQmF+ALsTvIWKYQOGbX?=
 =?us-ascii?Q?rUKpJeW73MVY00Y4CjULz3lQoJosTgjjvey9yFBSnRkHco91h6NZk94+9WMD?=
 =?us-ascii?Q?bHLBkE5fMggYUvp4wEI2yRgDrivj0sBy4bdsRGhMM1aPGoeusQ0wzDpVmMjz?=
 =?us-ascii?Q?znrJeNrJnJ9YsNSNQld/xm2z5/pMlTcAAHm9i8QhHDo1PbWNQn8ym96kwH8g?=
 =?us-ascii?Q?vBfseRa3WzzrBPrZ3U/lLFg1+Ok7p8PBBwuRJFiq3zc0UHWNG6sCbdx426cT?=
 =?us-ascii?Q?ExVtC7JIvH+QGYy3IxhInlSDFNvje4LLlWOb3Do88CqV3BBzu3Jom1kARHjS?=
 =?us-ascii?Q?c8x3IalLZuW5lEcK2y7wPV1qnh1f1usfEn8sgSwPVONRBN1emqiFRv0NEHnN?=
 =?us-ascii?Q?LoC2mvi2Ww/Z7IgWIkopNw8o81eV4F8/+PcDWjOq4sWcGVCr7iuYW7VMBDCW?=
 =?us-ascii?Q?QZLHSWeNTVFDjKHRuowkltl/q+q2q4KOtNEVtk9SKDM/DyJKGeUd+RwJx8BD?=
 =?us-ascii?Q?n6VZdVfRkOQgM692EMHZtPxwO1yt6K2dUaqIh7H1yjrDoOe+sMDVdZdRbEMT?=
 =?us-ascii?Q?coSBMrXLeni/MqBB/CmOwC1KwfH4wOvmwa5btfL3wZxI3lyLuaW3Sxty0+S7?=
 =?us-ascii?Q?jgjrlYbt08/7ogRQpqKBXg0VNtCfzrUQT0I1ATFGDrMhYR5aN+VPgWDrtmFD?=
 =?us-ascii?Q?mxkA40W60nWSBWYcoiE5EyhLDe7jEiqpLZr28dFqktbitRZ6GFkz/B9nyKwa?=
 =?us-ascii?Q?+VwxzsGEyBTiV/ba8SM8UTDgjx/KLwvx/jBz2NRQMHM9JZC6Ak3nqsHXURiW?=
 =?us-ascii?Q?U8TOmyMxEGy6d2n1Xysni2EeQ1tpTJAB5XyoUt8l0ltSUhB4ygD762MKZZ9g?=
 =?us-ascii?Q?+xHuHtNebZlnPyPysirsQMb+ctd5NKMyDAuf3qOu7DBOyW9Fiv2RQZTlwhJ+?=
 =?us-ascii?Q?jgZng4PuISrYYqjWkFdVb5WQYvVq0mYPnZJ3RyrOGIGUUAxLVlzLi9ooUAH3?=
 =?us-ascii?Q?NW7zIyrZ1MlVkkLhwqs/lyB3su60e81CeIfMnoyQ5M3ulJewYoBx3pJxAQ9o?=
 =?us-ascii?Q?oBf4m4Xh4EV98ZXGus+h2WWgwKl9GimdkqvpLT6fLJBb3bJhJ4Zis7SFmCiE?=
 =?us-ascii?Q?qTJ5svOv17Eh8Em128qDhTsSN12M9DtyhEGBq2izTZjCFFyTqrpnR4HxR67Y?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef8d5ef-98fb-46e6-d4f7-08dbf5bab3c5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:50:43.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5ZHiHIE1mn+Jp/ITxiOuTtN88MDIOQt2hgqhe7s+/7l+jQsxp4WTv5BPxyGRDIeC/M3FqQREqwfairO7AYHRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9315

On Tue, Dec 05, 2023 at 05:04:15PM +0100, Tobias Waldekranz wrote:
> mv88e6xxx_get_stats, which collects stats from various sources,
> expects all callees to return the number of stats read. If an error
> occurs, 0 should be returned.
> 
> Prevent future mishaps of this kind by updating the return type to
> reflect this contract.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
> diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
> index 3b4b42651fa3..01ea53940786 100644
> --- a/drivers/net/dsa/mv88e6xxx/serdes.c
> +++ b/drivers/net/dsa/mv88e6xxx/serdes.c
> @@ -187,7 +187,7 @@ int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
>  
>  	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
>  	if (err <= 0)
> -		return err;
> +		return 0;

Ok, you're saying we don't care enough about handling the catastrophic
event where an MDIO access error takes place in mv88e6xxx_g2_scratch_read()
to submit this to "stable".

I guess the impact in such a case is that the error (interpreted as negative
count) makes us go back by -EIO (5) entries or whatever into the "data"
array provided to user space, overwriting some previous stats and making
everything after the failed counter minus the error code be reported in
the wrong place relative to its string. I don't think that the error
codes are high enough to overcome the ~60 port stats and cause memory
accesses behind the "data" array.

Anyway, for the patch content:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

