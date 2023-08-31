Return-Path: <netdev+bounces-31568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074D378ECD1
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 14:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3851B1C20A6A
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC68111BB;
	Thu, 31 Aug 2023 12:12:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD999470
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 12:12:10 +0000 (UTC)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83631CFE
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 05:12:09 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34dec9c77d4so2605305ab.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 05:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693483929; x=1694088729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZp1XQd7vaipu6rzlZK+a0HfApCTruStBRPAzdQPAnE=;
        b=QwqEWDjGTE9pbh9/9DlE5RRj83eGb9ypq2UOUYwWqu3OVmuXGyYTJ51bwGaEDK7Xfb
         jGTA8r6X7s+V6etd41fcJuXR0u5nJKHGBTEwGMJE6WCI1736XJadubqcr1yPP1B+df5l
         aY5QuSI+yFuWuHoEcBS3fj1LkbJAZoi+Cl+9mX+JvGSg2CxFoLrzpZahthPadYSo/wgT
         j8ML+JdSdlBDDy+u8uHJuTOqMq74qPLz0cb1jeyJ/PNZT7Q3I8MVYQTwaQFl68y2jFHD
         rU5vkqa6tsx/Er/OYrJYXyMQh0Yr6iOzCbb1kESHj5LWjO1KJmb7UABS20IGYqc95sPL
         Hecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693483929; x=1694088729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZp1XQd7vaipu6rzlZK+a0HfApCTruStBRPAzdQPAnE=;
        b=MwnzCrzL4I9C9sPLKdeWqWGJ9SwE8xetsBMJz5Z6hV/cEO0I9Ee6DNh5MDlc9ZIhlK
         TVpQu9W5PzvGO3DPgjDoXnCWrBdKICyrOJka+2K3tMuAGFvO2z8vLOLh9beRGuMBmD2E
         MgYmBqz4K+R/EMo0MQRH/bgdfgveU9pMrRNCGFMszBnlwfFbmcJ4/45D/LptTUFpiL4a
         UQNhejbruIhijK6xmC9p8KsjI+bNA0cJD9ku15E3YxNSLQP2vs6KEZg02ocYInoYkMo3
         yMP+nxcsAqeih/5ZZ7Cv4aV9pt36oPuSNVCr5B/0W+goePMiwlh5bhSWa1ba1SBFq2US
         JK1g==
X-Gm-Message-State: AOJu0Yxk3B6jVGE1JyL0oDGMnz0Dl3F84T2dJ/41RXOI2I0PikbyBg9b
	um7bnqw1jrzrG6v4Qr2m6Jo=
X-Google-Smtp-Source: AGHT+IHK3d3hmR+QT4nH862ycktv+Mt2Ap2vjupQ3wpjV7ImI8RPgjbdq+gagt/NLSh/jDPNF6S8lQ==
X-Received: by 2002:a05:6e02:ed2:b0:34c:b23a:85f3 with SMTP id i18-20020a056e020ed200b0034cb23a85f3mr5117794ilk.12.1693483928835;
        Thu, 31 Aug 2023 05:12:08 -0700 (PDT)
Received: from localhost.localdomain ([124.64.4.91])
        by smtp.googlemail.com with ESMTPSA id i16-20020a633c50000000b005701110ca06sm1275578pgn.5.2023.08.31.05.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 05:12:07 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next v2] veth: Fixing transmit return status for dropped packets
Date: Thu, 31 Aug 2023 20:11:52 +0800
Message-Id: <20230831121152.7264-1-liangchen.linux@gmail.com>
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

The veth_xmit function returns NETDEV_TX_OK even when packets are dropped.
This behavior leads to incorrect calculations of statistics counts, as
well as things like txq->trans_start updates.

Fixes: e314dbdc1c0d ("[NET]: Virtual ethernet device driver.")
Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 Changes from v1:
- add Fixes tag
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


