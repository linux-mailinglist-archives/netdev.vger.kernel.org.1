Return-Path: <netdev+bounces-34054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E56A7A1E49
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE4B2824EC
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD20110794;
	Fri, 15 Sep 2023 12:15:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3810782
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:15:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2195C2134
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694780111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FP0IT9D2do1i/qXeFKAhCEFBnRZ2j14dkv/qsnZwWc=;
	b=CSqrGf3WBmVVU+zExhHPCtrNwcPygnWsyTQZcR+p3wZy39B/zuOlLwwYntP3bFbq7AN2lw
	obt4a0nJTXdzerWMhjqoa4u2PgNytvIPgUXVsSijafylaZGbHLi2IyFHrd3wzycoQCzS56
	7eKs8B5WaNrY4nUVQ6CvJv7MEjm9Amk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-MNGFVl62MBOIG-RT8K4b1Q-1; Fri, 15 Sep 2023 08:15:10 -0400
X-MC-Unique: MNGFVl62MBOIG-RT8K4b1Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31f46ccee0fso1288938f8f.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780108; x=1695384908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FP0IT9D2do1i/qXeFKAhCEFBnRZ2j14dkv/qsnZwWc=;
        b=fG14w8K3mzvbqgexHsoK5QtYR5l+GceC9O+kSSz6b9Mtky3OKSKi40QmLZDqLX1NTC
         VozKhnsH51OcY8AuMOtcramC8GOrVyGUvqPgZsX26umQeoYs59yOGg0CGmU9tNssLghv
         7JOtbWbUcZYVcv7jgfx+scJ6L8P56ICUzu949XHAX19SwrrkUUvZ/u3myQAGR0OTWr2U
         1ZWvfhuoOhItSwlKd9khFA2LYlM5AMl/sZtRptmMt4/5YoskKWDAk0x0WUWMbsT+xzk5
         mbfZioUKOyfZL/ZuIbeAfAIY4tP5krysaVrdqB1Mk44mM9csVeSRFjhsZrv470Ie8heh
         2PLg==
X-Gm-Message-State: AOJu0YwbjgR9ss5cNCvFr8mYmC9MG19sbDGGbGujldUd17grfzJf7OZO
	zYOt6mq+AV8gnUePrYay9I7y2CxlmxillKC3HsRMR/Dl01AnKGLGH+Eod4Vi3jDXYe5gQiGhy6R
	nFmE1odC6n4O+zER6LxjcsQFClDk0Bc48e1B78HlrU9DHCAFJBhFcofF/6ix2AoBt+AEERwNRTN
	UZp3Y=
X-Received: by 2002:adf:d202:0:b0:31f:f8a7:a26c with SMTP id j2-20020adfd202000000b0031ff8a7a26cmr619576wrh.25.1694780108305;
        Fri, 15 Sep 2023 05:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJF6T446VPfAO2MFW1Z0pgHTw0vTmbNmzAcUKmbss0UAE9W23X6m2itdgZ2I4QNcEqteZP5Q==
X-Received: by 2002:adf:d202:0:b0:31f:f8a7:a26c with SMTP id j2-20020adfd202000000b0031ff8a7a26cmr619554wrh.25.1694780107830;
        Fri, 15 Sep 2023 05:15:07 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id d6-20020adfef86000000b0031f82743e25sm4300429wro.67.2023.09.15.05.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:15:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	virtualization@lists.linux-foundation.org,
	oxffffaa@gmail.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 2/5] vsock/test: use recv_buf() in vsock_test.c
Date: Fri, 15 Sep 2023 14:14:49 +0200
Message-ID: <20230915121452.87192-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915121452.87192-1-sgarzare@redhat.com>
References: <20230915121452.87192-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We have a very common pattern used in vsock_test that we can
now replace with the new recv_buf().

This allows us to reuse the code we already had to check the
actual return value and wait for all bytes to be received with
an appropriate timeout.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 104 +++++--------------------------
 1 file changed, 17 insertions(+), 87 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 90718c2fd4ea..d1dcbaeb477a 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -301,7 +301,6 @@ static void test_msg_peek_server(const struct test_opts *opts,
 	unsigned char buf_half[MSG_PEEK_BUF_LEN / 2];
 	unsigned char buf_normal[MSG_PEEK_BUF_LEN];
 	unsigned char buf_peek[MSG_PEEK_BUF_LEN];
-	ssize_t res;
 	int fd;
 
 	if (seqpacket)
@@ -315,34 +314,16 @@ static void test_msg_peek_server(const struct test_opts *opts,
 	}
 
 	/* Peek from empty socket. */
-	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT);
-	if (res != -1) {
-		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
-
-	if (errno != EAGAIN) {
-		perror("EAGAIN expected");
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK | MSG_DONTWAIT,
+		 -EAGAIN);
 
 	control_writeln("SRVREADY");
 
 	/* Peek part of data. */
-	res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK);
-	if (res != sizeof(buf_half)) {
-		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
-			sizeof(buf_half), res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_half, sizeof(buf_half), MSG_PEEK, sizeof(buf_half));
 
 	/* Peek whole data. */
