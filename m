Return-Path: <netdev+bounces-48022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC47EC4F3
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81121C20B8B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDEE28DDE;
	Wed, 15 Nov 2023 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CB455S9z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B9A2E620
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:17:43 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FE1C8
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:41 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9e62ab773f1so774330266b.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700057860; x=1700662660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kf03/GjqEv8CtzPycOicYWsSAK9DuhKN09pa9zL/eN8=;
        b=CB455S9z1zc9NcOTs8hZR6KpTbZ0AwGtmchjeFHtNNSEpq4/SItq2szTcU6Su+N6MG
         srPFRD7JQUrWh29CINIPDdCxMvirnT6TH1vzjlpxD3VSBK3FWjk2xeQBXsMETxxH+Jqa
         Ou6OjdgSNfh1x94XnsNms3ttwSOwK1+9unW7mKDwy0/CuJ3YV5RVY7J48q67KM8xbQvm
         E9AJ04LnmuaPNQwo6BhIc7J3ETXf2/3DceqR24rPBpp250LHWhzQw4D0FzedQlwWeJ4r
         HwkieejQI+QLLAn+gui2Z964XjBinMPAemywKc8wh2pMSIbICFGwWNOB1MPJqxrkjNJd
         ZDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057860; x=1700662660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kf03/GjqEv8CtzPycOicYWsSAK9DuhKN09pa9zL/eN8=;
        b=swzLKtBM+CzYPX8qRok5gPXfO6gLRxY3c/3KF21S7iO+q3goUtXmDUinOClw5C+yAg
         V/rjtKwgdaRTm3ZDhqp9DeGhb+Tq9zZV/sORkPCbM/kYwyzmF3VmC7eZcb6O+aMaazGt
         rXEkf+p4HE3YlFPEQrRoWAKZUxffccA/PdAg2n4ByZSw5Zd+Clx3zS2grQWZ+iO0XkvU
         AnwFGyyiEEbLLyOnzOROBal6tS0XPyTfY1wnMh61kB8/N95NfreqgsrlGZXGjesIRMZn
         9jPN30HWBrnBXhrBx/joleqoZdfsKiQWrqj9riwziWHZhVE/qWKPI42nKiYGAOgz1tfQ
         1ZAg==
X-Gm-Message-State: AOJu0YwJQF1fRd/2U1UwHznshm9fwS6CKD0Nt7kXLZmkO229UYIMPy5d
	sqPNJuIT4+sYG5F2DqFuyNocnAUpmClTSfU6JAA=
X-Google-Smtp-Source: AGHT+IGAZ2w5LEVX91iAp1OIRwHayqvSUpvQqtY6eiAJ6cPhNaOuybMIXpjHOyg3W1Zh80YxCRUzGA==
X-Received: by 2002:a17:906:d292:b0:9dd:f5ba:856d with SMTP id ay18-20020a170906d29200b009ddf5ba856dmr10938935ejb.62.1700057860253;
        Wed, 15 Nov 2023 06:17:40 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id kg4-20020a17090776e400b009e5e4ff01d4sm7064494ejc.129.2023.11.15.06.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:17:39 -0800 (PST)
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
	sdf@google.com
Subject: [patch net-next 6/8] genetlink: introduce helpers to do filtered multicast
Date: Wed, 15 Nov 2023 15:17:22 +0100
Message-ID: <20231115141724.411507-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115141724.411507-1-jiri@resnulli.us>
References: <20231115141724.411507-1-jiri@resnulli.us>
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
 include/net/genetlink.h | 35 +++++++++++++++++++++++++++++++----
 include/net/netlink.h   | 31 +++++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index e18a4c0d69ee..ec93e73fd8f8 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -435,6 +435,35 @@ static inline void genlmsg_cancel(struct sk_buff *skb, void *hdr)
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
+ */
+static inline int
+genlmsg_multicast_netns_filtered(const struct genl_family *family,
+				 struct net *net, struct sk_buff *skb,
+				 u32 portid, unsigned int group, gfp_t flags,
+				 int (*filter)(struct sock *dsk,
+					       struct sk_buff *skb,
+					       void *data),
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
@@ -448,10 +477,8 @@ static inline int genlmsg_multicast_netns(const struct genl_family *family,
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
index 83bdf787aeee..60f510e33964 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1073,27 +1073,50 @@ static inline void nlmsg_free(struct sk_buff *skb)
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
  */
-static inline int nlmsg_multicast(struct sock *sk, struct sk_buff *skb,
-				  u32 portid, unsigned int group, gfp_t flags)
+static inline int nlmsg_multicast_filtered(struct sock *sk, struct sk_buff *skb,
+					   u32 portid, unsigned int group,
+					   gfp_t flags,
+					   int (*filter)(struct sock *dsk,
+							 struct sk_buff *skb,
+							 void *data),
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
2.41.0


