Return-Path: <netdev+bounces-48443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BF47EE57C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D4E1F260D1
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D54122C;
	Thu, 16 Nov 2023 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NkGsDill"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72342D4B
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:36 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9c3aec5f326so441141566b.1
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700153315; x=1700758115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZINPLM47jewxX8k6AZrQ3FkxNVby2E3liigCGzybfzQ=;
        b=NkGsDillaLjvbCWTmCbwkeqx/+OvxVExqpCEf1ZurMP9WBMqsXj6oa2k0Sp92r9x64
         qmf6THs+3iVvhrsfGs55hyKuPB7WgPdTp9v6L0/BFFPPuSEoEeeMOoifuuRtHYgDQNpk
         nk6k1udf6msVR1xX424qpdW7pAHBlv2jEZFS1zowjW0PCV6U20nkQx4cxjQUUUmFzVsW
         ajTZRUKuu8FYErgeui/HBc0Vhiyvs1RuNjd7FNTa45Ik/9ZU2MALr9NkK9QkQCMSLKaX
         +uTrWTDSL/6KSJKK4qqPtb6v7nAj7Mwh3k203XjCjJ6tGyNYV48CCtshyqUjX9ETomCV
         vquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153315; x=1700758115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZINPLM47jewxX8k6AZrQ3FkxNVby2E3liigCGzybfzQ=;
        b=YOAigHHHMOODFp+WACaF38UkxT2j85+W6kfGH7VRDTc0G7a2WP31Lbtx68Tqqaoa8F
         7eK3AJQdwZRz4HpAqTl4FynMgNJuFrqmRMGWuQtuE0KWy0/WSQ1Sv2xn12l9o9Al3+fE
         DifRCW9lGLOUIQH95eDFkk79IB6sBxlOxlODZpdOnU2BbrkIfLcDSuws76Ji7/RK86qS
         3RoiNuMdFj8KRpy5P4yyW+onkr9hmhTFh46zgTt4k4h/OdzAUpzv/HLJN1860Atzul5O
         GHyyAJMOgYDHJaeADPDn+n8Qa3LUTr2yC1+2/8S9euJzMqKDHOWmaYU+SSHidiDl0C5g
         Mr5A==
X-Gm-Message-State: AOJu0YxUJBzXyfJ7uj/EPtJwg5SsBSoJAMMlNyr7ZuMBI2o8hFw9D+x5
	RCn9aVMq0vA+/Mtmx30NMPh/9dTgSxYKg9MyXtc=
X-Google-Smtp-Source: AGHT+IG1swJGR8h/cneIYl81IXBXGVTsbo/CqaVFRaLZsbOJTRc5g/E0jXa+fpGaI2UzoVkZK2scjA==
X-Received: by 2002:a17:906:f1c6:b0:9a2:295a:9bbc with SMTP id gx6-20020a170906f1c600b009a2295a9bbcmr2113713ejb.37.1700153314761;
        Thu, 16 Nov 2023 08:48:34 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b13-20020a170906038d00b009bd9ac83a9fsm8639131eja.152.2023.11.16.08.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:48:34 -0800 (PST)
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
Subject: [patch net-next v2 7/9] genetlink: introduce helpers to do filtered multicast
Date: Thu, 16 Nov 2023 17:48:19 +0100
Message-ID: <20231116164822.427485-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116164822.427485-1-jiri@resnulli.us>
References: <20231116164822.427485-1-jiri@resnulli.us>
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
index e18a4c0d69ee..246912033e77 100644
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
index 83bdf787aeee..f5423de36c21 100644
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
2.41.0


