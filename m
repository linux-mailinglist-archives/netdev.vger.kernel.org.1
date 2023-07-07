Return-Path: <netdev+bounces-16117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D8874B713
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D682818C4
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2D17720;
	Fri,  7 Jul 2023 19:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4521174D4
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:30:23 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3053F2D49
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:30:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-553d42a7069so3254718a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 12:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758209; x=1691350209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUwtriwyOracwMOZXeZy5WPkxcNh6yxf9oRms7nzKTY=;
        b=oOLV4zrDUqAxxkowDhttg1IrzvIgFKZh2y7reDvYsW4ZMXYf4FAv+6TQjrVFk5pgLG
         yLWyKfFJaMOpODuzlWLBR/0l7NY3ENVg3Q8xVAyPYHHgueeghr+ftWEczMRnfokhg5bc
         8PF8Yzx6TXjH5pnB0woFb5jrx5mdbNK2Dt8W1ijJkic2n5AmiDusi5vGllSNsjJcmDhC
         8WjSchF/EoKlmJNNVMFicidjdRIHsjVhdKJ/oqIbJuma2IWqyAyaNRx+XfxupvXJ3F0h
         nsZ2rntCqpjc+8c+KsvQbrQ7gYVZyCst7LcVDhuc/qcF+FRrShuScuQP+CSgjOHbXcZo
         ROhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758209; x=1691350209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pUwtriwyOracwMOZXeZy5WPkxcNh6yxf9oRms7nzKTY=;
        b=IMbD1a6HPKlpHwDU7J8CMCXkijr2PDM6lKNxPF8FTGnEr5WLts5crEEc1siQtPpBfl
         0FA/3qe3mV++fNR12q8vDtFPVIq0GgpIEf4BRefDHkovyRCzn/ruVnLUS2qvTmH5WyYT
         eefLTmYjvgzOF8rTusMdVIA7dXzaWigxYp/Iq+OuQVuuFlKmt34U4J4RynAuY2Hn5i5e
         DpoPM4AqUdsNtb8IaoSuDo2MD7m7fMlC52YTRZ4fHNK/y+CGX2nDGUBtjyT24JRYUZgS
         yXmQLzUkVbnoIzPJ7exkBzH3K/8Y2JTjQEy7pfYHE0tpI/2zn/OkseOKThVYXVHJWfxB
         afPQ==
X-Gm-Message-State: ABy/qLZrHd7ko+S53tvuEN+LJEtM38M4Mgd1wycZBp+QinbvTeYeAIrP
	6ZyzDJWHUTNQpxBfB+TRtxos52M=
X-Google-Smtp-Source: APBJJlHfnmoyS4495xHVU6VUWBR28u6C2ELCQ1/k8iKyN9B++NBMhgpA3UyTUK0+bu6zEa88AdAOVgU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7015:0:b0:553:3b6c:b3b3 with SMTP id
 l21-20020a637015000000b005533b6cb3b3mr4002662pgc.4.1688758209600; Fri, 07 Jul
 2023 12:30:09 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:29:53 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-2-sdf@google.com>
Subject: [RFC bpf-next v3 01/14] bpf: Rename some xdp-metadata functions into dev-bound
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

No functional changes.

To make existing dev-bound infrastructure more generic and be
less tightly bound to the xdp layer, rename some functions and
move kfunc-related things into kernel/bpf/offload.c

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/offload.h | 28 ++++++++++++++++++++++++++++
 include/net/xdp.h     | 18 +-----------------
 kernel/bpf/offload.c  | 26 ++++++++++++++++++++++++--
 kernel/bpf/verifier.c |  4 ++--
 net/core/xdp.c        | 20 ++------------------
 5 files changed, 57 insertions(+), 39 deletions(-)
 create mode 100644 include/net/offload.h

diff --git a/include/net/offload.h b/include/net/offload.h
new file mode 100644
index 000000000000..264a35881473
--- /dev/null
+++ b/include/net/offload.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_NET_OFFLOAD_H__
+#define __LINUX_NET_OFFLOAD_H__
+
+#include <linux/types.h>
+
+#define XDP_METADATA_KFUNC_xxx	\
+	NETDEV_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
+			      bpf_xdp_metadata_rx_timestamp) \
+	NETDEV_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
+			      bpf_xdp_metadata_rx_hash)
+
+enum {
+#define NETDEV_METADATA_KFUNC(name, _) name,
+XDP_METADATA_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+MAX_NETDEV_METADATA_KFUNC,
+};
+
+#ifdef CONFIG_NET
+u32 bpf_dev_bound_kfunc_id(int id);
+bool bpf_is_dev_bound_kfunc(u32 btf_id);
+#else
+static inline u32 bpf_dev_bound_kfunc_id(int id) { return 0; }
+static inline bool bpf_is_dev_bound_kfunc(u32 btf_id) { return false; }
+#endif
+
+#endif /* __LINUX_NET_OFFLOAD_H__ */
diff --git a/include/net/xdp.h b/include/net/xdp.h
index d1c5381fc95f..de4c3b70abde 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -9,6 +9,7 @@
 #include <linux/skbuff.h> /* skb_shared_info */
 #include <uapi/linux/netdev.h>
 #include <linux/bitfield.h>
