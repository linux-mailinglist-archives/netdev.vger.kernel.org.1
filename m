Return-Path: <netdev+bounces-43224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B88B77D1CCE
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C02825B3
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C983DDF45;
	Sat, 21 Oct 2023 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jX349BJ2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90227F515
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 11:27:24 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61B1A4
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:21 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so2388703a12.3
        for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697887640; x=1698492440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxYbZL7pdVoxFWQTW59ElwR4qST6nZRNnQGFPjrE3Vw=;
        b=jX349BJ28x1RaSX5iKtUhgB5lO8Q+7umBWoO7URnHc/B3HWis6ARuBFmRie02UYYb3
         LKgKyN4SJVMHOj0FtkOlpVkUZ9Vm+R/7p/657x1cpZcJ/lapZC5Iiek01XRVNSsJG8LX
         /g3yqDPKA3px1aPVmtrOL4lloPyKV4+bmBoStZSG5SWWVaUh1IWUuSv5xtHCMh88FbzN
         1ACbkPlpJS2SWMvoTGfVBcaJh8p7JskgYBi09CXEd334LRgandaNCwDNqjjAurBqP2LS
         tp44yV+kqn09F2Q7WK6biWgruuvfIO+hPmx1g173jmkzY47V4DSMFLiSspJEkfqxt6LU
         wnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697887640; x=1698492440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxYbZL7pdVoxFWQTW59ElwR4qST6nZRNnQGFPjrE3Vw=;
        b=vn0VjaKADmRICEa9ixk1oMOLc1qbVQ0AsTi9/bkKH545hipIYThMvL8OBC8mn48/kO
         A7rwMgf9pt7As99PkUeJiJweurSaMvdvPJ3WBua84FlT6L87t39ZJAn0KaE+cM7IsYqh
         D1izKF5IcWpMMuhD9TPkFmphbVypNqj/5BCvi+kO7RIT6u+RsEqEx8T3AGW02+QZDcDw
         qb50ND8enfQV/hvHnCR9rRGJIbaJInN07uNUmg/olfub/GixYZHLoAsYRs7Rp0CCKHey
         Cg6kIBq0TnhuxoMedG4rJF4IYH1G8RHeZz2eFxNNbE/hOKpTaKuvKYQI3SFwCpjPi2Hj
         zkiQ==
X-Gm-Message-State: AOJu0YwZ9SF6TqhuVwOnWDUFL7PvAIFuz3ffQBYXppm7vFRFFd6/0+/E
	bBM6l8kg7COMttM+vA2HUpYaZZEAMXlR3oOsR94=
X-Google-Smtp-Source: AGHT+IENmHaYtLc+WWbWxeu3mnc5ndvmL2IIC7S9ykDVphzQppjvzO98i8y45A1KunYD4uM03l03Vg==
X-Received: by 2002:a17:907:26c2:b0:9ae:6ffd:bdf7 with SMTP id bp2-20020a17090726c200b009ae6ffdbdf7mr3306802ejc.39.1697887639867;
        Sat, 21 Oct 2023 04:27:19 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s19-20020a170906bc5300b009b957d5237asm3440520ejv.80.2023.10.21.04.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 04:27:19 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v3 04/10] netlink: specs: devlink: remove reload-action from devlink-get cmd reply
Date: Sat, 21 Oct 2023 13:27:05 +0200
Message-ID: <20231021112711.660606-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021112711.660606-1-jiri@resnulli.us>
References: <20231021112711.660606-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

devlink-get command does not contain reload-action attr in reply.
Remove it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 1 -
 tools/net/ynl/generated/devlink-user.c   | 5 -----
 tools/net/ynl/generated/devlink-user.h   | 2 --
 3 files changed, 8 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index dec130d2507c..94a1ca10f5fc 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -263,7 +263,6 @@ operations:
             - bus-name
             - dev-name
             - reload-failed
-            - reload-action
             - dev-stats
       dump:
         reply: *get-reply
diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
index 2cb2518500cb..a002f71d6068 100644
--- a/tools/net/ynl/generated/devlink-user.c
+++ b/tools/net/ynl/generated/devlink-user.c
@@ -475,11 +475,6 @@ int devlink_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
 				return MNL_CB_ERROR;
 			dst->_present.reload_failed = 1;
 			dst->reload_failed = mnl_attr_get_u8(attr);
-		} else if (type == DEVLINK_ATTR_RELOAD_ACTION) {
-			if (ynl_attr_validate(yarg, attr))
-				return MNL_CB_ERROR;
-			dst->_present.reload_action = 1;
-			dst->reload_action = mnl_attr_get_u8(attr);
 		} else if (type == DEVLINK_ATTR_DEV_STATS) {
 			if (ynl_attr_validate(yarg, attr))
 				return MNL_CB_ERROR;
diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
index 4b686d147613..d00bcf79fa0d 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -112,14 +112,12 @@ struct devlink_get_rsp {
 		__u32 bus_name_len;
 		__u32 dev_name_len;
 		__u32 reload_failed:1;
-		__u32 reload_action:1;
 		__u32 dev_stats:1;
 	} _present;
 
 	char *bus_name;
 	char *dev_name;
 	__u8 reload_failed;
-	__u8 reload_action;
 	struct devlink_dl_dev_stats dev_stats;
 };
 
-- 
2.41.0


