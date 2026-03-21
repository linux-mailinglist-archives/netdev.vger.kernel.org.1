Return-Path: <netdev+bounces-270134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA/gACnxvWlkEAMAu9opvQ
	(envelope-from <netdev+bounces-270134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:15:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0481B2E2BFB
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE8833018E2A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009BA325707;
	Sat, 21 Mar 2026 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gpLnj0NE"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638642D3A69;
	Sat, 21 Mar 2026 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774055700; cv=fail; b=lc+iqf+Vi374oQXpCzWom+VyXXvBpPNLq/Cr3yQ6pjohNwm5X5L9iWMuqtvok0cE/j7GeV0d+fpK98XPTOgcrUBoDGVYO1XZQEQVg+0j87OqbqirGlTqoY6wVYyLXV4ov3odKRD0I3Obj417ZL0HDOYBlRpVlYKmBgx3G5YwXRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774055700; c=relaxed/simple;
	bh=mO81rLEGlsTvkx5L6myXb85tgAvkV7e7tpo0HUWN2gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kEufOf0NiTC9OCQs0w6cOtHRFVRjUgzEwgsN4VPRwV2HwOJpmCZVF6TGE3TC/kMvI2AEk/G/QJTrTOQz678SuSSltVXaNwnZAU4XIjLiRYsfkX9U1FgUd4Oo84OPJo2l7Iq5xXhUL2ke54AjYxss9GWZEWe8zq5gb9Xh1IGLtkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gpLnj0NE; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ysq7kqpSPGRpQ5u4h4RZQaB8XjcAXYyO3U41aOryjda/QeZvpmA1Zzp/rW1ZHoCSRXqmb80/9LhLSQ1a6d7EggZ61c6Yb73rSJKC0H5bDSN3xdqJDUw7TWonxiJtqr7b1mFkt4JKgWBj6wOPdKqYh98ZEBmCv/545iUqehixnwk4IEjfhzmeYvUa1HdCsVtuw9SKmaNtiseXHWRpmIFhv5YagaH2tu61S8jiFqBoZB0SrNfgtkwhdPskUCR0m+mpe/RwqkPpm5vvs+KxDwoqUDJzpAlTmuTIpLxHTY6fnklPRbqnzWPaquOiIWP2Nsrhw4beRq6QQEHmUGhEYES3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Q+CNzYzvfo2eA98EfLT1Hje68s+9E+eicHVldSOG+8=;
 b=TvZ8bfugINmZhv2RGfwuiqGQBVQMQC+uqqr4QJbA7VBJgUlLmCC+ZHcp7vT6b7M1tNkKdvBHOUqrPzmestAFHK+QO/cyNqx6cmu2jIlmpc//yPm9JuHUo4o5lSBQxWRygBvlOwsZ5NAmIbuxPmIcHac/W+MuE6WEJJDqTNDaw9Kt/OVObq9o6tvEkVbn53w8HHnzUklmlSluTNdhD0BHFYCp8BYraSX89h/zHlsO8rxpS1sYH+L1J5zt+CtKjc+Xi8PjGowKUVTq9RpBX48rKZyigH9wXTrvYvkW8w6xjKxKkGuYvMT00wOb4LOe/UfkxmZbTiUMd7gB9Pv0zyR0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q+CNzYzvfo2eA98EfLT1Hje68s+9E+eicHVldSOG+8=;
 b=gpLnj0NEQmWBS+dtBY57NxRjhBoqPsyD7wWGWvocps1a8Qr1S5o57b1pxH0JRbaMFKKdIqu+ARFcG8V6hI6MVYkPO3x+oeVIAvglJoiRYdppRlp19NgueEiTM1hI0DwcgD6azLhvYd+c/VQVKMPm1HZHjx+kNQO1G8gomau1L7aEzqd85aw5CrL48brAWI2gt6XpkCXAxZ0HDZ29uEVyW355dzk6FFCeD7TJmVh4QwKaHlS16BHEAf1SQyBuciZ5DikXWzXNgdmqqiZviqnrR9UwDWncztHN7yjvYGA731MPGLVD/FrvU6EylHOqvV81k/2uvKORJREsanPJw1hLXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VE1PR04MB7360.eurprd04.prod.outlook.com (2603:10a6:800:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Sat, 21 Mar
 2026 01:14:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9723.018; Sat, 21 Mar 2026
 01:14:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy-next 1/3] phy: lynx-28g: use timeouts when waiting for lane halt and reset
Date: Sat, 21 Mar 2026 03:14:49 +0200
Message-Id: <20260321011451.1557091-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
References: <20260321011451.1557091-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0055.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::35) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VE1PR04MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b242dd2-79d7-4ad6-cf1c-08de86e73a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|10070799003|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	8XfpEAtoLQ/HQYNDdRp3YgjKkiKqRufGeh3jerlVfY6JcpJXAG9783Ia3Y4671PBMggp0QWnqmysA2+p3rPsfhZTL2B7jVUC06pY4UToPBfXiuGN5p59gX7Z5TEos+TCXGgpYLXQqvnnfIP2/Jw5OZCsm3/j6Spz0UTMmFdSz57K6ugyevk/yif21ROBXpTFeDJSYSOVLGUwg8w6jS9gaUe4Zekg6B9QHF6+JTWjFO/rX+7MV54jeyUt6V13rO5gkSHAA5tT7ph82DT3b1InuukZTVhCTvTFpdfrxU2QZO3LpAKJ97ekpwFf6nUv6+ZEwzMN5s9WDhGCeN+ycopJrKdnTJejeN+HrtPnLob5F7fHdNycNQFDmrAFP1xqHXj4cPPVGpDxdyXCFc7ff4PxXlEk2QBkbtobF/26BoO5TaZvm1j8zzHNSZcduKhfVNkFcDByVCRqJa8OXinLVUscQawm1/HTn5JTcfUJzYpX5zVigNCxgDScNHQx/oWgekGQmOh1fsdoHKd3+GxNkUP/GzHqthgqoS5DKYJ6rcbOTm1AXpjTAqblRgkDKBMJIX/GAKQc+OxT4ra6+Chh8SssfSlceR4kuv5UUIIjCxx91NdWjCSDaih3Oy59jTnpuCP4MC9gs4USuNKZmGX+ofRTMxR65CKo4kL8+sc/VKgxNVPcGUHGkGLVlBzZzM1/mFrd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(10070799003)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/VDfxjnuUiXESJ1R+Jln9lG0JdxtkjOqOZ+k0Uya4e7zkkYa+rFpjSMSFVBm?=
 =?us-ascii?Q?t9H1rR78dzXEwqGE6cCA5Jlxi618f03v9KX/A+qDtninNw7vgRukJSuuI37c?=
 =?us-ascii?Q?b7rgHQTZi5hzkPSYVt6T43uUzs88s12veZwS98UCael2rlLgSwEQ1jGRjA1H?=
 =?us-ascii?Q?l+MXUaW06HSaMP32LIiSu/JvAPZgxwKAqif+gYg5bDz0sTgOQGNiKzEYLjz/?=
 =?us-ascii?Q?1Pq+SzJVFJcyAev0L5wCuHdR3F/e+gmd2c2UTRIOH52a2Vy0F0slLd6h7WCs?=
 =?us-ascii?Q?q0CD42HI/x1bzIJA0GhEa7rYeTi3x+G+axT9pxbIxESImIqt29zKdPITkdWZ?=
 =?us-ascii?Q?DmwtOiO6lSTrTweW+lKyuuan0vAnm07ADAFu5POWm3Uck0xeGot6mCttSVxm?=
 =?us-ascii?Q?/cBd/tvY/z1LH456ISrGJxR8C8mDOhTohJLdkzChu/NyKj/Vv9zZALWpr8nQ?=
 =?us-ascii?Q?u+FGK2TX3FXGScvIoSzwUTRtnRsQIDh9IiCVfhGFloFaWTMKOqyNBqnWA2g0?=
 =?us-ascii?Q?lNNBFfi7oiu6AkRnotzmQH2ibXgElszt91LDh4QdnJoIfmp33zfswTzwOSKs?=
 =?us-ascii?Q?djvlRDyx1Gm8VoYvgYl9VDh63VgoUAD7qrhDRs908kra6hW+luvHTo44h5Kk?=
 =?us-ascii?Q?bR1zpdRtAXP8bsg7pOyYZ/ba4ljfgMucReILaFHkspN1EOAuidCrgtf4Jlak?=
 =?us-ascii?Q?Uv4QWMa95wULH207v0Qk8bdnSkQ657bxA00aCQVK0N7MEYmvFo6DvkU5hojZ?=
 =?us-ascii?Q?pSdFHnEPpCLoIhz4myRzWD+aQz8hxpIhtFcck3TYC+WsFpHIDNNiCRaQIBSn?=
 =?us-ascii?Q?NHvtL6cRt+It3TJdWIJvfXyAWVGoKWcWIrpZ3tohk0/ADSbNJrkimWvhHCZt?=
 =?us-ascii?Q?EP/GWV/mcO+HETEi+OGlobesvpLAzCtWs04gFjV2Ak70M/6M0/3wA/S2KwEo?=
 =?us-ascii?Q?zm/PmanNqnUHlyfKg/MealMaYKeNLjRGcDzVhuBGw1c1DNkzGMQpwgBmQSwh?=
 =?us-ascii?Q?J+1UY+dSi7faPRSdZ0xxuGsjJ71cy8WbT75Vwts898bCfb5u44vzvJSi/Wne?=
 =?us-ascii?Q?Aoa5aV/OtrcobtohMn2JwSGGSYjurqIi1gm/qEastzyQKN6xlEB5w0LBRygz?=
 =?us-ascii?Q?klbTnU+QDIy+F/Xa769wjYIKiNkF9Rnjjl4u5imXvIBaA1bOouIlwGlMjl6+?=
 =?us-ascii?Q?neY2gELYOdJmp4rbdzym/PthF/9kH4TBam4f9ggQlAf0+rPL7iOFha2rq7HW?=
 =?us-ascii?Q?M3TyRy2A3vcbOvhrxRatmUOkTFm5ly0lqJ0g/xsjvfH2OMFg6BsYStGoFyFQ?=
 =?us-ascii?Q?/nofrzMvpCm3+i6p5eZYPBQvmHgeHzLxCOEMF/mxy0nRwuY5Gp/qcyclLMJK?=
 =?us-ascii?Q?bNPkVHzomOGteK+beeR/EZ8wVlcUsUjfz2J09Ynn65rUYc9eY+iZgHzMBtDt?=
 =?us-ascii?Q?iXJS1LGmk0aok67My1pOs8fhc5w9uv9W+gV61k0zpSJDoIcavnCezYoJuiGC?=
 =?us-ascii?Q?k3S0ZkvUcTI41LY0ZD4v38v/vXwXWkrDNbMghXM0E85CDazoePacNb+j1tgL?=
 =?us-ascii?Q?3hKtnOOuJ2Y2XyKCZb23fR3D1plsFdji4LBEmH7XkmWXFS7ZPjxZY8Q92Agh?=
 =?us-ascii?Q?j/khNsK5D0JK8A+xpt+nNqW8GwKZGm9JnWRT4Y3J7OHS7gibdAGg7Nto0JWX?=
 =?us-ascii?Q?aL6lw0BUP4Z+i5upymoGl5Qhsx2V0qenW8+9soL0hDXHF77SwBEJfhLtpquR?=
 =?us-ascii?Q?VybGQIggXC6m4Tszaga6LYH1MR7R6Q5f7aCT/cidQ9BD0iIEpMD2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b242dd2-79d7-4ad6-cf1c-08de86e73a18
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 01:14:40.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86qKwuiQH98hKt3REfDrGJzamBIDM3dO7MzW06VS0ns2hekBi2QYgLm6R5UZX2VaLTyK009tggXUdHk8FI30zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7360
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270134-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,nxp.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0481B2E2BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are various circumstances in which a lane halt, or a lane reset,
will fail to complete. If this happens, it will hang the kernel, which
only implements a busy loop with no timeout.

