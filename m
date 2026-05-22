Return-Path: <netdev+bounces-290741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFnLHdIgEGpNUAYAu9opvQ
	(envelope-from <netdev+bounces-290741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:24:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8325B11C3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4CC83024A05
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC91D3C65FA;
	Fri, 22 May 2026 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="er/gcSmx"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2688C3C4540;
	Fri, 22 May 2026 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441756; cv=fail; b=ntnkLM+d4zZW1r6tYYC4iksXGZiDq5tfSb1XFpel5U1Snp9M9NqEzOW5vu4XEz5UjGwMkJub3NJn/Ccc1Qez6dQMVKkpDz3savAUtBcggxFwggc2M21SU3i5RR4fCjy9i1i8TAyF8EyCxghGwYu9P0Iw1IE1NVg/LoAv6zfZwKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441756; c=relaxed/simple;
	bh=ODB6YPrEz40JosoNfqG1hII2Li6T/j4qfHjLK5cTO4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sFhSbSBo9BYRoH8KuW2DfUbNWCQlwpoTm1IYbfWgRwW822yS2+/b5jnczVdvK2Ohy9ruLYILYKT6QnipgzvBG245i4Bxl/J6PiuY/QERioXyHHyH9yugiHFuHBJFRXL1AEYCotj3wGWNImzOUis56Z7TIyZ0EGje+4zQ586Gvv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=er/gcSmx; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PclI0RISl67lpq8/yc/gE8XGAxTrxRVhEgqucjF9Pw9SrpilcaMPpc/wJzoRO0SEgaJv13tHeKa0Qdb/OJatvrAWH6shkRuLIrEj2CDTaDSNvOnKuXfTgbb1YyphPLTwr5OEeoKtTY082gZP58qSGEQcrN6vsNvwnr0JN1yRROEOOGG1N5y4VubOZ0ybi3/uSYD9jbfnZjRVzjndBFnc/3Osi6Rrjt2TnK3v3uT1WxZtpY0vgnCeHz1RJ4drCGqc05DEaD93zwar9fwQUHNJkrYfNJcTRifnHTZVagO9N8f3Hc2B4TVInhr//VuIXyS8eYg6xO2gLReEyU9o+kDu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkDc+0+3iwKsLAqxrN8RXoIs240u4NGlzXzbd+IxNCU=;
 b=dDGR6HHhVMjX2PmaPSe1QFThtQfpLha3Osc4ofQlE1+BxrJLk54zG3njUQ//Znkx8l1UUsCoLngeJ5hkS6BCBdmHsOOcrOYDESzERKHuSa8l1GyCHVNHW2hvF/SHGDqoAQ5K5CtxrXyjho3obbPUJDK2LOwry5RQRhtfbZBxql0kfgs/zLFPbOlaOvpT2Yv8reaCZ1YD2IxAKcIegVNkU7EuTXuXqEW4twftNX3dnBFBUh6oePuzBvbEF3SxoGfKeNshJspMMA9G/MstVxJfMfm8oA2wOtrklubdZCYgAdY9JVb+AAJcSUdUNI13MG0tsQ1lsbBwKDs4SBi2xImybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkDc+0+3iwKsLAqxrN8RXoIs240u4NGlzXzbd+IxNCU=;
 b=er/gcSmxEEO2iEauu8mjiR89SYDnziZxrF0gBI7WdIdOWqXNXjfSGf8lXp9Wp3Nvqp5rDujJCDAw6+CtiWJveOeFYzcVtjGeWLUDc5O4/psLsPtElUQxqc6U2fIwLLKiQMo2ZuozZRqRc6Vg7gu0NVEGF6PkunipChkGqKj4saxPDLmvQdwAXTeW8QmPoxeciCXIr3R3Firs1yd0W8HE37mzTkXrY58kRO9ISy+VdIzFHw7K3k99N1Kaxz4uKNn4S7scLIrDGHT92jqgs1+k84ekwZR2HD00zqNVmEE8hB3aPVdgNfAuiak8CyEevYjlJnqYnkKKEJKFOQV/mRxVog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by PA4PR04MB7949.eurprd04.prod.outlook.com (2603:10a6:102:cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 09:22:33 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 09:22:33 +0000
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
Subject: [PATCH v2 net-next 08/12] net: enetc: align v1 CBDR API with v4 for VF driver sharing
Date: Fri, 22 May 2026 17:24:34 +0800
Message-Id: <20260522092438.1264020-9-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ff5eb6e-93d1-4c9f-1df6-08deb7e3a769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|19092799006|3023799007|22082099003|56012099003|18002099003|11063799006|38350700014|6133799003;
X-Microsoft-Antispam-Message-Info:
	BmA/KTgkFaZhyAwJYBjrS7y2vWjguJRhtlycUsGFX9aWWuGOp/GIf3bkcWUXk9aTsGgQNu7Hngq5LHjhs4maaoGZMh9AreX4Hz03YcISeCfClqUXNLEArV+45jJKhkLtxLlvanrY3sQe6N8u5O4UmVkgoEjB8Yiwqaw69ux3MqNUNLrCByxLlD6oRX9Pw0Mxom61zMORdnCplKapP8wZZU7Wy+obCxlRplyKL//HW8Nq5vMgtvFRrR42VqHcC4Mt/D2WEQQk7wu/bT2Sy5CP+KlMGK1cx1XcGTRduney5SoV3gxbXebWG6rJDd5oLZ6Vu6We0vOrBm/zykAi5PwNLn4r/idIwu696tcxF3Bx1QHecYhkribWUlxHo06gYA1UQa7k5vK1NScZZdqUjfbjCrimdaEjibDxa0pB/noxn4ocfHEeu377dLYVSWM1JV5csHv1U3GG3F9OzpYT9ecssOtVbvlfKkpbDS8iMyUoDlvEp7fluGr6OcCQ+UvoTBGiV83lG3VpIjJNUhOZfGeU/82H5SrzifSAxinMGSci8sHc6zujnsnQPjnfOZN1c3muJFz4TQIjccdLZBNw1BLHPNKMtq/4shFo0htfVmh5MWwf4bsaHhUqeSqjh8FVPCle1FaQKuaqtW5trKAcX4DiRR3+GmnW32BcnPaBwpWLbnwsab+wE/0H7TrdsVIl/PDGmzhjKcHDxAR2lIJhE/hiXmisjDdaxnA3ZG0i2yAnEfgqBAvylVE+LQaQZae9OcJi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(19092799006)(3023799007)(22082099003)(56012099003)(18002099003)(11063799006)(38350700014)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2RjOxssOMwj9R96ouCprwywXJ9Zhp59/ebk5SeAr11+9XSi1VGCs8mQkP5B?=
 =?us-ascii?Q?ocAdxUugLbde4ReipOpM4mQgYv++jL64m6l6x11gpbVslxOoZN0pdRCCp3Mc?=
 =?us-ascii?Q?ADxyRIQpih5MeJuvMyHgW70YBp/3IETtRKC1EsryQJckEAPp7r8rtSd+NgWl?=
 =?us-ascii?Q?xjZev9RR8eELb5NlpWgV2APQaOPIemIL/QrsyADWSMXVbPFKeySqOIepXZ8G?=
 =?us-ascii?Q?hZlJMdC3s1bftmMimuWmqRNUSJbgYic/bCHXJUP5MVuJfk3/6ghJpBsdWoga?=
 =?us-ascii?Q?3Lc0LXVeB6s/nOHjesYZ95ETu9OdeESPkcbBGmFPm82bx5O44ew8G1aQ7pwM?=
 =?us-ascii?Q?FyKIQnlifPXIIgV+W/w77Kt2NZCc7W1MgBB/sZqDDJGITH+G9ZwGwRAAFZGs?=
 =?us-ascii?Q?8KBmv6BT7txB+MKtoUJdxuqbvHqkXyetjf68Aw2FAP0iHrng/KqXBxgPT3P/?=
 =?us-ascii?Q?H46mqzr5o/mmoyJpJpknjJFcMqEBeVwTV2T2czOhJJiDRbEnX8sZrmpSNMkU?=
 =?us-ascii?Q?7y+fuBu1cUNF+LCtnvbz1UYo5OmpMXVLZ8FlLqS/VbyIpgHO5XM33CpgXGaN?=
 =?us-ascii?Q?bfad/JgLy1wTF5CE3zpV80PZ0KD6MkwXpj4KiaR15SoSTVtzyJ+VR0NLoGyt?=
 =?us-ascii?Q?FmlkgRWQsQGZHdVm4jgpjNPdd43MKOo5hJn/cikldaga7b/n4uEyqNL5P+EZ?=
 =?us-ascii?Q?unlNwDA+aQypOlQqk0jBxJaWHYmq4qKuBBUDoH1jVjo3zPkWkAWzI6r+WTiO?=
 =?us-ascii?Q?8Xd9aFH6dCqvqKlHIaW88uKyaUIC7Al78BBP/Bo6Z8/xYEkhvRHYxeNYqaLG?=
 =?us-ascii?Q?6JnssbStBFy+9QOGB9y+e+jhbN1hmp2i7lKSuJ5oJ665kUBGLvgkc1EOJlHs?=
 =?us-ascii?Q?EY7Ev6yTsisiS0khwfJnEyunpVYzhZ+4Bv03DcEkpVqwgqR6o/Yi3NSMOBxV?=
 =?us-ascii?Q?rfr2xvwfEHplHC7P0NOUudeh2EmKlG6GFCPle426Ci270lZdxYcVNnPbx3dU?=
 =?us-ascii?Q?t9/3bIUmkLqgva+mjpkpyVuNJ7xhHLzLR5FRf1XU6ENgbIuHVRsuRNGf43an?=
 =?us-ascii?Q?UsddYCz/ATV6J8ZhVBX7E4hC7XACtS47EAg6MJWtlG4EzWneDfv6Zq7Kr8JI?=
 =?us-ascii?Q?eu+QPEwpH90ILy8OdcnfSa00KJ+KFX1iByjGBqmh/AgZfSsR3iU6WUWStCCV?=
 =?us-ascii?Q?QRXMRkWyo6ETVPIASt/UtSl2pn+sF5CJ4vD7EqNaoV7MSdQ0WTs3oeCim+hi?=
 =?us-ascii?Q?PK30ndiAOGuzkeQX/DdYbpGnhA6GKqcjWkV4nxZEQM1BuN4tiyVOQJjZEC1q?=
 =?us-ascii?Q?qB1Qho26RJccpvwcVs9p8WyEqkblIIOQi23ywBILTy2bXv9pKbXJRFvdBwC5?=
 =?us-ascii?Q?cvei+vnto3tQPfZCRFaM4FXoVVxRkys4EePkzKm/uE63VNhzlba4vY0cNsJ8?=
 =?us-ascii?Q?jliPUJ7JMFxWW8CAaG+Ys+7b+SRXPl2h93PTRgXe6/XJzKEvDC7vhK5bsFIE?=
 =?us-ascii?Q?P09nzFl/fO2HDJdbJoXrJqPp6hIGDS51uzgb9J/rZEuqom2juUdCVcUYdwwl?=
 =?us-ascii?Q?VQ1jU3kXUboIJ9vQcgsGktLb18+WMeW65IC9h4mAYw1PXVIs0q7HdmbN4DX4?=
 =?us-ascii?Q?gBj0sdzn1ym97uRcVUBwPxDKoIl6lk633gQjaCecnfogINOeD+WyoiyO29/c?=
 =?us-ascii?Q?TqYPq40sSo823FWndrt0GHBDQkAfXWcre8e45dqYB2LDcDuK22f1hKKa4qlD?=
 =?us-ascii?Q?s6LrAXi2Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff5eb6e-93d1-4c9f-1df6-08deb7e3a769
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 09:22:33.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzsJ/qmdh1eZ9b/jaU66RXbgUe3z+bJYd2sCv+eIUt06UK38abpLWQCEQZxUBCPOqK0mW52VXB/3FIo2acgL7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7949
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
	TAGGED_FROM(0.00)[bounces-290741-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:mid,nxp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B8325B11C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The upcoming ENETC v4 VF will share the enetc-vf driver with the v1 VF.
However, ENETC v4 introduces different CBDR (command BD ring) setup and
teardown semantics that are incompatible with v1.

To support both versions in the same driver, the .setup_cbdr() and
.teardown_cbdr() hooks will be added to struct enetc_si_ops, allowing
the driver to register version-specific implementations. So refactor the
v1 CBDR functions to match the v4-style interface (taking struct enetc_si*
instead of individual parameters), enabling them to be registered via
si_ops in the subsequent patch.

Changes:
- Update enetc_setup_cbdr() and enetc_teardown_cbdr() prototypes to
  take 'struct enetc_si *' as the sole parameter
- Extract parameters (dev, hw) from the enetc_si structure within the
  function implementations
- ENETC_CBDR_DEFAULT_SIZE has always been used as the number of command
  BDs, and there is no need to adjust the size of the command BD ring.
  Therefore, ENETC_CBDR_DEFAULT_SIZE is moved into the enetc_setup_cbdr()
- Update all call sites in enetc_pf.c and enetc_vf.c

No functional changes. This prepares for adding v4-specific CBDR handling
in subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h     |  5 ++---
 .../net/ethernet/freescale/enetc/enetc_cbdr.c    | 16 ++++++++++------
 drivers/net/ethernet/freescale/enetc/enetc_pf.c  |  7 +++----
 drivers/net/ethernet/freescale/enetc/enetc_vf.c  |  7 +++----
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index b70b625328ea..772f0ab2f8c1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -537,9 +537,8 @@ void enetc_mm_link_state_update(struct enetc_ndev_priv *priv, bool link);
 void enetc_mm_commit_preemptible_tcs(struct enetc_ndev_priv *priv);
 
 /* control buffer descriptor ring (CBDR) */
-int enetc_setup_cbdr(struct device *dev, struct enetc_hw *hw, int bd_count,
-		     struct enetc_cbdr *cbdr);
-void enetc_teardown_cbdr(struct enetc_cbdr *cbdr);
+int enetc_setup_cbdr(struct enetc_si *si);
+void enetc_teardown_cbdr(struct enetc_si *si);
 int enetc4_setup_cbdr(struct enetc_si *si);
 void enetc4_teardown_cbdr(struct enetc_si *si);
 int enetc_set_mac_flt_entry(struct enetc_si *si, int index,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
index a635bfdc30af..e4a393a8a58e 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_cbdr.c
@@ -3,10 +3,12 @@
 
 #include "enetc.h"
 
-int enetc_setup_cbdr(struct device *dev, struct enetc_hw *hw, int bd_count,
-		     struct enetc_cbdr *cbdr)
+int enetc_setup_cbdr(struct enetc_si *si)
 {
-	int size = bd_count * sizeof(struct enetc_cbd);
+	int size = ENETC_CBDR_DEFAULT_SIZE * sizeof(struct enetc_cbd);
+	struct enetc_cbdr *cbdr = &si->cbd_ring;
+	struct device *dev = &si->pdev->dev;
+	struct enetc_hw *hw = &si->hw;
 
 	cbdr->bd_base = dma_alloc_coherent(dev, size, &cbdr->bd_dma_base,
 					   GFP_KERNEL);
@@ -23,7 +25,7 @@ int enetc_setup_cbdr(struct device *dev, struct enetc_hw *hw, int bd_count,
 	cbdr->next_to_clean = 0;
 	cbdr->next_to_use = 0;
 	cbdr->dma_dev = dev;
-	cbdr->bd_count = bd_count;
+	cbdr->bd_count = ENETC_CBDR_DEFAULT_SIZE;
 
 	cbdr->pir = hw->reg + ENETC_SICBDRPIR;
 	cbdr->cir = hw->reg + ENETC_SICBDRCIR;
@@ -46,13 +48,15 @@ int enetc_setup_cbdr(struct device *dev, struct enetc_hw *hw, int bd_count,
 }
 EXPORT_SYMBOL_GPL(enetc_setup_cbdr);
 
-void enetc_teardown_cbdr(struct enetc_cbdr *cbdr)
+void enetc_teardown_cbdr(struct enetc_si *si)
 {
-	int size = cbdr->bd_count * sizeof(struct enetc_cbd);
+	struct enetc_cbdr *cbdr = &si->cbd_ring;
+	int size;
 
 	/* disable ring */
 	enetc_wr_reg(cbdr->mr, 0);
 
+	size = cbdr->bd_count * sizeof(struct enetc_cbd);
 	dma_free_coherent(cbdr->dma_dev, size, cbdr->bd_base,
 			  cbdr->bd_dma_base);
 	cbdr->bd_base = NULL;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index fbe2c126082e..7a5dcbfeb693 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -802,8 +802,7 @@ static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 		goto out_pci_remove;
 	}
 
-	err = enetc_setup_cbdr(&pdev->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
-			       &si->cbd_ring);
+	err = enetc_setup_cbdr(si);
 	if (err)
 		goto out_pci_remove;
 
@@ -822,7 +821,7 @@ static struct enetc_si *enetc_psi_create(struct pci_dev *pdev)
 	return si;
 
 out_teardown_cbdr:
-	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_teardown_cbdr(si);
 out_pci_remove:
 	enetc_pci_remove(pdev);
 out:
@@ -833,7 +832,7 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
 {
 	struct enetc_si *si = pci_get_drvdata(pdev);
 
-	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_teardown_cbdr(si);
 	enetc_pci_remove(pdev);
 }
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 7d022b9c12d7..e8ad5ad5aba4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -328,8 +328,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_init_si_rings_params(priv);
 
-	err = enetc_setup_cbdr(priv->dev, &si->hw, ENETC_CBDR_DEFAULT_SIZE,
-			       &si->cbd_ring);
+	err = enetc_setup_cbdr(si);
 	if (err)
 		goto err_setup_cbdr;
 
@@ -365,7 +364,7 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 err_alloc_msix:
 	enetc_free_si_resources(priv);
 err_alloc_si_res:
-	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_teardown_cbdr(si);
 err_setup_cbdr:
 	si->ndev = NULL;
 	free_netdev(ndev);
@@ -390,7 +389,7 @@ static void enetc_vf_remove(struct pci_dev *pdev)
 	enetc_free_msix(priv);
 
 	enetc_free_si_resources(priv);
-	enetc_teardown_cbdr(&si->cbd_ring);
+	enetc_teardown_cbdr(si);
 
 	free_netdev(si->ndev);
 
-- 
2.34.1


