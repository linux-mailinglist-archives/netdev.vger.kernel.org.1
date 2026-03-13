Return-Path: <netdev+bounces-267357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMjmGQPds2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:46:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7738280B81
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25E263035ABC
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE803603C1;
	Fri, 13 Mar 2026 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bmdxAgpk"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BA282F26;
	Fri, 13 Mar 2026 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395095; cv=fail; b=faflnGmKp8FavfQGUWwXhgm6z/+qWLsMRiCXvpC/PYQa+LlurKU0ruOEYIQstsMC/PUWVP6f71KFTAPOGcS5l4/T05rJRcP0np6SYlNjwz4ME1yxyuJyovVwJSzdSSJZFnpOCKmTJBtiWtkF3PQvuOw1NefNjYcwT+VBiIlWljE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395095; c=relaxed/simple;
	bh=AiI06e6o3tExuyvKphyLMkoeSdgbtwOSUzKXHncuVjo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r9cO7oIf8NGcCHP0yumueSIp9Tnw+nB4attsqJBhxV10RTDhurs/vV/J8kPZh+rWs1IMPPy6RTPKvvVOxmegul/TFxvoWYMkTLLGjwYthGlatV8FUX4XRw//Tnp6/aioYU0nT0RsCnMCJs4J9ZepZsb5c4P47oBF4/mO15r0ssQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bmdxAgpk; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxHD/DZJ5+ITgacWh8vGZ7bE7KV5suQdvQ5/CWcSbmzf5d5iovMKtk5wqN69ixYvOeI8o/uwUGZtPcZwGhT7ufL9MIe+8EtXZw8cpmhrzwIu8DSSfHGVUlKOs5PCTgmVqMsPcMolDMMUN7d4+03iJD1t2hzl68Eki4eLpHU7N1lqoI4f0/oIIIxopiy+stJV3hZ1trWrN/mcKh5qrbyaotWK1MmG/f+5xPEqQ8uNuYY5vIE0Ie3WSlySuFnAdrulT7sXaHltrAvXLZSi5tBc5OG54QkrtpyeZCstqt7Ekav8axRJ8cgsDgEvQae/L2drvtQnVFatyezM+Me3rVpm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLcSzPPneqHAn12m3EsuUTumkxmm9sEe5wz/AusRs7g=;
 b=WKKVVsZNZ0ci3UHS+8KIsYaeGckxdlADxSuyIAP+bh2Bn3bj5NiRUN5+uvZUO8/8OLXK2om9Q7pMQu3EDf0hlmfu0Y2JLyn3pToxTqJces4sY2ya9gLKv87dABnYzhkH4UzzJ7Bxum10lbKxD2XiKeXU8o16pkcQ5sQahT/1lrxVCxOza2au9auxYg0aOWKtgXzDwzAswyFAaHeaaHKJMucIIJwARNTn/KlYZAOIG0olsEa5YZSXEaXkwP4NWwQABqzZEnX5Wgfd03DaTcWazJU2W6VisPqFDPIAXiMY45dabbVRCsPEWjFepHnWHKFHRUv2o9868yw9j6X3AUjBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLcSzPPneqHAn12m3EsuUTumkxmm9sEe5wz/AusRs7g=;
 b=bmdxAgpkngk9qhPHBhaJWFXXiXnmAQ33eLL05Mu9gRdQ7hKrdcANtxyOVLe2fmoviptXDCwtgMRxZF1t2+aB2nGasR2XRsa0F9RsajSzw9PIPh3k3X+b7M/TnpnMEA8ZJrE0hLLbfhSaVvgKruggo0kfX1ICOX4Ef8Neqk+vIi0NopKh9rrMMjVxOq//xzJDUIad9qab6aBe6vgiK68K/YR5aAT4rqeuduxNXnmOTPX3l7jexiY2Ube15nF6M/rqErGCGIYB1ipA8353HezBkDFZSXXbbn7gZEQyxKnJo/fIlaZaYk1zxj+HjLd7mA9SX/QJeyTvMO+MTBGQvw3IIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB9100.eurprd04.prod.outlook.com (2603:10a6:10:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Fri, 13 Mar
 2026 09:44:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.013; Fri, 13 Mar 2026
 09:44:51 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	Frank.Li@nxp.com,
	horms@kernel.org,
	saikrishnag@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net 0/3] net: enetc: safely reinitialize TX BD ring when it has unsent frames
