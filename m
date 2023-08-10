Return-Path: <netdev+bounces-26114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F2A776DBE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 03:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325E21C213F5
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 01:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD0634;
	Thu, 10 Aug 2023 01:58:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F87EF
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:58:03 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFF110DA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:58:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d5869d96657so477938276.1
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 18:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691632682; x=1692237482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GDnXmpYx8eP78AYOg4pkJM7yEm1cliNyt0IkWPt0PrI=;
        b=LzYZfGCg//bPASt7D6BWde7K6bp5L+5MhP1tCdXjworRSSLBu7xjr6LKKX8Cjw5xrQ
         fEf7GfqhFc6l80Z76x9vcJGRpaS9LDC+zhe9wAEPuGy8OPgCEE97tXGFRhdAXbu+yMiq
         8tOx/o2b4A+x0h4eczD17rS5D/34T+0UjjKE5eOLAtPj2hLsjd67wEHyvBVjEQYqPIA6
         B0RRZY3QEQDRF1LY2gGiZe9eBrWcgU1jCAmIq4zX24mhfAxEhyAXaY4k0ugzIXXjIcbG
         JE082j7UAJP2Pavbxv+YGs1MjTpowuU+IeBYsKGgSQfksMSpbL3BJrBD70B8WWtD+O4x
         s5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691632682; x=1692237482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDnXmpYx8eP78AYOg4pkJM7yEm1cliNyt0IkWPt0PrI=;
        b=NlPyOKBQr1TKU5o5/Myrx9EIC7IpYPPTLP5aCxVmfKuq5RJy8JL29hT/dGeEmuxY33
         6GRmoPLX7yVS6V9aaTqwD32GGLU28Qruxw9JmvMg3pCwqoQto/UkqmMZmRM/GFveZMcE
         Gqk1+2uXJ3cMPxL+wiuweALL8QHj+i9DqxM6SUc9CRU1AAq5afdtY+90UOZ3QjCXpFkE
         HkMlo8xcFmVLBYXZv8T/jWxmxlUv51b5IghuzdclYoPbFjpNM2NcAUwc0bky6us4XEed
         2OR6cm8wIo/L15pFOSFHGsXIWam0jEnFrFn1BsZiBwHlHSh6q/4jWvHNylGaDhvxrEzb
         Z2Zg==
X-Gm-Message-State: AOJu0Yzlc5wHTsC3XjlTL7t4d+y4bucPRgd96b3FOx6vihZyROvdSjYl
	+kh/w7tEh+3HIQqkYgsiMUNq4eb8mwia1b/B6Q8C9if9fE3abBcwFGhSAke1gNXNbsxMBlkFApw
	Wm7V0DKjzQkZUJ8iTltltH3Y54XgVk4lNGRZt9+0286zAvKsrhDxrZlBTt1QuslnGy0ApdJtqwb
	8=
X-Google-Smtp-Source: AGHT+IFdKYYGNPKm4yIJ3i7lDukNoxcqgTIDgeuPYnSb7xY53ojSb6n324Dq4HxTw3OmxqB5uOVGQp26su1wnD96Rw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:73ad:9ed5:e067:2b9b])
 (user=almasrymina job=sendgmr) by 2002:a25:d711:0:b0:d4a:7656:a680 with SMTP
 id o17-20020a25d711000000b00d4a7656a680mr18846ybg.2.1691632681568; Wed, 09
 Aug 2023 18:58:01 -0700 (PDT)
Date: Wed,  9 Aug 2023 18:57:37 -0700
In-Reply-To: <20230810015751.3297321-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810015751.3297321-1-almasrymina@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810015751.3297321-2-almasrymina@google.com>
Subject: [RFC PATCH v2 01/11] net: add netdev netlink api to bind dma-buf to a
 net device
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Hari Ramakrishnan <rharix@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Andy Lutomirski <luto@kernel.org>, stephen@networkplumber.org, sdf@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

API takes the dma-buf fd as input, and binds it to the netdevice. The
user can specify the rx queue to bind the dma-buf to. The user should be
able to bind the same dma-buf to multiple queues, but that is left as
a (minor) TODO in this iteration.

Suggested-by: Stanislav Fomichev <sdf@google.com>

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 Documentation/netlink/specs/netdev.yaml | 27 +++++++++++++++
 include/uapi/linux/netdev.h             | 10 ++++++
 net/core/netdev-genl-gen.c              | 14 ++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  6 ++++
 tools/include/uapi/linux/netdev.h       | 10 ++++++
 tools/net/ynl/generated/netdev-user.c   | 41 ++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h   | 46 +++++++++++++++++++++++++
 8 files changed, 155 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e41015310a6e..907a45260e95 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -68,6 +68,23 @@ attribute-sets:
         type: u32
         checks:
           min: 1
+  -
+    name: bind-dmabuf
+    attributes:
+      -
+        name: ifindex
+        doc: netdev ifindex to bind the dma-buf to.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: queue-idx
+        doc: receive queue index to bind the dma-buf to.
+        type: u32
+      -
+        name: dmabuf-fd
+        doc: dmabuf file descriptor to bind.
+        type: u32
 
 operations:
   list:
@@ -100,6 +117,16 @@ operations:
       doc: Notification about device configuration being changed.
       notify: dev-get
       mcgrp: mgmt
+    -
+      name: bind-rx
+      doc: Bind dmabuf to netdev
+      attribute-set: bind-dmabuf
+      do:
+        request:
+          attributes:
+            - ifindex
+            - dmabuf-fd
+            - queue-idx
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index bf71698a1e82..242b2b65161c 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -47,11 +47,21 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_BIND_DMABUF_IFINDEX = 1,
+	NETDEV_A_BIND_DMABUF_QUEUE_IDX,
+	NETDEV_A_BIND_DMABUF_DMABUF_FD,
+
+	__NETDEV_A_BIND_DMABUF_MAX,
+	NETDEV_A_BIND_DMABUF_MAX = (__NETDEV_A_BIND_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_BIND_RX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index ea9231378aa6..2e34ad5cccfa 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -15,6 +15,13 @@ static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_BIND_RX - do */
+static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_BIND_DMABUF_DMABUF_FD + 1] = {
+	[NETDEV_A_BIND_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_BIND_DMABUF_DMABUF_FD] = { .type = NLA_U32, },
+	[NETDEV_A_BIND_DMABUF_QUEUE_IDX] = { .type = NLA_U32, },
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -29,6 +36,13 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.dumpit	= netdev_nl_dev_get_dumpit,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_BIND_RX,
+		.doit		= netdev_nl_bind_rx_doit,
+		.policy		= netdev_bind_rx_nl_policy,
+		.maxattr	= NETDEV_A_BIND_DMABUF_DMABUF_FD,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 7b370c073e7d..5aaeb435ec08 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -13,6 +13,7 @@
 
 int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 65ef4867fc49..bf7324dd6c36 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -141,6 +141,12 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+/* Stub */
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return 0;
+}
+
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
 				       unsigned long event, void *ptr)
 {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index bf71698a1e82..242b2b65161c 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -47,11 +47,21 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_BIND_DMABUF_IFINDEX = 1,
+	NETDEV_A_BIND_DMABUF_QUEUE_IDX,
+	NETDEV_A_BIND_DMABUF_DMABUF_FD,
+
+	__NETDEV_A_BIND_DMABUF_MAX,
+	NETDEV_A_BIND_DMABUF_MAX = (__NETDEV_A_BIND_DMABUF_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_BIND_RX,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 4eb8aefef0cd..2716e63820d2 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -18,6 +18,7 @@ static const char * const netdev_op_strmap[] = {
 	[NETDEV_CMD_DEV_ADD_NTF] = "dev-add-ntf",
 	[NETDEV_CMD_DEV_DEL_NTF] = "dev-del-ntf",
 	[NETDEV_CMD_DEV_CHANGE_NTF] = "dev-change-ntf",
+	[NETDEV_CMD_BIND_RX] = "bind-rx",
 };
 
 const char *netdev_op_str(int op)
@@ -57,6 +58,17 @@ struct ynl_policy_nest netdev_dev_nest = {
 	.table = netdev_dev_policy,
 };
 
+struct ynl_policy_attr netdev_bind_dmabuf_policy[NETDEV_A_BIND_DMABUF_MAX + 1] = {
+	[NETDEV_A_BIND_DMABUF_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+	[NETDEV_A_BIND_DMABUF_QUEUE_IDX] = { .name = "queue-idx", .type = YNL_PT_U32, },
+	[NETDEV_A_BIND_DMABUF_DMABUF_FD] = { .name = "dmabuf-fd", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest netdev_bind_dmabuf_nest = {
+	.max_attr = NETDEV_A_BIND_DMABUF_MAX,
+	.table = netdev_bind_dmabuf_policy,
+};
+
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
 /* NETDEV_CMD_DEV_GET - do */
@@ -172,6 +184,35 @@ void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp)
 	free(rsp);
 }
 
+/* ============== NETDEV_CMD_BIND_RX ============== */
+/* NETDEV_CMD_BIND_RX - do */
+void netdev_bind_rx_req_free(struct netdev_bind_rx_req *req)
+{
+	free(req);
+}
+
+int netdev_bind_rx(struct ynl_sock *ys, struct netdev_bind_rx_req *req)
+{
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NETDEV_CMD_BIND_RX, 1);
+	ys->req_policy = &netdev_bind_dmabuf_nest;
+
+	if (req->_present.ifindex)
+		mnl_attr_put_u32(nlh, NETDEV_A_BIND_DMABUF_IFINDEX, req->ifindex);
+	if (req->_present.dmabuf_fd)
+		mnl_attr_put_u32(nlh, NETDEV_A_BIND_DMABUF_DMABUF_FD, req->dmabuf_fd);
+	if (req->_present.queue_idx)
+		mnl_attr_put_u32(nlh, NETDEV_A_BIND_DMABUF_QUEUE_IDX, req->queue_idx);
+
+	err = ynl_exec(ys, nlh, NULL);
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
 static const struct ynl_ntf_info netdev_ntf_info[] =  {
 	[NETDEV_CMD_DEV_ADD_NTF] =  {
 		.alloc_sz	= sizeof(struct netdev_dev_get_ntf),
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 5554dc69bb9c..74a43bb53627 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -82,4 +82,50 @@ struct netdev_dev_get_ntf {
 
 void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
 
+/* ============== NETDEV_CMD_BIND_RX ============== */
+/* NETDEV_CMD_BIND_RX - do */
+struct netdev_bind_rx_req {
+	struct {
+		__u32 ifindex:1;
+		__u32 dmabuf_fd:1;
+		__u32 queue_idx:1;
+	} _present;
+
+	__u32 ifindex;
+	__u32 dmabuf_fd;
+	__u32 queue_idx;
+};
+
+static inline struct netdev_bind_rx_req *netdev_bind_rx_req_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_bind_rx_req));
+}
+void netdev_bind_rx_req_free(struct netdev_bind_rx_req *req);
+
+static inline void
+netdev_bind_rx_req_set_ifindex(struct netdev_bind_rx_req *req, __u32 ifindex)
+{
+	req->_present.ifindex = 1;
+	req->ifindex = ifindex;
+}
+static inline void
+netdev_bind_rx_req_set_dmabuf_fd(struct netdev_bind_rx_req *req,
+				 __u32 dmabuf_fd)
+{
+	req->_present.dmabuf_fd = 1;
+	req->dmabuf_fd = dmabuf_fd;
+}
+static inline void
+netdev_bind_rx_req_set_queue_idx(struct netdev_bind_rx_req *req,
+				 __u32 queue_idx)
+{
+	req->_present.queue_idx = 1;
+	req->queue_idx = queue_idx;
+}
+
+/*
+ * Bind dmabuf to netdev
+ */
+int netdev_bind_rx(struct ynl_sock *ys, struct netdev_bind_rx_req *req);
+
 #endif /* _LINUX_NETDEV_GEN_H */
-- 
2.41.0.640.ga95def55d0-goog


