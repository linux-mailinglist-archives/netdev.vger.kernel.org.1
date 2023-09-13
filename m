Return-Path: <netdev+bounces-33457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B579E091
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ED9281C09
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B64A18B05;
	Wed, 13 Sep 2023 07:12:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1118AF2
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:12:58 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D8A1728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401b5516104so68441775e9.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589176; x=1695193976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqkQ0rNxlqlnSBJNC6M4MIiSS3iN/iafF3G9ARoJuF0=;
        b=L4RH/HRU4QF7My8vs5TSMl/ux/7Imku4ZrNjcQMasJ52s9tmdDdrt+gG1Wn6etQ7uh
         BQfglHnEVLaou1nlxWUs6fv/B6oJ+O+wiEosTRI1mvFCwpRpLO1M9DVNuu1TsXYXo/py
         maSgnIt3wi4Cfvdp69ivKz+GFn9iqKD1ebWpcd2ntlM0Talu11BJ3i5g11kJFcorFM6E
         BpoU2p1VRQQlA9Rvdw/EJ/MhnCa64t2ncQhZI2EhHwWHxL0okpAmAaowMbM2XNKZVObJ
         0reKohJXQTxTPfnGi7RxvcGMybEUt2NRfUiekslyTq2dR8t4PpOWU0SIWu0LT30E2TQA
         uOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589176; x=1695193976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqkQ0rNxlqlnSBJNC6M4MIiSS3iN/iafF3G9ARoJuF0=;
        b=cwKRrj2Phq2w9mmKamZll0hTkO2aFweoZlczPO6zF4RIEGvhPalI8UXbfy9feUbYTg
         iKHuM2wX5AssXrlop2BiJmD4DaQtvm4RdRHP01V+cskdqZVXmUjSOEPkADEcBH0jAt3O
         bvaR4TXMN2nHH1S53ydXPOacbckwIz6b6qd4qf7UK2eVSTpNFBjlTa9yPGZqGRWMVzcx
         hBlcPDxZyfsEFfC6uePMq/E6N0WNQ7liy6c2HK6/eNcfBZoiYyN4NVK7a1UFKNiY+dpJ
         /JZjl1MMsPafT+wlJec3Xe/CmhDPEezwYXO1GntYDN44PEDdv5BRX5okMJIe+3ZdsL8G
         6F9A==
X-Gm-Message-State: AOJu0YzRVi9bTydQfQb79RfT1i5NR2a1LIPubcGMxkq10fsyJkd10A7B
	Syquqh5l/P8JuAY8E8l+VFdYK2Ubt9wGBWZq33w=
X-Google-Smtp-Source: AGHT+IFITjilultJWk8vk4m8q+MooiOK8Z8jvT2bdNx6c1euK3HtbRgH5Q/j6T3apoP72Nhoh3V5uQ==
X-Received: by 2002:a05:600c:221a:b0:401:dc7c:2488 with SMTP id z26-20020a05600c221a00b00401dc7c2488mr1313440wml.11.1694589176010;
        Wed, 13 Sep 2023 00:12:56 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0ac400b004030c778396sm1144220wmr.4.2023.09.13.00.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:12:55 -0700 (PDT)
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
Subject: [patch net-next v2 06/12] devlink: extend devlink_nl_put_nested_handle() with attrtype arg
Date: Wed, 13 Sep 2023 09:12:37 +0200
Message-ID: <20230913071243.930265-7-jiri@resnulli.us>
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

As the next patch is going to call this helper with need to fill another
type of nested attribute, pass it over function arg.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 net/devlink/devl_internal.h | 2 +-
 net/devlink/linecard.c      | 3 ++-
 net/devlink/netlink.c       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index fbf00de1accf..53449dbd6545 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -146,7 +146,7 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 }
 
 int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
-				 struct devlink *devlink);
+				 struct devlink *devlink, int attrtype);
 int devlink_nl_msg_reply_and_new(struct sk_buff **msg, struct genl_info *info);
 
 /* Notify */
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 688e89daee6a..36170f466878 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -114,7 +114,8 @@ static int devlink_nl_linecard_fill(struct sk_buff *msg,
 
 	if (linecard->nested_devlink &&
 	    devlink_nl_put_nested_handle(msg, devlink_net(devlink),
-					 linecard->nested_devlink))
+					 linecard->nested_devlink,
+					 DEVLINK_ATTR_NESTED_DEVLINK))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 48b5cfc2842f..499304d9de49 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -83,11 +83,11 @@ static const struct nla_policy devlink_nl_policy[DEVLINK_ATTR_MAX + 1] = {
 };
 
 int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
-				 struct devlink *devlink)
+				 struct devlink *devlink, int attrtype)
 {
 	struct nlattr *nested_attr;
 
-	nested_attr = nla_nest_start(msg, DEVLINK_ATTR_NESTED_DEVLINK);
+	nested_attr = nla_nest_start(msg, attrtype);
 	if (!nested_attr)
 		return -EMSGSIZE;
 	if (devlink_nl_put_handle(msg, devlink))
-- 
2.41.0