Date: Fri, 13 Mar 2026 17:46:41 +0800
Message-Id: <20260313094644.1132411-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU2PR04MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ec08e6-fe73-4799-ac29-08de80e52c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vPr8E83cbHN2PLwxmMfGS0gp+93eLtSUz4MjzaFI0tVDzei6fu0Ly8Ojs7iNxDn+7opHOLiJ3Ps65jAasJMCsVpNBZtYtQ8SfnAr5ONnipULj8ImQ67YmF4H15QTOhh6ZdA0UCmzf5RCMmxWqdm4/Zvp8xwOSLckz85cKymdQXIUlwC9jtVMrmipNa86hwuFVdnIOrqaeyiwAf8C5bsZ9rRUy+Df/2KRc79orVB81JhoBJ9cni5LTvfttvnazuvOB2Oh+rW3wl4UWEr5oLp5uT+10OMs16avgZwjBBOm8+I2yZSzg3CSlwqRm9mccIZG6SZ/nfqcI0a0/fqIk73evN7xZFxVXHDSFkmOMHjdNUwD52RV76gslNA/JQ+a7XWlqwP/yf38fksSYxIzyhzEZ87zyG89ZYycf1fHdhAxGic505eraA7D5IYetXaxvvyRA2gbE5lhq7g1o2Qk8XD134MGPW6U3OEm7lR7g+PIFRgFB9V73p1QkPdPTvJRyumi6ce5eoQRHAexpDK/WBDk/s9dqqu69giGD+Ix0rFDmIY6oOjkx/s78R1886UFo81Imhdh95WFwa5zJcZb0Ab6XlSHVRnTgean63fsImUIzcQY15YJmMsIZR7+0B9V92UwX9POW1CgpUnpJsWHPmh6p6v5Qzhh2Lu9gMHRXhOZ40/RJ9/D72LAf+3xM3U4GrvmB9zRMIzqWDaBrrLJUAqviwueS4rbGDDejqcHbPFfaqxRF9ofqMSA54drz+66MrZ7pyIQDAgRvgeP4e5ZXFALohsjL7+oner7xKgYkqRtRMJTWId+cLY8YSZAUC3/TRW7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KDQljse6cV5gaxDA9Hfp23j9Ci8l6EIx4HQPtW9eh8C7WQIftg3nRz3Rj/xA?=
 =?us-ascii?Q?SHoKXyFiYJ/odI1bGLiGmHGteiaLGv+8BOl92wlT4w32JarRDqGDoTfmSzZO?=
 =?us-ascii?Q?lY/a+sM7By3onwJqI+t0cdS8mnjp426a5PDrKuxD755rUgDhka5Hi1cDWV6X?=
 =?us-ascii?Q?G4qS+PjKlN78DZF5RNQIXjJhg3FLmg9mHHzwCSdE9NnJy/Q5zmYox71zZnE7?=
 =?us-ascii?Q?ZoNrwD7ClnAMf0C1CeotSVEhb8/fxG8O15zJIFiWSABLhVX9OOu2rjM+uzu+?=
 =?us-ascii?Q?e8cwSDAnA/wfKN4RVB9b61usSg+BrCWfhmPAlMVZCcSFsJQpS3dE7b5M6FT0?=
 =?us-ascii?Q?337T+JCStUrFhoYPLIJ5WgSjVJ+Fc1rjl2xbR5V1mhN/LhMiNf4fuZW2Ffmm?=
 =?us-ascii?Q?HpXvcEEbqlV+uSbPFM+O9/P3JoM40SFBTfWJTMcudRlRcJkAdIdSU38oBQXe?=
 =?us-ascii?Q?zJ2P3U4Qfl7335K4WciodIp8Jh2jyhaftqJFbPaT9R00Lb8tSo8BVma9bPN2?=
 =?us-ascii?Q?12LvUoWV/wb8Yg4eo1AD6mIG4OT6uOJkqjq3XrAFLURKCEdSKqpO2pWzieOD?=
 =?us-ascii?Q?c0nO3TwveRQixTYDPj5/39RxZ/tza8LEsPCXCRbGZ8MCo9f4oGJD/jHzwWmI?=
 =?us-ascii?Q?PJIz1BKowFAC433nMovcC1bdvLjkZk+3yJM0mEHZf68JccVjMWr5MKJByvrO?=
 =?us-ascii?Q?42TFpO2hl8Knyg8cnclQHmnVMB5fgPLKSa4Ohd/U0s0CRERpWBd7WnqJt6TH?=
 =?us-ascii?Q?vCtFlwiEPJ1zzPD4nnuUE9OrCErjPSTuvGHmlJK6xHJr+35zr6iW8DZZUA0l?=
 =?us-ascii?Q?M9ZJiuLO1F7yjm6cmNsqCTy7nxx25rD2cTwh97D3lW3a59p/HhjPn8hSk9Bd?=
 =?us-ascii?Q?dH/LNQN4uPBRWQ2oa3ymA8gbmyjQFncGwcemHerPnazpFMbeQ2lUlNJmn5CG?=
 =?us-ascii?Q?4SYTscl9uyciUFRnaEl4Q4KzTzNZsJUlebKcQM1ikXtRR1SGYVTAhzEf0Ybs?=
 =?us-ascii?Q?guVj6J4xzKdiC/MMl/7S4Nf5a4imgasE7bTX9U3ya2Sxg36pWQ9F8lPSkAzE?=
 =?us-ascii?Q?RPrU+DLS1u7VapcuElPj3llO1wFBaBVpRBxk/s9XGBMlZYWXF7WA3xn8su0c?=
 =?us-ascii?Q?73D2YVCUPEWo+VLyS7ILcVnpE4YoWXsCNjSDZ6IgQsM7jLwvOqRU2aDGvaKE?=
 =?us-ascii?Q?HTuDJDpGmxXwk1FAldWJLYkqlcNy0P8NhSlZT3jmyKZ58bvuib90cOXkjf6w?=
 =?us-ascii?Q?ISIb5VKMxOzYEEsOdt+fG7NOOnmn4izO9Fx8h8yjVuOT90QtCcWOIaRqYNj/?=
 =?us-ascii?Q?9v/L3Cb3IiVtDwP/bYWVo0fD3h3xEoYRg6HE6Rlf8RRXZSSdWi0Z0JgPQRmg?=
 =?us-ascii?Q?D6ovb1DzuMaMJCWtpPIesb2Y3V1ccVtFI1XNEd/0S6MWzRdbe96Wbdsw9tBh?=
 =?us-ascii?Q?ljRZQIpFRnGPkhqALdwI+E95yyJIPPoOtNTFvEqfRXOZDoOnsIjcvuQy/P2H?=
 =?us-ascii?Q?f8tdObDa50qLDauT6nDRLhQrCmsT3KLXHdzbWj0YB1AXjtNfVxNZMgBPFP3/?=
 =?us-ascii?Q?+a3WpzwDGC8dT3UF7qL1nsFV2y32n+QgW9Sc18HdbF0I8vA+ozMEbIt0FdDx?=
 =?us-ascii?Q?YrdvxojjhE+3vaZEiMXw5UPbKtFYPpaB9T9w45UnyTHZsVHOIxcYDeuVDpTb?=
 =?us-ascii?Q?QR63NVnjrjj0yfCwX9w/j+2PlW1w885q4SWoqsMNsorSTxmWnsK/FMUVLpHp?=
 =?us-ascii?Q?bvavl3NUvQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ec08e6-fe73-4799-ac29-08de80e52c82
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:44:51.7926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+vgosCxCxmMD0cP+SJjqIHiBfcz4sKyubXxab5rUpLCwjX0c5AXkEs89wyKHnn5nfkOGe1tq2gEXLOwiKFsKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9100
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267357-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:mid]
X-Rspamd-Queue-Id: C7738280B81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the driver does not reset the producer index register (PIR) and
consumer index register (CIR) when initializing a TX BD ring. The driver
only reads the PIR and CIR and initializes the software indexes. If the
TX BD ring is reinitialized when it still contains unsent frames, its PIR
and CIR will not be equal after the reinitialization. However, the BDs
between CIR and PIR have been freed and become invalid and this can lead
to a hardware malfunction, causing the TX BD ring will not work properly.

