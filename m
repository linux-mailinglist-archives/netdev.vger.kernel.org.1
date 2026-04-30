Return-Path: <netdev+bounces-282618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SITVF5/D8mk9uAEAu9opvQ
	(envelope-from <netdev+bounces-282618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:51:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E349C891
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B08C308BF73
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02FA32ED54;
	Thu, 30 Apr 2026 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIU7PIXJ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB232E728;
	Thu, 30 Apr 2026 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517284; cv=fail; b=ex0nm0sCiaHw6ukd0Mogu4ksRHNv4qDvY1pNZn3gWw0W7O82Dv5haUajX0fPq/g4oRGlsARR8WHfAnCZn7uV119Zdw5mxYvaH1ajpgh7xOGQVl5JPmIdh7fbmrs5+qGuxrQv7G7ZKuYNDp4TLB/GBDHDskUGRAqJu8R6qjYadGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517284; c=relaxed/simple;
	bh=T9FUOLT9qXxvx+lIjq9jvzMRiE7bGjmoAf/FbH8TK54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XofqlZyENNfgfcWCPz2P1K1V4/viZdT5b8+dSrAsjW5m6Fbedse/+ABKHqywoCuT8BvpBmHC8GJKY4rhyqP4BbCF0YY8f1IEaD5sy/Nq5RkaP3OCD1kz6fCF39z7rGF2/2XhxmRVC++LH9YCMg6CeuUTcAa0ooG5h8eES++J/rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GIU7PIXJ; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gImuSuXRDlQ3PRKNa17349gUFHIyUOIbBMzXQ0JnWsnLbVbopk36bXyZmh7mo0OA5te6G++LTU1pNsQ3Sp2W3GMvmDLeZ3406qi+trHAQUMJPG06oa2/x8XK1P1VNvJs8oe+xfrJrRDC4Zz3UGZ2FWFekP8nFvC+XR6hsaTILfpbaIQXXuQpeBABW8bBro15g6RZoS/nHNLDTNvL/CFO9KSdWcQsbfXtL6V4Xw+nmPAGuTFVjfAmZFhVlrS/EuFTJbE/mwerEHD2Id+BEVRxf00Kqj/S3GzPuJgsbjyby5BMkhsTgVPYmF3kHnqk/2HVA+/AfwPLxcy1vGLIEy1TMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGyWMr34sOmRve9pQaB1i48erLlrlhLvlyJNA9dS0ok=;
 b=J4kW2bOXsYGgbVWcEVWC47eB/qch2klwqYf1d3KrhA0eAGRRi/WmvC5bUYRc4a7w8d2sRLa4SQw6IhaAPL90BfXCtG4A7QUo9j3y3AVwZL2jCdjricQXCnLmgZuaNhGeWQPRV5qzFFisTM3IN0j1VQ8xCKx05yJIqrBJadoZO+gLo48KZAdKhU5s0eoVhFkkOva4j881rQtn3VnteeAZNLg23gKjSoiPiw8TVzep0JAX69T5oSqHqy88DqFB+eDPKc7da1uB7J3E3dRVm5eL5dL5dG9LdPZISM6ido11ju0uonE+hIGSTJwbQn24wk3W9rn82w9cLls2IeR99y4Kxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGyWMr34sOmRve9pQaB1i48erLlrlhLvlyJNA9dS0ok=;
 b=GIU7PIXJy6a+4sHb5cqGUpWRnMUADfeyhOpUTrKJjOd7SGCv5nlNZcAgwesRId4cQfiNGfE7RdOcu+1gpW6yD5SzvuPgraOU2WEluIn1rgEveonx71jSG83rgmoSJFrFnspJ4+s+pdFgg68GIGS/YJsRKrupc5JBftGjXsvfKlr6Qpq/v/3c+Z0A8iDhIPEEdkMAISS8c21IPdUcmP74rC0n7+MBw3Rlig3Ov6Yu9NlbCSuVG4ZBWkChF8J8K3NkTxCnARXtgbi26pcCFCE4kCzSb8S4q7WaW0gs3XbO/iR1X+C+J++fps7SWOz8AgjLgjccbr5oBPaXSVSjz3YeIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PAXPR04MB8608.eurprd04.prod.outlook.com (2603:10a6:102:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 02:48:00 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:48:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 05/15] net: enetc: add support for the "Add" operation to VLAN filter table
Date: Thu, 30 Apr 2026 10:49:35 +0800
Message-Id: <20260430024945.3413973-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430024945.3413973-1-wei.fang@nxp.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PAXPR04MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d6b146-98f9-4ca7-889e-08dea662e44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FyAqWtcjKU7jzLRSB7SHlDFtoSs43dcP0Uw+nCJbEAgArMXJaGYhPy2IFuQoqhcdqNwgGDGOZ4t2V6CSutW7YkejncRCMHXqW23Web7D+U1aVjD+Z5yHj4pbMT935ehOgy/RgYIIdOWyYPP4/9vnpE8PstlbM7Y7NxKRqAy2k/2dcQqYQPJVbhVLeL+PWkE9rJ9H1IO686BwE1V7QcAgnga0VVyomwYo9rm1ODwcH/Q3RgPilrdGg93UGMrS4pI69FLN3D3Lc775kIXRDBWPHkh8729dBQUtfrPyhB987ROV9U7luYvHgykzQPiwjqxhDDtF5oEnKWffdPiB1I9QQYp1sRepN+pp14em214MKFvUlJ4DYTlIJhyzvgrjubyRzNNaUkxfhkDbMCmI9XkU9tbkjr4PInHM9L1+zxNuUy1K5dpwM0FP8v1spz6QfawQk51+zQHBs6kuVjNbCIZQWD/7a6oGcIbt1lB6/Z+EvnF3nbhMPJz9YOipYKrgRF+Out0Adw/uFfBRwMSARvhJWd+BTkCOepZhU8wOVn92va9Jr9UlzYcmKoSgYzmD5uBId+LSXG1zAqGDaFnnTmrqhTiPe/fFiDoXi0u/ZmCwXs+dBRTjvuNtAIFjXBslsab81L5A4MULUMlzXMReBa0c4tMAFpnaBrYvbIHta//89bto/bISxWisCszyygyVD1NwjaLkwmwyBlg37Aon02SNvX03PdE09RkzKSNe2K1o/zoG2MSkBpHK+0ewos0JhU0nXXuCNq6SzisWcLH48WWpCkoI0Z6EMR2ImozvEohEbum/FwjcjiXJs8KTz+3J2GxR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FlhT6IrrBBUnxphvRWnRVd4RgUbD3qlK9SFmeeXBQYpDYOG31YnW4XcWmOID?=
 =?us-ascii?Q?mm9RLaYQSP6uN88J/Az9lRnvbEqfqWyrcjGaKhgwoAsbw+aNQZ8/h2IxgzF8?=
 =?us-ascii?Q?rR88fK7H+D/G4qqB1HRQR4Ddi8zv/PsQxcQDXSGYXTW1t43wNJRo7h84gAtn?=
 =?us-ascii?Q?HTHjXbBb9Y8dI43NBjXZVhrVqZKsJ/jh+wNAZXhaOCXogTmCfYtD4eXHDHiN?=
 =?us-ascii?Q?kbxQFoiOxkfWeiy5+Zlo8MGurvKdnhOx+l2ktBXthBIJZzY7QiSr8mW2hP/y?=
 =?us-ascii?Q?biUUUrU77GkeWqVO7Mgcyi0UfYT+ubNS/kDSzu0Imxf/w6DC6hZIFMGA5Odj?=
 =?us-ascii?Q?gNBijS1f9ZjtHH0pSz1WxZDciKd+evyUCR5OjDj6RheSq7/aYAjT783pbrhw?=
 =?us-ascii?Q?Rz6HtxtFJlMF6UwlMNrCyADHjL1aJ/q6UflLfPwYjp0aZym9PQWyVqEkvrHt?=
 =?us-ascii?Q?btP9KoRH5qRPWKHfwC/BiiwNlPDP3vPOGGK14wyNVDpq9RrVcx4593da7Nph?=
 =?us-ascii?Q?1P34TtJ/lQo9V6rc+/GFpbsLlnX1LBWG/TKJ8Gk2kbAJ+y0GWaLVHYtbYoWh?=
 =?us-ascii?Q?9QAMMa0O7RCS+ayxtqNqdi4CDVyEWY4Tuoxg1GE/+X9Ylpb1uUaaUGxRsBpo?=
 =?us-ascii?Q?lNKW7LsVlZauRpZct7wvyGSkp+q54BlRkWTiv2dnDcMJIhqxLERUiM3DAb7B?=
 =?us-ascii?Q?mpT2o9BWaRYcfAIlHAdf8Aiy1lBz5vnynuzxF0x1xlkdpX9UoBekTYFm0otF?=
 =?us-ascii?Q?3eV8DP65UPp70VtKr3YVN2xVwFIS9qAiQU3IVpWIrHpteUq9R8SJ2s4kQqcz?=
 =?us-ascii?Q?7fXKoKu+BerO8c+mBx6UcQ/Oz2Htqof94hgcXDFeP4qgz5WV0LGYXWvf5v82?=
 =?us-ascii?Q?70dBlp9AT2zrHunqnh4fSAxBaUH9CGL//qIQ53ocn4NFlmYnIiQXPGcPv5n0?=
 =?us-ascii?Q?HfLbviUrhnnOqfmskxI+dcsVTvgyU9Xl8aXhDLuzKqowQlPqgeRccUnqB7KB?=
 =?us-ascii?Q?pRnBlRluyTTVO4O/7bQpI5+0X131JkpdZgWEIIiS6cEy+CNZ36FxbjxPLpiy?=
 =?us-ascii?Q?Eu2Ce1z8Puhu1ildlWxplShkDG4Y1bJhrrZk03TMwB4suU2bYRO0R92Wwva0?=
 =?us-ascii?Q?0twCAD/pvZ1rY2KOnBBVg4P1Z0pc+uks00B92fhRFwdfVVqEE0U1pGnYdpIb?=
 =?us-ascii?Q?7P6CLXuH8gdACeoU5GSAvh66M37wwpTNq/iXfKo/qBynbdWqpX7EuDPX4I8a?=
 =?us-ascii?Q?aAapKCsDh18i5hvfyiaKkEJaP8Tlt16mVsAxWGJWHjZkPwS0c81JVkh1CneJ?=
 =?us-ascii?Q?Hpl4iyBgIq7LH3n5mnKdwE5pfwmiVqKhbJdRI8FExzqzXPp7C5S/ur+Ff5wI?=
 =?us-ascii?Q?V2Ks68M7siUOFd/xHRPHip/Hxbc+OUmW3TGevNO0WcPQhMJqyxUj2iffjOnx?=
 =?us-ascii?Q?bAvQR9AC8IB1wesLOSIAGAKXhn1q0dUtqNoqVv6fYw1aqk/IS5FOtwB5iY1W?=
 =?us-ascii?Q?zvihOzox+iIlgeZpkWNQH668L8AhikhHu7L6lzvsQ6d+i0ICG393nCDRiqt9?=
 =?us-ascii?Q?ezB9pbmxAVcc7WcVmshuYFuppNuqrkjlXZDMszlA4ZA5LzfiOxV52E4Jbpy5?=
 =?us-ascii?Q?ygryDdZTd+SQGu84icXn11p0aXWR3FjY99gDQZV5c6fP6EuAdI0WqVQLZKsC?=
 =?us-ascii?Q?E3xj9u/FXkhJ/No8z01Fo+VPh6jk2JhkP/SlBMgIA/IckubU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d6b146-98f9-4ca7-889e-08dea662e44c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:48:00.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boBsqXUt4sTBn/VcVCfFzSb9RRwp0BKeFGCCPSjQOZWCyfGpCblBkkBEB25nbg6hpbeZHyVeKAAUAzR4zVubqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8608
X-Rspamd-Queue-Id: D63E349C891
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-282618-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

The VLAN filter table contains configuration and control information for
each VLAN configured on the switch. Each VLAN entry includes the VLAN
port membership, which FID to use in the FDB lookup, which spanning tree
group to use, the egress frame modification actions to apply to a frame
exiting form this VLAN, and various configuration and control parameters
for this VLAN.

The VLAN filter table can only be managed by the command BD ring using
table management protocol version 2.0. The table supports Add, Delete,
Update and Query operations. And the table supports 3 access methods:
Entry ID, Exact Match Key Element and Search. But currently we only add
the ntmp_vft_add_entry() helper to support the upcoming switch driver to
add an entry to the VLAN filter table. Other interfaces will be added in
the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp.c   | 50 +++++++++++++++++++
 .../ethernet/freescale/enetc/ntmp_private.h   | 19 +++++++
 include/linux/fsl/ntmp.h                      | 24 +++++++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
index 4ed8d783a9a2..31e8945de6cb 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp.c
+++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
@@ -22,6 +22,7 @@
 #define NTMP_MAFT_ID			1
 #define NTMP_RSST_ID			3
 #define NTMP_FDBT_ID			15
+#define NTMP_VFT_ID			18
 
 /* Generic Update Actions for most tables */
 #define NTMP_GEN_UA_CFGEU		BIT(0)
@@ -266,6 +267,8 @@ static const char *ntmp_table_name(int tbl_id)
 		return "RSS Table";
 	case NTMP_FDBT_ID:
 		return "FDB Table";
+	case NTMP_VFT_ID:
+		return "VLAN Filter Table";
 	default:
 		return "Unknown Table";
 	}
