Return-Path: <netdev+bounces-245823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2404ECD8ACB
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 159D7302F6BE
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77107322749;
	Tue, 23 Dec 2025 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="RjSEVC+a"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0C329C7D;
	Tue, 23 Dec 2025 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766483883; cv=none; b=ifiHMu+HIapqz8tc64hhylHb5eaV9jbdJ/a4M0py7zFg3t9yJGEB4+OGPcrwU6g8YLtjkQKhXkDILPhLsWunjXtQu9GOZ3EQWNDlFM+5gjVVCXnFlRYtvVucoscflcxX5a6KA0a84wfd/+q2qSwZl1+71MSycJwMBkEy4jDK/dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766483883; c=relaxed/simple;
	bh=TrxUyFZPlQjs7e0r6ueVJONGzRevZ/FhmjWNmIsGNLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrBPQGe1YKiafc4vpDIZrVnCKW1OXRj9BPaHpTPdo95zi9gUR1Z4JaOPVK5jqakEyXA9N4k9pANkmRlLDGRUPweyt9Y503hoxRsw8zmV3GwXvwyTZk78OrUEhtu/n9WxFXDWdh9YsQqihO0uwS3cSxP4SUODTIy/VYQ/ywi78eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=RjSEVC+a; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vXyUn-00B31q-No; Tue, 23 Dec 2025 10:15:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=yDGrqLXmWU2pboYhTkpP5V/0hwt+4F3zcefRl6mlCig=; b=RjSEVC+aSVs9CyZGTamDeiH6SK
	1xCz2YGJIbayG8+A25tYAqbwg4Id6+EyD9pRxqtzT1Idda3wwavCBVlygZOBjYwXIPkkXpPtUUFvC
	09UL56Qy/M2fce84PLQqbnV8K1c/2Ml6sIwgTeunSf+2WJVpsiUx4tKFCxq9RHJhcABfWpDMkq3Hg
	xdr7/heDH9WFIiT3jZl7jSL6gp6BxuGlwBCwkTLt5iyy36OPeIphhW7qdk6OKGDssnwHE/eTdsVX7
	yEodPXoCoDjapBfvKuvqdIqdX0d1HtBSmjRGvCHipYPFKxvXeWoqTySZlhVBnO2/Fm7+KODqOhO2F
	X3CLfXtQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vXyUn-0005Ke-9c; Tue, 23 Dec 2025 10:15:57 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vXyUh-009MHY-5f; Tue, 23 Dec 2025 10:15:51 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 23 Dec 2025 10:15:29 +0100
Subject: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on accept()ed
 socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
In-Reply-To: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
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

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 9e1250790f33..8ec8f0844e22 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
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
+	vsock_wait_remote_close(fd);
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
@@ -2371,6 +2399,11 @@ static struct test_case test_cases[] = {
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


