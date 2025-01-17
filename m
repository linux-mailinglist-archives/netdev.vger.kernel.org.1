Return-Path: <netdev+bounces-159468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3612A15945
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A850D188CA37
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484E91D7E41;
	Fri, 17 Jan 2025 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="mxcYjkuV"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678851B21B7
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151224; cv=none; b=BBEZK+6wDdBhfjZOLvVdz3BDrWmEgOD3Ib/Afb1uK7J0RJ3YHDjSfHb01YyfAQYTpkBFUm7/xULzUUdbbbrKQhpb3sgWkQEUAdx/HsjnHtrmFaHi+r3PAlvo8iY6hDqoxlSqpoxwOrjnBV8+enDtM5ZbE2qKfFyJVBuDCidigwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151224; c=relaxed/simple;
	bh=3EUSZXWgbl0hTV9LjEQzWMnHSKDCehkOIqtbZwV2Y90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+ql3RRzaDcjJ+a2eOgEEYaLBsoDxL6X//tUOF2wMUHAcgKdUyxZ0nU/lHxhH2KkfPVsrzCt9C2FiP7NlcpCDYUYkygBzHlREbOyZTN/CdmzIBPRHDsCxEqeO7UfnbDIB8DdE/TRddNGTNFxaYuzhPyowfgDS+aDqpl+v5SeAWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=mxcYjkuV; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tYuNx-008VBE-JG; Fri, 17 Jan 2025 23:00:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=WxRW8O4/j/bQNeepeJ6dOpLUQxcOGQjuIrUFWu6Biqw=; b=mxcYjkuVDCCb+FnHOUEasC1k6a
	pFw038VEOcIg4+gqqdbkN0IUeMJy2YFbtOgwe+QA049y+2HPi2+wrwqQPiDGqLuk9/kEAOHEZfdrc
	775Bvi0CJ5a3G+O1r+isKInQbHMaQc/zlUP40XhGKgnwUO8Q27OV/gbm+jWKzG55ABq/J+/NuoCK5
	6kgDEfskDwXLPye5Mivh54cRAHk+UwU/KNJH7ko2vKZa8pRLHdxs7CzANwUk6CE4y2GwWVNEV5ITB
	YCnUxNfnCJ63W1vOWlq2UWGZAAM/OG/y7TL+ttOnarOSz9R1ha79tCaVDfDQBF3GZV+hO7eAbXdsk
	OSKBURSA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tYuNw-0004u2-Rj; Fri, 17 Jan 2025 23:00:13 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tYuNl-006md8-1l; Fri, 17 Jan 2025 23:00:01 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 17 Jan 2025 22:59:43 +0100
Subject: [PATCH net 3/5] vsock/test: Introduce vsock_bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-vsock-transport-vs-autobind-v1-3-c802c803762d@rbox.co>
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
In-Reply-To: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Add a helper for socket()+bind(). Adapt callers.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/util.c       | 56 +++++++++++++++++-----------------------
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 17 +-----------
 3 files changed, 25 insertions(+), 49 deletions(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..31ee1767c8b73c05cfd219c3d520a677df6e66a6 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -96,33 +96,42 @@ void vsock_wait_remote_close(int fd)
 	close(epollfd);
 }
 
-/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
-int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
+int vsock_bind(unsigned int cid, unsigned int port, int type)
 {
-	struct sockaddr_vm sa_client = {
-		.svm_family = AF_VSOCK,
-		.svm_cid = VMADDR_CID_ANY,
-		.svm_port = bind_port,
-	};
-	struct sockaddr_vm sa_server = {
+	struct sockaddr_vm sa = {
 		.svm_family = AF_VSOCK,
 		.svm_cid = cid,
 		.svm_port = port,
 	};
+	int fd;
 
-	int client_fd, ret;
-
-	client_fd = socket(AF_VSOCK, type, 0);
-	if (client_fd < 0) {
+	fd = socket(AF_VSOCK, type, 0);
+	if (fd < 0) {
 		perror("socket");
 		exit(EXIT_FAILURE);
 	}
 
-	if (bind(client_fd, (struct sockaddr *)&sa_client, sizeof(sa_client))) {
+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa))) {
 		perror("bind");
 		exit(EXIT_FAILURE);
 	}
 
+	return fd;
+}
+
+/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
+int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
+{
+	struct sockaddr_vm sa_server = {
+		.svm_family = AF_VSOCK,
+		.svm_cid = cid,
+		.svm_port = port,
+	};
+
+	int client_fd, ret;
+
+	client_fd = vsock_bind(VMADDR_CID_ANY, bind_port, type);
+
 	timeout_begin(TIMEOUT);
 	do {
 		ret = connect(client_fd, (struct sockaddr *)&sa_server, sizeof(sa_server));
@@ -192,28 +201,9 @@ int vsock_seqpacket_connect(unsigned int cid, unsigned int port)
 /* Listen on <cid, port> and return the file descriptor. */
 static int vsock_listen(unsigned int cid, unsigned int port, int type)
 {
-	union {
-		struct sockaddr sa;
-		struct sockaddr_vm svm;
-	} addr = {
-		.svm = {
-			.svm_family = AF_VSOCK,
-			.svm_port = port,
-			.svm_cid = cid,
-		},
-	};
 	int fd;
 
-	fd = socket(AF_VSOCK, type, 0);
-	if (fd < 0) {
-		perror("socket");
-		exit(EXIT_FAILURE);
-	}
-
-	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
-		perror("bind");
-		exit(EXIT_FAILURE);
-	}
+	fd = vsock_bind(cid, port, type);
 
 	if (listen(fd, 1) < 0) {
 		perror("listen");
diff --git a/tools/testing/vsock/util.h b/tools/testing/vsock/util.h
index ba84d296d8b71e1bcba2abdad337e07aac45e75e..7736594a15d29449d98bd1e9e19c3acd1a623443 100644
--- a/tools/testing/vsock/util.h
+++ b/tools/testing/vsock/util.h
@@ -43,6 +43,7 @@ int vsock_connect(unsigned int cid, unsigned int port, int type);
 int vsock_accept(unsigned int cid, unsigned int port,
 		 struct sockaddr_vm *clientaddrp, int type);
 int vsock_stream_connect(unsigned int cid, unsigned int port);
+int vsock_bind(unsigned int cid, unsigned int port, int type);
 int vsock_bind_connect(unsigned int cid, unsigned int port,
 		       unsigned int bind_port, int type);
 int vsock_seqpacket_connect(unsigned int cid, unsigned int port);
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 48f17641ca504316d1199926149c9bd62eb2921d..28a5083bbfd600cf84a1a85cec2f272ce6912dd3 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -108,24 +108,9 @@ static void test_stream_bind_only_client(const struct test_opts *opts)
 
 static void test_stream_bind_only_server(const struct test_opts *opts)
 {
-	union {
-		struct sockaddr sa;
-		struct sockaddr_vm svm;
-	} addr = {
-		.svm = {
-			.svm_family = AF_VSOCK,
-			.svm_port = opts->peer_port,
-			.svm_cid = VMADDR_CID_ANY,
-		},
-	};
 	int fd;
 
-	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
-
-	if (bind(fd, &addr.sa, sizeof(addr.svm)) < 0) {
-		perror("bind");
-		exit(EXIT_FAILURE);
-	}
+	fd = vsock_bind(VMADDR_CID_ANY, opts->peer_port, SOCK_STREAM);
 
 	/* Notify the client that the server is ready */
 	control_writeln("BIND");

-- 
2.47.1


