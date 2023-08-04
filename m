Return-Path: <netdev+bounces-24449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF7377036C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1404F282716
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92BCA60;
	Fri,  4 Aug 2023 14:46:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB912B66
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:46:26 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCCB49C1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:46:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d064a458dd5so2219801276.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691160384; x=1691765184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c0BjAAN0IPipJTA9RdKDWrqmllCquz2fYaUJUwlEPXI=;
        b=Yc631kFu0eWJOMKnjRJXOazDF7jTMwTznjBas/ks1nLdLHul6ntcZs7JlWeS7T71bS
         LZgviTFdeMubXrhBUigsz2y25ELrtvJih1+qdGDE1ekyee0v7gN3sqd7K5OASxnPQ1QQ
         /eK7f/qwwjoKv9OMOvlIoQabQgVsD3OYEP+aHUtcirtWCb5w2xpgST40ljdqAZHzozrP
         29Q5mb0S+mnKLz3WWjlhsiqZJJYh7zhQhriSMh39NcBrQ30YGZEMvcGOJmikitw3J+Q3
         KxRFW0ZTEJqfP7U7QJOLaf4raQYg7NGWeGJ+tR+hmTymuCX0mH/uC6n/qXIOo+s3xCsC
         bQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160384; x=1691765184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0BjAAN0IPipJTA9RdKDWrqmllCquz2fYaUJUwlEPXI=;
        b=kWi+8X4WpwohQkks+Q5gJEZSh1ewRaYab0hsjX+eDhQBOfQ0vZ61T/vMuXFKf15u9h
         fKEzlwOU4teM1pl5wzmq4wmzONAANMvUHpUPNQlkaxN26OQQUYkD1/0ZEG56Q0npRfBi
         xirYDQkbmUk1dzMNx7n03FjafslxK6vLpSJoxu16PYg77jzfIOu0Xx41KuqaAyy5VtJq
         sv1AjNZ0TVw5Ed0VFRez9sF6fy7YjBrCri/opluOzxdV1QQww2oLGMsf8Qrrbd9tbOWr
         OWZrf9XYIubcUbMn+BPVd9Xf06ngm40jBlMR22UOEXkuIbDi405zr4dNAXkJluhNT2df
         FepA==
X-Gm-Message-State: AOJu0YyEZ2lsk2ptu4S6YQx6uFj0LHppr1+47yH+fBQpK5cI75dQetNq
	WlmrViNT6Dw+9t99d78+jqjBTzxRrwRwAA==
X-Google-Smtp-Source: AGHT+IHFvNlQIyFmT8KQSJLHTxSlUS5Oi4qHzGhlxyUxOUnFQkdAhHN1ltiLuT9fZcjhdjRiGkyChl70aPnRsw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:dc14:0:b0:d1c:e102:95a5 with SMTP id
 y20-20020a25dc14000000b00d1ce10295a5mr10988ybe.7.1691160384237; Fri, 04 Aug
 2023 07:46:24 -0700 (PDT)
Date: Fri,  4 Aug 2023 14:46:14 +0000
In-Reply-To: <20230804144616.3938718-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804144616.3938718-5-edumazet@google.com>
Subject: [PATCH net-next 4/6] tcp: set TCP_KEEPCNT locklessly
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tp->keepalive_probes can be set locklessly, readers
are already taking care of this field being potentially
set by other threads.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 75d6359ee5750d8a867fb36ec2de960869d8c76a..e74a9593283c91aa23fe23fdd125d4ba680a542c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3358,10 +3358,8 @@ int tcp_sock_set_keepcnt(struct sock *sk, int val)
 	if (val < 1 || val > MAX_TCP_KEEPCNT)
 		return -EINVAL;
 
-	lock_sock(sk);
 	/* Paired with READ_ONCE() in keepalive_probes() */
 	WRITE_ONCE(tcp_sk(sk)->keepalive_probes, val);
-	release_sock(sk);
 	return 0;
 }
 EXPORT_SYMBOL(tcp_sock_set_keepcnt);
@@ -3471,6 +3469,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		return tcp_sock_set_user_timeout(sk, val);
 	case TCP_KEEPINTVL:
 		return tcp_sock_set_keepintvl(sk, val);
+	case TCP_KEEPCNT:
+		return tcp_sock_set_keepcnt(sk, val);
 	}
 
 	sockopt_lock_sock(sk);
@@ -3568,12 +3568,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	case TCP_KEEPIDLE:
 		err = tcp_sock_set_keepidle_locked(sk, val);
 		break;
-	case TCP_KEEPCNT:
-		if (val < 1 || val > MAX_TCP_KEEPCNT)
-			err = -EINVAL;
-		else
-			WRITE_ONCE(tp->keepalive_probes, val);
-		break;
 	case TCP_SAVE_SYN:
 		/* 0: disable, 1: enable, 2: start from ether_header */
 		if (val < 0 || val > 2)
-- 
2.41.0.640.ga95def55d0-goog


