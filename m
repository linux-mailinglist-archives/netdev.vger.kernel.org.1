Return-Path: <netdev+bounces-286516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGJMM7qVAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:39:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA3B50A366
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA5D6300AB2C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC89E3B8BDB;
	Mon, 11 May 2026 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jIf5Vrlm"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713893B8920;
	Mon, 11 May 2026 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488494; cv=fail; b=qGC0cuAPGTe5D6CGx+ahbaFeNYzoL6d9svjFeqcyN2+3Ngw4PG1xhJ/CfubBft0vQ11b3pL/g0UZ19/V92IeYEa+7Ew4RA7o1G59CJIis4lUi+8xnR5AqY0livMV3HwkhFJkmzP/djcse8psQLokEjMG5cYKb1m8Xm/87OJ3CP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488494; c=relaxed/simple;
	bh=7CtqWS6FBgA2XHlUsZyAArUK1eD5kFJArPy7WtFdxU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q8nTmiABIJo0H9gZCJyAZW5qm16es5BNHoXSHfgJmpAgxwwFUD4tvkWknskJDXNeefHY8jBAUSDYnxbrhvQcFOmy2Psk32VfrvIwKNTFBaPkqjeRQfcGVgvBAgf1IoKq4KNeKqZhz2v+2rDTCFwD8TduC9g8yq3z/a73QULv49Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jIf5Vrlm; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVAN+3H0rIOveE9EOIJJ7wbRTqLjO7AcfF0K9leNXNsNyMmMcfh4bTnCAM9NhodU1KflD+5D+uKqysgV/PG67WwqGSXDgIvcCsVB7NFSciCrH0/cowMhmbY5yb6Pw+0RrR8i1EsiUNaQRvkOKN4CU5Iyc/LTHf2ev9z/7gmnAjxV1bm4v/YqsECx8tWVibsLuKPyxe8SrMSDx2aUu9v1ZNx2J4v7YLrN3twxIbgGU5DXg1ZYE5i64joDi3BVDRpnoXFXnGKHhbnny3sc+Cu8nqVhjTVAP25Q7djLFCxx/A8UU8uOfQRmOl0aLHrSE9kWKQIdN+rkqt2ussnN8ECyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xboyFKga4dxWYTz1egBwZXtcGP/iDHIDYqpV9hxGqjs=;
 b=dTddcTnf1e/8M4GNqaxOPuQ8EQ4Yw880Gu+2JWDcYXUcE+ltAU5/ZR3qESeuUN7XD+4aTA8Au5fR2BcnUDpX5qVH1VApn9ehucOESnyI1/Jx9TY2WaobZ48s4JxgZ7gVxUA4ZbsMfDzrklwraN8/aPWYkcpBr/h5brWpVJPBYOrDuxwLgR/IIxdj1xAmMswcjx30o7I/TyROFydIHWyTdoIsIRjOjuCVrIMuz0RYSjJu9Rhm0E/Ota63AlsyzdFny5mPAYYGCB9xrXZ1sNSZk2ceb7nh7Vp1wr7SdE/fXn1puMxWu/0zPoWlHydinm3JDZ+e1Q1lRhxCD9GIVGD0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xboyFKga4dxWYTz1egBwZXtcGP/iDHIDYqpV9hxGqjs=;
 b=jIf5Vrlm/PJZg0TNR2cneBUsw6/l/7DvsQtATe/JOfSgmbvLp2EK/HBwzWEAFYyoX839b7839Jm4j4CwBEr9MXPFte7MlMiq5BuC6QjLGS8wjVhapWYkQ+XL9UQ0Vh37oUwnmlsTIl81o9enTzGH9gpZjT81pa4TdQNyV0mSejeIr3E1FFUuNQeHSeqS1DteWLuIe/eetHDzAYn/Qu0buAEUbqUfSDKRSpcRH175sIJM2MN9WhTiQDlfWvmoEIB8vT6NNxnnus7JZ46O2CBmaHky217L0RvBDOHvbYELYsvAWkVf0gETIq185O1HHwHqSXYklBy7V97G2/bVs+BjvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by PAWPR04MB10055.eurprd04.prod.outlook.com (2603:10a6:102:380::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:34:42 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:34:42 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/15] net: enetc: switch VF primary MAC setter to PF ops for commonization
