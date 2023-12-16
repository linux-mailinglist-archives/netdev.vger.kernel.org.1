Return-Path: <netdev+bounces-58225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D20815902
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7111C21699
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD01A2C681;
	Sat, 16 Dec 2023 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="j7QU/s1F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072EB18EA9
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-334af3b3ddfso1189014f8f.3
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 04:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702729815; x=1703334615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbTUWeD75Qq/q03fxzPY6vzlSe3qJgsO2ERBgJjGn4U=;
        b=j7QU/s1F13BYAQ/3tigXxdavbt4/Tli6QnfXK44R5LJ1n5GlrUv45WysxH3TcNFLcb
         KFLde47JdPHabT0xWVBdR8D6J5O/DRr/d10RM/wbEj0PYjgWL9HTVgvsz3fOwdBS5xTQ
         7r68nrE6Xhw5KQBpUIQdRCan3oQ7+hisYsYO4Br2ypmxlfqEP/LvevbSgGqJPJHVQi9Q
         hIy4TrZ79fz8d64iSou7O3N4prB0C24jOIJ3Adz0xLhKQMMmxpN22gLQkUvdhtsnQFj7
         4o9ilWx+r8oFc0zfI4aQmfH9Tkiv/O3e9Sz7F4r5qQx33kNiUoMf7eMHIzKWN9v0YpP9
         0iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702729815; x=1703334615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbTUWeD75Qq/q03fxzPY6vzlSe3qJgsO2ERBgJjGn4U=;
        b=KZwlPz8Y/yNMapdSNmtobVq44LwsnD7+849dN2H+cmZN1qd4efCkqt6lv60cADbXXP
         YtpdrAOpdrEUWnRtR34yvwxdKhwA9+TapIGz8V7kVJWoWZskdpRLrj1R1mvChQcGHjPX
         Q8Yb+Lsylsam8w6lowOHgfbnlYQgniPXZgiLPNDAeBFdDx1DcfQUxNDspQz04y5Go8i6
         lcyAgmBM3OT7bCYZ8NglAg1YI/EEMiZezFWk8Z/wA4VXGWXlvPa5dnPuvnFj1yyhjRBy
         XYp5uXkgTp+9NaPDxW0A2mh74h2ZMwdzMbrGG3QRHwJ7u8/+llqQRB6aiE5TW0MKe+FV
         qk3g==
X-Gm-Message-State: AOJu0Yy3SL4PoDmGRPjl0fquGjdpAlCx9qwoymXC9gGYNZFtiKcO+tad
	71e1PVH+CPQu/SzdWNDq06orBt3geHeiUm4XoIQ=
X-Google-Smtp-Source: AGHT+IFWTe45MqdZjukyoFjoaldo1SC5XH5Rl7j0Al77R+XVJjiGc7iMjEwRlngZ2v5hBIij0Bb47A==
X-Received: by 2002:a5d:4603:0:b0:336:4b33:a919 with SMTP id t3-20020a5d4603000000b003364b33a919mr1841156wrq.50.1702729815278;
        Sat, 16 Dec 2023 04:30:15 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id et14-20020a056402378e00b005527cfaa2dfsm2291644edb.49.2023.12.16.04.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:30:14 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next v8 7/9] genetlink: introduce helpers to do filtered multicast
Date: Sat, 16 Dec 2023 13:29:59 +0100
Message-ID: <20231216123001.1293639-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216123001.1293639-1-jiri@resnulli.us>
References: <20231216123001.1293639-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently it is possible for netlink kernel user to pass custom
filter function to broadcast send function netlink_broadcast_filtered().
However, this is not exposed to multicast send and to generic
netlink users.

Extend the api and introduce a netlink helper nlmsg_multicast_filtered()
and a generic netlink helper genlmsg_multicast_netns_filtered()
to allow generic netlink families to specify filter function
while sending multicast messages.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- used netlink_filter_fn introduce by the previous patch
- added return comments to silence scripts/kernel-doc warnings
---
 include/net/genetlink.h | 35 +++++++++++++++++++++++++++++++----
 include/net/netlink.h   | 31 +++++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 6bc37f392a9a..85c63d4f16dd 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -448,6 +448,35 @@ static inline void genlmsg_cancel(struct sk_buff *skb, void *hdr)
 		nlmsg_cancel(skb, hdr - GENL_HDRLEN - NLMSG_HDRLEN);
 }
 
