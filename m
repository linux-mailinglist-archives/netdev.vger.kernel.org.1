Return-Path: <netdev+bounces-272283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKWbI0THxWmgBgUAu9opvQ
	(envelope-from <netdev+bounces-272283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:54:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE733D468
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF941304DE84
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EF13815F4;
	Thu, 26 Mar 2026 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="aj+ylgOn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F431AF3B
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569173; cv=none; b=alXM9pDH6Eo6w9JBaR/btj1tOr8HmEgnCIaI6Hsp7qzGYRFrVFCNDRxZjzZGcQhgjLQOQnWnqdUz3HDKN7DblPSWuypCvST2l8diC/YwwssVQfyherFXtMKUWM5+syeoCJZ23/wOg4/pUpsUOHgWXG/M7v116xWy8P0bYub6pjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569173; c=relaxed/simple;
	bh=89osrXGFcyoMNdsGsSYJRS7HmUWWP8RNcJMZ4Irlins=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcwNN0a1nR87N7wmxllVfYc3KKkCIfbDMvD8WlYEFKHe4t3aA78DwhGtJhC+zBdjs+3iKisqdhknTJbDNRpcSwjSYOTC6j5mk4fWevohWAuxCwwNPvriKB9OKQA82ZHObHm5zAFm+nMiK63sC9WqD+KBDV0foUWgm7FQmkUdxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=aj+ylgOn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c757a9251faso703890a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569172; x=1775173972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzwsL2AaeOyolPivj0sSP8+HZDWRlIMJad3TwBTVVkk=;
        b=aj+ylgOn5510l4Y1yr1L48xVbF+yPSDcoQ04fpFRCjWibUE3Dl6r+5hHV0s3tXUq8P
         daTXj8gqltaK6AK5N0fWmdswu+r8u1vjc0VwAFNS0ZdFmcaHTb30k3vC/LooVqYTWJCh
         30WMIve7I00ypX1HNnuIQaoutbA0ZkDiqkSmshjlpSX0f/3L3z0wRxjMSA0GOSs57JLh
         /tv5ycH5t3eJ2h0ugybsy5YsG27lTBpYgbP4gwoJ2bVrXb45W6+Q57OMujrOGUbpAjsu
         KeU/HmwSjtBih6m4VPWwVfJDSKOSf1yOJw0VZnHh0UTs5DLXzath5Q5zRScfdYHvX5+m
         oeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569172; x=1775173972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hzwsL2AaeOyolPivj0sSP8+HZDWRlIMJad3TwBTVVkk=;
        b=UExESvENpnWdCsQ4DE87LONKbp8EaCZKxyQF9XUXcmmcdgOk9ueSHa9iuXX057J2Fu
         pADhvweKk1uWScgIO1BQOlknRgj6cLSuKtE/4TZlh0xgyU49d4gIGalwoLHCU6FaSDG6
         KdiRMysUlBpSAWGt8ks2FCktINWAFSJnQmkLjxeIghBBvDi2+3J6lpXORgqWz9cKoTIy
         kxYLqeOnn/iA8EOY603PIuFHrtmwJdqlN4uoZ27cEOrlHmLyqE7MI12KBHSx3PEfNpBw
         Hp9kbas3VJ2WxUSUDumknl2RjXCXH7YsNcs+o0o346jSZjhJXlTP0o4r/+MZKjWHAnq3
         GD0Q==
X-Gm-Message-State: AOJu0YwqyM3ylLdpmsJ7HMOXRnfOb9K2ZN4rlfu3maCW+0TWdom7fB4z
	oJrUEJa1JKh2zartEdRPBKqX8MPdjjUdEUL5dpt+TNitR4tZ/JbgoE/olqtYg3Wx6/u6YSzD1Z2
	t2UOY
X-Gm-Gg: ATEYQzw1uESLQkiUPChY914HEH4VEmpPzDb4/ncBML9Q6kLWdzr3KasJzPvcpSj7fQ3
	iNxrBOZVRvgfrQ+O26OzFbEcK5+6LiKVDDvfWf7rJJPc+AzwA4L8hppuiIGXB1e1pftCfF4UXFG
	k4stIXYE15bARCUOyVJsIWmcRwI/nK8JvCYJKU+4YbemTcfGwm4aTc8vj7HL8YIFwW5a51uN/if
	pwm9Lopf34eUct36Xk+bXGUy0zI+NW43/QIr8cGNvHVnHrIKb15w769zXg0D6wAg5s8aMN/ByOn
	sFJtS26OhYv8Gjiit+JnKAcO7U42qr0o9olrScEvFr8DJh8NpZbs3QnU14dC/0mTdQ0Lt0xX/CY
	Ik7wZN6GqS8Vfc6Rw8F6uuAHf+gtK1jF/04DUWL6Bwb2yfzWJ160oRNbIsOc48uW9gakzkbtDoa
	MNaSw=
X-Received: by 2002:a17:903:19ed:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2b0cdc43116mr4855505ad.20.1774569171745;
        Thu, 26 Mar 2026 16:52:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e643sm43677055ad.41.2026.03.26.16.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:52:51 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v6 01/12] net: tso: Introduce tso_dma_map
Date: Thu, 26 Mar 2026 16:52:20 -0700
Message-ID: <20260326235238.2940471-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326235238.2940471-1-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272283-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,dama.to:mid,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E9AE733D468
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


