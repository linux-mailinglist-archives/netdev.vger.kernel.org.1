Return-Path: <netdev+bounces-30344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33744786F37
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B282815D0
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 12:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD26193B6;
	Thu, 24 Aug 2023 12:32:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED36193B3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 12:32:12 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B31BC1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 05:31:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c09673b006so18920405ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880316; x=1693485116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5uNBFRKdGGDZRAKFO4JFxe+e5Mi3BpGgv08ttLAbB4=;
        b=MfWOOqqbCDLkbWxtg0uR/wjfD1QNMniZeu5eEyRFyxlwvzt2bTF3KxkBIBgy9M1u7K
         d39zSduODTKcuaBEMzYdc4XPCqQK7QT4JdEE9cNxZRZIxEtpzhpbAOprOuZOzVO50ZOh
         7gYweWhFINLztb+AIWwt8Zej1twioBVOaKAY7gNAzIXCNX/E9SkK5GxSO4ACddgxL8nw
         OKrXv28uY2q1D+lnxNf2jPY0eZpWOghZMQ4hydpvhtMoLzdydg3cw2Ffqs85WYQFTWop
         u38F/U23EDn48pBpn4WcLFGItFC8X+xpoyoI7FhAibw5MisxV8pOqJu9JrEh4P6OkcqK
         vKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880316; x=1693485116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5uNBFRKdGGDZRAKFO4JFxe+e5Mi3BpGgv08ttLAbB4=;
        b=ElPep022dQpHkmD55A2WWKjcbOxjzV6wXVfVJkB1vaN2/FXa04ynDY9BMxN/YAQEjf
         DZcK1s02RKf9Wi7x7Y1JmcdLO01munqv6GefDwhuFsSnhGxI2tLGlvfLlbXoCz4p/mOU
         Ykk4i4k8UkhJVIIy2fc1TDI6oEl3tHwGkB+kR3jsC4MdDWSVTPBBpJlLQdi1nwATunTk
         w23BAmKYLQXiyDCtvvNgRP/xuIp1lIPIYpzmd1w9KMclIY3SdiM7jMf5uMPVV5kBeOsG
         aAFyLbkqpIHX/AVjcUMeiN+eq13HO0rjDfEGdf3NTQYOWbrFPDkWdGGYscyjEJGGrqK2
         SqjQ==
X-Gm-Message-State: AOJu0YzTmcuwOEwt7P+d9tyxpp0n7xdK641DQRIuedL+UJl/jYpC0riU
	W1OhXJG/b4YEhtKNe1IU4Qk=
X-Google-Smtp-Source: AGHT+IFLodXAn4fo+KxTYnA1dWhTGiqBCoTsgJ4vBtKPqTmRhigm/L4PLBVAHLX7iHgel1c6D+1bSQ==
X-Received: by 2002:a17:902:f684:b0:1bc:25ed:374 with SMTP id l4-20020a170902f68400b001bc25ed0374mr15475900plg.49.1692880316605;
        Thu, 24 Aug 2023 05:31:56 -0700 (PDT)
Received: from localhost.localdomain ([50.7.159.34])
        by smtp.googlemail.com with ESMTPSA id h9-20020a170902748900b001bf11cf2e21sm12601467pll.210.2023.08.24.05.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 05:31:55 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [PATCH net-next] veth: Avoid NAPI scheduling on failed SKB forwarding
Date: Thu, 24 Aug 2023 20:31:31 +0800
Message-Id: <20230824123131.7673-1-liangchen.linux@gmail.com>
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

When an skb fails to be forwarded to the peer(e.g., skb data buffer
length exceeds MTU), it will not be added to the peer's receive queue.
Therefore, we should schedule the peer's NAPI poll function only when
skb forwarding is successful to avoid unnecessary overhead.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/veth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..e163c6927f56 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -373,14 +373,13 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
 		if (!use_napi)
 			dev_lstats_add(dev, length);
+		else
+			__veth_xdp_flush(rq);
 	} else {
 drop:
 		atomic64_inc(&priv->dropped);
 	}
 
-	if (use_napi)
-		__veth_xdp_flush(rq);
-
 	rcu_read_unlock();
 
 	return NETDEV_TX_OK;
-- 
2.40.1


