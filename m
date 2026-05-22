Return-Path: <netdev+bounces-290739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EImCNFQhEGqjTwYAu9opvQ
	(envelope-from <netdev+bounces-290739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:26:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3ED5B1264
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AB413029CE3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8353C3445;
	Fri, 22 May 2026 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E/ZEh2b7"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BCB3BF685;
	Fri, 22 May 2026 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441752; cv=fail; b=NIoluMk7eGUXP1IoWEStvY4g05cnOsamhkoGAORJImrBvEGxcDI5/zNSTny6LoWWslggxy7+RCVwaqkk+I9x8ogabvooXWnq5yAcD8FwUsCoJpcbcjg9UstC5SL/QqOTboh45dtSTGwNBdx7ltEHLSFBncsO+n5VO439ffjvGbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441752; c=relaxed/simple;
	bh=u6GpO6HDEgzHq7stJd7qU8hSBFzPbGl77KA/5Ibwm+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DRlsdxEk1y/JYNHX+bxGUGHlcbwDUqS+h1EaB74eA5dSW6BpEFJIqhXpa/0kQ3jBZzSscbsmrdE+mvle27C8Inu5XM8f/opQZjIG+1N4W4jICvKwssTZKoS9MR0MFBQwvLWayWv8sSKp0E5qG5BJ0g7r8Wrm5QxUMQNNUXlaLlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E/ZEh2b7; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PonXoRyZ7yZ2Cnl2E6FN+oHQWYDZ4HjeW5dNgWNeceCNMtVrlV+IoHmXTuweEG3Zvzgqpg0newCosZiLZeL4co9IMqobOHBNZOv7NUxGuTgq9NQ+xNm1MbiIGdZ8FpSrtskp2DTlcUQhAbAHMvdfH9niqkNnYejCdN50U/jsnsP3BSR0MNCHP09wSKrBAWKJcPb1zsx3+TDAKf9RbehCjbJ0zyU3BanosLt8Zjo8KLV8G5DnvrxtIBTMf95oPVcb96GTgXVu+tGHKEHEIQJkmz6Z8wxMtTSzs+e/nCJvFGlUSqn405HmySAyFsllEm3kwhMiI7lfT+0SEQPX7e3mRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HONltkVavojfK5OEoLbyx+Q106el8puzwaNKrcscfKo=;
 b=qpYdAHN4W54tc1ixHM6l+Gx+J7ph7knnXeYKfOQLTk0z0Sz2nbeKRjiPkRI4O+tp4wm88glzLBQ9NHO64aWLYyUY1a9ZzYSOG6j1tKA7mzRJVP1GYlHRpnZrlsmhN/vWKw/vZay6Esvgzd5izcGxQse4j+F1RTpB6nwh7Lj7+/X351NClG7hQnnkXD5/qVXe36eKVK+zqT2ixh6DpgAOVR63VyjAqFXjGTjMgoQOvLNglaIWGmTZVAoifhn2+dieLDk5bvjgUxJL7IbSxM0nuvPJCyi7DpqAwC9l+WEKzfd1/k+Oorhh1U6UGiGFzf+/ckGFWi4Mp8HZV4Pa3yPvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HONltkVavojfK5OEoLbyx+Q106el8puzwaNKrcscfKo=;
 b=E/ZEh2b7VmctPBt10G/TnE2WiZdXSWY3tn8n6fRt5oodzivJuEtSwfCbrAUCx/IzXycVLzSqNjxrnB2oSXRhKQbca6JwB+Klx5REJxPAJFo2RKePjVvHaXGIGkW7i4qO0fmR8NKVtWBxCS5kmMAa86BtCSq3n45mzATsuO4EeKq36E8lr0a9bmo0+4fVJiZS2HnFpaOgJ+BsIETZmv/xGkWpQjyTbVHh65cAPG70H9WxQbi+xINlPSvb7SaE9uOF/JHBta+07VqR4l35l6nCLvZ0wwLeqfvJSxyxPD+n6WNHxpdzov3H3XW9oyLAYpOdwoAt3fjZOYBwQg0UU2d35A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 09:22:25 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:25 +0000
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
Subject: [PATCH v2 net-next 06/12] net: enetc: convert mailbox messages to new formats
Date: Fri, 22 May 2026 17:24:32 +0800
Message-Id: <20260522092438.1264020-7-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18df107c-ee1f-42ed-835d-08deb7e3a290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|19092799006|3023799007|21046099003|22082099003|56012099003|18002099003|11063799006|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	Bh5na0nmNAZ3Y/7MS7q7QONzz8N0nS9WJLpYp8oiv9UDk+GZ2mLIOuTWZOjF8CpYhtE+mCJ8dMP+nhSGx0uVecMk2vXpMpINI0lXZjQLxGFUi49gSBbU3zHD94eO77wTi2svA471C7LHXWm1CM7uecNYbmmmhN3xQcAKCxvabm0cyjRPD/9hlwk7zTtP0ECHubyrsOx08CCbfNbS9BV8o4A9KTyM2OrwDK3a7bZPHvQMMq4XDsDCaPT+7X739XRZs5I8xB9h5PaldjrJGN8oMscroVxNnbauWu425YwQcJFomvrZWFKpsfHhXgv1oKP/lNtNwUknmmrygeTDaLe8+7Izckqj4p7eSiFxEO9jgswzlWey6DquC658rrTBxVDqHzNDP0hmnOWgujUimBUVTmQJbm+QVu4kIB58JIp1oAdTr+KuoeO5tXqDuoOdKQfP4YmB7HHiTmoSeQJ7yqCm6DMzlWnYuQ41V/eTTT3mEdAceTZEE7smsHVe7ExV9dreyVUTvzT8vW81bGs9kArnAjyonKEac6a/5LtJIMrLEBBh6vDSqAIGhDkfj91YWLS+7qOtHzeZNxFrfFpoFYZPBf8PRXLxldZC35lVTKLUxx485JKmGDqbyrY732iM5s6KaO7rmh41dLfZa20HmS0zZNPfFvrFcuUaOAypG+ZfLa0U6dokqVJDJA5Brzhex6+KoKDN2EtYjLPwLQBSTYXTdY9YFhTuohTF7TDQZm2HzO6v/AZfrziiG+sjFO+uFSho
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(3023799007)(21046099003)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gsxjdTn/0OHfM6qEDEaAdnAoBAHXLMpeq89CLtbQRChKsB0IJ7RNUhLlb+Wc?=
 =?us-ascii?Q?VeosIobDVoiBMBYTzYzJwoMsMsm+uJcdYQ08VxJSZfJ9a4a1upB3SOsLh162?=
 =?us-ascii?Q?wCmjg5EQgyCUTH/ctxSSujy2JUEFqnJcWlTMWJrOQeTa5vHEcCROIJMmf6Ye?=
 =?us-ascii?Q?Cw6idnncKsuN2VAqB3AkHWWqcrUpgiJTixAI1sOjp/9aLHIlhrNpJHITB2XV?=
 =?us-ascii?Q?OYgMsQg4iyd12HVyjQ/7OHMSUxdlDt7obdiu9fw3FY+ZywConsRycEgIcRzy?=
 =?us-ascii?Q?TRKZ1NLgp8S7zsLXvzII1JEuAu2/62AA6fbjms25mS018FuocpM38j+3JmHr?=
 =?us-ascii?Q?ymHYarAb9pNTVeOhYQvP+iNAOygHV/vT36RmEGV2TzoHeGlZG2nU6zkexBRP?=
 =?us-ascii?Q?K9FHvwAxIzunLPYCk0SNssXUx8aagVDaFd00YEfhgmtj/DahFAiBuGU5yqKl?=
 =?us-ascii?Q?4XJ/14gryUCscHjfD2eshCcCK4vEBYUo821ASc0xayZvPAiSL7oalaRT1LJt?=
 =?us-ascii?Q?m5ROK319n23jLM/+jKLXze2664h/ufQuPP1feBEBSLo+q47kbbLWmxrFrQhr?=
 =?us-ascii?Q?MomxCVtsdkMyOW3gjrNY8O3KlWPZAmG7lWPyP3pMTRZWJKdVFAMKJWuDIlhp?=
 =?us-ascii?Q?UHIJtciNoan09WodOtxw+RjoXS9m8aDRtgnoURSwElLToMQayi2mZHhXC/Tq?=
 =?us-ascii?Q?NXaRIa/JPnd3wzPjRU6utdiA1R4hxgkMobO9tyoHaHSf1neBnBcMCF94Dz/S?=
 =?us-ascii?Q?mB4i7CmHxs773GeTaTD/+6aIH/TPODpLnVLiyW4LJd6v+B2GBcbOWrjsoXvo?=
 =?us-ascii?Q?BcXj+jvt3IQTWQ03DX58BfYbn9fd0bgNyx36Z8ZqWJAdk0O8mvmWRp8TNviO?=
 =?us-ascii?Q?HDh9sN0vh5fWmnML/VUmaPWj5jU12GlTIXCaYlCWAldKxg3EmIQCBsOlFQUm?=
 =?us-ascii?Q?HDLkPiDf7dYEDAvUbgG0xY4bTBRktnxEftNpIRZiwBkNSJQSyfP7dIwiE++g?=
 =?us-ascii?Q?zpBgB6llgVXVPW5y6JDdulzBoZ3pFH8FclerLkGNA7r3n0IEW4TIgdhZL3cK?=
 =?us-ascii?Q?hw27f7cAl0Z7Ckm6gkhVo6+45TyTZttYV5emRGaQgYMprdQZcKu0bFJobyF3?=
 =?us-ascii?Q?Wg/vf1ec1jkJppomqea4b4P2qNawxXIPkEXK4OeuBC4C+KG/VsGgpQ6moWfI?=
 =?us-ascii?Q?qPvc4cGQKpeV9tKl6OluMyIOaoAmng39u+iKkt1xdB/kO7pLrOm7pZ/MU7ow?=
 =?us-ascii?Q?GpMtHSQdX0x/EQvaB3YCpM/il1TH85z9z1CVN0niQig7OS18TCrRquje4G8M?=
 =?us-ascii?Q?lj9l7VSw9Tf8BhOyWnssfAz8eQqwfMPcZLqDHD9sVEsq1aIvqctpUsLxeKV6?=
 =?us-ascii?Q?XdAu3dpt8psTK2gyQOGQ0NR+I2qE5l6SIq/kLYILuXpFCalVuspyhtFW2H1s?=
 =?us-ascii?Q?E3dtNkfTJnyJr5lACV3i0el+7lHg41oHHqVpxTByEnQ68scYzJ10ATKXrqOx?=
 =?us-ascii?Q?unU0DKN3x4Ue1aK5d5dnQi752BRLKtNimeeJqBb86PSN65iZE+TKwQ3CUwvI?=
 =?us-ascii?Q?Uosl94vbfKBwXQDNBvjAEH1yuRL7cZykmj/W+01GOUINnl6/cUpz2EuwcZ22?=
 =?us-ascii?Q?UAnjlrKRS/uwt0lT7GbpkS01xxC2gq4k8/Doqc3jsDlOM1I0P67d4BBjR72W?=
 =?us-ascii?Q?JELL38/8SQ1qpcjj+bxpRcMNGR6ao/RiVVZr+dy6mb2tWEod?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18df107c-ee1f-42ed-835d-08deb7e3a290
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:24.9557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxMT+wmtu3EucxoBwB6TeiG6FTdX/6Z+CIzZYC+WSzwbIeVdftUDzwZv6HflnvDL8eB3Ve0XgeVfdRfUDpqOhw==
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
	TAGGED_FROM(0.00)[bounces-290739-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Queue-Id: CD3ED5B1264
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On the LS1028A platform, the PF-VF mailbox was only used to update the
VF's MAC address. The original message format is minimal, lacks a clear
structure, and provides no means for the receiver to validate message
integrity, making it difficult to extend for new features.

With the introduction of i.MX ENETC v4, the interaction between PF and
VF has become significantly more complex. Typical deployments now include
scenarios where the PF is controlled by an M core while the VF is driven
by either the Linux kernel or DPDK, or where the PF is controlled by the
Linux kernel while the VF is controlled by DPDK. These heterogeneous
driver combinations require a unified and extensible message format to
ensure compatibility across different operating environments.

This patch introduces a newly defined PF-VF message structure and
converts the existing MAC-update mechanism to use the new format. The
redesigned message layout provides:

  - extensibility to support future PF-VF features on ENETC v4,
  - consistent framing for all message types,
  - improved data integrity checking,
  - a common protocol usable across Linux, M core firmware, and DPDK.

Additional PF-VF message types will be added in subsequent patches.

Note that switch to the new message format will not affect ENETC v1
(LS1028A). Due to a hardware limitation of ENETC v1, the ENETC PF and
VFs can only be controlled by the same OS. If the PF is controlled by
the Linux kernel driver, then the VFs must also be controlled by the
Linux kernel driver.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
 drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +-
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |   4 -
 .../ethernet/freescale/enetc/enetc_mailbox.h  | 151 ++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_msg.c  | 127 +++++++++++----
 .../net/ethernet/freescale/enetc/enetc_vf.c   |  97 ++++++++---
 6 files changed, 326 insertions(+), 70 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_mailbox.h

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 117038104b69..db5c17a44613 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -10,6 +10,7 @@ config FSL_ENETC_CORE
 
 config NXP_ENETC_PF_COMMON
 	tristate
+	select CRC_ITU_T
 	help
 	  This module supports common functionality between drivers of
 	  different versions of NXP ENETC PF controllers.
@@ -70,6 +71,7 @@ config FSL_ENETC_VF
 	select FSL_ENETC_MDIO
 	select PHYLINK
 	select DIMLIB
+	select CRC_ITU_T
 	help
 	  This driver supports NXP ENETC gigabit ethernet controller PCIe
 	  virtual function (VF) devices enabled by the ENETC PF driver.
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index e691144e8756..b70b625328ea 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -16,6 +16,7 @@
 
 #include "enetc_hw.h"
 #include "enetc4_hw.h"
+#include "enetc_mailbox.h"
 
 #define ENETC_MAC_MAXFRM_SIZE	9600
 #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
@@ -257,12 +258,6 @@ static inline union enetc_rx_bd *enetc_rxbd_ext(union enetc_rx_bd *rxbd)
 	return ++rxbd;
 }
 
-struct enetc_msg_swbd {
-	void *vaddr;
-	dma_addr_t dma;
-	int size;
-};
-
 #define ENETC_REV1	0x1
 #define ENETC_REV4	0x4
 
@@ -490,14 +485,6 @@ struct enetc_ndev_priv {
 	u64 sysclk_freq; /* NETC system clock frequency */
 };
 
-/* Messaging */
-
-/* VF-PF set primary MAC address message format */
-struct enetc_msg_cmd_set_primary_mac {
-	struct enetc_msg_cmd_header header;
-	struct sockaddr mac;
-};
-
 #define ENETC_CBD(R, i)	(&(((struct enetc_cbd *)((R).bd_base))[i]))
 
 #define ENETC_CBDR_TIMEOUT	1000 /* usecs */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 56899f2254aa..4e771f852358 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -17,10 +17,6 @@
 #define ENETC_MAC_FILTER_TYPE_ALL	(ENETC_MAC_FILTER_TYPE_UC | \
 					 ENETC_MAC_FILTER_TYPE_MC)
 
