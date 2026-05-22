Return-Path: <netdev+bounces-290735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yInoC6kgEGpNUAYAu9opvQ
	(envelope-from <netdev+bounces-290735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:23:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF65B1178
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68337301B30D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585443C3444;
	Fri, 22 May 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FCVWGGb5"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3793BED33;
	Fri, 22 May 2026 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441733; cv=fail; b=FhaN8MYqugyxxDVVxmyyXC7Z3OKSEU3ALXaGzxCUj7cM9ZmFJ+hKjQqJfJt6juYmF1Cp3KT9F7yFhPpRklsvtUWD5FVZCPv8/pR3UlxZMmELA2gKbKHh3uvuohmwKBpD7FgC4JVQoFZ8J147OFn4tRgBqd+J6ldVkj6eBr+3ID4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441733; c=relaxed/simple;
	bh=cHEuoR49tr6uZCOAh6jTtu4FHzoj56kk4q/a1yrmLTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fcpgvbgaP7xNFvvzVmx0Y524ejzDCIAmFP00r0u2fXPZKgbrxWiLzo2GFYLEbTu4nNCGGZkgiqcATpexNMGk37JcYbMyX0zbCoxK/G2EvKiWFJs9tInNL1UXe0t1A8I4IVOE5ZyP4B6K5+uDgmJYpj8qOymBeQoirnangT14bdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FCVWGGb5; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9inYcHlvxsjJJzBfPp9O4Xg6Wmw+65uRmjFlLTUkoaO492yHi7JvEhLO+RFpL/fLXpCMMYb5+rEQdUxJ/S5I0hPGaINhWjSBvuUTCG+DsCfJvaLX7FfbaORQ/+3+gZ7ZCfaGaJGn30oBsxFQ7N+BXFdbM2J8Vb9f1six/XjxqCpqgYZbxoc70ViPhi9/+fYdTzwJhvL8oYLeD9177tLetQbbjOhS2LXAZFQEUS8RwwJkFGzxlPOdnAS03gahszGYgejnrlwnwk1q04RO60aHg6j9NVNSaesK6AVFjt3znQvF82AmTqj6wyIAGniHz4KCRIrAdhpvIAAhTwIpjGyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y/wrRiI2Gt8g3JYXzDDLFs1xddIFJzmar10M99Wmas=;
 b=S6vtWTm5hSw9Lhag+aaHdnu1KoV1C1SB/RFkG0IfrIkNpEfaOY/T6AeMFIl0XD2xT/+Hr3ssW8Lhy9ZYwjNFMAEe/BrW64g3pUunIoKr6a4VZI4ahQeMyiE68OTUtQ1sGUFsWdyZY098zbYNkX1GH0Rsshqjs4M+asDackuZ8F57AfnANONmSZInLy7wf4YXtKH7maKhwS4fqQrRH8y9NopqBmoMwgx2Z6pVUbtsVHgyLcx/d5CdxOCg8GQmRnEJu652uay2Utvqmc9PgNjVI1HTCnULu4QPqQ9If9pBnWtYXBR8HQJRRrJ3hhXWyUp2g/9rP5Lg+ZJDR6qwYJsByg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y/wrRiI2Gt8g3JYXzDDLFs1xddIFJzmar10M99Wmas=;
 b=FCVWGGb5ObVoD3Z/61MZzqQcX8LaaW/3Y6IP+UYL4N7cJEOienPEoL75CnC83VBiTEBVJPiHhxnfrVf+aaLeDXyaxMEz0ZqFOPvKxiSKIQeo6P1nnhCVaLS5juaUjnRyCW25v9d/u9Tt12Z4wGfJx6pDmRkzbzaYZumQtIGdFbKmdeoEW4ImGY2dYMt3MaL+uTDcq6JDSOtIa6WiTjeOs6tzHQ/d456t5ZT266UNvu7QO8U/fhu2eCATT5552odh+NDB2CNSE6ATPfFA1jYYiuV1a5b0XxC5C+F/M6q112WlgC+R/Zl7pKFuUMfKSXah8oBr/bDd4iyouwO8caOxCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by VI0PR04MB10855.eurprd04.prod.outlook.com (2603:10a6:800:25b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 09:22:08 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:08 +0000
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
Subject: [PATCH v2 net-next 02/12] net: enetc: move VF message handlers to enetc_msg.c
Date: Fri, 22 May 2026 17:24:28 +0800
Message-Id: <20260522092438.1264020-3-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|VI0PR04MB10855:EE_
X-MS-Office365-Filtering-Correlation-Id: e2775c88-0fba-45e6-9e21-08deb7e39901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|18002099003|22082099003|56012099003|38350700014|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	9/dLofMQeBcI49GUTdwjd6zNjciD1yYToXjAWEOCgzWnugnkKXqwZYpENd43WEeiZoFI1HL0saaSbHIz5c4U2Ef+pqLjw4rmIZcHjQsTKOLTfpUpzPiJdPz3rXGsWU08erNUHQ2+jFclVjLNeIsAfLzrb9MoecWF6TPIkfRqyuvhSsSC4WIe0j2AhGMYAKrYS19pLkKSxA+C/3ybs6yo5GH/gow03Eq7Hu103KgHeJqusApXMqoP32gTavNhwm+RaT4VgAmF+Nw8nPZ8Ibq5LbVYZY++2HUnfF3ej5FDUGxtXz+nlNbbHDmD6RPbLqR4T0nwiHqQ8dIZP93Q4fSS8wudG6ajib3i2nLTbMscPTDf5DSLMHrjt1w0/s0NIAwL6ov9zvun6KOJltmDE6KAdP1tFQyaKSTKmKHWYsDPbQ6si4xiMkpxsPncHq202EgJDqExZDJFx4AI8TTa2Beg53bZ4QVjdIF3DaNjsesKTihc7/NWt+EypDCWpxJaGIOkjw+jBg70h0Uvg1WN6w3c7aAB0jkiJmD60Y0GACNd/C2ajTp+Z+Ru/t6VqU0HGgVrkIZeUn3kS8uXLFcws6z1XRARkyU+s9vK9NwqLEJR7g/XrMYKn96OROzfOvBBj+b/K799Q19dwjgMUAv2c+6HjmbB/kJcW2oarfbFJXHOwEhlvWQ0smCpyDwQgEjHsW1zALXzOKSN3ixy+Lb4K4/V91JGIGZ946CjCxMbyZrFB5hbWgzxvrDmaHr/Na6Zhdjo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EteI9k+bRnhVnerZBDcSWGDlT9vmhfSswhjrv4F9VNiHqZ+ibDl257+tuPnZ?=
 =?us-ascii?Q?GkJx+hNcdXWGqB6tE+/ltFScT7N5SbXw05OjWZIRxWK3pDhPSNseXNolBeuF?=
 =?us-ascii?Q?FdCKbI/W/yB+zQP+XVcXhs77vG82JUptODCuOSQfxb+JjnEA2YyLbQyPDvxb?=
 =?us-ascii?Q?6rq3xtK5jplmnAe1QPHwOF/XWOP4/QZb3lE5Fm1NP1xYJPBxBjdxoqwUyrRu?=
 =?us-ascii?Q?PabZIIQ3jyeHVPC+56/7W0tTPUsPl9mUWWDxaIzvywJ5n0xYdZoIVfyY20u7?=
 =?us-ascii?Q?fk0l9QUeCylhZ1DR3QdSyU0nHuzuTriNJsP0WPmNBLpICi81z5kQYvYqdYt2?=
 =?us-ascii?Q?Dq8rF191QA7n454qx1kQikSXf4mUFse2XEewwI3ADOFICZfX0B1VhRcqTEf4?=
 =?us-ascii?Q?H5RY8Lzh7Zo21S2M0ZHRrO8AILgGvWYBNLz7wBwzcvUi+F/qq4jyisOlB6xm?=
 =?us-ascii?Q?B/8RbIX3h7dSA118vAsNb4fum0XSFzge9KcSz5FfaSewk9YOMt/C+qLlZV8A?=
 =?us-ascii?Q?Ns6bI5z4fwTpM2N+NxeMjbOphO0oiDPIuum5vjAhMu7vvVT5hUOACvc49DV3?=
 =?us-ascii?Q?uWqwl4z3OToGlsIK6PZSWUJoibEXcot5UXOaNnAYJb2dAWKP2rle2du9e/UN?=
 =?us-ascii?Q?rmcguPP9RQBKguxjra9aBnsSxpsbqDTaeqK3hM3Vh1l9t/7NJBaMk2zCqHWL?=
 =?us-ascii?Q?uA0yisViPC2JE4oXtp4fSACz0DuB/w+gV9yMGN7w4Yrz1AqLbfl2FFdLKsY1?=
 =?us-ascii?Q?lSXK4/xbN4gABtFdnzVZSZ2ZL84dPHAXhrvCEJvB0nRLDYIS4W0N62hNwtbT?=
 =?us-ascii?Q?tl4qxQ65Nooh6imlfxb/eQTUvf0Thv2Dufgq+ywk4UG5enO9AV3+dHPbUHA3?=
 =?us-ascii?Q?fg+gDh/2EO0ar/ms8Sv7Qf8um5YQ5Hzv9v3WfaHwpDhl2vvidkj7XOT4SAFW?=
 =?us-ascii?Q?HTjQffeD4IuhCVUACxY7hR2ZGeHuoLbmcdCZK5IVRJ22W2ms0UbKfwV4J+Ek?=
 =?us-ascii?Q?EkhYlAiXwLX0LxnDek4T++f0dQja5yPS6lGcdu/SyqdqZDfVp/ds8nXzWiLP?=
 =?us-ascii?Q?zyVXYwQJ6TQzupd5LAm9DO8GP/KrydpCKDOJqo6HGctdkmMir1yp1Np1uQZq?=
 =?us-ascii?Q?iW1ZvAn9Opm/wG5RUCTXTP55YkKhgFBhNPF9M80bAkUETzCl4eME15TqPTus?=
 =?us-ascii?Q?Deri0lnfs7OCe3sCtgUjKoWufuR96bl/SQkdYQVeVoXmp/JBt8DniIoHcFqG?=
 =?us-ascii?Q?6DAgBjVAG2vEqZYXEnpen1407WDdWzQ2wDH/jIWL5QHj5qEyrx99MEcXb8KZ?=
 =?us-ascii?Q?SXOAyA1Rqz0Z8ehjZQ3RNWeKwjul2xPyUMMmJRshN4w0Z3amAOCec6U2AdAO?=
 =?us-ascii?Q?minFZJGEGL/UuxWWj1VgwWzQgTvNtXeRjzaD9LxGj351xJ82/1CSJD8CHU3Z?=
 =?us-ascii?Q?4nwKeUJ1TAFR5R3DcJSopkEqZEtRP+rkE7+ePG30gjlycY9bLMFbljzEvVri?=
 =?us-ascii?Q?XiB7gyMZNVaYoCOR4URSE6lfnOzRItcBg/x+y1QufMbJZJTQ+SrBxR3ywlI5?=
 =?us-ascii?Q?BIVtwiEStN7VfzvOJAwqoL4uL+SB3wekB/6zmrJx9AInSpM+uwdJXZRxwXu4?=
 =?us-ascii?Q?4cMGL1bC8YLfJbcwAnXHxH8XezfPH6KIJG6Wg53PQzvtrUQRYlQ7nXGuJxTZ?=
 =?us-ascii?Q?io6UnyII4Gnz4rAo+MXboDpAsWVVHbJSDc6twnwk+IkYN708pj0dzbs1RoUD?=
 =?us-ascii?Q?ycQ/l2PYEg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2775c88-0fba-45e6-9e21-08deb7e39901
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:08.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqIfbpcx/HZjlDa1FPm7U9eBTloV0wc+kLNj0hf4hFGP0Hnl9lEbvqMwvyxx6/rFnhbcFGd+j30tej+/j8E+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10855
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-290735-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2DFF65B1178
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move enetc_msg_pf_set_vf_primary_mac_addr() and enetc_msg_handle_rxmsg()
to enetc_msg.c to consolidate VF mailbox message handling logic.

Make enetc_msg_handle_rxmsg() static since it's only called from
enetc_msg_task() within the same file.

This prepares for integrating enetc_msg.c into the enetc-pf-common
driver to be shared between ENETC v1 and v4 PF drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 78 ++++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 75 ------------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
 3 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index c09635e7eb3d..73da2018034e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2017-2019 NXP */
 
-#include "enetc_pf.h"
+#include "enetc_pf_common.h"
 
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
@@ -35,6 +35,82 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/* Messaging */
+static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
+						int vf_id, void *msg)
+{
+	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
+	struct enetc_msg_cmd_set_primary_mac *cmd = msg;
+	struct device *dev = &pf->si->pdev->dev;
+	u16 cmd_id = cmd->header.id;
+	char *addr;
+
+	if (cmd_id != ENETC_MSG_CMD_MNG_ADD)
+		return ENETC_MSG_CMD_STATUS_FAIL;
+
+	addr = cmd->mac.sa_data;
+	if (!is_valid_ether_addr(addr)) {
+		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
+				    vf_id);
+		return ENETC_MSG_CMD_STATUS_FAIL;
+	}
+
+	mutex_lock(&vf_state->lock);
+	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
+		mutex_unlock(&vf_state->lock);
+		dev_err_ratelimited(dev,
+				    "VF%d attempted to override PF set MAC\n",
+				    vf_id);
+		return ENETC_MSG_CMD_STATUS_FAIL;
+	}
+
+	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
+	mutex_unlock(&vf_state->lock);
+
+	return ENETC_MSG_CMD_STATUS_OK;
+}
+
+static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
+				   u16 *status)
+{
+	struct enetc_msg_swbd *msg_swbd = &pf->rxmsg[vf_id];
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_msg_cmd_header *cmd_hdr;
+	u16 cmd_type;
+	u8 *msg;
+
+	msg = kzalloc_objs(*msg, msg_swbd->size);
+	if (!msg) {
+		dev_err_ratelimited(dev,
+				    "Failed to allocate message buffer\n");
+		*status = ENETC_MSG_CMD_STATUS_FAIL;
+		return;
+	}
+
+	/* Currently, only ENETC_MSG_CMD_MNG_MAC command is supported, so
+	 * only sizeof(struct enetc_msg_cmd_set_primary_mac) bytes need to
+	 * be copied. This data already includes the cmd_type field, so it
+	 * can correctly return an error code.
+	 */
+	memcpy(msg, msg_swbd->vaddr,
+	       sizeof(struct enetc_msg_cmd_set_primary_mac));
+	cmd_hdr = (struct enetc_msg_cmd_header *)msg;
+	cmd_type = cmd_hdr->type;
+
+	switch (cmd_type) {
+	case ENETC_MSG_CMD_MNG_MAC:
+		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id, msg);
+		break;
+	default:
+		*status = ENETC_MSG_CMD_STATUS_FAIL;
+		dev_err_ratelimited(dev,
+				    "command not supported (cmd_type: 0x%x)\n",
+				    cmd_type);
+	}
+
+	kfree(msg);
+}
+
 static void enetc_msg_task(struct work_struct *work)
 {
 	struct enetc_pf *pf = container_of(work, struct enetc_pf, msg_task);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 4d72e2b77072..67cc80adec72 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -480,81 +480,6 @@ static void enetc_configure_port(struct enetc_pf *pf)
 	enetc_port_wr(hw, ENETC_PMR, ENETC_PMR_EN);
 }
 
