Return-Path: <netdev+bounces-35602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79297A9FEC
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2E9281E90
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD218C17;
	Thu, 21 Sep 2023 20:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D37179A9
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:29:00 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9E2D22A
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-597f461adc5so20640117b3.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328103; x=1695932903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hpa1uEZfIRRbRJGKKVRC4KI50a9/m3Fk8+9DwcgnNlM=;
        b=cwBP2BW4IztHs1udW8/X6eyeu7dPIGEOKFdTpgujMElmHbpygjuIdeJTnTX5jWDwT/
         YAZ4LfC4yQFFhNMveDJl93TBfmNRjM8heljbcICWxVPqYS1I+7dyZqxb9VYzlcsJp5FT
         M66XdnkdBVxT/CvwwJiVzcrRlmOyNQrnv7a+fT9QJ625bSYnEDPhrzB5DtqEwygesJ3C
         Oktp+Vt1fWOjsqZcAZjw7zT31S3hBgfN1iBRZ60XyULSjlK8ry5khNd9D1tivLhukwwY
         PpeU5BPLCGrjKfgvTD+j8cENOl4imq40BWoTTYXbVOe4lfMut+reD9aNZ4w7Pk0VZefH
         lBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328103; x=1695932903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpa1uEZfIRRbRJGKKVRC4KI50a9/m3Fk8+9DwcgnNlM=;
        b=NVt0dZnevIESMsDShsWLuTGGUrtB75pYcaLdkIPKoZuf6LJfLabOA6Pk9+UVnly4sA
         724krql7FQ74rd9JmBkftIE/OngH+r3cFzJ1WbUEGtKSrs2mryA+yLqdYe8+ruGXqCyy
         eMbDNF4kyjOYFs3g2qQwLc+81N1a1xneqNaK5n2xl/oMhA16sraSJHzi7Z3t4aADdeZC
         atbgmIH2Qvj2jbw+cxFKSuD4mZiip4D7VB0R4AD4n4eTtfA97Jv7YuVtXSg3kR62gV1Z
         5B+ccstRmSeTj4l1ArDf/xhtn7/aHHkruUGRFycExh9Ki91YZ+5TjePtrpgZAEeAGJJO
         zfCQ==
X-Gm-Message-State: AOJu0YzFDnsQ+0L7b3Si+9zC2P42YDP0Q/LZzs2SXM/bK8/pHyIb+d3l
	PXYw2CVlKl3+xHc3bTOGlUZuoVsGD4lNLg==
X-Google-Smtp-Source: AGHT+IGsJ2LPOPYVMiBnoW8dbnX7LtWoRSEI1c/SlIdWyD0Ct9pFhxGI6+DEtBF/AC16wlY5oO5KqMP8DEs2Jw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:987:b0:d84:e73f:6f8c with SMTP
 id bv7-20020a056902098700b00d84e73f6f8cmr103954ybb.6.1695328103626; Thu, 21
 Sep 2023 13:28:23 -0700 (PDT)
Date: Thu, 21 Sep 2023 20:28:12 +0000
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921202818.2356959-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921202818.2356959-3-edumazet@google.com>
Subject: [PATCH net-next 2/8] net: lockless SO_PASSCRED, SO_PASSPIDFD and SO_PASSSEC
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sock->flags are atomic, no need to hold the socket lock
in sk_setsockopt() for SO_PASSCRED, SO_PASSPIDFD and SO_PASSSEC.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 1fdc0a0d8ff2fb2342618677c3adef2b485c6776..f01c757245683452fd6c30c51b885d09427ef697 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1126,6 +1126,15 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			return 0;
 		}
 		return -EPERM;
+	case SO_PASSSEC:
+		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
+		return 0;
+	case SO_PASSCRED:
+		assign_bit(SOCK_PASSCRED, &sock->flags, valbool);
+		return 0;
+	case SO_PASSPIDFD:
+		assign_bit(SOCK_PASSPIDFD, &sock->flags, valbool);
+		return 0;
 	}
 
 	sockopt_lock_sock(sk);
@@ -1248,14 +1257,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_BSDCOMPAT:
 		break;
 
-	case SO_PASSCRED:
-		assign_bit(SOCK_PASSCRED, &sock->flags, valbool);
-		break;
-
-	case SO_PASSPIDFD:
-		assign_bit(SOCK_PASSPIDFD, &sock->flags, valbool);
-		break;
-
 	case SO_TIMESTAMP_OLD:
 	case SO_TIMESTAMP_NEW:
 	case SO_TIMESTAMPNS_OLD:
@@ -1361,9 +1362,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			sock_valbool_flag(sk, SOCK_FILTER_LOCKED, valbool);
 		break;
 
-	case SO_PASSSEC:
-		assign_bit(SOCK_PASSSEC, &sock->flags, valbool);
-		break;
 	case SO_MARK:
 		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
 		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
-- 
2.42.0.515.g380fc7ccd1-goog


