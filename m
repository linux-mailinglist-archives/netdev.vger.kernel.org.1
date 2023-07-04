Return-Path: <netdev+bounces-15288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57C7469F1
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCADF1C20A1E
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 06:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC0580A;
	Tue,  4 Jul 2023 06:48:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88127C
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:48:01 +0000 (UTC)
Received: from sonic310-20.consmr.mail.gq1.yahoo.com (sonic310-20.consmr.mail.gq1.yahoo.com [98.137.69.146])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E471C1735
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 23:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688453246; bh=8+A3hssWKx9fMAtGWKmfcPQW2sLlRb8An4XzdDXd2ys=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=hR/yryjqyEWaQl77Snq89cTWMroh/vKWLrcNofjZlubGqT845AHghEAX7NF0m6jNR74wlBd7SlKEWZIkx46ljF7eGwPIJICpTtyvo9tsOckUCr0QEXJNdNgjs+f+sTFvL3sVawDZnvE31qm7BaJCdytAKYaTpsBrcdTVxPdVwsQkc4E84S8M9EwI+iVBUTHsOSA6N6m3KeF+1detg3/25LApKZ/HGRxKTLK0OeH3pZOa3ORx7z8d6z/bbE9nLHk2AMWKTdsEZd1UuQRl5x25LJCEPhEMkow0HlDu2JoQdfsvNUS+lmhwVgpmFhhkxwT+L+7d0UUQA8BWxs2E40vCCA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688453246; bh=rLXYBPf5wrLgfVNRvY4uXGOTW3rci7nCuTL/0cWq1Kj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=U3xInOAZXXh8Rt3nVVdLXHWgEOiVCdBHPYijJmW5kY6R5dXiJP/JfZ0beX6/wlyR1HAfNGrdeFcp3ThZzdAsA2hMisMmXyEIbffTHvpflHvvMn16v2K5SK4oBPNPJn78QwJ/V4lF1jaxWOPhSaVyAPp0bPokfd+iSrGrZ/PhKmiN+VAVsLj/Qq9akpig3lEbDUndj0H3ebCnKIa3fcRG8hPDKCLxa1adooqaUlLmfSdkEvVuFju0BrRIAw+WhLutNMkEZ4tv5JuryFomP/rQBEuW+AOoAPVfd1jhLuyNG3qupV2zfZ6ZTDu3uAwi6D/PRcQhb/wF3HNLsvzk+fB8zQ==
X-YMail-OSG: mqY4jvYVM1lP9LtrCpphurtC2ClunU534oSgGNjHkuPY0vCD.4MMXUKQ.yyMHh3
 YSW5ghXEUvM_zILKFIYY8VmtpBP2x.ZJJY.S0.O23tj6wwBq.52oT6zq68vZGAQm098vnSrOi.eo
 4Bv0yZJvFdk1zbnYbdyKHfCJKTByicP8mTr.RBga9zK2qf8XBgHoR8Cz9v2sDKrL4jy65BB1M791
 ljkWevwDdDzUPopfi_cHViw3hf9bfDIUSlOLnL04iF3Mej9T8w9p9VsvzoammNBAvkilr8dY_54W
 OI2RxZik9tFkjafDJeqIMzco7y0wG80DRGyQyBVL16TG0AGW2AF3WM36ehXoGdducAx5sQ2rS7I.
 1GITujJXi1qSEWkmAZ6WA.UjR.VJwJJkxV1CNveVawsFGqm6.2abgSEoGJUXaR_lb8IWwJvywvNN
 1bqbzbh2IvvArWua8G5M7yyoRFW2bVQ4NANRnp4JvVyOKgqGa3EQlBQw3.xvUjwNp5s1AhRpoidI
 DTyFkbAs8eFunK.DXUe9.DqS8rAtOIgrJObmygCnXA4_nNMKvM7_s_nC6bRJTad33pV89vGiySIg
 xLzdstRXZTQCmtAKQnQoy6vd7QIJoYdLY2y71Bzy5YBNUjfovcTXY5P3K.Xq8W1CiZsu57R7psfu
 PoKy4W0qulKH4k2v.8.PEmOUD3YtNFUeAt2NRHZfVk5BG5OstjihYC9BOhxEJRbhIquXBUdD4Ymp
 xwWbbyTCxzk6jFVoKAW_SSDZrgEinmRmzc_54VFvRB8zZLOXcQl36jOhkLc.DBCpDb5vtKakDH5D
 hzdtQWDzV33KoC7Kab6cnw4he.GzOwFzRTTaNr5h.hNPMvrGZ3p3G.aAp9F8WOMW9VpROdx4dzm3
 ZDMYZTcTQ.Ptp._RaEpro3qFKAUVLFVEQn7MeFCaylaL6u325q0I4AGp7ISdYsyeZm3txIAk.dW7
 avkXtKnE.JNP4lDyAupU5OnWSrIiw7Ch65XXbZgqdGDDlSYR_tAC6tSH4MULat8Nyc4hCiA4qQtF
 uvOuJIFLAZsPquDrvKkduw3lVXa4n64gJGT8XozXMfIOgacH4h2IvsoSHdkJf.8wAbX9VgpcoxxZ
 M_8FRwCEuHeJeGcvUUVC2xNBe1iGm4UyXOmUO90vf0VlZjNs0tV.Bvde8UA7O8GxUZuENbegRuQk
 n8NUEg1R7LRQYmqFzKcdncgnTlTAGfYAmNtd0HPwW2GVYFBd7lsTAC3oXuWdHwDSTIwZw9.i6PmZ
 v2DqU4d34soA_79I4Hypw39e8DFg5qI9JOWnMTRTMoY6mHWD1lbSQr.Z05sXZ8vKjpLG.4rMpI7D
 RzlPAInDRlUd3K65pXPcCjEKCo8U68y__Rn3X.nsBxuc1CT9kq1MZsy.mXoshvyWcp3iaNIjup1T
 ZJ2BhniVN3KdDK6JB.CZx5fj2Z9Bg.ZuX5B.wWjN6n3q47mNukifqop4oOZ6aS6rd4pnqM7Jl.iA
 UCel4GIEKYdu9jhm6vnNYVvJGU3gS5Z9e0IX6zAiF.mQmXit.UOE0hMEuWUrqHnSxtp94J39LLcb
 W4cstkldaqJGe5khw7cf5ZKZOlDCmx9e1w.KKDl5Ma4LENjZUC3.sJV.W_jC.bO2TeDvHVIai4PZ
 PC42i4n3Dem7.ixW6KMmwfQftztiJZtbWPpkLpONMLVtVEKkJg3x_FcnBMJUqcPxg.GbMFkYkB8O
 32stoVNut24cDHRbUXIHGY2JuuVZ6nhQZt_6DJiFsPa8RwReUnA4q.azbESPqFMUJ613DECW.xrL
 Nh1iI39O6_pkXbZuXJv4u50C2baeIk4GHi8eZw7PPTzmt1cbg215z6BSa5ZVUyPj7lrMednjXWL7
 Y6C8QX9wcMtvqmM3tdG5MOtZBrAQQtsd4xe3pFNGnCmFZNHjP2WDM1paMYHtNkLbkxf7x9jRDVh5
 THvpLff2iA6uniEiYis55OcKTmGkejnKuEJ8kwXsTlLT_c.TA2xGfHhToKF2aDKdufTHzfxOYpuV
 t9w7hFMlvIRD6q_geyFJppBb6p1MRseoorPMl2a2mc3bJi2e7KpfdxIblMPgwUNj88VGHE6A23zf
 vJzctzV1OPBGdBvZ9r.vLjs587kmE48Fv9JjjIUwbl2QybsNVsIQsHFK2nJj_1IW5SWfok_Ij_3O
 pQ3gaSDa5hDtMKWeuGIb.wuAsRIpFFUuFL63IysscdsiRJinsOL1KsAY5jjSEs0DJRkq9oIjnyiO
 t3PAluEzqI.DmE4P4pW6TK81QCx4OYsPLrXcg0U6BBnrD9Oa0Mxl98bOohg--
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: 203ad4b4-5369-485c-aa49-3a13aa0a11f2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Tue, 4 Jul 2023 06:47:26 +0000
Received: by hermes--production-bf1-5d96b4b9f-8sjv4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 05cbd9aedde85f592cdddd53a107404d;
          Tue, 04 Jul 2023 06:47:22 +0000 (UTC)
