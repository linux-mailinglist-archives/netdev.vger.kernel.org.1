Return-Path: <netdev+bounces-33277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9A179D47F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F20281D48
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642E818B1A;
	Tue, 12 Sep 2023 15:12:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2018B07
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:12:55 +0000 (UTC)
X-Greylist: delayed 2395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Sep 2023 08:12:54 PDT
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97160115
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:12:54 -0700 (PDT)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.17.1.22/8.17.1.22) with ESMTP id 38CCPJus015741;
	Tue, 12 Sep 2023 15:32:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=jan2016.eng; bh=DyQa0
	+KRV9eaWPN25XWMmggvJmV36QSWG55JMsI514c=; b=k0a5BHbNSyPLOtxg6VDn4
	VVUlc/LUGScIfFAO7D1pM5DsNp+RBKxyLUPrA3KYEn8D7fJjTcDUG29HRaVphbdG
	Sz/PbocvL4qg1n3bfcnvFA0sMS+BdTD4g27W3E793EzCbVnMAPVX7SKnCMXwoJ0B
	1lGlfYV5ohMBGXRDSX2IsGDrrPMJit85Ji9I1ZWiAByfmIX82A+6PXo2ZfkmDWaJ
	it5sxpD4FlBOcvHRrBwOXv77GClcLPSF6pa7UesM/EVMN7LbFoqQw2Bdu8xqBo/h
	hA9WwwSq76K8aih4w7DZyd8HcyPMqTpc5/DRVQnYGeZqLSGxE/EvaKHikCPontjf
	g==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 3t0fyq1wct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Sep 2023 15:32:31 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 38CCWRFQ010133;
	Tue, 12 Sep 2023 10:32:30 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 3t0m1xgjxa-1;
	Tue, 12 Sep 2023 10:32:29 -0400
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.122.140])
	by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 2270D6281C;
	Tue, 12 Sep 2023 14:32:24 +0000 (GMT)
From: Jason Baron <jbaron@akamai.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [net-next 2/2] sock: add SO_REUSEADDR values to include/uapi/linux/socket.h
Date: Tue, 12 Sep 2023 10:31:49 -0400
Message-Id: <03e136d47995efafaa575031b1ddd2f4bc2194e7.1694523876.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1694523876.git.jbaron@akamai.com>
References: <cover.1694523876.git.jbaron@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120121
X-Proofpoint-ORIG-GUID: VTb1kXaFloleYnGteOZ4ikkssFgDioOP
X-Proofpoint-GUID: VTb1kXaFloleYnGteOZ4ikkssFgDioOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 clxscore=1011 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309120121

The settings for SO_REUSEADDR are now available via sock_diag. To
help userspace understand it's meaning let's add the values to
include/uapi/linux/socket.h. Also, rename them from SK_* to SOCK_*
to match the convention. These can also be used to interpret the
getsockopt() return value from SO_REUSEADDR.

Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 drivers/block/drbd/drbd_receiver.c |  6 +++---
 drivers/scsi/iscsi_tcp.c           |  2 +-
 fs/ocfs2/cluster/tcp.c             |  2 +-
 include/net/sock.h                 | 11 -----------
 include/uapi/linux/socket.h        | 11 +++++++++++
 net/core/sock.c                    |  4 ++--
 net/ipv4/af_inet.c                 |  2 +-
 net/ipv4/inet_connection_sock.c    |  4 ++--
 net/ipv4/tcp.c                     |  6 +++---
 net/ipv6/af_inet6.c                |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c    |  2 +-
 net/rds/tcp_listen.c               |  2 +-
 net/sunrpc/svcsock.c               |  2 +-
 13 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0c9f54197768..315c3a1de0ff 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -721,7 +721,7 @@ static int prepare_listen_socket(struct drbd_connection *connection, struct acce
 		goto out;
 	}
 
-	s_listen->sk->sk_reuse = SK_CAN_REUSE; /* SO_REUSEADDR */
+	s_listen->sk->sk_reuse = SOCK_CAN_REUSE; /* SO_REUSEADDR */
 	drbd_setbufsize(s_listen, sndbuf_size, rcvbuf_size);
 
 	what = "bind before listen";
