Return-Path: <netdev+bounces-24946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111387723E4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423171C20B71
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7D2101ED;
	Mon,  7 Aug 2023 12:26:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193D101CE
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:26:50 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3439C130
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 05:26:49 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc34b32785so28046895ad.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 05:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691411208; x=1692016008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=dngqcxXkDTjUguZrMGIXCZRSIUUg9AZAyokTIPWxIrcInPtG7Oom8LrZYQCNQfAxfM
         HfuxYkkNZ92dsmzFnU31gFlDgQ0QnbwdGfT9Es48c0ImSHzs/d0j7HH9+TEWMgk9Tr8i
         iKjXU4rtNS7XpURqDZLWy7NBO1O1V8h1eQ4pgieMGX4/yDGfQz7qyaIZ49ua5sPJbjxy
         4LJtbYzALFrjnewrODhYVDl5AMUkle2pxD9GEFBQSPMvXnNEY61rNykWv5GjFEcfUFLo
         KiPxWohvcAjtUDfEA2/xHi2IoyZpyJZzi3/kisTUicQ9gqTEhWgVrhSUXP1Mt7ljP3Qm
         6Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411208; x=1692016008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=Cw01MU/rdwFqkOp1WfPpr46DBmzg2SvqW1EJFjxOTUH3ClPIlKmpqvXfilqL1DHWQa
         VEaM7ygcJy0eO6XQAIX7aNozrKshhs5BQbIet2YxL1MkpVxn0KOsb3Mr+vzk9uGxCyrc
         FYVixy484NVWokl0iZKXjkM5LKow4EYMkcjTAQJyga9Qneq/Whzsf7jgrHInWkzUpYdc
         ls4JaGSvvA7KWW1ZnSgDf2QyGnUKCNRPOj5SHDCtLkbb761NbMcfSxKQgi/OE4o2K7zZ
         ShpxJSsM9GNMr9u3HVQdZjbhOAy3fGSfUtSG/JxaBDRJ6FMTpfi79XDOm0t1P9T61xxJ
         TLtQ==
X-Gm-Message-State: AOJu0Yx842FwWj72kgofLytafTlGbVads9QO383PsRXfMSNnPhr12wk9
	PqVTPGAO0TnOx/hi9yF0S9TnZg==
X-Google-Smtp-Source: AGHT+IE0UTxZOMHvSuq9wsKJiCX3RPP6CxfzwfTLYdpnBG8UJD0b3bu3kQMZ6+Be3716D2hcPya8Yg==
X-Received: by 2002:a17:903:1cb:b0:1b8:2ba0:c9c0 with SMTP id e11-20020a17090301cb00b001b82ba0c9c0mr8983752plh.59.1691411208720;
        Mon, 07 Aug 2023 05:26:48 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902768300b001b8a3dd5a4asm6792670pll.283.2023.08.07.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:26:48 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: 
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 Optimizing veth xsk performance 9/9] veth: add support for AF_XDP tx need_wakup feature
Date: Mon,  7 Aug 2023 20:26:40 +0800
Message-Id: <20230807122641.85940-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

this patch only support for tx need_wakup feature.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 70489d017b51..7c60c64ef10b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1447,9 +1447,9 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 
 	memset(&tuple, 0, sizeof(tuple));
 
-	/* set xsk wake up flag, to do: where to disable */
+	/* clear xsk wake up flag */
 	if (xsk_uses_need_wakeup(xsk_pool))
-		xsk_set_tx_need_wakeup(xsk_pool);
+		xsk_clear_tx_need_wakeup(xsk_pool);
 
 	while (budget-- > 0) {
 		unsigned int truesize = 0;
@@ -1539,12 +1539,15 @@ static int veth_poll_tx(struct napi_struct *napi, int budget)
 	if (pool)
 		done  = veth_xsk_tx_xmit(sq, pool, budget);
 
-	rcu_read_unlock();
-
 	if (done < budget) {
+		/* set xsk wake up flag */
+		if (xsk_uses_need_wakeup(pool))
+			xsk_set_tx_need_wakeup(pool);
+
 		/* if done < budget, the tx ring is no buffer */
 		napi_complete_done(napi, done);
 	}
+	rcu_read_unlock();
 
 	return done;
 }
-- 
2.20.1


