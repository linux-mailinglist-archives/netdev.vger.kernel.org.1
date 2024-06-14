Return-Path: <netdev+bounces-103462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB1C90837A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17731C22C0A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 06:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D6119D894;
	Fri, 14 Jun 2024 06:00:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6075A23;
	Fri, 14 Jun 2024 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344834; cv=none; b=iqqLCBVu/LhlMNXNhU9EjSYI/CbgjLWM6j/yepXQZjD3YiU6yEK+8JfN9npCYCglfqbeleY4aed/1oFlv37C/vqu581fFRJ2T7V1i77ZZ1Fh4QqNOYWu7NzQ3vtYrC/A6H9tOaV+6pwP8G08aW6c+qD0HHsqAKk/08fDHIxDs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344834; c=relaxed/simple;
	bh=GW4WsGWfmf/VNxcocottY+qzRoW45O4XrJ2pamOF32A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u70RLUVkOt5weGPk5eDSOYq9+hDenn6lax/NId349WlRIJ2PVdyayGE/g1kih30NTxPlV5iYI/KMhSWv+EI88WFe8021IFSMeVhCHcKRsb0j7Ac4EjEp7zmy0SNlnVtv0UvcgeSYIU98c9C9qDKE5ZuQmREgGu9SiGGEbxLG0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5fb19b522a1311ef9305a59a3cc225df-20240614
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:f3965d31-fd7c-4513-86e1-2f56de3473a0,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:13
X-CID-INFO: VERSION:1.1.38,REQID:f3965d31-fd7c-4513-86e1-2f56de3473a0,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:13
X-CID-META: VersionHash:82c5f88,CLOUDID:a71ca4f081d568f9d50dde9718be5f76,BulkI
	D:240614140018TO7FIQZY,BulkQuantity:0,Recheck:0,SF:38|24|16|19|44|66|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_USA,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 5fb19b522a1311ef9305a59a3cc225df-20240614
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <luoxuanqiang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 884987294; Fri, 14 Jun 2024 14:00:16 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id D319EB80758A;
	Fri, 14 Jun 2024 14:00:14 +0800 (CST)
X-ns-mid: postfix-666BDC6E-650757267
Received: from localhost.localdomain (unknown [10.42.12.252])
	by node2.com.cn (NSMail) with ESMTPA id 4460DB80758A;
	Fri, 14 Jun 2024 06:00:13 +0000 (UTC)
From: luoxuanqiang <luoxuanqiang@kylinos.cn>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luoxuanqiang@kylinos.cn
Subject: [PATCH v1 1/1] Fix race for duplicate reqsk on identical SYN
Date: Fri, 14 Jun 2024 14:00:12 +0800
Message-Id: <20240614060012.158026-1-luoxuanqiang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When bonding is configured in BOND_MODE_BROADCAST mode, if two identical =
SYN packets
are received at the same time and processed on different CPUs, it can pot=
entially
create the same sk (sock) but two different reqsk (request_sock) in tcp_c=
onn_request().

These two different reqsk will respond with two SYNACK packets, and since=
 the generation
of the seq (ISN) incorporates a timestamp, the final two SYNACK packets w=
ill have
different seq values.

The consequence is that when the Client receives and replies with an ACK =
to the earlier
SYNACK packet, we will reset(RST) it.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

This behavior is consistently reproducible in my local setup, which compr=
ises:

                  | NETA1 ------ NETB1 |
PC_A --- bond --- |                    | --- bond --- PC_B
                  | NETA2 ------ NETB2 |

- PC_A is the Server and has two network cards, NETA1 and NETA2. I have b=
onded these two
  cards using BOND_MODE_BROADCAST mode and configured them to be handled =
by different CPU.

- PC_B is the Client, also equipped with two network cards, NETB1 and NET=
B2, which are
  also bonded and configured in BOND_MODE_BROADCAST mode.

If the client attempts a TCP connection to the server, it might encounter=
 a failure.
Capturing packets from the server side reveals:

10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], seq 32=
0236027,
10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], seq 32=
0236027,
localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], seq 2=
967855116,
localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], seq 2=
967855123, <=3D=3D
10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], ack 42=
94967290,
10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], ack 42=
94967290,
localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], seq 29=
67855117, <=3D=3D
localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], seq 29=
67855117,

