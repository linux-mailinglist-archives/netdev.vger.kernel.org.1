Return-Path: <netdev+bounces-28432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E43377F6CC
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB91C20F08
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982B13AF5;
	Thu, 17 Aug 2023 12:52:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA392907
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:52:47 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33302D5F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:52:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so71202515e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692276763; x=1692881563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNH8jgIIjeoKstQpTEEzPTnWqsW8pg6m16x+9+66OeA=;
        b=a8G8Ftm0/LSBlydRINwfX5C9EAGW7al3clx6LYmuog337/p9f54rkwvxRaxrikf9S4
         3C+uxkPmAhl9Z5qz97Flrwv89OHtFXlwKOmoybqzhFtzQJwkQFYs1SFXJOVz5jJLsBB9
         qTejhrIJweCdWA1SyNvwTGnIIxdyqtLw+6md5grwWV5w65CJAp0w8hVra2pjVINt640u
         sunbdXwZCZ1Xs4mrkFqADHkLk+rGXUKFlwCffIURjJvoPwmvD7pDVjYdnGL7db8hwWIO
         eEO8dsmkjhDauQ4nbkzS6/vO0UHbsQW/wzEYTIsQWfGVbkfGR1ZE0kRe9wu7TF7BGnBC
         kx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692276763; x=1692881563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNH8jgIIjeoKstQpTEEzPTnWqsW8pg6m16x+9+66OeA=;
        b=ehjbjznKAQQ2JvWtcHkEjbiqkWNHdvI0mq28XJbanXJjDLGWlLFmtQMxvD+2H1U7F4
         hI/JuGvwqiCKPlf2CxCGR/+2h0AAPelddXeE4jv/eiaT2QJoVt6wGurz0kqftZsfyzY3
         foAwM+7TJyN6z1t9Mw9rxduzIKOvfG70NmOGtuZzxp+O7F9TNmIChZOzWZRsQSvVGlAn
         La071NIwVT6yazKaR5Bku9Vst4yuFjTJBQxEuHtuJBCQ4qGkXI2wTkGJWGBzZkGZI0FV
         fYs7CBYJJ2wXBKj0giekVYe+9UYHJBOxXrgSCHq/iH9mAC5nMtzs+awx/rk/1Y4narGu
         pgWQ==
X-Gm-Message-State: AOJu0YwvQ7cr0JoW6DKi3aIIkUHaiiYmMrYiqKhQDx/ngIGWnsYYFO9A
	tn/eYEoNrpSTJs9b0G6Jj45oZKW7oI3ksSBbJM9tlw==
X-Google-Smtp-Source: AGHT+IFEsKIVIlwDN2VV/XOksV1u5uUHdebA6Xw3EiySuFeDGb7He8XafUlmnKmgu2PIIZlRNBM4wg==
X-Received: by 2002:a1c:f314:0:b0:3fe:201a:4b7b with SMTP id q20-20020a1cf314000000b003fe201a4b7bmr4833122wmq.27.1692276762709;
        Thu, 17 Aug 2023 05:52:42 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c231000b003fe2bea77ccsm2930846wmo.5.2023.08.17.05.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:52:41 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next] devlink: add missing unregister linecard notification
Date: Thu, 17 Aug 2023 14:52:40 +0200
Message-ID: <20230817125240.2144794-1-jiri@resnulli.us>
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

Cited fixes commit introduced linecard notifications for register,
however it didn't add them for unregister. Fix that by adding them.

Fixes: c246f9b5fd61 ("devlink: add support to create line card and expose to user")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/leftover.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index c26c63275b0b..e7f76cc58533 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6630,6 +6630,7 @@ void devlink_notify_unregister(struct devlink *devlink)
 	struct devlink_param_item *param_item;
 	struct devlink_trap_item *trap_item;
 	struct devlink_port *devlink_port;
+	struct devlink_linecard *linecard;
 	struct devlink_rate *rate_node;
 	struct devlink_region *region;
 	unsigned long port_index;
@@ -6658,6 +6659,8 @@ void devlink_notify_unregister(struct devlink *devlink)
 
 	xa_for_each(&devlink->ports, port_index, devlink_port)
 		devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
+	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
 	devlink_notify(devlink, DEVLINK_CMD_DEL);
 }
 
-- 
2.41.0


