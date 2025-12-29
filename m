Return-Path: <netdev+bounces-246282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BACACE813F
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AACE4301D662
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998C244660;
	Mon, 29 Dec 2025 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="eDUWI4/z"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D423BD05;
	Mon, 29 Dec 2025 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767037417; cv=none; b=E3CtD7hXSwZkOOm0+AJXrRUTBQ8OLY6vVAH8H4Rsm/Ly5dUQFCB/mnio2JuT6+8WVfn7t7xCkGiSaPFfeym8iHdPOiibLgzlYjEC0hA7GlwARPvRemgVyxZ4+zuUMrIO9xVWk982AQTbbJDFHhMhWciiETAVo0GRmEPB7vtY4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767037417; c=relaxed/simple;
	bh=qnFOcfaQ+Fdf0303gqILTNW2VZkb6iJ3agfVLqGwgPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzB9tGkASGz2FYxuRbPEk2WZs2TdRnjJ4bJUFcKKZU20GmSO7lcWln8d8P9ij/cObnLh+OSBRyK+HbB7pjzGe+o0mIzScjc4HcufvkraetXK2CLa281zpEvKhq/VlhAQqFnYYxZDIrk3Mz1+C4ybVDrFCLEI5tNWbSeOrDaNr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=eDUWI4/z; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ9R-00Cgrp-S4; Mon, 29 Dec 2025 20:43:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=u0Lx+3sG2FvgAEiBDLuAH3C9233OnOOeqeRLegSabKQ=; b=eDUWI4/zjOPlxS1BwqtyYc7/9+
	B6n2v5NJo2eDQT/nXqGZ5c8BQmIKUzpAhoHxg0KoTslerEXmjn4rc0aWOax4JiFWq9V03GJmHK6x9
	T48nrvrMTVGC6o28tIwxnus9T2hAJ0clb3lIfvCBq6ufI9vi1xP7oact4j5FIVEfG4piEIt0e+uYH
	YzinvpznFQv9RoUxi6emboRYp8dAJp6IPes3rumg1qemXqEF0keuCEXQH517AbYJZl4fGF6QV/cwd
	X/Mp3RAYnEpp2rm+A7YhVkHV2Xk+0loZtci7S7Jcy4Wou6YrYiFIC1BsGK2M6ZiPz25kFQEdakwZN
	tzOSiWrA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vaJ9R-0007qe-IK; Mon, 29 Dec 2025 20:43:33 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vaJ9A-0055FL-3P; Mon, 29 Dec 2025 20:43:16 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 29 Dec 2025 20:43:11 +0100
Subject: [PATCH net v2 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-vsock-child-sock-custom-sockopt-v2-2-64778d6c4f88@rbox.co>
References: <20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co>
In-Reply-To: <20251229-vsock-child-sock-custom-sockopt-v2-0-64778d6c4f88@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.3

Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
handled by vsock's implementation.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 9e1250790f33..bbe3723babdc 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2192,6 +2192,33 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
 	close(fd);
 }
 
+static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
+static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	enable_so_zerocopy_check(fd);
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2371,6 +2398,11 @@ static struct test_case test_cases[] = {
 		.run_client = test_seqpacket_unread_bytes_client,
 		.run_server = test_seqpacket_unread_bytes_server,
 	},
+	{
+		.name = "SOCK_STREAM accept()ed socket custom setsockopt()",
+		.run_client = test_stream_accepted_setsockopt_client,
+		.run_server = test_stream_accepted_setsockopt_server,
+	},
 	{},
 };
 

-- 
2.52.0


