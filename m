Return-Path: <netdev+bounces-43302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17307D245C
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 18:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A54CB20EB3
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 16:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8D710A16;
	Sun, 22 Oct 2023 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSO/eL8b"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2F10A09
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 16:20:55 +0000 (UTC)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B04610F4;
	Sun, 22 Oct 2023 09:20:50 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-457cb7f53afso875407137.3;
        Sun, 22 Oct 2023 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697991649; x=1698596449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Yqf8xOcyNNZs+GLw9aGZ5FbGSaK8bs1qBlvW4RYacI=;
        b=eSO/eL8boPEF/QsYprRX0Robfp0EMZ6zP2Js9SzYKr6yhAwLqXLMwgEp2PrukQOH3p
         d4SNgCR57PTqRD8bfx8t5VBBxtySeNT76NknHR+SmfJ+IxEW8NplMDiDoUFJvlso4nsr
         2lCzpVJgTSMIM+2wfbOc04gr+4XxGxiJThjVS7FPBaR1nF88c1TZr9bdXAKyVJSQShhz
         QoVzNlkiS2erMbjGCvEfS7trdgv4mm8BDnUJgL39qD5wnuC/He3oUqI/c1CU+7T6+TQ6
         Pec0YRZX4wSdpzBbJUQ3zqxtQIkh35G+oNoR/HRtB6eRcVu7x9EXD0GRLe2AosfbaQJ0
         2B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697991649; x=1698596449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Yqf8xOcyNNZs+GLw9aGZ5FbGSaK8bs1qBlvW4RYacI=;
        b=dBpvbyv5amGw0BlWcv0CFC+iAk9DUybF3v4XlMoB4TeSovLe6BVZu4tEdIEmNJGHfN
         NgQFR2+DNi97H8h8FBKp7BYptrHA6qj7BwrXU4YRyIsc+xAUZemYR+VsC336c8hiz2cV
         dYkMjBF1Fk7/cCKvdLDSA7cQtW5oLoSxywh246z0Mr32LzZ6MhytqVWtJb6v/gSM1Z5k
         I6mW7beA1v84iuwBJ9HBycNjSngpUdgwRQFP/0oUCj/ZFKZhdNkyea8ydxGe6L1KsSbw
         D6t/o65Ubw07lULRgb2pKjdPnNi6HMzYg3EiM+UKjIWDEm8y93kkStACarT/lDHnYsJA
         93zA==
X-Gm-Message-State: AOJu0Yyektluw63TzDl4J11cqwsEIkBooXLGTGzvAlzbx8aMFIlHcS/Y
	n9SX1eJ5+mROJ0qnXfpSYbu1iZoOBTt8nDjN
X-Google-Smtp-Source: AGHT+IFK9DmeyDcF9/djIZteLet9zGGQFyDAxkMMHxpJMhtz1/ZTnU5DRYqWbE+uP4A1FyKGPRrrxQ==
X-Received: by 2002:a67:e156:0:b0:450:f5cb:c3ce with SMTP id o22-20020a67e156000000b00450f5cbc3cemr5758220vsl.17.1697991649192;
        Sun, 22 Oct 2023 09:20:49 -0700 (PDT)
Received: from localhost ([2601:8c:502:14f0:d6de:9959:3c29:509b])
        by smtp.gmail.com with ESMTPSA id m1-20020ae9e701000000b00767da9b6ae9sm2112629qka.11.2023.10.22.09.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 09:20:48 -0700 (PDT)
Date: Sun, 22 Oct 2023 12:20:48 -0400
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: davem@davemloft.n
Subject: [PATCH net-next 08/17] Update cork to pointer
Message-ID: <e7c4e9575bec76fc4ba6dc0e8115aa9621377f7b.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>

Updates cork to a pointer in the __ip4_datagram_connect function in
accordance with the previous patches.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 net/ipv4/datagram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index cb5dbee9e018..bb73eae9de25 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -45,7 +45,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 	} else if (!oif) {
 		oif = inet->uc_index;
 	}
-	fl4 = &inet->cork.fl.u.ip4;
+	fl4 = &inet->cork->fl.u.ip4;
 	rt = ip_route_connect(fl4, usin->sin_addr.s_addr, saddr, oif,
 			      sk->sk_protocol, inet->inet_sport,
 			      usin->sin_port, sk);
-- 
2.42.0


