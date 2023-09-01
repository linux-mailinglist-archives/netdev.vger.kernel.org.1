Return-Path: <netdev+bounces-31671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB3C78F79F
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 06:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37BB1C20B43
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6A1FA9;
	Fri,  1 Sep 2023 04:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B11C3E
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 04:10:32 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A572E4C
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 21:10:30 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c0c6d4d650so12685985ad.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 21:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693541430; x=1694146230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5wwpWGTogrpbOxepev52y4pUEprQ78vBdMjPkvFbiHw=;
        b=K+cblS1h9ISJbByi8+Sf+l8bqJdQ3sh+owDtjOySfLiTW4UgQzkztjN3LjFylqJMJ1
         r8gpUhHmlU6McUmqSjnT/pSqml/YFWO8mSfG5zvsBQ237aNttP6D55YdRbauzljItDuk
         214bCGWjmGIGAQUkPtQDeDnqdnOozfN15E6lwP66NRDcNPdQqWA6DLxTPUh/0Pz4tCsv
         qvXAHkkaMQBuqGfTX2dRMRb0aDXjWVhP0QZKxRxTC74D6JgDS4Zbs2XuVqwj1lsyWyVh
         G/w0YWCaavmqmg1m9Hx+UsXKdsJrGc5FVzcDakW5XVWqz9TdLYfuxiN1WHnNwMTFgr0r
         ktdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693541430; x=1694146230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wwpWGTogrpbOxepev52y4pUEprQ78vBdMjPkvFbiHw=;
        b=BR1BEdYcOAW6bwPTxrdTClqUGAImFzxJovx2Lb+vcUgOf33eOvLigHlajt7v9WX22s
         CuT1NghmNWolFmpwf/RjoOwxTdYxGCctEBQ0QYU4fB/T9GbFn7i3qqQQLXS7Tp3h6BUm
         U7jSKxAI7QH/Rb6hmODZRld9mNA178lh+PQ/HWCkOXwcZ6IL4QvB2UZYtIw2gM97/uh/
         nudAOPWOz+EIE1qpCMLHe/si+ZfQ3pXAeaFYzMvCr6GUDe7l55iM9lIagrUnBUStHHb3
         4FX9zuh1Kw2wgVS3oNpSlEZmZkIr+ZOsLFHTKOvSt8aeAIOwpu6vF1Y0p0ldB0ss5rJ/
         BUzg==
X-Gm-Message-State: AOJu0YymLK54+vbb6UzNUBmEwaQ6nZmhH5Prv3z9ALgAjfEOVbLEPYMm
	Y+0eGpBZZyfMeUDlJxfsAp8=
X-Google-Smtp-Source: AGHT+IG5Ous+YfgsZ4P/DKjKEOCLwaC7O2sQPT6wEI8YLE1+l/OTobLzUIMLXePZWnqv5fuonSG+TQ==
X-Received: by 2002:a17:903:26ce:b0:1b8:4f93:b210 with SMTP id jg14-20020a17090326ce00b001b84f93b210mr1338672plb.45.1693541429773;
        Thu, 31 Aug 2023 21:10:29 -0700 (PDT)
Received: from localhost.localdomain ([50.7.159.34])
        by smtp.googlemail.com with ESMTPSA id d1-20020a170903230100b001bb99e188fcsm1966393plh.194.2023.08.31.21.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 21:10:28 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net v3] veth: Fixing transmit return status for dropped packets
Date: Fri,  1 Sep 2023 12:09:21 +0800
Message-Id: <20230901040921.13645-1-liangchen.linux@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The veth_xmit function returns NETDEV_TX_OK even when packets are dropped.
This behavior leads to incorrect calculations of statistics counts, as
well as things like txq->trans_start updates.

Fixes: e314dbdc1c0d ("[NET]: Virtual ethernet device driver.")
Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 Changes from v2:
- as a fix, targeting 'net' tree instead of 'net-next'
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