-struct enetc_mac_addr {
-	u8 addr[ETH_ALEN];
-};
-
 static void enetc4_get_port_caps(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
new file mode 100644
index 000000000000..86a51bae19f3
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mailbox.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2025-2026 NXP
+ *
+ * The VSI-to-PSI message generic format:
+ *
+ * OFFSET  0                               16              24            31
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x0   |       CRC16 (big-endian)      |    CLASS ID   |     CMD ID    |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x4   |   PROTO VER   |      LEN      |    RESV       | COOKIE|  RESV |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x8   |                              RESV                             |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0xc   |                              RESV                             |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x10  |                                                               |
+ *  0x14  |                                                               |
+ *  0x18  |                          Message Body                         |
+ *  0x1c  |                                                               |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *  0x20  |                                                               |
+ *    ~   |              Extended Message Body: LEN x 32B                 |
+ *  0x3e0 |                                                               |
+ *        +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+ *
+ * Field Descriptions:
+ * CRC16 (16-bit): Big endian, CRC16 CCITT-FALSE algorithm, It provides the
+ * equivalent data integrity check functionality as the FCS for standard
+ * Ethernet frames.
+ *
+ * CLASS ID (8-bit) and CMD ID (8-bit): These are 8-bit fields identifying
+ * the command class and the class-specific operations supported. For more
+ * details, please refer to the definitions of the relevant class ID and
+ * cmd ID in this document.
+ *
+ * PROTO VER (8-bit): Supported VSI-PSI command protocol version. Currently
+ * only support version 0. To be incremented for future protocol extensions.
+ *
+ * LEN (8-bit): Extended message body length in increments of 32B. The upper
+ * limit is given by the physical implementation of the NETC VSI-PSI Messaging
+ * mechanism that supports message sizes of up to 1024B (including headers),
+ * that are multiple of 32B.
+ *
+ * COOKIE (4-bit): Optional parameter, which, if not 0, indicates that the
+ * command should be execute asynchronously on PSI side. If COOKIE is not 0
+ * and the command cannot be executed instantly on the PSI side (it would
+ * take longer time to complete), the PSI may enqueue the request in a command
+ * queue of up to 15 entries per VSI and, later after command execution, the
+ * PSI returns the COOKIE to VSI as part of an asynchronous notification
+ * message that indicates the command completion status. If COOKIE is 0 then
+ * the command is considered as blocking, the PSI will wait for the execution
+ * of the command to complete before updating the PSIMSGRR[MC] field with the
+ * corresponding return code.
+ *
+ * The PSI-to-VSI message generic format:
+ *   0               4               8               12          15
+ * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+ * |       COOKIE      |   CLASS CODE  |          CLASS ID         |
+ * +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
+ *
+ * The PSI to VSI message format is mapped to the following PSI message
+ * registers/fields, depending on use case:
+ * 1) PSI_RX_control: PSIMSGRR[MC] - for VSI command return code messages
+ * (blocking requests), and
+ * 2) PSI_TX_control: PSIMSGSR[MC] - for PSI to VSI notification messages
+ * (async mode)
+ */
+
+#ifndef __ENETC_MAILBOX_H
+#define __ENETC_MAILBOX_H
+
+#include <linux/crc-itu-t.h>
+
+#define ENETC_CRC_INIT				0xffff
+#define ENETC_MSG_ALIGN				32
+/* s indicates the size of the message */
+#define ENETC_MSG_EXT_BODY_LEN(s)		((s) / ENETC_MSG_ALIGN - 1)
+/* l indicates the extended body len (LEN field) of the message */
+#define ENETC_MSG_SIZE(l)			(((l) + 1) * ENETC_MSG_ALIGN)
+
+/* The cookie filed of VSI-to-PSI message */
+#define ENETC_VF_MSG_COOKIE			GENMASK(3, 0)
+/* The fileds of PSI-to-VSI message, the message is only 16-bit */
+#define ENETC_PF_MSG_COOKIE			GENMASK(3, 0)
+#define ENETC_PF_MSG_CLASS_CODE			GENMASK(7, 4)
+#define ENETC_PF_MSG_CLASS_ID			GENMASK(15, 8)
+
+enum enetc_msg_class_id {
+	/* Class ID for PSI-to-VSI messages */
+	ENETC_MSG_CLASS_ID_CMD_SUCCESS		= 1,
+	ENETC_MSG_CLASS_ID_PERMISSION_DENY,
+	ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT,
+	ENETC_MSG_CLASS_ID_PSI_BUSY,
+	ENETC_MSG_CLASS_ID_CRC_ERROR,
+	ENETC_MSG_CLASS_ID_PROTO_NOT_SUPPORT,
+	ENETC_MSG_CLASS_ID_INVALID_MSG_LEN,
+	ENETC_MSG_CLASS_ID_CMD_TIMEOUT,
+	ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED,
+	ENETC_MSG_CLASS_ID_CMD_FAIL, /* Generic error code for failure */
+	ENETC_MSG_CLASS_ID_CMD_DEFERRED		= 0xf,
+
+	/* Common Class ID for PSI-to-VSI and VSI-to-PSI messages */
+	ENETC_MSG_CLASS_ID_MAC_FILTER		= 0x20,
+};
+
+enum enetc_msg_mac_filter_cmd_id {
+	ENETC_MSG_SET_PRIMARY_MAC,
+};
+
+/* Class-specific error return codes of MAC filter */
+enum enetc_mac_filter_class_code {
+	ENETC_MF_CLASS_CODE_INVALID_MAC,
+};
+
+struct enetc_msg_swbd {
+	void *vaddr;
+	dma_addr_t dma;
+	int size;
+};
+
+/* The generic VSI-to-PSI message header */
+struct enetc_msg_header {
+	__be16 crc16;
+	u8 class_id;
+	u8 cmd_id;
+	u8 proto_ver;
+	u8 len;
+	u8 resv0;
+	u8 cookie;
+	u8 resv2[8];
+};
+
+struct enetc_mac_addr {
+	u8 addr[ETH_ALEN]; /* Network byte order */
+};
+
+/* Message format of class_id 0x20 for exact MAC filter.
+ * cmd_id 0x0: set primary MAC
+ * cmd_id 0x1: Add entries to MAC address filter table
+ * cmd_id 0x2: Delete entries from MAC address filter table
+ * Note that cmd_id 0x1 and 0x2 are not supported yet.
+ */
+struct enetc_msg_mac_exact_filter {
+	struct enetc_msg_header hdr;
+	u8 mac_cnt; /* No need to set for cmd_id 0 */
+	u8 resv[3];
+	struct enetc_mac_addr mac[];
+};
+
+#endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
index f696751c00ea..4ab123cbfbec 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
@@ -3,6 +3,11 @@
 
 #include "enetc_pf_common.h"
 
