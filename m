Return-Path: <netdev+bounces-290737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GwEAPMgEGqjTwYAu9opvQ
	(envelope-from <netdev+bounces-290737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:25:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8F5B11EC
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00BAD3022647
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3988F3BED66;
	Fri, 22 May 2026 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IT1+2d5i"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA813BED5A;
	Fri, 22 May 2026 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441742; cv=fail; b=eIhB8EJXBiCnvwD+qfkwveK/Jv1VZg3++G4WMoWkwxWXg2B9vhKhHbkpimi1spk6AEdFEarPxgmJk1bkbXB547aY6hsLRjz2ScWLoeK4FB8WEGFwdhEYfDYcyrYgei8Tlf57w3Pkfa9YQ0Je51Ermdzk+5SmdWg/xWCuEVM6xJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441742; c=relaxed/simple;
	bh=m35r0+vxiNfnW+TQUGz8EtyjqyGwAUryVUgBKlZsGUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HNvF8ILebssMryKY33jgq3EMmMzVO10mCvxQfr1jNVZiDxXEN3LRh6CDFIrkqwxE86SAmUpVWltZ+n4MS5kEU4t0Qf8F2WTIcbWA9oekXTVnZ9NZW/f6gIPNw4KBXplkIzXMQoRTbg2QN5rT8b5y4fl0PLLLVM942eybKXsXzXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IT1+2d5i; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfONF5Bqx++8TFPHzRGKdHhnh7ah8t6OLZ23SQlXnfW7CkZ5e1sJ0AY0+lbL51/Ximq7y615AfXTj9RwGkKevNHVS91XE+byLstQsQtoXh7F96r+FgXQ6jgOOJbDvFHXnAEvWz7yUK9UzJWcCC35nAMXCetYboUpAc3ZZjOnVvlxhE7CDC9EVO2poU0TzVjmW0xLWaghmpLxsOqD3i9fdIq5dBWRN3TyyLYb3eO5vjrGc1aXBEiqTKdsJi/THHSICt7p2CdVmikB6fGUQ73dPH4LDgmC6Dw+9ClsseBYlTb2UZIrsT9wikNLZ9ANlPYYwjD+VebgL1dCljIGyDG5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kP81dT/0fx4TbxkilRVVPcnd3od94oG9LNMUjWkF2I=;
 b=MdS89PJGwmUuIxKLfUMLfac4e5f4AfexBy6arBOxaKgOclSud2CrTR5f4TBfuGP9YLRvUQvPS2wfJA4hqHAlT6B7gj3s0YuqrqOS+uqgOwCAQmGi1uPPyQ3T4et6lKBq10yZhH8ZbZTZ+NJfct5tpWzUsjsSedZOTodvyOBKilXPl4RMiMcbiYQNVSQYcZPkaAF5ujGnChJOjxrn97rY8Llhbr6jraQ0CFKtw1axwmcS9U/jAN64elYRwfWPmQGuHw7WHTXDsxXw9ar4ZKswp+2+ttg2o+DqZJ45lghnVr0JIeOQkZbvzKUfbyjGryQ8gDGTMdz8RoHuylL+RmwJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kP81dT/0fx4TbxkilRVVPcnd3od94oG9LNMUjWkF2I=;
 b=IT1+2d5irwSEBrxU62xsMfdIfw62YxSdpREv06uZeVvvddUOouDwlLxweBe7W5uVZR8b7kj+Q4sdXrhBUWA8iajemNqLEb48V2+bjDx9r7T6NCqrVkoiDlT2qjbqHcaH3DIVcCwnHBW3RUkm87lp3AemdihzB0azaWJCJKyDfokHcmi6iwydKjCje56znvU+HcC7gqC78rYtLn/pYFIHPtWMXT78tuoBjU/kdyN96oglhOSWNvNMKjLBIpUcUwR4q5YprW8d5keOHJfBa3iJsL2CW1tnbJhEfiNiMo3PP6ZY5NA44hDKIYOzx1Z0eKrnPkndLdq3FKyuyWVo5KSqnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 09:22:18 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:17 +0000
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
Subject: [PATCH v2 net-next 04/12] net: enetc: integrate enetc_msg.c into enetc-pf-common driver
Date: Fri, 22 May 2026 17:24:30 +0800
Message-Id: <20260522092438.1264020-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 775ae95b-4239-47d6-769a-08deb7e39de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|19092799006|22082099003|56012099003|18002099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	0nARBJd9TqlE4Xm0Ntu5xm2CALocwM4EiEGAw8f7lDGbeSMFbLOf41kHXi/wC3FQ6uS9o4PQTezQXnPCUH/I3WpDNGtAQq4iZkDYh1AIsNA8G5mCRdQsksmTn97O6ALAUtvbUYDoHciROPRei9Wm+37cs+4UuI8jnBYiqu3FNqq8rfjdSh8IMa+eFwLtuAlWoWMutWw5q5DaxaonsS27Sb/pEEsYcZlbvDpd66D52MpNps7U0T1b6fZ14PgkkTFYTaGcVi6g8GHBepu6pHXjFxs57BTa9ERtt0He1UJital/T1WR6897wvda8bymoN5V6r2PoOPRGdzp/u3VhrLVO7VYLOxGcLJ8QL4PIw8NoIvjRNx66kCvu1aX5pka8/ryzqYZS5Z5poi4j/9XGoHIxiHe9X1R08JdDHG8GUgOQ/1/eNIH4yAkIY9B0zu+ezVfcEOvII+jSOqyZltWgNAClm30+EBmCnoadVtzoH7XzRhtJcYHYEf6KrOJy8Mu/kysJlvdpQVXMmojkfkpdWiHY6BMy898pjLXzJfekpmb/YlOeTmr9Nic/cItNVGwteW6uN8VOC/v1wZexJBc/rreeR5czw3WKKyStG2ce66CVRG2ljtzjJD4psuhA8bSDSW+k1q5Mx+tYzYpEkKGOiP/GwcuG+1vuQOdQc8yt72wLg7qm+wWANDOXYJ2UvN4nIJ/QAXfnpHDonJiiJ1cT8rEXQGOeHydQeANldVHbhWzTYZr6WPjVW1g4Ib3LUaJXb1H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CEZ21JaX6XGw6NMOOkS+3lpB5QddioWdYiNRLWfyqxdhi2e7O574iXkPMM2b?=
 =?us-ascii?Q?VUMylDtvEm0BxMXoFMB5rZKhFJ3SVBHx2B2rlczbOFmSLjdQ/p5oQEjH+Vo9?=
 =?us-ascii?Q?4ozrzkWFA/cOMmqrprlE9NBWcK+vECjErFYfStxLYuj7aGjVg65wBUjY+Ra3?=
 =?us-ascii?Q?Ga/ee7iw2P/Dpqt/pbTB7fPdtGX3H2UwcjRa8iAT4/QOkH5HLWnPF5+YX0fu?=
 =?us-ascii?Q?h/K1oB8J72Aox0wqbnOb29sqBgITUBLPTsFZrCImK8spjtjkIeQFFMidIxvf?=
 =?us-ascii?Q?R6BXLTyndsNVBg+PqKCveFD6eNh++O2nnUZeQEGmuHgNBJkFLW6FCll6C0N+?=
 =?us-ascii?Q?A40bs9JZjJomGG6ZoxDDpnouDtl35MrmzPU1nlFum+7nuFJZ6MtoPO2pUtfN?=
 =?us-ascii?Q?G35PcikJZ15ExBtkQEj9u0WsKQ2DAFN3k0/TGuccLFcPa1hH2ybRlWW9zKtK?=
 =?us-ascii?Q?pGpoiXIlS2GHadEJuICvjEWeiM6wVQjtFxh3VdXt+TeauG3EZU+KgDh4TWRp?=
 =?us-ascii?Q?bik+kJkqdBwckGbp/sz2/WX5d65VH5XS8p8oqptVO5/OWUn04Ug7ZoD6OY1Q?=
 =?us-ascii?Q?zWbtXg8VwXq9rmTuh+k2xuUuJHlUAvnmhE1OuXo0jJRe2IrsHeNhGnMKShyg?=
 =?us-ascii?Q?F1+52YPPBBWXFP0YjG7e0NWxMDQDIeGgfuPvQ32jDEkKCf/FOQGOjmeHEGRA?=
 =?us-ascii?Q?hyIcbOA4NOzKLpgNcvXfiVHzTg/ofoAmM/b1Mk8dB/cpCf9/lqJfMEvoTbb/?=
 =?us-ascii?Q?Vre7OCLuVwNrzh7MPPAmEWnuAZzYxSQk5dtenX3yiz7Cy05l/+PzyBF0CgBP?=
 =?us-ascii?Q?McoHe+D3rIKUPOH6mif2a0UZqKfD+KjN/Bl7vyRPIM32baOtpJ9/93cUxCul?=
 =?us-ascii?Q?IgQR90hogpywYNs3eGzGRDbqLsDdxZi4Ux04UfXP0tSbM6VF/9GklgZQOdoL?=
 =?us-ascii?Q?wmYBEZCMYsEPddufugid4Kcu3a68adHGndWMox9IlUl/x1OInPIBbXKSrgeq?=
 =?us-ascii?Q?9iaF05J8YfJVhO6lWOtKgKjUQoH71rYzNUxJvBq38uRPCPUrM14kUCC6asDo?=
 =?us-ascii?Q?uQ+J6sfWSDpWqmcsmqcDJeHX1D25DOVWdDnCQqS5yV+ZPnPEcacCa4yBfgMx?=
 =?us-ascii?Q?OpZFjOONyfchn2GSHPNlFvyKjG+zh5Oc61VdcgsPmXqyBrm/U+VhARsnMTWa?=
 =?us-ascii?Q?UX9dJcv8hSjoShgqXvyk46iYnorMKEMKCVbhdcRcGJ7o/O7gimfGs2kvAIBE?=
 =?us-ascii?Q?YmVekJO9tmjNTReVYCr+jiiv51WT2zoPDUF+GE2W1Eq6tSvW76wIQqksFkJC?=
 =?us-ascii?Q?1TB3dDHs7+HEGobEml78rYzYmIyFmb4jiv37f2TBU+4L52HORfw9ktG1Xhdb?=
 =?us-ascii?Q?BwdOCtCzGFWuTGmFa7MxLsvgJMqQuQHwaxtjlLc6d4oDB+UxVw+lHR3mzvtN?=
 =?us-ascii?Q?4uxA4fGnm45+tMwQcEYbMatx1tJC0ZgvngAhsNrW75dQ2iPFg5Jr6/AEVdbz?=
 =?us-ascii?Q?WXzA9t5MiGAFEHw4FDTUePwGgDez7Aigs6RwoXveB8jUauLk4WnZmKQ2oDkQ?=
 =?us-ascii?Q?DWvKSfj8NBAyb8n1mBojlopn2EsomzVjlFwhUsjvvm33GIBdWCL1gxqUG6dB?=
 =?us-ascii?Q?GHsQmr5vZFrGZZewxS2/LUj2I28w2PsM0qnUXLQvEeXCq2lGeKdNwaRCUOil?=
 =?us-ascii?Q?wU9rv0KAtoZTjKFWcD5m4MA6mX61cAn4dB5WwUbQSFXfJsLb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775ae95b-4239-47d6-769a-08deb7e39de4
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:16.9744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20+OWBvQQJdH3HoW/NtBMcXWcfiVkQ797ykZJUlaEVbHBZ8Aem+EHidbHQspX4X+Wr5DjqtuHik6U+dSafbvKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949
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
	TAGGED_FROM(0.00)[bounces-290737-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: E9E8F5B11EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move enetc_msg.c from the fsl-enetc driver to the nxp-enetc-pf-common
driver so that SR-IOV mailbox handling can be shared between ENETC v1
and v4 PF drivers.

Changes:
- Move enetc_msg.o compilation from fsl-enetc to nxp-enetc-pf-common
- Export enetc_sriov_configure() with EXPORT_SYMBOL_GPL for use by
  both PF drivers

The fsl-enetc driver now depends on nxp-enetc-pf-common for SR-IOV
functionality.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Makefile    | 2 +-
 drivers/net/ethernet/freescale/enetc/enetc_msg.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index f1c5ad45fd76..10ab6694c314 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -5,13 +5,13 @@ fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
 obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
 nxp-enetc-pf-common-y := enetc_pf_common.o
+nxp-enetc-pf-common-$(CONFIG_PCI_IOV) += enetc_msg.o
 
 obj-$(CONFIG_NXP_NETC_LIB) += nxp-netc-lib.o
 nxp-netc-lib-y := ntmp.o
 
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
 fsl-enetc-y := enetc_pf.o
-fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
 obj-$(CONFIG_NXP_ENETC4) += nxp-enetc4.o
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index fd1a42bbdcb1..f696751c00ea 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -284,3 +284,4 @@ int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(enetc_sriov_configure);
-- 
2.34.1


