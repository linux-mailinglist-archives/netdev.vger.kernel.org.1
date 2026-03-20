Return-Path: <netdev+bounces-269933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIsiIdxcvWl09QIAu9opvQ
	(envelope-from <netdev+bounces-269933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:42:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EE22DBF35
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1526B302C72B
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E63C5534;
	Fri, 20 Mar 2026 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Lm8sE7OG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522F3C3BFD
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017714; cv=none; b=ryvJCp45xvK5GX1zingEMnKKuBftrJ8kiZrj6HIA1WtzafZz1cvElYC2FAHX6pWe3VFNZPOPtWMPtbqV+fNaz8V9gBIlqv3iLWNWpDarxpd19nZOmSArielfQdRCwL4b9kba+HEwcHgMRuAz6aS4Y8ItBMdg9z0e/5NSof/iHLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017714; c=relaxed/simple;
	bh=89osrXGFcyoMNdsGsSYJRS7HmUWWP8RNcJMZ4Irlins=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIEux8bG3/oOYZgkweKXf/icr1HP4azZgEHTpyLpUZnw2DIS9UwPo/uUj9eWNrbgY1JpZsQmYig6jsnhEqemZvnLGq+TLcJEWIGO95AWurBtRq1MRULrXjulXzI71OYC/muJQwNxLhr7FjH3A9vpcddxXuw1fp/9VHVq5IDXwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Lm8sE7OG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2addb31945aso13025505ad.1
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017712; x=1774622512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzwsL2AaeOyolPivj0sSP8+HZDWRlIMJad3TwBTVVkk=;
        b=Lm8sE7OGbocoDFV7Qr9a1YCPAiGWzFngthqaFsYayrlztFFYH8vcExxV5ZRHt/ox5U
         BpzMcwIZrTieMK1/FSh6332VrK/kg+CDdsUcj1TOd2k7ik9PSu5KJlOWEJ0R9xLB2IwK
         iBE3wdOLipV4nPnuzxHlKPjBsHMjAs2vxn6PPP+pXxzzdN1KaBcScpvCNrsCQXzjCyTG
         zv6NS/MKhPPoj6KwS4wlwFQLh8YGqAn6gvPUQFjtFxBECMAqJcllhPelqWTnd0wg+YM5
         9J/uiAkkUeNBqnylNd/s+x/aV7ywLxOxBaEicM+qQEUlXXyiie7IRCUNxWrp3P3y7WX1
         NCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017712; x=1774622512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hzwsL2AaeOyolPivj0sSP8+HZDWRlIMJad3TwBTVVkk=;
        b=ptCP8wglCCujZjhMfrVF7hHxsST36QEoM11zWbVGAx5a0OpvKd4bWJcTX5ZBCM8m/Q
         3+azklk0rMplxfOzSk7gBmD3wlEqUvlJCFgfvBmnFqx0TyFNZRBG8+S4eMkoqi53yMWT
         N2YLEzctuED2Ed1/jD7UCBogqAez22px1kc4Hodi4PBxi7ca9KBeWF88dQc38PR1VC/O
         h7tyAG5dUVMGoigJEPPN51rHpboUE1LO5xOCg2n466NGuGAzowv6DY0vqxCSxj3bvrzc
         EiLFkymawdCCgfi1VFiS/LBMdkyXkW22pRwFyAw67NloQheVgXSak5O/RhT1kOAZfHxX
         htoA==
X-Gm-Message-State: AOJu0YwanZ1130A4b+VWFQ9UGujB1tRCHv99Y/qPOIZw1UW6aBGzIiFE
	MJ5T6UaInPLmV8kKmtP54vC87oGiBj2K7XoIWlB+z+TCRbR2s17F2IXpQDM74uURw+JVjbI7LCv
	pxUPgGTY=
X-Gm-Gg: ATEYQzz+zNWt4FhfkeVFO6mhTrAEFGZvXTHhH/3ZXlYiiCnxu4/uhDllzkVZvoy6w5W
	cejdXfsxG/UXbhO6UaIJaeXbJj1MGwxN6VthRphp8sF4q6j8zM17TyVM4BuN1Qhn8XTRIyCnE3f
	VMn/WYta90SiAoveoMrTA1FRYeIrZEPXmDK+gbagc/Kw8gTYAWXsEYpsedAM9pXPe73SDcGYco6
	lMdMgf0plYlkROy6JKaKlU1UfSvfIe6zEGmtQn/IojgSkwLihALxNIN/QV101xefE9eu453KAm1
	wy0f9zRca9EzsVMicXDONL6uZ3ZhlqZdL+2aE21Fvjuc2i094Yve0zpzLgw0LS9yy8MzV65P3Xx
	8GEZRfmxT9MbQU0oY/N9t8JHfshiIrLdDk5nQp389YRNN0AAbv2u6XD9/FhDJ17yq7NmJWqSBxm
	D3MgU=
X-Received: by 2002:a17:902:e850:b0:2ae:7fbd:3dcd with SMTP id d9443c01a7336-2b0827e30f8mr31687945ad.52.1774017712230;
        Fri, 20 Mar 2026 07:41:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516194sm24208835ad.4.2026.03.20.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:41:51 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v4 01/12] net: tso: Introduce tso_dma_map
