Return-Path: <netdev+bounces-128144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE129978460
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0B61F262BA
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7451A707D;
	Fri, 13 Sep 2024 15:09:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61357CBA
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240162; cv=none; b=A+Duko9A2rJm0LXsdaAG0JXGaS/ixA/EnwGelLa5SV7DFIe45lt/jtyacqD8MgXTKK5E+nPd0kdyZu+/maZNvAJ/CteFLNg4P64H1eG1MviT7W4z6yLtnQDwMX4QDGh4jt7DWqiE+BuZOKMp5JUIeTI9MQpLzLVXKOk1SRzKxnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240162; c=relaxed/simple;
	bh=thMplTqGsVoAKQjqdpX+ivt5zp8lr0k4I0E/jip2AYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S88R/YIMeaRmTLxkV1HFLejVJ6/eCc22OXvzRIXwX0fcqgZkKmgAJCIDDlGiQQkEJdOwfnnfyx5OWXFgt/dyahHe/PJV0XqEBY1W0ksrpNckftC8orTz9t6xAL3SenzLY1JdVfWlONPjSbXg2XhrWKB7GXOlmKx0/YV/3br9ckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20573eb852aso22403595ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240160; x=1726844960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snrfTNjrCzwTsZeODG3Q86ZYElMWnO3LXsHzUKno/38=;
        b=L2RzS6NhkYaUXnXKZW0RgC1tMkc4JnnbAvtDyJFUdlqtVhAfRJCPnT+joEJskBStZQ
         57eA9b3LhzAiho/xTgWnVdXZ0spZPNCbHUBBEDe2YiWYrlA2ku2+3gsop4/sPx6NWlwm
         Wo8sta3GO57bb/fh+Led4gKpzheW3n0Y8hHUbJdWezNkuirwHgldwhvPF0x6gZKfca0+
         ua2xr2zLvt5yWHbh+WuEg6OWQB7adsl3sF04d6lXIRZsHzOh64cy+6VmWxtXPgvpPX9t
         G2WOV4NT4l6452MYw9A+FhY2jwt8NQ7li6Uo1LymopfJ4vBo3KOH6ECQqKZcRCnKovAa
         6vtA==
X-Gm-Message-State: AOJu0YycU5S490OCe4pYjs7orutaqJaVYo7inTG3Jq6MwVCyoetaEyNY
	1pYxaWlWnmLsWinBw1wzN4dj/dHAo9To/jL8kzwR93Oeiuj+RQsKaifH
X-Google-Smtp-Source: AGHT+IE7QOSdlHjULOBOI83xfaemrriY7xbxfdlyhAQ4bMaKhnfh7ZDRrWK/bh4OzAjdWPSODRa04g==
X-Received: by 2002:a17:902:e884:b0:205:8a8b:bd2a with SMTP id d9443c01a7336-2074c6df0bemr185612255ad.22.1726240160113;
        Fri, 13 Sep 2024 08:09:20 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdd00esm29051635ad.130.2024.09.13.08.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:19 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH net-next v1 3/4] selftests: ncdevmem: Implement loopback mode
Date: Fri, 13 Sep 2024 08:09:12 -0700
Message-ID: <20240913150913.1280238-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913150913.1280238-1-sdf@fomichev.me>
References: <20240913150913.1280238-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In loopback mode, start both client and server on
the same IP and share dmabuf. The kernel will forward
the packets back to the receiving socket. Note that in
this mode, the server doesn't exercise bind-rx and
flow steering. Driver's TX and RX paths are also bypassed.
IOW, we are testing only UAPI and TCP stack.

Running with the following:
  dev=eth0
  addr=192.168.1.4

  ip addr add $addr dev $dev
  ip link set $dev up
  ret=$(echo -e "hello\nworld" | ./tools/testing/selftests/drivers/net/ncdevmem -L -f $dev -s ::ffff:$addr -p 5201)
  echo "[$ret]"

  want=$(echo -e "hello\nworld")
  if [ "$ret" != "$want" ]; then
          echo "FAIL!"
          exit 1
  fi

