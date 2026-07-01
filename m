Return-Path: <netdev+bounces-303879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v8o1GaSURWoFCgsAu9opvQ
	(envelope-from <netdev+bounces-303879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A56F2191
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 00:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=iuTvXMe0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303879-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303879-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7F9B3126BE6
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 22:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045A420E79;
	Wed,  1 Jul 2026 22:25:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D34420E83
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 22:25:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944756; cv=none; b=Ix9xfIefS0C3e3r1ciAf4WhX2MySENMqJbh7skKDofOHJ4iXVcT6Js450yLSafzRsiTz7xp9kmdbRc7tkeGzajnkg2FPIdgnIorLU4dL8WDGtADu/rJC9vK//EeEULpV5vsxO/GtaayjW6p+9oQTLGJ2YGy8qRA1yMURjqGuDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944756; c=relaxed/simple;
	bh=8lSuqwumdn2BKTiHe/HUVakWWZ5vhW2QFM7z2iAvTEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uf/Uy2ZLZRHpAeXzM02JWkQnMAX7vxniu1CxWc0GkwSNKd93VL0g6zg9LsxJXx8ACSdW5uGN9VOT4GYN8ubNKPrLgW/g5N0Lp7I/ZbzKvFJWrPTxjQnMuWvXhAQhA14oGj39qfeT0M5liP5eXftIoq45cpSKqZZDqMLPMPUfdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iuTvXMe0; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Ln8Qr2227137;
	Wed, 1 Jul 2026 22:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UYGiXCIYODZfOiEgr
	8brLWoayiy96x4uNZR0YI3Jopo=; b=iuTvXMe0GBthUKXyTrdTl3CHUg2ioOm0T
	R5q/bw9yfYEqFtARmhWVxTx/WtN0UTUhWScfUNjuU57YEg9wvtIWZoy6h4YFEQOH
	6BS+TK8ZyLNVM7PCdwpWMr7JjIBqHNRfPNQyFsjrn9npBVyTcpvMcWnOSB86vCRY
	eh33lPo79TO7lk437ktGXE3happFf9OsOzjvHIinUeFTGBT6oDORABmnysPy5/uN
	cW23TxE+H8chmFnsj0a4N0BKZJXUSmxB+zzs02C75AOBLXELPxrR7dSBHziHGaT2
	IcgLjrekB1DantiPlSSoTsnyyNJklZA06RNeb+MmUMRgXIbwJeW7w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg6x47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661MJbXG028845;
	Wed, 1 Jul 2026 22:25:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w9fkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 22:25:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661MPdRx33816966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 22:25:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25D1558059;
	Wed,  1 Jul 2026 22:25:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B41C658067;
	Wed,  1 Jul 2026 22:25:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.150.53])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 22:25:37 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v2 09/15] ibmveth: Add per-queue RX statistics collection and reporting
Date: Wed,  1 Jul 2026 15:23:21 -0700
Message-Id: <20260701222327.61325-10-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260701222327.61325-1-mmc@linux.ibm.com>
References: <20260701222327.61325-1-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a4593e6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=yQpt-_ILD-ttr8A9-FoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfX0G752pSEnV2p
 xSd1lUyFVJL0XXSP4h09leDheqO4x5JfbfeAnETbP8hXd7RPtx5EhFl6E6BF4p2I5RXdKA6vEBH
 yH1nS7DCn9A9xZG26hDB9+hZIVl4AY4=
X-Proofpoint-GUID: PIHaagpiIAxTlP07plLQ5s4Z51psUa2x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIzOSBTYWx0ZWRfXx0oezyknr76t
 uzc3rUz1OghiI90UjqabPPvwU/W+GQxM8vijCsB/k5K843liffOr3+jnWMbRsbi/VtPKW8ax8aB
 wySIGvw7wHrQtJLGvLVk8TzEW42CR769xgVZDyt1SPSE0OdR2a+OpPF5db1nzOX9PuCJ9XLaYbE
 vRQ/hhlcQDJlV+1OwFEJR92Lh9JkcF2fGH2TKyMFniHz4DfDCF9sCD4bb/PfAJq7DO3DoG79QL1
 H3LF6XOFvchyN9mnSU1Cw6o/4tz7EzDs7la3KInGFY3r4yqK6XufNZN6+MzQcwB1mKDjH35FBQJ
 2Q7Uwsoo1B4Jjo7d7CYjZcYE2DctHnc3WT5K9up4IkbzQq8pSLQ/hiRTB3RhLEqhZfWKfCu43xe
 0eeuRmzR4xcdyy6fRA8BRSR2gnvFVHYXN6IgPR3Y711kjuAM0n8Iovt5rBrZ25fx5IWWEH8j+AY
 ISSWF8teBNWSr0tWyHQ==
