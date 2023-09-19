Return-Path: <netdev+bounces-34840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2B7A56AC
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 02:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958781C20A3F
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C90B163;
	Tue, 19 Sep 2023 00:46:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A704615A3
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 00:46:38 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F61114
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:46:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so5261089276.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695084394; x=1695689194; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nZI4WQvaICAXY2f7JZMwx/vILSY7yeD3gxZekHHKSyA=;
        b=2X+UuLJIQWtugBixi9UMMyt8pAj8UWhe+2hD+kGH11gm3+lxkCNya6pdTT0/L3vQek
         LJ+AYaQMk8zyXYFcDQucsErdr/KZOwgH+GfiFwBrseBBq8lhP7C55wHOVTgh/RYE24G0
         HS1/mvvuLFfAdm/QXvrKpbv0lNjOLHvcJkP8q6aWxQNn1enUH0/O3M0AFeq6KVtYIR4L
         xC9IIb8fBDfNTAXcMmFO0+PqNsq3skadixacV0gHiXDms7chERZ+1zpZiKA4FXCH3iec
         o/YBB+jt6RvMD69fE64VVQa46Fbdfnjiqy+2qSOXxZWXj69iducVsOKRUhIgbSKVgJPZ
         1ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695084394; x=1695689194;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZI4WQvaICAXY2f7JZMwx/vILSY7yeD3gxZekHHKSyA=;
        b=LLTUQYVdhmlG0Pd8MgcXizg9kNOiJY0LA1twvczgescgxWQmU9Wc6YjN4iRfrJdz1q
         skx5z6EFcETHLMy6a9nQIoKQ/HYn0fa960bdVzjzUucUBVuViabPCvkFN4SASKcNdASb
         NK95mfu+xAiNoz/JAXV4AN9dBy3YYiH5MQkqauo67pXq3TXSLqsquplaSDHYUCthS8Th
         QQx/r0gYii3+ZJxeaU0WtPn3vjjq53vzEDUXI18qhngNS7hadR2Pxqg3O+Pe1b2r+rkl
         I3d6QwY0rrri5TXBqf1bAWZYAY2lXblIOjfrilS/9gFym50GSK8gQXS7PhT/ze8YI7j6
         O9DQ==
X-Gm-Message-State: AOJu0YxFfUYmz2bx3/dP3PT8/bkYxDTPGtm/e9iASbfhdfaoWX2tsUoh
	nvk9rhFihUotx5wnBED27S+UtsWyTw==
X-Google-Smtp-Source: AGHT+IGh9Q6V42mut0ANBjQQSFDfrxLEbM2rs3fTXKxAdckmJrYHDET7RQgSRxUazsVnoSg1dl5LZH/kLQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:c74e:0:b0:d7e:add7:4de6 with SMTP id
 w75-20020a25c74e000000b00d7eadd74de6mr225015ybe.4.1695084394442; Mon, 18 Sep
 2023 17:46:34 -0700 (PDT)
Date: Mon, 18 Sep 2023 19:46:12 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919004613.147693-1-jrife@google.com>
Subject: [PATCH net v3 1/3] net: replace calls to sock->ops->connect() with kernel_connect()
From: Jordan Rife <jrife@google.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, chengyou@linux.alibaba.com, 
	kaishen@linux.alibaba.com, jgg@ziepe.ca, leon@kernel.org, bmt@zurich.ibm.com, 
	ccaulfie@redhat.com, teigland@redhat.com, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, sfrench@samba.org, pc@manguebit.com, 
	lsahlber@redhat.com, sprasad@microsoft.com, tom@talpey.com, ericvh@kernel.org, 
	lucho@ionkov.net, asmadeus@codewreck.org, linux_oss@crudebyte.com, 
	idryomov@gmail.com, xiubli@redhat.com, jlayton@kernel.org, horms@verge.net.au, 
	ja@ssi.bg, pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, 
	santosh.shilimkar@oracle.com, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
ensured that kernel_connect() will not overwrite the address parameter
in cases where BPF connect hooks perform an address rewrite. This change
replaces all direct calls to sock->ops->connect() with kernel_connect()
to make these call safe.

