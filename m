Return-Path: <netdev+bounces-33455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583A79E08F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56A9281B74
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ADC182CA;
	Wed, 13 Sep 2023 07:12:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75A182A3
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:12:54 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFE81728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31aeef88a55so6007437f8f.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589172; x=1695193972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPUEIwNx71s3eWjcIHfx8aNZVUmLM22niP2i+9vR93c=;
        b=al4WkwwVYM4nqNvQ82uF60cri/3qTgguU+QOa+3zKrD7/f59mVfpX4lflHnR3HQbCO
         TBK4CHhJJpOkPepoNt4QsU+5kvhjg2MrO5uXNMjRGYnhee24RTNxg+iOul2hQfpm/Hvb
         GEZoHelA5mgnUNBAkehUKKiVicYQ3/w9iFcp6GnLWEd108cn/Wpbhmrhv+i+SiucvBdW
         l3aBiYPzR8q9eo9dzDGM8qft4cAF0qvXtM7KkVDk46ZX7wOwfp4QFWmG5pYiqpvGGbnU
         GaWYij5EkKl746K+f4VsG83pqkLEbWPZnnYI9Jecpo+mOyVIXk9GDaUHfnmPc+/Qjzon
         9AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589172; x=1695193972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPUEIwNx71s3eWjcIHfx8aNZVUmLM22niP2i+9vR93c=;
        b=OcxgfWc8vYg+Eo0V7qGDploAkOe5uFxXoVK4A7JZ6CaMaechL6/4lhPYBQgbwy/PmP
         WsGgrKfyVK4vJlMur0TWUYlGCJSFP9a7jewcwgkK+R+oubTaJ4O8M2qlKVrS0Ue9ShKQ
         iSbEhU9zbTLA03Q6zZA1+BRRtf+n7803q27VVEvSaiAvdXACH0ZrENdIXE3sJrZXgOf4
         NvmJIXSEqXfYP+ILRmbasExtWbwLDBFi16l2n+kjXyq0L4/Iz9B2xt+vwJ64t8vNvmWZ
         T7RLJhXSqCRoZ7QaBEYFlIeNKSixtfQuXyYVkj+54Cw7nyUFc6HxOrKCEuarBuqiprRq
         DVng==
X-Gm-Message-State: AOJu0YwfEU8LeEr+jq6H5TOgI0HTG2shSkFRFCv+EWVlKIVopi2GGZOs
	vNbvKZnBtDwaTwqT9oyy670vAkqHG+pMuqnH4BQ=
X-Google-Smtp-Source: AGHT+IGXTYFNIzApQa/tfZExtrc7xRaGySZIhOB5sRg4nVAzee5Ynq0MgDtB2kLD5MhyUGtICPIovw==
X-Received: by 2002:a5d:6ac3:0:b0:314:2fdd:28ef with SMTP id u3-20020a5d6ac3000000b003142fdd28efmr1368501wrw.18.1694589172729;
        Wed, 13 Sep 2023 00:12:52 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d6983000000b003197c7d08ddsm14680861wru.71.2023.09.13.00.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:12:52 -0700 (PDT)
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
Subject: [patch net-next v2 04/12] devlink: put netnsid to nested handle
Date: Wed, 13 Sep 2023 09:12:35 +0200
Message-ID: <20230913071243.930265-5-jiri@resnulli.us>
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

If netns of devlink instance and nested devlink instance differs,
put netnsid attr to indicate that.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 net/devlink/linecard.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index a0210ba56f2d..f95abdc93c66 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -65,7 +65,8 @@ devlink_linecard_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_linecard_get_from_attrs(devlink, info->attrs);
 }
 
-static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct devlink *devlink)
+static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct net *net,
+					struct devlink *devlink)
 {
 	struct nlattr *nested_attr;
 
@@ -74,6 +75,13 @@ static int devlink_nl_put_nested_handle(struct sk_buff *msg, struct devlink *dev
 		return -EMSGSIZE;
 	if (devlink_nl_put_handle(msg, devlink))
 		goto nla_put_failure;
+	if (!net_eq(net, devlink_net(devlink))) {
+		int id = peernet2id_alloc(net, devlink_net(devlink),
+					  GFP_KERNEL);
+
+		if (nla_put_s32(msg, DEVLINK_ATTR_NETNS_ID, id))
+			return -EMSGSIZE;
+	}
 
 	nla_nest_end(msg, nested_attr);
 	return 0;
@@ -131,7 +139,8 @@ static int devlink_nl_linecard_fill(struct sk_buff *msg,
 	}
 
 	if (linecard->nested_devlink &&
-	    devlink_nl_put_nested_handle(msg, linecard->nested_devlink))
+	    devlink_nl_put_nested_handle(msg, devlink_net(devlink),
+					 linecard->nested_devlink))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
-- 
2.41.0


