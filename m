Return-Path: <netdev+bounces-31528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F19778E913
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7D928142A
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38498473;
	Thu, 31 Aug 2023 09:06:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E86FCB
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:06:41 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F3BCE6
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:06:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68a3e943762so470919b3a.1
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693472800; x=1694077600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lB0hyRUCpeaVTJ0O2x1VOVOnZsBq1Pgv26u29UVmMRE=;
        b=qIlfTgzB2sPqs39Miwu5yVXdxJsfux3FlLxME0aUJPI5v0PEQU+/+XolQvnnlIRlBL
         uYugDAW2EwtLs7PmgQFEqOWf+Gey33w0tlHZQQBlJ6QPcGOyjI484c37dkV90hPlqolG
         +AtoWtb+nleK6Mu3TQkR9yBt3m4XcQQoBYGpD5fXxzZoohz6c0Hjv6kNwnBXfx9XlqK+
         c/JL5kpDBWY7Vm46Zs4SsTsbZhhW2mXKG/KPRxWTZTjC0T6c9FllzNjUdJ7W38KhVM1U
         t94v4WBMF08SWJ821TVwqMool38G/UivaFdJMfLZWGzeo3lhcVMuKY5WCn9YMeW0kVI/
         JQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693472800; x=1694077600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lB0hyRUCpeaVTJ0O2x1VOVOnZsBq1Pgv26u29UVmMRE=;
        b=VD609jqtLcqiGEQc+FyHGup95E5Zz9APxhEdUvkcOqgGq5uiQDE8GZnNhUL1oqmSqK
         lPdSnMIWZrlkpT/QGabKwmiB8GAieGnkkfNW4AffTDaYkmokTL7UKqcwZqfJ8tpLpEGj
         RF0N1vI7pj4fUlLeN9Mt/xjTwRy7I6T72uZzWykQPgKSZK4S+hQ3+U8OwvBnsw4A14+t
         qGjUyYBPVw+/nJhJUUMgqrgRYGVs4CGTFkjkcnBsuaWuWcsFUS62WklXIQnfuX5Jml3G
         Qx3G6ZDiLWAAlAgbuEq+k6zm1fslT9C8jgNM3a7JzofIq/x3deeAGa7LFdAhM4XMf4hc
         C9Zw==
X-Gm-Message-State: AOJu0YyY+2Z/smLxy8wWOao3XqXKbpjqp5oFvNfAM5Uk8XSHpDppE/L7
	B+ub0eJyq8u3KqR0uUh42tPOLbFTTpPBhw==
X-Google-Smtp-Source: AGHT+IHjpwBX15jzGtOyGYNqF6g72Pf2ocWzbYXnOg3fOhID9zVmGa8FzyVuiUjdtMcVfhByu/TpnQ==
X-Received: by 2002:a05:6a20:6a1a:b0:133:be9d:a9e6 with SMTP id p26-20020a056a206a1a00b00133be9da9e6mr5768805pzk.17.1693472799991;
        Thu, 31 Aug 2023 02:06:39 -0700 (PDT)
Received: from localhost.localdomain ([103.10.86.235])
        by smtp.googlemail.com with ESMTPSA id v25-20020aa78099000000b0068b1149ea4dsm879022pff.69.2023.08.31.02.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:06:37 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next] veth: Fixing transmit return status for dropped packets
Date: Thu, 31 Aug 2023 17:05:25 +0800
Message-Id: <20230831090525.17742-1-liangchen.linux@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The veth_xmit function returns NETDEV_TX_OK even when packets are dropped.
This behavior leads to incorrect calculations of statistics counts, as
well as things like txq->trans_start updates.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/veth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index d43e62ebc2fc..9c6f4f83f22b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -344,6 +344,7 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
 	struct veth_rq *rq = NULL;
+	int ret = NETDEV_TX_OK;
 	struct net_device *rcv;
 	int length = skb->len;
 	bool use_napi = false;
@@ -378,11 +379,12 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 drop:
 		atomic64_inc(&priv->dropped);
+		ret = NET_XMIT_DROP;
 	}
 
 	rcu_read_unlock();
 
-	return NETDEV_TX_OK;
+	return ret;
 }
 
 static u64 veth_stats_tx(struct net_device *dev, u64 *packets, u64 *bytes)
-- 
2.39.3


