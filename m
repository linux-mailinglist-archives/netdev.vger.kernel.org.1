Return-Path: <netdev+bounces-290742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FZ+Ad0hEGpzUAYAu9opvQ
	(envelope-from <netdev+bounces-290742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:29:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D507C5B12EB
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 289FD3039CD3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B273C8194;
	Fri, 22 May 2026 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M8MCuQe9"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011056.outbound.protection.outlook.com [40.107.130.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDFB3C76A1;
	Fri, 22 May 2026 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441761; cv=fail; b=QGz6aNHyAvbAyRq31u0TbNp6kxTJ3ThPIa2lzNlCU6+55Kf74GZSliY2EMXtNx4UbZeDY/MhcqMSaZxcx/T/citsJbIoMeuz5t+ZJEhR4YzCNuhCEkjnYlI1p93zx3K9qg4ZxRg96Wv+O1wXfsDF3pP209sfvkVcG+uw3xOegow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441761; c=relaxed/simple;
	bh=qLmBIT2p184gyk/YaRUZSSQlbcTdqfE3aiJ9IEmCNZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyuxBETdacJ/2nakHBPXCjI8mpuHNbE8ocKrAu4sa1Ko6DQZIX3ypGXHEwUW/v1zrYLAgQFezDe1svANKg+WVu9IaLEb24+OSKhhQjSghdVjK9WcEgpyzhW3955pn/jUotZQzx7g+MUFxl5sU35oWQkshVqxY2/Xb6p3ubGQ9LM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M8MCuQe9; arc=fail smtp.client-ip=40.107.130.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExEGE+nAYPBgTtEHShzedNr7SiQKNCsgtA83Avb17J2T6iWmyM4K/jsH0sBME+dkboXULcoYi+KWDvmRPyUbrQOxIeM3WEdTVoM6/My2cuBtJKkpbzqkwYHSmYPvLeIquPcVKMAMHklQBJOa1akrPNLdLhRzyuudtMRMPegjhTTkAnjXDbNEjRXaq2DAWcq+5XlS3yYuCSrhblfKiXMhYjPgVIdpV2AgFE1Qk+q73Fgex74pkNU7eKm/ZoAEm4aBYnCx5OX/Td0UrSdVzzh8+WpZhP97v52vBCmyWy6cs3ReZdc2WoguOqdZvub/i3W9ECLrk8U30D1yUeHg8Q6YEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjp1PXnRpCaa3tJUGIQ7aRgIccy8lS3ILDjO4dEx0C0=;
 b=AganTRp2hBvF9XueXK6dQNuSoMTqBsidZ9rp4doDFCsrfq0NZ5DIj76Nuwup1Y1oFJfeSp1OAdrcOECQ/Q8NXBcleOHEKDwOwtYi0gPE9NhMo1qcaEMEyaZ2irN9iZhvT1Y6TXhUw7E+Kt/eJg8pUvGMkzLhY9NFrRTBwE76PQUkhrSShNNUjoPEoTC6dSX59iozYGECAvZxAGYmL6K4K5ONY8xSGFsRWCEX7p+exGQ2XydvqfQJ6TOnFx9N+OpIb3eClWxITe07+aNTML3X+R9XyS0R52NW2aZmXown2j5kiD0KR5v5J77OpfrIWWCWyyMYTDRw7wRg1LoCKOLcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjp1PXnRpCaa3tJUGIQ7aRgIccy8lS3ILDjO4dEx0C0=;
 b=M8MCuQe9lgEkFZF4U/RjaGeTcZQbtl6eXYQUzrX31oGZ3S2UTiwwyxBwIZRVTHvYoajE4tJHGCz49vPsoZSAtYZrDtf6h3M+N7g0yCrQ5QJTkLp3+HlMmsfsV04DkEgBWyoDdZXp84GOAgxdMMapBXQdGBTjQ3MFZd05i3wrtzpwhh6MDR9fcxacN5JlqShDujZVCLrD78Ke3ZOp/a1iuo5jHb5WOvXaJyetrnXCeWsc4MZDLkc31r31D9JFUMBcbX4KXX/K3B6yQ00A340wFfF4MCie10wcjDlWJmrp6SQf+aPE34MGf2nndQWvONoWhNxBlw9Heea21sB1Tyk05g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 09:22:37 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:37 +0000
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
Subject: [PATCH v2 net-next 09/12] net: enetc: add CBDR setup/teardown hooks to enetc_si_ops for VF support
Date: Fri, 22 May 2026 17:24:35 +0800
Message-Id: <20260522092438.1264020-10-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 219feab9-9d90-4458-9920-08deb7e3a9d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|19092799006|22082099003|56012099003|18002099003|11063799006|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	XqBB4LysFCibMCjAOEbA+49W2pjGiaVO1JvvMXsB9TQ6RoffyOQyYPLpI2ENi+Di/BqSi8KXp/UJI2Pf06zc+vWq6zahZciQP2HRW2Ca28ia+F1AH+FzHg30EMHm9hD9gzFSnbGsrz9hLlmh8krGduJYGVOaFMh6egppS+YHb5QRn4YG4/kJkAnmmY2iiSn8d+9wbQM5Lair49y1V6S5HM+wLhdm1UpJVy4i0fUn1BvE4XdO2zqzEvTJj4EApVUokyzP6/M0nNLH3cywQqARXQPkpTodmDZe9t/hwcK28rtoqyH3n4ZNoxaM2J0wvPPuD/UWHQbYl/U4sJe/MdFuNZ2PhXEQ8Q1yE4rJdh+RB+LuLDoBS7YcHipO8j6a+zflVNrKwBNb2bb3/HAVfCPDTky0h/8FTTVY0jw56/v6yjRPpplue8BU99CUH1F8AWb1c5r52WNbtWTO5Ko8d61r5ko0MKSJCLNmY8QqMSbywG6vQAyzxJqoBKSM+a2dEVn4HMPZQ3yDozWb7cd9VPmUFjXZpMQ4WzZJ1FKTiT2sWnpcxx5UiU03pAGYj+ilk1SViK9uy8rfj62ktAKyRigmV16z2fb/IbuXz4ECNZiXVsWG4kWNhqg0rxBKIqoEwuoZNhaNAMxcAAQgl94CqfTjLWSAly1Cn4gqsCQSGcLfV3RPFH6GFnMIVL742dmGOmg4JUPeItjtLimKPh6TRDWt/FrDSqAJBXVOUYpzcY5vVhKPLWx5fmIJsxQ/LBxlQzNk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VBjjHeC/T8r237yT6EEjwAWBDeWYepICtAi7qKZ4FUNjXYej/MTUfwiip/DI?=
 =?us-ascii?Q?/YtGht36sv8xFU8SGMRxlvvqFivB52OP0h/b18Mh9g5c9tnFWzG/3ikxs6AF?=
 =?us-ascii?Q?PmeXMeyuXCkDxLIRtWpUvLYEWvB7zGQdl+9w0EY3LGtwue270tFEf+aoGGer?=
 =?us-ascii?Q?xdXXS25mCc2FIid03bw79tsLbUYnI2bvKjJ7RXfYbHBVVCZ2s3UkIBW+KefU?=
 =?us-ascii?Q?BBkMb82GRqqsq59MivXJXYguhbcx8wU5JxlnCLryonTKHFPu4/ZKl1Lj9HBN?=
 =?us-ascii?Q?h+SgN2PVKJk4aLuNsHPGJJRpuACk+Pp7j2Z1K1kctoaYXvata+fLPZug29LA?=
 =?us-ascii?Q?WAyl3G23Zdw2idj3G5lPW31qbd4UpmcSUeMbTEwDczG+kSHIRlmgJgt2W1nY?=
 =?us-ascii?Q?0haYCwjgump9548476xXCUg4ADfXSgpBdzAOZN7svOJ97ptfRhFv1IirlxU0?=
 =?us-ascii?Q?gf7TwCdxRxTk3yqr/Z+m6vCSpKNIIApMz5438B/gFLg1CEoBHCjgfmu6KfX0?=
 =?us-ascii?Q?hiOJojISTd5dEuAcuFTjppdPgoi3SFSC0Kb0DlwtYvFHZVMc/Tx4RFru1bNx?=
 =?us-ascii?Q?nIwaEF8Z46X0hjRDsN6d1EaenszEBjIxQCWNyNf0WA4Fahsv0+jilQBm9K0E?=
 =?us-ascii?Q?mJBNP9EfBWS5f6mhGlXLTTFMupFFqMS9x7LuMoWOpeGwrJ3VkeNkzz2+zlqo?=
 =?us-ascii?Q?bjJYuwrYpIXW95c4CfGefqjeLAokhwvgxTZE71C9lzryik4dJJ7PZQwMHnCz?=
 =?us-ascii?Q?yR2KGrX6FaltGkB+pxjgjVo0dLehdZ56eHATyWw0V0aV1pNHriNzo7i/Cwkn?=
 =?us-ascii?Q?eMdF2gXyzHDFs3AZKIbGzvNmhzrFFLulAmGwg8H3hr/WnfV9o81L/Oa1KsMe?=
 =?us-ascii?Q?CcRo1Fvhtcsb9rRL2GmfLgk8YK/atVdOmRj5qUFhojqFKEk9zWWvbHT9iDbp?=
 =?us-ascii?Q?3np2kkrUEfDSwdZOlCRgaooxaT9XOf+ahatGHeE3It3B4Ym1G6T117vuVBub?=
 =?us-ascii?Q?ZfsWT4sK5D+h7+XQ1EmnTS/SEOqUoR/3JYe+Ye1Ib/ArIVuH6aMDFy3xctqo?=
 =?us-ascii?Q?2UKVFLXkgBSs70Q0emPD0Hma6wggpY/T8qi3xj9L5sf/zCgPACuQWvTK+8Yk?=
 =?us-ascii?Q?s/2NfZwj9p3+hNP1TGDeutWTjrKpsVJjlEOVvdky6OoHLrYKj61z3psh155X?=
 =?us-ascii?Q?YK6OiH8hTId7nNIzhhzGlJi3P62TY2FfmtPE0P3iqNjr/VwTKXobPJ0Q50sw?=
 =?us-ascii?Q?QkVPb5NrV3rsEVgWmpvC0sY+Owd2zMPJsj9LnqwNo8M2htgDimZ7Y0mlR5OR?=
 =?us-ascii?Q?SPN/41xNJ8YdsNg/aYD93VQY92cFME8E//CVfA3ZEF/ZgCQbz45W11BHuKJ6?=
 =?us-ascii?Q?TfkIjR/jcBeP18dYnCeRQrLjyimiQ7X7qwT4gOvu6TfWuvj8aq5gBIqjiI1o?=
 =?us-ascii?Q?4ugC2r2ZBz5Mn3oPc1EwkEN2WKrm6sUZDAJ61LW1WZIbCTjr33iAkpw6xrq0?=
 =?us-ascii?Q?mZVQ+LbPSAfLlVir79n9Cmr2mJ/v4/uS13SD3gdLAjaudb9F5VfPAWVcTaXS?=
 =?us-ascii?Q?T4xBExGQqHfJi4YNWV6GgLAwNfaZ/TmajZ+4hPbQmxhKyead24g2q4V0L/lT?=
 =?us-ascii?Q?UlUiq0XJQHG2oZgNnBeC3u2tK0hvWF8Q66QkIJR4C8Q0tuN7h0jbqnYdnbu+?=
 =?us-ascii?Q?Lm2+tzIwgDHGKCAC4N2uvxwCZwjfxEITvT0zO++9G6nIUVB2AW2NIWsqlJ/J?=
 =?us-ascii?Q?emwuZmfDiQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 219feab9-9d90-4458-9920-08deb7e3a9d5
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:37.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9gdTW+pCpCUYTDvgN+lKJlEfXarkct4ev+8qbDygF+sGL6CXd3o7DSd4XenV1U2/p0o+p0x2cIALiS/+4Sa8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_FROM(0.00)[bounces-290742-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: D507C5B12EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The upcoming ENETC v4 VF will share the enetc-vf driver with the
existing v1 VF. However, ENETC v4 uses a revised CBDR (command BD ring)
setup/teardown API that differs from v1.

To support both versions in the same driver, add setup_cbdr() and
teardown_cbdr() function pointers to struct enetc_si_ops. This allows
each hardware version to register its own CBDR implementation:

- ENETC v1 VF registers enetc_setup_cbdr/enetc_teardown_cbdr (existing)
- ENETC v4 VF will register enetc4_setup_cbdr/enetc4_teardown_cbdr

Update the enetc-vf driver to call CBDR operations through si->ops
instead of directly invoking the v1 functions. This enables runtime
selection of the correct CBDR backend based on hardware version.

Changes:
- Add setup_cbdr() and teardown_cbdr() hooks to struct enetc_si_ops
- Register v1 CBDR functions in enetc_vsi_ops
- Replace direct calls with si->ops->setup_cbdr() and
  si->ops->teardown_cbdr() in enetc_vf.c

No functional changes to existing v1 VF behavior.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h    | 2 ++
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 772f0ab2f8c1..04a5dd5ea6c7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -297,6 +297,8 @@ struct enetc_si;
 struct enetc_si_ops {
 	int (*get_rss_table)(struct enetc_si *si, u32 *table, int count);
 	int (*set_rss_table)(struct enetc_si *si, const u32 *table, int count);
+	int (*setup_cbdr)(struct enetc_si *si);
+	void (*teardown_cbdr)(struct enetc_si *si);
 };
 
 /* PCI IEP device data */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index e8ad5ad5aba4..9cdb0a4d6baf 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -288,6 +288,8 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 static const struct enetc_si_ops enetc_vsi_ops = {
 	.get_rss_table = enetc_get_rss_table,
 	.set_rss_table = enetc_set_rss_table,
+	.setup_cbdr = enetc_setup_cbdr,
+	.teardown_cbdr = enetc_teardown_cbdr,
 };
 
 static int enetc_vf_probe(struct pci_dev *pdev,
@@ -328,7 +330,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_init_si_rings_params(priv);
 
-	err = enetc_setup_cbdr(si);
+	err = si->ops->setup_cbdr(si);
 	if (err)
 		goto err_setup_cbdr;
 
@@ -364,7 +366,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 err_alloc_msix:
 	enetc_free_si_resources(priv);
 err_alloc_si_res:
-	enetc_teardown_cbdr(si);
+	si->ops->teardown_cbdr(si);
 err_setup_cbdr:
 	si->ndev = NULL;
 	free_netdev(ndev);
@@ -389,7 +391,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-	enetc_teardown_cbdr(si);
+	si->ops->teardown_cbdr(si);
 
 	free_netdev(si->ndev);
 
-- 
2.34.1


