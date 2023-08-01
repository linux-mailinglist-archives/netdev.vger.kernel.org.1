Return-Path: <netdev+bounces-23420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC5A76BED5
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96071281ADF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB0F26B6A;
	Tue,  1 Aug 2023 20:53:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C0B4DC77
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:53:03 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5126311D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:53:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d0fff3cf2d7so6837605276.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 13:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690923181; x=1691527981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+yit71oMsx680KafiyUWCZMFyhA9I6XCSFIZv1F378=;
        b=bXD5gfj3eNqfEKm44vRZA2A4pXrXDXEUmoohw1l9afdyIU/p7VOrfqjuNXdHTGfMFy
         VDIjp45X5DFVIpHr34eMQKAVrlsk5zXndndyJcHjO/BfnnFcX1muoJE4tXajvYsBFHz1
         bEwQYTFwBPH+K0X+JX+iSq198U9oSFbPXlcdZ5fxDJ+O/LdQ/fo8/LIPGkp7BNFynTfE
         6SB439T6oWXyKvGWJhDx+OM8RbG0PEfcBy24pm7h34OiLURcXW9bKDr5V1kzA45Io2OP
         BhfbYvsvYtGNugVGFD2vrLGe18d03SjkjYg2u0VIb6c63TkNGW+BMDJdAZRt77kYCOIC
         2Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690923181; x=1691527981;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+yit71oMsx680KafiyUWCZMFyhA9I6XCSFIZv1F378=;
        b=iWNG6elmTY9wNiCYo2q9MeyZwcWmnnVT1dOCIchATuKM2MgrgM4CLzl7iuf6o15ZCa
         izt4+kgXkvmwvKWqwqxRHOxeFyazvgn1/l5fYagZDG8BOSHQm2GZqCtZVximI15gPTH3
         r7NSyaymXGUYavxo8hh9f9S1vL2dmUdRE3+KTvA+DPq86G6K67mRv1/9spqgyCbMIokT
         DCeDwGnzy8cAAqhw6BwsC0yP6ys/8kS6hBXFJTK4QxkHgDkA9MNvKcA9m3uKR1yfjBlD
         eAmZidpEw5rqtblKAl7Rn9sT9sW95cnwqfKVf7HQKuAAsOHIRYXlzAOuofJ4pGLCVq1O
         n5ww==
X-Gm-Message-State: ABy/qLYsMCsxUalSgx+DgI5OONr9dJlhDaNztyIHCeMNwgjnpibnBDa9
	CX9iACdFZILd6XRrZX7+fYgt2ObATSdtCA==
X-Google-Smtp-Source: APBJJlFr7gwiNW/kz8b5JcnzIaxGXXjmZe0phpN+3IYBTnditADsQ2DYSqAKmsLmhn/uP1UHz6PQEVnt1tkytA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aaec:0:b0:d35:bf85:5aa0 with SMTP id
 t99-20020a25aaec000000b00d35bf855aa0mr40983ybi.4.1690923181437; Tue, 01 Aug
 2023 13:53:01 -0700 (PDT)
Date: Tue,  1 Aug 2023 20:52:53 +0000
In-Reply-To: <20230801205254.400094-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230801205254.400094-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801205254.400094-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] net/packet: change packet_alloc_skb() to
 allow bigger paged allocations
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

packet_alloc_skb() is currently calling sock_alloc_send_pskb()
forcing order-0 page allocations.

Switch to PAGE_ALLOC_COSTLY_ORDER, to increase max size by 8x.

Also add logic to increase the linear part if needed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tahsin Erdogan <trdgn@amazon.com>
---
 net/packet/af_packet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e3ddec4c3d57e7492b55404db3119cbba6f6022..3b77d255d22d6d2ed23cfc50e69a32e9c7b94531 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2927,8 +2927,10 @@ static struct sk_buff *packet_alloc_skb(struct sock *sk, size_t prepad,
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


