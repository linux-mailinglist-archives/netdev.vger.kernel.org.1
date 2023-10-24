Return-Path: <netdev+bounces-43797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A6D7D4D39
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5773C2818F2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDAF2510C;
	Tue, 24 Oct 2023 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="azrISm/C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0D7250EE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:04:11 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B328BDC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso645660866b.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698141849; x=1698746649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccMtuO+zt1fMw+Gu4Yh5qATQ62lLyHlYSWuS8GbJO90=;
        b=azrISm/CGPrsg1ucr1XaPrMKe8lSnixQrp6YOCI5E5ZHwg4TAn9jlCY93ccBI1/+jj
         4MT4M5KoRpytaNJKo+6qNAfLjuEga8f5i9LCiMannmDLEeNydsZMK9I1H/TvDWXlDKMR
         QQXqmzkbcx3yHtspsOF85pIKyZbkguHn+xsbVkf+IZxNTyOvU4RdLa0N+hejYMV51riW
         Op//XjMTx5N+CnJPnSh5ON8iZ8nDIGlL+pZ33VZhCnRwJbHrpdufEE4hlX7vIzS2ZFHV
         Ei1P/IOdd2GsDsY2xnezB1g6chHKucDPaeTkWLp0Uvf89MqWct9HgHf9DQQ/+InqdXmy
         7pRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141849; x=1698746649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccMtuO+zt1fMw+Gu4Yh5qATQ62lLyHlYSWuS8GbJO90=;
        b=Q2NH0FU1cHgEKqDzgRdkBsgwqnv0QjyiUep8EP17H5OAuxzv0Fwm3sujNTtWRR+j1e
         ZFLmRED6BvnZ7dQ5jHyPjJ69BTRvria9t/GboWSvFDg/zWwDEtrsGONWtRe50/r9Og/v
         r95wORgEvvJhH9xu8OCY8TPbAobWjOMGZI0jibCKtAO09quQGcylcmaI3UdKQOpNSzfO
         ak6FLfLUrr0JzOyya8CvBa2I/+SiUmuGdnatx0iw894Og1BTKdo5mx9MlctNX7nPweRw
         x0aZ6f67+eACVhboIYtJWGGZ0nBiO3Y4OvGwzvUgYgR8YVWHJ9KV3/LjNM9DhW4dhE+o
         /X4g==
X-Gm-Message-State: AOJu0Yz9c+lpWyG9/irdvtRmZntx+y1IK0oDnzlEr8MjfXxpk5Bc2765
	GZ6IOzIINd92o+UgALEyVsS1f7u87TiRc9Qhm212Ig==
X-Google-Smtp-Source: AGHT+IHKZM6mU6cYOLPZ5N6AjcvwrCtcU1Tnl2Dc0yBF2jXZ1RjlkXEZg1l8lrfUAxZmLBemXki4uQ==
X-Received: by 2002:a17:907:970c:b0:9a5:a0c6:9e8e with SMTP id jg12-20020a170907970c00b009a5a0c69e8emr9639512ejc.31.1698141849039;
        Tue, 24 Oct 2023 03:04:09 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id fx4-20020a170906b74400b009b9a1714524sm8118186ejb.12.2023.10.24.03.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:04:08 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v3 2/6] devlink: do conditional new line print in pr_out_port_handle_end()
Date: Tue, 24 Oct 2023 12:03:59 +0200
Message-ID: <20231024100403.762862-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024100403.762862-1-jiri@resnulli.us>
References: <20231024100403.762862-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of printing out new line unconditionally, use __pr_out_newline()
to print it only when needed avoiding double prints.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 3baad355759e..c18a4a4fbc5a 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2974,7 +2974,7 @@ static void pr_out_port_handle_end(struct dl *dl)
 	if (dl->json_output)
 		close_json_object();
 	else
-		pr_out("\n");
+		__pr_out_newline();
 }
 
 static void pr_out_region_chunk_start(struct dl *dl, uint64_t addr)
-- 
2.41.0


