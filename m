Return-Path: <netdev+bounces-127886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CE5976F57
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855C11F24D80
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29591BF816;
	Thu, 12 Sep 2024 17:12:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395C1BF800
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161178; cv=none; b=rEYtoF+Ysdc3VJ70f/S7dR6rKk+LXgxUsDcXJqo7s6yftpjNTV2B7nPMsl35HMwTGm0ACe2Dz3LmEjbj5lOhk+YLUt2mv86AGau7+qT9DHNt2SlWzMAg5a4UZePrksPZgaBuotGMkvQiq5hxDkSWcQaltAb9C/BOzBBP0nTx9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161178; c=relaxed/simple;
	bh=qIU/Uno9BJxJdIy//auK6K9HWLg2TXD1Haiyu7O/j+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ7cgs9zeexufqUefs/k+lru1a+VcD0rPdJhGX5UsM7lVABUYHDShQhT237iE+crQXAYltHsdlmZOIBIyLYXAgWNEuCipqZf88wzWy0sxKYnVfEY6fatOrdIMKCecZCoKKnT/PPEli3OefMuK+eq7GrSJa+H8OwFdJfDim8YryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-207397d1000so18761365ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161176; x=1726765976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgsSTQx8vMbVv0FXXtJf2mFV9lIEgAihpXa+rCJ+4lM=;
        b=f1wZ9/RuOVIqB7LPGhX0dtmjNYxfh9aRX/4a9M0Vf484zxh/g1T0Qwicv48zu6ol08
         JLWZ/D9OF4Lp3rif3uAJ0/QMTH0+TX9wsK9pnClGaschb2a/NFD+TaME9PwiaEyNUCQ8
         Bd9ExGeE8UXno+hPgu42ptdThFmv6E8hhICOXgrLYEVlFJuuq7k8u4oH2qcPBMJOhEFq
         5l9njC0wDtxnp97nyTlz5xsW5SAwoOqhaNezZjEo9GoqQRrie7BkeFIu7yebJ0LMDKq6
         cfLJjo8vjTlvIW907HoxCsBVpr5QwfN5g9iPj02RcNaQgZi5yVAtmlPngixckjEiodOe
         qlbQ==
X-Gm-Message-State: AOJu0YwH6WKM1WFv0VHVuRK571iwzRLxt2nbM1+niq4JWOcvw9fKdS3k
	ZBHLGVXF6l0OnFQkkvWnIXrCuaUy+Bw2LhJTd3FHQ8j9jgZb6OI7DOHv
X-Google-Smtp-Source: AGHT+IFJDb6E6GVMvg/hD0flfDJZ07IsSccmeKBUlhjRvcR4i4zkhulsh6nwHsS2AsBGxUFueWzRSQ==
X-Received: by 2002:a17:903:230b:b0:202:2e81:27cd with SMTP id d9443c01a7336-2074c760c12mr123968835ad.26.1726161176003;
        Thu, 12 Sep 2024 10:12:56 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdc382sm16523715ad.171.2024.09.12.10.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:12:55 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 03/13] selftests: ncdevmem: Redirect all non-payload output to stderr
Date: Thu, 12 Sep 2024 10:12:41 -0700
Message-ID: <20240912171251.937743-4-sdf@fomichev.me>
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

That should make it possible to do expected payload validation on
the caller side.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 61 +++++++++++++-------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 3712296d997b..7fb930571ff9 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -77,7 +77,6 @@ static void print_nonzero_bytes(void *ptr, size_t size)
 
 	for (i = 0; i < size; i++)
 		putchar(p[i]);
-	printf("\n");
 }
 
 #define run_command(cmd, ...)                                           \
@@ -85,7 +84,7 @@ static void print_nonzero_bytes(void *ptr, size_t size)
 		char command[256];                                      \
 		memset(command, 0, sizeof(command));                    \
 		snprintf(command, sizeof(command), cmd, ##__VA_ARGS__); \
-		printf("Running: %s\n", command);                       \
+		fprintf(stderr, "Running: %s\n", command);                       \
 		system(command);                                        \
 	})
 
@@ -93,22 +92,22 @@ static int reset_flow_steering(void)
 {
 	int ret = 0;
 
-	ret = run_command("sudo ethtool -K %s ntuple off", ifname);
+	ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
 	if (ret)
 		return ret;
 
-	return run_command("sudo ethtool -K %s ntuple on", ifname);
+	return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
 }
 
 static int configure_headersplit(bool on)
 {
-	return run_command("sudo ethtool -G %s tcp-data-split %s", ifname,
+	return run_command("sudo ethtool -G %s tcp-data-split %s >&2", ifname,
 			   on ? "on" : "off");
 }
 
 static int configure_rss(void)
 {
-	return run_command("sudo ethtool -X %s equal %d", ifname, start_queue);
+	return run_command("sudo ethtool -X %s equal %d >&2", ifname, start_queue);
 }
 
 static int configure_channels(unsigned int rx, unsigned int tx)
@@ -118,7 +117,7 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 
 static int configure_flow_steering(void)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d",
+	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d >&2",
 			   ifname, client_ip, server_ip, port, port, start_queue);
 }
 
@@ -152,7 +151,7 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 		goto err_close;
 	}
 
-	printf("got dmabuf id=%d\n", rsp->id);
+	fprintf(stderr, "got dmabuf id=%d\n", rsp->id);
 	dmabuf_id = rsp->id;
 
 	netdev_bind_rx_req_free(req);