+#include <net/offload.h>
 
 /**
  * DOC: XDP RX-queue information
@@ -384,19 +385,6 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 
 #define DEV_MAP_BULK_SIZE XDP_BULK_QUEUE_SIZE
 
-#define XDP_METADATA_KFUNC_xxx	\
-	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
-			   bpf_xdp_metadata_rx_timestamp) \
-	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
-			   bpf_xdp_metadata_rx_hash) \
-
-enum {
-#define XDP_METADATA_KFUNC(name, _) name,
-XDP_METADATA_KFUNC_xxx
-#undef XDP_METADATA_KFUNC
-MAX_XDP_METADATA_KFUNC,
-};
-
 enum xdp_rss_hash_type {
 	/* First part: Individual bits for L3/L4 types */
 	XDP_RSS_L3_IPV4		= BIT(0),
@@ -444,14 +432,10 @@ enum xdp_rss_hash_type {
 };
 
 #ifdef CONFIG_NET
-u32 bpf_xdp_metadata_kfunc_id(int id);
-bool bpf_dev_bound_kfunc_id(u32 btf_id);
 void xdp_set_features_flag(struct net_device *dev, xdp_features_t val);
 void xdp_features_set_redirect_target(struct net_device *dev, bool support_sg);
 void xdp_features_clear_redirect_target(struct net_device *dev);
 #else
-static inline u32 bpf_xdp_metadata_kfunc_id(int id) { return 0; }
-static inline bool bpf_dev_bound_kfunc_id(u32 btf_id) { return false; }
 
 static inline void
 xdp_set_features_flag(struct net_device *dev, xdp_features_t val)
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 8a26cd8814c1..235d81f7e0ed 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -844,9 +844,9 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 	if (!ops)
 		goto out;
 
-	if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP))
+	if (func_id == bpf_dev_bound_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP))
 		p = ops->xmo_rx_timestamp;
-	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
+	else if (func_id == bpf_dev_bound_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
 		p = ops->xmo_rx_hash;
 out:
 	up_read(&bpf_devs_lock);
@@ -854,6 +854,28 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 	return p;
 }
 
+BTF_SET_START(dev_bound_kfunc_ids)
+#define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
+XDP_METADATA_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+BTF_SET_END(dev_bound_kfunc_ids)
+
+BTF_ID_LIST(dev_bound_kfunc_ids_unsorted)
+#define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
+XDP_METADATA_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+
+u32 bpf_dev_bound_kfunc_id(int id)
+{
+	/* dev_bound_kfunc_ids is sorted and can't be used */
+	return dev_bound_kfunc_ids_unsorted[id];
+}
+
+bool bpf_is_dev_bound_kfunc(u32 btf_id)
+{
+	return btf_id_set_contains(&dev_bound_kfunc_ids, btf_id);
+}
+
 static int __init bpf_offload_init(void)
 {
 	return rhashtable_init(&offdevs, &offdevs_params);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11e54dd8b6dd..e7b2d0a6d7c6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2721,7 +2721,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 		}
 	}
 
-	if (bpf_dev_bound_kfunc_id(func_id)) {
+	if (bpf_is_dev_bound_kfunc(func_id)) {
 		err = bpf_dev_bound_kfunc_check(&env->log, prog_aux);
 		if (err)
 			return err;
@@ -17923,7 +17923,7 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 	void *xdp_kfunc;
 	bool is_rdonly;
 
-	if (bpf_dev_bound_kfunc_id(func_id)) {
+	if (bpf_is_dev_bound_kfunc(func_id)) {
 		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
 		if (xdp_kfunc) {
 			*addr = (unsigned long)xdp_kfunc;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 41e5ca8643ec..819767697370 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -741,9 +741,9 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
+#define NETDEV_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
 XDP_METADATA_KFUNC_xxx
-#undef XDP_METADATA_KFUNC
+#undef NETDEV_METADATA_KFUNC
 BTF_SET8_END(xdp_metadata_kfunc_ids)
 
 static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
@@ -751,22 +751,6 @@ static const struct btf_kfunc_id_set xdp_metadata_kfunc_set = {
 	.set   = &xdp_metadata_kfunc_ids,
 };
 
-BTF_ID_LIST(xdp_metadata_kfunc_ids_unsorted)
-#define XDP_METADATA_KFUNC(name, str) BTF_ID(func, str)
-XDP_METADATA_KFUNC_xxx
-#undef XDP_METADATA_KFUNC
-
-u32 bpf_xdp_metadata_kfunc_id(int id)
-{
-	/* xdp_metadata_kfunc_ids is sorted and can't be used */
-	return xdp_metadata_kfunc_ids_unsorted[id];
-}
-
-bool bpf_dev_bound_kfunc_id(u32 btf_id)
-{
-	return btf_id_set8_contains(&xdp_metadata_kfunc_ids, btf_id);
-}
-
 static int __init xdp_metadata_init(void)
 {
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
-- 
2.41.0.255.g8b1d071c50-goog


