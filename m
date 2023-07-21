Return-Path: <netdev+bounces-19963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F075CFF1
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2AB1C21358
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891A31ED27;
	Fri, 21 Jul 2023 16:44:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B591EA84
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:44:38 +0000 (UTC)
Received: from sonic311-24.consmr.mail.gq1.yahoo.com (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705BC1BF4
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689957868; bh=8COXdqwHqW8IP794Sq9JAJB+e+BdIi/e3dcqMlkJ4oo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=uEWGfZHLu7PXvQbMSdI3krSxWdKYoiezAzQgWSN4O9iqeXDdM5XMxbCWqIqFN7PZdV2tOuFUnWDc317R826hpgHlvjBs+K1pJvvbWiHk0aefVfF7Pf6ZyS7PYv5/KdWCSJ8HnbmeaVR2zn9JXXEPFRZmWccwj1YpPMeDRPY4vgHp6CDVflrpEH4lO7ApY1u59GVgG2B8rrPRahx79dgqbxnzISp3uazT/4jogfCd3vRKjXswdn24TYq7Opnjk3LT5VgENYywi3rLc4BKcMXpt3OJeUfpHQWU7MS1Tvxj+a3aBAbKnIVhXxuQtcu0NJ9wdpF7uzLLgsIJPRIxjvrqpg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1689957868; bh=m7OvO28vzbMXpXrr+7k7zawKZRdCffSjP7TEKPVmZON=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EE2ixZ5qiMjMZc8NEo1J0BVi27NjopgPF6H7rE0s/nPLmMolOpXn1Un/VTLXl4//4UBqF0OyYmsL+P0emPsrOGjr3kZo7/Qi146KmJw1I7CKVfBscXXGiufCIlDEpyWtZg2M5vUwq2X4qFTfUwbudqTyauK77nsGmWh93qds5TppWrZoXNrChNJJsN7TnV9e+ZhalbLEw6GJtSn3r6G95uQUCnUNUe7ylULgiMSUxLSE7hzwQqBd10MTWMSWz0gl5CNof7s68mG4mKCzABZPbZOZ4ScfK7lGmX41OZyK5wYI/MTlZCXaqmUpwHxHxm7Lu9LXAKB1wsNNZoeGpvFiWQ==
X-YMail-OSG: 4s7fEo0VM1kJOB9QjtmWvdKm1rS8R8bsMUeL1hb7rvIjCsXjvifUO8.bSViRbft
 RqhW_v46jm8.MSYOl0Qiil71mruiL42xdt0edQqxOXUBCBuuZkSDKdipffOJFHm08SYln57FW2Wb
 tnr8wCkMqzYUI0sRi9Pv5kuDy1s2q.UNdp18oT3a4SCwUXjMb9r2Bm4IQ4Kqg_QIRzWji4mkcqPg
 BgiSh7Vst2qGSeAtby6GkErBoG0em9NXsAyAL7HHMDt1nrNVpyjlqZpknBDLY6SB83iKj3XhYH_W
 6OiEMMh9n80onkuxiGeGz3wUyEgqCBk65mW5vlYMtozlhvYqmi4.tneSiZbBTeNezWmeGdLbDnbG
 o6thumoOg9sWp5A7q6VtE6TeTP1gQdvRBHZvI9JPkOhAtVl2NrsuBCYVUSdv20pR665wZ9INo6VT
 z_RY5Ldwn0XvSUFKZAd61.BEBCOII5Cue4kBmPvUH6VTlZFR9Ty..atvtWVOlnxs.6QvKNGEO9iD
 8QY8_0.g.vhwqpgMoRb72RSnvVe.nuLq6V5FGoFsegiRVk4dXM0oXIqUe3KH_9n87OLEr09n8XUQ
 FhtVeoeuNFweJn8Lzq2qT7dVBbf.yRq0i2Nk8y2X1A.5pM_HkgNjMMGYqsv1iXqQDktw8A3.ovaF
 MD0vcjNmIA17NEbhGTO91X38om2XvWE9OapbZZcNX8LGq7NbTTMpyDaCKTwp17Mb82kqDU0IUFiu
 6J4StutjrgNY1JEgvqSqx7krbROXPur1a97ZYvj0GF1NldjmUENzcJrAfL.__7HTW7PvNHPobI.n
 zGaxbLFt1_A2CHPgfOBjSC9s.CpaFOj1SqYtLs_t35XINRQGhpQOxbEMcyCD7EROVaCmCRHfMMvp
 MlFOlq5uZN4dYosCMVOcENXrdKNzxxul45N.3nbcidRi3n41nSdByNaGmlcDNArCImTQNt9CHRZT
 yFtp6qkg5ytAuRfKRfoHvnGnuxRxo9Mtaj.769fFh1gJq9.1cxuaTHlLY4B6ai_4JpY0rteL_tN0
 owZlYZBUkm3zVNd.gF6Wh3FMoJo.7Ye0QnuxGT_hEbW4wLn9wOnLUy0x_U2eHw7LLmHmnDxmMx74
 4JA_jPyrOnqhLk9ev5Ay4OwLKBbEMTK0RIWq6SwJaZ3L2MMpUyJJ94_qpJArik8XlJL9IJ27hxvf
 XDfByIRGaYuoFBR_3pMccGCKl0J6kdkZHrvavDRjxznS0o3iz5S7EcdKJGWI2EToOAsiyAuyhUgb
 DxGEtavK12k_GRt0vgfup0I40PJ4SeppX9a8RHKSs5EAHnNBaXnO_.hVLvmAqqGq_lrIofvy3doe
 d5PIwiS2OOv88kcAVhBOrF1SaLkjkRcAHq5wTGCvVe3uzsbxSu79BTerMSj3rvIF7f5xmRQwQqIh
 DlghkhDmcXYCcQ.vAW_syG438KS2lv7JGKu6ftSqmtK6ArJy021Fe6H7Lqp7bkpIc1YuBVwGSL9Y
 fstKtvG8vYMeH.SotpWc4qfJU2MHrFIUfG6jghi1vThj0LbvZ_sZQgm8mogETeQi.J7rVZ9V0gjj
 aANcsy62OIN7Kk.A4NKoq9EXsd4tXhDNw71BixX5EVIas2_RoC5YFL1tMUpo6iwuFmPmMKX2.ax8
 CueD9HEE6ljub.xrVTvhFTX2KW1gS8thqT1Wuf0n6YBkZYW8KlzLwCjzjKOVCxxWdjqxt9Ipfusw
 Y1wCO6FjzWFQGQCseICACMk1sVIbCEX4vbnykavTYPkXXc2QfRcWSJ5XYUTAf9dwc011.y.DAC3r
 c7yQ.rvOPBg0nAd_GTAXBlkDA_pWlJKl9OE_GnORIc1RuKlCWs.8B35WyIUbHSIgu7lnC_piK.tR
 meheFpaP5.rehK5M1EEWclBZwU_QGfUCmftbOwBGUK81JpFxVZhwq7YziBS9PrYy8NYKB7j4nuuo
 xMieJHnHUHQ2P2dQKmBL6uAg59EMu6_QWoVY6LyZfqkXiAmek6MGnZKG6fW5suowddLP9MI1CKHa
 vawd1XBi3b4SAftWJ5pFbQjfHwIh.B9_SOn7ajPCNvZkFgOWW7dG7uT5XMSLmNStDfw0pOO3_Bsp
 gQ1if4uA.Vn_sUqckjBZWL_IcLU8e06_eBjxb3ZX38mzPz8JNyvnRVja2A54na.8RXAy24md.jy5
 Q.5LNT9fr1h1DY0WZU1pSUPtqMnYa6D3_LtnKo416qB1SekEVeZo.7_QQxrhx52bSa2pDDpqkPRU
 7B1MiRSvBzMiefWbGbl.H3FQZtEaydvTsf57nNtwTdyCwiQ--
X-Sonic-MF: <astrajoan@yahoo.com>
X-Sonic-ID: cf5c43ee-1067-422a-8436-3db623ce878c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 21 Jul 2023 16:44:28 +0000
Received: by hermes--production-ne1-77c6dd44c7-f4ww6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e1ca44d63345361332b647089c6c5b35;
          Fri, 21 Jul 2023 16:22:35 +0000 (UTC)
From: Ziqi Zhao <astrajoan@yahoo.com>
To: astrajoan@yahoo.com,
	davem@davemloft.net,
	edumazet@google.com,
	ivan.orlov0322@gmail.com,
	kernel@pengutronix.de,
	kuba@kernel.org,
	linux@rempel-privat.de,
	linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	pabeni@redhat.com,
	robin@protonic.nl,
	skhan@linuxfoundation.org,
	socketcan@hartkopp.net
Cc: arnd@arndb.de,
	bridge@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	mudongliangabcd@gmail.com,
	netdev@vger.kernel.org,
	nikolay@nvidia.com,
	roopa@nvidia.com,
	syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com
Subject: [PATCH] can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock
Date: Fri, 21 Jul 2023 09:22:26 -0700
Message-Id: <20230721162226.8639-1-astrajoan@yahoo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704064710.3189-1-astrajoan@yahoo.com>
References: <20230704064710.3189-1-astrajoan@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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

Reported-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com
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


