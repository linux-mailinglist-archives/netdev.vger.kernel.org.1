Return-Path: <netdev+bounces-23678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD9C76D1B8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EE5281B9A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F09C8FD;
	Wed,  2 Aug 2023 15:21:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EFC8F8
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:15 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4B2D7D
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so46774545e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989630; x=1691594430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6dEKsVObuwCBVkuwQ2aMV2dMYfNJE9+/kM8MgMaO1A=;
        b=ryuUf2UWyFt1x//0z9wkh7gSYXbVtc1QrLB6a+V0tPdQpaF8CvlDCXNeNbN/CqdGr5
         IALFkZFPt+ThzdRa2oGDy7WuNjsFxqLYilBxYNM8YO41obwYd5p7XUtsLRqETroNDRTd
         6r0U2VJMqszMa6D6iML+M5U/1BZK+pfrzxvT+N9H22At8lljGcG2GWd9VaxKzQXlszte
         waxgHD902xC+AciUWRj73JNnM8UHQ46mA+dkqmGoxkfwXeVpUcMMka0FSGLD2eFc6DBm
         UM32y7e8TKPi988qEbY77j3KJksh/IVV4HcRyb/g+szNla3fO6riVtCX6I2Vby6gJ/xk
         yiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989630; x=1691594430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6dEKsVObuwCBVkuwQ2aMV2dMYfNJE9+/kM8MgMaO1A=;
        b=E1/gvSpj4eYxw2F5uyuIYZBk3VoIVN6l6ABY/44g2abDv5XlbZLEhWF1wZjSAFe3Ei
         BQi6MBJVzPjd/m1vhlfkK3wzJLDPd3L9wLF2L3wj1P1prS6BtM15vC0BowcsVI7QVp/U
         90wUcjkEY9lRzrh6yW8FDIKWbthYxXAAdIyr9Dg9v0h2rUZ7LCisFlh1CBYYVQ99PEm6
         Z9i+IYauzi1hOitdoJFeuKL4lsRqryyEYqY+LkdM+gEmTHpoircRpF/wTcRmFUKORzOC
         gxhnt3oi1tVTWwDMqIxVGW0ZpTWP6kPKZrMlo8vOddwWvpeoCCqFxJ5JN1L+8EnE2OW+
         KKCg==
X-Gm-Message-State: ABy/qLZRKfI6qSoy6o61+WRDaIZp7EDqiSfYGSraNh+R6ZnRYRqC5nNv
	rGLsSnmtw7Am3RLSp5XhiCVfP2eOgG6M+R3wjWKSrA==
X-Google-Smtp-Source: APBJJlFMUaRdH9hF62yeF7ofYdEXrOvvXe2UC5pa8saBWNPQTpvOU4dP0lFKCcZ/3NbbjJX2t+iduQ==
X-Received: by 2002:a5d:50d0:0:b0:314:3c84:4da2 with SMTP id f16-20020a5d50d0000000b003143c844da2mr5315090wrt.13.1690989630692;
        Wed, 02 Aug 2023 08:20:30 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d524e000000b0030fd03e3d25sm19312441wrc.75.2023.08.02.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:30 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v2 03/11] ynl-gen-c.py: allow directional model for kernel mode
Date: Wed,  2 Aug 2023 17:20:15 +0200
Message-ID: <20230802152023.941837-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802152023.941837-1-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Directional model limitation is only applicable for uapi mode.
For kernel mode, the code is generated correctly using right cmd values
for do/dump requests. Lift the limitation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- re-phrased the patch description
---
 tools/net/ynl/ynl-gen-c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index a3f70ca929fb..34ee7b8e3f71 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2317,7 +2317,7 @@ def main():
         return
 
     supported_models = ['unified']
-    if args.mode == 'user':
+    if args.mode in  ['user', 'kernel']:
         supported_models += ['directional']
     if parsed.msg_id_model not in supported_models:
         print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
-- 
2.41.0


