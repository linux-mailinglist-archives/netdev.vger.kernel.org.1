Return-Path: <netdev+bounces-39751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA37C4480
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65FE281C36
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D19529433;
	Tue, 10 Oct 2023 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anVlnXYD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8113551F
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:46:47 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265279D;
	Tue, 10 Oct 2023 15:46:46 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-58974d4335aso598789a12.1;
        Tue, 10 Oct 2023 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696978005; x=1697582805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yfc2ApoKjWF5pFCF6Ncuv8BWtgDho+97WSMGGN/f+Hw=;
        b=anVlnXYDKoxrH3dpt/8b+McTGxFnk4kBeIk/7dP+Z6eRraqtvL6OhpXbkmi3zsB7xi
         xko4G0SpdOBOgh17tygxnKDESMsKFi20jFjSxjDDw93AoealRrAVghM6X5NvaB4MJqba
         HVH1i1pKJEtDH++r5/1LCuo3kfqDltCp0HIqq6SdR1TnsKwEHYwgmijGfwl+Um6gf/l8
         yV5uq6iB5qSTWbGj6yAimugjntTFJt5d5miUsD185tLD0BRTG7BQuMBn5j+KdLi8nqqy
         dOjknak23IYC03odM2pA83nefeDJW9jnbjghOZ0Pk7I13pDPaoDvHFaXh7UXQnY/eLaC
         KzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978005; x=1697582805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yfc2ApoKjWF5pFCF6Ncuv8BWtgDho+97WSMGGN/f+Hw=;
        b=Tw9/r718SaD4mf21OnNl0J8qUoHUQDKZ/c43JGWRB3NlNmRSZND4ET5ZlHXQRHSdAm
         YV6ytx5F3kCw4nm5BwnFdi4AvC8GgGA5EBIqT2OKjHABJnZfT+iSkl25HcvYrPMr2Hcb
         yach5JT3HMkT93glmJ0IA80SfLf7mbH4rKPRkXHuRTRjIaa5NKreMf8d3t9o+5csZ8pL
         65C4hOfBsDc8p9Cm5H/C1TMxuKCtcPfVv3sw07afHl7bMUgFvdYIUeyn5B6HCLswEfXN
         g1KBn/MKyly+zYQKt3hv8HByLbfzjAXaO9kBrQIzrj9tvgXW2EMl2F9N6dWnGrsjcl2O
         c1HQ==
X-Gm-Message-State: AOJu0YzNI8Dzqv4UeXYyBbXc3I8DJIlfhRJUXzZEbl0JK7FwTc32LiDk
	502XVBjHqG6zPqxnYkmGDnw=
X-Google-Smtp-Source: AGHT+IFt9Myk9KUHdeA/2gFtXuUyoJ9lWC8rmYSHPW2LIP7dUo+hLgSjBkzvVkLLobEJ++Viinf8Ew==
X-Received: by 2002:a05:6a20:daa8:b0:171:947f:465b with SMTP id iy40-20020a056a20daa800b00171947f465bmr4587914pzb.4.1696978005607;
        Tue, 10 Oct 2023 15:46:45 -0700 (PDT)
Received: from abhinav.. ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id j13-20020a62b60d000000b0068fbaea118esm8692062pff.45.2023.10.10.15.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:46:45 -0700 (PDT)
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] Remove extra unlock for the mutex
Date: Wed, 11 Oct 2023 04:16:30 +0530
Message-Id: <20231010224630.238254-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a double unlock on mutex. This can cause undefined behaviour.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index aeebe8816689..f11fe8c727a4 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -597,7 +597,6 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 	}
 	if (head2_lock_acquired)
 		spin_unlock(&head2->lock);
-	spin_unlock_bh(&head->lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(inet_csk_get_port);
-- 
2.39.2


