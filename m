Return-Path: <netdev+bounces-22312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C3276701C
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C2F1C21951
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E18214290;
	Fri, 28 Jul 2023 15:03:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527ED14268
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:03:36 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEE8420C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-584126c65d1so24484557b3.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690556613; x=1691161413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J55GrORTZK1MXE275mZW5dmPuzvAC44whDG7RcFuX2Q=;
        b=of8tboTP6hHtgVqktnuIai+ca9PaT4wT1dmNot9MIYNdyrHcLakqQRQtXGwfT6O4Q+
         VrDfEiSblP98g+2iTBxk5oy2XRBHrnc4JkH1D3NjNLhjLJF4kwoma/72vCbfwtxi5MZs
         /AS1z/yv545ULZLBGnNA3IyySZ7zVOAiEK9w6zZXMkXFGtWEKdgVlzh2v1CNek4q7iGM
         e1txzLwxZZRloL/8D0oMifXLxMaUD2OUL6tthDY+DxxXxy5pT8t5b5DU0SfpCOLE6lN5
         HSSrUI4iH32KNnWdoXBCReFuP3jMacVm1dOiC1rXNeg9rPxX1qeJIpf2O1tlmsjdd5T9
         /tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556613; x=1691161413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J55GrORTZK1MXE275mZW5dmPuzvAC44whDG7RcFuX2Q=;
        b=Tpi1CUhNeR9MjDNqo4Jy/GI4DrStLkMogSz2JTWK5NcQxcVnXLpMgu3T+03ubfmCnB
         kk4o45cp2lGLDdslZgTv0x2V3TMOyawEI77NGLQ2gRsFfiJ8a2Jobqg3u5XFXO7Q9X0/
         VJ1i0MJsL6g0lVP5vgVs8GnllQWEWk+4Dac/fmw/az5kk3xg3/rSZNs/kG2tTJuy1uB5
         2/bNWIx7uj61eFm3C2+0EJj4XdQJcVg557hkAbHYPBhDiE0PvvHI0R6vLmTwrr58GQlC
         88i6JIsUyxNfvDVQL4TWaG3NIQ2/XfHBvbXK3+NcqOHTAVZxFfyNB7CLIwkkFuQNmGy1
         O14w==
X-Gm-Message-State: ABy/qLa1ZJzB6aCbYavyGWhgh8oYl3o7Ysc9NWY5QEv0N1V1D1d+q9um
	SHCBJyI6OmCg8y5EkUtfElWdo2xZ+H+dqA==
X-Google-Smtp-Source: APBJJlEiuIx5WUxaBtZJWUe/yTDgLzANqn4+2uzWXEaMsebOJ8aDvnpmDxSEXW9I7wjsvYCaOv2pGJO2MzJdew==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4304:0:b0:584:43af:7b0d with SMTP id
 q4-20020a814304000000b0058443af7b0dmr13203ywa.2.1690556613495; Fri, 28 Jul
 2023 08:03:33 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:03:14 +0000
In-Reply-To: <20230728150318.2055273-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230728150318.2055273-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230728150318.2055273-8-edumazet@google.com>
Subject: [PATCH net 07/11] net: add missing READ_ONCE(sk->sk_rcvbuf) annotation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In a prior commit, I forgot to change sk_getsockopt()
when reading sk->sk_rcvbuf locklessly.

Fixes: ebb3b78db7bf ("tcp: annotate sk->sk_rcvbuf lockless reads")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index ca43f7a302199724ecf155e3c03add7c964fd3ef..96616eb3869db6a6c33be34909af017d7dea59b1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1643,7 +1643,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_RCVBUF:
-		v.val = sk->sk_rcvbuf;
+		v.val = READ_ONCE(sk->sk_rcvbuf);
 		break;
 
 	case SO_REUSEADDR:
-- 
2.41.0.585.gd2178a4bd4-goog


