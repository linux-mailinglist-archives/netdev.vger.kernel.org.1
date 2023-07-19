Return-Path: <netdev+bounces-18878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DD1758F09
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3D02816A1
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C4C2EF;
	Wed, 19 Jul 2023 07:30:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56317FF
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:30:07 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE1C2115
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:29:50 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so362981a12.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689751790; x=1692343790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyMOIwWMdG1+g+6Z4Ry9QONKdbjBXirobly89D2UzW4=;
        b=CSyvn31khKjT0FBgxTR+sp2rqzXZh6FDPgbbG1aIauQYYE3H7iurLS0kXJWnrTT981
         c84kPjcC7yLeSunjA7r75V9fSpGi/PpIjB8qszfygwsz4/9QfUikhW+4+xsim64QURsd
         ZwVKwIVeJBlHfiWwUDQ6fL/XbwcdUoR8WLvf+pNkbrugtH2iO2fHqFWQovUNadFvLHxY
         NU3drlwomR8loBBSkU5YzIudC7BKzQ8GOySXKRDr4cTdyMFiJGCeQRddtHFryrfO+Ky7
         cttZaxC0r+aDqu5EsjGspTQSEvpzswOfe7lGP6DgQnaJRBVvRbCzXXmWvsRN91WnCeAu
         dRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689751790; x=1692343790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyMOIwWMdG1+g+6Z4Ry9QONKdbjBXirobly89D2UzW4=;
        b=S0FxoKAMfkd0SWwDiPDB4uwNKEXK9f2q9Qz5oDD/NVh4EykkWpiPfJRnSi+Lao1peK
         1q4FuOJbM7VJX6YxkmcdjWCx4j5/0synX3+tqAHRgLbkwmowoeYvzexzxe8uYIA+7O5E
         QVjb1yHSnwKjsO4jEWwOUszf9+zIQ+Z/t+5s4OfRjcicVHnr/t06PioYKJ8RtOd8200v
         Osxfz+RaITHJ4MN/Fpx9o6J/A9v/ooajuntEybCM+HdfRgfNE2gsL5JsMZ9YWeixHIKg
         CEceLAzZScDvQ/RmKT9xUpkyPZFGUU94SgkFiZGYIFgBfkgzP5LLC2FRXGtdZO/3WgeI
         q6FA==
X-Gm-Message-State: ABy/qLbBMd9LMGvqO90615Fb6KUAEkUVE7oE44f0WY5iekpBYMrbSZqF
	jJbmp4DVwwk0zYvclXd91BuKWpmhBFcauw==
X-Google-Smtp-Source: APBJJlFPCsEOPFNHiODbwTTQ8Ow43rk0dxTIugZdbOQSJ3QkciTyjpWZytNFvRaQY3rBnUTBg4aItQ==
X-Received: by 2002:a17:90a:98c:b0:263:f674:490e with SMTP id 12-20020a17090a098c00b00263f674490emr1841496pjo.3.1689751790195;
        Wed, 19 Jul 2023 00:29:50 -0700 (PDT)
Received: from 192.168.0.123 ([123.120.23.36])
        by smtp.googlemail.com with ESMTPSA id b17-20020a17090a8c9100b00264044cca0fsm4287092pjo.1.2023.07.19.00.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:29:48 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	linyunsheng@huawei.com,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [RFC PATCH net-next 1/2] net: veth: Page pool creation error handling for existing pools only
Date: Wed, 19 Jul 2023 15:29:06 +0800
Message-Id: <20230719072907.100948-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.40.1
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

The failure handling procedure destroys page pools for all queues,
including those that haven't had their page pool created yet. this patch
introduces necessary adjustments to prevent potential risks and
inconsistency with the error handling behavior.

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