This patch also introduces a sanity check to kernel_connect() for
addrlen.

Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Signed-off-by: Jordan Rife <jrife@google.com>
---
v2->v3: Add "Fixes" tag. Check for positivity in addrlen sanity check.
v1->v2: Split up original patch into patch series. Insulate calls with
	kernel_connect() instead of pushing address copy deeper into
	sock->ops->connect().

 drivers/block/drbd/drbd_receiver.c     |  2 +-
 drivers/infiniband/hw/erdma/erdma_cm.c |  2 +-
 drivers/infiniband/sw/siw/siw_cm.c     |  2 +-
 fs/dlm/lowcomms.c                      |  6 +++---
 fs/ocfs2/cluster/tcp.c                 |  8 ++++----
 fs/smb/client/connect.c                |  4 ++--
 net/9p/trans_fd.c                      | 10 +++++-----
 net/ceph/messenger.c                   |  4 ++--
 net/netfilter/ipvs/ip_vs_sync.c        |  4 ++--
 net/rds/tcp_connect.c                  |  2 +-
 net/socket.c                           |  3 +++
 11 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 0c9f54197768d..9b2660e990a98 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -646,7 +646,7 @@ static struct socket *drbd_try_connect(struct drbd_connection *connection)
 	 * stay C_WF_CONNECTION, don't go Disconnecting! */
 	disconnect_on_error = 0;
 	what = "connect";
-	err = sock->ops->connect(sock, (struct sockaddr *) &peer_in6, peer_addr_len, 0);
+	err = kernel_connect(sock, (struct sockaddr *)&peer_in6, peer_addr_len, 0);
 
 out:
 	if (err < 0) {
diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index 771059a8eb7d7..e2b89e7bbe2b8 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -993,7 +993,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	ret = s->ops->bind(s, laddr, laddrlen);
 	if (ret)
 		return ret;
-	ret = s->ops->connect(s, raddr, raddrlen, flags);
+	ret = kernel_connect(s, raddr, raddrlen, flags);
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index a2605178f4eda..05624f424153e 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1328,7 +1328,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	if (rv < 0)
 		return rv;
 
-	rv = s->ops->connect(s, raddr, size, flags);
+	rv = kernel_connect(s, raddr, size, flags);
 
 	return rv < 0 ? rv : 0;
 }
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index f7bc22e74db27..1cf796b97eb65 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1818,7 +1818,7 @@ static int dlm_tcp_bind(struct socket *sock)
 static int dlm_tcp_connect(struct connection *con, struct socket *sock,
 			   struct sockaddr *addr, int addr_len)
 {
-	return sock->ops->connect(sock, addr, addr_len, O_NONBLOCK);
+	return kernel_connect(sock, addr, addr_len, O_NONBLOCK);
 }
 
 static int dlm_tcp_listen_validate(void)
@@ -1876,12 +1876,12 @@ static int dlm_sctp_connect(struct connection *con, struct socket *sock,
 	int ret;
 
 	/*
-	 * Make sock->ops->connect() function return in specified time,
+	 * Make kernel_connect() function return in specified time,
 	 * since O_NONBLOCK argument in connect() function does not work here,
 	 * then, we should restore the default value of this attribute.
 	 */
 	sock_set_sndtimeo(sock->sk, 5);
-	ret = sock->ops->connect(sock, addr, addr_len, 0);
+	ret = kernel_connect(sock, addr, addr_len, 0);
 	sock_set_sndtimeo(sock->sk, 0);
 	return ret;
 }
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 960080753d3bd..ead7c287ff373 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1636,10 +1636,10 @@ static void o2net_start_connect(struct work_struct *work)
 	remoteaddr.sin_addr.s_addr = node->nd_ipv4_address;
 	remoteaddr.sin_port = node->nd_ipv4_port;
 