@@ -1023,8 +1023,8 @@ static int conn_connect(struct drbd_connection *connection)
 	if (ad.s_listen)
 		sock_release(ad.s_listen);
 
-	sock.socket->sk->sk_reuse = SK_CAN_REUSE; /* SO_REUSEADDR */
-	msock.socket->sk->sk_reuse = SK_CAN_REUSE; /* SO_REUSEADDR */
+	sock.socket->sk->sk_reuse = SOCK_CAN_REUSE; /* SO_REUSEADDR */
+	msock.socket->sk->sk_reuse = SOCK_CAN_REUSE; /* SO_REUSEADDR */
 
 	sock.socket->sk->sk_allocation = GFP_NOIO;
 	msock.socket->sk->sk_allocation = GFP_NOIO;
diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 9ab8555180a3..163964207fa2 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -735,7 +735,7 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
 
 	/* setup Socket parameters */
 	sk = sock->sk;
-	sk->sk_reuse = SK_CAN_REUSE;
+	sk->sk_reuse = SOCK_CAN_REUSE;
 	sk->sk_sndtimeo = 15 * HZ; /* FIXME: make it configurable */
 	sk->sk_allocation = GFP_ATOMIC;
 	sk->sk_use_task_frag = false;
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 960080753d3b..f2a7da6ea48a 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1997,7 +1997,7 @@ static int o2net_open_listening_sock(__be32 addr, __be16 port)
 	o2net_listen_sock = sock;
 	INIT_WORK(&o2net_listen_work, o2net_accept_many);
 