The circumstances in which this will happen are all bugs in nature:
- if we try to power off a powered off lane
- if we try to power off a lane that uses a PLL locked onto the wrong
  refclk frequency (wrong RCW, but SoC boots anyway)

Actually, unbounded loops in the kernel are a bad practice, so let's use
read_poll_timeout() with a custom function that reads both LNaTRSTCTL
(lane transmit control register) and LNaRRSTCTL (lane receive control
register) and returns true when the request is done in both directions.

The HLT_REQ bit has to clear, whereas the RST_DONE bit has to get set.

Any time such an error happens, it is catastrophic and there is no point
in trying to propagate it to our callers:
- if lynx_28g_set_mode() -> lynx_28g_power_on() times out, we have
  already reconfigured the lane, but returning an error would tell the
  caller that we didn't
- if lynx_28g_power_off() times out, again not much for the consumer to
  do to help get out of this situation - the phy_power_off() call is
  probably made from a context that the consumer can't cancel, or it is
  making it to return to a known state from a previous failure.

So just print an error if timeouts happen and let the driver control
flow continue. The entire point is just to not let the kernel freeze.

Suggested-by: Josua Mayer <josua@solid-run.com>
Link: https://lore.kernel.org/lkml/d0c8bbf8-a0c5-469f-a148-de2235948c0f@solid-run.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Previously submitted as part of larger set:
https://lore.kernel.org/linux-phy/20260114152111.625350-7-vladimir.oltean@nxp.com/