+/**
+ * genlmsg_multicast_netns_filtered - multicast a netlink message
+ *				      to a specific netns with filter
+ *				      function
+ * @family: the generic netlink family
+ * @net: the net namespace
+ * @skb: netlink message as socket buffer
+ * @portid: own netlink portid to avoid sending to yourself
+ * @group: offset of multicast group in groups array
+ * @flags: allocation flags
+ * @filter: filter function
+ * @filter_data: filter function private data
+ *
+ * Return: 0 on success, negative error code for failure.
+ */
+static inline int
+genlmsg_multicast_netns_filtered(const struct genl_family *family,
+				 struct net *net, struct sk_buff *skb,
+				 u32 portid, unsigned int group, gfp_t flags,
+				 netlink_filter_fn filter,
+				 void *filter_data)
+{
+	if (WARN_ON_ONCE(group >= family->n_mcgrps))
+		return -EINVAL;
+	group = family->mcgrp_offset + group;
+	return nlmsg_multicast_filtered(net->genl_sock, skb, portid, group,
+					flags, filter, filter_data);
+}
+
 /**
  * genlmsg_multicast_netns - multicast a netlink message to a specific netns
  * @family: the generic netlink family
@@ -461,10 +490,8 @@ static inline int genlmsg_multicast_netns(const struct genl_family *family,
 					  struct net *net, struct sk_buff *skb,
 					  u32 portid, unsigned int group, gfp_t flags)
 {
-	if (WARN_ON_ONCE(group >= family->n_mcgrps))
-		return -EINVAL;
-	group = family->mcgrp_offset + group;
-	return nlmsg_multicast(net->genl_sock, skb, portid, group, flags);
+	return genlmsg_multicast_netns_filtered(family, net, skb, portid,
+						group, flags, NULL, NULL);
 }
 
 /**
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 28039e57070a..c19ff921b661 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1087,27 +1087,50 @@ static inline void nlmsg_free(struct sk_buff *skb)
 }
 
 /**
- * nlmsg_multicast - multicast a netlink message
+ * nlmsg_multicast_filtered - multicast a netlink message with filter function
  * @sk: netlink socket to spread messages to
  * @skb: netlink message as socket buffer
  * @portid: own netlink portid to avoid sending to yourself
  * @group: multicast group id
  * @flags: allocation flags
+ * @filter: filter function
+ * @filter_data: filter function private data
+ *
+ * Return: 0 on success, negative error code for failure.
  */
-static inline int nlmsg_multicast(struct sock *sk, struct sk_buff *skb,
-				  u32 portid, unsigned int group, gfp_t flags)
+static inline int nlmsg_multicast_filtered(struct sock *sk, struct sk_buff *skb,
+					   u32 portid, unsigned int group,
+					   gfp_t flags,
+					   netlink_filter_fn filter,
+					   void *filter_data)
 {
 	int err;
 
 	NETLINK_CB(skb).dst_group = group;
 
-	err = netlink_broadcast(sk, skb, portid, group, flags);
+	err = netlink_broadcast_filtered(sk, skb, portid, group, flags,
+					 filter, filter_data);
 	if (err > 0)
 		err = 0;
 
 	return err;
 }
 
+/**
+ * nlmsg_multicast - multicast a netlink message
+ * @sk: netlink socket to spread messages to
+ * @skb: netlink message as socket buffer
+ * @portid: own netlink portid to avoid sending to yourself
+ * @group: multicast group id
+ * @flags: allocation flags
+ */
+static inline int nlmsg_multicast(struct sock *sk, struct sk_buff *skb,
+				  u32 portid, unsigned int group, gfp_t flags)
+{
+	return nlmsg_multicast_filtered(sk, skb, portid, group, flags,
+					NULL, NULL);
+}
+
 /**
  * nlmsg_unicast - unicast a netlink message
  * @sk: netlink socket to spread message to
-- 
2.43.0


