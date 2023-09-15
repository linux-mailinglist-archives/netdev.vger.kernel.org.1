Return-Path: <netdev+bounces-34058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9137A1E62
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0921C20FEA
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B6107B9;
	Fri, 15 Sep 2023 12:15:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE891078B
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 12:15:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F09D82701
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694780133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMEGvb3Sq84IyOhcCt8lUx9+cduXmZG2jRi2oEjFcn4=;
	b=W9u/YQ/Mgx7bd9asRuHN+bqH8w04PycswkILLBwm0naUzt279FEl2LkYwzLAa44vZ1afj7
	jhxS/Gj0J/UGR3rmnWF9xVhLAW3XRxdXEvRWGxxH/WFmPiTORvg+dYpjdyf9wumU0nCnqv
	bRce4GUlyipaEHDGKNxgd7qjPeardiM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-tKhG6OIZNumwp7DvLBGwAg-1; Fri, 15 Sep 2023 08:15:31 -0400
X-MC-Unique: tKhG6OIZNumwp7DvLBGwAg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31c5c762f97so1454184f8f.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 05:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694780129; x=1695384929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMEGvb3Sq84IyOhcCt8lUx9+cduXmZG2jRi2oEjFcn4=;
        b=R5xVcDFzryAshCjDFW+dbDtNpWpxcXh8JzRDmEbpKqGTvdbhoXun9vg3sasjUYXoWD
         DK2GYkiZD+GZDTzC4TIgkWLMiWQbsvnXlJdGa4Dfy2xrhzspf9UqeVKydIJLn8ZaQVmF
         Z87Ow1fU7nFe3K0E23x+GdU3KKkYN0mJu7GWsGQHPTLc9Wop5IRlkGNiHFU9n1zYaIk0
         kk/cMxq3pyHVvKXzaSqOWy4/kXNM7QZcZ3XIGepcKHqKRCqryzBu6i1vYG21LFkpRdbs
         jLlsu37byOJeBF6116NW3DQlf1yye0rpPdTJzz7fcMgN4nPufsWfJRgvVH04JNMMa3Zr
         3o3A==
X-Gm-Message-State: AOJu0YzehyrZyKjGw00e7AUHSrxSLV8MzqEEcNPCPqCzDTFi1zqPD2ZI
	GVAD6exSlNxSCNpnQKW8qikq9PRKKxW26e9MpEJxo44OuR5sCNMO2RijG4Sh8be5I7sa9Oidh6Y
	FbYYG5QqEvn8ABFkVK4jKiL3qJAj3T0zQtmb3Qx701SDDfb+uDP/bMmrFqYUKaQXJE5A/XS4Uhs
	DAoeE=
X-Received: by 2002:a5d:6dcb:0:b0:31f:eb8d:4823 with SMTP id d11-20020a5d6dcb000000b0031feb8d4823mr1120626wrz.26.1694780125514;
        Fri, 15 Sep 2023 05:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmZEMz8JTAkutLT6oF8NF90vZ5bmQukR1ASa3FCQYrmpM8Mq37F3IN0p/HD9/gA/uhMXLXfw==
X-Received: by 2002:a5d:6dcb:0:b0:31f:eb8d:4823 with SMTP id d11-20020a5d6dcb000000b0031feb8d4823mr1119962wrz.26.1694780101879;
        Fri, 15 Sep 2023 05:15:01 -0700 (PDT)
Received: from step1.lan ([46.222.72.72])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d674c000000b0030ae53550f5sm4257548wrw.51.2023.09.15.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 05:15:00 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	virtualization@lists.linux-foundation.org,
	oxffffaa@gmail.com,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net-next 1/5] vsock/test: add recv_buf() utility function
Date: Fri, 15 Sep 2023 14:14:48 +0200
Message-ID: <20230915121452.87192-2-sgarzare@redhat.com>
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

Move the code of recv_byte() out in a new utility function that
can be used to receive a generic buffer.

