Return-Path: <netdev+bounces-255910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGNOG4rEgGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:36:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE4CE4F6
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 371BC300BBA8
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9034C37754E;
	Mon,  2 Feb 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pwz7lsDt"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA536683B;
	Mon,  2 Feb 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046589; cv=fail; b=c51HW9YV59JSjbH2eI2OC44jdm1nNyNB3arfTcKlJBxRiLIlTmmigxGENPAJI8bLkX7jM5Ae4VIaoJIcRTcqJjXeZXaeStNXffLxKcMItRk4qWFmqQoFpAaJjMp0kufrVR0vvQkom3be+zeKQTkcifDLQdt6rtlWMFsRih+oWgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046589; c=relaxed/simple;
	bh=wxr9mwqu+Mwfpz0o/WGMzLzcldrp0eYOtEjH6c1YQzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwKYEJ2FDmh6r6+Xu12qFmyJPCmbNzeYFP8gKw9Dp7nGJk1AgAUCpUdZyoMJn9CMAChV/WJ3Ux09i4aA6y6IwXv4SZnWgB4CZN1PwFohVhgNl5GfrV4n8tv1cjLHzGGurTAg7rLcu5MdN+U6gd6RCWwn9rta+G8EYczCTYV9VwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pwz7lsDt; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRLvnSd4nokFY1YGL05odxhVPGMTHAmbjw0Yq2rJC2qtTrtLAAsBoh3jLMkt28YS1BXuWGgvuMFpD1E/aWm2V8DhbRKAhA2shMqib0AeTH8N7zg614Rd7N2ELo0b/O+Ka/Xk2I4njWVB7s9ZAAa8e43faMZjRcxPNa2Z79arReocPEqH3LSXfxyhYjG4VHpkCPoPgSgbc00tzAowohNvL5gqaObplrgC/7LImG9NZYaG+W0bjbQ4uURke9Ey9PWzKW7eZsPqLrPgXF/wSgeRqc4mcMRabd6FNto07Fs1DHc3TJMur/eSefWa9Jyr7jkIWYY02HyZ7j5uqieCFuTQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKre1zuBvctbNw3zvxpsqq/gJWtM6nT5OQSLpSQbYlc=;
 b=nr3ZLvKv+PPpxZqVsLAgRkjVGU0NYK+BvUFp4Lvne8iGw9cQ3s58eqMWmUlBFm/JxP4hOZDqWgoS44Jv/UieGU2cQwK22JL8ZXegdNuQ95qZWPo9CA/GgegeMidimBTg6LZOiSVE819t7no2IkBY0W+7ZBmO+fDu+VNEL9bRnozXGM3LGBwCHJq44QEsDyWWTaP8hd9iY/w2Hf9xWOcCC7GSmP/vCOWxs73gseqM6YwQ7eQ31ZZnZjBpmvQhdiv5rCm+Srh28KcfB8PNjMJ3mywymWnulRSZYpnC3hk1KyClsVCH/jqs7ORL46tkPAemX6yiwgqPRZDTE488U46NYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKre1zuBvctbNw3zvxpsqq/gJWtM6nT5OQSLpSQbYlc=;
 b=pwz7lsDtAr2qAKZlUtGnPybJtR7YYp2y//eVLwtHlGNuYI49neYREjfbKTcMAnddhZfvgYRogVJ2+m/+97WnFZUn84osyV1sZuWbn7Uulw/662qDA2nAvLmAWFkfS0obmFS/9d07NL0O2bvxT+J2wqSO7aBk4nVooKVeoJ3exA4=
Received: from BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::18)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:36:21 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::f5) by BL1P223CA0036.outlook.office365.com
 (2603:10b6:208:5b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 15:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 2 Feb 2026 15:36:20 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 09:36:18 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH 2/3] net: amd-xgbe: add ARP offload ethtool self-test
