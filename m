Return-Path: <netdev+bounces-18005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE6A754163
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 19:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2402F28225B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D454156EE;
	Fri, 14 Jul 2023 17:52:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AF14A83
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 17:52:29 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622F035B3;
	Fri, 14 Jul 2023 10:51:59 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-78625caa702so86594139f.1;
        Fri, 14 Jul 2023 10:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689356998; x=1691948998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEIKeE5pM9zn9D8Srf35AY3/pDLGKpItW+k06EDlZ4c=;
        b=T+glcA/GY2in6tncWfqRwgewx+njuySKLH4W/3brlllKqRKpl4oN8siRhvtlbHky9T
         xoQJCcaYRmqJ52iDvSz7rqMEL05L8AasBVietGVMwEbPi6qOa961SzhZ/CVIGWV7jKtv
         dF3XYBMtFGB9PLS5g2vqw6saaqtHMZT7rPuZP/60nHW4XTHpc0ui6SixthLwjbjdUilg
         eUkXwqFO7HvPIX1RmxW3Eno0KipOaBBxAYqb7EB7ub/r37M8q7+ug5l5827qYI1uPaGk
         CN/cKpkpveLwKvKogIJt4EKFIvF3MCPVncqtbtTVI5WARCkxt12ZyD7bjzLpMi8ZIFoj
         I41A==
X-Gm-Message-State: ABy/qLYVawoLV4jRHHGINCr3dQRUs6FzT1MKtR+Oqf+gh4pWDe1/Cwoc
	9vcDqwigf4WlG6tcRQSGTg==
X-Google-Smtp-Source: APBJJlF8MQmWVa6E2TnegdqPcO3I1VDTQ1vLGqnfLDaaes0YHjMlxxjcIMvwXsd2XFLbvrUUN/Wh3Q==
X-Received: by 2002:a6b:5b08:0:b0:787:1990:d2ec with SMTP id v8-20020a6b5b08000000b007871990d2ecmr5563567ioh.12.1689356998520;
        Fri, 14 Jul 2023 10:49:58 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x25-20020a6bda19000000b00786dffc04e2sm2772310iob.25.2023.07.14.10.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:49:57 -0700 (PDT)
Received: (nullmailer pid 4063275 invoked by uid 1000);
	Fri, 14 Jul 2023 17:49:27 -0000
From: Rob Herring <robh@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>, Yangbo Lu <yangbo.lu@nxp.com>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ptp: Explicitly include correct DT includes
Date: Fri, 14 Jul 2023 11:49:22 -0600
Message-Id: <20230714174922.4063153-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/ptp/ptp_qoriq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 350154e4c2b5..a52859d024f0 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -12,7 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/timex.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
-- 
2.40.1


