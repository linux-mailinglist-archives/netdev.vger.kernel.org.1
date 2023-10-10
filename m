Return-Path: <netdev+bounces-39519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336E17BF93D
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B7A1C20E9E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC278182D4;
	Tue, 10 Oct 2023 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AuGowa3q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18FFBFC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:08:40 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F6A9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b9ad5760b9so933962066b.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936117; x=1697540917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxWUyh6O06si/cD3suyQpeij9Bgshk8PP3U/limEXmg=;
        b=AuGowa3quN5FB24nKeHWjq81V+XCtuEJv9puQYFpC8xCbYw61Jo1oSkv8RD+RPPT0+
         PCN3psK6mZFlXTl5NKK850Q9jAmz1v0O+LIoCddabejMDoCLVd98PpgskxdUpUascq6n
         TlBwqtnmv5kpROwtsuAYht1dCWa7+CE3ArTSom91MvxjRD3CtJEAWH518t96Y+dzF3fs
         s6O3YzwE83ylRGNyNs1qwkiwVjmRlkxg8pOYsoIKnfbhRnHNcB3nZPljZJLwBu87XvJe
         yjMSTjLleAhp+wed9/WG6BF5A0Ta6ohgZxCfq296GOCmjtHcBHiMUu0lrZ9CEB1CdbV2
         OWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936117; x=1697540917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxWUyh6O06si/cD3suyQpeij9Bgshk8PP3U/limEXmg=;
        b=RWH8/tB+kHI72+XfB89pe2mZZGcuuhk9JwhAPys+jnZtqtumEMjLFGX2kLeMDvBDec
         RAkMkbE6DgiY1Wrnquvc/P6aT5dpKrHijBvg/rcpyfDyueehwFrM3AR6IRzoGGyRrS8q
         XIPj4EIlo1IUzABmrrlbclFjfVtFb2COWlZCPuDlIBibYWogGXTCYXySSEBqXA9oIELS
         lomJDSJhANJwaxBr+E9W/72vQWTG5z5jGZrhb6NDV95a3f1Mv+283Ije72wkgylj3a8y
         yix/hepZOBZYHsy/+gFmjY2DtiBhb7IKv2bhPpVEsOsxWPr6B2q7jQ9znm04QFBl3Fwg
         LJ6Q==
X-Gm-Message-State: AOJu0Yz7kmVeLaHyhXp9C8ey7xNsr9WcmBW/isA1SNj8O4xp2EB1sRE2
	H23W3h4JTKr327ceUG+gwVIBLFo9REWpqmO+nuQ=
X-Google-Smtp-Source: AGHT+IFSBV9QNQuR384HUh504aqQTSCFtXBfF1cuM7B8SsgFlDpvfBsBLM/b+nF1VtVyWaavUG9XSQ==
X-Received: by 2002:a17:906:300f:b0:9a5:7f99:be54 with SMTP id 15-20020a170906300f00b009a57f99be54mr14728104ejz.67.1696936116246;
        Tue, 10 Oct 2023 04:08:36 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jp20-20020a170906f75400b0099bcb44493fsm8324226ejb.147.2023.10.10.04.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:08:35 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 03/10] netlink: specs: devlink: remove reload-action from devlink-get cmd reply
Date: Tue, 10 Oct 2023 13:08:22 +0200
Message-ID: <20231010110828.200709-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010110828.200709-1-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 86a12c5bcff1..08f0ffe72e63 100644
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
index 3a8d8499fab6..34ed9319a2b2 100644
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
index a490466fb98a..5fbb20859837 100644
--- a/tools/net/ynl/generated/devlink-user.h
+++ b/tools/net/ynl/generated/devlink-user.h
@@ -113,14 +113,12 @@ struct devlink_get_rsp {
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