Date: Mon, 2 Feb 2026 21:05:41 +0530
Message-ID: <20260202153542.1727429-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202153542.1727429-1-Raju.Rangoju@amd.com>
References: <20260202153542.1727429-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae56176-02fe-4413-bdea-08de6270d09b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lsaubipPqkXGv9emtDWk9JtMK7LefUXwsDrAY3psWWtwLztJtEXEDXWGUXVZ?=
 =?us-ascii?Q?X5ftkeu1VviltXdxit4GdRE8b0Y+8dcoBO34i0K/3/X4g93A2nxBedl1q6Zo?=
 =?us-ascii?Q?6thOFN1R9/4TaZBDmyeKBIaaTuJeCluRJz+nwpQfR/e9cIEzTvsFOG3uWyme?=
 =?us-ascii?Q?+6ttT3oOts5FPb9NSTQjZJOntwkELpKzh/Vw1r+qJqMrHIxApbSxBix+7+Ab?=
 =?us-ascii?Q?5yORIFgv1oHImSZjHppLipAgnaHjln4i+O5TXIf7KgAlFt5SmLQNo18UAvv7?=
 =?us-ascii?Q?j1aMXD2MZx65TIVbc6iht7CpWq68q26JDOMLgzsnGTj/+nXyrI63aunDQCNS?=
 =?us-ascii?Q?x+WvwdhMsaS8FbXTFmoI87SzqS4GWrofQPicW/LQGsp4sIJohgWaTMCFBhy+?=
 =?us-ascii?Q?JAuFj/2Z0Iahc9OBbVf4Lm9trefqkgTM2V3ogCdor4q3cPG5crEhfblwASp+?=
 =?us-ascii?Q?juXLC6vZss0IPBmLrxTL7j6Z8bBfJdS0Fx7N36/rZx30ZxypuI74jvgjRekk?=
 =?us-ascii?Q?NVee94fMB2bvFzjsm45RJWImfAs3ryZAxDeUZX9nDEZLz1V/4w+fZZJzsCpL?=
 =?us-ascii?Q?iSgSnII1lE2CfHpqYuam4K+9x/mG2hkNbSBAtAJdhvK0CV6E6JWK4Pau2hC/?=
 =?us-ascii?Q?oQF2YoF3qSzu8XaMEcV5ivwJV4iJ4H5NwyLS85yJSSrmJrGeq9s/tCFcvEcc?=
 =?us-ascii?Q?y8iC9e15gAbnjcSikHvsHYB6sYxuA8gyfujkhB6arOTwp/tEPRtj98QTnCfR?=
 =?us-ascii?Q?U2NYvPFMMXCM4bx8jVPGiBhQsOcUtlDPdX5hncAk0kmmZPWu4w7djvPno+ij?=
 =?us-ascii?Q?hpPIYWNVk63Mi0ITnhVzv/JOoSZAVamVy8mOaEV95iYkISXI2wux+twCzv7R?=
 =?us-ascii?Q?W8VEnp0UnJ/jFLs9NQZ55c8Od8RZQNkHaHz5SdhB6HZLCzXPkvM+ES2naSFg?=
 =?us-ascii?Q?iGlszho96pezVGnyRhM/3Olv7x06uhdf8bnONPDdzi5d1O2N9ov4MSHz870y?=
 =?us-ascii?Q?wo+dsEQqDPI2K85lSj8CrOP5Sr06S0fAmryTQY/DTBBQGuahc/SBfHaidUtA?=
 =?us-ascii?Q?uxS0v9wW4ZVylhHHrzBKAopruO7R++pGuwX2HNHOBYzSgiwGX9MqiDrNMgFb?=
 =?us-ascii?Q?SGG9BqjFy0XqbvqghLHEikc2pbCn+OEUlAsVlH3CTsMYNMCfNHP67Ea1ve8E?=
 =?us-ascii?Q?7BnicgKVKAiF8QRu+iV5Kr3pX3LB107y4jBUPj9Tqea+FKpGANDFFOrN3Zwo?=
 =?us-ascii?Q?Fb9k3sWubC10VW/HlS2Wc3JDUOrWBTAJS9DOwwkot3W3WybiIBGeZ36aCC99?=
 =?us-ascii?Q?rsRK+qSpgXlWRn7+FKsw7AkMRWQVMZuF+urfr389mKxnw+N4K7tSet7eBwC2?=
 =?us-ascii?Q?DMhMgYkShRjuVjm12a9mO8/R9NxNU8qmDU8OP6GtA2itZJFkGn/gfEhfMT/k?=
 =?us-ascii?Q?2IoCTiUeRhZ4q3k/nVh7lsfFZpEPlJpHV3TcTpH2zzc1RMOCBDLKub4P25rW?=
 =?us-ascii?Q?1qf5XDBZNt/WCnsxURzAlo/LQ/Q5SMFv1NBnACpc1R8M0CaLbdl4pIX4JJCh?=
 =?us-ascii?Q?cU+JRuuq9fVsDKiasrvA3Sabmx9dtaK5I93lbTemaN7oC/Fhj8xkcfXA+Gpl?=
 =?us-ascii?Q?nJRhTe5VY8T94N2qwKKvv7EdzyxidPWsMFqU7eFYbD9wKvldHDuKwbPnMWIs?=
 =?us-ascii?Q?ZJ5wLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c7VqX2yVOY6Yixz1NNpYd343JWqYqDdDLT2lyzSSzr2TRbrLROllLJKXvRFPYssbOU6MvJJ0TfFiNeelmR8E1RyKz2Dr24cFfIjOd+y2Pppru57yDfxj6k1wYbJB2XJiV8Z84KWdYUMDJIFPKl1eWU9lPIztNw6NgmVOAyEvMWYX3diGtB5HE2RlkzZR/mpfNmMGjgNG7swCayDJB1P9u8JZQoU3HVVepfKq85fS0J2/yMjnTVhdgLLN4eKleivgRC8iJUCXEhHJahAHslQPiPThhK4d7+6+orFoJPgqLRzl/v0KGjPtrzlZcuLqkH8A224lXeKksdcVYuWPf7kxyKcSLgsKjuk/Ihibsm+Lq8dBxnSibIM0jOUy1UncTRcuk5lYFax4/tsgCj5CQxTvamtgfTx5ZUvnOcS7Wb6Kt25+9W/xHVCx7n69rarrzCvP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:36:20.8485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae56176-02fe-4413-bdea-08de6270d09b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255910-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0BFE4CE4F6