Since the PIR and CIR are sofeware-configurable on ENETC v4. Therefore,
the driver must reset them if they are not equal when reinitializing
the TX BD ring.

However, resetting the PIR and CIR alone is insufficient, it cannot
completely solve the problem. When a link-down event occurs while the TX
BD ring is transmitting frames, subsequent reinitialization of the TX BD
ring may cause it to malfunction. Because enetc4_pl_mac_link_down() only
clears PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
doesn't set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore, it is
not safe to reinitialize the TX BD ring at this point.

To safely reinitialize the TX BD ring after a link-down event, we checked
with the NETC IP team, a proper Ethernet MAC graceful stop is necessary.
Therefore, add the Ethernet MAC graceful stop to the link-down event
handler enetc4_pl_mac_link_down(). Note that this patch set is not
applicable to ENETC v1 (LS1028A).

---
v5:
1. Add patch 3
2. Correct the typo in commit message of patch 1
v4 link: https://lore.kernel.org/imx/20260312095415.669128-1-wei.fang@nxp.com/
v4:
Correct the offset of ENETC4_PSR
v3 link: https://lore.kernel.org/imx/20260311084105.3982037-1-wei.fang@nxp.com/
v3:
1. Split the v2 patch into two parts
2. Update the comments regarding PIR and CIR in enetc_setup_txbdr()
3. Use read_poll_timeout() instead of the while loop
v2 link: https://lore.kernel.org/imx/20260309030412.2716984-1-wei.fang@nxp.com/
v2:
1. Remove unused register macros (ENETC_SISR and SISR_TX_BUSY)
2. Remove spurious semicolon from enetc4_mac_wait_rx_empty()
---

Wei Fang (3):
  net: enetc: reset PIR and CIR if they are not equal when initializing
    TX ring
  net: enetc: add graceful stop to safely reinitialize the TX Ring
  net: enetc: do not access non-existent registers on pseudo MAC

 drivers/net/ethernet/freescale/enetc/enetc.c  |  13 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 118 +++++++++++++++---
 3 files changed, 127 insertions(+), 15 deletions(-)

-- 
2.34.1


