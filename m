Return-Path: <netdev+bounces-291170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGpeFFHwEmo25gYAu9opvQ
	(envelope-from <netdev+bounces-291170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:34:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ADA5C25F5
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8098C300829F
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C900D33291F;
	Sun, 24 May 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="tLLbrGh2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE33126D7;
	Sun, 24 May 2026 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779626062; cv=none; b=SESb6B/cpZfcfVVafQPaFzWCgefRRSkVCwc9bw5vDGykEAgD5fc37hQLfqm88zHpiXHQQUm6UueJaNy3WWZbJhx6+jEVBrD9dqD7CqmfeYNbQWBkMFTP/QW9VXcFqNUyq5eUBPBqoeXRZoo4wZUyPg5s0Sqt7vF41B2dBGkaFu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779626062; c=relaxed/simple;
	bh=szCCrtLdtFoE4dM7+O2m93gCw/j67O8g9H50uE1R6mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuZk5l/3yMZIT4KlDhi8jUpyOD5GFpabWccfk+2syK9Dg/jUAN53PEakdZXvKoes/CMVuZrHtjZNW4IdQFHN9R4Lm7RUb4bMeUSFV3QlY4uPt3V71lK0LbWVxtsqxAcWKZJU5MV66QOo6b4WM3xEvLFl+fINyYgzbSHHdF2y/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=tLLbrGh2; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 09ABA240060;
	Sun, 24 May 2026 14:26:43 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 643D2240114;
	Sun, 24 May 2026 14:26:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1779625601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NW2Brjv/gjqCBnukCyK/ebm4jUVcireHaKeLcTr3dUU=;
	b=tLLbrGh2DePrDrYHwUHWy3+06nv4Fwl5HUlmBmgWsoED67ROtKmEf2Z36JcrY78yOi8lhP
	NVOTQF9DXbuQw4jY/sSc/SlLgqekYpaQwD0SjllULsiklSF0+rKCK6sXSk3IS1YMdUdu0x
	tZosi0KNlZhwc7lsnD2JCg7JMvx30fxMFpllL5001oMHsmTKBZuu5GRGBoeVcWQ7J7/EHh
	q+xolqXa0zM2FrYA8nfJcFm+cbWR7zEAqKsdNzdINIi/wtD9NpspHMm7UOEASwfQ+W72ws
	70tOEsRnaCNoKFLdzEY+azCI+jz5FhZV6XB2DTLD76LUHmAouhFoYq5KrFIcIQ==
Received: from Til-Notebook.lan (unknown [IPv6:2a00:1f:5743:3300:7fdc:421c:b21a:ba71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id D39EA240102;
	Sun, 24 May 2026 14:26:37 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	mcroce@microsoft.com,
	sven.auhagen@voleatech.de,
	bpf@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH] net: mvpp2: fix skb not reflecting XDP modifications on XDP_PASS
Date: Sun, 24 May 2026 14:23:34 +0200
Message-ID: <20260524122334.1730451-1-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 50deb9
X-Rspamd-UID: 580b41
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tk154.de:s=DKIM001];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-291170-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,microsoft.com,voleatech.de,vger.kernel.org,tk154.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tk154.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@tk154.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tk154.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tk154.de:email,tk154.de:mid,tk154.de:dkim]
X-Rspamd-Queue-Id: 80ADA5C25F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When an XDP program uses bpf_xdp_adjust_head() or bpf_xdp_adjust_tail()
and then returns XDP_PASS, the driver ignores the updated xdp_buff
pointers and builds the skb from hardcoded offsets derived from the
original RX descriptor. This means any packet modifications made by the
XDP program are silently discarded before the skb reaches the network
stack.

Fix this by saving the post-XDP data pointer offset and length back into
rx_offset and rx_bytes when XDP_PASS is returned, so the subsequent
skb_reserve()/skb_put() calls use the actual packet geometry as seen by
the XDP program. When no XDP program is loaded the variables retain
their original descriptor-derived values and the non-XDP fast path is
unaffected.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f442b874bb59..27d4feebcb59 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3920,7 +3920,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		unsigned int frag_size;
 		dma_addr_t dma_addr;
 		phys_addr_t phys_addr;
-		int pool, rx_bytes, err, ret;
+		int pool, rx_bytes, rx_offset, err, ret;
 		struct page *page;
 		void *data;
 
@@ -3933,6 +3933,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		rx_status = mvpp2_rxdesc_status_get(port, rx_desc);
 		rx_bytes = mvpp2_rxdesc_size_get(port, rx_desc);
 		rx_bytes -= MVPP2_MH_SIZE;
+		rx_offset = MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
 		dma_addr = mvpp2_rxdesc_dma_addr_get(port, rx_desc);
 
 		pool = (rx_status & MVPP2_RXD_BM_POOL_ID_MASK) >>
@@ -3998,6 +3999,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 				continue;
 			}
 
+			/* Update offset and length to reflect any XDP adjustments. */
+			rx_offset = xdp.data     - data;
+			rx_bytes  = xdp.data_end - xdp.data;
+
 			metasize = xdp.data - xdp.data_meta;
 		}
 
@@ -4036,7 +4041,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		ps.rx_packets++;
 		ps.rx_bytes += rx_bytes;
 
-		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
+		skb_reserve(skb, rx_offset);
 		skb_put(skb, rx_bytes);
 		if (metasize)
 			skb_metadata_set(skb, metasize);
-- 
2.54.0