From: Ziqi Zhao <astrajoan@yahoo.com>
To: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kernel@pengutronix.de,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@rempel-privat.de,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robin@protonic.nl,
	socketcan@hartkopp.net,
	syzkaller-bugs@googlegroups.com,
	skhan@linuxfoundation.org,
	ivan.orlov0322@gmail.com,
	Ziqi Zhao <astrajoan@yahoo.com>
Subject: [PATCH] can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock
Date: Mon,  3 Jul 2023 23:47:10 -0700
Message-Id: <20230704064710.3189-1-astrajoan@yahoo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000008981d905ffa345de@google.com>
References: <0000000000008981d905ffa345de@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The following 3 locks would race against each other, causing the
deadlock situation in the Syzbot bug report:

- j1939_socks_lock
- active_session_list_lock
- sk_session_queue_lock

A reasonable fix is to change j1939_socks_lock to an rwlock, since in
the rare situations where a write lock is required for the linked list
that j1939_socks_lock is protecting, the code does not attempt to
acquire any more locks. This would break the circular lock dependency,
where, for example, the current thread already locks j1939_socks_lock
and attempts to acquire sk_session_queue_lock, and at the same time,
another thread attempts to acquire j1939_socks_lock while holding
sk_session_queue_lock.

NOTE: This patch along does not fix the unregister_netdevice bug
reported by Syzbot; instead, it solves a deadlock situation to prepare
for one or more further patches to actually fix the Syzbot bug, which
appears to be a reference counting problem within the j1939 codebase.

