Return-Path: <netdev+bounces-26784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159FA778F1C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A67F2821FA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434711CB7;
	Fri, 11 Aug 2023 12:18:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A911CB3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 12:18:32 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C335A1
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 05:18:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc0d39b52cso12925875ad.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691756220; x=1692361020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7miTxeWiB87c+J9DmLF40wxK9wZOCYtAiwID2gSy8f8=;
        b=IWQ0/km4LqvT4CYXKO9bn6za95Gfop5yRTleF7cQAaMCDHHKJQkUUX1CymK6b1jNi+
         DBqVPzgzHsXzPGtybYe1SqxYJBrEOmx+4yfkm/PXIphxUY7zzwDQ5qX2CoFtenSBdlEz
         StD7gfQUqciV0ad0MvsETTDXMo5hamrUQByuAwPFJJSkNzzOPnLuDITK+C7YGoRu7XIh
         zJ12/hWYGjlpv0ZFOwgQVJTuIfczdIn7gKVvNafTaN6j/dYTchAv07o6LQ916hzBuWs1
         7v0/4xPM2zICPxXjBe/dsSn/cMTZOzF4JyI8ds38BrnQUZtGm15BGSqKTKUukENTvv/R
         nCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691756220; x=1692361020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7miTxeWiB87c+J9DmLF40wxK9wZOCYtAiwID2gSy8f8=;
        b=eQMVzpugZMgkue4ZlwhV/rs2P6no//D7e66qa2xOyl9nV1z8jYDQpDwpz2eqa3oYtG
         f3gVmNwjqQdJ7motl5NHDRLWWowzgMl1tsiKbUHTNsaS26xv4IEL623eABj716kdxucx
         5t7Yzq1L5Xt2KcJCpvr9oTjaZQc7sRheYGrWT918Cshg+gT0Xtpl9vLCr1P0vBksb6H+
         Br+43IwO17eJc5ivCPqfY/pyw4Zb1j6Tp50TrkdzrLYcPl0Li1jmYPuGmAq/jbiMaMku
         /b2GGadGXg5vj98wH3j6oN41g03fzKH715vtURYrbD15Ltb1zfVA0AbSXKXrwajEbLch
         F0fQ==
X-Gm-Message-State: AOJu0YzOYo6ytSynCNHU8iF+aKwBTYWUSpNnKeiZPUqh23UJSa0XeJLH
	ydyhKXf7EfH6humNl14l7qw=
X-Google-Smtp-Source: AGHT+IF/ZgGBIzxlQBASA45dCotZw0TDejTOF8x4p0Jm3NjeYfkGwyP3LKUqisUTnshInU2r4cXV8w==
X-Received: by 2002:a17:902:bcc4:b0:1bc:5bdd:1f38 with SMTP id o4-20020a170902bcc400b001bc5bdd1f38mr1134447pls.3.1691756220315;
        Fri, 11 Aug 2023 05:17:00 -0700 (PDT)
Received: from localhost.localdomain ([45.83.117.58])
        by smtp.googlemail.com with ESMTPSA id s18-20020a17090330d200b001bdbe6c86a9sm1021140plc.225.2023.08.11.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:16:58 -0700 (PDT)
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
Subject: [PATCH net-next] net: veth: Page pool creation error handling for existing pools only
Date: Fri, 11 Aug 2023 20:16:40 +0800
Message-Id: <20230811121640.13301-1-liangchen.linux@gmail.com>
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

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
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


