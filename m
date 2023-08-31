Return-Path: <netdev+bounces-31593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBDF78EF03
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0B6F1C20AB9
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178A1173D;
	Thu, 31 Aug 2023 13:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAB12B6D
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:52:33 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2746DE50
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:30 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d799aa369so12213777b3.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693489949; x=1694094749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipxZ1g9mQtOs0lzIsEu0eNu7bLb5QR6acYJ6X3Gfq1U=;
        b=rXQYiRiFkVMpNB5zCWjMjwVRKQfcX+Q8qDPsjXB6qVTiFzUwjGd52wE1nm9sRBP6+a
         fS4OzYO06YnrLBPG6TN0f7lYTKh50kNABPkXB81hCDBC+5WwfDDXojux2pkxkAFLt6M9
         vHKquq8rE1Uz0RBQU0qiRjC4don4EvgrDLZqaIi7k+QTQwnV6GWqH7thOLCFcWW10UOx
         bk+f+uLtB2L/qoaebrHvRdBHq61qEwatZELp7DozNqMsPsj9jj90YDP0LHRwajTeyHUy
         jjyx/nrz9oxaR2fErUxrPyCWY5T29l+62XXGiZy/57C2NsZxH3W52Xs692U0mnajcWml
         W1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693489949; x=1694094749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipxZ1g9mQtOs0lzIsEu0eNu7bLb5QR6acYJ6X3Gfq1U=;
        b=FqpqVLd6xFtdZPyLc9JMhykM1Nmf4dZqFtQow4Aq1AFPNoDqixzrLT1xiLClz9jqqA
         yLQPSoG59NT0Ek671RdNeLvESoDdD9lZrkEXH9P0ZiJowsAKAK6ih2P6/JTdfj+kV5bD
         RblcBBQ8SuFzQtvSDiVLJw7jTmZ+1MiZfikbq21KFjcMuDoOprV2Tdsk2jInKwmiPdvz
         UUDvYHIJjSbvRc7v11Q6+Xjsnfzr8ZHJtce8h7twdClHt500192ZC4wsSmTvk6Zne2LU
         1wvk0VHyvpQqeBqiVhsVgg2bRoZVG3q/bGYNK4GxwyE5oCT7VpHVWMSpBZcBFwvp0S+W
         8M0w==
X-Gm-Message-State: AOJu0Yz7IUtukJDHNWuufBur3ZOzSpxedrX9iAsKWS4vvxSfAQrp3zS7
	Mhcxaxmi7KdLVeW0tsz1w/f3LOHuWv8z5w==
X-Google-Smtp-Source: AGHT+IEd3BTnp+GH68G1o5X3jkt/3DgprzW6PutcN2lJR9cMK0JlJVqBraCBv04botlMYLZEoxou5r8BX2z+Hg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d786:0:b0:d4d:deb:7ce0 with SMTP id
 o128-20020a25d786000000b00d4d0deb7ce0mr159064ybg.13.1693489949469; Thu, 31
 Aug 2023 06:52:29 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:52:12 +0000
In-Reply-To: <20230831135212.2615985-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230831135212.2615985-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831135212.2615985-6-edumazet@google.com>
Subject: [PATCH net 5/5] net: annotate data-races around sk->sk_bind_phc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Yangbo Lu <yangbo.lu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk->sk_bind_phc is read locklessly. Add corresponding annotations.

Fixes: d463126e23f1 ("net: sock: extend SO_TIMESTAMPING for PHC binding")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
---
 net/core/sock.c | 4 ++--
 net/socket.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index d05a290300b6c8c765d6733520c50978f35f2dd0..d3c7b53368d2245c8c2299a5f8ad79fad4de4d16 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -894,7 +894,7 @@ static int sock_timestamping_bind_phc(struct sock *sk, int phc_index)
 	if (!match)
 		return -EINVAL;
 
-	sk->sk_bind_phc = phc_index;
+	WRITE_ONCE(sk->sk_bind_phc, phc_index);
 
 	return 0;
 }
@@ -1720,7 +1720,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	case SO_TIMESTAMPING_OLD:
 		lv = sizeof(v.timestamping);
 		v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
-		v.timestamping.bind_phc = sk->sk_bind_phc;
+		v.timestamping.bind_phc = READ_ONCE(sk->sk_bind_phc);
 		break;
 
 	case SO_RCVTIMEO_OLD:
diff --git a/net/socket.c b/net/socket.c
index 98ffffab949e850fe07904f1cf20ff2ce4a9b5d1..928b05811cfd3333ffc101f850486bc1e8e3f611 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -939,7 +939,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 
 		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
 			hwtstamp = ptp_convert_timestamp(&hwtstamp,
-							 sk->sk_bind_phc);
+							 READ_ONCE(sk->sk_bind_phc));
 
 		if (ktime_to_timespec64_cond(hwtstamp, tss.ts + 2)) {
 			empty = 0;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog


