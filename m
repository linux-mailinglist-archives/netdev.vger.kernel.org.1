Return-Path: <netdev+bounces-266332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFjCAruLsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:23:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEDF258353
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 436E93054B98
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759BF3D47C4;
	Tue, 10 Mar 2026 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Dw1lXr6x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973C3CB2C7
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177766; cv=none; b=lTM4BTwxPdJ4zzC5J1dcOq4UK4GTzYr+Uiq0lyxmONjzfGrxkKCnaL6ZVOOCGDKofyJDBIGujjQGvU9gejnWHLtbL7jGDNEXTSbEnAQW7bVkvJhm83cetTOMSoJsbOTyFQR+msv9hY6sLOS4wan0VlXvxyYq2lWn1lXNiN59Ahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177766; c=relaxed/simple;
	bh=zvBLdH4BAnKwNC0mMbvEM7gYtBsX4O90UZ6qJh816nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIeew7as9N05/zHDCR/C4fAj9u1gpOB1NtjggEy2hJlRtCIR/3gTCLFYLMrjAuSTIxts1Ba8aYDwFJRwAxyvPoQShCtVjNcTNq7eqDNzGKITAnj8vnvjI6eoqYCuXFSkk/fmqTqBZA68KunbAzlHoR8Qp2CdrLMgTJ3OgwbOaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Dw1lXr6x; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c739561f0d3so4018148a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177764; x=1773782564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USJsgtHmtoDgSFTSjAgvcXraSNpVggb2xq+PXWw1f2A=;
        b=Dw1lXr6xR0eAMuodlBAMfTX408+O4jCjFi+hMhQFKdrwqH1jpcQqbfvqTgcAyN494O
         FLwzXAMNM7BnqBLd/YMjXwFCjy2Tn70GDq4RysN4I2MUCbfJY29AkW/qFUrrxcdW/UPm
         5k+kPW/Wf17lcD75tK7QXBEdUpQxUPm0IDcPWrqts736/R1XKBMy22GQUNn7RcaiYYuj
         i3KOkUGKLYZcDKfoN5Ukoi52gY3iq5PjMUWYBZXZ6Vi/1hB5ad+14XOxnnR29fuAUGBj
         Pd48v5lnuV4SnGGNsyp+RF3/K58yjm3mPaa1/xcOvV7p84P/YPWn429hm2ePelnR8E1C
         M3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177764; x=1773782564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USJsgtHmtoDgSFTSjAgvcXraSNpVggb2xq+PXWw1f2A=;
        b=iGA5YR1w9mtr68/EO2oIEkICZ4kQDbcm93HUizU/Le+Qhg4j0vYNUkTNbHsjvvVkFQ
         F71bz09cJvzYLmoCeByJ4LXm4BLiSqkA5veFMcOvdobZZr5diRozRteao/p+6Rj/Z8q3
         W8y76C3qiDgFHIKtVcdC2/6i1GNHbrba4il2NJP+Gp0TLYfuQLRgkeLZK07n25ogzdOE
         CQqXu2jXLI+Ez1LXmoa+x+uFa74CjNgySoI4DHO6gA9JNWsugLPSkn7HIf2fY4b0ENo4
         bNlFUwg+tdgW5j1h9AWMehUQPSDH0p65kgwjYvZ09Oxb4D2b0oDwbb2VEonRntTjDn8n
         pwag==
X-Gm-Message-State: AOJu0Yyy+tskiz5NOOwXMorZUpGS0gAIJnAk/BWx8A0PTgOXNTyJOYaR
	/m6AqM097FH55hg47zudDb4Oi5QDhsPOi7fz+DLyuRWOuLSRQ7JTmar4XfEzja9aox13fIuqYXv
	FnDHjxJM=
X-Gm-Gg: ATEYQzxbsjTzN/5476Mfv2Z1de45b5mIGlZ1J3LIs0TQUteXLXa0yC2umQz2foTf5/7
	fde9qJKFbdyvoir9WkYKJVtUxTw9RrPWO6ynKFMHWO8D13uc0TEyAGZyhsKV68fsFLfQndPri/2
	btBDhrMYkUhW3x5ROoWQohTp7fwnhl4cedOXzKRfa5MqnHG4x+7ax3nQH81ta/dIWeHOga4iW2X
	PVaam3ljYCTZUQMYRlhAPxRZmJsjpXaEVCklZ8YTF0bz7ftmqD9/f/VlePacG0XbeCe8D4IY3lE
	nr8pA8S7t6ay7XQAxvuLOhMeLnovP5v3hO8XtSrBBNEE5WaqkSMUpgiBN44g4TJrp1C802gKM34
	QRw0b5omo740siNnXVtrVNhMeDfHcdU7d+oKIQecJtMKaAWrAD9jdaJHqYv/aOCexLXvs5pL0Wq
	ZFqHA=
X-Received: by 2002:a17:903:2b0c:b0:2ad:d5ea:4c89 with SMTP id d9443c01a7336-2aeae7c04bcmr2078045ad.22.1773177763969;
        Tue, 10 Mar 2026 14:22:43 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222dddsm2372365ad.19.2026.03.10.14.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:43 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next 01/10] net: tso: Introduce tso_dma_map
Date: Tue, 10 Mar 2026 14:21:49 -0700
Message-ID: <20260310212209.2263939-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8CEDF258353
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim,dama.to:mid,dama.to:email]
X-Rspamd-Action: no action

Add struct tso_dma_map to tso.h for tracking DMA addresses of mapped
GSO payload data.

The struct combines DMA mapping storage (linear_dma, frags[]) with
iterator state (frag_idx, offset), allowing drivers to walk pre-mapped
DMA regions linearly. Helpers to initialize and operate on this struct
will be added in the next commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 include/net/tso.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/net/tso.h b/include/net/tso.h
index e7e157ae0526..9a508e60ee19 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -3,6 +3,7 @@
 #define _TSO_H
 
 #include <linux/skbuff.h>
+#include <linux/dma-mapping.h>
 #include <net/ip.h>
 
 #define TSO_HEADER_SIZE		256
@@ -28,4 +29,40 @@ void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
 void tso_build_data(const struct sk_buff *skb, struct tso_t *tso, int size);
 int tso_start(struct sk_buff *skb, struct tso_t *tso);
 
+/**
+ * struct tso_dma_map - DMA mapping state for GSO payload
+ * @dev: device used for DMA mapping
+ * @skb: the GSO skb being mapped
+ * @hdr_len: per-segment header length
+ * @frag_idx: current region (-1 = linear, 0..nr_frags-1 = frag)
+ * @offset: byte offset within current region
+ * @linear_dma: DMA address of the linear payload (after headers)
+ * @linear_len: length of the linear payload
+ * @nr_frags: number of frags successfully DMA-mapped
+ * @frags: per-frag DMA address and length
+ *
+ * Struct that DMA-maps the payload regions of a GSO skb
+ * (linear data + frags) upfront, then provides iteration to yield
+ * (dma_addr, chunk_len) pairs bounded by region boundaries.
+ *
+ * Drivers set dma_unmap_len on the first descriptor touching each DMA
+ * mapping; the completion path unmaps via per-descriptor dma_unmap_len.
+ */
+struct tso_dma_map {
+	struct device		*dev;
+	const struct sk_buff	*skb;
+	unsigned int		hdr_len;
+	/* Iterator state */
+	int			frag_idx;
+	unsigned int		offset;
+	/* Pre-mapped regions */
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