Date: Mon, 11 May 2026 16:07:51 +0800
Message-Id: <20260511080805.2052495-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511080805.2052495-1-wei.fang@nxp.com>
References: <20260511080805.2052495-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0114.apcprd02.prod.outlook.com
 (2603:1096:4:92::30) To PA4PR04MB7502.eurprd04.prod.outlook.com
 (2603:10a6:102:ef::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|PAWPR04MB10055:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1ef49e-aa58-40e4-83d4-08deaf382577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014|3023799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lGOOj2retCvHvCAi5tWp4bFTGmUeXOVUbw9Q61jvuT1mc5NRW04NP2dGnA0bvG4mVol28aG9v6T5/ddQK4GO/F3PiIjVHXJpQDg/T+BgCGgaLp35YhVuAd05rCZZ4pXCkJg43gNW1CeSd3bZM2poyNU0Nm7oT/NWn3e0WYt5OVW5psPR8M7sv5OiN3Hl9WkyQkGVhmD/QElykpjZA0niewXBTShYVTzO8m2fte4a83nkYSMeqry/m0jj7iCjsxcBoIvpqMYyR6wrjKpimk1F7N11UEQPcVPNIJAz4ZtJVu3YbAFObOWqoVOh2o0MaDaSm24m0KKaGL30WI4RLa565cYbni/kucGhJWs00pMZouw68eezjhRb2dV5oUAs/Kvd78PU/6s6nKxJ1AJvNI07X9DOaPIEHNSxSSe9HupfMKqwfACw0x/0RzD5CXk9nRBFvIn1lA3fjJtvYTEXcP0xVqhxQKx1xS3egwHZYO5ayvn95JbGznYZBh2ZZzrheY8MrDzGoseXCWklbaJRTysg7Bl2WCv90dtl7i1qI7WdF03/gmZ3Msv+g202+YwCTtaBym9oFLjmhodKta2K6snT44wCCzyNcuK9k3hbf+4J3leHntBZ6+K66rEP0ZigIIz1OqKq8FRrGlJMd3/J/wDaGgAAgwsXJye/xAsD8T+1KnonNEjqiirV1U2cyAKbJWxX1fPHzZKwpIxVrdkUCS7TqR9wy5YN5Y+2p3aSEUDSjbwxk8nHuVWn8LHvRe8MXW6k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014)(3023799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1/synZN2IvBpamIJHOoOyDD53jblPGW53MKNL0TBGJ1vlzrYQF05ZWxPuFN0?=
 =?us-ascii?Q?iR/BRZv5U3SNZhKo3KFczdqJWaCb5PDOiDCeeKZDcU/FSJl/9aEoyrqUVvyn?=
 =?us-ascii?Q?ipN84ClcceiLkLZREENtrIC53YR8oLnsZyCrgKeJQZgL1y3EdJY4XLDVHRtK?=
 =?us-ascii?Q?lH4P9oHUWcYh5zL4fjWaUUGpOjpU2lB7E9KY5E4OpCD4ZuE7TYUqeOorCRtV?=
 =?us-ascii?Q?oXz46O5Cg+eDZp95T0v9751VQ402B5TdOnNqL/3UUabXjarTLUpm9+FwKcdT?=
 =?us-ascii?Q?ViREX0nC4jxlVFJE4HW/Fym+gN7dLb3n8Sl/xD+yZt2hc7fVT28MFg/IHnLs?=
 =?us-ascii?Q?JatLv1JXUm2VrUEkfnsEL+iwmJg7VZEjcdzsgpcGo5yLhxWphbsUjdCEI54o?=
 =?us-ascii?Q?vYbG+gpGxH0dvzChF+qe5zeewLulMUhi/FjubKKwjhZjjT9c6/ErRJY2lavk?=
 =?us-ascii?Q?RVbWDNE3zhh56RxA7MTx0TUsmCfvT9JTImcc0S5qGuIcotLfbwsjW0j2Tr25?=
 =?us-ascii?Q?NxbLG4x/RjuGJWitJK7BDrVlo6/fG/ukL3TkG/plbfQKBCykesFrAXqVab+G?=
 =?us-ascii?Q?VcQqNsXaFEg9JmvkSFphTl1g7YztRYUguPkAeTwqBAbsgG9J2ZofqcWu/Ur2?=
 =?us-ascii?Q?+h30IXvVHUBvMKq70M0mA3ubZvFtg8vJVy1F3CY3ujS6pYcDhlYwBfvdi+W9?=
 =?us-ascii?Q?o1/FQVmRFTFB6Y8PKa9foSd7gzg2FA0TJh+PIWkyVYvMZaKqmj161HN1Dzzu?=
 =?us-ascii?Q?PfJ8Bz0aKWP/aDL+V1C4OMSr6NpPz/tTd18tgiarZBv3bn2H3VSvkMM58fX6?=
 =?us-ascii?Q?m9IOUlRFk2IJ/fzqYtHmVI7z/2Duszxy91jZOT3JdcPSKLmjlIQaxZGjFUKU?=
 =?us-ascii?Q?WdH69cuQatp73fHy2n70IFyxnIuvTCT97c8L6Cn66e/kyaGxFMxuMhJhVr1K?=
 =?us-ascii?Q?HbBUt2l4dh/U15wjtoZf04DsoOzCIYNOX8GpwGkOY2MmDFea0zQYG3CvJrr0?=
 =?us-ascii?Q?rV3HJT6dwBfyfFl0LVqkUVhws+NzLrXJXj5DvQxqY6NgbSJZ1plimoXZA8UO?=
 =?us-ascii?Q?iOtyz/LurXoAVeOZEp12Z3ea5+omOAs+y8Rqtmutj8RRKsZaHiX6738xFnD6?=
 =?us-ascii?Q?R5iQDhEDfwlDi1JSfQE7auZDUgx8FFYclTYLNEPIh/wcDkoeuKGgU0EvJyjy?=
 =?us-ascii?Q?moxFyJl4u+eQ8WM9MogE3teHhkYhEOB17hUmZT+fkL8JKXcBa17iKTf5Q1LF?=
 =?us-ascii?Q?jeuYXp5UA0PXGS6jGuDQ3Qd2abLs2+a4fdXrw+omTCc8Qb6bUmG8jTN1O4lp?=
 =?us-ascii?Q?pvxo1Y5+gdZR5JGvztO7AoMnaAFVZif2wS9cRxij/ZrDXqXstCrX8R3wvKb1?=
 =?us-ascii?Q?DAWPdRT1TJHTuxO8+Hdu+qx6HfgIYiH5KWTRGJkV5proVc8RRX9yHICqG3/s?=
 =?us-ascii?Q?+7wJHzO8U+1NesksuZV6cWJkvgMNqaAsWC/BFJO3mlmUMcgGNYvpR2sVoPe0?=
 =?us-ascii?Q?h1ZVW71E+X9ntaJyKjwvY1R5V2zBeg/NYnddUgab1hIcFr5G/g1e0vMTtwiO?=
 =?us-ascii?Q?YYeW4B+FYiqJG+Ozkq5VlVX9nhPw956Yvq6sxhmcepJqEFHPyGhrtxBe6qgy?=
 =?us-ascii?Q?4JAxfeB26cx5Xi0mpN7KWuufRR6dOoePE2e4m0sweIsF0nTSaLsXzkGkE4t0?=
 =?us-ascii?Q?GHoBlFJ5+CXUSVF9/x0uSBet4OLd1XTDRHdMyqDN/oeybhBsCpTBXg7vxBYc?=
 =?us-ascii?Q?rLcP1wFZpQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1ef49e-aa58-40e4-83d4-08deaf382577
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:34:42.0350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ydw/ihfg/NjOP6KiON9dvXryYi6GiRAWCbd+06zsYb8Z1lAIe4REmsQG8RFXosdJWPRK+HksSMasKtHb+wAdgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10055
X-Rspamd-Queue-Id: 4AA3B50A366
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286516-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Use pf->ops->set_si_primary_mac() instead of direct call to
enetc_pf_set_primary_mac_addr() in preparation for moving
enetc_msg_pf_set_vf_primary_mac_addr() to enetc-pf-common.

This enables both ENETC v1 and v4 PF drivers to share the VF MAC
configuration interface. No functional change.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index a12fd54a475f..9063255d8ca5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -497,7 +497,7 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 		dev_warn(dev, "Attempt to override PF set mac addr for VF%d\n",
 			 vf_id);
 	else
-		enetc_pf_set_primary_mac_addr(&pf->si->hw, vf_id + 1, addr);
+		pf->ops->set_si_primary_mac(&pf->si->hw, vf_id + 1, addr);
 
 	return ENETC_MSG_CMD_STATUS_OK;
 }
-- 
2.34.1