X-Proofpoint-ORIG-GUID: XqIG2I4BpjPg8sPPQwRfD4wlMETuYQK4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010239
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-303879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:bjking1@linux.ibm.com,m:haren@linux.ibm.com,m:ricklind@linux.ibm.com,m:mmc@linux.ibm.com,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:davemarq@linux.ibm.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmc@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C09A56F2191

Count per-queue RX stats in poll, replenish, and the IRQ handler:
packets, bytes, polls, large_packets, invalid_buffers, no_buffer_drops,
and interrupts. Stop updating netdev->stats.rx_* in poll; totals are
summed from rx_qstats[] in get_stats64(). Per-queue TX stats follow in
the next patch.

Expose the counters via:

- ethtool -S: per-queue rxN_* strings and aggregated invalid/large
  packet globals via ibmveth_aggregate_rx_qstats(). pool%d_* reports
  queue-0 pool geometry (size, active, available) only: static probe
  config used as the template for every queue. Live per-queue pool
  usage is exported through sysfs in the next patch.
- get_stats64: sum rx_qstats[] so ip -s and /proc/net/dev report total RX
- ethtool hcall_stats counters and count send_lan on successful TX hcalls

Fix get_channels() reporting: max_rx is IBMVETH_MAX_RX_QUEUES only when
MQ firmware is enabled, rx_count tracks adapter->num_rx_queues.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 152 ++++++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 863e5c68b42c..1c08082ffbd6 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -98,7 +98,15 @@ static struct ibmveth_stat ibmveth_stats[] = {
 	{ "fw_enabled_ipv6_csum", IBMVETH_STAT_OFF(fw_ipv6_csum_support) },
 	{ "tx_large_packets", IBMVETH_STAT_OFF(tx_large_packets) },
 	{ "rx_large_packets", IBMVETH_STAT_OFF(rx_large_packets) },
-	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) }
+	{ "fw_enabled_large_send", IBMVETH_STAT_OFF(fw_large_send_support) },
+	{ "hcall_reg_lan_queue", IBMVETH_STAT_OFF(hcall_stats.reg_lan_queue) },
+	{ "hcall_reg_lan", IBMVETH_STAT_OFF(hcall_stats.reg_lan) },
+	{ "hcall_add_bufs_queue", IBMVETH_STAT_OFF(hcall_stats.add_bufs_queue) },
+	{ "hcall_add_bufs", IBMVETH_STAT_OFF(hcall_stats.add_bufs) },
+	{ "hcall_add_buf", IBMVETH_STAT_OFF(hcall_stats.add_buf) },
+	{ "hcall_free_lan_queue", IBMVETH_STAT_OFF(hcall_stats.free_lan_queue) },
+	{ "hcall_free_lan", IBMVETH_STAT_OFF(hcall_stats.free_lan) },
+	{ "hcall_send_lan", IBMVETH_STAT_OFF(hcall_stats.send_lan) },
 };
 
 /* simple methods of getting data from the current rxq entry */
@@ -847,6 +855,8 @@ static void ibmveth_update_rx_no_buffer(struct ibmveth_adapter *adapter)
 		__be64 *p = adapter->buffer_list_addr[i] + 4096 - 8;
 		u64 drops = be64_to_cpup(p);
 
+		if (adapter->rx_qstats)
+			adapter->rx_qstats[i].no_buffer_drops = drops;
 		if (i == 0)
 			adapter->rx_no_buffer = drops;
 	}
@@ -1925,22 +1935,71 @@ static int ibmveth_set_features(struct net_device *dev,
 	return rc1 ? rc1 : rc2;
 }
 
