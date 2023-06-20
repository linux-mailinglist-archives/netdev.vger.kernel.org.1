Return-Path: <netdev+bounces-12328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817E7371AC
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490271C20C99
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF719E6D;
	Tue, 20 Jun 2023 16:30:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACD317AD3
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:30:34 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1566010A
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:30:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f9b258f3a2so23424505e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278630; x=1689870630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuFBhZfTmDJAZacaxfhCFb1KYqHWsBgcdKKRWfbEWN0=;
        b=ip/UV28rDJqQq2BbB/nmsQmvnh2Q9zK8z8PFY81lxd7V1Mp0OmCLkR5dQ8H83H4uhZ
         VI8ckfYU2yXe6RSJCQz+MCdkZsL6N3cT4j17mft3T53HJvQ0Md1HiTP8yi3/41nw/Ubw
         x8oAdzNUHUe24z96gHGyFJekPUO8N/UHQt5MYgV0O20aeH9Uh/+rHBfA+w36waFbuJL+
         SDUwRyoK0uWUi23fSE8RYOQOz0dtMZm3EvEztDKcQXvHTaMDvT+El3PlOQR1iIfbC2gJ
         f0OgPnCEtmtxTO07XHeJHpr3GDzMakX4XfsgIBszqdxHzit1a1MYNOWbtktAL69L8k4u
         RMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278630; x=1689870630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nuFBhZfTmDJAZacaxfhCFb1KYqHWsBgcdKKRWfbEWN0=;
        b=leXNRBXle2f6ztEQ0rea3a4ETbHFF5fHzYtO6BVMAFOq2A6iHsWie8YE/sjk6aVJV+
         SuqzeoySqo32c5LWaJ5Z/Lbr9fnwwLZZIF8HIvruGw6VGjJP9peXV3BxtLYbHlvSYVDa
         2vNrZJYZazoGNlgs9cUpltUlZpwKYBSE9CvJFPUmSewkPbxMogO+I4/0eGK7XLj5RaPE
         UvDeeQTAkm6hrLsQs9QpNeag1pWFpmOwaRRPTSxboJaNxxdwZ55ftDMuOQfdpBYkIgGU
         0dAjpTWGW9kGMKrbiC2pe0ai49owE8a5oaj6In5GvhXZUZuXoQAcOGrXuDiq6Rrwmx2B
         JQbg==
X-Gm-Message-State: AC+VfDw4PKdLSrfcuP60Tr9ch5vPjR0Z6wPDHcmUfgp3aESI4I84FgeJ
	1KjZS++5DpkSJtcQ6U+aMXqSTA==
X-Google-Smtp-Source: ACHHUZ7Mbq8cxk10O6pIhAs15469MAs+ooaNZINU+QWeHRJ6sFW9x/oVH2NZF8exPkXVmsPguMdlIw==
X-Received: by 2002:a7b:c8c4:0:b0:3f9:1bf:8704 with SMTP id f4-20020a7bc8c4000000b003f901bf8704mr10812613wml.6.1687278630558;
        Tue, 20 Jun 2023 09:30:30 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id y7-20020a05600c364700b003f8fbe3bf7asm12064342wmq.32.2023.06.20.09.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:30 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 20 Jun 2023 18:30:14 +0200
Subject: [PATCH net-next 1/9] mptcp: move snd_una update earlier for
 fallback socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-1-62b9444bfd48@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=94K2vUxW+7CjklZmQNEYvAmRJRbL9yuf+LzZZuN1/V0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdQku48aOBuwK+NuGg9HyBhX9pfXbAc1tubB5
 Yc83bLntdGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHUJAAKCRD2t4JPQmmg
 c38dEADNumynfgX24GcZFzNWCG0Qhbm504OpQxp+hEc7nrxy40pgn5aH/p3l0vib6cd4m6sRuSb
 T24Xb37opZtyyKTsQU3/LmZGX/B5mAQVrHEVMFBn7jelpeXuM4UYykGjouWcfM6uwjZ3j8S70tg
 31RxltoM0qpCJcjGtyZmWmhfCyknfkJ5O+LVErxwClw2a7L91BK/B+2p649JB5UfbxXFMePNAVZ
 X3S9n4B7IiGutxOgQ6px3ccNX72b/Anh8UNDcltzcNOUw+/tQ8YWIRyFF+DddOpK3l9kfQS8a71
 LcFntLBQEIn0EDEz25F3TUnaGCd80A1ODkQZ9w2LUrHdPGPtWhKg1y9QZFOOHzMmZRVhwColYx5
 TrUrxl6jgkrAXbMhBTGH1DVoTXlQdUSXRIBt8eGeC2Ly9K1QEV6f60qMhhL60EP/GIwecfehDBc
 LxcYov8h8S2GTceEytuzZrxZ9BujoyriEvQm+70LK0fUQ6SY+GLWPjbvbjYkFmJcU+yCAzt4qDv
 m8B/MPxPdqGUuGeEUTrVvJx99HIo8SaL1ZhysQW3vBF2TqthQc4srngJSuysYdMPMAky6QgL+nj
 u7CeM3NcZpmMCGNVI4WlbUXrbwgBbgk4JoJr67yoKsobiawHsa51vJ0ukaHl+PUmQZ+kMPwY0fg
 NqIfBLe0thFxcCA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

That will avoid an unneeded conditional in both the fast-path
and in the fallback case and will simplify a bit the next
patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c  | 6 ++++++
 net/mptcp/protocol.c | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a8083207be4..4bdcd2b326bd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1119,6 +1119,12 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		mptcp_data_lock(subflow->conn);
 		if (sk_stream_memory_free(sk))
 			__mptcp_check_push(subflow->conn, sk);
+
+		/* on fallback we just need to ignore the msk-level snd_una, as
+		 * this is really plain TCP
+		 */
+		msk->snd_una = READ_ONCE(msk->snd_nxt);
+
 		__mptcp_data_acked(subflow->conn);
 		mptcp_data_unlock(subflow->conn);
 		return true;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 992b89c75631..9c756d675d4d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1004,12 +1004,6 @@ static void __mptcp_clean_una(struct sock *sk)
 	struct mptcp_data_frag *dtmp, *dfrag;
 	u64 snd_una;
 
-	/* on fallback we just need to ignore snd_una, as this is really
-	 * plain TCP
-	 */
-	if (__mptcp_check_fallback(msk))
-		msk->snd_una = READ_ONCE(msk->snd_nxt);
-
 	snd_una = msk->snd_una;
 	list_for_each_entry_safe(dfrag, dtmp, &msk->rtx_queue, list) {
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))

-- 
2.40.1


