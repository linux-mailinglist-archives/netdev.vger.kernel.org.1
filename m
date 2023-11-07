Return-Path: <netdev+bounces-46372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0AB7E364E
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60B4280F88
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14806D30A;
	Tue,  7 Nov 2023 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w9Yc1WFC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FADF6B
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:06:16 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A0EA
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 00:06:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso12516316a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 00:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699344373; x=1699949173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8d5a3nShBIdHXY2ae+XSzbkdt1Sq3Zwcq9vEnxeuIQ=;
        b=w9Yc1WFC1/Xo/yWtHbJcdHYZQrEvwGB8FWhkZzcYzFWomp/pmuAS2h1PKn+loD9+Du
         mPyNsDcQNYGlUmkP0i3BIHN5nK1kukg1/5wcuSaH/wbPKG3vNQMHdN5qn53zpDm40n5F
         adTmMX6u9S2QLkxXle8cG3p9oJscQD46HX7IDUt8wtcIfvl5EZhvQc1ZbfGCvApNX7yh
         uNfzXaXCDilSokD2TgExUKM2aLEutf1v1NcP4xvYpeGY3c31v0M6KRfpHGAb5hm1qtcG
         PJ9fevIgfhDKFbe61gGqsvC6LCHmf5VypqxeOCy9duRn0kqPP5ROrtx+CjJIOUamuH2f
         qmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344373; x=1699949173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8d5a3nShBIdHXY2ae+XSzbkdt1Sq3Zwcq9vEnxeuIQ=;
        b=Ngay7en3R5X66gi0W74eoGcaRoJMldBih223Y5osZrXPFwxuTHhtrYhnFAGpTz3FeM
         XTcLLjFY+JoTuGVZ+MbaoH/+xZy1J01SeTi13ADS3Qe8DaHSKcnAkFmZmSRhJSJViFxJ
         WFWUFuLTeY4dloaPC4TN+1exOc1RDDgFbWk40RTuDP5Mzhtuiwu/+qlF44rC0w9ydFAx
         +OC3ops2tCewiFtRhOtD8/4xxAOO15CD6fWLc0l+4Flmdm2s5NU0bavgBpwPIWyTNNo4
         CFXD1orrS64kIO26OmKjIeW1UTcTpO+lVYPv32O6sGwSoVuyid4mgwctFdB95Xt/RUnB
         ZT3g==
X-Gm-Message-State: AOJu0YwfYefVVAdaLht2lXFrLEE8AAi46j6Arn5K040YXo6MwMsYhqlK
	LfKk568esCn9dboP+4EvJUgQnC9gLuV2aukqzeQ=
X-Google-Smtp-Source: AGHT+IHuATefY1MJtu6lHyPDOGGCh4qWEeePNQgnL9bpPGsICpQ4p6MLTGDFOVcP1l/37yv0cmDfvQ==
X-Received: by 2002:aa7:cfd3:0:b0:53e:1207:5b69 with SMTP id r19-20020aa7cfd3000000b0053e12075b69mr1632369edy.10.1699344373131;
        Tue, 07 Nov 2023 00:06:13 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id d19-20020a056402001300b005402a0c9784sm5054940edu.40.2023.11.07.00.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:06:12 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch iproute2-next v5 3/7] devlink: do conditional new line print in pr_out_port_handle_end()
Date: Tue,  7 Nov 2023 09:06:03 +0100
Message-ID: <20231107080607.190414-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107080607.190414-1-jiri@resnulli.us>
References: <20231107080607.190414-1-jiri@resnulli.us>
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
index b711e92caaba..90f6f8ff90e2 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2976,7 +2976,7 @@ static void pr_out_port_handle_end(struct dl *dl)
 	if (dl->json_output)
 		close_json_object();
 	else
-		pr_out("\n");
+		__pr_out_newline();
 }
 
 static void pr_out_region_chunk_start(struct dl *dl, uint64_t addr)
-- 
2.41.0


