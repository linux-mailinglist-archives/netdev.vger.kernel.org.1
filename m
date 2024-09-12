Return-Path: <netdev+bounces-127891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A81976F5C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB31F2416F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C71BFE14;
	Thu, 12 Sep 2024 17:13:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A13D1BF7E8
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161184; cv=none; b=jkvYVIgvQeaN2OntnIp3sooYIx30bHNBRPfcxc+2dagiRS5pK/aoisOH/3CGcXe/ufn0WmF4NEPb+8UAqU+SWBRvE+LrJi/yr4pjAMBMNEi2GyuF28crsx0XOf1MvDhFEkq57eNw13NqPnP1JxEzhuz0I3lF7StixwtyhtzGc28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161184; c=relaxed/simple;
	bh=IzWaiPNvZ7bQ6KBmyTsfp9Gb6J1yGwGTM4RbN18g7x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY2ujJ62R1EjVaXjVbQlxozKVjBju8jNBGdNcS2zGpIhdQWmGT5myXDoaO8/08DhwMQ/UL/Hc8by0wdL4+D2gvok26lFJXVkK+IDlX7HoseQ7XxUHCPL0k2XPkYbWscn87R8ELVwR5K10g53HYKYgDPGuDtBo8FxtbYcFkiq+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7db2e3fa438so113852a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161182; x=1726765982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu7kSS7sdkITFMlpea1V2u6bxvXk4hNcHq8Tp7Juc5k=;
        b=sFkGYkqoaL915KEpriOS+ArPjRjT1GeIsmayq95LSVauKkXHGZCqrNjGY9zKXuDSxa
         XxXdbvg96KxZOGjySnAOYBB5bdcWA6x8mAsbTe+vx+ptifbxd/Jx+B5+/5oVRxiy2BNs
         BkVV/kH8uHJZFRKY6d7GFyxJMNt7Yp1z7E3GB9TjlwgmBpumfX+zbk2vhUFLvhSbPffR
         lEnwewCnEAUB0Xi4yGEM0nG4i/Etw6WtopMj2uuIWE3Aa8w+nezYODIaL93p+e7Ln26R
         FfCd+2cQzVkXYoGuq3FwR4FxeJfYZXDnaWeSDmgEt1S5pplXyO0a9mGwwVohKWtbrbbm
         wM1g==
X-Gm-Message-State: AOJu0YygtekwXbIwmdUJevidLeFIRCQpT+nEIIXNgzfD3o5hdTBaeGXe
	J43HIIWIIuzxuHS6Xj+Fd9Rms8eRVjZCSBuBfyr6avp+ESXAH/VvIxtx
X-Google-Smtp-Source: AGHT+IGwkINhU3KQ9dR3W3onRodQXRDmgK+AIiiEdzuxjpKNwfKxVHl//532RlhR/LPuP/cs3vKE2w==
X-Received: by 2002:a05:6a20:b2a8:b0:1cf:3677:1c4a with SMTP id adf61e73a8af0-1cf75eb94cfmr3877393637.16.1726161182281;
        Thu, 12 Sep 2024 10:13:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb581esm2011440a12.34.2024.09.12.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:13:01 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 08/13] selftests: ncdevmem: Switch to AF_INET6
Date: Thu, 12 Sep 2024 10:12:46 -0700
Message-ID: <20240912171251.937743-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912171251.937743-1-sdf@fomichev.me>
References: <20240912171251.937743-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dualstack socket to support both v4 and v6. v4-mapped-v6 address
can be used to do v4.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 84 +++++++++++++++++---------
 1 file changed, 56 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 829a7066387a..d82e550369c0 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -206,10 +206,18 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 	return run_command("sudo ethtool -L %s rx %u tx %u", ifname, rx, tx);
 }
 
-static int configure_flow_steering(void)
+static int configure_flow_steering(struct sockaddr_in6 *server_sin)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 dst-ip %s dst-port %s queue %d >&2",
-			   ifname, server_ip, port, start_queue);
+	const char *addr = server_ip;
+	const char *type = "tcp6";
+
+	if (IN6_IS_ADDR_V4MAPPED(&server_sin->sin6_addr)) {
+		type = "tcp4";
+		addr = strrchr(server_ip, ':') + 1;
+	}
+
+	return run_command("sudo ethtool -N %s flow-type %s dst-ip %s dst-port %s queue %d >&2",
+			   ifname, type, addr, port, start_queue);
 }
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
@@ -257,13 +265,43 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
+static int enable_reuseaddr(int fd)
+{
+	int opt = 1;
+	int ret;
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt));
+	if (ret)
+		return -errno;
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
+	if (ret)
+		return -errno;
+
+	return 0;
+}
+
+static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
+{
+	int ret;
+
+	sin6->sin6_family = AF_INET6;
+	sin6->sin6_port = htons(port);
+
+	ret = inet_pton(sin6->sin6_family, str, &sin6->sin6_addr);
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
 int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
 	size_t non_page_aligned_frags = 0;
-	struct sockaddr_in client_addr;
-	struct sockaddr_in server_sin;
+	struct sockaddr_in6 client_addr;
+	struct sockaddr_in6 server_sin;
 	size_t page_aligned_frags = 0;
 	size_t total_received = 0;
 	socklen_t client_addr_len;
@@ -275,9 +313,12 @@ int do_server(struct memory_buffer *mem)
 	int socket_fd;
 	int client_fd;
 	size_t i = 0;
-	int opt = 1;
 	int ret;
 
+	ret = parse_address(server_ip, atoi(port), &server_sin);
+	if (ret < 0)
+		error(1, 0, "parse server address");
+
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
 
@@ -286,7 +327,7 @@ int do_server(struct memory_buffer *mem)
 		error(1, 0, "Failed to configure rss\n");
 
 	/* Flow steer our devmem flows to start_queue */
-	if (configure_flow_steering())
+	if (configure_flow_steering(&server_sin))
 		error(1, 0, "Failed to configure flow steering\n");
 
 	sleep(1);
@@ -307,29 +348,16 @@ int do_server(struct memory_buffer *mem)
 	if (!tmp_mem)
 		error(1, ENOMEM, "malloc failed");
 
-	server_sin.sin_family = AF_INET;
-	server_sin.sin_port = htons(atoi(port));
-
-	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
-	if (socket < 0)
-		error(1, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
-
-	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
+	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
 	if (socket < 0)
 		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
-	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
-			 sizeof(opt));
-	if (ret)
-		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
-
-	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
-			 sizeof(opt));
+	ret = enable_reuseaddr(socket_fd);
 	if (ret)
-		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, reuseaddr]\n", TEST_PREFIX);
 
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
-		ntohs(server_sin.sin_port));
+		ntohs(server_sin.sin6_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
@@ -341,16 +369,16 @@ int do_server(struct memory_buffer *mem)
 
 	client_addr_len = sizeof(client_addr);
 
-	inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
+	inet_ntop(AF_INET6, &server_sin.sin6_addr, buffer,
 		  sizeof(buffer));
 	fprintf(stderr, "Waiting or connection on %s:%d\n", buffer,
-		ntohs(server_sin.sin_port));
+		ntohs(server_sin.sin6_port));
 	client_fd = accept(socket_fd, &client_addr, &client_addr_len);
 
-	inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
+	inet_ntop(AF_INET6, &client_addr.sin6_addr, buffer,
 		  sizeof(buffer));
 	fprintf(stderr, "Got connection from %s:%d\n", buffer,
-		ntohs(client_addr.sin_port));
+		ntohs(client_addr.sin6_port));
 
 	while (1) {
 		struct iovec iov = { .iov_base = iobuf,
-- 
2.46.0


