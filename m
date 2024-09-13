Return-Path: <netdev+bounces-128143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2845897845D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38020B21F6A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40619F402;
	Fri, 13 Sep 2024 15:09:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85441940B1
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240161; cv=none; b=vDM11r+7KnaPJC1m1lRnzOri0QJQYNk5S7AtchkhWfw3a075eAl1ssyzYsifc6KIUV6XmhTYxYti8YUPW2GAVWdwrxfZVpXNzRhygEeOd+a4/ps7i5rbc7JynExBZ8SxelbUtE6NPhyqnrGUTEbzIXDtGIBbBCA9vJQHxikechU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240161; c=relaxed/simple;
	bh=SkvKwuPo7UxOmrDrzH7qaSZXVrlBq3i98F02AMtVG8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeySjy2iVrhX5Qhf8teNm/DFORs61+9B0nnL1YJ7alnC6G0LO594wuA6s8WhESEE7ne2SM/O/4UT5C0HSB2cn1Lkf6+lKM2fSc+ucsx9L6Z/KRk8yYyGIa64cL3mp8HDwpYprXbqKfrUAGzygFMOBjKKb32FQQStIsmvUrgoeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718816be6cbso1810066b3a.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240159; x=1726844959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pm2lrSuufGMlKVGzBX5HFp3PItCIiPEtXPG9Wd2GwOo=;
        b=Qg7ZwbSylMGkjAKe7wtEBXFoOGVgdMouGcaDd7JY1pWBiTJwk8PFJZnA9RjE4ThXkg
         pebXbkHaqOWTeVMah5n0hR8jFHr5SFA9adOC/rGXOoMjGzVxMqykEm+03deSU7d36Ls9
         JfJVyk5WD5e7WvjFsKaOnWVNQ0rG4sjNI+6oPyAnM09mA38q7Z5HcoUtzp3ghhtgrcET
         52A4sTul0CebXJ/WZMsEcuK+UIWDxfwzKDEZJ0yQd6dppdpdWU6VpHmZd7hyi67KE44Z
         nsEX1ou955LPl4HeGXRx1Gd9Ue6ZBEQR+eTJfmwXpvOtkPy7eldlQWn3N7K1wvOCJ5ty
         n1xA==
X-Gm-Message-State: AOJu0YxN5kWQdMk/JIQj184pi5W8T/x0LoBKcCSQISh7GYObmhXobS+I
	eZLkEX9eX2LtrTztJ+2ShrMNNIiz2EtR/SiItNl1C7Nw+lM6E3iq7o9c
X-Google-Smtp-Source: AGHT+IGs6xAlSg+koXxhtL87EXdX3TkjxUFKlDpjZX8x4PTDNnJMuNVwnIvt00JqhNPO1MfYm0mDcQ==
X-Received: by 2002:a05:6a00:b83:b0:70b:a46:7db7 with SMTP id d2e1a72fcca58-719260962c0mr9703018b3a.16.1726240158771;
        Fri, 13 Sep 2024 08:09:18 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbb527csm3523941a12.27.2024.09.13.08.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:09:18 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [RFC PATCH net-next v1 2/4] selftests: ncdevmem: Implement client side
Date: Fri, 13 Sep 2024 08:09:11 -0700
Message-ID: <20240913150913.1280238-3-sdf@fomichev.me>
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

The offset and size are passed via iov_base and iov_len. The dmabuf
is passed via SCM_DEVMEM_DMABUF cmsg.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../testing/selftests/drivers/net/ncdevmem.c  | 212 +++++++++++++++++-
 1 file changed, 210 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ncdevmem.c b/tools/testing/selftests/drivers/net/ncdevmem.c
index 3883a67d387f..4e0dbe2e515b 100644
--- a/tools/testing/selftests/drivers/net/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/ncdevmem.c
@@ -22,6 +22,7 @@
 
 #include <linux/memfd.h>
 #include <linux/dma-buf.h>
+#include <linux/errqueue.h>
 #include <linux/udmabuf.h>
 #include <libmnl/libmnl.h>
 #include <linux/types.h>
@@ -50,6 +51,7 @@ static int num_queues = 1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
+static unsigned int tx_dmabuf_id;
 
 struct memory_buffer {
 	int fd;
@@ -326,6 +328,49 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	return -1;
 }
 
+static int bind_tx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
+			 struct ynl_sock **ys)
+{
+	struct netdev_bind_tx_req *req = NULL;
+	struct netdev_bind_tx_rsp *rsp = NULL;
+	struct ynl_error yerr;
+
+	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
+	if (!*ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = netdev_bind_tx_req_alloc();
+	netdev_bind_tx_req_set_ifindex(req, ifindex);
+	netdev_bind_tx_req_set_fd(req, dmabuf_fd);
+
+	rsp = netdev_bind_tx(*ys, req);
+	if (!rsp) {
+		perror("netdev_bind_tx");
+		goto err_close;
+	}
+
+	if (!rsp->_present.id) {
+		perror("id not present");
+		goto err_close;
+	}
+
+	fprintf(stderr, "got tx dmabuf id=%d\n", rsp->id);
+	tx_dmabuf_id = rsp->id;
+
+	netdev_bind_tx_req_free(req);
+	netdev_bind_tx_rsp_free(rsp);
+
+	return 0;
+
+err_close:
+	fprintf(stderr, "YNL failed: %s\n", (*ys)->err.msg);
+	netdev_bind_tx_req_free(req);
+	ynl_sock_destroy(*ys);
+	return -1;
+}
+
 static int enable_reuseaddr(int fd)
 {
 	int opt = 1;
@@ -356,7 +401,7 @@ static int parse_address(const char *str, int port, struct sockaddr_in6 *sin6)
 	return 0;
 }
 
-int do_server(struct memory_buffer *mem)
+static int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
 	struct netdev_queue_id *queues;
@@ -610,6 +655,169 @@ void run_devmem_tests(void)
 	provider->free(mem);
 }
 
