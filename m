Return-Path: <netdev+bounces-48018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C471A7EC4EF
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FEB1F27335
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EF428DC1;
	Wed, 15 Nov 2023 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="om+7ojwT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98A28DA2
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:17:36 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA044C5
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:33 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9becde9ea7bso184668366b.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700057852; x=1700662652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPea8PV/Lzln8WWqnBMyajL3ID7zpvNDOa2t9VBeu3s=;
        b=om+7ojwTbfS98aRvLRSDXeS9nORow7yvOWBCJTDF1N1jBc8dbcEDLgqaJ3GV2QRujb
         fb0/y8ukmpCu92NaGFfqzMLdXkmVrNXYD32Y5wIp8DLfaaWiu2wQHaxbRNcPeFkzYEAL
         HmlGV60fBw1c6WNxr0EC7VrY/3bdX7xPH5Ckfw2MBpZxYV5F91mb1WgT/YBGkG4xzsEY
         C2vfzzXphilDK75croKd/ReoQWG8WVomsZe6bMGCx6oIE7bVJ3QwLfn4aTf3i5r3sHG1
         XSs8XWZ7280oYZfw87w8ZKqdezTqBApnyl3msS8uIo7Mo/BD6QbFzcXKFWYTK7YV2tp/
         PQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057852; x=1700662652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPea8PV/Lzln8WWqnBMyajL3ID7zpvNDOa2t9VBeu3s=;
        b=KHRuWWtskmYlkyVoWZT3MC/+Sa8eC/p+9zhxRQCtg+vB1mw/Q+FltolSspkDkD3DKD
         6xNwe4W1eBVQAXY+3VC8LFZ5/QNKKPEi/aTQQvq5QUrf2PSrHKmhNf6MSPJORvjkIG9Q
         +cLBlzejOou5fN1zFOdISyfijB+BhPkYXyjSqKX5H8NGcFuVVtaTFlHn2mYZds5GbOHR
         T+Zc1qnxPyKk3m+JVga/siV0AebSyiRxcyr6rDJAcgwpwTQrykfBc7zejXpmkS3x3aUg
         krehKD88pMk5paJLjbf7varcb3+haOZNUZfpFAp6C6pfoPiY3mhDvOOGtOAk86EdtjwM
         2l3g==
X-Gm-Message-State: AOJu0YwwDRU/CzQZdCvNRrMpkX3VNyPq2B/e4MUT5aj0RFpl67pJIp4n
	+I+bEpV9QimV4FPJdtf8OI6Kp0GU38oE0DINbRo=
X-Google-Smtp-Source: AGHT+IHM+SDtrO+luj3iWPFaQ40sByM271UbNyR5o6qLS3RhIeMWGoOZh2Z16Vginp7eeG35zXclmQ==
X-Received: by 2002:a17:907:94c1:b0:9f2:859f:713e with SMTP id dn1-20020a17090794c100b009f2859f713emr2164344ejc.3.1700057851981;
        Wed, 15 Nov 2023 06:17:31 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gr12-20020a170906e2cc00b009e6391123b6sm7050566ejb.50.2023.11.15.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:17:30 -0800 (PST)
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
Subject: [patch net-next 2/8] devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
Date: Wed, 15 Nov 2023 15:17:18 +0100
Message-ID: <20231115141724.411507-3-jiri@resnulli.us>
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

Introduce __devl_is_registered() which does not assert on devlink
instance lock and use it in notifications which may be called
without devlink instance lock held.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/devl_internal.h | 7 ++++++-
 net/devlink/linecard.c      | 2 +-
 net/devlink/port.c          | 2 +-
 net/devlink/region.c        | 3 ++-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 183dbe3807ab..381b8e62d906 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -90,10 +90,15 @@ extern struct genl_family devlink_nl_family;
 
 struct devlink *devlinks_xa_find_get(struct net *net, unsigned long *indexp);
 
+static inline bool __devl_is_registered(struct devlink *devlink)
+{
+	return xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
+}
+
 static inline bool devl_is_registered(struct devlink *devlink)
 {
 	devl_assert_locked(devlink);
-	return xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
+	return __devl_is_registered(devlink);
 }
 
 typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 2f1c317b64cd..9d080ac1734b 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -136,7 +136,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 	WARN_ON(cmd != DEVLINK_CMD_LINECARD_NEW &&
 		cmd != DEVLINK_CMD_LINECARD_DEL);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!__devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 7634f187fa50..f229a8699214 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -512,7 +512,7 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 
 	WARN_ON(cmd != DEVLINK_CMD_PORT_NEW && cmd != DEVLINK_CMD_PORT_DEL);
 
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+	if (!__devl_is_registered(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
diff --git a/net/devlink/region.c b/net/devlink/region.c
index 0aab7b82d678..396930324da4 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -234,7 +234,8 @@ static void devlink_nl_region_notify(struct devlink_region *region,
 	struct sk_buff *msg;
 
 	WARN_ON(cmd != DEVLINK_CMD_REGION_NEW && cmd != DEVLINK_CMD_REGION_DEL);
-	if (!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED))
+
+	if (!__devl_is_registered(devlink))
 		return;
 
 	msg = devlink_nl_region_notify_build(region, snapshot, cmd, 0, 0);
-- 
2.41.0