Outputs:
  using queues 0..1
  binding to address ::ffff:192.168.1.4:5201
  Waiting or connection on ::ffff:192.168.1.4:5201
  got tx dmabuf id=1
  Connect to ::ffff:192.168.1.4 5201 (via eth0)
  Got connection from ::ffff:192.168.1.4:54040
  DEBUG: read line_size=6
  DEBUG: sendmsg_ret=6
  recvmsg ret=6
  received frag_page=0, in_page_offset=0, frag_offset=0, frag_size=6, token=1, total_received=6, dmabuf_id=1
  total_received=6
  tx complete [0,0]
  DEBUG: read line_size=6
  DEBUG: sendmsg_ret=6
  recvmsg ret=6
  received frag_page=0, in_page_offset=6, frag_offset=6, frag_size=6, token=1, total_received=12, dmabuf_id=1
  total_received=12
  tx complete [1,1]
  ncdevmem: tx ok
  recvmsg ret=0
  client exited
  ncdevmem: ok
  page_aligned_frags=0, non_page_aligned_frags=2
  [hello
  world]

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/ncdevmem.c  | 97 +++++++++++++------
 1 file changed, 67 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ncdevmem.c b/tools/testing/selftests/drivers/net/ncdevmem.c
index 4e0dbe2e515b..615818cf5349 100644
--- a/tools/testing/selftests/drivers/net/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/ncdevmem.c
@@ -12,6 +12,7 @@
 #define __iovec_defined
 #include <fcntl.h>
 #include <malloc.h>
+#include <pthread.h>
 #include <error.h>
 
 #include <arpa/inet.h>
@@ -52,6 +53,9 @@ static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
 static unsigned int tx_dmabuf_id;
+static bool loopback;
+static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 
 struct memory_buffer {
 	int fd;
@@ -358,6 +362,8 @@ static int bind_tx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 
 	fprintf(stderr, "got tx dmabuf id=%d\n", rsp->id);
 	tx_dmabuf_id = rsp->id;
+	if (loopback)
+		dmabuf_id = tx_dmabuf_id;
 
 	netdev_bind_tx_req_free(req);
 	netdev_bind_tx_rsp_free(rsp);
@@ -409,11 +415,11 @@ static int do_server(struct memory_buffer *mem)
 	struct sockaddr_in6 client_addr;
 	struct sockaddr_in6 server_sin;
 	size_t page_aligned_frags = 0;
+	struct ynl_sock *ys = NULL;
 	size_t total_received = 0;
 	socklen_t client_addr_len;
 	bool is_devmem = false;
 	char *tmp_mem = NULL;
-	struct ynl_sock *ys;
 	char iobuf[819200];
 	char buffer[256];
 	int socket_fd;
@@ -425,33 +431,33 @@ static int do_server(struct memory_buffer *mem)
 	if (ret < 0)
 		error(1, 0, "parse server address");
 
-	if (reset_flow_steering())
-		error(1, 0, "Failed to reset flow steering\n");
+	if (!loopback) {
+		if (reset_flow_steering())
+			error(1, 0, "Failed to reset flow steering\n");
 
-	if (configure_headersplit(1))
-		error(1, 0, "Failed to enable TCP header split\n");
+		if (configure_headersplit(1))
+			error(1, 0, "Failed to enable TCP header split\n");
 
-	/* Configure RSS to divert all traffic from our devmem queues */
-	if (configure_rss())
-		error(1, 0, "Failed to configure rss\n");
+		if (configure_rss())
+			error(1, 0, "Failed to configure rss\n");
 
-	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering(&server_sin))
-		error(1, 0, "Failed to configure flow steering\n");
+		if (configure_flow_steering(&server_sin))
+			error(1, 0, "Failed to configure flow steering\n");
 
-	sleep(1);
+		sleep(1);
 
-	queues = malloc(sizeof(*queues) * num_queues);
+		queues = malloc(sizeof(*queues) * num_queues);
 
-	for (i = 0; i < num_queues; i++) {
-		queues[i]._present.type = 1;
-		queues[i]._present.id = 1;
-		queues[i].type = NETDEV_QUEUE_TYPE_RX;
-		queues[i].id = start_queue + i;
-	}
+		for (i = 0; i < num_queues; i++) {
+			queues[i]._present.type = 1;
+			queues[i]._present.id = 1;
+			queues[i].type = NETDEV_QUEUE_TYPE_RX;
+			queues[i].id = start_queue + i;
+		}
 
-	if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
-		error(1, 0, "Failed to bind\n");
+		if (bind_rx_queue(ifindex, mem->fd, queues, num_queues, &ys))
+			error(1, 0, "Failed to bind\n");
+	}
 
 	tmp_mem = malloc(mem->size);
 	if (!tmp_mem)
