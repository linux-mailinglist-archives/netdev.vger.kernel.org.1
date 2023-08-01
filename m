Return-Path: <netdev+bounces-23240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7D976B66A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC291281947
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152622F13;
	Tue,  1 Aug 2023 13:55:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5A111E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:55:02 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78079C3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:55:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585f254c41aso41725957b3.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 06:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690898100; x=1691502900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ce38lInC3y1CKhKvDL0FKNpZbXqllhZkxY6jIapoJY=;
        b=6mqAEu9nX2orFEFvybaIokonjWc5xzSZOLobyj91VAC4AUM4qjInyqiXHlXvQbfcS0
         HmnXKvwylXeSH+G8Vc9Nr8hcUVcskH8tPSx8XqZZ5g/Hms2BQg6jnug4dvkXoE+UKmGa
         yHls7i5Q8cWeozYSEhBHUUerBntlUKdhbJEfcN7ci5v599kARm8abajSCuAoTc5Hvtft
         SDu5MgmQ1Nyk/3BvJq2BsbpDEjBP/vF3P5cmqDItfxBVp2vZNbD5Kxcj0jkRmIEkjAHS
         Ta2vjuhmXystQE3ZsVTwWimMt3Uo8HBVCwfbz+A+3DWgMJGKmS9uUDpZmZ9jRiISl14e
         UGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690898100; x=1691502900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ce38lInC3y1CKhKvDL0FKNpZbXqllhZkxY6jIapoJY=;
        b=ZVKGPvYAeL7u0C/oI/khY/OsczI5svdWkJmXX4F+rk0DAccwpq5Xex0g1tKUCXiIk3
         Ju2a/C2KtCfFcWg+i0ZItUfJqNw78LmPPVqPzDzQdw5yUcVCSI1YLB17D//mjivw9hP1
         2pedh03j/xZM8d6ptD9gBbJCxsUzEFvTWegBliiVxewNIxwJ4jn3IemNAmwA/qaPJYkH
         xlXhU0UKrKBFhDmzgwC0IKU8FkYkZt6lxL6OEQwkaKUqB17pBThFaEiiXpqp4RxcEHiQ
         V0d+wHHBR8JH0tQ292rT2PPrccKdufUAdke9qzWkZEROF16kHd/yr3ZDTXJ+GMxVuCFI
         aCFQ==
X-Gm-Message-State: ABy/qLbhUmeilKnniq5cm2fyiybYu31ykBm47whU2tr7HffJeCgh6TQO
	NecFh9BbWzlffXlT5U+mXJQQxl1snxSChQ==
X-Google-Smtp-Source: APBJJlE5rvHNDMdbyPeYOhTHWACrv32m+BQi7inibBkmnI8yCBpSrZhFvfwLioKxc8Kl+UBLGZN9GNpoxUMw6g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:e80a:0:b0:560:d237:43dc with SMTP id
 a10-20020a81e80a000000b00560d23743dcmr100186ywm.3.1690898100787; Tue, 01 Aug
 2023 06:55:00 -0700 (PDT)
Date: Tue,  1 Aug 2023 13:54:53 +0000
In-Reply-To: <20230801135455.268935-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230801135455.268935-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801135455.268935-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] net: tun: change tun_alloc_skb() to allow bigger
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

tun_alloc_skb() is currently calling sock_alloc_send_pskb()
forcing order-0 page allocations.

Switch to PAGE_ALLOC_COSTLY_ORDER, to increase max allocation size by 8x.

Also add logic to increase the linear part if needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tahsin Erdogan <trdgn@amazon.com>
---
 drivers/net/tun.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d75456adc62ac82a4f9da10c50c48266c5a9a0c0..8a48431e8c5b3c6435079f84577435d8cac0eacf 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1526,8 +1526,10 @@ static struct sk_buff *tun_alloc_skb(struct tun_file *tfile,
 	if (prepad + len < PAGE_SIZE || !linear)
 		linear = len;
 
+	if (len - linear > MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
+		linear = len - MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER);
 	skb = sock_alloc_send_pskb(sk, prepad + linear, len - linear, noblock,
-				   &err, 0);
+				   &err, PAGE_ALLOC_COSTLY_ORDER);
 	if (!skb)
 		return ERR_PTR(err);
 
-- 
2.41.0.585.gd2178a4bd4-goog