+#define ENETC_PF_MSG_SUCCESS	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					   ENETC_MSG_CLASS_ID_CMD_SUCCESS)
+#define ENETC_PF_MSG_NOTSUPP	FIELD_PREP(ENETC_PF_MSG_CLASS_ID, \
+					   ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT)
+
 static void enetc_msg_disable_mr_int(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
@@ -36,23 +41,35 @@ static irqreturn_t enetc_msg_psi_msix(int irq, void *data)
 }
 
 /* Messaging */
-static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
-						int vf_id, void *msg)
+static bool enetc_msg_check_crc16(void *msg_addr, u32 msg_size)
+{
+	u32 data_size = msg_size - 2;
+	u8 *data_buf = msg_addr + 2;
+	u16 verify_val;
+
+	verify_val = crc_itu_t(ENETC_CRC_INIT, data_buf, data_size);
+	verify_val = crc_itu_t(verify_val, msg_addr, 2);
+	if (verify_val)
+		return false;
+
+	return true;
+}
+
+static u16 enetc_msg_set_vf_primary_mac_addr(struct enetc_pf *pf, int vf_id,
+					     void *vf_msg)
 {
 	struct enetc_vf_state *vf_state = &pf->vf_state[vf_id];
-	struct enetc_msg_cmd_set_primary_mac *cmd = msg;
+	struct enetc_msg_mac_exact_filter *msg = vf_msg;
 	struct device *dev = &pf->si->pdev->dev;
-	u16 cmd_id = cmd->header.id;
-	char *addr;
-
-	if (cmd_id != ENETC_MSG_CMD_MNG_ADD)
-		return ENETC_MSG_CMD_STATUS_FAIL;
+	char *addr = msg->mac[0].addr;
 
-	addr = cmd->mac.sa_data;
 	if (!is_valid_ether_addr(addr)) {
 		dev_err_ratelimited(dev, "VF%d attempted to set invalid MAC\n",
 				    vf_id);
-		return ENETC_MSG_CMD_STATUS_FAIL;
+		return (FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				   ENETC_MSG_CLASS_ID_MAC_FILTER) |
+			FIELD_PREP(ENETC_PF_MSG_CLASS_CODE,
+				   ENETC_MF_CLASS_CODE_INVALID_MAC));
 	}
 
 	mutex_lock(&vf_state->lock);