Changes:
- Stop propagating the read_poll_timeout() errors to callers
- Adjust commit message to explain that decision
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 72 ++++++++++++++++++------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 2b0fd95ba62f..3debf4131e0f 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -249,6 +249,12 @@
 
 #define CR(x)					((x) * 4)
 
+#define LYNX_28G_LANE_HALT_SLEEP_US		100
+#define LYNX_28G_LANE_HALT_TIMEOUT_US		1000000
+
+#define LYNX_28G_LANE_RESET_SLEEP_US		100
+#define LYNX_28G_LANE_RESET_TIMEOUT_US		1000000
+
 enum lynx_28g_eq_type {
 	EQ_TYPE_NO_EQ = 0,
 	EQ_TYPE_2TAP = 1,
@@ -600,10 +606,29 @@ static void lynx_28g_lane_set_pll(struct lynx_28g_lane *lane,
 	}
 }
 
+static bool lynx_28g_lane_halt_done(struct lynx_28g_lane *lane)
+{
+	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+	u32 rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+
+	return !(trstctl & LNaTRSTCTL_HLT_REQ) &&
+	       !(rrstctl & LNaRRSTCTL_HLT_REQ);
+}
+
+static bool lynx_28g_lane_reset_done(struct lynx_28g_lane *lane)
+{
+	u32 trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
+	u32 rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
+
+	return (trstctl & LNaTRSTCTL_RST_DONE) &&
+	       (rrstctl & LNaRRSTCTL_RST_DONE);
+}
+
 static int lynx_28g_power_off(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	u32 trstctl, rrstctl;
+	bool done;
+	int err;
 
 	if (!lane->powered_up)
 		return 0;
@@ -615,11 +640,14 @@ static int lynx_28g_power_off(struct phy *phy)
 			  LNaRRSTCTL_HLT_REQ);
 
 	/* Wait until the halting process is complete */