-/* Messaging */
-static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
-						int vf_id, void *msg)
-{
-	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
-	struct enetc_msg_cmd_set_primary_mac *cmd = msg;
-	struct device *dev = &pf->si->pdev->dev;
-	u16 cmd_id = cmd->header.id;
-	char *addr;
-
-	if (cmd_id != ENETC_MSG_CMD_MNG_ADD)
-		return ENETC_MSG_CMD_STATUS_FAIL;
-
-	addr = cmd->mac.sa_data;
-	if (!is_valid_ether_addr(addr)) {
-		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
-				    vf_id);
-		return ENETC_MSG_CMD_STATUS_FAIL;
-	}
-
-	mutex_lock(&vf_state->lock);
-	if (vf_state->flags & ENETC_VF_FLAG_PF_SET_MAC) {
-		mutex_unlock(&vf_state->lock);
-		dev_err_ratelimited(dev,
-				    "VF%d attempted to override PF set MAC\n",
-				    vf_id);
-		return ENETC_MSG_CMD_STATUS_FAIL;
-	}
-
-	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
-	mutex_unlock(&vf_state->lock);
-
-	return ENETC_MSG_CMD_STATUS_OK;
-}
-
-void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id, u16 *status)
-{
-	struct enetc_msg_swbd *msg_swbd = &pf->rxmsg[vf_id];
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_msg_cmd_header *cmd_hdr;
-	u16 cmd_type;
-	u8 *msg;
-
-	msg = kzalloc_objs(*msg, msg_swbd->size);
-	if (!msg) {
-		dev_err_ratelimited(dev,
-				    "Failed to allocate message buffer\n");
-		*status = ENETC_MSG_CMD_STATUS_FAIL;
-		return;
-	}
-
-	/* Currently, only ENETC_MSG_CMD_MNG_MAC command is supported, so
-	 * only sizeof(struct enetc_msg_cmd_set_primary_mac) bytes need to
-	 * be copied. This data already includes the cmd_type field, so it
-	 * can correctly return an error code.
-	 */
-	memcpy(msg, msg_swbd->vaddr,
-	       sizeof(struct enetc_msg_cmd_set_primary_mac));
-	cmd_hdr = (struct enetc_msg_cmd_header *)msg;
-	cmd_type = cmd_hdr->type;
-
-	switch (cmd_type) {
-	case ENETC_MSG_CMD_MNG_MAC:
-		*status = enetc_msg_pf_set_vf_primary_mac_addr(pf, vf_id, msg);
-		break;
-	default:
-		*status = ENETC_MSG_CMD_STATUS_FAIL;
-		dev_err_ratelimited(dev,
-				    "command not supported (cmd_type: 0x%x)\n",
-				    cmd_type);
-	}
-
-	kfree(msg);
-}
-
 #ifdef CONFIG_PCI_IOV
 static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 35d484858c7b..3b265ad8d845 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -71,4 +71,3 @@ struct enetc_pf {
 
 int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
-void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
-- 
2.34.1