@@ -61,53 +78,97 @@ static u16 enetc_msg_pf_set_vf_primary_mac_addr(struct enetc_pf *pf,
 		dev_err_ratelimited(dev,
 				    "VF%d attempted to override PF set MAC\n",
 				    vf_id);
-		return ENETC_MSG_CMD_STATUS_FAIL;
+		return FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				  ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED);
 	}
 
 	enetc_set_si_hw_addr(pf, vf_id + 1, addr);
 	mutex_unlock(&vf_state->lock);
 
-	return ENETC_MSG_CMD_STATUS_OK;
+	return ENETC_PF_MSG_SUCCESS;
+}
+
+static u16 enetc_msg_handle_mac_filter(struct enetc_pf *pf, int vf_id,
+				       void *vf_msg)
+{
+	struct enetc_msg_header *msg_hdr = vf_msg;
+
+	switch (msg_hdr->cmd_id) {
+	case ENETC_MSG_SET_PRIMARY_MAC:
+		return enetc_msg_set_vf_primary_mac_addr(pf, vf_id, vf_msg);
+	default:
+		return ENETC_PF_MSG_NOTSUPP;
+	}
 }
 
 static void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int vf_id,
-				   u16 *status)
+				   u16 *pf_msg)
 {
 	struct enetc_msg_swbd *msg_swbd = &pf->rxmsg[vf_id];
+	struct enetc_msg_header *msg_hdr = msg_swbd->vaddr;
+	u32 msg_size = ENETC_MSG_SIZE(msg_hdr->len);
 	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_msg_cmd_header *cmd_hdr;
-	u16 cmd_type;
 	u8 *msg;
 
-	msg = kzalloc_objs(*msg, msg_swbd->size);
+	if (msg_size > ENETC_DEFAULT_MSG_SIZE) {
+		dev_err_ratelimited(dev,
+				    "Invalid message size: %u\n", msg_size);
+		*pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				     ENETC_MSG_CLASS_ID_INVALID_MSG_LEN);
+		return;
+	}
+
+	/* To prevent malicious VF from tampering with the original data by
+	 * sending new messages after passing the check, the DMA buffer data
+	 * is copied to the msg buffer before validation.
+	 */
+	msg = kzalloc_objs(*msg, msg_size);
 	if (!msg) {
 		dev_err_ratelimited(dev,
 				    "Failed to allocate message buffer\n");
-		*status = ENETC_MSG_CMD_STATUS_FAIL;
+		*pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				     ENETC_MSG_CLASS_ID_CMD_FAIL);
 		return;
 	}
 
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
+	memcpy(msg, msg_swbd->vaddr, msg_size);
+	if (!enetc_msg_check_crc16(msg, msg_size)) {
+		dev_err_ratelimited(dev, "VSI to PSI Message CRC16 error\n");
+		*pf_msg = FIELD_PREP(ENETC_PF_MSG_CLASS_ID,
+				     ENETC_MSG_CLASS_ID_CRC_ERROR);
+
+		goto free_msg;
+	}
+
+	/* Default to not supported */
+	*pf_msg = ENETC_PF_MSG_NOTSUPP;
+	msg_hdr = (struct enetc_msg_header *)msg;
+
+	/* Currently, asynchronous actions are not supported */
+	if (FIELD_GET(ENETC_VF_MSG_COOKIE, msg_hdr->cookie)) {
+		dev_err_ratelimited(dev,
+				    "Cookie field is not supported yet\n");
+		goto free_msg;
+	}
+
+	/* Currently only support protocol version 0 */
+	if (msg_hdr->proto_ver) {
+		dev_err_ratelimited(dev, "Unsupported protocol version %u\n",
+				    msg_hdr->proto_ver);
+		goto free_msg;
+	}
+
+	switch (msg_hdr->class_id) {
+	case ENETC_MSG_CLASS_ID_MAC_FILTER:
+		*pf_msg = enetc_msg_handle_mac_filter(pf, vf_id, msg);
 		break;
 	default:
-		*status = ENETC_MSG_CMD_STATUS_FAIL;
 		dev_err_ratelimited(dev,
-				    "command not supported (cmd_type: 0x%x)\n",
-				    cmd_type);
+				    "Unsupported message class ID: 0x%x\n",
+				    msg_hdr->class_id);
 	}
 
