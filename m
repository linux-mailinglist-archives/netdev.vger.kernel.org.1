Return-Path: <netdev+bounces-54566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1A1807778
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CFE1C20EA8
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E0E6F610;
	Wed,  6 Dec 2023 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kuEVFYUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB8818D
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 10:21:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so95869a12.2
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 10:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701886886; x=1702491686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqAP4zVW3tr3kQv/U3Y5QSJhXtJi2tdSQ5AvLLkkNsk=;
        b=kuEVFYUS0hP48wShRpL4L9ddfD2uP7sEm9vt6ohWhKJocbtLf6KFFKFYtedEKKvzXg
         ZHjEd+yXLNTfV3IIhMksXWYT+wP8WKNtY9VjKuc7a53Gk5DkgLDiT8eI9gcwf0O8DPiY
         1Pb9kghH1/oCybEJUxsE1J7iI58UkGxs8GJl0mCVE4dAGdYbGBjhD5vYbpZ1rCrQ9Asl
         G4piEeqjbi+Os15l5WT+p0YChHwxa3CR7di85qoCQ5prqRZFF3k+Ur/KWNeC9dDDftz0
         IUie0unLiEt76ur3H87WcoPyNGfe2uiwszPD9DERH/Fmd5PMncIs3EeNFu0c/tKoEx2e
         QDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886886; x=1702491686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqAP4zVW3tr3kQv/U3Y5QSJhXtJi2tdSQ5AvLLkkNsk=;
        b=LygFMt9zS9x2C2Ftah1qFPS1eVPeb9fmqtZ6PcXDyxebNOwSKkiZckLrv5FfNxt6T9
         z0yxPiGdmH6xv6TL+gKAPlXJXfyXfXnpwqVx3dL4glyts98ptycY4B+xR+LfH0lSVmxX
         oQhZ63gLtusW0WFk62t+WbILKjscE2zjefOiebPRW54+YRryIemnkEE35sRjC+ORbMAS
         NX4AxXxLjawtTWHzTVjt7mVS8/hn2S466M6r5USxMeqVPR3OPF9rz8ENIrA4V6L9sqEf
         k0CQlJdWXHgKyGOcjnXzxcFYl2igmGaerKnh/0+GZxfQmLylO9/Ygj9W9ARHt6C1hPaK
         FDpQ==
X-Gm-Message-State: AOJu0Yz4ywT0q8IUEMF7W4W5HrlkTdzsQoReEV6Ufy5iV/jL/RgTAN5x
	3bvfxVIVYjbJWfEkJRBI+0EpsC1oFEwxz6TxrgI=
X-Google-Smtp-Source: AGHT+IH9NElVj3xWmaKbAKNfU5eW7LXZCoBz9yyVqL07Kc/vY1lckoBHcjp9thRyiNuTPduSlmPOiw==
X-Received: by 2002:a50:999a:0:b0:54c:4fec:f0 with SMTP id m26-20020a50999a000000b0054c4fec00f0mr408191edb.127.1701886886196;
        Wed, 06 Dec 2023 10:21:26 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g6-20020a056402114600b0054cb316499dsm254638edw.10.2023.12.06.10.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:21:25 -0800 (PST)
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
Subject: [patch net-next v5 2/9] devlink: introduce __devl_is_registered() helper and use it instead of xa_get_mark()
Date: Wed,  6 Dec 2023 19:21:13 +0100
Message-ID: <20231206182120.957225-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206182120.957225-1-jiri@resnulli.us>
References: <20231206182120.957225-1-jiri@resnulli.us>
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
index 5ea2e2012e93..59ae4761d10a 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -91,10 +91,15 @@ extern struct genl_family devlink_nl_family;
 
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
 
 static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
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
index e3bab458db94..b65181aa269a 100644
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