X-Rspamd-Action: no action

Add an ethtool self-test to verify the hardware ARP offload
functionality. The test validates that the MAC correctly responds
to ARP requests without CPU intervention.

Test procedure:
1. Check for aoe (ARP Offload Engine) hardware capability
2. Create an ARP request packet with test IP addresses
3. Enable ARP offload with the target IP address
4. Transmit the ARP request in PHY loopback mode
5. Verify that an ARP reply is received from the hardware
6. Clean up and restore configuration

The test requires the device to be in PHY loopback mode and runs as part
of offline ethtool self-test suite.

Usage:
  $ ethtool -t <interface>

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 55e5e467facd..ae4825578c59 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -9,8 +9,10 @@
 #include <linux/crc32.h>
 #include <linux/ip.h>
 #include <linux/udp.h>
+#include <linux/if_arp.h>
 #include <net/tcp.h>
 #include <net/udp.h>
+#include <net/arp.h>
 #include <net/checksum.h>
 #include <net/selftests.h>
 
@@ -152,6 +154,117 @@ static int __xgbe_test_loopback(struct xgbe_prv_data *pdata,
 	return ret;
 }
 
+static int xgbe_test_arp_validate(struct sk_buff *skb,
+				  struct net_device *ndev,
+				  struct packet_type *pt,
+				  struct net_device *orig_ndev)
+{
+	struct net_test_priv *tdata = pt->af_packet_priv;
+	struct ethhdr *eth_hdr;
+	struct arphdr *ah;
+
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb)
+		goto out;
+	if (skb_linearize(skb))
+		goto out;
+
+	eth_hdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* Verify the reply is destined to our test source MAC */
+	if (!ether_addr_equal_unaligned(eth_hdr->h_dest, tdata->packet->src))
+		goto out;
+
+	/* Verify this is an ARP packet */
+	if (eth_hdr->h_proto != htons(ETH_P_ARP))
+		goto out;
+
+	ah = arp_hdr(skb);
+
+	/* Verify this is an ARP reply */
+	if (ah->ar_op != htons(ARPOP_REPLY))
+		goto out;
+
+	tdata->ok = true;
+	complete(&tdata->comp);
+out:
+	kfree_skb(skb);
+	return 0;
+}
+
+static int xgbe_test_arpoffload(struct xgbe_prv_data *pdata)
+{
+	unsigned char src[ETH_ALEN] = {0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};
+	unsigned char bcast[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+	struct net_packet_attrs attr = {};
+	struct net_test_priv *tdata;
+	struct sk_buff *skb = NULL;
+	u32 dst_ip = 0xabcdefab;
+	u32 src_ip = 0xefdcbaef;
+	int ret;
+
+	/* Check if ARP offload is supported */
+	if (!pdata->hw_feat.aoe)
+		return -EOPNOTSUPP;
+
+	tdata = kzalloc(sizeof(*tdata), GFP_KERNEL);
+	if (!tdata)
+		return -ENOMEM;
+
+	tdata->ok = false;
+	init_completion(&tdata->comp);
+
+	tdata->pt.type = htons(ETH_P_ARP);
+	tdata->pt.func = xgbe_test_arp_validate;
+	tdata->pt.dev = pdata->netdev;
+	tdata->pt.af_packet_priv = tdata;
+	tdata->packet = &attr;
+	dev_add_pack(&tdata->pt);
+
+	attr.src = src;
+	attr.ip_src = src_ip;
+	attr.dst = bcast;
+	attr.ip_dst = dst_ip;
+
+	/* Create ARP request packet */
+	skb = arp_create(ARPOP_REQUEST, ETH_P_ARP, htonl(dst_ip),
+			 pdata->netdev,	htonl(src_ip), NULL, src, bcast);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	skb->pkt_type = PACKET_HOST;
+	skb->dev = pdata->netdev;
+	skb->protocol = htons(ETH_P_ARP);
+
+	/* Enable ARP offload */
+	xgbe_enable_arp_offload(pdata, dst_ip);
+
+	ret = dev_set_promiscuity(pdata->netdev, 1);
+	if (ret) {
+		kfree_skb(skb);
+		goto cleanup;
+	}
+
+	ret = dev_direct_xmit(skb, 0);
+	if (ret)
+		goto cleanup_promisc;
+
+	/* Wait for ARP reply */
+	wait_for_completion_timeout(&tdata->comp, NET_LB_TIMEOUT);
+	ret = tdata->ok ? 0 : -ETIMEDOUT;
+
+cleanup_promisc:
+	dev_set_promiscuity(pdata->netdev, -1);
+cleanup:
+	xgbe_disable_arp_offload(pdata);
+	dev_remove_pack(&tdata->pt);
+free:
+	kfree(tdata);
+	return ret;
+}
+
 static int xgbe_test_mac_loopback(struct xgbe_prv_data *pdata)
 {
 	struct net_packet_attrs attr = {};
@@ -251,6 +364,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "Jumbo Frame    ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_jumbo,
+	}, {
+		.name = "ARP Offload    ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_arpoffload,
 	},
 };
 
-- 
2.34.1


