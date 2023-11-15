Return-Path: <netdev+bounces-48020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA17EC4F1
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 15:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08DC8B20BF3
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 14:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227728DD1;
	Wed, 15 Nov 2023 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hWg0W8W5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C728DCA
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 14:17:39 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F2101
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:37 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so1820263a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700057856; x=1700662656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDezKWz0doJAOlG7AP9dGlF4Zqe7hOwSp2BSLUMy+RQ=;
        b=hWg0W8W5kaWWA4luAaXhtFHpghK1raKuCeZuz8TOG0Fj21+BSjjsP1kmF8phWFge7n
         7E7e2s7yNPHCohGKQXIxbOc/4YDnWxhymrBs7PdOrePWQ0o5NTUIVo9fWo7f78DG505O
         6VWwuKguULAiBhYRI33P5uY6NkWtePn7W3QaZZ9PLL1AH039E+0FcdJd3HRwz3a0qE6g
         XAzySyqeHjoikXxD6HwPnxAOccRQWFvE9xWJE+b/4DlIpFs/y6ZEvEeG4IrzuDD0sQgP
         +sbhHIvKby1w/1nHg9ul6+Ur4jNlEQmq40RPOozofITL7k2FBNqE1F7kmgJP4W+09fEV
         +xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700057856; x=1700662656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDezKWz0doJAOlG7AP9dGlF4Zqe7hOwSp2BSLUMy+RQ=;
        b=fGohiZ2kRrIkPQmwCRJfvUPlXsweV14+1W7p2cBaMbSfM9D2bbvvyrUKbdRKi6mt03
         Y6+S27B3YaM1Q0Js0myyEJmkKw8nJuAV3pnPceJKbuLz1/q9b0Ye1tKY4qpasOwMnB8g
         8a+B3/KoxUSO+uV4YW9ZOBAuWfoGE0LsFHUF4HJIUP1G0/4ETEBv24Oat09MEuVsl+mS
         NOFNuLCWKGmPKXl+duKgxGcTpVzpy4vqHAaXUR1DRTMHgj/bI4FD94E87YxxX55gdiJN
         btQbNFRax3DB9QwnevXoXs0eEYPJ/txtFFILpTkD7gq0EbYuAXlmhrymtWq7QR+5Kl+7
         s2VA==
X-Gm-Message-State: AOJu0Ywt4k508L66g95Pl2YoWpdfB3KqXMNKDqSSQb9eyr7JmiqlwHYj
	A3VLZcKjBTYvp7RyoOveqM5ins0pxaSWNrXDUwE=
X-Google-Smtp-Source: AGHT+IG+UNfclit120Nv1u3S/ERRNLmu879KUck+vZuiZL/ZJdry1+y0gdGapQu5zoM7uT67m8GmFg==
X-Received: by 2002:a05:6402:27cb:b0:53e:1207:5b69 with SMTP id c11-20020a05640227cb00b0053e12075b69mr5612844ede.10.1700057856239;
        Wed, 15 Nov 2023 06:17:36 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m20-20020a50d7d4000000b00530bc7cf377sm6668730edj.12.2023.11.15.06.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:17:35 -0800 (PST)
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
Subject: [patch net-next 4/8] devlink: introduce a helper for netlink multicast send
Date: Wed, 15 Nov 2023 15:17:20 +0100
Message-ID: <20231115141724.411507-5-jiri@resnulli.us>
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

Introduce a helper devlink_nl_notify_send() so each object notification
function does not have to call genlmsg_multicast_netns() with the same
arguments.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c           | 6 ++----
 net/devlink/devl_internal.h | 7 +++++++
 net/devlink/health.c        | 3 +--
 net/devlink/linecard.c      | 3 +--
 net/devlink/param.c         | 3 +--
 net/devlink/port.c          | 3 +--
 net/devlink/rate.c          | 3 +--
 net/devlink/region.c        | 3 +--
 net/devlink/trap.c          | 9 +++------
 9 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 582b5177f403..ecbc6d51b624 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -216,8 +216,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
@@ -991,8 +990,7 @@ static void __devlink_flash_update_notify(struct devlink *devlink,
 	if (err)
 		goto out_free_msg;
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 	return;
 
 out_free_msg:
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 8b48a07eb7b7..e19e8dd47092 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -178,6 +178,13 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
 				  DEVLINK_MCGRP_CONFIG);
 }
 
+static inline void devlink_nl_notify_send(struct devlink *devlink,
+					  struct sk_buff *msg)
+{
+	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
+				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+}
+
 /* Notify */
 void devlink_notify_register(struct devlink *devlink);
 void devlink_notify_unregister(struct devlink *devlink);
diff --git a/net/devlink/health.c b/net/devlink/health.c
index 93eae8b5d2d3..2f06e4ddbf3b 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -509,8 +509,7 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
-				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 45b36975ee6f..67f70a621d27 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -150,8 +150,7 @@ static void devlink_linecard_notify(struct devlink_linecard *linecard,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_linecards_notify_register(struct devlink *devlink)
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 6bb6aee5d937..854a3af65db9 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -356,8 +356,7 @@ static void devlink_param_notify(struct devlink *devlink,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 static void devlink_params_notify(struct devlink *devlink,
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 32f4d0331e63..758df3000a1b 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -525,8 +525,7 @@ static void devlink_port_notify(struct devlink_port *devlink_port,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
-				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 static void devlink_ports_notify(struct devlink *devlink,
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 0371a2dd3e0a..7139e67e93ae 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -159,8 +159,7 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
-				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_rates_notify_register(struct devlink *devlink)
diff --git a/net/devlink/region.c b/net/devlink/region.c
index f1402da66277..fd6bfabc0c33 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -242,8 +242,7 @@ static void devlink_nl_region_notify(struct devlink_region *region,
 	if (IS_ERR(msg))
 		return;
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink), msg,
-				0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_regions_notify_register(struct devlink *devlink)
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 3ca1ca7e2e64..5d18c7424df1 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -1188,8 +1188,7 @@ devlink_trap_group_notify(struct devlink *devlink,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_trap_groups_notify_register(struct devlink *devlink)
@@ -1249,8 +1248,7 @@ static void devlink_trap_notify(struct devlink *devlink,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_traps_notify_register(struct devlink *devlink)
@@ -1727,8 +1725,7 @@ devlink_trap_policer_notify(struct devlink *devlink,
 		return;
 	}
 
-	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
-				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
+	devlink_nl_notify_send(devlink, msg);
 }
 
 void devlink_trap_policers_notify_register(struct devlink *devlink)
-- 
2.41.0