#syz test:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Signed-off-by: Ziqi Zhao <astrajoan@yahoo.com>
---
 net/can/j1939/j1939-priv.h |  2 +-
 net/can/j1939/main.c       |  2 +-
 net/can/j1939/socket.c     | 25 +++++++++++++------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 16af1a7f80f6..74f15592d170 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -86,7 +86,7 @@ struct j1939_priv {
 	unsigned int tp_max_packet_size;
 
 	/* lock for j1939_socks list */
-	spinlock_t j1939_socks_lock;
+	rwlock_t j1939_socks_lock;
 	struct list_head j1939_socks;
 
 	struct kref rx_kref;
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index ecff1c947d68..a6fb89fa6278 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -274,7 +274,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
 		return ERR_PTR(-ENOMEM);
 
 	j1939_tp_init(priv);
-	spin_lock_init(&priv->j1939_socks_lock);
+	rwlock_init(&priv->j1939_socks_lock);
 	INIT_LIST_HEAD(&priv->j1939_socks);
 
 	mutex_lock(&j1939_netdev_lock);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index feaec4ad6d16..a8b981dc2065 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -80,16 +80,16 @@ static void j1939_jsk_add(struct j1939_priv *priv, struct j1939_sock *jsk)
 	jsk->state |= J1939_SOCK_BOUND;
 	j1939_priv_get(priv);
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	write_lock_bh(&priv->j1939_socks_lock);
 	list_add_tail(&jsk->list, &priv->j1939_socks);
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	write_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static void j1939_jsk_del(struct j1939_priv *priv, struct j1939_sock *jsk)
 {
-	spin_lock_bh(&priv->j1939_socks_lock);
+	write_lock_bh(&priv->j1939_socks_lock);
 	list_del_init(&jsk->list);
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	write_unlock_bh(&priv->j1939_socks_lock);
 
 	j1939_priv_put(priv);
 	jsk->state &= ~J1939_SOCK_BOUND;
@@ -329,13 +329,13 @@ bool j1939_sk_recv_match(struct j1939_priv *priv, struct j1939_sk_buff_cb *skcb)
 	struct j1939_sock *jsk;
 	bool match = false;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		match = j1939_sk_recv_match_one(jsk, skcb);
 		if (match)
 			break;
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 
 	return match;
 }
@@ -344,11 +344,11 @@ void j1939_sk_recv(struct j1939_priv *priv, struct sk_buff *skb)
 {
 	struct j1939_sock *jsk;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		j1939_sk_recv_one(jsk, skb);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static void j1939_sk_sock_destruct(struct sock *sk)
@@ -484,6 +484,7 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 
 		priv = j1939_netdev_start(ndev);
 		dev_put(ndev);
+
 		if (IS_ERR(priv)) {
 			ret = PTR_ERR(priv);
 			goto out_release_sock;
@@ -1078,12 +1079,12 @@ void j1939_sk_errqueue(struct j1939_session *session,
 	}
 
 	/* spread RX notifications to all sockets subscribed to this session */
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		if (j1939_sk_recv_match_one(jsk, &session->skcb))
 			__j1939_sk_errqueue(session, &jsk->sk, type);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 };
 
 void j1939_sk_send_loop_abort(struct sock *sk, int err)
@@ -1271,7 +1272,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 	struct j1939_sock *jsk;
 	int error_code = ENETDOWN;
 
-	spin_lock_bh(&priv->j1939_socks_lock);
+	read_lock_bh(&priv->j1939_socks_lock);
 	list_for_each_entry(jsk, &priv->j1939_socks, list) {
 		jsk->sk.sk_err = error_code;
 		if (!sock_flag(&jsk->sk, SOCK_DEAD))
@@ -1279,7 +1280,7 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 
 		j1939_sk_queue_drop_all(priv, jsk, error_code);
 	}
-	spin_unlock_bh(&priv->j1939_socks_lock);
+	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
 static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,
-- 
2.34.1