This new function can be used when we need to receive a custom
buffer and not just a single 'A' byte.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.h |  1 +
 tools/testing/vsock/util.c | 88 +++++++++++++++++++++++---------------
 2 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index fb99208a95ea..fe31f267e67e 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -42,6 +42,7 @@ int vsock_stream_accept(unsigned int cid, unsigned int port,
 int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 			   struct sockaddr_vm *clientaddrp);
 void vsock_wait_remote_close(int fd);
+void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret);
 void send_byte(int fd, int expected_ret, int flags);
 void recv_byte(int fd, int expected_ret, int flags);
 void run_tests(const struct test_case *test_cases,
diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 01b636d3039a..2826902706e8 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -211,6 +211,58 @@ int vsock_seqpacket_accept(unsigned int cid, unsigned int port,
 	return vsock_accept(cid, port, clientaddrp, SOCK_SEQPACKET);
 }
 
+/* Receive bytes in a buffer and check the return value.
+ *
+ * expected_ret:
+ *  <0 Negative errno (for testing errors)
+ *   0 End-of-file
+ *  >0 Success (bytes successfully read)
+ */
+void recv_buf(int fd, void *buf, size_t len, int flags, ssize_t expected_ret)
+{
+	ssize_t nread = 0;
+	ssize_t ret;
+
+	timeout_begin(TIMEOUT);
+	do {
+		ret = recv(fd, buf + nread, len - nread, flags);
+		timeout_check("recv");
+
+		if (ret == 0 || (ret < 0 && errno != EINTR))
+			break;
+
+		nread += ret;
+	} while (nread < len);
+	timeout_end();
+
+	if (expected_ret < 0) {
+		if (ret != -1) {
+			fprintf(stderr, "bogus recv(2) return value %zd (expected %zd)\n",
+				ret, expected_ret);
+			exit(EXIT_FAILURE);
+		}
+		if (errno != -expected_ret) {
+			perror("recv");
+			exit(EXIT_FAILURE);
+		}
+		return;
+	}
+
+	if (ret < 0) {
+		perror("recv");
+		exit(EXIT_FAILURE);
+	}
+
+	if (nread != expected_ret) {
+		if (ret == 0)
+			fprintf(stderr, "unexpected EOF while receiving bytes\n");
+
+		fprintf(stderr, "bogus recv(2) bytes read %zd (expected %zd)\n",
+			nread, expected_ret);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /* Transmit one byte and check the return value.
  *
  * expected_ret:
@@ -270,43 +322,9 @@ void send_byte(int fd, int expected_ret, int flags)
 void recv_byte(int fd, int expected_ret, int flags)
 {
 	uint8_t byte;
-	ssize_t nread;
-
-	timeout_begin(TIMEOUT);
-	do {
-		nread = recv(fd, &byte, sizeof(byte), flags);
-		timeout_check("read");
-	} while (nread < 0 && errno == EINTR);
-	timeout_end();
-
-	if (expected_ret < 0) {
-		if (nread != -1) {
-			fprintf(stderr, "bogus recv(2) return value %zd\n",
-				nread);
-			exit(EXIT_FAILURE);
-		}
-		if (errno != -expected_ret) {
-			perror("read");
-			exit(EXIT_FAILURE);
-		}
-		return;
-	}
 
-	if (nread < 0) {
-		perror("read");
-		exit(EXIT_FAILURE);
-	}
-	if (nread == 0) {
-		if (expected_ret == 0)
-			return;
+	recv_buf(fd, &byte, sizeof(byte), flags, expected_ret);
 
-		fprintf(stderr, "unexpected EOF while receiving byte\n");
-		exit(EXIT_FAILURE);
-	}
-	if (nread != sizeof(byte)) {
-		fprintf(stderr, "bogus recv(2) return value %zd\n", nread);
-		exit(EXIT_FAILURE);
-	}
 	if (byte != 'A') {
 		fprintf(stderr, "unexpected byte read %c\n", byte);
 		exit(EXIT_FAILURE);
-- 
2.41.0