-	ret = sc->sc_sock->ops->connect(sc->sc_sock,
-					(struct sockaddr *)&remoteaddr,
-					sizeof(remoteaddr),
-					O_NONBLOCK);
+	ret = kernel_connect(sc->sc_sock,
+			     (struct sockaddr *)&remoteaddr,
+			     sizeof(remoteaddr),
+			     O_NONBLOCK);
 	if (ret == -EINPROGRESS)
 		ret = 0;
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 687754791bf0a..b7764cd57e035 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -3042,8 +3042,8 @@ generic_ip_connect(struct TCP_Server_Info *server)
 		 socket->sk->sk_sndbuf,
 		 socket->sk->sk_rcvbuf, socket->sk->sk_rcvtimeo);
 
-	rc = socket->ops->connect(socket, saddr, slen,
-				  server->noblockcnt ? O_NONBLOCK : 0);
+	rc = kernel_connect(socket, saddr, slen,
+			    server->noblockcnt ? O_NONBLOCK : 0);
 	/*
 	 * When mounting SMB root file systems, we do not want to block in
 	 * connect. Otherwise bail out and then let cifs_reconnect() perform
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index c4015f30f9fa7..225ee8b6d4c5b 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1019,9 +1019,9 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 		}
 	}
 
-	err = READ_ONCE(csocket->ops)->connect(csocket,
-				    (struct sockaddr *)&sin_server,
-				    sizeof(struct sockaddr_in), 0);
+	err = kernel_connect(csocket,
+			     (struct sockaddr *)&sin_server,
+			     sizeof(struct sockaddr_in), 0);
 	if (err < 0) {
 		pr_err("%s (%d): problem connecting socket to %s\n",
 		       __func__, task_pid_nr(current), addr);
@@ -1060,8 +1060,8 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 
 		return err;
 	}
-	err = READ_ONCE(csocket->ops)->connect(csocket, (struct sockaddr *)&sun_server,
-			sizeof(struct sockaddr_un) - 1, 0);
+	err = kernel_connect(csocket, (struct sockaddr *)&sun_server,
+			     sizeof(struct sockaddr_un) - 1, 0);
 	if (err < 0) {
 		pr_err("%s (%d): problem connecting socket: %s: %d\n",
 		       __func__, task_pid_nr(current), addr, err);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 10a41cd9c5235..3c8b78d9c4d1c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -459,8 +459,8 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	set_sock_callbacks(sock, con);
 
 	con_sock_state_connecting(con);
-	ret = sock->ops->connect(sock, (struct sockaddr *)&ss, sizeof(ss),
-				 O_NONBLOCK);
+	ret = kernel_connect(sock, (struct sockaddr *)&ss, sizeof(ss),
+			     O_NONBLOCK);
 	if (ret == -EINPROGRESS) {
 		dout("connect %s EINPROGRESS sk_state = %u\n",
 		     ceph_pr_addr(&con->peer_addr),
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index da5af28ff57b5..6e4ed1e11a3b7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1505,8 +1505,8 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	}
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
-	result = sock->ops->connect(sock, (struct sockaddr *) &mcast_addr,
-				    salen, 0);
+	result = kernel_connect(sock, (struct sockaddr *)&mcast_addr,
+				salen, 0);
 	if (result < 0) {
 		pr_err("Error connecting to the multicast addr\n");
 		goto error;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index f0c477c5d1db4..d788c6d28986f 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -173,7 +173,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	 * own the socket
 	 */
 	rds_tcp_set_callbacks(sock, cp);
-	ret = sock->ops->connect(sock, addr, addrlen, O_NONBLOCK);
+	ret = kernel_connect(sock, addr, addrlen, O_NONBLOCK);
 
 	rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr, ret);
 	if (ret == -EINPROGRESS)
diff --git a/net/socket.c b/net/socket.c
index c8b08b32f097e..eb7f14143caed 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3572,6 +3572,9 @@ int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 {
 	struct sockaddr_storage address;
 
+	if (addrlen < 0 || addrlen > sizeof(address))
+		return -EINVAL;
+
 	memcpy(&address, addr, addrlen);
 
 	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)&address,
-- 
2.42.0.459.ge4e396fd5e-goog