+free_msg:
 	kfree(msg);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9065bdbd02aa..77c0eddba6e2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -7,7 +7,29 @@
 
 #define ENETC_DRV_NAME_STR "ENETC VF driver"
 
-/* Messaging */
+/* Note: This function should be called after filling the message body,
+ * because the CRC16 needs to be calculated after all the data has been
+ * filled.
+ */
+static void enetc_msg_fill_common_hdr(struct enetc_msg_swbd *msg_swbd,
+				      u8 class_id, u8 cmd_id, u8 proto_ver,
+				      u8 cookie)
+{
+	struct enetc_msg_header *hdr = msg_swbd->vaddr;
+	u8 *data_buf = ((u8 *)msg_swbd->vaddr) + 2; /* skip crc16 field */
+	u32 data_size = msg_swbd->size - 2;
+	u16 crc16;
+
+	hdr->class_id = class_id;
+	hdr->cmd_id = cmd_id;
+	hdr->len = ENETC_MSG_EXT_BODY_LEN(msg_swbd->size);
+	hdr->proto_ver = proto_ver;
+	hdr->cookie = FIELD_PREP(ENETC_VF_MSG_COOKIE, cookie);
+
+	crc16 = crc_itu_t(ENETC_CRC_INIT, data_buf, data_size);
+	hdr->crc16 = htons(crc16);
+}
+
 static void enetc_msg_vsi_write_msg(struct enetc_hw *hw,
 				    struct enetc_msg_swbd *msg)
 {
@@ -30,6 +52,7 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 {
 	struct device *dev = &si->pdev->dev;
 	u32 vsimsgsr;
+	u16 pf_msg;
 	int err;
 
 	/* The VSI mailbox may be busy if last message was not yet processed
@@ -60,36 +83,72 @@ static int enetc_msg_vsi_send(struct enetc_si *si, struct enetc_msg_swbd *msg)
 
 	/* check for message delivery error */
 	if (vsimsgsr & ENETC_VSIMSGSR_MS) {
-		dev_err(dev, "VSI command execute error: %d\n",
-			ENETC_SIMSGSR_GET_MC(vsimsgsr));
+		dev_err(dev, "Transfer error when copying the data\n");
 		return -EIO;
 	}
 
-	return 0;
+	pf_msg = ENETC_SIMSGSR_GET_MC(vsimsgsr);
+	/* Check the user-defined completion status. */
+	if (FIELD_GET(ENETC_PF_MSG_CLASS_ID, pf_msg) !=
+	    ENETC_MSG_CLASS_ID_CMD_SUCCESS) {
+		switch (FIELD_GET(ENETC_PF_MSG_CLASS_ID, pf_msg)) {
+		case ENETC_MSG_CLASS_ID_PERMISSION_DENY:
+			/* Intentionally returning early to prevent excessive
+			 * error logs due to permission issues.
+			 */
+			return -EACCES;
+		case ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT:
+		case ENETC_MSG_CLASS_ID_PROTO_NOT_SUPPORT:
+			err = -EOPNOTSUPP;
+			break;
+		case ENETC_MSG_CLASS_ID_PSI_BUSY:
+			err = -EBUSY;
+			break;
+		case ENETC_MSG_CLASS_ID_CMD_TIMEOUT:
+			err = -ETIME;
+			break;
+		case ENETC_MSG_CLASS_ID_INVALID_MSG_LEN:
+		case ENETC_MSG_CLASS_ID_MAC_FILTER:
+			err = -EINVAL;
+			break;
+		case ENETC_MSG_CLASS_ID_CMD_NOT_PERMITTED:
+			err = -EPERM;
+			break;
+		case ENETC_MSG_CLASS_ID_CMD_FAIL:
+		case ENETC_MSG_CLASS_ID_CRC_ERROR:
+		case ENETC_MSG_CLASS_ID_CMD_DEFERRED:
+		default:
+			err = -EIO;
+		}
+	}
+
+	if (err)
+		dev_err(dev, "Return error code from PSI: 0x%04x\n", pf_msg);
+
+	return err;
 }
 
 static int enetc_msg_vsi_set_primary_mac_addr(struct enetc_ndev_priv *priv,
 					      struct sockaddr *saddr)
 {
-	struct enetc_msg_cmd_set_primary_mac *cmd;
-	struct enetc_msg_swbd msg;
-
-	msg.size = ALIGN(sizeof(struct enetc_msg_cmd_set_primary_mac), 64);
-	msg.vaddr = dma_alloc_coherent(priv->dev, msg.size, &msg.dma,
-				       GFP_KERNEL);
-	if (!msg.vaddr) {
-		dev_err(priv->dev, "Failed to alloc Tx msg (size: %d)\n",
-			msg.size);
+	struct enetc_msg_mac_exact_filter *msg;
+	struct enetc_msg_swbd msg_swbd;
+	u32 msg_size;
+
+	msg_size = struct_size(msg, mac, 1);
+	msg_swbd.size = ALIGN(msg_size, ENETC_MSG_ALIGN);
+	msg_swbd.vaddr = dma_alloc_coherent(priv->dev, msg_swbd.size,
+					    &msg_swbd.dma, GFP_KERNEL);
+	if (!msg_swbd.vaddr)
 		return -ENOMEM;
-	}
 
-	cmd = (struct enetc_msg_cmd_set_primary_mac *)msg.vaddr;
-	cmd->header.type = ENETC_MSG_CMD_MNG_MAC;
-	cmd->header.id = ENETC_MSG_CMD_MNG_ADD;
-	memcpy(&cmd->mac, saddr, sizeof(struct sockaddr));
+	msg = (struct enetc_msg_mac_exact_filter *)msg_swbd.vaddr;
+	memcpy(&msg->mac[0].addr, saddr->sa_data, ETH_ALEN);
+	enetc_msg_fill_common_hdr(&msg_swbd, ENETC_MSG_CLASS_ID_MAC_FILTER,
+				  ENETC_MSG_SET_PRIMARY_MAC, 0, 0);
 
 	/* send the command and wait */
-	return enetc_msg_vsi_send(priv->si, &msg);
+	return enetc_msg_vsi_send(priv->si, &msg_swbd);
 }
 
 static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
-- 
2.34.1


