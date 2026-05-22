Return-Path: <netdev+bounces-290736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E4rFuYhEGpzUAYAu9opvQ
	(envelope-from <netdev+bounces-290736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:29:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C5F5B130D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B73A8309EFC0
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00F3C37B6;
	Fri, 22 May 2026 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mAULDSb3"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB453BB128;
	Fri, 22 May 2026 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441737; cv=fail; b=DAafWPFb3fKsCAjevqTpxKwxk2GKJjXy6/qFdLTdWuzwWjsvzvYaBoHTdIElPGwIEiM2mDGsikEfpPzaOk6n82w/H81onb67/EkoRBQ8/2k7cgtTapFIQkJ0UXc6NrqgxpaGrsKbE0xfMZNIiu2ribl+m8W/UMZXLHxnh9H1yVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441737; c=relaxed/simple;
	bh=0EhCXcP5UxG9O7Owjnt39sThFu7ZHcpZEkhXNt2+gDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZAk7BEnwHL15wUGij+zWw6hCeQNKTxG3aRbPSjWMb/dkd2o1A5j/HDQBG5fty3kL71qR0hoGuUyzhlRJkZhSIXYDVK+sdZ5YBz1E+mZczbHUlABP91brHU/G2R/aH89n0Ip9tk32NXFlCr6IAkaae6/8qR79smjtuuvNEmadJHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mAULDSb3; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St5DOOQNT//uP445wOQD42GLs/WC3geKwBoIXqwuqCG8lP0ZV8i/ANMVxabVGrMbNaCwevki9NDHm9G0P9pspLvtVUUjFhV7B4tJB6wdiWkkkf6+wIqkhlJ8a1ERNmp3n4QFB7cdnl+LITHxwT73vLdNNHH5+kevMrv6/sGFwlVXf3z55Dbk4uJ0YeGvpGBSJyT/g4Oib651e0gIhZn7EHksaUnMCEwxV7KBAlDvFUo8CGrrJT4/DcZvxevzfxeITGN2Ucza6MK58CenWl8+1K/m5OAbE9ugRFk2HXp9lXVY1tasUjwc0qUAgfKxb+rU7R8ZuS+zXxTjCZrt7lYsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAZXwBJlEk6D8VWBkK+ZWIE4+U5w1Czqfyb+A8LrXDA=;
 b=xrnivyefEZ264I/ezaY/bzGvSU7p/0rItZ3Fnu3qbQMjr4sMj965PQFUOhqyWhnHJ+ij71smBDtMqMIuAZEpk3uGG6Wj8GSC/hMMABwZ0JiZZ2dAsJJ1uACCRXfF/viYjn5iCCScLYCzmAuRk00ydSkBYtb8V6/UEP+L1tagiDdbA/vrkGxChtwU/tNtw0+LTPe6k1pQB/hIvGHgNnkg1m91zd6pYli1WmUx83IrpN4abcrUv+32HYEOZQYVwbgvHmE91J9ZuqHHkqMZIZGMsowM+vvW/Y6w+0fblJa5LUSZGJWbLCiduC357GLZUZ81QfnXSFbRmyDZ0+6Rm9njjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAZXwBJlEk6D8VWBkK+ZWIE4+U5w1Czqfyb+A8LrXDA=;
 b=mAULDSb39F+H7lnRVs/h+nSSxdcWIaRlaHDWmQw56+RuAu8PuNyUQJmBXE5PoX03UbIeAcMa/1706EwwmNkkF34qtlkNlIwIF/4m4PibKsE3rElEOrbgDRFik33bVM+V4El6U+sJHIN+kD26famfTPWrvKoKPTePfBd3W8pLTh7hnFrRGDnMBT8QMPXgO0yYwCZuhii7sFBVBR3OhnSqHONSZFdQiJ25+7qxCb3N4u2T5u/jwfD7k7fXbHqK5KYXfxya0S85nkn8APFsy9uoKbuifC3RnDyQc4dY+A9ofx8qzlwVLJ40VZiuBVQN5VhG5dgQl2ampOxg9jGBmyzI9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 09:22:13 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:12 +0000
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
Subject: [PATCH v2 net-next 03/12] net: enetc: relocate SR-IOV configuration helper for common PF support
Date: Fri, 22 May 2026 17:24:29 +0800
Message-Id: <20260522092438.1264020-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522092438.1264020-1-wei.fang@nxp.com>
References: <20260522092438.1264020-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::6) To DBBPR04MB7500.eurprd04.prod.outlook.com
 (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|PA4PR04MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a3a6e3-d055-4107-947f-08deb7e39b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|19092799006|22082099003|56012099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	BBPnWAjTlEMFJtsS7+GIaAGZnrZtbj4AzdyWscBpId2rCPUb0ENm20oLrTMfnNAz0yd7l1E8QrPj1UWfqpXaPMef1LBQ5lsyFfepYHMFQJ49NzTZlXfhVnnen+vcn+cHor3MquL3TwwssnoMeRswr4xO84/AKQ1+ZI4VseGMxZ2ss/ULP2njJYY5YN1hsLOpVFxXvF8ecLkI36id8OEVdSSE+RGEKSqrymN3WhHQTU0txfMDHNlpeJOwVsYAC3IJeyEQsAhmtGBaeIpbebXq61JPlLkUILQntSXzNIjj2acnGBXExdQTlp093dvO40f0EuqPWd7vRYprmSwuOZwBY6W649ML1NvNb0EqQPUFfcSLlN2OZA4mgrSV3yFTOcBqw/pM6lG/QMJ+jJk6aoOwZVdJo4VS1IFNd/vKNg9GUPvtsrMqSrO2i3u7QQ09VlaJE6nbROAeDS32r1cHQxF/RoZCgef0UDJM3avVeeFi6TOcNG8WfM/QTTyhMyeImQodGqFZu4gHwTj8SEUdItw5BGdCOKbEKJoQZuVqzko2w7ZcdVXVphQDv6cmCLoytuXsNhftDn517z2EDmEectEfI1Ugn3FKXPChVH0JKJQSuMMOKA0UeFeIUtL0Xt648ok6dj3jpRJum+M0v44s4WuR95IfqLV8FPK4vZSOuV8FHndDeWp2FyFIGR9XuvpYwDL4c9UfZ1XX/TFd9AAY+HVTlryoagrjNLAQJUzIOFAdgPaoyjFr94t/zSyrBZnhZRI1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JDpiZO5k13VhZpnHl1TVBxC9PvUyEKZzy1di0ts6IDFRnpt2TyWivdH2b0LT?=
 =?us-ascii?Q?SD/Knes70gpARwKfps/7qEPs539+1ELT9nxoc09IvMGG/eI5NLwQ4ANMvXLQ?=
 =?us-ascii?Q?Bak1bSqeJbhwIeYvJU59GJITMcPVGB9IGI3YR0pTrHpl6IiOABFvHDzJNcrS?=
 =?us-ascii?Q?sJ3ZzxnKhbe9KoCRjR3/7HcyLx86i5ck06FNJr5mgU4XijEZjngsXuZM4CLH?=
 =?us-ascii?Q?rJ0oOarFwHO5+GXsuXjbnSockVRW8K9vealXzqVCeQePPSF99hR1GxCO2eNE?=
 =?us-ascii?Q?BDOWvAJ49vkZwYnG6d4rVLM2LxIfasZZExVrtIxggMT5EW+xUFu6wvbODIFg?=
 =?us-ascii?Q?6dCGRinTBfUGaT+v3qJNxW6TbHwz+u16DZZlFyPvV26h+RrG3rNyn7JrpjFr?=
 =?us-ascii?Q?qYL8hwdD6R+XHaJZoYTKhXKSIVDPXWGIUh5HwIn0eSmhP3/0TnBHjW7/jZ9l?=
 =?us-ascii?Q?jms2MD4eEf/R1GmQb5bhVxWOKST01uX8eeM1qy7zIu4w3PkD5UkLZprHnuA4?=
 =?us-ascii?Q?306VyWn8D41bTn/ri6TGYB3F+w+ar/qJ881f+V0K3uY8rq5jxqtRge3HFfMi?=
 =?us-ascii?Q?/dTDP+ClSU7ii/OLEYQ5z+0ZY02fJZor4OqDCCxP+quwxWRulmDGBANQIc17?=
 =?us-ascii?Q?ph2YHq1TUF93wsK81gEd8LVWQHs4EoLvQO5NzvJp8OU0yvcNJbwUPG4wGyBG?=
 =?us-ascii?Q?MvJwOKfjpRlJF1zlejRzkFnKDRoYyJb9F7LvcW072lCwGf9c3MET8WUSf4BL?=
 =?us-ascii?Q?ovkCFmL7ARFNOvNvR8oEaERtbm1dgwFADMLkj4BDHBPCPuBDwdx+HKR1zqg+?=
 =?us-ascii?Q?OxaIErLFIOV38e2Yysbs88ggpIvPfPz/QtQ1FHHTEsdhUF3bNUj0oN0tuiCE?=
 =?us-ascii?Q?5ZyvEr+G5BgLzwemW/PfL1QG/ov6ClXN1QkrrvFr4zrtxlY/S7V8KIKNlFeH?=
 =?us-ascii?Q?OB8eb9dsAJxwNdWSO7yxHYpsnTDvLv1RImFF3rYnENPZCdgdXo1n6lZI3dwH?=
 =?us-ascii?Q?N/wqAELquaTNMcA21zEqQnp4mUcLrPZ/dA9G7VcncQOObJihsYpli8FlDUJn?=
 =?us-ascii?Q?L6QUF84aj7MDXBDvH6yT3TiZrk3C2557/OkR4bRUnL/js3UOWsQtVl9K2wdU?=
 =?us-ascii?Q?egOztU7tlk5gluWKAf/7sEggE7xY+JAWIujfe2wK+xxcq8y0ExK70qZHcMiE?=
 =?us-ascii?Q?eiKxfG9rcZdtN7xfL4eGHB2dzoxSvBze4DN46nwE+h2Cf7WapenzfIEBz0xJ?=
 =?us-ascii?Q?Nyct+uBNPn74JRPOxFnWvB1cxeh3ENv9Oj7xKpedxR7/xDyDr6bzxNIXjZLt?=
 =?us-ascii?Q?sjYaockoGizz/ABSzlU3blre8e3NxCycE/DA2KvWUR74z6rokDtONR9evGvH?=
 =?us-ascii?Q?YcRubStaQt0IjXqM6YE2lxViFhZQf5XHpMZnfAL+y/5nJj5Lq+BU+bKd5OEr?=
 =?us-ascii?Q?3GuyLXDH7RqHlgmn+MvMpz/8Z/p6OrHAejC0tI9XGVtQXpK0/jWckJcZeuTl?=
 =?us-ascii?Q?c/pqNgNVydc4uR+fxs+UISeZuPTTkVQhMyhCih6CjplC9MRFtVad5CO14ZLC?=
 =?us-ascii?Q?s+nwdREpPgxnEQpDlxiy18jbJMueoVwTjADzTkuLkdTJ7iwe/tFo+V7VfOHG?=
 =?us-ascii?Q?JqbK93duioWdUMprfcv7znomaOXw+Wmv8cAcd6/oBazv+Jq6lHosCOIWpVEG?=
 =?us-ascii?Q?TMJj5h2Frud+p7CqNsE5wxeag2xaT7RLcRnLfRqtF0c5laZJX/cvNPGZoz9L?=
 =?us-ascii?Q?LlbDHjQ1xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a3a6e3-d055-4107-947f-08deb7e39b55
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:12.8002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8+SfRlbshvU0QwKyV73B4nFU9Dk0B4IrtM8wzWkcobsd3FL2KYoC2inF9IyzFQaKx0NSzB3KRO89D3YQ4atIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-290736-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: C7C5F5B130D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move enetc_sriov_configure() from enetc_pf.c to enetc_msg.c to prepare
for integrating enetc_msg.c into the enetc-pf-common driver, where it
will be shared between ENETC v1 and v4 PF drivers.

Since enetc_msg_psi_init() and enetc_msg_psi_free() are now only called
from enetc_sriov_configure() within the same file, make them static.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 40 ++++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 40 -------------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  3 --
 .../freescale/enetc/enetc_pf_common.h         |  9 +++++
 4 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index 73da2018034e..fd1a42bbdcb1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -189,7 +189,7 @@ static void enetc_msg_free_mbx(struct enetc_si *si, int idx)
 	memset(msg, 0, sizeof(*msg));
 }
 