-	sock->sk->sk_reuse = SK_CAN_REUSE;
+	sock->sk->sk_reuse = SOCK_CAN_REUSE;
 	ret = sock->ops->bind(sock, (struct sockaddr *)&sin, sizeof(sin));
 	if (ret < 0) {
 		printk(KERN_ERR "o2net: Error %d while binding socket at "
diff --git a/include/net/sock.h b/include/net/sock.h
index b770261fbdaf..a3b760ebf3f8 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -657,17 +657,6 @@ void sock_net_set(struct sock *sk, struct net *net)
 	write_pnet(&sk->sk_net, net);
 }
 
-/*
- * SK_CAN_REUSE and SK_NO_REUSE on a socket mean that the socket is OK
- * or not whether his port will be reused by someone else. SK_FORCE_REUSE
- * on a socket means that the socket will reuse everybody else's port
- * without looking at the other's sk_reuse value.
- */
-
-#define SK_NO_REUSE	0
-#define SK_CAN_REUSE	1
-#define SK_FORCE_REUSE	2
-
 int sk_set_peek_off(struct sock *sk, int val);
 
 static inline int sk_peek_offset(const struct sock *sk, int flags)
diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..635ceabefada 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -35,4 +35,15 @@ struct __kernel_sockaddr_storage {
 #define SOCK_TXREHASH_DISABLED	0
 #define SOCK_TXREHASH_ENABLED	1
 
+/*
+ * SOCK_CAN_REUSE and SOCK_NO_REUSE on a socket mean that the socket is OK
+ * or not whether his port will be reused by someone else. SOCK_FORCE_REUSE
+ * on a socket means that the socket will reuse everybody else's port
+ * without looking at the other's sk_reuse value.
+ */
+
+#define SOCK_NO_REUSE     0
+#define SOCK_CAN_REUSE    1
+#define SOCK_FORCE_REUSE  2
+
 #endif /* _UAPI_LINUX_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index 16584e2dd648..2a14f29c8cac 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -782,7 +782,7 @@ EXPORT_SYMBOL(sk_mc_loop);
 void sock_set_reuseaddr(struct sock *sk)
 {
 	lock_sock(sk);
-	sk->sk_reuse = SK_CAN_REUSE;
+	sk->sk_reuse = SOCK_CAN_REUSE;
 	release_sock(sk);
 }
 EXPORT_SYMBOL(sock_set_reuseaddr);
@@ -1128,7 +1128,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			sock_valbool_flag(sk, SOCK_DBG, valbool);
 		break;
 	case SO_REUSEADDR:
-		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
+		sk->sk_reuse = (valbool ? SOCK_CAN_REUSE : SOCK_NO_REUSE);
 		break;
 	case SO_REUSEPORT:
 		sk->sk_reuseport = valbool;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 3d2e30e20473..1abce1f1d026 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -328,7 +328,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 
 	err = 0;
 	if (INET_PROTOSW_REUSE & answer_flags)
-		sk->sk_reuse = SK_CAN_REUSE;
+		sk->sk_reuse = SOCK_CAN_REUSE;
 
 	inet = inet_sk(sk);
 	inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index aeebe8816689..70bcd996b2e6 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -335,7 +335,7 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 
 	l3mdev = inet_sk_bound_l3mdev(sk);
 ports_exhausted:
-	attempt_half = (sk->sk_reuse == SK_CAN_REUSE) ? 1 : 0;
+	attempt_half = (sk->sk_reuse == SOCK_CAN_REUSE) ? 1 : 0;
 other_half_scan:
 	inet_sk_get_local_port_range(sk, &low, &high);
 	high++; /* [32768, 60999] -> [32768, 61000[ */
@@ -548,7 +548,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 
 	if (!found_port) {
 		if (!hlist_empty(&tb->owners)) {
-			if (sk->sk_reuse == SK_FORCE_REUSE ||
+			if (sk->sk_reuse == SOCK_FORCE_REUSE ||
 			    (tb->fastreuse > 0 && reuse) ||
 			    sk_reuseport_match(tb, sk))
 				check_bind_conflict = false;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0c3040a63ebd..fcf69377d4cd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3522,15 +3522,15 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			err = -EPERM;
 		else if (val == TCP_REPAIR_ON) {
 			tp->repair = 1;
-			sk->sk_reuse = SK_FORCE_REUSE;
+			sk->sk_reuse = SOCK_FORCE_REUSE;
 			tp->repair_queue = TCP_NO_QUEUE;
 		} else if (val == TCP_REPAIR_OFF) {
 			tp->repair = 0;
-			sk->sk_reuse = SK_NO_REUSE;
+			sk->sk_reuse = SOCK_NO_REUSE;
 			tcp_send_window_probe(sk);
 		} else if (val == TCP_REPAIR_OFF_NO_WP) {
 			tp->repair = 0;
-			sk->sk_reuse = SK_NO_REUSE;
+			sk->sk_reuse = SOCK_NO_REUSE;
 		} else
 			err = -EINVAL;
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 368824fe9719..cf66fe3c35b0 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -197,7 +197,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 
 	err = 0;
 	if (INET_PROTOSW_REUSE & answer_flags)
-		sk->sk_reuse = SK_CAN_REUSE;
+		sk->sk_reuse = SOCK_CAN_REUSE;
 
 	inet = inet_sk(sk);
 	inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index da5af28ff57b..d3a2a88d1688 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1539,7 +1539,7 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 	}
 	*sock_ret = sock;
 	/* it is equivalent to the REUSEADDR option in user-space */
-	sock->sk->sk_reuse = SK_CAN_REUSE;
+	sock->sk->sk_reuse = SOCK_CAN_REUSE;
 	result = sysctl_sync_sock_size(ipvs);
 	if (result > 0)
 		set_sock_size(sock->sk, 0, result);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 014fa24418c1..4f3c4d7936b4 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -282,7 +282,7 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 		goto out;
 	}
 
-	sock->sk->sk_reuse = SK_CAN_REUSE;
+	sock->sk->sk_reuse = SOCK_CAN_REUSE;
 	tcp_sock_set_nodelay(sock->sk);
 
 	write_lock_bh(&sock->sk->sk_callback_lock);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 998687421fa6..bd9580900ccf 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1559,7 +1559,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	if (family == PF_INET6)
 		ip6_sock_set_v6only(sock->sk);
 	if (type == SOCK_STREAM)
-		sock->sk->sk_reuse = SK_CAN_REUSE; /* allow address reuse */
+		sock->sk->sk_reuse = SOCK_CAN_REUSE; /* allow address reuse */
 	error = kernel_bind(sock, sin, len);
 	if (error < 0)
 		goto bummer;
-- 
2.25.1


