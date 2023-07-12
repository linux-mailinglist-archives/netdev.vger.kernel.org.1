Return-Path: <netdev+bounces-16999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD48174FC64
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD019281833
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C36C39F;
	Wed, 12 Jul 2023 00:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D74362
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:49:39 +0000 (UTC)
Received: from sonic312-25.consmr.mail.gq1.yahoo.com (sonic312-25.consmr.mail.gq1.yahoo.com [98.137.69.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9E1998
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689122877; bh=8+A3hssWKx9fMAtGWKmfcPQW2sLlRb8An4XzdDXd2ys=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ECTflWnVtCyVrI4sLpYfZSUCyHA9lmMbfupFU6Xvw7pnZrM+WtADHYYFWKnLWj/R70uK3DcZj56ilumJDtB/HbLh4lZPdn6YW52p0JoNLQr2BN1E8Sz6RurM6rsBqFVrXXCsL+yDheRrWITAOdJFoiAoX5P9wQeR2ii6sKDzfMFNe1dIw0oTaQUqTSXJTpRLOPIhbmP44s6nmRdn72mIBhiE/DnjGPPeOkJilAqYvTANudVXMp+z49Y6qpFGDgtxE1PAZJjjWW2joUCCXTv1XiL4zaEGxJ0L7w19S7csi6s8GCRHF02QQhsThLdBjFWz3FrnsaSy9ETvtAD8Y6K67g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689122877; bh=ORFNnmzAONreZ8M7Y0QoaSaiDuK+RXPskkTUFLOZGxc=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XLrX3qhoyJHYPRkVAxiFeeCU56gaiROnpiwhuhCG3ZupEguHuFIoOHKhhu44b4q0mA23kMaDR/awalkuuaJnO/LlC7VFD7IE4G5HG3s4QDbfK26t4Tgkot6BEdHNHGLW5swZkEEGX/aRm8Ei7qVAQClkVK4dOLPTm4TIXjUsN6dlsSXPnIzo5Hq1KuKzUm1jQXmIhgnwsLAocHXHqYo6dY/Eo4j+XdV6W9mQX/wFYaecAi35du6kcRsYNtWMXJMgze1zkRC7NWsLCE+CaRMAmv6upy1IXtOPtsPPHfONH/oND8khrO1Y9rSUMVjGiZgyOND5oV0X/5F4RHVoy/+IMA==
X-YMail-OSG: MGBqvtMVM1lfJxfYspC5W78rO5B5vetccJiVlj6lgRXVEkmmtK0yMBt1YCmufuB
 nnuSsR9MIVcDMwVfHyNfoZG7rzJuOKa4b8SEoYK2MIz6XMrYNpoIle4U2qqpyw4YdXRuEGGYx1Wq
 7hSPK6RPXcP.mcOGRBKuLqrc0gAbykNg_2o49NghyThpm8CaTwwYfTEIFwxgabz7RSfrE2njuWhN
 Ne32LZKw9ORCgMJBgscaozV0aAguC_BUfh_44vyVOMat5qMZ9Iqpy2fYvMbyqqj5oIYkL1y4vXGg
 LgRcYKmBTnNSTWPF1B0GQofXtebGBU4kYY9AZlkeG0T3N3VWEW8cHlSHSt36btX8k1IcAtLd8TBv
 CzslXs4ZpRq1QNeC_K.JfB68PhxRmMQwjscp6l6hTZopGbrgbNkBZGAbHXiVxxitvKux5o1T8s_d
 dkDgzorLjt.INiWQrpkletkvnbGQb0iCZTcYnS3.sgA37YN3FdvjrI.pjt3uL2DlRtMhK7fQI9q8
 bCb6lyolS5vMcp1NOGKn733GJk12spoCAbummNYOS9N3Zfn6BpC_YrExBWwWTVSE1d4cZuU39wNc
 LPtwPTPDfxAazTtSttjaU0BhMpz5tre1yRq_GvVB9GAske4AeAvBzja2mWRWQBS0u9sPpb8AdTo_
 B8Lm3YLqhGigI0PkHVV7fp9M80NccA1a7mObYjlBjS7Xw8fKCl5DXpuzSrqTkk0TrBPQh7rRt7sF
 P3ryetkVkNGWY966m98P5RKE9Pu2f6Bku02qbuQ_CIGHlhDLr7F9Y7EzpZRnykRz9V6gVinIii5q
 n049HOzTiSKhq3hKnPXka9njjp2Oy8b8NxE8WM3LvAhb3nJaM3SVTQVVJvJap4Z4Z1q1q0xZl8Qc
 qXKRFceIGPbhkKLEzcOihDm70n966VFOqlnqfFeEIZq7.u52SzdLBAVQvU3nj1AYOLhEh_xBm4QI
 6mOaGNKJRBePl6w37r4.irGMnYao5jfb4trgGtndqnS6H55Th5RLd3.DC.p6gtL.yXrjHuZEEgjo
 c12xAKrVfCcUkNq6oudl_vnTaRagPaNj79eu3BykzNh5IBXoYgfuR_CW5oAHqZvoLhu2pBZy9gXx
 tBly4xNhSRxpwdU.QFqfh3LJXZueN.1JNdWAQ0vwtZ2Yjl9DIUeKEpFgK3D1TkK4g49QRh2kfVTn
 vxzxAcQ8I3iCsUjsteQzSn3p25QkfPb_cGOXgP7QyJzgbTREf3Y_XO_kIrcrpL8PHwbr36vXJlRP
 MT5gI_STl7qXkPjXICgHP42frAlbazCX8v9tUPjyUtTyaIS6ohfMa0Mfui0GA1HeMrzW6lXnuKCL
 _BL8QkTqGqXblcjrYfLN515Ua3UtLhasrsKGenxfgLBgx3gISu4ny1Vl1619b5DiD385xPXFd90Q
 EsqaTx2cj3WZRyibLYfLZ36XSvywBj9xjSlf3mTF47mAxsAoQCu.uI7_FkQwNZtykrhKvLbV6AUs
 17yZHYY82apw1xeQ86Sh0_ihEQelmApFnnWaYmAAhmfNkntYwWlrcSS8Y4vdr_H96Vhs5bGmB62Z
 6qoVZz9rn7vGtCcj0rGkTZ9xiArvpDSeNsUF.COUA5DZzW1fz8euDe800PDuv2NSdZOx5uQnISQK
 6nNG9FV.3cTX89OnpV1XNreAsQZ9PvVr0Z95stDtGGmJuSEsBFx5SddxcXwDpEulyQouNA3FIkQF
 bYRQzJDMi4JA2qrigERFe8i33Rypq_gsOPphn2bbQKKRT8n85eNM10kOvUSvqAxzYhyHr8f4e.0q
 JsveGOJx8_OBBfA2QmD6aYZTqJt4BV6yYX59c6chYXjDDl.p6Joa0hzhFbzgIzn_Lz3BojF2L.9O
 RlDbe3PUg1WMxk5.qKRNZFKDuh.1ppRxQhawqsM8GyqO38M0pRZsSwMOJ1rBmle_twfAKiQiFSPQ
 c..21hcok4ZDpR.KKEGxHb7OOlsi7kEq61Kx75UZlsHMsKkPbQEtf5im6ejfGUaycFsPYE0RwIgQ
 UABEk4WamJNbRW6_EuvJ9SMTf_FnuXmTp1aKNIkKuoIkxp38wbTIE4b47E4vIMlcZ9FulZ0dKM1H
 Rk0Qmr.YLGW2Yn72_2SgNBim_GcC73F6kvfWvJ5zKuIZmzWdN3FiGSQMtdIcpkIpq3qHHn4VrIbp
 DXCuPbiE3mVptC8MVn97MRXGkqfIUp1RE73rvG9L6QVophryRD2nqKEqsKp3kPP84g5thstCJLMH
 1Txws0pb_IvPFkD0BfR.K51Lo3_hECJ2O
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: fc3dedb8-af40-496e-afcb-e138abeb7742
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Wed, 12 Jul 2023 00:47:57 +0000
Received: by hermes--production-gq1-5748b5bccb-jz9fv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d037bf7637baaa70e79099ccbe3559f0;
          Wed, 12 Jul 2023 00:47:53 +0000 (UTC)
From: Ziqi Zhao <astrajoan@yahoo.com>
To: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com
Cc: astrajoan@yahoo.com,
	davem@davemloft.net,
	dvyukov@google.com,
	edumazet@google.com,
	ivan.orlov0322@gmail.com,
	kernel@pengutronix.de,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@rempel-privat.de,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	robin@protonic.nl,
	skhan@linuxfoundation.org,
	socketcan@hartkopp.net,
	syzkaller-bugs@googlegroups.com,
	syzkaller@googlegroups.com
Subject: [PATCH] can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock
Date: Tue, 11 Jul 2023 17:47:50 -0700
Message-Id: <20230712004750.2476-1-astrajoan@yahoo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000b57ce3060025aa46@google.com>
References: <000000000000b57ce3060025aa46@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reported-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
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


