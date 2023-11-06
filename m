Return-Path: <netdev+bounces-46126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6D7E18C2
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 03:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F841C20AF4
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499A71391;
	Mon,  6 Nov 2023 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pm9R3xL6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D91843
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 02:44:28 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E3EEE
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 18:44:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03ef6fc30so4642777276.0
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 18:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699238665; x=1699843465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=myyimfrqgp1IZWG/ujCwmnkNglmXYrRvMz92cYVRHqQ=;
        b=Pm9R3xL6bn9UQe2wumfaDV9vJnA5rdu7IRShE1NvhDHl/1ZeblbkO6Z+hOfYIoJ/PN
         IV+7AjyubuXQOJ7ZOVo8SnCEFRppgWULsAd8QtEhI8bdd233GmwL4U3jcFX0A30H+KUF
         7Px/ZGnSNXxdiJPTHeGa3Wh8jHPl4IL6gCRBwbgcmeKQfg+9kiNzbkIoNrx/yAeQGdrF
         7DTryPhfGvrAUua8viYVq8L/rrLWH+TILrvs3LzKKwSyRsfTEAD/ZWA7jJgg7302Stjs
         lTRNsftAFdpxIuaXKnVKvmeMHVMHz8M+x3Mh9I2jTzMxvkErQaeHRNs7dLvBp6ujiJjG
         00nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699238665; x=1699843465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myyimfrqgp1IZWG/ujCwmnkNglmXYrRvMz92cYVRHqQ=;
        b=WONkn3+31MdY64TKL/d9LSY20CAYHhggh0vK5oKByu11hY2IBwwfcbQpiGm81yu+aP
         Z8ytFz+Hej8q9sER+g0Xxz8dFkpJRKuVgfRVQu038rESZOaXIFJTtznRW0XKK5ZUReEB
         xQZq4OUu2J/NCD8W1GkA/iEeWcSCoSVLO+wx4oH3/xZN6zJRCjWSUg0o45p4aIGCKXvf
         hVbBSABrV93LiqBpjMYZzWNqL1bQ2CO6ufQ1XXptR76yt2dEQ9PnP1su1+jXAlln7M3w
         uCOCEvFg4kaeEJPahS1rywXSiRVUWxMcOQGcarZPTygYU/am28CcFGe6a73XW7gM+0yi
         XWjA==
X-Gm-Message-State: AOJu0YxvMtj9zXipY9i3/0ISTG/hAGyApCzGrKtZXzAn/9zk799brZh1
	nfsEyehlP4HlBhxBXn6xGL6peZtjI5jVIIjgIIasY6r3p+XqEvck4oJlCwqpkp2ALhiri2OO3nF
	66VNp+3wYvPOkMBlU08ua0s1f3E1NLRTRC7h3MH+qDVG2QPMrFcDPdtrShizVbV1ZlWxM2a5cnV
	8=
X-Google-Smtp-Source: AGHT+IGWp48Z8KmELXQxvxVV5DLFXiq5qCBokj5aX+KpMHAL69lZpLvJunFDekA59GS1FqFlT9Q2Vt+r+UX/F4+7uQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:35de:fff:97b7:db3e])
 (user=almasrymina job=sendgmr) by 2002:a25:db11:0:b0:d9a:47ea:69a5 with SMTP
 id g17-20020a25db11000000b00d9a47ea69a5mr527645ybf.1.1699238664884; Sun, 05
 Nov 2023 18:44:24 -0800 (PST)
Date: Sun,  5 Nov 2023 18:44:02 -0800
In-Reply-To: <20231106024413.2801438-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106024413.2801438-4-almasrymina@google.com>
Subject: [RFC PATCH v3 03/12] net: netdev netlink api to bind dma-buf to a net device
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"

API takes the dma-buf fd as input, and binds it to the netdevice. The
user can specify the rx queues to bind the dma-buf to.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v3:
- Support binding multiple rx rx-queues