-int enetc_msg_psi_init(struct enetc_pf *pf)
+static int enetc_msg_psi_init(struct enetc_pf *pf)
 {
 	struct enetc_si *si = pf->si;
 	int vector, i, err;
@@ -229,7 +229,7 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
 	return err;
 }
 
-void enetc_msg_psi_free(struct enetc_pf *pf)
+static void enetc_msg_psi_free(struct enetc_pf *pf)
 {
 	struct enetc_si *si = pf->si;
 	int i;
@@ -248,3 +248,39 @@ void enetc_msg_psi_free(struct enetc_pf *pf)
 	for (i = 0; i < pf->num_vfs; i++)
 		enetc_msg_free_mbx(si, i);
 }
+
+int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct enetc_si *si = pci_get_drvdata(pdev);
+	struct enetc_pf *pf = enetc_si_priv(si);
+	int err;
+
+	if (!num_vfs) {
+		pci_disable_sriov(pdev);
+		enetc_msg_psi_free(pf);
+		pf->num_vfs = 0;
+	} else {
+		pf->num_vfs = num_vfs;
+
+		err = enetc_msg_psi_init(pf);
+		if (err) {
+			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
+			goto err_msg_psi;
+		}
+
+		err = pci_enable_sriov(pdev, num_vfs);
+		if (err) {
+			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
+			goto err_en_sriov;
+		}
+	}
+
+	return num_vfs;
+
+err_en_sriov:
+	enetc_msg_psi_free(pf);
+err_msg_psi:
+	pf->num_vfs = 0;
+
+	return err;
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 67cc80adec72..fbe2c126082e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -480,46 +480,6 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	enetc_port_wr(hw, ENETC_PMR, ENETC_PMR_EN);
 }
 