+static void wait_compl(int fd)
+{
+	struct sock_extended_err *serr;
+	struct msghdr msg = {};
+	char control[100] = {};
+	struct cmsghdr *cm;
+	int retries = 10;
+	__u32 hi, lo;
+	int ret;
+
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	while (retries--) {
+		ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
+		if (ret < 0) {
+			if (errno == EAGAIN) {
+				usleep(100);
+				continue;
+			}
+			perror("recvmsg(MSG_ERRQUEUE)");
+			return;
+		}
+		if (msg.msg_flags & MSG_CTRUNC)
+			error(1, 0, "MSG_CTRUNC\n");
+
+		for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+			if (cm->cmsg_level != SOL_IP &&
+			    cm->cmsg_level != SOL_IPV6)
+				continue;
+			if (cm->cmsg_level == SOL_IP &&
+			    cm->cmsg_type != IP_RECVERR)
+				continue;
+			if (cm->cmsg_level == SOL_IPV6 &&
+			    cm->cmsg_type != IPV6_RECVERR)
+				continue;
+
+			serr = (void *)CMSG_DATA(cm);
+			if (serr->ee_origin != SO_EE_ORIGIN_ZEROCOPY)
+				error(1, 0, "wrong origin %u", serr->ee_origin);
+			if (serr->ee_errno != 0)
+				error(1, 0, "wrong errno %d", serr->ee_errno);
+
+			hi = serr->ee_data;
+			lo = serr->ee_info;
+
+			fprintf(stderr, "tx complete [%d,%d]\n", lo, hi);
+			return;
+		}
+	}
+
+	fprintf(stderr, "did not receive tx completion\n");
+}
+
+static int do_client(struct memory_buffer *mem)
+{
+	struct sockaddr_in6 server_sin;
+	struct ynl_sock *ys = NULL;
+	ssize_t line_size = 0;
+	char *line = NULL;
+	char buffer[256];
+	size_t len = 0;
+	size_t off = 0;
+	int socket_fd;
+	int opt = 1;
+	int ret;
+
+	ret = parse_address(server_ip, atoi(port), &server_sin);
+	if (ret < 0)
+		error(-1, 0, "parse server address");
+
+	socket_fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (ret < 0) {
+		fprintf(stderr, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+		exit(76);
+	}
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_BINDTODEVICE, ifname,
+			 strlen(ifname) + 1);
+	if (ret) {
+		fprintf(stderr, "%s: [FAIL, bindtodevice]: %s\n", TEST_PREFIX,
+			strerror(errno));
+		exit(76);
+	}
+
+	if (bind_tx_queue(ifindex, mem->fd, &ys))
+		error(1, 0, "Failed to bind\n");
+
+	ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
+	if (ret) {
+		fprintf(stderr, "%s: [FAIL, set sock opt]: %s\n", TEST_PREFIX,
+			strerror(errno));
+		exit(76);
+	}
+
+	inet_ntop(AF_INET6, &server_sin.sin6_addr, buffer, sizeof(buffer));
+	fprintf(stderr, "Connect to %s %d (via %s)\n", buffer,
+		ntohs(server_sin.sin6_port), ifname);
+
+	ret = connect(socket_fd, &server_sin, sizeof(server_sin));
+	if (ret) {
+		fprintf(stderr, "%s: [FAIL, connect]: %s\n", TEST_PREFIX,
+			strerror(errno));
+		exit(76);
+	}
+
+	while (1) {
+		free(line);
+		line = NULL;
+		line_size = getline(&line, &len, stdin);
+
+		if (line_size < 0)
+			break;
+
+		fprintf(stderr, "DEBUG: read line_size=%ld\n", line_size);
+
+		provider->memcpy_to_device(mem, off, line, line_size);
+
+		while (line_size) {
+			struct iovec iov = {
+				.iov_base = (void *)off,
+				.iov_len = line_size,
+			};
+			char ctrl_data[CMSG_SPACE(sizeof(int))];
+			struct msghdr msg = {};
+			struct cmsghdr *cmsg;
+
+			msg.msg_iov = &iov;
+			msg.msg_iovlen = 1;
+
+			msg.msg_control = ctrl_data;
+			msg.msg_controllen = sizeof(ctrl_data);
+
+			cmsg = CMSG_FIRSTHDR(&msg);
+			cmsg->cmsg_level = SOL_SOCKET;
+			cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
+			cmsg->cmsg_len = CMSG_LEN(sizeof(int));
+			*((int *)CMSG_DATA(cmsg)) = tx_dmabuf_id;
+
+			ret = sendmsg(socket_fd, &msg, MSG_SOCK_DEVMEM);
+			if (ret < 0)
+				continue;
+			else
+				fprintf(stderr, "DEBUG: sendmsg_ret=%d\n", ret);
+
+			off += ret;
+			line_size -= ret;
+
+			wait_compl(socket_fd);
+		}
+	}
+
+	fprintf(stderr, "%s: tx ok\n", TEST_PREFIX);
+
+	free(line);
+	close(socket_fd);
+
+	if (ys)
+		ynl_sock_destroy(ys);
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	struct memory_buffer *mem;
@@ -675,7 +883,7 @@ int main(int argc, char *argv[])
 	}
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
-	ret = is_server ? do_server(mem) : 1;
+	ret = is_server ? do_server(mem) : do_client(mem);
 	provider->free(mem);
 
 	return ret;
-- 
2.46.0


