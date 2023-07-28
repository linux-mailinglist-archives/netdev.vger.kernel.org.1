Return-Path: <netdev+bounces-22314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5BD76701F
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AED28284C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBF914AA6;
	Fri, 28 Jul 2023 15:03:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309A14A94
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:41 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931D34201
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585f04ffa3eso1019797b3.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556617; x=1691161417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKSSomLWDqDVYb97SvpqGhmh2QBNuIMbb4vQhOgjMc=;
        b=xLQSbQDKe/Pdfk7RuJyBqCSU6B+prz7RMnBrZFQ0OKGMvZHrWIR/SDEV617u0BOTf2
         vfjiQNZvhB7bAVnS0bbxWPD8+O5LiULs5Q4HCJtuVj+iFHwF+kUQPbaLPXmODa+j/gvn
         yVjHmUXXRaJMiqFp+CQ3zaD1eEV+N9hoIWwK6jKG2hyQmcO4w8usjEFrUCHmJyiQmBsn
         GH+VswtuFQqcUxnib3hjOKAdbQW2DFJpHMy2hsHD9gnM1B00WPNxahwn37+AcBRg85Wp
         9VPg9dw9kckrDWYPrL92hV/qYzXww1MQcembIcOax1B86rAztDhU2k9jztUpAb4jr/ZN
         KIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556617; x=1691161417;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKSSomLWDqDVYb97SvpqGhmh2QBNuIMbb4vQhOgjMc=;
        b=d/wNCELSbRK6OLi5u9QlLqBamsOBokzfGaN7YHoSTdb6NDjEjGHFukApd7RfNOD/uy
         SC5MAzCVhRfiXHhbBHL7dA6IYbdgdpZx7RKabC9xxTAOrTomh4ls7rmHTzD1ciN73WUQ
         FNiDZzVphfQdQUq74hmPNog4FjkF1DoUXxtK0gJtUbZ81P3ZaZV/YoWAtIncHomIF3Hc
         48hsQcsgMfpDD4K3j3ayUsrxAChGT5du7BF4jv2Ta2CQMtYA3Zl+ibbxCAk9G7BlsB+t
         PbbaVhD/VLgd1Z6kqCLNGYoZMbWAlHYoxOE7zq7izBVXdH2b8qYC/Zeiw78y98uQfvMG
         huEw==
X-Gm-Message-State: ABy/qLYTHzXTcdOjvpCy+XeF6mFOGkPhOH3ZN4sPBg/kDJmSkNG6VBKu
	sLuIyLokC6imNRDclNJ5tf/ta2SnfOPYNg==
X-Google-Smtp-Source: APBJJlEh3eUzmNXRwSxQGwOvoBVjfmjn5NYVfH20lVekpg8QcuMW2i6ax+fcgLhnkFcOjfaSMFBOdDgbWDYZ+Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:db82:0:b0:d0f:15a4:5a53 with SMTP id
 g124-20020a25db82000000b00d0f15a45a53mr9810ybf.2.1690556616791; Fri, 28 Jul
 2023 08:03:36 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:16 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-10-edumazet@google.com>
Subject: [PATCH net 09/11] net: add missing data-race annotations around sk->sk_peek_off
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk_getsockopt() runs locklessly, thus we need to annotate the read
of sk->sk_peek_off.

While we are at it, add corresponding annotations to sk_set_peek_off()
and unix_set_peek_off().

Fixes: b9bb53f3836f ("sock: convert sk_peek_offset functions to WRITE_ONCE")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/core/sock.c    | 4 ++--
 net/unix/af_unix.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index d831a3df2cefc9c2c7467b59b044227d16c712b7..d57acaee42d4b1204d34baf6f8ab64cd5a0c3abf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1870,7 +1870,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		if (!sock->ops->set_peek_off)
 			return -EOPNOTSUPP;
 
-		v.val = sk->sk_peek_off;
+		v.val = READ_ONCE(sk->sk_peek_off);
 		break;
 	case SO_NOFCS:
 		v.val = sock_flag(sk, SOCK_NOFCS);
@@ -3179,7 +3179,7 @@ EXPORT_SYMBOL(__sk_mem_reclaim);
 
 int sk_set_peek_off(struct sock *sk, int val)
 {
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(sk_set_peek_off);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 78585217f61a6944934f1cc0b3b930284e891ed4..86930a8ed012bfad9a407db985782934f52b9698 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -790,7 +790,7 @@ static int unix_set_peek_off(struct sock *sk, int val)
 	if (mutex_lock_interruptible(&u->iolock))
 		return -EINTR;
 
-	sk->sk_peek_off = val;
+	WRITE_ONCE(sk->sk_peek_off, val);
 	mutex_unlock(&u->iolock);
 
 	return 0;
-- 
2.41.0.585.gd2178a4bd4-goog


