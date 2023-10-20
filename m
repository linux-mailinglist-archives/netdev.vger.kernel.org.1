Return-Path: <netdev+bounces-42934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4677D0B77
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19822824A5
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65512E64;
	Fri, 20 Oct 2023 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qEvdJR55"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB54912E4D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:21:43 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D95610E0
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso90475766b.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697793684; x=1698398484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0EVjenb227G/wMt3EtTBLsgc7qzbhgk6YY5pWJ6hrg=;
        b=qEvdJR55zOLoHl4bxTrvQyzGrPkEUJ6h3z685INoHyHuHtl+inCZyUsdblaTA7ipPY
         bfcgYCzMW84GshZeFTg9fBWzr8IaOAjgaJ7O+5J+yf8Dldn+dAQy0xyRp2R/gxrJmhaY
         ju2IPEnAPnFcf6CGvBZdPX0HhA2J4OrFB6b3mFTO2zyXvWUByX5zEE2c37ZXvdF5Maip
         T48neYlJGpTJJLknAdJmfotYM70uj18n/prvnGLKopuzRNzryS36jJSVk2e1ujlujAmR
         NlLY2kxN9J94q1mPcF62uIx4mRvVF3n5QhdF5IUtYeQpsgGwrPe0acRqFks7wt8A0r90
         O5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793684; x=1698398484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0EVjenb227G/wMt3EtTBLsgc7qzbhgk6YY5pWJ6hrg=;
        b=FcbQU0dEazYjsPO7NyBIRsFAro8ZMsTnH0ehePxZwUzmugRF+q150ioTYNHWwSCRqu
         SECrEga+Fk0XhIMSxKBwwPWFV8f8NuRBMjrrVLT3p1qCcXinoqqZ/A9IHgpbUqMSRR+Y
         TY1jxAYPKnyeo6vj0JJpeE9cNUiOfcoeXCpYy1weFLUFCliLNImZexf6BWdmvi1lV53U
         4X+wzWXfsTvkvm01/jKrxe+KKQuCRI6HqDoiAndoOgPKBKGe5C/lDW7U+jgX07A6p4T0
         soSBOhXZ7bKk6qMwsfbklNDD+oqLinAAl30OJe3nlZ92WDXk5N+uu3FCIMsK2mHaFEDW
         l3LQ==
X-Gm-Message-State: AOJu0YzfUvLSpOphaY2UFsVkr4pKNsPCDwhS5nsDlga3wqXa8Bp4u6IK
	G4Bod2Rm6AqE8Q6GjaWzSD8eVBSNxR0kNwgUFPc=
X-Google-Smtp-Source: AGHT+IFSMIVv5WxaKS9RxcBdNknKqzziv6r7d14N//7yeRKxHCvG68xhYfNiH020FiHsU59xo7gXFw==
X-Received: by 2002:a17:907:60d5:b0:9bf:c6a2:d3d8 with SMTP id hv21-20020a17090760d500b009bfc6a2d3d8mr852081ejc.29.1697793684396;
        Fri, 20 Oct 2023 02:21:24 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x9-20020a170906b08900b0099ce188be7fsm1102983ejy.3.2023.10.20.02.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:21:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v2 03/10] tools: ynl-gen: render rsp_parse() helpers if cmd has only dump op
Date: Fri, 20 Oct 2023 11:21:10 +0200
Message-ID: <20231020092117.622431-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020092117.622431-1-jiri@resnulli.us>
References: <20231020092117.622431-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Due to the check in RenderInfo class constructor, type_consistent
flag is set to False to avoid rendering the same response parsing
helper for do and dump ops. However, in case there is no do, the helper
needs to be rendered for dump op. So split check to achieve that.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 tools/net/ynl/ynl-gen-c.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index d72079e316e9..bb8b27481bf2 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1109,10 +1109,13 @@ class RenderInfo:
 
         # 'do' and 'dump' response parsing is identical
         self.type_consistent = True
-        if op_mode != 'do' and 'dump' in op and 'do' in op:
-            if ('reply' in op['do']) != ('reply' in op["dump"]):
-                self.type_consistent = False
-            elif 'reply' in op['do'] and op["do"]["reply"] != op["dump"]["reply"]:
+        if op_mode != 'do' and 'dump' in op:
+            if 'do' in op:
+                if ('reply' in op['do']) != ('reply' in op["dump"]):
+                    self.type_consistent = False
+                elif 'reply' in op['do'] and op["do"]["reply"] != op["dump"]["reply"]:
+                    self.type_consistent = False
+            else:
                 self.type_consistent = False
 
         self.attr_set = attr_set
-- 
2.41.0


