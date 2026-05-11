Return-Path: <netdev+bounces-286529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLRKCpSVAWqXfAEAu9opvQ
	(envelope-from <netdev+bounces-286529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:38:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C7C50A351
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A728A3011793
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137313C3BFA;
	Mon, 11 May 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iCsIfIHZ"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D53C1989;
	Mon, 11 May 2026 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488557; cv=fail; b=u/ZT5QPjUfoXDkcyC0S7XQcJksog1xOsIBP/ZrUa+DIBwL+9fLdT7SeE5vfF6oramqxW3gjk4MM3pnoiYU0DYBR7XFCHKuZ9ESSXQs6TXoVjblHldffHjNS2E+KM7eSFuv4VcodE9vbP02K0r+tV7iOWQgNFgJZqsnLyV0CvCys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488557; c=relaxed/simple;
	bh=i+7MVTEcCllR/uaIFApVXm9N6JnkEL4kLVWZyoMykEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bR+JyBbw5IHX+S5GUhUYZZfZS4Wa/BzvmK4HaOUb5vkcE0evqnADxPUCACLYSuwh7MreGIFCveXtkRQu8Hdd8f4V/obtPOvLCyyF6A/ktfkA/Y4DTGuOesgBBOxJ3XCBYVcRw71g41fSUzNlBxgA+uNXzKpmLzaaXAYN+WuTyQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iCsIfIHZ; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRxNkTRhA4E1KPUhQU+KfEiXl8nfjgSvVshnbgIpjVl6iRkeLvGeEytQlaFGujfgBgdl+UJRHJCqWF7f9pb0GCgsZroyrK51m1LiY6TRuK7fdfmCaz3mkfrJ6E5ZGwNkn8V6bg9gRNh1JJwS4MjnVhiWd6/yyFm9mw28UhHug2XVJVXgtOR4PSN2nsPFJnmvsOMcpSlHvvfF3fx5DJ7Heu3ljTTXN5+kH1Ro3ftaVS7U0sIyuSf0FDJsiY57dL82sKfDd5yQc9rv9MCMEGm/Y8mW7FUsHmC0NtN8Dn8mhVZBjJN/ucR0KVivgBNnrbP7HCr/Kp+VKKRzFP3MyhW+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlptiXhVJoakyrbgsQQtPrLVxYEZvHwpxc0e5PwDJzg=;
 b=kEDovO4KKsE7q6vzx/lntfaH5RAenQGerrhPDcRkjN3AbN7JsPf6QsYRc4fIC76ulvQXw1nopqS+6mRI2UzGFQwzbAtP4qGIXdFNUH+tf9VV2NOqAl2cWGDd/sthx3n1oa9UsSexJt8SKKRSMUx5HuhfxymlwGEH/e2kJykQ1J3Biidoh2qwNgQUJURzMH4+Pw7oNlrfD2GLP2EKpzNl9aSRTLT87h+bbWcCguxuGfL/Je5XEWP1XXEPr8/coIkSmUE4OA7TyC8FaO1GKQXFEFeJc+mlaRIrcP1S7MSNaT/D+Y0Caj5n1F1MHFs5j17rcplXeD2dFeQyxQDbPlzGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlptiXhVJoakyrbgsQQtPrLVxYEZvHwpxc0e5PwDJzg=;
 b=iCsIfIHZ7XoV9QXCNLPbi2eohOEeTK5kPzjBYe46w+QQyVuqF9i0RuFSBHt5WZpxvDkW3wGmtOpMej1rE727pras+MKd+Q9sV3uOH/U5C9GYrM5n5/aaaLbYu5S/liQ5jMcpmfKKYJ2U0rTjB9eBEc0agTElkPy0cAbUxQD8v3UKDOknOH9rF5VjRcjErFBLuaWUYKQegsjQOrX+sTojorXr3143Wfzw/Aoh1pqJI/sfJiy1HOP5Q2goLDiUuHZAs+sx7zYf9NDSPAZNRviT5z/S/nCrNt430+iJIzoXLPY03WDprszy34fRj7V+loU+F0MMPoPEGK6mzhO8FvzREg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21)
 by AM9PR04MB8322.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 08:35:26 +0000