-#ifdef CONFIG_PCI_IOV
-static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
-{
-	struct enetc_si *si = pci_get_drvdata(pdev);
-	struct enetc_pf *pf = enetc_si_priv(si);
-	int err;
-
-	if (!num_vfs) {
-		pci_disable_sriov(pdev);
-		enetc_msg_psi_free(pf);
-		pf->num_vfs = 0;
-	} else {
-		pf->num_vfs = num_vfs;
-
-		err = enetc_msg_psi_init(pf);
-		if (err) {
-			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
-			goto err_msg_psi;
-		}
-
-		err = pci_enable_sriov(pdev, num_vfs);
-		if (err) {
-			dev_err(&pdev->dev, "pci_enable_sriov err %d\n", err);
-			goto err_en_sriov;
-		}
-	}
-
-	return num_vfs;
-
-err_en_sriov:
-	enetc_msg_psi_free(pf);
-err_msg_psi:
-	pf->num_vfs = 0;
-
-	return err;
-}
-#else
-#define enetc_sriov_configure(pdev, num_vfs)	(void)0
-#endif
-
 static int enetc_pf_set_features(struct net_device *ndev,
 				 netdev_features_t features)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 3b265ad8d845..5b4094f8d5d4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -68,6 +68,3 @@ struct enetc_pf {
 
 #define phylink_to_enetc_pf(config) \
 	container_of((config), struct enetc_pf, phylink_config)
-
-int enetc_msg_psi_init(struct enetc_pf *pf);
-void enetc_msg_psi_free(struct enetc_pf *pf);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index cef9fcc58e2f..c9b3512d4e2f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -21,3 +21,12 @@ static inline u16 enetc_get_ip_revision(struct enetc_hw *hw)
 {
 	return enetc_global_rd(hw, ENETC_G_EIPBRR0) & EIPBRR0_REVISION;
 }
+
+#if IS_ENABLED(CONFIG_PCI_IOV)
+int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs);
+#else
+static inline int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	return 0;
+}
+#endif
-- 
2.34.1