@@ -478,6 +484,12 @@ static int do_server(struct memory_buffer *mem)
 
 	client_addr_len = sizeof(client_addr);
 
+	if (loopback) {
+		pthread_mutex_lock(&mutex);
+		pthread_cond_signal(&cond);
+		pthread_mutex_unlock(&mutex);
+	}
+
 	inet_ntop(AF_INET6, &server_sin.sin6_addr, buffer,
 		  sizeof(buffer));
 	fprintf(stderr, "Waiting or connection on %s:%d\n", buffer,
@@ -514,7 +526,7 @@ static int do_server(struct memory_buffer *mem)
 		}
 		if (ret == 0) {
 			fprintf(stderr, "client exited\n");
-			goto cleanup;
+			break;
 		}
 
 		i++;
@@ -585,15 +597,11 @@ static int do_server(struct memory_buffer *mem)
 	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
 		page_aligned_frags, non_page_aligned_frags);
 
-	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
-		page_aligned_frags, non_page_aligned_frags);
-
-cleanup:
-
 	free(tmp_mem);
 	close(client_fd);
 	close(socket_fd);
-	ynl_sock_destroy(ys);
+	if (ys)
+		ynl_sock_destroy(ys);
 
 	return 0;
 }
@@ -818,6 +826,15 @@ static int do_client(struct memory_buffer *mem)
 	return 0;
 }
 
+static void *server_thread(void *data)
+{
+	struct memory_buffer *mem = data;
+
+	do_server(mem);
+
+	return (void *)NULL;
+}
+
 int main(int argc, char *argv[])
 {
 	struct memory_buffer *mem;
@@ -825,11 +842,14 @@ int main(int argc, char *argv[])
 	int probe = 0;
 	int ret;
 
-	while ((opt = getopt(argc, argv, "ls:c:p:q:t:f:P")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:q:t:f:P")) != -1) {
 		switch (opt) {
 		case 'l':
 			is_server = 1;
 			break;
+		case 'L':
+			loopback = true;
+			break;
 		case 's':
 			server_ip = optarg;
 			break;
@@ -883,7 +903,24 @@ int main(int argc, char *argv[])
 	}
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
-	ret = is_server ? do_server(mem) : do_client(mem);
+	if (loopback) {
+		pthread_t thread;
+		int rc;
+
+		rc = pthread_create(&thread, NULL, server_thread, mem);
+		if (rc != 0)
+			error(-1, -errno, "pthread_create failed");
+
+		pthread_mutex_lock(&mutex);
+		pthread_cond_wait(&cond, &mutex);
+		pthread_mutex_unlock(&mutex);
+
+		ret = do_client(mem);
+
+		pthread_join(thread, NULL);
+	} else {
+		ret = is_server ? do_server(mem) : do_client(mem);
+	}
 	provider->free(mem);
 
 	return ret;
-- 
2.46.0


