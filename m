Return-Path: <netdev+bounces-21999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B7765A1A
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 19:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A75D1C211E5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A227149;
	Thu, 27 Jul 2023 17:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8F2712E
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 17:22:34 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED14597
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:22:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so13632765e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690478551; x=1691083351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YntrG46n/7loKNtEmcaHWQJv9c3QOJS9xxFYrwJEtaM=;
        b=DtIAj9msSqVCysoCKcZoT+IGUPkzx/xSUijKEl7lVEna1+866qpm0RAEVj8LWjySTN
         ZxoPrmHJ0R6PyfOVs2z6/GBgC96dXJg76r4R6BVpMOoCvLFoPDSWegdFctoy6IqNjGGv
         tO9hrhRJ0A1wBiupF2ZUnmQ2HIGnRGaY7S4bIBeQVzRpiA6CRHMQo6FYFLwW4JHvYumE
         AX0wFRTQlMt16cmMK9HIAMTXGODvizceOVS1ExKB/zGl2i/mnZ+5JUgllUuQaeyZcYyG
         foU5R8VpXepHHfl2tdodJOeJg03KpAMG2o6Z8VDpP3x3v3Pp5/DBJBJksieXRGU25zGN
         ChKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478551; x=1691083351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YntrG46n/7loKNtEmcaHWQJv9c3QOJS9xxFYrwJEtaM=;
        b=KWy0d+hwEazsy57CbmS+/VN6AtL1DgEXUylTAGhVdeZcNEpy6tumlzD0rXPmdSvHMW
         D2XCVAk7bmqJJoOv8KUpsXLmtpDuRZIWHbsndbG+IoAzZ6+1xUTJH1uZjGDKgHTGEyXX
         UYCUhGEgg69rGBD4XaaTovSbdsYWbhVOauPDCJ4RvNyU8bSYlfadannL4S7FAYD9re/d
         qv17wEUtUWlyfioEYzkfPzHNj1/61p/jczfqhC4MUETNJr77PLVBln7MCZy6vLWXTZPa
         Ej957g0xwecMCY1wws0K/OrNN3luEsu99krVmmvd84HMIyQzPOHbfk/jbr03dZmiIvHx
         ft4A==
X-Gm-Message-State: ABy/qLYaCxIeLhBbENJc2yUeUXa5OyLn4x4VOOAM5qJqOChj1hOu8gCa
	rv4ymrEm9WzTpjHeeGuKujJ6eYQfrvI=
X-Google-Smtp-Source: APBJJlE9ndZ29s2V+flumcpGFqZYSDMEcy5jvvlEe2R621h1vCyshvEwc/nqAdnW0xtUoSa6vDCdoA==
X-Received: by 2002:a1c:e915:0:b0:3fc:92:73d6 with SMTP id q21-20020a1ce915000000b003fc009273d6mr2227868wmc.11.1690478550993;
        Thu, 27 Jul 2023 10:22:30 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d4b4a000000b003143ba62cf4sm2519242wrs.86.2023.07.27.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:22:30 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Nicolas Escande <nico.escande@gmail.com>
Subject: [iproute2] man: bridge: update bridge link show
Date: Thu, 27 Jul 2023 19:22:08 +0200
Message-ID: <20230727172208.2494176-1-nico.escande@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This adds the missing [ master DEVICE ] in the synopsis part and the detailed
usage/effects of [ dev DEV ] & [ master DEVICE ] int the detailed syntax part

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 man/man8/bridge.8 | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index e0552819..4e7371fc 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -66,7 +66,10 @@ bridge \- show / manipulate bridge addresses and devices
 .ti -8
 .BR "bridge link" " [ " show " ] [ "
 .B dev
-.IR DEV " ]"
+.IR DEV " ] ["
+.B master
+.IR DEVICE " ]"
+
 
 .ti -8
 .BR "bridge fdb" " { " add " | " append " | " del " | " replace " } "
@@ -661,9 +664,15 @@ display current time when using monitor option.
 
 .SS bridge link show - list ports configuration for all bridges.
 
-This command displays port configuration and flags for all bridges.
+This command displays ports configuration and flags for all bridges by default.
 
-To display port configuration and flags for a specific bridge, use the
+.TP
+.BI dev " DEV"
+only display the specific bridge port named DEV.
+
+.TP
+.BI master " DEVICE"
+only display ports of the bridge named DEVICE. This is quite similar to
 "ip link show master <bridge_device>" command.
 
 .SH bridge fdb - forwarding database management
-- 
2.41.0


