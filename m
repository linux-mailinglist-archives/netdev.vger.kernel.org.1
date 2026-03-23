Return-Path: <netdev+bounces-270667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPIFAVqPwWmuTwQAu9opvQ
	(envelope-from <netdev+bounces-270667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:07:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EDC2FBE12
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDFB730B06CE
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3542F4A14;
	Mon, 23 Mar 2026 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="T89p1VN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43D2E9757
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291144; cv=none; b=ZIftEqHZ7SFAHipdd+F02Tzi2gvKiHV6rwYVn4fBpHk9GqaEce1w+FvmEbfYo8+20By7/zMuxFHXEBhIuKm11pqA/+GwwbbN3iOtuymD3cDkbEm+DlhsOM1tOm0J/HoTJvizVVjjr2hrEGVF1KfCUqXHTcMgrydXCpjCX9v3VRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291144; c=relaxed/simple;
	bh=89osrXGFcyoMNdsGsSYJRS7HmUWWP8RNcJMZ4Irlins=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMBDuRMGT4coU8y8nKd7z+zKvMzsyoKpfhDQamohyD0gl3kijJX11uvI29aMysx/UN2zIaFJbXs6yLmhTwW1hALYp6kleg61Kq3MfeWHUdOKTI4GMj3W/5F3HuIhq7OqWyfe0jsmyZx3DHx5k+vr5VfXm8XtaUmzw0cRbG0ms50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=T89p1VN9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82c28f0a4ecso1892092b3a.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291141; x=1774895941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzwsL2AaeOyolPivj0sSP8+HZDWRlIMJad3TwBTVVkk=;
        b=T89p1VN9h6LGCEoOoEJGUO0OWJq/Sj2g4haLGWe1lelkQ4y+s+dAgkOBXDLaak8NoR
         759U9DUC6GhTXNgUYvBzCnHtrQMGsWkEO977OTsM2/+f/66Hn06RJR7XCvFNrqAXsQJP
         lDDUxA38ovEYfvo9HKFh98apoh7AZLraIr/2I6NSdORqpOzLM2FcPH912C88CeZFrcDx
         gkHTvDM7ANxl9tJeE8JO7jYt73+HnPntI21UZD6mADOCb5CveeBUw71L047Vy/7XVkuJ
         RiuqqXCR45jyEuAyKwWoJhOrdSyzbbdeSb9XoTZjEvLbkQY8LIL4YPvcnHtqniCBRhq1
         eYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291141; x=1774895941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hzwsL2AaeOyolPivj0sSP8+HZDWRlIMJad3TwBTVVkk=;
        b=QQ69DC0UEqWqVlgTjyOtV4R7SthNn+SK6DR+30/u0cDg1NMlLUU90X+bi32Q2/NU0i
         9Z/gQh71U4zYXMcVpZsQrLML5voqzFKv8JLL43lS1hzb/VJ7Ml61++ezd3zePTDwhCvF
         ZNbeTmkaMRvsVj3Ep64HkvG7LtceyeqXdvLwwUrZlqfoa5Hl45ot9i2pWFbN7AX8xZdP
         NbZoHcxDxNQCDbpw1ofjz73C1BA/JmciJK9rg66bgnlACRKs4wmbBzDE/OH9M8tzaalw
         3ifdtW6jPXOMQfs4juzN15A9hF7feGYSNcetDyzip4qzGAA1ccgN9biRgVr/4U6An584
         qfsA==
X-Gm-Message-State: AOJu0Yy/OoNhmyorfKRbP5e6loe4HjC5sSB7nRvdOu2F4PxwCvxVqXxL
	dO/iJT5JaIDStpWPDGJXVsq1CIps2gPocK+jNBV3i50mXhwxRp0utrnH61+wtbioQONEFjeMGbj
	PxplMcTE=
X-Gm-Gg: ATEYQzyns2ahnnLTNA95055hACdqo/nIUqkOBYavbCKkyebgS+2OgRcUU4xU5+YnYB2
	2orQXzlxxTdGbFsviVGDVjP8/d+7DzSX5W8XgSRsSJx5w9f4MMrmnWzgqzLWppY/TA1wy6dJUl4
	sZ/OvTUY2ICALE2qgZI8EoWPrL3xtzBB7kNNVkAVk1BV8xCgA8lcp45u+xxvKFsfRtN192CrS39
	8pj7n+lO/czNydSJwu7gGhAVSNoXMnq+9BQQHxVlttNNzqo4nOlGhcVXR+67ZEBctgol/1Mn+a4
	5xYofTQlGUk5AnYGSVwXu6c84n9Lgp26iTxbzY2MpSCCTZtMPMMWLLiuAuGqcb21MoLEkXW89a6
	8SD1mnMYUqQZEynHLTOEJLOasWL0eNZgi7m5zI2LMA4FwAXu/n3Fkx0H5ruQ2lQwCMnX3EBNgNM
	Djcuw=
X-Received: by 2002:a05:6a00:10c4:b0:829:88e7:c8a0 with SMTP id d2e1a72fcca58-82a8c209e2fmr10800620b3a.12.1774291140962;
        Mon, 23 Mar 2026 11:39:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c6besm11845843b3a.32.2026.03.23.11.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:00 -0700 (PDT)
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
Subject: [net-next v5 01/12] net: tso: Introduce tso_dma_map
Date: Mon, 23 Mar 2026 11:38:26 -0700
Message-ID: <20260323183844.3146982-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270667-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,dama.to:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 00EDC2FBE12
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


