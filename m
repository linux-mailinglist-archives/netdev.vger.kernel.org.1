Return-Path: <netdev+bounces-14114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E0573EE4F
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 00:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A53280EDF
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6880A15AC5;
	Mon, 26 Jun 2023 22:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984214282
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 22:06:02 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6CE59CF
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:05:41 -0700 (PDT)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 79127413A5
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 22:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1687816801;
	bh=WrPgRiS83Y2mIcWHryPXtoWboK6sANlwF7CN0nqeeXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=qQM9tTvvQdz58zqZnYVXLY6GLI53DKyGpp1cmabVV0YHUgPFsSGgWn8ds4RphxJfv
	 bH1U9tqEWSzwYgpf3aE2X/Wm8U9uEG7PNjQ/5wS4X6XOLDwy9QVtPZB7ULdwXAbxOt
	 I8HrZ8Bb45gBYSyrfX2xnvKhIc/IPglLNJojJaZ7EbRdESmZp3wa7GdUbN+xaoyAlO
	 ZCzmYwN1N2HYuOtu0vZR7IxNFULCHEMAyP4UYvd/9tqgI7abTqzsxMrUxlDmYWM3CG
	 xdoM1jEtPXUrxcr64bzKv8lwssKJfsP54g8IAYezRVCB7anJKzXtRrzXQcj8kQoP4S
	 q6bh4J1FtK1pA==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b69dcf0d73so17330121fa.2
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687816801; x=1690408801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrPgRiS83Y2mIcWHryPXtoWboK6sANlwF7CN0nqeeXc=;
        b=hMPyIh1aj0DwNoSu35ZyBgCJ5r80MVbsOwCFubjroUn1pp+w3mqYGJsu+tHrgkQJjL
         EIbJ3T2TFDnVoDyjwqy81P60rR2k8npubK58QKHjgbNmpFn5TRVtumHS7+NR9AnLOUuK
         jmASUY413aIJfiR/E6AyWfVyqg+461S4SHpnu8yI9ainsrjExKy3z+f0wAYpRe4xMFC+
         SFTrEKllqvgI2HrpZEoT9wfE/Q7hjtzjZXOsIR9zax5PfFskITOHMx/EDNV0cE+XpH0E
         DHxmG60X/CgPrIBAwG/hCVvQs3kiKVjbx5KOk67TxTEyfh6ReviTW+dxP7XKBWu7PImw
         oD6w==
X-Gm-Message-State: AC+VfDx9KJNTlpZEOiKv9SN7VX36o0aIgm89dXUSRx8Lucf6RSTeXXBc
	pegsIzP7GSUOLCDrPk//2il5MM70HvRCJVVtWAoqJTHBP4ERf2sWAF/PG+T2GIZaO+Ea/k5kgul
	H1Bz4JX32lLxfBK9KFPfTGq6bhsRxi53fgA==
X-Received: by 2002:a2e:8689:0:b0:2b4:6195:bb2f with SMTP id l9-20020a2e8689000000b002b46195bb2fmr17494472lji.25.1687816800744;
        Mon, 26 Jun 2023 15:00:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kEAG7BKp281vQ4Tc4uIIwnYqIhjtiqYLG/VOPCVutTsyYJTaNlnV0Ghbwg0sP5GAXOWPw1Q==
X-Received: by 2002:a2e:8689:0:b0:2b4:6195:bb2f with SMTP id l9-20020a2e8689000000b002b46195bb2fmr17494457lji.25.1687816800440;
        Mon, 26 Jun 2023 15:00:00 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y7-20020a1709060a8700b0098f99048053sm2097490ejf.148.2023.06.26.14.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 14:59:59 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH net-next] net: scm: introduce and use scm_recv_unix helper
Date: Mon, 26 Jun 2023 23:59:51 +0200
Message-Id: <20230626215951.563715-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Recently, our friends from bluetooth subsystem reported
[1] that after ("scm: add SO_PASSPIDFD and SCM_PIDFD")
scm_recv helper become unusable in kernel modules (because it
uses unexported pidfd_prepare() API).

We were aware of this issue and workarounded it in a hard way
by ("af_unix: Kconfig: make CONFIG_UNIX bool").

But recently a new functionality was added in the scope of
817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
and after that bluetooth can't be compiled as a kernel module.

After some discussion in [1] we decided to split scm_recv into
two helpers, one won't support SCM_PIDFD (used for unix sockets),
and another one will be completely the same as it was before
("scm: add SO_PASSPIDFD and SCM_PIDFD").

[1] https://lore.kernel.org/lkml/CAJqdLrpFcga4n7wxBhsFqPQiN8PKFVr6U10fKcJ9W7AcZn+o6Q@mail.gmail.com/

Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/net/scm.h  | 35 +++++++++++++++++++++++++----------
 net/unix/af_unix.c |  4 ++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index c67f765a165b..409b8efda2c9 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -151,8 +151,8 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
 		fd_install(pidfd, pidfd_file);
 }
 
-static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
-				struct scm_cookie *scm, int flags)
+static inline bool __scm_recv_common(struct socket *sock, struct msghdr *msg,
+					 struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
 		if (test_bit(SOCK_PASSCRED, &sock->flags) ||
@@ -160,7 +160,7 @@ static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 		    scm->fp || scm_has_secdata(sock))
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
-		return;
+		return false;
 	}
 
 	if (test_bit(SOCK_PASSCRED, &sock->flags)) {
@@ -173,19 +173,34 @@ static __inline__ void scm_recv(struct socket *sock, struct msghdr *msg,
 		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(ucreds), &ucreds);
 	}
 
-	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
-		scm_pidfd_recv(msg, scm);
+	scm_passec(sock, msg, scm);
 
-	scm_destroy_cred(scm);
+	if (scm->fp)
+		scm_detach_fds(msg, scm);
 
-	scm_passec(sock, msg, scm);
+	return true;
+}
 
-	if (!scm->fp)
+static inline void scm_recv(struct socket *sock, struct msghdr *msg,
+				struct scm_cookie *scm, int flags)
+{
+	if (!__scm_recv_common(sock, msg, scm, flags))
 		return;
-	
-	scm_detach_fds(msg, scm);
+
+	scm_destroy_cred(scm);
 }
 
+static inline void scm_recv_unix(struct socket *sock, struct msghdr *msg,
+				     struct scm_cookie *scm, int flags)
+{
+	if (!__scm_recv_common(sock, msg, scm, flags))
+		return;
+
+	if (test_bit(SOCK_PASSPIDFD, &sock->flags))
+		scm_pidfd_recv(msg, scm);
+
+	scm_destroy_cred(scm);
+}
 
 #endif /* __LINUX_NET_SCM_H */
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f2f234f0b92c..20ac83e012e4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2427,7 +2427,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 	}
 	err = (flags & MSG_TRUNC) ? skb->len - skip : size;
 
-	scm_recv(sock, msg, &scm, flags);
+	scm_recv_unix(sock, msg, &scm, flags);
 
 out_free:
 	skb_free_datagram(sk, skb);
@@ -2808,7 +2808,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	mutex_unlock(&u->iolock);
 	if (state->msg && check_creds)
-		scm_recv(sock, state->msg, &scm, flags);
+		scm_recv_unix(sock, state->msg, &scm, flags);
 	else
 		scm_destroy(&scm);
 out:
-- 
2.34.1


