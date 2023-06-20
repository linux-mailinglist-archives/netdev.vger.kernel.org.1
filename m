Return-Path: <netdev+bounces-12334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7572F7371C8
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75D51C20D28
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD931E539;
	Tue, 20 Jun 2023 16:30:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC119522
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:30:42 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE8F1731
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:30:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f909853509so28658805e9.3
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278637; x=1689870637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7elg4draWHNpGjD0HLDzJ+3OyRSgUqMtc+y+geeEHc=;
        b=fhdDkTczBb6rVV12XCSs39fdpf55epJ4y5zRoQJT4xQoM9iIJRmDufHZHlIIcb7Qyo
         h+6PVjFheamz0VSQ78gJKyXdF3yENiH5+dS9AO2Vgqt9dQ3MEEtXyi/1ySdCS53TcZxA
         zQtSpbckW/mT68NuBh3ibnXPoleFYgEEBufh4Tp6QS9xVrpYVZr0fBQpMpLRROVRaqfd
         aFC1/0yE6n7xYkWVgUuFQyLTIK+TuFMCNm5ln5wqaNgLz27HNiBMS2Vk9trpk+BPs/+q
         wlkEgh/7ThT+IxasDcGdlWeksqxnSVXO4rJRsSNy0Ouz5P9gG96knLndmxy+IJSmfP0k
         Jl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278637; x=1689870637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7elg4draWHNpGjD0HLDzJ+3OyRSgUqMtc+y+geeEHc=;
        b=XCGKKLAUE9PMTGd3fm0tuImA8toHHZToqndTMISBub5lLT3VoIXQAUK648YVbwewmR
         boaogZ5XG9UlTCnh/jdlRLVPPYBxxmBISkZdUPfEBUy1ED8xNh2P5Pbz+LLiBM+wD45N
         MpD0/rz/VNAa0jxvhQSraF2wcsQqP0JbB47xmSi9Dz/JSws6wRr+kBtv6zXiRoj93MMF
         dUDUcKk930luub6EzDOQN9J0004gE/LJKu90WcZeZkuVqu6zYcTbwsCeglJ8RNdtH4n1
         TPfCQhRpEF5KTncyeZcfEyPD9ICcTeTYhX7ZY0fHXL4PdpKkCWjgabpX7ypfOcQnNzAb
         JxRg==
X-Gm-Message-State: AC+VfDwX5qXhvVxwAUgvpJ3yfFBKryW0TZdu8nWJP7x/TmPEM2T2sfzB
	48YcwiA7DPpG9eT4QP5uZ22D/A==
X-Google-Smtp-Source: ACHHUZ7fwNWKNT8E7GKIMsrZniopnHnIcGVJJdgTDGjgIYfQYpGyRFGJw4lFtdWwUQZ0WA+585VQjg==
X-Received: by 2002:a7b:c449:0:b0:3f4:a09f:1877 with SMTP id l9-20020a7bc449000000b003f4a09f1877mr8650689wmi.23.1687278637169;
        Tue, 20 Jun 2023 09:30:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:36 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 20 Jun 2023 18:30:21 +0200
Subject: [PATCH net-next 8/9] mptcp: consolidate transition to TCP_CLOSE in
 mptcp_do_fastclose()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-8-62b9444bfd48@tessares.net>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1968;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=J0hbphqDnBQXxAYln3jyFeuXYGpPLcu5bRjMLswg8ew=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQkQp7ZphscCESHFoCADk9udZaIhfe1hxTej
 uZAKnNJS0KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUJAAKCRD2t4JPQmmg
 c6YaEADNIuJ+BTrKv0+V9hcb8zkqWKeXlBnXPs8LCezMBeJqm0szcDC6fUlr5nUouQpf+qsL63a
 wwdQvNvpgHDbMH6oVGOOaEmAtnqX/guDsqid6bKqbsXqhvh4GwRAHQfHncVyGVZSG9+incwolfK
 eDVmThQo4GhatAajhbFaCufHV4FgBeF8eT7CQ4jjIY7U3zBDJUmQRCOBwfDvzCd7JJkVN2VEuLo
 oqblrQ/hrbBYKHZ5NHwXsJHheT7ZOC1DItwjpc/MbC+RPd9BpopS8WFHKxwtjNkQPjJBjkeYiI3
 6/R+evhOwDMnCmV/X/rvOqhTpssdtIoo1n4m3gFCJWG6TePolrNrclszyAG6yvJSEzgTR8oF1oQ
 aqvYsgYa29lB+GjnYyawfTThAXpWnjN3ERRk3Doi0KT3sRxGMmWL7OfJokKR5iQFf0w+MXdGBXK
 MjGb7FsNHXtbLBivuPndenEuRk0EGi2xm4vPecXNyswzx2gqMm9nwF+3Q4z367STZJj/u6Bzd3k
 Jg1z0AqzVaSnjuc1BgYKsl1fpl9Gzb7VAcmHdQWwAe4R10bBLI1GjK9c2fyK++Auhycn3ED1DEI
 bwfwRNr1ajskPGDpP6rG28b5iyEglNRAoJEs3UYOcc3gHbIQM2lcNNmv9ymjyHb8OmrDDSvRwTT
 Lj5X395gifMiS5g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP code always set the msk state to TCP_CLOSE before
calling performing the fast-close. Move such state transition in
mptcp_do_fastclose() to avoid some code duplication.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4ebd6e9aa949..f65eec3e0d22 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2655,6 +2655,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	inet_sk_state_store(sk, TCP_CLOSE);
 	mptcp_for_each_subflow_safe(msk, subflow, tmp)
 		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
 				  subflow, MPTCP_CF_FASTCLOSE);
@@ -2692,10 +2693,9 @@ static void mptcp_worker(struct work_struct *work)
 	 * even if it is orphaned and in FIN_WAIT2 state
 	 */
 	if (sock_flag(sk, SOCK_DEAD)) {
-		if (mptcp_should_close(sk)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
+		if (mptcp_should_close(sk))
 			mptcp_do_fastclose(sk);
-		}
+
 		if (sk->sk_state == TCP_CLOSE) {
 			__mptcp_destroy_sock(sk);
 			goto unlock;
@@ -2938,7 +2938,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 void __mptcp_unaccepted_force_close(struct sock *sk)
 {
 	sock_set_flag(sk, SOCK_DEAD);
-	inet_sk_state_store(sk, TCP_CLOSE);
 	mptcp_do_fastclose(sk);
 	__mptcp_destroy_sock(sk);
 }
@@ -2980,7 +2979,6 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		/* If the msk has read data, or the caller explicitly ask it,
 		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
 		 */
-		inet_sk_state_store(sk, TCP_CLOSE);
 		mptcp_do_fastclose(sk);
 		timeout = 0;
 	} else if (mptcp_close_state(sk)) {

-- 
2.40.1


