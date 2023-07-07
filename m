Return-Path: <netdev+bounces-16118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5774574B715
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1209F2818BE
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9A31773B;
	Fri,  7 Jul 2023 19:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317A1772D
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:30:25 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE32D52
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:30:12 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-262ffe98bcfso2806691a91.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758211; x=1691350211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1MKED6r0fOSDG2OitoAAOgEtvC/DPkEhJBtkp+m4JxY=;
        b=EGjzvxZkZ6WZcSrwuUBc43q7K4kA6DDHwdu+a/yLWFrtPUqsj66GtaoQ9oWKouBJ1R
         FSjRmA8n5sUv5WiLmzSMYclPd6wC1KDDR2muZOffUzOZWJQ08xr7mwd9G5gwQjYU+3gD
         xuiE3OZJOPsIjTOzWPpaHF5B5azOKBoalOANnvsxwL9EtaL4yNOKiLDk+EVLCn/h+q0X
         TXIsyg9bl6p5Gur2Y8u2nNQ14YxR4hCZnZnFL2ANEk73e+oOerLcq1ijgSjdz3NIwICQ
         S0+tG+6MllI3IrKtH9nnAZWVPO064v+F4URTsctXDmsdL8Q6FSuwmFBEbddi/fLmtivY
         pcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758211; x=1691350211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1MKED6r0fOSDG2OitoAAOgEtvC/DPkEhJBtkp+m4JxY=;
        b=YIo35Qj9lMHKE8WOqFvdXSFr3SXlbF7AKVzl/4a917BfiYI++16+cAz3TglsgGNzDk
         MJtaCbRSJTzlJFK6HbRkQElTKLz3sJxb+XdI7VheI47UjWIGOgz6MSJnlf02doilulbE
         9f8wBep8ObUXEhI+cAZ/kJ8EKapJJmE8EX7YVZy+Xpil829KvZdCGfrFw0QNV9xMikhh
         4ONg2aXLDWMDhJJiyjOjK9nfvQbsL2BUxVI/MPbAk+T0IbWwMX+6IyXENuEbNTr6GcsV
         1Zh2FrDynDyeLSiwRI+pJUSGhjGWniPpjm0SImkfEEmdVqi8MdqP7Y6A/3yckqoTEuqM
         D1wA==
X-Gm-Message-State: ABy/qLY0+UuozEjDQ1Lq8kBHwK4TjFXye2t/lN8Qcjo9LoDYmYvjXSdU
	b3KfpLuKpFt43/hC1qXHPLiHIiE=
X-Google-Smtp-Source: APBJJlGIZBvJPkKFv/Q5I+xIa3tblE8GIDGj+rcewIcapBo9qV5OybfQAFp23jqwnP4fXgxyIaOajVk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:f481:b0:263:4dca:ae63 with SMTP id
 bx1-20020a17090af48100b002634dcaae63mr4830732pjb.6.1688758211652; Fri, 07 Jul
 2023 12:30:11 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:29:54 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-3-sdf@google.com>
Subject: [RFC bpf-next v3 02/14] bpf: Make it easier to add new metadata kfunc
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

Instead of having hand-crafted code in bpf_dev_bound_resolve_kfunc,
move kfunc <> xmo handler relationship into XDP_METADATA_KFUNC_xxx.
This way, any time new kfunc is added, we don't have to touch
bpf_dev_bound_resolve_kfunc.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/net/offload.h |  8 +++++---
 kernel/bpf/offload.c  | 13 +++++++------
 net/core/xdp.c        |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/net/offload.h b/include/net/offload.h
index 264a35881473..de0fac38a95b 100644
--- a/include/net/offload.h
+++ b/include/net/offload.h
@@ -6,12 +6,14 @@
 
 #define XDP_METADATA_KFUNC_xxx	\
 	NETDEV_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_TIMESTAMP, \
-			      bpf_xdp_metadata_rx_timestamp) \
+			      bpf_xdp_metadata_rx_timestamp, \
+			      xmo_rx_timestamp) \
 	NETDEV_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
-			      bpf_xdp_metadata_rx_hash)
+			      bpf_xdp_metadata_rx_hash, \
+			      xmo_rx_hash)
 
 enum {
-#define NETDEV_METADATA_KFUNC(name, _) name,
+#define NETDEV_METADATA_KFUNC(name, _, __) name,
 XDP_METADATA_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 MAX_NETDEV_METADATA_KFUNC,
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 235d81f7e0ed..cec63c76dce5 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -844,10 +844,11 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 	if (!ops)
 		goto out;
 
-	if (func_id == bpf_dev_bound_kfunc_id(XDP_METADATA_KFUNC_RX_TIMESTAMP))
-		p = ops->xmo_rx_timestamp;
-	else if (func_id == bpf_dev_bound_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
-		p = ops->xmo_rx_hash;
+#define NETDEV_METADATA_KFUNC(name, _, xmo) \
+	if (func_id == bpf_dev_bound_kfunc_id(name)) p = ops->xmo;
+	XDP_METADATA_KFUNC_xxx
+#undef NETDEV_METADATA_KFUNC
+
 out:
 	up_read(&bpf_devs_lock);
 
@@ -855,13 +856,13 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 }
 
 BTF_SET_START(dev_bound_kfunc_ids)
-#define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
+#define NETDEV_METADATA_KFUNC(name, str, _) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 BTF_SET_END(dev_bound_kfunc_ids)
 
 BTF_ID_LIST(dev_bound_kfunc_ids_unsorted)
-#define NETDEV_METADATA_KFUNC(name, str) BTF_ID(func, str)
+#define NETDEV_METADATA_KFUNC(name, str, _) BTF_ID(func, str)
 XDP_METADATA_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 819767697370..c4be4367f2dd 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-#define NETDEV_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
+#define NETDEV_METADATA_KFUNC(_, name, __) BTF_ID_FLAGS(func, name, 0)
 XDP_METADATA_KFUNC_xxx
 #undef NETDEV_METADATA_KFUNC
 BTF_SET8_END(xdp_metadata_kfunc_ids)
-- 
2.41.0.255.g8b1d071c50-goog


