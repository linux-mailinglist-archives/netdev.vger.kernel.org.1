Return-Path: <netdev+bounces-23061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67C76A8D8
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA32E28135B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D588C4A11;
	Tue,  1 Aug 2023 06:19:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF5EA3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:19:59 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2941729
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:19:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686f090316dso3505111b3a.2
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690870798; x=1691475598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyMOIwWMdG1+g+6Z4Ry9QONKdbjBXirobly89D2UzW4=;
        b=JHiy8zfmMGA2n6b+uN4qROLFQgj343/TQ1ZzhqLa64ghdPF4qee1SuMTJtceRvFy8/
         LsnIE7epdTi85y9QvzM58j/7gxLnHpJDINoOrCne37InCIgEN6Zgkybi5Z0q03lnGFso
         Ibwz3xWOomlR8qrsleqmy7Vhp23xodyNBPbFdOIEFRaMKp1DvWmJzK8kSzXXB5J5uPpZ
         cG9bROdprjVXfFR9KOXY54+6Q9/KnHznwd6QdHRr5SY3+jbxk0XvVka6lVV0BNGnE8LU
         aniMR/DLXy/RBryK/ZsUf96ExWEXIbKxzPN3oUcTCpFQorhuyY4SHi3waRFsPCj8Nqxz
         nWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690870798; x=1691475598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyMOIwWMdG1+g+6Z4Ry9QONKdbjBXirobly89D2UzW4=;
        b=Y7W2zKBU9vZro6UGtYkzxg02C1m9MlHmrN25lj9OARTbTcCMQMgvCbrKNvmEBa56wB
         3ShW072rV2ZR9HECda2SQvSMQLShin4WIeIjmiZD2YxDRKFpV89vhceXBbtfl6yE0IHU
         /G6MlDmPT5WIwhWPReecg8a6xzZssvhgI4gZeit2Ls3xfbfLuRY1fxNexJxekNAyDuVn
         NObubXLTBy0uOSXz1kxDU/d/bCrcxWjGglybeZEgjDWFSj3i2UqPar4bJ9oX5pUkttYC
         BsKWxkBR+WoL68BGe8qIvXJENp8XyI9Dg4sn9TyM4RIgVqEQ6c3VIfEMRpERSN0ONEfM
         uDig==
X-Gm-Message-State: ABy/qLb0Oyh2ouMtR6MqsotaZyt0RC4aB+cvbkTsCw4+Hao4Cfo9NFuJ
	5gHTSwVhpYsIdjF5hUCMgD4=
X-Google-Smtp-Source: APBJJlHNuPn63IQDN4hAhgBh+XoocQvX9RBUId5vGvf+xqJvnTw937SuJ1Z0Mb/lehSrsROQYmasTQ==
X-Received: by 2002:a05:6a20:3942:b0:13d:af0e:4edb with SMTP id r2-20020a056a20394200b0013daf0e4edbmr5674105pzg.62.1690870797806;
        Mon, 31 Jul 2023 23:19:57 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:400:7b06:9c8e:d68e:629d:2c7d])
        by smtp.googlemail.com with ESMTPSA id 17-20020aa79211000000b0066a31111cc5sm8512735pfo.152.2023.07.31.23.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 23:19:56 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linyunsheng@huawei.com
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [RFC PATCH net-next v2 1/2] net: veth: Page pool creation error handling for existing pools only
Date: Tue,  1 Aug 2023 14:19:31 +0800
Message-Id: <20230801061932.10335-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
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


