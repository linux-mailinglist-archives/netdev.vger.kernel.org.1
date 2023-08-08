Return-Path: <netdev+bounces-25444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E2773FED
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED7E281060
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BF113FED;
	Tue,  8 Aug 2023 16:56:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E601B7C3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:56:31 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D46B53522
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:56:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so40223755e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691513777; x=1692118577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRSD7cZcMc8pHUT2rH1b4BXyP/pZfwzfe/AEglATwv0=;
        b=NJJhs25z1tw756uGmX+ZR6lXt+U26JxEzr0YGdJgbIixO2QcjtWzuPybxmRnVryV9v
         l73Q819OmB/1S++UFHQdHK2+HEIyCr2M3QpUkYrV6iK49oXFmB81XZqousxcpjHkl42B
         +o9VNkYv4sjB3JANIkzl9gsdgElQbOXpTZk9RGjiMOJSJQvZ9Znz7F8HQTSNFzE2RHa5
         +l9mWylkdHBPGgyoJXs2Vd1RlnwA5ygSnaElSY5dJbrfhTq7UctoacANo9P+maS87Bvv
         ShpncWExWxaxIiZa39WULVuihQZcDYGC71MUJYD9nNdCGQYdxg/blA4fexqleiLe8RED
         926A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513777; x=1692118577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRSD7cZcMc8pHUT2rH1b4BXyP/pZfwzfe/AEglATwv0=;
        b=gYrMdLvFSyXKEaqX9ZeGmaJDeCnF8Kf4OblJKAly8nRMvDiZMBn+gvJ2VCfP0MGfKN
         zz/LW8CKNEoixALDfv+skoL4DFSQFj4vcOOjGZeD2VYl6iM5sVVl+6qNA5GkbSuE0gMT
         5v4o0OM5pd1X2M6RQvkml5olsjK2aVwcPMbPjlMtpsbU+m0nhiX8PdkWkcwLaM1sWBeZ
         BLuZlPNE7esi5M4T1UOZu/w/HcSG7nVH/DynUOFcMkhWPdaFg9jfzCDZWyXAtMd2QP2d
         twyPCt48cXVNZ6R5u6ckXHCl/ILjkW4gh8HPeuWcerfF5HI248YKG608lDYMfHJLSWbJ
         0ibw==
X-Gm-Message-State: AOJu0YzV4U8i3iz4O0uvdiTxZTaWKpRe97tNw6YKYhVsQUN4vD5wWwAT
	E8Ou0uj+e08yJBOHTcj1xxvFBfS6LqS6UVsRM88RCmNe
X-Google-Smtp-Source: AGHT+IGsZaSYcdqfGRReDLUAitKzMiMRJjed9aPzsM0UC/JAt78mhCxdFUS12U3VTN18XZrmDvUljg==
X-Received: by 2002:a05:6000:189:b0:317:5168:c21f with SMTP id p9-20020a056000018900b003175168c21fmr8363553wrx.31.1691482824263;
        Tue, 08 Aug 2023 01:20:24 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4c89000000b00317f3fd21b7sm2690776wrs.80.2023.08.08.01.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:20:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next] devlink: clear flag on port register error path
Date: Tue,  8 Aug 2023 10:20:20 +0200
Message-ID: <20230808082020.1363497-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

When xarray insertion fails, clear the flag.

Fixes: 47b438cc2725 ("net: devlink: convert port_list into xarray")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/leftover.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 0a9b49dfeb61..5568992a1a90 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6840,8 +6840,10 @@ int devl_port_register_with_ops(struct devlink *devlink,
 	spin_lock_init(&devlink_port->type_lock);
 	INIT_LIST_HEAD(&devlink_port->reporter_list);
 	err = xa_insert(&devlink->ports, port_index, devlink_port, GFP_KERNEL);
-	if (err)
+	if (err) {
+		devlink_port->registered = false;
 		return err;
+	}
 
 	INIT_DELAYED_WORK(&devlink_port->type_warn_dw, &devlink_port_type_warn);
 	devlink_port_type_warn_schedule(devlink_port);
-- 
2.41.0


