Return-Path: <netdev+bounces-288328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKVfKFsuB2oLsgIAu9opvQ
	(envelope-from <netdev+bounces-288328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:31:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAF85517A9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C3A9300B3E6
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF43932D1;
	Fri, 15 May 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b="q65Whuxy"
X-Original-To: netdev@vger.kernel.org
Received: from sender-pp-o93.zoho.in (sender-pp-o93.zoho.in [103.117.158.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9752367F51
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855512; cv=pass; b=RrDOF7oi2hIx9oC1Pn5qaIv34ONF4k5VhWV7+QrTlOxP/I1BYDzRwirlJ04ycgWSulACH7ZtB+SD4HBaSzwCZs2eoNfmI145n7sXNRSZPIZr6XqPqYDE4tghzRiMa/5AxpEePMD2SNoEQ1DmSFkktuYKIP+Buqc3NAChP0ozXo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855512; c=relaxed/simple;
	bh=yrzyDnTvFRGO23Rk7kM4kIx3fbpV7VD5uahzJ2pWsUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgnyReEmmi76nu0SPyGAqazFpNP54Ueu+W0dLC9/y60kChvNRO2nJEEM6CEYFWJl9a2J1kbuWvc8sWNab2xaDsFxAIZ8OO97tgwmnNu07WE53mb2UOZg79TpAH9thn7B65630z1vBly3UwVuXHfYkOwHeVHn9LByppT0QZsiHvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=kshitiz.bartariya@zohomail.in header.b=q65Whuxy; arc=pass smtp.client-ip=103.117.158.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
ARC-Seal: i=1; a=rsa-sha256; t=1778855458; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=c9Dx97FbOnI9qaPMQrDk3Bg8gekc+K4OkVCgccXzF9irD8YIV5JjMHVftW8tlW9Xyh6Nkz7PA6H7iXODe7+egQrXXNPbeBUDnMwQ9xtPCmYdFLNW04G2CgF8suLWcHp9NVObD1o2BBrbWsmQqQRJw9a2aE5U8iGVzUgQANGF9cY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1778855458; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fhIN3zCM8kVhoVPicrrLTx3Drgf0l4gyykQ6YFAV4As=; 
	b=SCJQffqNTEtFaMaJNiQ17udawf/z/SmlTtwBvM1gBiFZEDBiLDlraJ9IVcCVValuoW1hjFZR9lY+tKW7raKBveH4dNJ0dQtnPUl1woFYFRh1c6lH2uxje4vvTjHtryaF8DeayvF5TBXWW+zap7Nn/RXsNFL88q+VhI/d/mKnndI=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=kshitiz.bartariya@zohomail.in;
	dmarc=pass header.from=<kshitiz.bartariya@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778855458;
	s=zoho; d=zohomail.in; i=kshitiz.bartariya@zohomail.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fhIN3zCM8kVhoVPicrrLTx3Drgf0l4gyykQ6YFAV4As=;
	b=q65WhuxyGgfj0+TTo3r4e7HWlrrkiHx4KDQ2+ynLsf52hZREFdPWdmq/7/gRmlAV
	NpXrvVPMZAXv/QwOTLMJbbzY8ayUCTBM+hgkiTLVLqZ522fPQSIgNCyWX6VGpp/mBVS
	7qnoB0zSgEE1wdziexfujyRmVXQqyL8I2WAgPPd8=
Received: by mx.zoho.in with SMTPS id 1778855452266322.9274965790356;
	Fri, 15 May 2026 20:00:52 +0530 (IST)
From: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
To: hkallweit1@gmail.com,
	nic_swsd@realtek.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: r8169: add RX allocation failure counters
Date: Fri, 15 May 2026 20:00:09 +0530
Message-ID: <20260515143015.64018-1-kshitiz.bartariya@zohomail.in>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 1DAF85517A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.in,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-288328-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kshitiz.bartariya@zohomail.in,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[zohomail.in:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add driver-private ethtool counters for RX allocation failures so packet
drops under memory pressure are easier to diagnose.

The new aggregate rx_alloc_fail counter is incremented when the driver
fails to allocate an RX page, fails to map an RX page for DMA, or fails
to allocate an skb in the RX receive path. Individual counters for finer
details are:
 1. rx_buf_alloc_fail : failed to allocate an RX page
 2. rx_dma_mapping_fail : failed to map an RX page for DMA
 3. rx_skb_alloc_fail : failed to allocate an skb

These are kept in struct rtl8169_private instead of
struct rtl8169_counters, which contain the hardware tally counters.

Signed-off-by: Kshitiz Bartariya <kshitiz.bartariya@zohomail.in>
---
 drivers/net/ethernet/realtek/r8169_main.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..c1a200e14f6f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -766,6 +766,10 @@ struct rtl8169_private {
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
+	atomic64_t rx_alloc_fail;
+	atomic64_t rx_buf_alloc_fail;
+	atomic64_t rx_dma_mapping_fail;
+	atomic64_t rx_skb_alloc_fail;
 	u32 saved_wolopts;
 
 	const char *fw_name;
@@ -1901,6 +1905,10 @@ static const char rtl8169_gstrings[][ETH_GSTRING_LEN] = {
 	"multicast",
 	"tx_aborted",
 	"tx_underrun",
+	"rx_alloc_fail",
+	"rx_buf_alloc_fail",
+	"rx_dma_mapping_fail",
+	"rx_skb_alloc_fail",
 };
 
 static int rtl8169_get_sset_count(struct net_device *dev, int sset)
@@ -1999,6 +2007,10 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
 	data[10] = le32_to_cpu(counters->rx_multicast);
 	data[11] = le16_to_cpu(counters->tx_aborted);
 	data[12] = le16_to_cpu(counters->tx_underrun);
+	data[13] = atomic64_read(&tp->rx_alloc_fail);
+	data[14] = atomic64_read(&tp->rx_buf_alloc_fail);
+	data[15] = atomic64_read(&tp->rx_dma_mapping_fail);
+	data[16] = atomic64_read(&tp->rx_skb_alloc_fail);
 }
 
 static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)
@@ -4167,12 +4179,17 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	struct page *data;
 
 	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
-	if (!data)
+	if (!data) {
+		atomic64_inc(&tp->rx_alloc_fail);
+		atomic64_inc(&tp->rx_buf_alloc_fail);
 		return NULL;
+	}
 
 	mapping = dma_map_page(d, data, 0, R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(d, mapping))) {
 		netdev_err(tp->dev, "Failed to map RX DMA!\n");
+		atomic64_inc(&tp->rx_alloc_fail);
+		atomic64_inc(&tp->rx_dma_mapping_fail);
 		__free_pages(data, get_order(R8169_RX_BUF_SIZE));
 		return NULL;
 	}
@@ -4823,6 +4840,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		skb = napi_alloc_skb(&tp->napi, pkt_size);
 		if (unlikely(!skb)) {
 			dev->stats.rx_dropped++;
+			atomic64_inc(&tp->rx_alloc_fail);
+			atomic64_inc(&tp->rx_skb_alloc_fail);
 			goto release_descriptor;
 		}
 
-- 
2.50.1 (Apple Git-155)


