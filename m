Return-Path: <netdev+bounces-42935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192D7D0B78
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C36B28111A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1D212E76;
	Fri, 20 Oct 2023 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Dr7vV6ur"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3512E60
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:21:45 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFFBD7A
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so773801a12.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697793686; x=1698398486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxYbZL7pdVoxFWQTW59ElwR4qST6nZRNnQGFPjrE3Vw=;
        b=Dr7vV6urpRWnkmHrWuCG5+69uqdxyR2YfpMCbhFNjF1JSiXSBIK5y0sHxUWBx/Y8Iu
         7jlA8flMGUD6WjAwzExkoKmT+BcaF8xrH3Zd16amrGm6A2xrIhlJ0X2gAhl5ms+VJY+N
         qWzsTmYHU7TLkM4lBrtZxb22phc6IAgAjNiZQaZLklKQ2Tgzf4UAXWPasXgkJgRDe0mp
         uZGlaEqs0n4sNk1HJZ+mOMXgZ84gJpTkQloGPaaqe3VcMriBAWltv63fyfBwtMUECVT1
         jIdflV747T+jkTu9TwIPonsWK6U+QZBNLZLMB4RhUQohP8npiDTf3RuwMlCOej8xWH69
         1j/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793686; x=1698398486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxYbZL7pdVoxFWQTW59ElwR4qST6nZRNnQGFPjrE3Vw=;
        b=R5/q5uYTxXZx9+vDMVZjEh+lJM3r0ZQ8lLsmUlXZsWjWZ9sPgKG5qNk2FM4Bvl0ut+
         5FCEW40iCv2tMaR5Vf+v3gwj1YYgHdboz717TKn62IYOoCaNW2aC4ROOrYW1RinHqIHb
         AncrwR4AHyxjVjtEGlb3CUNmSKNWXcXDrxfuboZ4hux/AarlrZCO8X1vKfs9EiidVqlm
         N1lMqP62XsPM2vVw4i/9vWNnd/yXW0zIXz2Y8agOReVQC91YZuoHybnp1g8Sr5cc7SdJ
         2llk4+bVLOP6P7UiV/ETzjwquG/RJgaW3mDddYKYRN6hXNu0SgNJ9iWol39r7AAVONlC
         Iqrw==
X-Gm-Message-State: AOJu0YxSBUK7kt4eadEExDKBY45Cc4G2HKhdfTmptf5GEW5KXMPlpJyd
	mh5lmkNxU7iSZNfzCnNXLDCDz344Ld8Z0xhrfIw=
X-Google-Smtp-Source: AGHT+IHHA9AXbXiBjEMKV3lDAGzt+6tSBULzJkfPSioa2TutGQJ0MHT9sBh+QPMLqL9lHgVkWzkF2g==
X-Received: by 2002:a50:8e18:0:b0:53f:ded4:15b9 with SMTP id 24-20020a508e18000000b0053fded415b9mr448715edw.10.1697793685982;
        Fri, 20 Oct 2023 02:21:25 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k27-20020a508adb000000b0052ffc2e82f1sm1105898edk.4.2023.10.20.02.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:21:25 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v2 04/10] netlink: specs: devlink: remove reload-action from devlink-get cmd reply
Date: Fri, 20 Oct 2023 11:21:11 +0200
Message-ID: <20231020092117.622431-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020092117.622431-1-jiri@resnulli.us>
References: <20231020092117.622431-1-jiri@resnulli.us>
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