---
 Documentation/netlink/specs/netdev.yaml | 28 +++++++++++++++
 include/uapi/linux/netdev.h             | 10 ++++++
 net/core/netdev-genl-gen.c              | 14 ++++++++
 net/core/netdev-genl-gen.h              |  1 +
 net/core/netdev-genl.c                  |  6 ++++
 tools/include/uapi/linux/netdev.h       | 10 ++++++
 tools/net/ynl/generated/netdev-user.c   | 42 ++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h   | 47 +++++++++++++++++++++++++
 8 files changed, 158 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 14511b13f305..2141c5f5c33e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -86,6 +86,24 @@ attribute-sets:
              See Documentation/networking/xdp-rx-metadata.rst for more details.
         type: u64
         enum: xdp-rx-metadata
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
+        name: queues
+        doc: receive queues to bind the dma-buf to.
+        type: u32
+        multi-attr: true
+      -
+        name: dmabuf-fd
+        doc: dmabuf file descriptor to bind.
+        type: u32
 
 operations:
   list:
@@ -120,6 +138,16 @@ operations:
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
+            - queues
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 2943a151d4f1..2cd367c498c7 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -64,11 +64,21 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_BIND_DMABUF_IFINDEX = 1,
+	NETDEV_A_BIND_DMABUF_QUEUES,
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
index ea9231378aa6..58300efaf4e5 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -15,6 +15,13 @@ static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_BIND_RX - do */
+static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_BIND_DMABUF_DMABUF_FD + 1] = {
+	[NETDEV_A_BIND_DMABUF_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_BIND_DMABUF_DMABUF_FD] = { .type = NLA_U32, },
+	[NETDEV_A_BIND_DMABUF_QUEUES] = { .type = NLA_U32, },
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
index fe61f85bcf33..59d3d512d9cc 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -129,6 +129,12 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
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
index 2943a151d4f1..2cd367c498c7 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -64,11 +64,21 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_BIND_DMABUF_IFINDEX = 1,
+	NETDEV_A_BIND_DMABUF_QUEUES,
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
index b5ffe8cd1144..d5f4c6d4c2b2 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -18,6 +18,7 @@ static const char * const netdev_op_strmap[] = {
 	[NETDEV_CMD_DEV_ADD_NTF] = "dev-add-ntf",
 	[NETDEV_CMD_DEV_DEL_NTF] = "dev-del-ntf",
 	[NETDEV_CMD_DEV_CHANGE_NTF] = "dev-change-ntf",
+	[NETDEV_CMD_BIND_RX] = "bind-rx",
 };
 
 const char *netdev_op_str(int op)
@@ -72,6 +73,17 @@ struct ynl_policy_nest netdev_dev_nest = {
 	.table = netdev_dev_policy,
 };
 
+struct ynl_policy_attr netdev_bind_dmabuf_policy[NETDEV_A_BIND_DMABUF_MAX + 1] = {
+	[NETDEV_A_BIND_DMABUF_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+	[NETDEV_A_BIND_DMABUF_QUEUES] = { .name = "queues", .type = YNL_PT_U32, },
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
@@ -197,6 +209,36 @@ void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp)
 	free(rsp);
 }
 
+/* ============== NETDEV_CMD_BIND_RX ============== */
+/* NETDEV_CMD_BIND_RX - do */
+void netdev_bind_rx_req_free(struct netdev_bind_rx_req *req)
+{
+	free(req->queues);
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
+	for (unsigned int i = 0; i < req->n_queues; i++)
+		mnl_attr_put_u32(nlh, NETDEV_A_BIND_DMABUF_QUEUES, req->queues[i]);
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
index 4fafac879df3..3cf9096d733a 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -87,4 +87,51 @@ struct netdev_dev_get_ntf {
 
 void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
 
+/* ============== NETDEV_CMD_BIND_RX ============== */
+/* NETDEV_CMD_BIND_RX - do */
+struct netdev_bind_rx_req {
+	struct {
+		__u32 ifindex:1;
+		__u32 dmabuf_fd:1;
+	} _present;
+
+	__u32 ifindex;
+	__u32 dmabuf_fd;
+	unsigned int n_queues;
+	__u32 *queues;
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
+__netdev_bind_rx_req_set_queues(struct netdev_bind_rx_req *req, __u32 *queues,
+				unsigned int n_queues)
+{
+	free(req->queues);
+	req->queues = queues;
+	req->n_queues = n_queues;
+}
+
+/*
+ * Bind dmabuf to netdev
+ */
+int netdev_bind_rx(struct ynl_sock *ys, struct netdev_bind_rx_req *req);
+
 #endif /* _LINUX_NETDEV_GEN_H */
-- 
2.42.0.869.gea05f2083d-goog


