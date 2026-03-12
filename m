Return-Path: <netdev+bounces-267218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qND7HMU/s2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:35:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8527AF2D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C219F31784FC
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE343BADAA;
	Thu, 12 Mar 2026 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="ALM2w1B6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4103A3B38AB
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354910; cv=none; b=DL4Zw4qykwRv3RDCCMwh+b7UWfApfcb/zBF7PiWQiME9PLi+aiWZymIbx9CgN6JtcWGv2lQ722yc09bMcJDlEsH2zXWKkNUqHF5fjm+jR46qP197DlKJZP2XTItlS/TnPSKm8sm6qnkjqCPG67kAvQHbkb61dbn5clTePqQsu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354910; c=relaxed/simple;
	bh=Z/ESX+LLNY5t82nBsQH8Qqv4GqQzNnZ9UJQed+Rqsn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOYdBE+eVvNG9daeOAyqDYuJMwDY96OmJC3OmquBDQT5n9nnTHTdRZ/x7ZYtDa3SAd28Z0LwRLOXg6B+bfWeXeRv8pJhDOCYENLkHzqbw7OYQichguFhfuHGIqvG5EmTw34aRcw5v4UFzgPjc+erL6WZEPMGX25toE/fgC5CgAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=ALM2w1B6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35a1c6081a5so370071a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354908; x=1773959708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhbXK6hap671NF5qoYb68AsIxNo8RyyFm3WoVwNRKKg=;
        b=ALM2w1B6qU98oRWzwOpue/SZqP+/jeMEJwh3g7KH5J6svrCZ4OPmDGVZN4sa1XTmBA
         M2d4NjqB2WKZOtgIjf402UWRGL3f1NK22atGEQrYRcjjx3EUmZ3piMYAF/HV0nh3Z8xy
         c1i6XQ9nlUPHnMWdzNg9kTVV8G5phty6xm1eLiyUq/NKX0UDmQSx7YCX8zk7G11OpCly
         Nmm4ejQlz8N18fCjxl+6p8TUb/0OjLslvlKoMww6k68B1EGOQ430zuZDTXwzP/58wf/B
         ES3MF71eb03gRA0QgKIUNwjCahbS6AEkJlsF0BFzczuUi2dBrK2J/IzeaERnjTJlz6NA
         pg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354908; x=1773959708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhbXK6hap671NF5qoYb68AsIxNo8RyyFm3WoVwNRKKg=;
        b=GWoMDvfTP+Wv25vRAQ4K72+MrS+LpwO7zc8fO0HHdmTumCHyewhJiWS3BeCKmgUksO
         H2JIWJZyyjIMxnJf1PVS/LTajJeN0XspSNoaOLtDCEL3O7xO0Fi9I5dYAJsKgJrjoIRU
         ZNf86/kbGq7F/YsM1G1oGd/Yg+Ckks3r7vTw//hXg+RUNSNYMaF0F2LBB14sEEFDUm37
         QCcAwMvrU8UQzMlZBzRuoe3X4k4utTb/8hBDbq1/eHnRqUqZuPM68cQecRic5t/HgQVZ
         bm4a2sYcFUG2xhk8V7h1lpZvkOorlkaJFaGrj5pD+nCFVTrqIWgp9IO8za45dHJ4Jfr1
         wx/g==
X-Gm-Message-State: AOJu0YyUlpO8chpUF7ekWXbpZAyDQd4wntWGsxXvzyBBog41sFx4YPM6
	XeXw0y4zIC836JtlCo2DQ7XhyFhXvE5IdB1w/3ayfxlfrlPvvMTUJ2D7GDlO01DmOIX7wYKKVSi
	oNVTJg48=
X-Gm-Gg: ATEYQzze5oJc3pb+4hkaer45dGkzKyZN2+RislYNkGuAGiJNlpT6y2MUAAP7fBRpDG6
	LvMHr58sPAVxZVzgFOocQjkkSXsjbFFaX8KWkkJiQl1esFazM5q5JuvmqxoCOucO2db6rAvX7YS
	qCAFZawUgn7dsZnOb+TKqli8ZPIwwlw43+Rzm8S2mCjZx4zODquUujH4MR+yU7uxlg8KZ05BQvC
	4Z1afa3p/DMkqLcajkMXbgVHvYHoUNboD1gZLOirY1X9pC/Nr4I0DzWXdAFSLcqC4rgO+XAtzZq
	UUIAhwyxV7iHV1h7RggAFErgSeHTgtSGMdz9DdesL/0+TrpPKmg5vkC/AxRo2bp9gsCrz/nDMxT
	zy/O176quWfXSwT0ARJLnstpasnYLFeFKFo8MrClIImJlOQjv0pVveomfl41jPKXp+DILvOQAHG
	PgPQEu
X-Received: by 2002:a17:90b:2b4d:b0:359:f5f4:7740 with SMTP id 98e67ed59e1d1-35a2208696fmr831058a91.17.1773354908222;
        Thu, 12 Mar 2026 15:35:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a1ac3baf8sm2718951a91.12.2026.03.12.15.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:07 -0700 (PDT)
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
Subject: [RFC net-next v2 01/12] net: tso: Introduce tso_dma_map
Date: Thu, 12 Mar 2026 15:34:38 -0700
Message-ID: <20260312223457.1999489-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267218-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: BED8527AF2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add struct tso_dma_map to tso.h for tracking DMA addresses of mapped
GSO payload data.

The struct combines DMA mapping storage (linear_dma, frags[]) with
iterator state (frag_idx, offset), allowing drivers to walk pre-mapped
DMA regions linearly. Helpers to initialize and operate on this struct
will be added in the next commit.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 include/net/tso.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/net/tso.h b/include/net/tso.h
index e7e157ae0526..cd4b98dbea71 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -3,6 +3,7 @@
 #define _TSO_H
 
 #include <linux/skbuff.h>
+#include <linux/dma-mapping.h>
 #include <net/ip.h>
 
 #define TSO_HEADER_SIZE		256
@@ -28,4 +29,37 @@ void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
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