Two SYNACKs with different seq numbers are sent by localhost, resulting i=
n an anomaly.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

The attempted solution is as follows:
In the tcp_conn_request(), while inserting reqsk into the ehash table, it=
 also checks
if an entry already exists. If found, it avoids reinsertion and releases =
it.

Simultaneously, In the reqsk_queue_hash_req(), the start of the req->rsk_=
timer is
adjusted to be after successful insertion.

Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
---
 include/net/inet_connection_sock.h |  2 +-
 net/dccp/ipv4.c                    |  2 +-
 net/dccp/ipv6.c                    |  2 +-
 net/ipv4/inet_connection_sock.c    | 16 ++++++++++++----
 net/ipv4/tcp_input.c               | 11 ++++++++++-
 5 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
index 7d6b1254c92d..8773d161d184 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -264,7 +264,7 @@ struct sock *inet_csk_reqsk_queue_add(struct sock *sk=
,
 				      struct request_sock *req,
 				      struct sock *child);
 void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock =
*req,
-				   unsigned long timeout);
+				   unsigned long timeout, bool *found_dup_sk);
 struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *c=
hild,
 					 struct request_sock *req,
 					 bool own_req);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index ff41bd6f99c3..13aafdeb9205 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -657,7 +657,7 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_b=
uff *skb)
 	if (dccp_v4_send_response(sk, req))
 		goto drop_and_free;
=20
-	inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
+	inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NULL);
 	reqsk_put(req);
 	return 0;
=20
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 85f4b8fdbe5e..493cdb12ce2b 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -400,7 +400,7 @@ static int dccp_v6_conn_request(struct sock *sk, stru=
ct sk_buff *skb)
 	if (dccp_v6_send_response(sk, req))
 		goto drop_and_free;
=20
-	inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
+	inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NULL);
 	reqsk_put(req);
 	return 0;
=20
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
index d81f74ce0f02..d9394db98a5a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1123,12 +1123,17 @@ static void reqsk_timer_handler(struct timer_list=
 *t)
 }
=20
 static void reqsk_queue_hash_req(struct request_sock *req,
-				 unsigned long timeout)
+				 unsigned long timeout, bool *found_dup_sk)
 {
+
+	inet_ehash_insert(req_to_sk(req), NULL, found_dup_sk);
+	if(found_dup_sk && *found_dup_sk)
+		return;
+
+	/* The timer needs to be setup after a successful insertion. */
 	timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
 	mod_timer(&req->rsk_timer, jiffies + timeout);
=20
-	inet_ehash_insert(req_to_sk(req), NULL, NULL);
 	/* before letting lookups find us, make sure all req fields
 	 * are committed to memory and refcnt initialized.
 	 */
@@ -1137,9 +1142,12 @@ static void reqsk_queue_hash_req(struct request_so=
ck *req,
 }
=20
 void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_sock =
*req,
-				   unsigned long timeout)
+				   unsigned long timeout, bool *found_dup_sk)
 {
-	reqsk_queue_hash_req(req, timeout);
+	reqsk_queue_hash_req(req, timeout, found_dup_sk);
+	if(found_dup_sk && *found_dup_sk)
+		return;
+
 	inet_csk_reqsk_queue_added(sk);
 }
 EXPORT_SYMBOL_GPL(inet_csk_reqsk_queue_hash_add);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9c04a9c8be9d..467f1b7bbd5a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7255,8 +7255,17 @@ int tcp_conn_request(struct request_sock_ops *rsk_=
ops,
 	} else {
 		tcp_rsk(req)->tfo_listener =3D false;
 		if (!want_cookie) {
+			bool found_dup_sk =3D false;
+
 			req->timeout =3D tcp_timeout_init((struct sock *)req);
-			inet_csk_reqsk_queue_hash_add(sk, req, req->timeout);
+			inet_csk_reqsk_queue_hash_add(sk, req, req->timeout,
+							&found_dup_sk);
+
+			if(unlikely(found_dup_sk)){
+				reqsk_free(req);
+				return 0;
+			}
+
 		}
 		af_ops->send_synack(sk, dst, &fl, req, &foc,
 				    !want_cookie ? TCP_SYNACK_NORMAL :
--=20
2.25.1