@@ -697,5 +700,52 @@ int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 }
 EXPORT_SYMBOL_GPL(ntmp_fdbt_search_port_entry);
 
+/**
+ * ntmp_vft_add_entry - add an entry into the VLAN filter table
+ * @user: target ntmp_user struct
+ * @vid: VLAN ID
+ * @cfge: configuration element data
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge)
+{
+	struct netc_swcbd swcbd;
+	struct vft_req_ua *req;
+	struct netc_cbdr *cbdr;
+	union netc_cbd cbd;
+	u32 len;
+	int err;
+
+	swcbd.size = sizeof(*req);
+	err = ntmp_alloc_data_mem(user->dev, &swcbd, (void **)&req);
+	if (err)
+		return err;
+
+	/* Request data */
+	ntmp_fill_crd(&req->crd, user->tbl.vft_ver, 0,
+		      NTMP_GEN_UA_CFGEU);
+	req->ak.exact.vid = cpu_to_le16(vid);
+	req->cfge = *cfge;
+
+	/* Request header */
+	len = NTMP_LEN(swcbd.size, NTMP_STATUS_RESP_LEN);
+	ntmp_fill_request_hdr(&cbd, swcbd.dma, len, NTMP_VFT_ID,
+			      NTMP_CMD_ADD, NTMP_AM_EXACT_KEY);
+
+	ntmp_select_and_lock_cbdr(user, &cbdr);
+	err = netc_xmit_ntmp_cmd(cbdr, &cbd, &swcbd);
+	if (err)
+		dev_err(user->dev,
+			"Failed to add %s entry, vid: %u, err: %pe\n",
+			ntmp_table_name(NTMP_VFT_ID), vid, ERR_PTR(err));
+
+	ntmp_unlock_cbdr(cbdr);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(ntmp_vft_add_entry);
+
 MODULE_DESCRIPTION("NXP NETC Library");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index b0b5805ac4f6..575ee783be47 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -156,4 +156,23 @@ struct fdbt_resp_query {
 	u8 resv[3];
 };
 
