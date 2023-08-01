Return-Path: <netdev+bounces-23419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9576BED2
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62BD1C210A4
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B886D26B0E;
	Tue,  1 Aug 2023 20:53:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5734DC77
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:53:01 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE711BFD
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:53:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d061f324d64so6309203276.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690923179; x=1691527979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ce38lInC3y1CKhKvDL0FKNpZbXqllhZkxY6jIapoJY=;
        b=CAHrGqbLmdI9vj5+8/AIqWEKkFAxW+otBD2LoVE4fZTCHxZRUWvK5ScX0KHbzBUwKh
         n21PFvzIxmEyv+Mj7/BKNPFCLO0U9LJVI0GLMX4Bs73FGcJHRLcdhC4tjS0pM5/F+6FM
         HXqZXobrYCkw35beyu9Engjw0vBbp5vRzqDxbJODVOtLgNmEGztt9Q6AfBaPEwXS7tIC
         4BblGzgcLXIJ2JH8jgLMU7Z5oEYrbAI/8ny8rJEG/6zYNks2irYGLVLR8X4dIFixhmTH
         RKthZbPOESgIYFQEInotddhEX4N/mrL/Z+zXYyiKzta3jp7A9+U4/nL0/Il9WSSRgKGN
         kSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923179; x=1691527979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ce38lInC3y1CKhKvDL0FKNpZbXqllhZkxY6jIapoJY=;
        b=WAwyEsf/moN42DIeMGLVFtMXkVAkzdj+IkYWQvRLZR1EISM51GgPo3IJwbM8BGcoZr
         CXN326XwVSfVn1wnR6s9CwDXBvNrz4p4Sut2EPF53342fLyiet6h34cx7QfmeGGbFuYn
         8v3DOVeiMBUGrOq+pa/zkFC3mTgCqAl7YaD6pFiKksftl4k5/M1ZsXuy6KCGQk1syIbk
         XvS2ZhSRXQrg8QFG1mENfPnQBHpa9x1elGeu8lMULSaSx6lgqyaph80UzezIo29kI6xA
         tC5eh+YIQMmnByg+L40VakbkCPwnsJdWEn0nVNv9qr7XF7EAGtDxmGnfux4oppMmlSQ7
         d3Sw==
X-Gm-Message-State: ABy/qLY5Lipw2PPhFzJ6nrxyfZ0hppBiAQP7C2ZxP6Pfki0913Beh2rp
	oUUnljbU3Uzs6rV4q6zOMqBdanQe6pqrCQ==
X-Google-Smtp-Source: APBJJlG7bxzIDzzhCKcdtytTxOJLIE8cRqR8tpaeR2GWg5P7TenDsfRkTQ8mYcepSSY/cxHBxvjSch2ZrIVdhQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c712:0:b0:d0c:1f08:5fef with SMTP id
 w18-20020a25c712000000b00d0c1f085fefmr84222ybe.12.1690923179814; Tue, 01 Aug
 2023 13:52:59 -0700 (PDT)
Date: Tue,  1 Aug 2023 20:52:52 +0000
In-Reply-To: <20230801205254.400094-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230801205254.400094-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801205254.400094-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] net: tun: change tun_alloc_skb() to allow
 bigger paged allocations
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


