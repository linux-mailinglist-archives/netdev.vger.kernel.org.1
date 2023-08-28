Return-Path: <netdev+bounces-30992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C593178A5A8
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C5280CFE
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 06:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DE33FC2;
	Mon, 28 Aug 2023 06:17:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582154A14
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 06:17:45 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B31B5
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so27606395e9.0
        for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1693203435; x=1693808235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54ao4xaeANf4rYkAGw85Jng+0pqwuC1IeOIbZUJzqJU=;
        b=qZ3g9K+Plok+xlxHrIYK7TaGLXRuz0wtG+uiv6fZ+WhVqUEvKm+isuROuj9Jfgyo6w
         7BuObD4866LOrqepiCJ5m7xP6+qQssAQJmXMexLxMuYj9Gv5gFI4iCsJBlrcJ7ZKL4yG
         eJA3xWo0OzLFqp/p7/jlu/+qv3EthWcsn1+cevwS4V8vkYS5zsk8mQyJXHDmmgrXLorl
         kPhbXGPvGRS79TS2erca2y7d6K06c1oSpoyFZnUMe6KPc+bxqLUcME9nf7MfmeqoUnQ6
         jyhGXUEG0UjMgb5H/7RqhY0/gWV34Jq5bVArYh2WKGM2H7sSZTh51IS94DDVI47AMlee
         z5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693203435; x=1693808235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54ao4xaeANf4rYkAGw85Jng+0pqwuC1IeOIbZUJzqJU=;
        b=kUaCOA3uhAqEP1hd8B7MKOvkeA7UX0GRIaP5ph2I/T8kl6cZvnHGYkYQJRjyUxEhDT
         b/9EVWX+IxPHHYoRYSv4Ax7Mi4G8SVbANtqJ9Xdfy2pX4ufXkyPUu6qQl7b3pJ8Jjyfc
         Gwna06Eqj7cQ0DJrw7tefm3atDQk15rEqc4rNa0Jxj18E7bm3K/EBbdSLp6Uh65tiDwY
         hYo1b7J6l2X56yVTHzvlsmyE7XYdrln4JeXfiLl56FTAk3N5Aeg5W8uekJaC5kiVwusT
         3dYRKtFB6dQkLrqN1qDLjjZVADjNtDLwJEx9mplqMNKDyH1penPzSLupz08R08/4B9Vo
         F1BQ==
X-Gm-Message-State: AOJu0YyRNMIzP730py3SR8QCepxzoZxYoPkeIBJDzFZ+SZCIU36ocLO2
	l0y0rMMPChB0zxl3ALJb8cUQ7rKKOirGwv2OVntozw==
X-Google-Smtp-Source: AGHT+IHg51srpQXNmq32UluirFTGStvCH+7VYfU5PoCcNeIlJRd6844Jt7JO9huWDhPFGR2XLhYMuQ==
X-Received: by 2002:a7b:cbcd:0:b0:3fb:fa9f:5292 with SMTP id n13-20020a7bcbcd000000b003fbfa9f5292mr18228855wmi.25.1693203435072;
        Sun, 27 Aug 2023 23:17:15 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b003fe1630a8f0sm12921388wmq.24.2023.08.27.23.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 23:17:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com
Subject: [patch net-next v2 09/15] devlink: use tracepoint_enabled() helper
Date: Mon, 28 Aug 2023 08:16:51 +0200
Message-ID: <20230828061657.300667-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828061657.300667-1-jiri@resnulli.us>
References: <20230828061657.300667-1-jiri@resnulli.us>
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

In preparation for the trap code move, use tracepoint_enabled() helper
instead of trace_devlink_trap_report_enabled() which would not be
defined in that scope.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/leftover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 6d31aaee8ce8..1db3a7928465 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -3131,7 +3131,7 @@ void devlink_trap_report(struct devlink *devlink, struct sk_buff *skb,
 	devlink_trap_stats_update(trap_item->stats, skb->len);
 	devlink_trap_stats_update(trap_item->group_item->stats, skb->len);
 
-	if (trace_devlink_trap_report_enabled()) {
+	if (tracepoint_enabled(devlink_trap_report)) {
 		struct devlink_trap_metadata metadata = {};
 
 		devlink_trap_report_metadata_set(&metadata, trap_item,
-- 
2.41.0