+/**
+ * ibmveth_aggregate_rx_qstats - Sum per-queue RX stats into globals
+ * @adapter: ibmveth adapter
+ *
+ * Cold path only (ethtool). Keeps legacy global counters meaningful for
+ * tools that read the adapter-level fields in ibmveth_stats[].
+ */
+static void ibmveth_aggregate_rx_qstats(struct ibmveth_adapter *adapter)
+{
+	u64 total_invalid = 0;
+	u64 total_large = 0;
+	int i;
+
+	if (!adapter->rx_qstats)
+		return;
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		total_invalid += adapter->rx_qstats[i].invalid_buffers;
+		total_large += adapter->rx_qstats[i].large_packets;
+	}
+
+	adapter->rx_invalid_buffer = total_invalid;
+	adapter->rx_large_packets = total_large;
+}
+
 static void ibmveth_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	u8 *p = data;
 	int i;
 
 	if (stringset != ETH_SS_STATS)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++, data += ETH_GSTRING_LEN)
-		memcpy(data, ibmveth_stats[i].name, ETH_GSTRING_LEN);
+	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++) {
+		memcpy(p, ibmveth_stats[i].name, ETH_GSTRING_LEN);
+		p += ETH_GSTRING_LEN;
+	}
+
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		ethtool_sprintf(&p, "rx%d_packets", i);
+		ethtool_sprintf(&p, "rx%d_bytes", i);
+		ethtool_sprintf(&p, "rx%d_interrupts", i);
+		ethtool_sprintf(&p, "rx%d_polls", i);
+		ethtool_sprintf(&p, "rx%d_large_packets", i);
+		ethtool_sprintf(&p, "rx%d_invalid_buffers", i);
+		ethtool_sprintf(&p, "rx%d_no_buffer_drops", i);
+	}
+
+	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
+		ethtool_sprintf(&p, "pool%d_size", i);
+		ethtool_sprintf(&p, "pool%d_active", i);
+		ethtool_sprintf(&p, "pool%d_available", i);
+	}
 }
 
 static int ibmveth_get_sset_count(struct net_device *dev, int sset)
 {
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+
 	switch (sset) {
 	case ETH_SS_STATS:
-		return ARRAY_SIZE(ibmveth_stats);
+		return ARRAY_SIZE(ibmveth_stats) +
+		       adapter->num_rx_queues * IBMVETH_NUM_RX_QSTATS +
+		       IBMVETH_NUM_BUFF_POOLS * 3;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1949,21 +2008,48 @@ static int ibmveth_get_sset_count(struct net_device *dev, int sset)
 static void ibmveth_get_ethtool_stats(struct net_device *dev,
 				      struct ethtool_stats *stats, u64 *data)
 {
-	int i;
 	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i, j;
+
+	ibmveth_aggregate_rx_qstats(adapter);
 
 	for (i = 0; i < ARRAY_SIZE(ibmveth_stats); i++)
 		data[i] = IBMVETH_GET_STAT(adapter, ibmveth_stats[i].offset);
+
+	for (j = 0; j < adapter->num_rx_queues; j++) {
+		if (adapter->rx_qstats) {
+			data[i++] = adapter->rx_qstats[j].packets;
+			data[i++] = adapter->rx_qstats[j].bytes;
+			data[i++] = adapter->rx_qstats[j].interrupts;
+			data[i++] = adapter->rx_qstats[j].polls;
+			data[i++] = adapter->rx_qstats[j].large_packets;
+			data[i++] = adapter->rx_qstats[j].invalid_buffers;
+			data[i++] = adapter->rx_qstats[j].no_buffer_drops;
+		} else {
+			i += IBMVETH_NUM_RX_QSTATS;
+		}
+	}
+
+	for (j = 0; j < IBMVETH_NUM_BUFF_POOLS; j++) {
+		data[i++] = adapter->rx_buff_pool[0][j].size;
+		data[i++] = adapter->rx_buff_pool[0][j].active;
+		data[i++] = atomic_read(&adapter->rx_buff_pool[0][j].available);
+	}
 }
 
 static void ibmveth_get_channels(struct net_device *netdev,
 				 struct ethtool_channels *channels)
 {
+	struct ibmveth_adapter *adapter = netdev_priv(netdev);
+
 	channels->max_tx = ibmveth_real_max_tx_queues();
 	channels->tx_count = netdev->real_num_tx_queues;
 
-	channels->max_rx = netdev->real_num_rx_queues;
-	channels->rx_count = netdev->real_num_rx_queues;
+	if (adapter->multi_queue)
+		channels->max_rx = IBMVETH_MAX_RX_QUEUES;
+	else
+		channels->max_rx = 1;
+	channels->rx_count = adapter->num_rx_queues;
 }
 
 static int ibmveth_set_channels(struct net_device *netdev,
@@ -2061,6 +2147,7 @@ static int ibmveth_send(struct ibmveth_adapter *adapter,
 		return 1;
 	}
 
+	adapter->hcall_stats.send_lan++;
 	return 0;
 }
 
@@ -2311,6 +2398,9 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 	if (WARN_ON(queue_index < 0 || queue_index >= adapter->num_rx_queues))
 		return 0;
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[queue_index].polls++;
+
 restart_poll:
 	while (frames_processed < budget) {
 		if (!ibmveth_rxq_pending_buffer(adapter, queue_index))
@@ -2319,7 +2409,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 		smp_rmb();
 		if (!ibmveth_rxq_buffer_valid(adapter, queue_index)) {
 			wmb(); /* suggested by larson1 */
-			adapter->rx_invalid_buffer++;
+			if (adapter->rx_qstats)
+				adapter->rx_qstats[queue_index].invalid_buffers++;
+			else
+				adapter->rx_invalid_buffer++;
 			netdev_dbg(netdev, "recycling invalid buffer\n");
 			rc = ibmveth_rxq_harvest_buffer(adapter, queue_index, true);
 			if (unlikely(rc))
@@ -2384,7 +2477,10 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 			if ((length > netdev->mtu + ETH_HLEN) ||
 			    lrg_pkt || iph_check == 0xffff) {
 				ibmveth_rx_mss_helper(skb, mss, lrg_pkt);
-				adapter->rx_large_packets++;
+				if (adapter->rx_qstats)
+					adapter->rx_qstats[queue_index].large_packets++;
+				else
+					adapter->rx_large_packets++;
 			}
 
 			if (csum_good) {
@@ -2394,8 +2490,11 @@ static int ibmveth_poll(struct napi_struct *napi, int budget)
 
 			napi_gro_receive(napi, skb);	/* send it up */
 
-			netdev->stats.rx_packets++;
-			netdev->stats.rx_bytes += length;
+			if (adapter->rx_qstats) {
+				adapter->rx_qstats[queue_index].packets++;
+				adapter->rx_qstats[queue_index].bytes += length;
+			}
+
 			frames_processed++;
 		}
 	}
@@ -2444,6 +2543,9 @@ static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance)
 	if (WARN_ON(qindex < 0 || qindex >= adapter->num_rx_queues))
 		return IRQ_NONE;
 
+	if (adapter->rx_qstats)
+		adapter->rx_qstats[qindex].interrupts++;
+
 	if (napi_schedule_prep(napi)) {
 		lpar_rc = ibmveth_disable_irq(adapter, qindex);
 		WARN_ON(lpar_rc != H_SUCCESS);
@@ -2656,6 +2758,33 @@ static netdev_features_t ibmveth_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
+/**
+ * ibmveth_get_stats64 - Return aggregated per-queue RX statistics
+ * @dev: network device
+ * @stats: rtnl link statistics storage
+ *
+ * Sums per-queue rx_qstats into rx_packets/rx_bytes for multi-queue mode.
+ * TX counters continue to come from netdev->stats (updated in start_xmit).
+ */
+static void ibmveth_get_stats64(struct net_device *dev,
+				struct rtnl_link_stats64 *stats)
+{
+	struct ibmveth_adapter *adapter = netdev_priv(dev);
+	int i;
+
+	if (adapter->rx_qstats) {
+		for (i = 0; i < adapter->num_rx_queues; i++) {
+			stats->rx_packets += adapter->rx_qstats[i].packets;
+			stats->rx_bytes += adapter->rx_qstats[i].bytes;
+		}
+	}
+
+	stats->tx_packets = dev->stats.tx_packets;
+	stats->tx_bytes = dev->stats.tx_bytes;
+	stats->tx_dropped = dev->stats.tx_dropped;
+	stats->tx_errors = dev->stats.tx_errors;
+}
+
 static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_open		= ibmveth_open,
 	.ndo_stop		= ibmveth_close,
@@ -2668,6 +2797,7 @@ static const struct net_device_ops ibmveth_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = ibmveth_set_mac_addr,
 	.ndo_features_check	= ibmveth_features_check,
+	.ndo_get_stats64	= ibmveth_get_stats64,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= ibmveth_poll_controller,
 #endif
-- 
2.39.3 (Apple Git-146)