Date: Fri, 20 Mar 2026 07:41:22 -0700
Message-ID: <20260320144141.260246-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
References: <20260320144141.260246-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-269933-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.985];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 25EE22DBF35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add struct tso_dma_map to tso.h for tracking DMA addresses of mapped
GSO payload data.

The struct combines DMA mapping storage with iterator state, allowing
drivers to walk pre-mapped DMA regions linearly. Includes fields for
the DMA IOVA path (iova_state, iova_offset, total_len) and a fallback
per-region path (linear_dma, frags[], frag_idx, offset).

Helpers to initialize and operate on this struct will be added in the
next commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v3:
   - struct tso_dma_map extended to track IOVA state and
     a fallback per-region path.

 include/net/tso.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/net/tso.h b/include/net/tso.h
index e7e157ae0526..8f8d9d74e873 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -3,6 +3,7 @@
 #define _TSO_H
 
 #include <linux/skbuff.h>
+#include <linux/dma-mapping.h>
 #include <net/ip.h>
 
 #define TSO_HEADER_SIZE		256
@@ -28,4 +29,43 @@ void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
 void tso_build_data(const struct sk_buff *skb, struct tso_t *tso, int size);
 int tso_start(struct sk_buff *skb, struct tso_t *tso);
 
+/**
+ * struct tso_dma_map - DMA mapping state for GSO payload
+ * @dev: device used for DMA mapping
+ * @skb: the GSO skb being mapped
+ * @hdr_len: per-segment header length
+ * @iova_state: DMA IOVA state (when IOMMU available)
+ * @iova_offset: global byte offset into IOVA range (IOVA path only)
+ * @total_len: total payload length
+ * @frag_idx: current region (-1 = linear, 0..nr_frags-1 = frag)
+ * @offset: byte offset within current region
+ * @linear_dma: DMA address of the linear payload
+ * @linear_len: length of the linear payload
+ * @nr_frags: number of frags successfully DMA-mapped
+ * @frags: per-frag DMA address and length
+ *
+ * DMA-maps the payload regions of a GSO skb (linear data + frags).
+ * Prefers the DMA IOVA API for a single contiguous mapping with one
+ * IOTLB sync; falls back to per-region dma_map_phys() otherwise.
+ */
+struct tso_dma_map {
+	struct device		*dev;
+	const struct sk_buff	*skb;
+	unsigned int		hdr_len;
+	/* IOVA path */
+	struct dma_iova_state	iova_state;
+	size_t			iova_offset;
+	size_t			total_len;
+	/* Fallback path if IOVA path fails */
+	int			frag_idx;
+	unsigned int		offset;
+	dma_addr_t		linear_dma;
+	unsigned int		linear_len;
+	unsigned int		nr_frags;
+	struct {
+		dma_addr_t	dma;
+		unsigned int	len;
+	} frags[MAX_SKB_FRAGS];
+};
+
 #endif	/* _TSO_H */
-- 
2.52.0


