Return-Path: <netdev+bounces-45828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB0A7DFCC5
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 23:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8498E1C20E76
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17722EEF;
	Thu,  2 Nov 2023 22:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mg/DW7zm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73376225CB
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 22:58:53 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DBC185
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 15:58:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso1820687276.1
        for <netdev@vger.kernel.org>; Thu, 02 Nov 2023 15:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965931; x=1699570731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cchCkg2hcFOX1ZtG27UCGvSuVnk6LdagSTMBDQs0CwQ=;
        b=mg/DW7zmCp7wuhItaiqlVbM3jEg9AvLUI4PNHgZR/EKYMJWXTiKU5bxgtGGS+GDIaM
         jS15Nc0NCIYpKZMjVPT+8nOTitiE/MvvQ3ithlFjbpkpQ+NnIvbxPDeYwopaDp9lYuFQ
         SEovz46KUrWhc5AWlizjHrrlBWG8nO+yIOaObOeTIYY2VcJC67j45+FQgjiunITy43LD
         VAtE7fNHHHjrNTfN53ZXdWBhXvVfSW8rHLUA0tXkdpyAdgEI634jJsrKNvbidYyMQZBh
         19F3vo1DBoxeaWgmQdN0KL1vHH/U1OhTrMhMENXcr9PDjsTX/rG6gthaTfqRjaCGlqF/
         9oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965931; x=1699570731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cchCkg2hcFOX1ZtG27UCGvSuVnk6LdagSTMBDQs0CwQ=;
        b=QF3MQ+4BZT4oDzoP+MSUMifiy/oscnI1NpgIPDoL+htmOueoMpVFI6rMZ7Itp2mLWS
         LFJi91FIpXM2lA3+rhqU4pkmyW8cfrvR3AQpTmQEGG4/j1ilJ3TeD0DxnX80nE0NYSOs
         sdNt2Wid7LKmxd6SDetc+QiBdEAOUUpbYjGOmqdJqQm4rNrNHetuVBTRpSZqI48oTt34
         JFLh+5JVDoyTGIPAVlj0T0ofUUtdH7KsnZyF++406V6DWoJ1EEBbqY/MS87E7T8Xfim+
         Fxy7OMtwvTYXmSZG5FmLnAriZ93KKjaueIq1NUeBPypW4XrR6CxA3Tz3aAplCEWMfstI
         aJJg==
X-Gm-Message-State: AOJu0YyfI7FtiIzlsgOUN9cBtZe6ZxRPFjFsyhFTkQIX9G94EwoFvvhA
	SyOMLYeEG1S539EYZAWy5oyimMk=
X-Google-Smtp-Source: AGHT+IHj4JA6kBeIWI5vfIKduxpsOKCkJQxZJFhMF509ST6fAhXbSHC2dh+QTfMr/1MT9xvQhw/RoiI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:9392:0:b0:da0:cbe9:6bac with SMTP id
 a18-20020a259392000000b00da0cbe96bacmr401471ybm.11.1698965931578; Thu, 02 Nov
 2023 15:58:51 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:31 -0700
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-8-sdf@google.com>
Subject: [PATCH bpf-next v5 07/13] xsk: Validate xsk_tx_metadata flags
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

Accept only the flags that the kernel knows about to make
sure we can extend this field in the future. Note that only
in XDP_COPY mode we propagate the error signal back to the user
(via sendmsg). For zerocopy mode we silently skip the metadata
for the descriptors that have wrong flags (since we process
the descriptors deep in the driver).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xdp_sock_drv.h | 23 ++++++++++++++++++++++-
 net/xdp/xsk.c              |  4 ++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index e2558ac3e195..5885176ea01e 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -165,12 +165,28 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 	return xp_raw_get_data(pool, addr);
 }
 
+#define XDP_TXMD_FLAGS_VALID ( \
+		XDP_TXMD_FLAGS_TIMESTAMP | \
+		XDP_TXMD_FLAGS_CHECKSUM | \
+	0)
+
+static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+{
+	return !(meta->request.flags & ~XDP_TXMD_FLAGS_VALID);
+}
+
 static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
 {
+	struct xsk_tx_metadata *meta;
+
 	if (!pool->tx_metadata_len)
 		return NULL;
 
-	return xp_raw_get_data(pool, addr) - pool->tx_metadata_len;
+	meta = xp_raw_get_data(pool, addr) - pool->tx_metadata_len;
+	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+		return NULL; /* no way to signal the error to the user */
+
+	return meta;
 }
 
 static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
@@ -332,6 +348,11 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 	return NULL;
 }
 
+static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
+{
+	return false;
+}
+
 static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
 {
 	return NULL;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 84fd10201f2a..0e81ae6bfff4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -728,6 +728,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			}
 
 			meta = buffer - xs->pool->tx_metadata_len;
+			if (unlikely(!xsk_buff_valid_tx_metadata(meta))) {
+				err = -EINVAL;
+				goto free_err;
+			}
 
 			if (meta->request.flags & XDP_TXMD_FLAGS_CHECKSUM) {
 				if (unlikely(meta->request.csum_start +
-- 
2.42.0.869.gea05f2083d-goog


