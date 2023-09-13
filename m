Return-Path: <netdev+bounces-33642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8638679F001
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 19:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB921C21189
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED51E1F952;
	Wed, 13 Sep 2023 17:13:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CC4200A8
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 17:13:55 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3183591
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:13:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5d4a8242so747297b3.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694625234; x=1695230034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/AfsWqTsY33pj6en+LuS4ONjftbdwS42oVsfuILkVY=;
        b=kMHgYyybaYfK9rZkAZMMD1u9+QuHUMoG+85HGCcGZET56f6VTu91RlzfXH78TniHs5
         YCb/KMZkcJsgDbawCA70Fd9flM7iitNmaiE7T7SLU0krnB2wFKODTbqkJ9oUfxNvCsLB
         TyA+OnzstTFtd+M76Ix6VzbvLtIepthHEqLJiGIDhuIIIcPW21NhTcyhmbt1MZM7MvFW
         cCtNguumnfD/MpJlitxeQS82aS+auyytFqSI/quCtihsX5W/CxcmgyKtpdFMahvb+t93
         LnlIupkjQLHdQ5yLGon80wPBhPVR+tyfGvdwq0tVYfblMATkLAFq3aABm0imLARVec/D
         k5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625234; x=1695230034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/AfsWqTsY33pj6en+LuS4ONjftbdwS42oVsfuILkVY=;
        b=VYWVg4ufpVhfpBwYACgnj0bomoXPybCK2PopUJx9/B3lfsYY+pNAdnZybVAXZSaf/T
         vPim2KXPicHpzZOIHnujC0HLifapdaEFzE91c9hFSOp23QWZ6EVZ5/FF0PFU7FGLUH51
         /UStEsOS9wRXgPHaaUwDyCpy7nECSJ/nGuSpR1KTGTBubz93pUn5BblgzwQjCgWIwQ9t
         PaGlgZN5kC7pbmWidLTIb1iUsvPSe1IejHPdIYAFHR3d/p6C6pdGlIScNaunBhQlJICU
         lt6hC2VW98V1CBCCd64ZX7BmyvId8Ww+k5C7C8iG1nODxIHtk1lr8X+NHv1LxF7BQswl
         TgWA==
X-Gm-Message-State: AOJu0Yzzq7wdZKAMZ6bHcvTDhj5OFU5ysmcDD3dXMji6h2lxWzjDXvBP
	Agn5JNEoRosS5/Gfn9uP+rQE+Jg=
X-Google-Smtp-Source: AGHT+IGcYpsAB5B+CyxeUuBbZ6ZnfoO+pPjAnIC5Zu3/29S4EZU0dlDMPQ0eeq5TlgSc3mJjXEq0clg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:2f96:0:b0:d81:7617:a397 with SMTP id
 v144-20020a252f96000000b00d817617a397mr28853ybv.9.1694625234437; Wed, 13 Sep
 2023 10:13:54 -0700 (PDT)
Date: Wed, 13 Sep 2023 10:13:48 -0700
In-Reply-To: <20230913171350.369987-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230913171350.369987-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913171350.369987-2-sdf@google.com>
Subject: [PATCH bpf-next v2 1/3] bpf: make it easier to add new metadata kfunc
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

No functional changes.

Instead of having hand-crafted code in bpf_dev_bound_resolve_kfunc,
move kfunc <> xmo handler relationship into XDP_METADATA_KFUNC_xxx.
This way, any time new kfunc is added, we don't have to touch
bpf_dev_bound_resolve_kfunc.

Also document XDP_METADATA_KFUNC_xxx arguments since we now have
more than two and it might be confusing what is what.

Cc: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/xdp.h    | 16 ++++++++++++----
 kernel/bpf/offload.c |  9 +++++----
 net/core/xdp.c       |  4 ++--
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index de08c8e0d134..d59e12f8f311 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -383,14 +383,22 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 
 #define DEV_MAP_BULK_SIZE XDP_BULK_QUEUE_SIZE
 
+/* Define the relationship between xdp-rx-metadata kfunc and
+ * various other entities:
+ * - xdp_rx_metadata enum
+ * - kfunc name
+ * - xdp_metadata_ops field
+ */
 #define XDP_METADATA_KFUNC_xxx	\
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
-			   bpf_xdp_metadata_rx_timestamp) \
+			   bpf_xdp_metadata_rx_timestamp, \
+			   xmo_rx_timestamp) \
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
-			   bpf_xdp_metadata_rx_hash) \
+			   bpf_xdp_metadata_rx_hash, \
+			   xmo_rx_hash) \
 
-enum {
-#define XDP_METADATA_KFUNC(name, _) name,
+enum xdp_rx_metadata {
+#define XDP_METADATA_KFUNC(name, _, __) name,
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 MAX_XDP_METADATA_KFUNC,
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 3e4f2ec1af06..6aa6de8d715d 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -845,10 +845,11 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 	if (!ops)
 		goto out;
 
-	if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP))
-		p = ops->xmo_rx_timestamp;
-	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
-		p = ops->xmo_rx_hash;
+#define XDP_METADATA_KFUNC(name, _, xmo) \
+	if (func_id == bpf_xdp_metadata_kfunc_id(name)) p = ops->xmo;
+	XDP_METADATA_KFUNC_xxx
+#undef XDP_METADATA_KFUNC
+
 out:
 	up_read(&bpf_devs_lock);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index a70670fe9a2d..bab563b2f812 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
+#define XDP_METADATA_KFUNC(_, name, __) BTF_ID_FLAGS(func, name, KF_TRUSTED_ARGS)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 BTF_SET8_END(xdp_metadata_kfunc_ids)
@@ -752,7 +752,7 @@ static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
 };
 
 BTF_ID_LIST(xdp_metadata_kfunc_ids_unsorted)
-#define XDP_METADATA_KFUNC(name, str) BTF_ID(func, str)
+#define XDP_METADATA_KFUNC(name, str, _) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
 #undef XDP_METADATA_KFUNC
 
-- 
2.42.0.283.g2d96d420d3-goog