Received: from PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0]) by PA4PR04MB7502.eurprd04.prod.outlook.com
 ([fe80::ff73:c7b3:5306:2ba0%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:35:26 +0000
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
Subject: [PATCH net-next 14/15] net: enetc: refactor MR interrupt enable/disable helpers
Date: Mon, 11 May 2026 16:08:04 +0800
Message-Id: <20260511080805.2052495-15-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB7502:EE_|AM9PR04MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d3c0068-1d47-4a2c-81f5-08deaf384027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	neWRCmMt2M5Qrz2R4ek4VwZqJgU7tOj/us1ZjLAq5SWB7cu0sii0Sozi5NJxhlRoXpJfBQSyCOAi9RqfzvGFu6Omo1fdkN/wADtS0L4CYYjc4X9O21IYEGLzlH1wuW2vIDy+WuAlfEcZUI7+ubXjTfied6gnOTFXmOWAXGEPa6wO6VoJpCWN83XcgYukTHp/tbiuAvinHVrGLAEHdO62qew2xtteH5BPpb2QClCTQlOyjdtE+BMrwXcJa9rHrhCp2VpHzztGsNwmcEeaP5BOIK9rtKHemAgtkoRhYO5/KDQh/gJRMvOnwdktNwt5JBsK0JU2a8mxlKSN+A/JadvQsP7jM59OpBnypVnR6MNTiOb9t4dWPKaD0JLBisv98CGYaziVfG+5v4IJ5DK+C8LvfOTRTFtZbmPYXFaTqXeYY9GnvXioWRsgUcofKtjs315uwllf/yEbPtWwQNTopvtxaFWEwsNURNlgxF01gJzJC+A0sZV7CtNTBEzF1S29/opFtIdiDopg+5XV7AnpRONdvzEL963CNgpzVB2s8jIHnqWFr5JQfi30TCD6aFoRZWHeH9UZhovUJs4D/MAwOFmHhQldfTQfo9D9Gq7t4x2HSmqlFeXB5ZtC0izAlIzDku7gRZcFp9xXWQFUidwNJfG+k6RNlmH7IbOXFSv3K6IlG16LpSSNO8aydLWNqUmxrW6tP6vobulbV6J69pDLkYNzYo/kta78/kB3Brg8HQGPgWTIKldP+YJaSuv5AT/mg2nU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7502.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sp0o3PixTABP8C5BU6pSUJBDPdFtCQSt4xEAvPDbQcXFVkz6aypfvpzQm1AI?=
 =?us-ascii?Q?it8o+QxNi7WcIHl2KtLNNn63xe28VmBVRUGkfW2pV28XVNluhHMXGbrNSRp3?=
 =?us-ascii?Q?stIXQ7enBpE1jZC68Yv5jCiZV4Zb8DPl+nFmtTKQR4Th2lXF8mFzXw08pMlU?=
 =?us-ascii?Q?aiAC6yd3KdNpyJLCpkslVlsN5RJXCDNEjYT11InMCfODfhFL5S488h+5zJUw?=
 =?us-ascii?Q?iqn2jc8K8jtkUgfhqOCTNARPtu9HgAKWFmOuQMxC5X9oQJJa66WhDvUJrN28?=
 =?us-ascii?Q?6T7hB2R+hl7z1l62GTWB3WIecSTqiv9K9ttMxAC0S8F3SWBKikiTHsTGTcB3?=
 =?us-ascii?Q?lFg7BmJiRFaY4evluT0XHcLA7vsSkU9qZkkVnbH+yvpvKhYEJdgK3jJY3eix?=
 =?us-ascii?Q?Fz3FSNy2VZd2KaQ4YAbDYiLEXudRq7oz+Oh8St65NF3KH7R5GvnB7kC0ugow?=
 =?us-ascii?Q?OPpIOJfE77+YO9o+Qq/k48Ri13juiDl2nFYNLlxMbiIa1cVDnjQDGUH2SLsw?=
 =?us-ascii?Q?pjYCKL/8IMYHIGjujn7t+y8RFi2g2Ic0ybpM2LuKRW/jpt9xSCqx5aIAB33X?=
 =?us-ascii?Q?5tCjjqyV/gkI+bzKlmkW6UY6ZSbAFgQKYbGeeWkRcHiY8Z+p1myjmWmyXbdC?=
 =?us-ascii?Q?UjR3qj1veIUsoq/a9L3uk5lUgd218OlzVk54K0PaWkkedfYlKYXRVnKRJtqZ?=
 =?us-ascii?Q?AZzCKfkCoSx1colCnfI6b4Y/ACTZBDA/rMysDuFbjapk695me+wM+zQIvwBa?=
 =?us-ascii?Q?8KZBXF6Ntc+LG8bm+oIGA4qvbmNW2VDCc7dhtaaiLqutnTnfwI0CPdq9BjkF?=
 =?us-ascii?Q?8HxxV+z8+hG01uVjDIRioRR+eFqo0h07YqQYv58U5X6BY3d+EAzD6WNGbunH?=
 =?us-ascii?Q?xTnZmy25xifYeqXGECIQsbfOYRuYv07IFbLo6KAdCqlbuSy3bD+8MYKJABHx?=
 =?us-ascii?Q?kpuRI3/DyDSlhzCk6AvNgXKhJcinwpipQIoqYaWKa3X7LnY+svMs78SDI5+B?=
 =?us-ascii?Q?cDE8BRv0Gw5W87eJ5rnH4h2RMmJfni6d47fWq4yzjGegRhGFPk+MJ/rziLAc?=
 =?us-ascii?Q?Pgmphv3QKFEvA/xaTtl2qH65zvH5DLAUehZCl6EHN9fBbcan12hrrtpLjzF1?=
 =?us-ascii?Q?dzKwYk1mYEddElmBd3o7iqboUVZ1jFkesQwtGk56+OvqpGZgiG1PTg0J1UnY?=
 =?us-ascii?Q?X4voKFgScYeNG3n0cKajBbnNqrWMoNER6KSQrUrdWh4PZAcvBstO8q/8orr4?=
 =?us-ascii?Q?BHUx9IXm3l/Fd1UFOXmKlK0LDJQucYtq3y8CP64alCbHHSb/LfLuZMgxUrpT?=
 =?us-ascii?Q?Rr1emip6m2KiE0Wm51iQbDu1JzqtHGa7WJUEQgg8L4J9ZPm3S69a2B241r7w?=
 =?us-ascii?Q?SLE5dAeFFc10BZY5S9d0Ge5UgpnKDahYqNMjU4mE+B7TFr25CT3Ry2qj+U6N?=
 =?us-ascii?Q?pdq22leEMtyJeKL8K3J48JiCMCXFey9UrWBBpC2jBT2NfOdrmRC65gEbsdUA?=
 =?us-ascii?Q?Hbe3xBelUgUC0paj9HcCMCgSs2wHA+bdu5EK46OBN9RhCZYqRbXosUUXJjm2?=
 =?us-ascii?Q?Sa/AlJ31Wf614cYhKOYWZRWdCcnSZ7x+vcQHlxxbzAUATA5D28k5fd1uhREH?=
 =?us-ascii?Q?8AO1D/DIihIp/j6aoHV/M/hDdxe73RK/rODwNvRkCnfS0JWdMWPp5tJN6SHH?=
 =?us-ascii?Q?hVbAUcl10BOCzfvfSJ69M8YMX2aC857Fc9quS4MUoO0JEvsjJA6foGIGyewA?=
 =?us-ascii?Q?EZ87xBM91g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3c0068-1d47-4a2c-81f5-08deaf384027
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7502.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:35:26.4544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3c8PvPZS8lL+3e3MQUAulBMNht7GsX1q2JY9NeD0DMhMSRpO1r/557JtgW+KTdHU96gaeALj+h1R75yyjZ19w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8322
X-Rspamd-Queue-Id: E1C7C50A351
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-286529-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

The MR interrupt helpers currently operate on struct enetc_hw and rely
on the fixed ENETC_PSIIER_MR_MASK constant when enabling or disabling
MR-related interrupt sources. As part of upcoming support for ENETC v4
with more or less VFs, the mask used for MR interrupts will need to be
generated dynamically based on the number of enabled VFs, rather than
relying on a global constant.

Consolidate enetc_msg_enable_mr_int() and enetc_msg_disable_mr_int()
into a single function. The unified helper takes struct enetc_pf *pf
and a bool enable parameter, replacing the previous struct enetc_hw *hw
argument. This change allows future code to access pf->num_vfs and
dynamically derive the interrupt mask.

This is a preparatory refactoring with no functional changes. The
implementation still uses the fixed ENETC_PSIIER_MR_MASK constant. A
subsequent patch will implement dynamic mask generation based on the
actual VF count.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index f3e78865617e..73e32c9b65a8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -3,18 +3,18 @@
 
 #include "enetc_pf_common.h"
 
-static void enetc_msg_disable_mr_int(struct enetc_hw *hw)
+static void enetc_msg_set_mr_int(struct enetc_pf *pf, bool enable)
 {
-	u32 psiier = enetc_rd(hw, ENETC_PSIIER);
-	/* disable MR int source(s) */
-	enetc_wr(hw, ENETC_PSIIER, psiier & ~ENETC_PSIIER_MR_MASK);
-}
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 val;
 
-static void enetc_msg_enable_mr_int(struct enetc_hw *hw)
-{
-	u32 psiier = enetc_rd(hw, ENETC_PSIIER);
+	val = enetc_rd(hw, ENETC_PSIIER);
+	if (enable)
+		val |= ENETC_PSIIER_MR_MASK;
+	else
+		val &= ~ENETC_PSIIER_MR_MASK;
 
-	enetc_wr(hw, ENETC_PSIIER, psiier | ENETC_PSIIER_MR_MASK);
+	enetc_wr(hw, ENETC_PSIIER, val);
 }
 
 static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
@@ -22,7 +22,7 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	struct enetc_si *si = (struct enetc_si *)data;
 	struct enetc_pf *pf = enetc_si_priv(si);
 
-	enetc_msg_disable_mr_int(&si->hw);
+	enetc_msg_set_mr_int(pf, false);
 	schedule_work(&pf->msg_task);
 
 	return IRQ_HANDLED;
@@ -171,7 +171,7 @@ static void enetc_msg_task(struct work_struct *work)
 		if (!mr_mask) {
 			/* re-arm MR interrupts, w1c the IDR reg */
 			enetc_wr(hw, ENETC_PSIIDR, ENETC_PSIIER_MR_MASK);
-			enetc_msg_enable_mr_int(hw);
+			enetc_msg_set_mr_int(pf, true);
 			return;
 		}
 
@@ -264,7 +264,7 @@ static int enetc_msg_psi_init(struct enetc_pf *pf)
 	}
 
 	/* enable MR interrupts */
-	enetc_msg_enable_mr_int(&si->hw);
+	enetc_msg_set_mr_int(pf, true);
 
 	return 0;
 
@@ -285,7 +285,7 @@ static void enetc_msg_psi_free(struct enetc_pf *pf)
 	cancel_work_sync(&pf->msg_task);
 
 	/* disable MR interrupts */
-	enetc_msg_disable_mr_int(&si->hw);
+	enetc_msg_set_mr_int(pf, false);
 
 	for (i = 0; i < pf->num_vfs; i++)
 		enetc_msg_free_mbx(si, i);
-- 
2.34.1


