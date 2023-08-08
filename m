Return-Path: <netdev+bounces-25260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A537737AE
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 05:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D0C1C20D9B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 03:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D333FF9;
	Tue,  8 Aug 2023 03:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ED6F50F
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 03:21:51 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F471213C
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 20:21:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68706b39c4cso3596359b3a.2
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691464888; x=1692069688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=P/V9ljiS+RZV06sSAc2COBIOCp251sZvy3FmMZoG/OkNXoyMAnbNe24EKZNrbifKu0
         TMw9/bIBHlaHnzbtUtWzPHTqYsy2sFGtkRs+xt8vbZzsiS0x7Rc9mKFj2RktzhmElS+2
         SIeHhQhwHgkVPUcIXzdkakUQs/PkxTbSAUA2zU2DOYbE+GTmiLeGsM6DB34oY7IioJoX
         u8Jqfm2ETyE34gqRs7naQ2o/4eL8Sh9ZBIOH/9/XmQWQmnyKbBt5QKI6jrWVjEbTDSob
         NWueoCvGAVQgsnFEvyZJztfQr+58ypf9d4mbmvIy2JWUjfWc7DNBUg9/MfRu1XPR5mvw
         xldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464888; x=1692069688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=RyzVMWL4FOvG9l0Jbq/UMWHO4Fx3bcUpny1GOIIpevqkdHhCw6m7XqxHppg6imydQU
         ucRNKbZASeZeTirT/J/fJaBqfkavpP0tCjWn4sGA4HsaLzHNFihlko2TtkkEOxwECKMC
         PvQ8vSK7l68zYZVZQH/DIB2DpGwC+8rsuY7xrzvcwEWPCnpckz4A/ino6NcYWPinJ7mY
         YV1A/fIhjUQ3r58eZbhISy+IphsqPlMheumSrx2ZJ+AknlFS39B91gvLdMqHSLZ6Vq+2
         MH0IbcwWy8wuEAOi7biHB0dRQwrqReOIhrkHMY0WXFqavX7bHzF16XVj8Efh4C/I1TTo
         owSQ==
X-Gm-Message-State: AOJu0YytrtFwqfWwPjFZY9bae9h0+ESK03zmTs5/+7ZeNp/CeYWiitNE
	5AI9oKjB6IgNsLiwVl37JYcqfA==
X-Google-Smtp-Source: AGHT+IFOa9auvTw+52jDK1Q58QGt14PBhuKoWVXpCxAriS0oNTmVYC/tpubsf59++3sdyZXGMGacNA==
X-Received: by 2002:a05:6a20:9193:b0:140:d536:d424 with SMTP id v19-20020a056a20919300b00140d536d424mr6753584pzd.53.1691464887689;
        Mon, 07 Aug 2023 20:21:27 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001b896686c78sm7675800pli.66.2023.08.07.20.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 20:21:27 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: [RFC v3 Optimizing veth xsk performance 9/9] veth: add support for AF_XDP tx need_wakup feature
Date: Tue,  8 Aug 2023 11:19:13 +0800
Message-Id: <20230808031913.46965-10-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230808031913.46965-1-huangjie.albert@bytedance.com>
References: <20230808031913.46965-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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


