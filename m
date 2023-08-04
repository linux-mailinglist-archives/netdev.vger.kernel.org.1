Return-Path: <netdev+bounces-24448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55BE77036A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C762826A8
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8F8CA7D;
	Fri,  4 Aug 2023 14:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9491BCA60
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:46:24 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8690749C3
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:46:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d087ffcc43cso2233777276.3
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691160383; x=1691765183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmN1WhQqyXnxWLsVZC51NaQ0qsTN27+GpSzdqcWncMo=;
        b=qw7JLVm4oPgV7r4EPQIGS3uuIxVOmR+E+nnuw/4dgn4fc9KegvLPDZ8Y4M1Rvc79+F
         Z9vE/bKGkaOCwxyCbtH2HPgXsZp6w4FjspsleGVGJUpIjsa0snvmoRB3IBmPFzIHgoy7
         pDBergBHiCs6y3vsbNR7JUlUiItrqsjrLcpLRizmFu4KOGPtb+y10LA0potwKGSAgV2M
         NX5wSp8XC2HH3SmwYYJWnzE+5i+3BKNkboVB95jvq/dOFxZKHLYceaTxuP9966pw1vJa
         +9WXYNsas7J5ktCwTOFhtH/NWA/oi/18EX146bPQg2Q0zqf4twizvOiWHQUkAA906Gjx
         2AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160383; x=1691765183;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmN1WhQqyXnxWLsVZC51NaQ0qsTN27+GpSzdqcWncMo=;
        b=KybYtNx9R6ZF3HYGYO4D8LM7Vq8t81mZNHotPXMb3KZftpiZe63Lmrxjkuvcq99xRr
         4W3Hv5C3cDRNWcuFHmZEYPtj+ocrXjYH83BCwPiKZ+7t+jieq0L98bGpQ5ZbLDL4WA11
         oTuunf2sKJibWR4hotFGxMswncPCVYD79o6ixFPDn26QawVn9wOegqid96NU0klRvx+v
         FMjObJgtG28YRkrRDWI1pXKkjlA4erAVYaH2aaQwKfbFMp4pMhSPsB8Uj6eGdU0v8rIh
         C7F0lrNtlsuWwnXz2GLIlqXXMye/R9a3+B5N7Pj23uTz85z1cPxCmgXxQvnbHSSmCeH5
         8T9g==
X-Gm-Message-State: AOJu0YwvUeHsq36owLlU1xDq28TSbyKKtBwam/qbqM3H1BS/AynkB/2v
	HTn+MULmuotWQ9EdLlmegQczt+H3na0auw==
X-Google-Smtp-Source: AGHT+IFLCI+8JyN+2ZNB5a5W5UM9BYWWoUQImWkxq39BQTFRvLb3ZBLuYBLYZTrT0TVLJlOQb3VOr98yvBJMHA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1364:b0:d14:6868:16a3 with SMTP
 id bt4-20020a056902136400b00d14686816a3mr10254ybb.5.1691160382841; Fri, 04
 Aug 2023 07:46:22 -0700 (PDT)
Date: Fri,  4 Aug 2023 14:46:13 +0000
In-Reply-To: <20230804144616.3938718-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804144616.3938718-4-edumazet@google.com>
Subject: [PATCH net-next 3/6] tcp: set TCP_KEEPINTVL locklessly
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

tp->keepalive_intvl can be set locklessly, readers
are already taking care of this field being potentially
set by other threads.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 34c2a40b024779866216402e1d1de1802f8dfde4..75d6359ee5750d8a867fb36ec2de960869d8c76a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3348,9 +3348,7 @@ int tcp_sock_set_keepintvl(struct sock *sk, int val)
 	if (val < 1 || val > MAX_TCP_KEEPINTVL)
 		return -EINVAL;
 
-	lock_sock(sk);
 	WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
-	release_sock(sk);
 	return 0;
 }
 EXPORT_SYMBOL(tcp_sock_set_keepintvl);
@@ -3471,6 +3469,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		return tcp_sock_set_syncnt(sk, val);
 	case TCP_USER_TIMEOUT:
 		return tcp_sock_set_user_timeout(sk, val);
+	case TCP_KEEPINTVL:
+		return tcp_sock_set_keepintvl(sk, val);
 	}
 
 	sockopt_lock_sock(sk);
@@ -3568,12 +3568,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	case TCP_KEEPIDLE:
 		err = tcp_sock_set_keepidle_locked(sk, val);
 		break;
-	case TCP_KEEPINTVL:
-		if (val < 1 || val > MAX_TCP_KEEPINTVL)
-			err = -EINVAL;
-		else
-			WRITE_ONCE(tp->keepalive_intvl, val * HZ);
-		break;
 	case TCP_KEEPCNT:
 		if (val < 1 || val > MAX_TCP_KEEPCNT)
 			err = -EINVAL;
-- 
2.41.0.640.ga95def55d0-goog


