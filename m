Return-Path: <netdev+bounces-26997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477A779C9B
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 04:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDF71C20BA2
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC40620;
	Sat, 12 Aug 2023 02:30:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1E8C01
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:30:31 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3D5122
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 19:30:30 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso1944785a12.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691807430; x=1692412230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBXCtfDXFWZw+/3JgJyBDCXsXd0tBYouwp9JIGW5dXc=;
        b=XWBCdyvGxcAQM26/SsB3ioiJmUHCxh6T0hxbuuRMcxRCETbvGNbhjCQoe3qJUkPHdV
         OwwuzAkExdpt4gNyAFaDcWxao2AWCuGuWNiQSWUqtIbEPSn3fTopRagGmgQmBZSL3WoU
         gIM70riRm5iButtJ8wqKuWqMhGnZhsQiKOtBH+k4Op2Ghs/Ttq74PWUklSiFw3fRWbeK
         Y35ErCyPukefu3S0ds3sPG6O/bY81ny44JnPMBY3wXZsbjH1ndE4wFzR6Ak1Is0c6tur
         9fPDhzOV852sJhAXTPCAXnXIRXh8vuxgiQYhxCbuxrz9RrzyR3hdVniLdDSqp9gTrL8q
         G3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691807430; x=1692412230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBXCtfDXFWZw+/3JgJyBDCXsXd0tBYouwp9JIGW5dXc=;
        b=hoAzEAtFuVzcYUoRSCCPc/+1vQ51+6tsFKODoM9Bv4HpjQIYvleLnrHcrlkHbxuz/z
         iGWXuplMPVZ9CR0UnzsjJslLfuTvUdx10bFmeRM3SyRVEF8vMF+nU1dU6E/lAA1Sfg4e
         3n+inpzkDPTNCLfYCsy/r8AJHQQ53jW4NScLKn3ukuBaEfR1cStL1oOAHROjgm+twLYK
         sICh9sCwGJd+t+vKmkJuJRDFXTX+X44wBxT8N84tc1vMbEEuYUZLpWvhw6eub8rUksNv
         MQVv531yO6UUH1ZJV5HRv/jKuJ2rghoYui6NFo9oM/f3f1KF9bolIJnrRsnCTA4BYyRl
         XZjA==
X-Gm-Message-State: AOJu0YwcASe62LBsX2M1iCf/MSXYVUTIsPtEOn8zOsHEN2GaZxqtpxar
	gSvLTSGtLblu/WLOsXWjtRk=
X-Google-Smtp-Source: AGHT+IE3/Mwx9pJExJiEOz7yGHA/4zVkIetxv0C73ONqMWZUiaNk0Gos3EzwnEgfGINUbtuhSUqVyQ==
X-Received: by 2002:a17:90b:1244:b0:269:14eb:653a with SMTP id gx4-20020a17090b124400b0026914eb653amr3119829pjb.4.1691807429979;
        Fri, 11 Aug 2023 19:30:29 -0700 (PDT)
Received: from localhost.localdomain ([103.125.234.210])
        by smtp.googlemail.com with ESMTPSA id 88-20020a17090a09e100b0026b3cb294a9sm347359pjo.1.2023.08.11.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 19:30:28 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: hawk@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linyunsheng@huawei.com
Cc: ilias.apalodimas@linaro.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v2] net: veth: Page pool creation error handling for existing pools only
Date: Sat, 12 Aug 2023 10:30:16 +0800
Message-Id: <20230812023016.10553-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The failure handling procedure destroys page pools for all queues,
including those that haven't had their page pool created yet. this patch
introduces necessary adjustments to prevent potential risks and
inconsistency with the error handling behavior.

Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
Changes from v1:
- add fixes tag
---
 drivers/net/veth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..509e901da41d 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1081,8 +1081,9 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 err_xdp_ring:
 	for (i--; i >= start; i--)
 		ptr_ring_cleanup(&priv->rq[i].xdp_ring, veth_ptr_free);
+	i = end;
 err_page_pool:
-	for (i = start; i < end; i++) {
+	for (i--; i >= start; i--) {
 		page_pool_destroy(priv->rq[i].page_pool);
 		priv->rq[i].page_pool = NULL;
 	}
-- 
2.40.1


