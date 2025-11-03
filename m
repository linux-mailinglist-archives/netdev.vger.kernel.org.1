Return-Path: <netdev+bounces-234936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E58C29EB7
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 04:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A17A4E804D
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 03:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA95154BF5;
	Mon,  3 Nov 2025 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VG8BtIYZ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0B3645;
	Mon,  3 Nov 2025 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139299; cv=none; b=StqTE/P7R0QgQZTe2fble9JXCTGToUcWYbs0mUCVxwhMlemasgo5Nm1WTZjPV4hLlMaR76XhFUo6elQrvlMbzDy+glYtnSyAK87S9O9QVN8YebNMMn9IeglSlaK3iKopi5rEB3kYxj3RS1j38e6CEVzDJX8+8WIicihmXNtbPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139299; c=relaxed/simple;
	bh=bHHE3E54uobcKxeEX5HLWre2zSGpZmDYD1tNCXm++bQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dnDVRq0M6w6YM0WlBEPSnCO+FExTxGvtfxNCLPgRspC+JK/ufPtLHFHmf7S0jf7vQgmc9SnuYlDxvHNtFUDoXW0563VsGPGXy107tpf90JTK5DImjRuZ845VvYqwMuhst0xyQzPLhNn9+OTKXyYYuPPAbrzGIPbRo4PgqhzGn14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VG8BtIYZ; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=UXzIocNcwyOMYPW
	Cwl4HYt/EKP2TVjz3Tzoz6fYk+QI=; b=VG8BtIYZ035Rz0OaerUCz5m91G1CGiC
	tAC+kREufDzNCIKWp6F/8xHxHV1AhVtb492FXOgWD0TNoCHI/x3qJLL9hP8a7Vd8
	or9RzqF1yBzIhWCQKoiw3MTNEwQm6GYTjpCra8xxuRgCCfdTINe3X7gcSWqSquZy
	2i98A3dItVEI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3t9xNFQhpTrk+AQ--.49782S2;
	Mon, 03 Nov 2025 10:37:02 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] net/core/sock: fix coding style issues Fix multiple coding style issues in net/core/sock.c:
Date: Mon,  3 Nov 2025 10:36:53 +0800
Message-Id: <20251103023653.3843-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3t9xNFQhpTrk+AQ--.49782S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1rKF4DJr4xurWfAF1DKFg_yoWrWFy3pF
	48X3ZrJ34UXrWxWrZ5Kw4ku343X39aka47Zr17G34jyr9FvryUAF4UJryayF45JFWkCr13
	Jw1kKw4DtF1xCFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziVT5AUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiigb6xWkIEupHxwAAsq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

- Remove spaces before commas in _sock_locks macro definition
- Use tabs instead of spaces for macro line continuation indentation
- Separate assignment from if condition in __sk_receive_skb function
- Fix pointer declaration format in timer functions
- Add spaces around == operator in preprocessor directive

These changes improve code style compliance with kernel coding standards
without affecting functionality.

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 net/core/sock.c | 59 ++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index dc03d4b59..a5dbf6c07 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -223,23 +223,23 @@ static struct lock_class_key af_family_kern_slock_keys[AF_MAX];
  */
 
 #define _sock_locks(x)						  \
