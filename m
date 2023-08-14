Return-Path: <netdev+bounces-27247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D208177B270
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1326A280F0F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55248487;
	Mon, 14 Aug 2023 07:29:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827B6D24
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:29:07 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB145E75
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 00:29:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3180fd48489so3265997f8f.3
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 00:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691998143; x=1692602943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXmTyjOjqbJrnEr9NK8/CkgQsGSGHVKfXT9QUa+DJos=;
        b=S0W1wiFtxslctM1AdKVzQLoJ+FVShr7M6E4orGGSnVgGm/D/dIrEXpF6DyjNDyeFvJ
         4n2IXrFg7D4RfMgC3JpgjIFqJJoZfIrR4qvNGGEWFY6kCZ0Ysr6QQCjY+WfizpdMv3u2
         k/uPyyLYKfsRZlZqYxiInChaaAb05n3wej5/7vLBrW/N+OhOcCrITjzCL6Mq9bR4xK1I
         4gwfgzkMycp8im1dLnqA+RynxLqC1fI5bLfwq5M75VsJ+nsWdpEHf/SlWxa+FrwY7wlv
         SuJ7U254HEU3/kcYgr5f16TIU9KJGo92UbmWEMBapKxstD+oe0oEhLy5Do53eYS8v0TN
         2NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691998143; x=1692602943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXmTyjOjqbJrnEr9NK8/CkgQsGSGHVKfXT9QUa+DJos=;
        b=V7+cyRSZCQUW8oKNAX2s1tUBf0xfyXtgDQt5EWJ+aPEIy4ylk95ZWw/vazcgKcr0lR
         TG8g8t6MCLJypmXlEE/uLuOikMjt0lu/wXUqoQIAnrMNACOtGWQCDdxtopyNNElb7nrC
         QG5aKsuj6e+uZP6S/F6NLONQwkvohUqT8MPt2+CN4T8jV28iIHYZli6dlWan7HVWFCI3
         K2KZR/07mnlGUby5h+nbsAKpcGmcnq5gzEKoTmvViVW0O022lE4tW/C+SneU445dnsrL
         OT//5diKOoIYwAQETfvG0YdL9uQh4jwHItgkoNXDeajF4Qs7CXAEWo2q+i/OtuFI5FyU
         MGeA==
X-Gm-Message-State: AOJu0YxIQ3fwbEa3qGXf4PIZMN8RINM0nQX4hiK7smjYYGkb9IZcSKXg
	nXoquKAPFW5znwgaIWou8M6Ag3Ou2qJmAGRX5qH02w==
X-Google-Smtp-Source: AGHT+IGumNJsAXd0DMcbj6/ulgwttGs5GfPHz8XtlAmhCge+FdMeWdOsCWZaWYmzp+suaP2WbRl4Gw==
X-Received: by 2002:a5d:4448:0:b0:317:f537:748d with SMTP id x8-20020a5d4448000000b00317f537748dmr5151204wrr.64.1691998143008;
        Mon, 14 Aug 2023 00:29:03 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b00317f29ad113sm13467685wrr.32.2023.08.14.00.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 00:29:02 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next] devlink: spell out STATE in devlink port function help
Date: Mon, 14 Aug 2023 09:29:01 +0200
Message-ID: <20230814072901.1865650-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
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

Be in-sync with port help and port man page and spell out the possible
states instead of "STATE".

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 3cb102736b19..1a522111385b 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -4962,7 +4962,7 @@ static int cmd_port_param_show(struct dl *dl)
 
 static void cmd_port_function_help(void)
 {
-	pr_err("Usage: devlink port function set DEV/PORT_INDEX [ hw_addr ADDR ] [ state STATE ]\n");
+	pr_err("Usage: devlink port function set DEV/PORT_INDEX [ hw_addr ADDR ] [ state { active | inactive } ]\n");
 	pr_err("                      [ roce { enable | disable } ] [ migratable { enable | disable } ]\n");
 	pr_err("       devlink port function rate { help | show | add | del | set }\n");
 }
-- 
2.41.0


