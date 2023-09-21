Return-Path: <netdev+bounces-35603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E4A7A9FED
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 762561C20C3A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B6F182D1;
	Thu, 21 Sep 2023 20:29:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAC19446
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:29:04 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886D1AFC1F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d815354ea7fso1809180276.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328105; x=1695932905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkCVWzoj6/Qls74i9lxW/ws+zcRujkzlpypQiZwyexU=;
        b=3vfqlzDlU7JF9n2DaLK7tZofbd5bDAI3j9eJ5PHLWH056sov3pgDHsUiHxfEJ/o3Lw
         tpTDvFxOR9wV9LcpouQQtuhrLlPwKwEx87CDyG45HcKFPBl5k73tM6Kf9WPmg1o/IUzM
         4TBVZtqSDFES5oi/TCvb2851HJS7Na/rqAF9ndtLiTBpLnL0HYnxQplfbhjBRkRgx56K
         x1KK+S/ZeU8O9ruhspnqAu0pJfvMcDVZjNWyuQQInNEdsUEfTqQDojxPYbqbpFgbVncy
         UeGk5FGuJGtHBYseiLndspalNlG+J/vbm+jQfsAgyNPjZPvVsTuV62KPDRAurTBkR1S3
         sDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328105; x=1695932905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkCVWzoj6/Qls74i9lxW/ws+zcRujkzlpypQiZwyexU=;
        b=Uev/LTASuI6aJDoERdEhB70nQ5+YEAu9h/l/8oeMhE7VW05hde9vn7cbh4rQtZ72jL
         vKWaACLOoqewXjkm/A25/fxwugyw3BSJmxQlu0tjOW4Uk1DkbMD8xJO9O+TJBgZBHjSL
         adpmKJbk1vvUAfq45rMZ6Th0/+61IgJc1QkqTCmU/Hw5IrltSxoYQUA1H40R9u24PKZ1
         czKmqHQamZi87h7NYxsNYAmjUOIuTEC1tRpdsl2wobfYrs0zonddxl/TRfo00IQyNHwS
         kGdkTUTKED486qzg9y24Z2hMZBudnTijV1/3g2VAMhNfqcYu2lc0zZzDrPsvvlAH1IOP
         /QPA==
X-Gm-Message-State: AOJu0Yyy6uVylBWA6kXJxkbFmY/0mq66F8Uyj73CTzZDpoJiJv5xAQlG
	BGLgE0pFDiieg/1Hn2lqBI4GGtiG3/ywDQ==
X-Google-Smtp-Source: AGHT+IFt+4y7q5C+a/ZqVqzonuyk1+NIL3e6vE9HRFeiXGHcBm63zJJQ9n+t1dkleLvePXcA7eMd/X0Sv924Zw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ab48:0:b0:d81:68ac:e046 with SMTP id
 u66-20020a25ab48000000b00d8168ace046mr93772ybi.12.1695328105241; Thu, 21 Sep
 2023 13:28:25 -0700 (PDT)
Date: Thu, 21 Sep 2023 20:28:13 +0000
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921202818.2356959-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921202818.2356959-4-edumazet@google.com>
Subject: [PATCH net-next 3/8] net: lockless SO_{TYPE|PROTOCOL|DOMAIN|ERROR } setsockopt()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This options can not be set and return -ENOPROTOOPT,
no need to acqure socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index f01c757245683452fd6c30c51b885d09427ef697..4d20b74a93cb57bba58447f37e87b677167b8425 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1135,6 +1135,11 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_PASSPIDFD:
 		assign_bit(SOCK_PASSPIDFD, &sock->flags, valbool);
 		return 0;
+	case SO_TYPE:
+	case SO_PROTOCOL:
+	case SO_DOMAIN:
+	case SO_ERROR:
+		return -ENOPROTOOPT;
 	}
 
 	sockopt_lock_sock(sk);
@@ -1152,12 +1157,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_REUSEPORT:
 		sk->sk_reuseport = valbool;
 		break;
-	case SO_TYPE:
-	case SO_PROTOCOL:
-	case SO_DOMAIN:
-	case SO_ERROR:
-		ret = -ENOPROTOOPT;
-		break;
 	case SO_DONTROUTE:
 		sock_valbool_flag(sk, SOCK_LOCALROUTE, valbool);
 		sk_dst_reset(sk);
-- 
2.42.0.515.g380fc7ccd1-goog


