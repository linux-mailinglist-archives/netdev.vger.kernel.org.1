Return-Path: <netdev+bounces-44707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C357D94E9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB8D1C21059
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A61799B;
	Fri, 27 Oct 2023 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LqyN0vlM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D3B179B6
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:14:16 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A61ED7
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:14 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so2840641a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698401651; x=1699006451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8d5a3nShBIdHXY2ae+XSzbkdt1Sq3Zwcq9vEnxeuIQ=;
        b=LqyN0vlMjDlhBmRmZ3viiVud4sSVE656pmTZyBujla6cxUm3QYF1iYCUK4vn94NuUc
         7b1nMX8qsyb3uBG3aATNuT3ARNKuQAcwDJS1w3lWak6/AXzQLUxZ7FKAU+16yd0mYA5+
         dtw3T3I3J/6ACJmGse+DDk3p2AOWs8R0SVvQ/KuWhL+XhpMpJcCfwEipJGxuGxs+waBX
         bOgc8QYLnXGVMdDhEjSS+CBRRAYeULLVZ72oNPge6hknCqNxDYojCSgTN9g/Wwboh27y
         odf4Zjf6Y0Oz/ToTxmaDyZ3a34gPiM6OtuyOi391PEaOeD373D2PImuA921h7MQqZien
         2KUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401651; x=1699006451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8d5a3nShBIdHXY2ae+XSzbkdt1Sq3Zwcq9vEnxeuIQ=;
        b=oHY6skusL1dp1BWDPBTlI156PsQ1HLvxtAEdVfAc43foJ0xB3GJ6drhrEzHiLs/IpJ
         qJ0aK4K+Kd0gn49LzcXFA7YbzHSJ5HyiAvdWONmzz5YGf19ajFfvQ0vuHXVtrBj3N4OA
         EpycCNe1TCRJ00GU9adjvJYdMv1J4xmKNxXQViBFANMgLBxhuFhCujH4aPeNK9lY7xb/
         y/UaGltjmTzyAb/MPQOKYBkV05O6ghaSX+raMz4Lc4XhEY/iX+2IwtgiERHk2exLjg1k
         pjHfCV0B83YbuetCI8BqOoO+f5hflv1TS2xUmxMe7jlO9MSk0QKKAUA8paMenws6qqD3
         EtVQ==
X-Gm-Message-State: AOJu0Yx40wfEPUi213aoPiMmZLBaLgW0WjsBy9zWYZtJHNKlMfPrgoOL
	3xJdO2tnXYauO6iWK0vVu+bHQJqLBOGfPxRHfWMfPw==
X-Google-Smtp-Source: AGHT+IFEIUGVPt9VM851+vExAKRYJBOaE+v/JCZlot4aRvbwQatVejtU2QuS3RKutEZ53N9R+3YMRw==
X-Received: by 2002:a17:907:ea2:b0:9b2:abda:2543 with SMTP id ho34-20020a1709070ea200b009b2abda2543mr1913553ejc.65.1698401651444;
        Fri, 27 Oct 2023 03:14:11 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id rv4-20020a17090710c400b009b9a1714524sm979155ejb.12.2023.10.27.03.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:14:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	daniel.machon@microchip.com
Subject: [patch net-next v4 3/7] devlink: do conditional new line print in pr_out_port_handle_end()
Date: Fri, 27 Oct 2023 12:13:59 +0200
Message-ID: <20231027101403.958745-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027101403.958745-1-jiri@resnulli.us>
References: <20231027101403.958745-1-jiri@resnulli.us>
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


