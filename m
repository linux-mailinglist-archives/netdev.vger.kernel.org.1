Return-Path: <netdev+bounces-18007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3CE754236
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86C3F1C214C6
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 18:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4015AC0;
	Fri, 14 Jul 2023 18:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9013715
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 18:06:28 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4731FEE;
	Fri, 14 Jul 2023 11:05:51 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b9b427b4fcso1305856a34.3;
        Fri, 14 Jul 2023 11:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357884; x=1691949884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRlDs3/HYDJcI/NBAEppRFw1YZC9wRoCz9bMRVEtyc4=;
        b=KtMpWpSH+s6EraMPkBRt6kA52HtS/3r0nKyYEQ0m84UNLwmYE5+chWQZX00Q/fTiqk
         TS+7E7SI3hES6LMhCBxMkcPmNwH3Ijo44yPKMCxptV4I36thxDxApLS0CPkfTReWA2OM
         qgEuvZVcGnl/YWA247pIQy74Gnj9WEbHTcAQ142U+B3ldVgg8y0mlN7YERRA0WMYMaA9
         hv//svaFnrKR4h9tHHyMWprOg5opU1N1ZO7s63vUzbqIkKCmPOHPsBV0L0rdrkA6Di34
         mdApQJxL7UlrM0/YF9cjuktIvFSQCI+OxyVJyE9b0cwr+3g1XWR3Bi5qdyLLPOQqz3xz
         LK4w==
X-Gm-Message-State: ABy/qLapwHLP8zNS2t2mwDI6WsHH+bvhatPk2KmLWxQdQSaBLNOXuOqk
	yYWFbDenmeg++KQ8xkcuygnWJBnYe8MH
X-Google-Smtp-Source: APBJJlGxOIA4WwbdLm9RRj0waQRZ79ZN7FIkzgiGSOzi4R8+zo2m0wQih2gIo6anhDDNozgf/q4QbA==
X-Received: by 2002:a92:d490:0:b0:347:7399:b170 with SMTP id p16-20020a92d490000000b003477399b170mr4262926ilg.32.1689356900357;
        Fri, 14 Jul 2023 10:48:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o9-20020a92c049000000b00345cce526cdsm2917031ilf.54.2023.07.14.10.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:48:19 -0700 (PDT)
Received: (nullmailer pid 4060842 invoked by uid 1000);
	Fri, 14 Jul 2023 17:48:00 -0000
From: Rob Herring <robh@kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] can: Explicitly include correct DT includes
Date: Fri, 14 Jul 2023 11:47:57 -0600
Message-Id: <20230714174757.4060748-1-robh@kernel.org>
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
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
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
 drivers/net/can/grcan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index 3174efdae271..6d3ba71a6a73 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -30,8 +30,9 @@
 #include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/can/dev.h>
+#include <linux/platform_device.h>
 #include <linux/spinlock.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 
 #include <linux/dma-mapping.h>
-- 
2.40.1