-	res = recv(fd, buf_peek, sizeof(buf_peek), MSG_PEEK);
-	if (res != sizeof(buf_peek)) {
-		fprintf(stderr, "recv(2) + MSG_PEEK, expected %zu, got %zi\n",
-			sizeof(buf_peek), res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_peek, sizeof(buf_peek), MSG_PEEK, sizeof(buf_peek));
 
 	/* Compare partial and full peek. */
 	if (memcmp(buf_half, buf_peek, sizeof(buf_half))) {
@@ -355,22 +336,11 @@ static void test_msg_peek_server(const struct test_opts *opts,
 		 * so check it with MSG_PEEK. We must get length
 		 * of the message.
 		 */
-		res = recv(fd, buf_half, sizeof(buf_half), MSG_PEEK |
-			   MSG_TRUNC);
-		if (res != sizeof(buf_peek)) {
-			fprintf(stderr,
-				"recv(2) + MSG_PEEK | MSG_TRUNC, exp %zu, got %zi\n",
-				sizeof(buf_half), res);
-			exit(EXIT_FAILURE);
-		}
+		recv_buf(fd, buf_half, sizeof(buf_half), MSG_PEEK | MSG_TRUNC,
+			 sizeof(buf_peek));
 	}
 
-	res = recv(fd, buf_normal, sizeof(buf_normal), 0);
-	if (res != sizeof(buf_normal)) {
-		fprintf(stderr, "recv(2), expected %zu, got %zi\n",
-			sizeof(buf_normal), res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf_normal, sizeof(buf_normal), 0, sizeof(buf_normal));
 
 	/* Compare full peek and normal read. */
 	if (memcmp(buf_peek, buf_normal, sizeof(buf_peek))) {
@@ -900,7 +870,6 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 	unsigned long lowat_val = RCVLOWAT_BUF_SIZE;
 	char buf[RCVLOWAT_BUF_SIZE];
 	struct pollfd fds;
-	ssize_t read_res;
 	short poll_flags;
 	int fd;
 
@@ -955,12 +924,7 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 	/* Use MSG_DONTWAIT, if call is going to wait, EAGAIN
 	 * will be returned.
 	 */
-	read_res = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
-	if (read_res != RCVLOWAT_BUF_SIZE) {
-		fprintf(stderr, "Unexpected recv result %zi\n",
-			read_res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf, sizeof(buf), MSG_DONTWAIT, RCVLOWAT_BUF_SIZE);
 
 	control_writeln("POLLDONE");
 
@@ -972,7 +936,7 @@ static void test_stream_poll_rcvlowat_client(const struct test_opts *opts)
 static void test_inv_buf_client(const struct test_opts *opts, bool stream)
 {
 	unsigned char data[INV_BUF_TEST_DATA_LEN] = {0};
-	ssize_t ret;
+	ssize_t expected_ret;
 	int fd;
 
 	if (stream)
@@ -988,39 +952,18 @@ static void test_inv_buf_client(const struct test_opts *opts, bool stream)
 	control_expectln("SENDDONE");
 
 	/* Use invalid buffer here. */
-	ret = recv(fd, NULL, sizeof(data), 0);
-	if (ret != -1) {
-		fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
-		exit(EXIT_FAILURE);
-	}
-
-	if (errno != EFAULT) {
-		fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
-		exit(EXIT_FAILURE);
-	}
-
-	ret = recv(fd, data, sizeof(data), MSG_DONTWAIT);
+	recv_buf(fd, NULL, sizeof(data), 0, -EFAULT);
 
 	if (stream) {
 		/* For SOCK_STREAM we must continue reading. */
-		if (ret != sizeof(data)) {
-			fprintf(stderr, "expected recv(2) success, got %zi\n", ret);
-			exit(EXIT_FAILURE);
-		}
-		/* Don't check errno in case of success. */
+		expected_ret = sizeof(data);
 	} else {
 		/* For SOCK_SEQPACKET socket's queue must be empty. */
-		if (ret != -1) {
-			fprintf(stderr, "expected recv(2) failure, got %zi\n", ret);
-			exit(EXIT_FAILURE);
-		}
-
-		if (errno != EAGAIN) {
-			fprintf(stderr, "unexpected recv(2) errno %d\n", errno);
-			exit(EXIT_FAILURE);
-		}
+		expected_ret = -EAGAIN;
 	}
 
+	recv_buf(fd, data, sizeof(data), MSG_DONTWAIT, expected_ret);
+
 	control_writeln("DONE");
 
 	close(fd);
@@ -1117,7 +1060,6 @@ static void test_stream_virtio_skb_merge_client(const struct test_opts *opts)
 static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 {
 	unsigned char buf[64];
-	ssize_t res;
 	int fd;
 
 	fd = vsock_stream_accept(VMADDR_CID_ANY, 1234, NULL);
@@ -1129,26 +1071,14 @@ static void test_stream_virtio_skb_merge_server(const struct test_opts *opts)
 	control_expectln("SEND0");
 
 	/* Read skbuff partially. */
-	res = recv(fd, buf, 2, 0);
-	if (res != 2) {
-		fprintf(stderr, "expected recv(2) returns 2 bytes, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf, 2, 0, 2);
 
 	control_writeln("REPLY0");
 	control_expectln("SEND1");
 
-	res = recv(fd, buf + 2, sizeof(buf) - 2, 0);
-	if (res != 8) {
-		fprintf(stderr, "expected recv(2) returns 8 bytes, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf + 2, 8, 0, 8);
 
-	res = recv(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT);
-	if (res != -1) {
-		fprintf(stderr, "expected recv(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	recv_buf(fd, buf, sizeof(buf) - 8 - 2, MSG_DONTWAIT, -EAGAIN);
 
 	if (memcmp(buf, HELLO_STR WORLD_STR, strlen(HELLO_STR WORLD_STR))) {
 		fprintf(stderr, "pattern mismatch\n");
-- 
2.41.0