-  x "AF_UNSPEC",	x "AF_UNIX"     ,	x "AF_INET"     , \
-  x "AF_AX25"  ,	x "AF_IPX"      ,	x "AF_APPLETALK", \
-  x "AF_NETROM",	x "AF_BRIDGE"   ,	x "AF_ATMPVC"   , \
-  x "AF_X25"   ,	x "AF_INET6"    ,	x "AF_ROSE"     , \
-  x "AF_DECnet",	x "AF_NETBEUI"  ,	x "AF_SECURITY" , \
-  x "AF_KEY"   ,	x "AF_NETLINK"  ,	x "AF_PACKET"   , \
-  x "AF_ASH"   ,	x "AF_ECONET"   ,	x "AF_ATMSVC"   , \
-  x "AF_RDS"   ,	x "AF_SNA"      ,	x "AF_IRDA"     , \
-  x "AF_PPPOX" ,	x "AF_WANPIPE"  ,	x "AF_LLC"      , \
-  x "27"       ,	x "28"          ,	x "AF_CAN"      , \
-  x "AF_TIPC"  ,	x "AF_BLUETOOTH",	x "IUCV"        , \
-  x "AF_RXRPC" ,	x "AF_ISDN"     ,	x "AF_PHONET"   , \
-  x "AF_IEEE802154",	x "AF_CAIF"	,	x "AF_ALG"      , \
-  x "AF_NFC"   ,	x "AF_VSOCK"    ,	x "AF_KCM"      , \
-  x "AF_QIPCRTR",	x "AF_SMC"	,	x "AF_XDP"	, \
-  x "AF_MCTP"  , \
-  x "AF_MAX"
+	x "AF_UNSPEC",	x "AF_UNIX",	x "AF_INET", \
+	x "AF_AX25",	x "AF_IPX",	x "AF_APPLETALK", \
+	x "AF_NETROM",	x "AF_BRIDGE",	x "AF_ATMPVC", \
+	x "AF_X25",	x "AF_INET6",	x "AF_ROSE", \
+	x "AF_DECnet",	x "AF_NETBEUI",	x "AF_SECURITY", \
+	x "AF_KEY",	x "AF_NETLINK",	x "AF_PACKET", \
+	x "AF_ASH",	x "AF_ECONET",	x "AF_ATMSVC", \
+	x "AF_RDS",	x "AF_SNA",	x "AF_IRDA", \
+	x "AF_PPPOX",	x "AF_WANPIPE",	x "AF_LLC", \
+	x "27",	x "28",	x "AF_CAN", \
+	x "AF_TIPC",	x "AF_BLUETOOTH",	x "IUCV", \
+	x "AF_RXRPC",	x "AF_ISDN",	x "AF_PHONET", \
+	x "AF_IEEE802154",	x "AF_CAIF",	x "AF_ALG", \
+	x "AF_NFC",	x "AF_VSOCK",	x "AF_KCM", \
+	x "AF_QIPCRTR",	x "AF_SMC",	x "AF_XDP", \
+	x "AF_MCTP", \
+	x "AF_MAX"
 
 static const char *const af_family_key_strings[AF_MAX+1] = {
 	_sock_locks("sk_lock-")
@@ -579,14 +579,17 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 		rc = sk_backlog_rcv(sk, skb);
 
 		mutex_release(&sk->sk_lock.dep_map, _RET_IP_);
-	} else if ((err = sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf)))) {
-		bh_unlock_sock(sk);
-		if (err == -ENOMEM)
-			reason = SKB_DROP_REASON_PFMEMALLOC;
-		if (err == -ENOBUFS)
-			reason = SKB_DROP_REASON_SOCKET_BACKLOG;
-		sk_drops_inc(sk);
-		goto discard_and_relse;
+	} else {
+		err = sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf));
+		if (err) {
+			bh_unlock_sock(sk);
+			if (err == -ENOMEM)
+				reason = SKB_DROP_REASON_PFMEMALLOC;
+			if (err == -ENOBUFS)
+				reason = SKB_DROP_REASON_SOCKET_BACKLOG;
+			sk_drops_inc(sk);
+			goto discard_and_relse;
+		}
 	}
 
 	bh_unlock_sock(sk);
@@ -3611,7 +3614,7 @@ void sk_send_sigurg(struct sock *sk)
 }
 EXPORT_SYMBOL(sk_send_sigurg);
 
-void sk_reset_timer(struct sock *sk, struct timer_list* timer,
+void sk_reset_timer(struct sock *sk, struct timer_list *timer,
 		    unsigned long expires)
 {
 	if (!mod_timer(timer, expires))
@@ -3619,7 +3622,7 @@ void sk_reset_timer(struct sock *sk, struct timer_list* timer,
 }
 EXPORT_SYMBOL(sk_reset_timer);
 
-void sk_stop_timer(struct sock *sk, struct timer_list* timer)
+void sk_stop_timer(struct sock *sk, struct timer_list *timer)
 {
 	if (timer_delete(timer))
 		__sock_put(sk);
@@ -3678,7 +3681,7 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	sk->sk_sndtimeo		=	MAX_SCHEDULE_TIMEOUT;
 
 	sk->sk_stamp = SK_DEFAULT_STAMP;
-#if BITS_PER_LONG==32
+#if BITS_PER_LONG == 32
 	seqlock_init(&sk->sk_stamp_seq);
 #endif
 	atomic_set(&sk->sk_zckey, 0);
-- 
2.17.1


