Return-Path: <netdev+bounces-24502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B052177064F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 18:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990401C218F2
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCA618051;
	Fri,  4 Aug 2023 16:50:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42E1802C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 16:50:10 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673C198B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 09:50:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso21759495e9.2
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691167805; x=1691772605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtU8XnAEFpgf8e/8MnlqZfMos0l1wcmZywNA3fJoJ9g=;
        b=hosBZgetjw7IbkEHkOA93E2Q8FUxGKMDmZaSVMOjd+xy0Vo3G6m/PrqaV4GgzOZlXj
         0jCVRhT+g3tZ/W8jPcF6rlywDJEzi2wS1VS2H9ZidhG0gxrnqkpRBOaXgCBadGhVjsxh
         K9gP57yFeyUhQdyALqFgUEplvvXoK1G+KklFVu/tFBoGqPPRiz26DuLq8U8x5sBWeEuU
         R+yweJ35QjDMLaTBmct+CzJ1SPnTXy1YX+BrBO+BtwwSzkDW7JZE/QTkwHL/3Qmvb0eq
         YAW+y/8LGOwviaHG8a2Xh0yiz0Gp2RzEkWvlSa6rAs72GuYNT09xdtY0fhI1ZCnFhmp0
         Oj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691167805; x=1691772605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtU8XnAEFpgf8e/8MnlqZfMos0l1wcmZywNA3fJoJ9g=;
        b=j01B5L2SlLhDxFGFHlMDx0ao13ZEKa8Taw9vvP4q8oUpEx8GBaTq1kHCFOZOzRc1fv
         d/8jsFPWtwfa6+RZaEJm6bXco8Z7jqxTw8JmCUywMf6SgXJMyKjiJaaGIIaWlqvLbnl5
         A/xLWEqBOcgluabjhOmhhHxVN41VzRvC4Gb3JhK7btGvok3TZA/oSOqCuiBLacS0HbT0
         BcobRwQFRXgFuzJHbPbwfIqXzbUyfx6a/ZLjgAeqnNb9MXjv6uFUMj7PXuuhg7tMmfjR
         DncWCNveIxYan4xVENYNw21woEYpwF34YzXqkhAhe/Tpp/C5oWHknokRqT+oGnT6YErY
         fdHQ==
X-Gm-Message-State: AOJu0YzyB8ZMhpbg96G50/oBbcdDmRGLnj3FomVjvJ88qWAwodulXih2
	6bx8gOzmianAfSYxmps3dqOHpD56Dno=
X-Google-Smtp-Source: AGHT+IHlGcO8GGu9EfcUuuK7xUu6RZSQycWz277X1oZauAId16hQyz934eoHWNyNvqGWvL+t+iqjYQ==
X-Received: by 2002:a05:600c:b47:b0:3fe:2011:a7ce with SMTP id k7-20020a05600c0b4700b003fe2011a7cemr1829407wmr.6.1691167804552;
        Fri, 04 Aug 2023 09:50:04 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id z25-20020a7bc7d9000000b003fbaade0735sm7173252wmk.19.2023.08.04.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:50:04 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	idosch@idosch.org,
	Nicolas Escande <nico.escande@gmail.com>
Subject: [iproute2,v2] man: bridge: update bridge link show
Date: Fri,  4 Aug 2023 18:49:52 +0200
Message-ID: <20230804164952.2649270-1-nico.escande@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add missing man page documentation for bridge link show features added in
13a5d8fcb41b (bridge: link: allow filtering on bridge name) and
64108901b737 (bridge: Add support for setting bridge port attributes)

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 man/man8/bridge.8 | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
index e0552819..5bf14bab 100644
--- a/man/man8/bridge.8
+++ b/man/man8/bridge.8
@@ -66,7 +66,9 @@ bridge \- show / manipulate bridge addresses and devices
 .ti -8
 .BR "bridge link" " [ " show " ] [ "
 .B dev
-.IR DEV " ]"
+.IR DEV " ] ["
+.B master
+.IR DEVICE " ]"
 
 .ti -8
 .BR "bridge fdb" " { " add " | " append " | " del " | " replace " } "
@@ -661,9 +663,15 @@ display current time when using monitor option.
 
 .SS bridge link show - list ports configuration for all bridges.
 
-This command displays port configuration and flags for all bridges.
+This command displays ports configuration and flags for all bridges by default.
+
+.TP
+.BI dev " DEV"
+only display the specific bridge port named DEV.
 
-To display port configuration and flags for a specific bridge, use the
+.TP
+.BI master " DEVICE"
+only display ports of the bridge named DEVICE. This is similar to
 "ip link show master <bridge_device>" command.
 
 .SH bridge fdb - forwarding database management
-- 
2.41.0


