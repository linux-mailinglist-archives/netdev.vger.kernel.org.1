Return-Path: <netdev+bounces-23242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C22D76B670
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE891C20F42
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327623BCE;
	Tue,  1 Aug 2023 13:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E7D111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:55:06 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C951EC3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:55:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d13e11bb9ecso6213636276.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 06:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690898104; x=1691502904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fKWDhaneLtOE++Bs6lXFJLB9aWVQ1lnzdiH+IUuQ60=;
        b=7Jkqhp2TizX7v2DdyAxmUoYOXTV+Tp2oHovdz4261nWfAAGvoBV1sIikyz2hZS+bN6
         59DPoUHDor6b5Jkq2jCV16MbwPbAmqd6NYZKK1aSDON143f0Lx2DvjGusRNeQ22KR4kg
         Dt1MvAygoYPX/6vA0lTdlerMb92IIQ3XS1mMv5V3HdK1PvNMYwy1UbhzPnm/C96qC7SF
         db6MOzlGTblxfx4xK46NrmazwL2EMKBQcI1EpIVahjldPsKHY6365RkyXZxfyp+i+v10
         O6A9PkaAvScE3wJy7GKSq92eGvDQV2C9qPAVm2l7xaPxcus/qF1s+3dDTJ97T+YRzfPo
         kHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898104; x=1691502904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fKWDhaneLtOE++Bs6lXFJLB9aWVQ1lnzdiH+IUuQ60=;
        b=caRU+qEQeCoypGg2vi0+pFtpLptF1hsK4gM/q2qH023GXiM5PrDJtdirFrYjdRMYWi
         LVmawMvW12iyLpCGmBlQuovcWt8dpfrfo97YonNCWCrCuwHNFPLX1vX6TEovjKYqq34Z
         U8q0VRW4n6Ke23pNVaaAPqaOslRX+5n25F+vMDOUMCibJQ5YHvuABkaAz0WtQ5eKOhaQ
         q6g8seR7eBhWnrWA8S5icMsP67CfgDUwF4MUGMtVglrv+FKDMaxhgVrc1e2HpziTDqOy
         2G5JrRtMZXB0shcL9ACSwNgEfmCmgK5szr46nTRH2mCipcIMhr/o9bxorR16QmmsKWat
         54hA==
X-Gm-Message-State: ABy/qLZyEP4lU5ZO6sCik6cOZVCzRXurI3uGPd23uVEky9JGTDTvr6FR
	g9wkoDMKc73dvVD72qp0GHKpqZjJGo6mZw==
X-Google-Smtp-Source: APBJJlGfJ7QVFQP8c25zt84j4+BQuOJQo3zL3I0cYF3o2fo6DSKOkW5e4OdBzNlhWTNNsepdq6MPBJbVCDcYJw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:564:b0:d0f:a0a6:8e87 with SMTP
 id a4-20020a056902056400b00d0fa0a68e87mr73193ybt.2.1690898104141; Tue, 01 Aug
 2023 06:55:04 -0700 (PDT)
Date: Tue,  1 Aug 2023 13:54:55 +0000
In-Reply-To: <20230801135455.268935-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230801135455.268935-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801135455.268935-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net: tap: change tap_alloc_skb() to allow bigger
 paged allocations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Tahsin Erdogan <trdgn@amazon.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tap_alloc_skb() is currently calling sock_alloc_send_pskb()
forcing order-0 page allocations.

Switch to PAGE_ALLOC_COSTLY_ORDER, to increase max size by 8x.

Also add logic to increase the linear part if needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tahsin Erdogan <trdgn@amazon.com>
---
 drivers/net/tap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 9137fb8c1c420a792211cb70105144e8c2d73bc9..01574b9d410f0d9bfadbddf748d194e003d9da2f 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -614,8 +614,10 @@ static inline struct sk_buff *tap_alloc_skb(struct sock *sk, size_t prepad,
 	if (prepad + len < PAGE_SIZE || !linear)
 		linear = len;
 
+	if (len - linear > MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		linear = len - MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER);
 	skb = sock_alloc_send_pskb(sk, prepad + linear, len - linear, noblock,
-				   err, 0);
+				   err, PAGE_ALLOC_COSTLY_ORDER);
 	if (!skb)
 		return NULL;
 
-- 
2.41.0.585.gd2178a4bd4-goog


