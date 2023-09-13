Return-Path: <netdev+bounces-33456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904C79E090
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069BA2814CD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991CF182A3;
	Wed, 13 Sep 2023 07:12:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E59418AF2
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:12:56 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93771728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401187f8071so3679275e9.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589174; x=1695193974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASAR/arMUmymIcDXlTOqKsCopHPCwfPkt1/CsXfCTRU=;
        b=J9hIBtQAE2PvFGfWc7Ch0n8sHgu1Yu4rjjej/nYqowc2JLmuHUhNRHLmk30VG30gy5
         VhKuDBZoru45XWkl8VrfTXSfJMqFZ1IGfMt8Q68HFTGH4mS42B5Ze3OwfhIimKxVchQ8
         bbRlVRIt+KkyPnb7ApiOCE4l4WWAie0DqT0znahfHCYv+dwF4vsKCdYAxzMFBId77kG2
         Li17+WHCOAGsEJSBVFc4YTZA5kbUAXZVn7+PH85zvyPvzilD7+4PWoZb2dwvT49KvsUE
         8ZfRe8+2NeLvgW4JNSaSWvxfTzEcPsfoNHbs88ReJtZMi4A2bE9E41CSTXLkwyYIazi9
         T02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589174; x=1695193974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASAR/arMUmymIcDXlTOqKsCopHPCwfPkt1/CsXfCTRU=;
        b=N/bM4gOQHwZBZOzmQzrNczZ5xT3PYlT2bibNTlr5zOjXHBlwE3wQWdIK1TH88nD5sl
         K6Qf8EYAO4jH29BPmog3qIqSP1+y9j1sEjUMjA+6I5jFStxzm3sqNGCbWT5QdZplxZO/
         gVACaQQ3mjbsD2b7BMpBevYf+Ecn/A5r3k2gNzkKlCXnTNcFJhHOWH4jMMWBOnHzQ362
         AKnDttVJeaKbAMhjXbY/DKJ/R6gXGrXBrkk2HY0/tnKhd0PaVWeT99rhQZks51eUpHLF
         A4B4DLn3yl2Mx1tLSpsO9fLQNxa2dctncw5ZDcFKfrLwm0bs9r9JMkHhlVHeXWU0Xu3w
         DXkw==
X-Gm-Message-State: AOJu0Yy1mTqpIcBSS2Wl6BEdyojU1sxk6RoXXxBPjxKgmYEMISjoMxkn
	TSLRI7VsQuiW4PDkhp9ca4+thKexLZ+PZf8cKbw=
X-Google-Smtp-Source: AGHT+IHhVnxQeVYVbZDCF5jof2xDL2LyT6uHSTsdqYN2tEnXmpZyDZze824GcMRV+BJ9FQQzzeitgw==
X-Received: by 2002:a05:600c:3d87:b0:3fe:f4b0:634a with SMTP id bi7-20020a05600c3d8700b003fef4b0634amr3688659wmb.19.1694589174296;
        Wed, 13 Sep 2023 00:12:54 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c235200b00402f745c5ffsm1133472wmq.8.2023.09.13.00.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:12:53 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	petrm@nvidia.com,
	jacob.e.keller@intel.com,
	moshe@nvidia.com,
	shayd@nvidia.com,
	saeedm@nvidia.com,
	horms@kernel.org
Subject: [patch net-next v2 05/12] devlink: move devlink_nl_put_nested_handle() into netlink.c
Date: Wed, 13 Sep 2023 09:12:36 +0200
Message-ID: <20230913071243.930265-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913071243.930265-1-jiri@resnulli.us>
References: <20230913071243.930265-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

As the next patch is going to call this helper out of the linecard.c,
move to netlink.c.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h |  2 ++
 net/devlink/linecard.c      | 26 --------------------------
 net/devlink/netlink.c       | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 1b05c2c09e27..fbf00de1accf 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -145,6 +145,8 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 	return 0;
 }
 
+int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
+				 struct devlink *devlink);
 int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
 
 /* Notify */
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index f95abdc93c66..688e89daee6a 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -65,32 +65,6 @@ devlink_linecard_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_linecard_get_from_attrs(devlink, info->attrs);
 }
 
-static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
-					struct devlink *devlink)
-{
-	struct nlattr *nested_attr;
-
-	nested_attr = nla_nest_start(msg, DEVLINK_ATTR_NESTED_DEVLINK);
-	if (!nested_attr)
-		return -EMSGSIZE;
-	if (devlink_nl_put_handle(msg, devlink))
-		goto nla_put_failure;
-	if (!net_eq(net, devlink_net(devlink))) {
-		int id = peernet2id_alloc(net, devlink_net(devlink),
-					  GFP_KERNEL);
-
-		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
-			return -EMSGSIZE;
-	}
-
-	nla_nest_end(msg, nested_attr);
-	return 0;
-
-nla_put_failure:
-	nla_nest_cancel(msg, nested_attr);
-	return -EMSGSIZE;
-}
-
 struct devlink_linecard_type {
 	const char *type;
 	const void *priv;
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index fc3e7c029a3b..48b5cfc2842f 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -82,6 +82,32 @@ static const struct nla_policy devlink_nl_policy[DEVLINK_ATTR_MAX + 1] = {
 	[DEVLINK_ATTR_REGION_DIRECT] = { .type = NLA_FLAG },
 };
 
+int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
+				 struct devlink *devlink)
+{
+	struct nlattr *nested_attr;
+
+	nested_attr = nla_nest_start(msg, DEVLINK_ATTR_NESTED_DEVLINK);
+	if (!nested_attr)
+		return -EMSGSIZE;
+	if (devlink_nl_put_handle(msg, devlink))
+		goto nla_put_failure;
+	if (!net_eq(net, devlink_net(devlink))) {
+		int id = peernet2id_alloc(net, devlink_net(devlink),
+					  GFP_KERNEL);
+
+		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
+			return -EMSGSIZE;
+	}
+
+	nla_nest_end(msg, nested_attr);
+	return 0;
+
+nla_put_failure:
+	nla_nest_cancel(msg, nested_attr);
+	return -EMSGSIZE;
+}
+
 int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info)
 {
 	int err;
-- 
2.41.0