@@ -279,8 +278,8 @@ int do_server(void)
 	if (ret)
 		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
-	printf("binding to address %s:%d\n", server_ip,
-	       ntohs(server_sin.sin_port));
+	fprintf(stderr, "binding to address %s:%d\n", server_ip,
+		ntohs(server_sin.sin_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
@@ -294,14 +293,14 @@ int do_server(void)
 
 	inet_ntop(server_sin.sin_family, &server_sin.sin_addr, buffer,
 		  sizeof(buffer));
-	printf("Waiting or connection on %s:%d\n", buffer,
-	       ntohs(server_sin.sin_port));
+	fprintf(stderr, "Waiting or connection on %s:%d\n", buffer,
+		ntohs(server_sin.sin_port));
 	client_fd = accept(socket_fd, &client_addr, &client_addr_len);
 
 	inet_ntop(client_addr.sin_family, &client_addr.sin_addr, buffer,
 		  sizeof(buffer));
-	printf("Got connection from %s:%d\n", buffer,
-	       ntohs(client_addr.sin_port));
+	fprintf(stderr, "Got connection from %s:%d\n", buffer,
+		ntohs(client_addr.sin_port));
 
 	while (1) {
 		struct iovec iov = { .iov_base = iobuf,
@@ -314,14 +313,13 @@ int do_server(void)
 		ssize_t ret;
 
 		is_devmem = false;
-		printf("\n\n");
 
 		msg.msg_iov = &iov;
 		msg.msg_iovlen = 1;
 		msg.msg_control = ctrl_data;
 		msg.msg_controllen = sizeof(ctrl_data);
 		ret = recvmsg(client_fd, &msg, MSG_SOCK_DEVMEM);
-		printf("recvmsg ret=%ld\n", ret);
+		fprintf(stderr, "recvmsg ret=%ld\n", ret);
 		if (ret < 0 && (errno == EAGAIN || errno == EWOULDBLOCK))
 			continue;
 		if (ret < 0) {
@@ -329,7 +327,7 @@ int do_server(void)
 			continue;
 		}
 		if (ret == 0) {
-			printf("client exited\n");
+			fprintf(stderr, "client exited\n");
 			goto cleanup;
 		}
 
@@ -338,7 +336,7 @@ int do_server(void)
 			if (cm->cmsg_level != SOL_SOCKET ||
 			    (cm->cmsg_type != SCM_DEVMEM_DMABUF &&
 			     cm->cmsg_type != SCM_DEVMEM_LINEAR)) {
-				fprintf(stdout, "skipping non-devmem cmsg\n");
+				fprintf(stderr, "skipping non-devmem cmsg\n");
 				continue;
 			}
 
@@ -349,7 +347,7 @@ int do_server(void)
 				/* TODO: process data copied from skb's linear
 				 * buffer.
 				 */
-				fprintf(stdout,
+				fprintf(stderr,
 					"SCM_DEVMEM_LINEAR. dmabuf_cmsg->frag_size=%u\n",
 					dmabuf_cmsg->frag_size);
 
@@ -360,12 +358,13 @@ int do_server(void)
 			token.token_count = 1;
 
 			total_received += dmabuf_cmsg->frag_size;
-			printf("received frag_page=%llu, in_page_offset=%llu, frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu, dmabuf_id=%u\n",
-			       dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
-			       dmabuf_cmsg->frag_offset % getpagesize(),
-			       dmabuf_cmsg->frag_offset, dmabuf_cmsg->frag_size,
-			       dmabuf_cmsg->frag_token, total_received,
-			       dmabuf_cmsg->dmabuf_id);
+			fprintf(stderr,
+				"received frag_page=%llu, in_page_offset=%llu, frag_offset=%llu, frag_size=%u, token=%u, total_received=%lu, dmabuf_id=%u\n",
+				dmabuf_cmsg->frag_offset >> PAGE_SHIFT,
+				dmabuf_cmsg->frag_offset % getpagesize(),
+				dmabuf_cmsg->frag_offset,
+				dmabuf_cmsg->frag_size, dmabuf_cmsg->frag_token,
+				total_received, dmabuf_cmsg->dmabuf_id);
 
 			if (dmabuf_cmsg->dmabuf_id != dmabuf_id)
 				error(1, 0,
@@ -397,15 +396,15 @@ int do_server(void)
 		if (!is_devmem)
 			error(1, 0, "flow steering error\n");
 
-		printf("total_received=%lu\n", total_received);
+		fprintf(stderr, "total_received=%lu\n", total_received);
 	}
 
-	fprintf(stdout, "%s: ok\n", TEST_PREFIX);
+	fprintf(stderr, "%s: ok\n", TEST_PREFIX);
 
-	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
 		page_aligned_frags, non_page_aligned_frags);
 
-	fprintf(stdout, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
+	fprintf(stderr, "page_aligned_frags=%lu, non_page_aligned_frags=%lu\n",
 		page_aligned_frags, non_page_aligned_frags);
 
 cleanup:
@@ -511,7 +510,7 @@ int main(int argc, char *argv[])
 			probe = 1;
 			break;
 		case '?':
-			printf("unknown option: %c\n", optopt);
+			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;
 		}
 	}
@@ -519,7 +518,7 @@ int main(int argc, char *argv[])
 	ifindex = if_nametoindex(ifname);
 
 	for (; optind < argc; optind++)
-		printf("extra arguments: %s\n", argv[optind]);
+		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
 	if (probe) {
 		run_devmem_tests();
-- 
2.46.0


