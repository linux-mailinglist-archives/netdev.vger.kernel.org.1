Return-Path: <netdev+bounces-251364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35557D3C0B1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92311505AC5
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7680E392B99;
	Tue, 20 Jan 2026 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hEdU2e7n"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B28364E85;
	Tue, 20 Jan 2026 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893702; cv=none; b=VdXL7B+W5ZaeWD0xstomifGZ0j0doadt7/JOLsZ1aZImbNHJWmXodxRzCaO7q3Phw6pxiBvwIjp0CrM4rdTjD2YwncvEXtSunUp1e2bwTTh+H5AkIFNOkB+ZN0Be3ay6ksDywbZYmZr38fz7slsRq4DeHXngsxJSpJOXnKXQCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893702; c=relaxed/simple;
	bh=p8cAsH+U0zreVFn8XkbRD0x58b2kMBRfvTpcETKZl5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lkXlsPGYNeWAWqjBTv5JotPZ1vF+HBvMxHX+s/2dv1k2Doy73TsD+KiGVsZy1kIyuJ/fMJKw8VakdJjXvwuswwb9Y4bH6t4/9rVzyLZGn+Ucg7t3MMfZGKwGqd3E2Wi0Vie2fK1S6ShjWCQ//6wUof/Xoi6W1S+UGJDwMfrAq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hEdU2e7n; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Fn
	8sH/UPGAA1+BoMne6Uvp98j9WI73paMY45+Og8aWs=; b=hEdU2e7ngBfssFCG2O
	Vh6rK9A6lE03kYCxhIHmuUaZ8JLsY91aVSGIS4oWHYXufaWNgipoZPgH8OxERnkY
	TugTe6lSk0okFt0fVAWDtqFcrrnkaa76TJsOBc0E6WOQi6UA5lc5WhiDxFT4bhlB
	9PlUxBdXFerSvHn5J5K33EmZc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3P_e4LG9pP7D_Hw--.20586S2;
	Tue, 20 Jan 2026 15:20:26 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: [net] Revert "net: wwan: mhi_wwan_mbim: Avoid -Wflex-array-member-not-at-end warning"
Date: Tue, 20 Jan 2026 15:20:18 +0800
Message-Id: <20260120072018.29375-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P_e4LG9pP7D_Hw--.20586S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWUXw48Kw15Jw4fWr1UAwb_yoW5Zw4UpF
	4jk3yFvr4kGw1UWw4UAF4fZFWaqwn7K34Iy34Y9a4FqFnxtr15GFy8uFyrCrWYkayDuF13
	tFWUKF45ZF1kWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRiYFJUUUUU=
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC5xpv02lvLLqyyQAA3q

This reverts commit eeecf5d3a3a484cedfa3f2f87e6d51a7390ed960.

This change lead to MHI WWAN device can't connect to internet.
I found a netwrok issue with kernel 6.19-rc4, but network works
well with kernel 6.18-rc1. After checking, this commit is the
root cause.

Before appliing this serial changes on MHI WWAN network, we shall
revert this change in case of v6.19 being impacted.

Fixes: eeecf5d3a3a4 ("net: wwan: mhi_wwan_mbim: Avoid -Wflex-array-member-not-at-end warning")
Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/net/wwan/mhi_wwan_mbim.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index cf6d3e2a007b..1d7e3ad900c1 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -78,9 +78,8 @@ struct mhi_mbim_context {
 
 struct mbim_tx_hdr {
 	struct usb_cdc_ncm_nth16 nth16;
-
-	/* Must be last as it ends in a flexible-array member. */
 	struct usb_cdc_ncm_ndp16 ndp16;
+	struct usb_cdc_ncm_dpe16 dpe16[2];
 } __packed;
 
 static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim,
@@ -109,20 +108,20 @@ static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
 static struct sk_buff *mbim_tx_fixup(struct sk_buff *skb, unsigned int session,
 				     u16 tx_seq)
 {
-	DEFINE_RAW_FLEX(struct mbim_tx_hdr, mbim_hdr, ndp16.dpe16, 2);
 	unsigned int dgram_size = skb->len;
 	struct usb_cdc_ncm_nth16 *nth16;
 	struct usb_cdc_ncm_ndp16 *ndp16;
+	struct mbim_tx_hdr *mbim_hdr;
 
 	/* Only one NDP is sent, containing the IP packet (no aggregation) */
 
 	/* Ensure we have enough headroom for crafting MBIM header */
-	if (skb_cow_head(skb, __struct_size(mbim_hdr))) {
+	if (skb_cow_head(skb, sizeof(struct mbim_tx_hdr))) {
 		dev_kfree_skb_any(skb);
 		return NULL;
 	}
 
-	mbim_hdr = skb_push(skb, __struct_size(mbim_hdr));
+	mbim_hdr = skb_push(skb, sizeof(struct mbim_tx_hdr));
 
 	/* Fill NTB header */
 	nth16 = &mbim_hdr->nth16;
@@ -135,11 +134,12 @@ static struct sk_buff *mbim_tx_fixup(struct sk_buff *skb, unsigned int session,
 	/* Fill the unique NDP */
 	ndp16 = &mbim_hdr->ndp16;
 	ndp16->dwSignature = cpu_to_le32(USB_CDC_MBIM_NDP16_IPS_SIGN | (session << 24));
-	ndp16->wLength = cpu_to_le16(struct_size(ndp16, dpe16, 2));
+	ndp16->wLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_ndp16)
+					+ sizeof(struct usb_cdc_ncm_dpe16) * 2);
 	ndp16->wNextNdpIndex = 0;
 
 	/* Datagram follows the mbim header */
-	ndp16->dpe16[0].wDatagramIndex = cpu_to_le16(__struct_size(mbim_hdr));
+	ndp16->dpe16[0].wDatagramIndex = cpu_to_le16(sizeof(struct mbim_tx_hdr));
 	ndp16->dpe16[0].wDatagramLength = cpu_to_le16(dgram_size);
 
 	/* null termination */
@@ -585,8 +585,7 @@ static void mhi_mbim_setup(struct net_device *ndev)
 {
 	ndev->header_ops = NULL;  /* No header */
 	ndev->type = ARPHRD_RAWIP;
-	ndev->needed_headroom =
-			struct_size_t(struct mbim_tx_hdr, ndp16.dpe16, 2);
+	ndev->needed_headroom = sizeof(struct mbim_tx_hdr);
 	ndev->hard_header_len = 0;
 	ndev->addr_len = 0;
 	ndev->flags = IFF_POINTOPOINT | IFF_NOARP;
-- 
2.25.1