-	do {
-		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
-		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while ((trstctl & LNaTRSTCTL_HLT_REQ) ||
-		 (rrstctl & LNaRRSTCTL_HLT_REQ));
+	err = read_poll_timeout(lynx_28g_lane_halt_done, done, done,
+				LYNX_28G_LANE_HALT_SLEEP_US,
+				LYNX_28G_LANE_HALT_TIMEOUT_US,
+				false, lane);
+	if (err) {
+		dev_err(&phy->dev, "Lane %c halt failed: %pe\n",
+			'A' + lane->id, ERR_PTR(err));
+	}
 
 	lane->powered_up = false;
 
@@ -629,7 +657,8 @@ static int lynx_28g_power_off(struct phy *phy)
 static int lynx_28g_power_on(struct phy *phy)
 {
 	struct lynx_28g_lane *lane = phy_get_drvdata(phy);
-	u32 trstctl, rrstctl;
+	bool done;
+	int err;
 
 	if (lane->powered_up)
 		return 0;
@@ -641,11 +670,14 @@ static int lynx_28g_power_on(struct phy *phy)
 			  LNaRRSTCTL_RST_REQ);
 
 	/* Wait until the reset sequence is completed */
-	do {
-		trstctl = lynx_28g_lane_read(lane, LNaTRSTCTL);
-		rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-	} while (!(trstctl & LNaTRSTCTL_RST_DONE) ||
-		 !(rrstctl & LNaRRSTCTL_RST_DONE));
+	err = read_poll_timeout(lynx_28g_lane_reset_done, done, done,
+				LYNX_28G_LANE_RESET_SLEEP_US,
+				LYNX_28G_LANE_RESET_TIMEOUT_US,
+				false, lane);
+	if (err) {
+		dev_err(&phy->dev, "Lane %c reset failed: %pe\n",
+			'A' + lane->id, ERR_PTR(err));
+	}
 
 	lane->powered_up = true;
 
@@ -1065,7 +1097,7 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 	struct lynx_28g_priv *priv = work_to_lynx(work);
 	struct lynx_28g_lane *lane;
 	u32 rrstctl;
-	int i;
+	int err, i;
 
 	for (i = 0; i < LYNX_28G_NUM_LANE; i++) {
 		lane = &priv->lane[i];
@@ -1081,9 +1113,17 @@ static void lynx_28g_cdr_lock_check(struct work_struct *work)
 		if (!(rrstctl & LNaRRSTCTL_CDR_LOCK)) {
 			lynx_28g_lane_rmw(lane, LNaRRSTCTL, LNaRRSTCTL_RST_REQ,
 					  LNaRRSTCTL_RST_REQ);
-			do {
-				rrstctl = lynx_28g_lane_read(lane, LNaRRSTCTL);
-			} while (!(rrstctl & LNaRRSTCTL_RST_DONE));
+
+			err = read_poll_timeout(lynx_28g_lane_read, rrstctl,
+						!!(rrstctl & LNaRRSTCTL_RST_DONE),
+						LYNX_28G_LANE_RESET_SLEEP_US,
+						LYNX_28G_LANE_RESET_TIMEOUT_US,
+						false, lane, LNaRRSTCTL);
+			if (err) {
+				dev_warn_once(&lane->phy->dev,
+					      "Lane %c receiver reset failed: %pe\n",
+					      'A' + lane->id, ERR_PTR(err));
+			}
 		}
 
 		mutex_unlock(&lane->phy->mutex);
-- 
2.34.1


