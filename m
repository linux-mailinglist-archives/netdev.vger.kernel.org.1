Return-Path: <netdev+bounces-26877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E57793D9
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173D91C21781
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954063D3A7;
	Fri, 11 Aug 2023 15:58:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBF329BA
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:58:58 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9843D30E8
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:53 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317f1c480eeso1904059f8f.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769532; x=1692374332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=st2NKZ9E1hXrfDL5Ot0q/FaTfuFvnM6rU0/aNjt+RGc=;
        b=TGFIIasqCurxVc8BEOtpb7f0OIiHFeMet4baqs+yRG+W1i1oVpnRM7RH/oRF2dGxHu
         C3yaSG936y/XFN8cFrb3PMr9yODT9g8P7U3CJvMLHGL72yTu++BvRLnXj8GK9c7yO4qq
         B90jn6CTED9DabWy5o4ivqlOkl+g/Wx9ue+bKmzH700b9rs9Fj5L51k/NsSviadPG9uo
         5Srlly7ULuVfkVqVLWSMgTKirFez42x5hJmEga1Wfi8xh29VbL+TXjSR3kIfTeMlETqO
         pOP7LD/6pkfaQFEyYmILGr4/Trla2LyutlHlST2Rxpc4G/wGX8MS6hGcXOQSoP15krxv
         nHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769532; x=1692374332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st2NKZ9E1hXrfDL5Ot0q/FaTfuFvnM6rU0/aNjt+RGc=;
        b=B13YSczrmpspEQ5BV3hrU1zKDbk+Q+H3NhQsB2XfrNBI6wjQLZAaOid2F+25y2k4BQ
         e7WZg0XH+ANcVSNGI2hgHBt3vCDAtC/Kdbe97yDRLFzMn8JyMhhMAjWrC3RnqBbTtZ1r
         MJFVyGLHPPdBnoerCwTtIgqXGa+fmtuc/49iurXUWNvZBmmb9sb9pd6XWT6xh0ydu3MC
         rYdQQfz4jOn6HywuB0L0vumf3FlkzlIn2r8IowfjLszmMO/wDh1OeNRbugPpbK6WSCIt
         VeVbl18BEwqmqDtKbrMoDK115+o7cRBa2kQ4XeCOV6J9E56QemnQqF1Yybu0hda8LV3U
         s2dg==
X-Gm-Message-State: AOJu0Yxcyi/yKAGdbCNAh9/PvO3bI710tNGg/I5ifODEyML4Nn/Awvko
	FFOe6yRnFWY868/OKoXDlxUW2Q==
X-Google-Smtp-Source: AGHT+IG6K+E9E28dAF2CoPZoZYVbMBVGSUSdw0piTwy+yuUln7CVT3T59uKh993Hsq2y/6zb/QQlTw==
X-Received: by 2002:adf:fa8c:0:b0:317:7081:9a6a with SMTP id h12-20020adffa8c000000b0031770819a6amr1667780wrr.24.1691769532173;
        Fri, 11 Aug 2023 08:58:52 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:51 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:24 +0200
Subject: [PATCH net-next 11/14] mptcp: avoid ssock usage in
 mptcp_pm_nl_create_listen_socket()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-11-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ryKEnhcU8jzGTw+8/ZGieSQgwwgsCHLHT0d+ugOOpQc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvmajEXvtvTqt8lHzWQds82lCmd/Y2V7HCi
 Z01gYHwgqaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 cwrJD/40dDF0EYxvn5MXmn3Z/EHHQzIE6RcDCAsJGNaSvTC/z0X5Qd57QL50ZkUasy7eWY/XL04
 dVxdTQXld587lj44Hpu4qUxptiGHQcjviVPK8jhcH9QBJME4PL9apiurN28mna90GcUCuZfgTWU
 hn1pw0e2lY0nEY91BMsvdrbgPXYQljrn+kn2O6nIkNq0WWsfphkTWNMfeBCwFeVzto6Kecrf5bI
 LVPSdRtuy+fBfG2qAa+HUyf5wvyo4Lpu3PBlWvJJuj3gL7Qjpp/xfXWMRhsTRpe1iHl6CmhhguS
 Nkag1RM90+SzkkKWzMKEZEJkWAgM+5hMY2Kzzodm4V6raj7tof+dxZdii0Zike1tiV0FTQK0WLo
 o8xPMddT995MaoIDY3QCxbiViJDQpRRUPH6+NeMWq+AheVQJauH2eLA2DotoBZUCVjbWTWKfHfO
 /jm3l4X8Xam9FNNKeFMQ/lr+ZyydVpZ1bx5gye6iBVHRH06E0o+J9stqqlmqIV8hQo8J880Fhr2
 eWvuLyMImbi0rKsspWbaphIL/iTrMjzaK+n4WkfcXtzcaQtn/9ROyHYtErQZh3A8wfdbMjJX1UX
 JkngATdTVyt+Kiy0BAHiirZrk1HjjgQkw+v5U+UJXvMBcrwFXQCIz8t/ECB9soCoeBK6MThJH5D
 Pr81hahvz6kdXcA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

This is one of the few remaining spots actually manipulating the
first subflow socket. We can leverage the recently introduced
inet helpers to get rid of ssock there.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_netlink.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5692daf57a4d..ae36155ff128 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -9,6 +9,7 @@
 #include <linux/inet.h>
 #include <linux/kernel.h>
 #include <net/tcp.h>
+#include <net/inet_common.h>
 #include <net/netns/generic.h>
 #include <net/mptcp.h>
 #include <net/genetlink.h>
@@ -1005,8 +1006,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	bool is_ipv6 = sk->sk_family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
+	struct sock *newsk, *ssk;
 	struct socket *ssock;
-	struct sock *newsk;
 	int backlog = 1024;
 	int err;
 
@@ -1042,18 +1043,23 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (entry->addr.family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
+	ssk = mptcp_sk(newsk)->first;
+	if (ssk->sk_family == AF_INET)
+		err = inet_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (ssk->sk_family == AF_INET6)
+		err = inet6_bind_sk(ssk, (struct sockaddr *)&addr, addrlen);
+#endif
 	if (err)
 		return err;
 
 	inet_sk_state_store(newsk, TCP_LISTEN);
-	err = kernel_listen(ssock, backlog);
-	if (err)
-		return err;
-
-	mptcp_event_pm_listener(ssock->sk, MPTCP_EVENT_LISTENER_CREATED);
-
-	return 0;
+	lock_sock(ssk);
+	err = __inet_listen_sk(ssk, backlog);
+	if (!err)
+		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
+	release_sock(ssk);
+	return err;
 }
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc)

-- 
2.40.1


