Return-Path: <netdev+bounces-34378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4846F7A3F80
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 04:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639D01C20935
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A351389;
	Mon, 18 Sep 2023 02:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE291FAD
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 02:50:37 +0000 (UTC)
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D43611B
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 19:50:35 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id 5614622812f47-3aa172b512eso7206347b6e.3
        for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 19:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695005435; x=1695610235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgs6xo9aSLFNTXyqxCw9W0uW6ktQTa2iqTwos3YLkqM=;
        b=ytHDTV0rlSXKc04o+YLvQGJ1HKe7qPASjSdXWrPq3sqah/Jx4fMS2Ff9OeeCT//cBz
         LphyG4hw082p2MhVJGvg5leCIEurSF0l2pTtMhhTAEmpFbYMAxfIqb62H90mcSv9ldvA
         tW977qSrDUJcN6Q5GbL68TaHNBt7zXBXexZHzGsATeCFfKZpvNKxDsdYM1th5X/d0jz/
         oquBS2eJMf7S59XF5VVL2JOi1+c6np8UBf6sExBplw6ASGKZNi1g8ofFjlo4GnaIffce
         11oQYdkgZvg3uq7btWtpI4KWj59rjOKKHDH7W6creSJtA8ezc59eAd3JUV+Fs3DDVzif
         H2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695005435; x=1695610235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgs6xo9aSLFNTXyqxCw9W0uW6ktQTa2iqTwos3YLkqM=;
        b=hEndDwXVm/wYvTzQ0WhJx+Vlot+TChYfDo+urBChNkPdCpIp5I4JC8I5rSehvxaI5U
         xsTHbCVWZyZWHb2DAARsOtaQqHxff1ZcKiUo4wWSIrt7vAgTPitwM49FcWVlCIa6wKSj
         56L/+RMmYHo/Xbq/oQGluqNfqZj0FUjBv0vtyTRMf5tQT2eAlDIBMtbZHe9JPUhEPtGk
         z/dcQqgTaG12DANv+/vUAzbRIcgyeju/0fWAvblMttswUA0XkuEvo0ZvrY+1IWbK8k1o
         rN53rwp+4+in47dEL5fUisePF+XV27NgenyC2L8e+o/BEoT15CpT4zP9HVBhBjRmaPNx
         Tavg==
X-Gm-Message-State: AOJu0Yxy0YYPJOuYvmPX+Vmr3E0bFL1DMN/ylgY406AmuxVxdQp+FaHv
	5tQGnCHtXA65VAhenkMODR1vbcDnyQ==
X-Google-Smtp-Source: AGHT+IEEOYO/CRGw3IpeEwMPB9SxZi5cCBxSSmb+wQfdSy7cFlKvNChAfCQu0cLfg8ukT5RcUE/wd203+Q==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6808:30a4:b0:3a9:d030:5023 with SMTP id
 bl36-20020a05680830a400b003a9d0305023mr3667018oib.3.1695005434912; Sun, 17
 Sep 2023 19:50:34 -0700 (PDT)
Date: Sun, 17 Sep 2023 21:50:20 -0500
In-Reply-To: <20230918025021.4078252-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230918025021.4078252-1-jrife@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230918025021.4078252-3-jrife@google.com>
Subject: [PATCH net v2 3/3] net: prevent address rewrite in kernel_bind()
From: Jordan Rife <jrife@google.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org
Cc: dborkman@kernel.org, willemdebruijn.kernel@gmail.com, 
	Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Similar to the change in commit 0bdf399342c5("net: Avoid address
overwrite in kernel_connect"), BPF hooks run on bind may rewrite the
address passed to kernel_bind(). This change

1) Makes a copy of the bind address in kernel_bind() to insulate
   callers.
2) Replaces direct calls to sock->ops->bind() with kernel_bind()

Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/

Signed-off-by: Jordan Rife <jrife@google.com>
---
v1->v2: Split up original patch into patch series. Insulate
	sock->ops->bind() calls with kernel_bind().

 drivers/block/drbd/drbd_receiver.c     |  4 ++--
 drivers/char/agp/alpha-agp.c           |  2 +-
 drivers/infiniband/hw/erdma/erdma_cm.c |  6 +++---
 drivers/infiniband/sw/siw/siw_cm.c     | 10 +++++-----
 drivers/isdn/mISDN/l1oip_core.c        |  4 ++--
 fs/dlm/lowcomms.c                      |  7 +++----
 fs/ocfs2/cluster/tcp.c                 |  6 +++---
 fs/smb/client/connect.c                |  6 +++---
 net/netfilter/ipvs/ip_vs_sync.c        |  4 ++--
 net/rds/tcp_connect.c                  |  2 +-
 net/rds/tcp_listen.c                   |  2 +-
 net/socket.c                           |  7 +++++++
 12 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 9b2660e990a98..752759ed22b8c 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -638,7 +638,7 @@ static struct socket *drbd_try_connect(struct drbd_connection *connection)
 	*  a free one dynamically.
 	*/
 	what = "bind before connect";
