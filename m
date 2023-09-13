Return-Path: <netdev+bounces-33773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 512397A00AD
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085651F21F27
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C52AB4A;
	Thu, 14 Sep 2023 09:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE93224F2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:48:00 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD602E3
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:47:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso8352315e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694684878; x=1695289678; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzzzJpY9KlYdQtsBVsrdcIxWQyjcGOv0khQAB609xvg=;
        b=I8CIqLhZH7ynHiMYMnqMB4b7c89IzWD4eGgaVyuAgl7gMFubwSN3RsoBN8OzxPczDV
         RSFinowOnopUZOAfxWrglOU0lfZqe13jBSsjuAMmk24i5B+Q9vjy02UJ/QO6THK40v7C
         5kvjJ4VWPWcj86hVZ/+Tbo9Vca7M6WdhmfDro/cBgz0oxSi+qcqXMXjZOnhJmqpEMqLI
         AJb6Hxc15pEVActHbuvmmWLG35Oz0tOjhY6pRNEiO0YSqJP20WxFo1j3MGGmGys1mP+j
         TSdHlvPXiws/uXR7TYFDryTuMfORin8I5nZfI5zcFL9gT81hbY44K2mz/9n8lI62vvzX
         PqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684878; x=1695289678;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NzzzJpY9KlYdQtsBVsrdcIxWQyjcGOv0khQAB609xvg=;
        b=gUj25g0gIIoG4mljJ2hIX8lqbTpJ4jUeE8mrA0XPVHHplB5uPpbjA6Zg29FQIwJJvR
         0wK9ZAAjxJheqr7JGjfE4vjiX0GHGrF53NMvAAJ8Y3bBbsxeKwOlEG/b7ZQjcMq91LMX
         t56Uc2Dz+PMX5/P0psOjs68sBDb2XwzrKeq/zxcGh6m8+Qi0sz8+L01c8yYbQSUq98M6
         3t7w4GYJg3P9wCNm3Cb/Eueh6JdIB2ZFxeZyq8Ej3zpWURUN3WBCRImxAVU4pNnqRfyB
         26mxAam5Aqfwyaaq4BAeMW92jBppZM+OrwRwtxQvixXbOxDH62Q+Ql23n65PDZqnWFUd
         EFCQ==
X-Gm-Message-State: AOJu0YyQ7qYWbafmaXnj8ZmywA9x05/WYWXj9AgVnFPqT+RMvYOdpjPb
	3gBI9LRluKbzSMumZDC+oqckzA==
X-Google-Smtp-Source: AGHT+IHzgX1oNCgbhQl0a7H9yPKrhXkm4fFi37KYW/JBRfGXBl+yNuIOQgHlKkxiKUMaw93PkJHsHg==
X-Received: by 2002:a7b:c7d5:0:b0:3fe:e7b2:c97f with SMTP id z21-20020a7bc7d5000000b003fee7b2c97fmr4019759wmk.36.1694684878173;
        Thu, 14 Sep 2023 02:47:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bc8c2000000b003fed70fb09dsm1499698wml.26.2023.09.14.02.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:47:57 -0700 (PDT)
Date: Wed, 13 Sep 2023 12:36:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] tcp: indent an if statement
Message-ID: <de6b9eed-7049-45c6-aa49-ca7990c979c8@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Indent this if statement one tab.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Applies to net and net-next, but it's just a white space issue so it
should go into net-next.

 net/ipv4/tcp_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d45c96c7f5a4..18ede5205b9d 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -394,7 +394,7 @@ static void tcp_probe_timer(struct sock *sk)
 		if (user_timeout &&
 		    (s32)(tcp_jiffies32 - icsk->icsk_probes_tstamp) >=
 		     msecs_to_jiffies(user_timeout))
-		goto abort;
+			goto abort;
 	}
 	max_probes = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_retries2);
 	if (sock_flag(sk, SOCK_DEAD)) {
-- 
2.39.2


