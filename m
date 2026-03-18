Return-Path: <netdev+bounces-269157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJxdHGv5umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:13:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A312C1DCD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B848300D15A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F73F301468;
	Wed, 18 Mar 2026 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Fsyh5iLp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D413E9F96
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861219; cv=none; b=kwW1VRCGkuk1mN5J47kF66OGRAsMVQXvZTkWgkDy2CkqGSoqTQf+IF4Jl1CzgseUU+oqnfYG9S8KT9okQFBYRNQ8fN7YY0/7s2N8moE7E/NEpBXMQ32Tp0bgA8N3zT1yHX1WFmHXA+L/MilDZe2PUVLzqzG5oUUq/7L94UPed40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861219; c=relaxed/simple;
	bh=zew8Hi0Jlynv3BzSnDjtLPWvg3zE+oMVtctTTm4Asiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcEUUrn8IZY/jGy1Qu0bPz64Yk+jbWmbqduIyr13F9DN1ueIq66F5H0bDwtQJllqQQKTZBgkMzZ/pPNfr9hP8L+kaGxXgx5ZwziduPGNTUJKqoGDei4hj1lF3nmSc3uPATjUfWVQzHglQMam2ptBIMkjc5jwQOAktx+Zvp1xezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Fsyh5iLp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82a7539851fso156134b3a.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861216; x=1774466016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzwsL2AaeOyolPivj0sSP8+HZDWRlIMJad3TwBTVVkk=;
        b=Fsyh5iLpb9DWsrl+shceFbdZ0MY5C9Ad9moIH7MAyLWlwKTOtaoqPjrNNEDeZXRVJf
         TEsspaHdwfeY/Y5C8jctRUvr0oHNLEY/XcqkFmSmgVD9GzTJMjAWhPIx5EzVxWYvYLSJ
         T2bZVdQzKa+SfgW8wWLyMK13fWsFWtvsJ9HkSi7GqbvjA/w0ktXwh6LRO0RBRQbDeIPn
         eUS6GOk28aQ5wtHsejMT+EiSDGC/yaKYymYgZWCMQgds69aJ2lWiEdEAbc+Lo+l+jyV5
         v8MGnQ3xoT9Ig0X6Tyyx/r7U9X0DNmq3Eqebunlk2HBNpjEPKweIJVbJ9Nsy8oVr9ibq
         iENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861216; x=1774466016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hzwsL2AaeOyolPivj0sSP8+HZDWRlIMJad3TwBTVVkk=;
        b=g/1fDtSvucKKgQyGIrj4NtKWlj8kxaMc+NTMH7UsIvKF0qxzpl6SfZnBWTF7gikMbC
         CcxCxK9FyFtR2OqIl6weidL+rxLpx1CWqZUunzPA2lfJmobTFVtCb5KAK1x346AwpkbM
         1iQZ5ej8QYI5y0LNQhVQ9M7LTRSVFjQ51wKvi+MXY7ruyOL41MHOKSTsKRVYqovHtX6Y
         zatnV1ofLDn54l7iJL0S6oLP1Gc2Keq6h8R2sxbeKu1wvXkKM+EJv+q3tI2Rnx7pO0A6
         FqFPb8V1OGQFM5mFDHaGi9ExCd9EtRNpGtRSe7jmvAhBNBFciVE2knuXW0wPZi1d7AXv
         Y+DQ==
X-Gm-Message-State: AOJu0Yw2Usk7ghf6egyfLG6peqISVDuTXUuNBIRykdgD9REiIazPesUk
	5Ipwz3y12gMOUSsATEjDd9h/KfcQc5B8AGtKi8t95nSixv/AqndbxvAZbWjgQGQelNeU/emVDaB
	B1dtdtXI=
X-Gm-Gg: ATEYQzwWGbGJP1OpdLHhXA1Acym4DiWof9wUQBNC7lCBimsxhtaD36cpV2QjYnjLYTK
	Up2I73iqF68tvZG3YiJqGx9jS4DASyNscGcD6WIHsfDm1vpoPk0KYkb3/uKVrUBoUjBrOawuU+Y
	iFteYrWacyB3wIYvSB8vj8xZF+/V6lq/iwQ65AjQSsfpEj2+o684MPqfmDTHxgVfJ6SMa8lT+mh
	MqutcV6Ll9Y/BG6gYpoawnXsR1DvQGaR5LLFMx9aEWRyOimFC9mQYG1reZMW/dUwnGba4WF7uen
	tiHjj6LINVb3Ww+MCoI384RUjhDErzm7IVbuP4flTSS8zaPk8ot8uUO2z2+OLNkwz4F0vTGkVWA
	x7buYG6YScQ/iSVZpuDZ3OChLr3hRjvvF/bkTv5Px1apuhT4TnC7NEkAV1+xmclZj7UdF2UIxEM
	y2DVg=
X-Received: by 2002:a05:6a00:a1d:b0:81e:7496:f826 with SMTP id d2e1a72fcca58-82a6aedf286mr4281697b3a.31.1773861216102;
        Wed, 18 Mar 2026 12:13:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb390csm3766911b3a.29.2026.03.18.12.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:35 -0700 (PDT)
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
Subject: [net-next v3 01/12] net: tso: Introduce tso_dma_map
Date: Wed, 18 Mar 2026 12:13:06 -0700
Message-ID: <20260318191325.1819881-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269157-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C7A312C1DCD
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