+/* Access Key Format of VLAN Filter Table */
+struct vft_ak_exact {
+	__le16 vid; /* bit0~11: VLAN ID, other bits are reserved */
+	__le16 resv;
+};
+
+union vft_access_key {
+	__le32 entry_id; /* entry_id match */
+	struct vft_ak_exact exact;
+	__le32 resume_entry_id; /* search */
+};
+
+/* VLAN Filter Table Request Data Buffer Format of Update and Add actions */
+struct vft_req_ua {
+	struct ntmp_cmn_req_data crd;
+	union vft_access_key ak;
+	struct vft_cfge_data cfge;
+};
+
 #endif
diff --git a/include/linux/fsl/ntmp.h b/include/linux/fsl/ntmp.h
index 4cfff835954e..3672e0dc7726 100644
--- a/include/linux/fsl/ntmp.h
+++ b/include/linux/fsl/ntmp.h
@@ -32,6 +32,7 @@ struct netc_tbl_vers {
 	u8 maft_ver;
 	u8 rsst_ver;
 	u8 fdbt_ver;
+	u8 vft_ver;
 };
 
 struct netc_swcbd {
@@ -101,6 +102,27 @@ struct fdbt_entry_data {
 #define FDBT_ACT_FLAG		BIT(7)
 };
 
+struct vft_cfge_data {
+	__le32 bitmap_stg;
+#define VFT_PORT_MEMBERSHIP	GENMASK(23, 0)
+#define VFT_STG_ID_MASK		GENMASK(27, 24)
+#define VFT_STG_ID(g)		FIELD_PREP(VFT_STG_ID_MASK, (g))
+	__le16 fid;
+#define VFT_FID			GENMASK(11, 0)
+	__le16 cfg;
+#define VFT_MLO			GENMASK(2, 0)
+#define VFT_MFO			GENMASK(4, 3)
+#define VFT_IPMFE		BIT(6)
+#define VFT_IPMFLE		BIT(7)
+#define VFT_PGA			BIT(8)
+#define VFT_SFDA		BIT(10)
+#define VFT_OSFDA		BIT(11)
+#define VFT_FDBAFSS		BIT(12)
+	__le32 eta_port_bitmap;
+#define VFT_ETA_PORT_BITMAP	GENMASK(23, 0)
+	__le32 et_eid;
+};
+
 #if IS_ENABLED(CONFIG_NXP_NETC_LIB)
 int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 		   const struct netc_cbdr_regs *regs);
@@ -125,6 +147,8 @@ int ntmp_fdbt_delete_entry(struct ntmp_user *user, u32 entry_id);
 int ntmp_fdbt_search_port_entry(struct ntmp_user *user, int port,
 				u32 *resume_entry_id,
 				struct fdbt_entry_data *entry);
+int ntmp_vft_add_entry(struct ntmp_user *user, u16 vid,
+		       const struct vft_cfge_data *cfge);
 #else
 static inline int ntmp_init_cbdr(struct netc_cbdr *cbdr, struct device *dev,
 				 const struct netc_cbdr_regs *regs)
-- 
2.34.1