-	err = sock->ops->bind(sock, (struct sockaddr *) &src_in6, my_addr_len);
+	err = kernel_bind(sock, (struct sockaddr *)&src_in6, my_addr_len);
 	if (err < 0)
 		goto out;
 
@@ -725,7 +725,7 @@ static int prepare_listen_socket(struct drbd_connection *connection, struct acce
 	drbd_setbufsize(s_listen, sndbuf_size, rcvbuf_size);
 
 	what = "bind before listen";
-	err = s_listen->ops->bind(s_listen, (struct sockaddr *)&my_addr, my_addr_len);
+	err = kernel_bind(s_listen, (struct sockaddr *)&my_addr, my_addr_len);
 	if (err < 0)
 		goto out;
 
diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index c9bf2c2198418..f251fedfb4840 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -96,7 +96,7 @@ static int alpha_core_agp_insert_memory(struct agp_memory *mem, off_t pg_start,
 	if ((pg_start + mem->page_count) > num_entries)
 		return -EINVAL;
 
-	status = agp->ops->bind(agp, pg_start, mem);
+	status = kernel_bind(agp, pg_start, mem);
 	mb();
 	alpha_core_agp_tlbflush(mem);
 
diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index e2b89e7bbe2b8..674702d159c29 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -990,7 +990,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 	int ret;
 
 	sock_set_reuseaddr(s->sk);
-	ret = s->ops->bind(s, laddr, laddrlen);
+	ret = kernel_bind(s, laddr, laddrlen);
 	if (ret)
 		return ret;
 	ret = kernel_connect(s, raddr, raddrlen, flags);
@@ -1309,8 +1309,8 @@ int erdma_create_listen(struct iw_cm_id *id, int backlog)
 	if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
 		s->sk->sk_bound_dev_if = dev->netdev->ifindex;
 
-	ret = s->ops->bind(s, (struct sockaddr *)laddr,
-			   sizeof(struct sockaddr_in));
+	ret = kernel_bind(s, (struct sockaddr *)laddr,
+			  sizeof(struct sockaddr_in));
 	if (ret)
 		goto error;
 
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 05624f424153e..d05e0eeee9244 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1324,7 +1324,7 @@ static int kernel_bindconnect(struct socket *s, struct sockaddr *laddr,
 			return rv;
 	}
 
-	rv = s->ops->bind(s, laddr, size);
+	rv = kernel_bind(s, laddr, size);
 	if (rv < 0)
 		return rv;
 
@@ -1793,8 +1793,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv4_is_zeronet(laddr->sin_addr.s_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in));
 	} else {
 		struct sockaddr_in6 *laddr = &to_sockaddr_in6(id->local_addr);
 
@@ -1811,8 +1811,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		if (ipv6_addr_any(&laddr->sin6_addr))
 			s->sk->sk_bound_dev_if = sdev->netdev->ifindex;
 
-		rv = s->ops->bind(s, (struct sockaddr *)laddr,
-				  sizeof(struct sockaddr_in6));
+		rv = kernel_bind(s, (struct sockaddr *)laddr,
+				 sizeof(struct sockaddr_in6));
 	}
 	if (rv) {
 		siw_dbg(id->device, "socket bind error: %d\n", rv);
diff --git a/drivers/isdn/mISDN/l1oip_core.c b/drivers/isdn/mISDN/l1oip_core.c
index f010b35a05313..681147e1fc843 100644
--- a/drivers/isdn/mISDN/l1oip_core.c
+++ b/drivers/isdn/mISDN/l1oip_core.c
@@ -675,8 +675,8 @@ l1oip_socket_thread(void *data)
 	hc->sin_remote.sin_port = htons((unsigned short)hc->remoteport);
 
 	/* bind to incoming port */
-	if (socket->ops->bind(socket, (struct sockaddr *)&hc->sin_local,
-			      sizeof(hc->sin_local))) {
+	if (kernel_bind(socket, (struct sockaddr *)&hc->sin_local,
+			sizeof(hc->sin_local))) {
 		printk(KERN_ERR "%s: Failed to bind socket to port %d.\n",
 		       __func__, hc->localport);
 		ret = -EINVAL;
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 1cf796b97eb65..73ab179833fbd 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1805,8 +1805,7 @@ static int dlm_tcp_bind(struct socket *sock)
 	memcpy(&src_addr, &dlm_local_addr[0], sizeof(src_addr));
 	make_sockaddr(&src_addr, 0, &addr_len);
 
-	result = sock->ops->bind(sock, (struct sockaddr *)&src_addr,
-				 addr_len);
+	result = kernel_bind(sock, (struct sockaddr *)&src_addr, addr_len);
 	if (result < 0) {
 		/* This *may* not indicate a critical error */
 		log_print("could not bind for connect: %d", result);
@@ -1850,8 +1849,8 @@ static int dlm_tcp_listen_bind(struct socket *sock)
 
 	/* Bind to our port */
 	make_sockaddr(&dlm_local_addr[0], dlm_config.ci_tcp_port, &addr_len);
-	return sock->ops->bind(sock, (struct sockaddr *)&dlm_local_addr[0],
-			       addr_len);
+	return kernel_bind(sock, (struct sockaddr *)&dlm_local_addr[0],
+			   addr_len);
 }
 
 static const struct dlm_proto_ops dlm_tcp_ops = {
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index ead7c287ff373..3a4a7a521476d 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1614,8 +1614,8 @@ static void o2net_start_connect(struct work_struct *work)
 	myaddr.sin_addr.s_addr = mynode->nd_ipv4_address;
 	myaddr.sin_port = htons(0); /* any port */
 
-	ret = sock->ops->bind(sock, (struct sockaddr *)&myaddr,
-			      sizeof(myaddr));
+	ret = kernel_bind(sock, (struct sockaddr *)&myaddr,
+			  sizeof(myaddr));
 	if (ret) {
 		mlog(ML_ERROR, "bind failed with %d at address %pI4\n",
 		     ret, &mynode->nd_ipv4_address);
@@ -1998,7 +1998,7 @@ static int o2net_open_listening_sock(__be32 addr, __be16 port)
 	INIT_WORK(&o2net_listen_work, o2net_accept_many);
 
 	sock->sk->sk_reuse = SK_CAN_REUSE;
-	ret = sock->ops->bind(sock, (struct sockaddr *)&sin, sizeof(sin));
+	ret = kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
 	if (ret < 0) {
 		printk(KERN_ERR "o2net: Error %d while binding socket at "
 		       "%pI4:%u\n", ret, &addr, ntohs(port)); 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index b7764cd57e035..6dcc1cd41b8c5 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2891,9 +2891,9 @@ bind_socket(struct TCP_Server_Info *server)
 	if (server->srcaddr.ss_family != AF_UNSPEC) {
 		/* Bind to the specified local IP address */
 		struct socket *socket = server->ssocket;
-		rc = socket->ops->bind(socket,
-				       (struct sockaddr *) &server->srcaddr,
-				       sizeof(server->srcaddr));
+		rc = kernel_bind(socket,
+				 (struct sockaddr *)&server->srcaddr,
+				 sizeof(server->srcaddr));
 		if (rc < 0) {
 			struct sockaddr_in *saddr4;
 			struct sockaddr_in6 *saddr6;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 6e4ed1e11a3b7..4174076c66fa7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1439,7 +1439,7 @@ static int bind_mcastif_addr(struct socket *sock, struct net_device *dev)
 	sin.sin_addr.s_addr  = addr;
 	sin.sin_port         = 0;
 
-	return sock->ops->bind(sock, (struct sockaddr*)&sin, sizeof(sin));
+	return kernel_bind(sock, (struct sockaddr *)&sin, sizeof(sin));
 }
 
 static void get_mcast_sockaddr(union ipvs_sockaddr *sa, int *salen,
@@ -1546,7 +1546,7 @@ static int make_receive_sock(struct netns_ipvs *ipvs, int id,
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->bcfg, id);
 	sock->sk->sk_bound_dev_if = dev->ifindex;
-	result = sock->ops->bind(sock, (struct sockaddr *)&mcast_addr, salen);
+	result = kernel_bind(sock, (struct sockaddr *)&mcast_addr, salen);
 	if (result < 0) {
 		pr_err("Error binding to the multicast addr\n");
 		goto error;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index d788c6d28986f..a0046e99d6df7 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -145,7 +145,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 		addrlen = sizeof(sin);
 	}
 
-	ret = sock->ops->bind(sock, addr, addrlen);
+	ret = kernel_bind(sock, addr, addrlen);
 	if (ret) {
 		rdsdebug("bind failed with %d at address %pI6c\n",
 			 ret, &conn->c_laddr);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 014fa24418c12..53b3535a1e4a8 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -306,7 +306,7 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 		addr_len = sizeof(*sin);
 	}
 
-	ret = sock->ops->bind(sock, (struct sockaddr *)&ss, addr_len);
+	ret = kernel_bind(sock, (struct sockaddr *)&ss, addr_len);
 	if (ret < 0) {
 		rdsdebug("could not bind %s listener socket: %d\n",
 			 isv6 ? "IPv6" : "IPv4", ret);
diff --git a/net/socket.c b/net/socket.c
index b0189b773d130..426e2c72bb3c6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3519,6 +3519,13 @@ static long compat_sock_ioctl(struct file *file, unsigned int cmd,
 
 int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
 {
+	struct sockaddr_storage address;
+
+	if (addrlen > sizeof(address))
+		return -EINVAL;
+
+	memcpy(&address, addr, addrlen);
+
 	return READ_ONCE(sock->ops)->bind(sock, addr, addrlen);
 }
 EXPORT_SYMBOL(kernel_bind);
-- 
2.42.0.459.ge4e396fd5e-goog


