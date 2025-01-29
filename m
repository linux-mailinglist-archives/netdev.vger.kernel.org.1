Return-Path: <netdev+bounces-161552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6EEA22474
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 20:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7B93A2A7F
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD5F1E1C1F;
	Wed, 29 Jan 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wsj/W3yd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ECB194089
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738178018; cv=none; b=rhVXmZE1BEuD2Wjrn3bcuJnDLILXqNGaFIGGLIVHjeVo6jEOl95ocm4fHqf4sPOnymWHZ3VjbliNMApf/VbtIME5bUZ9n+ueSRo3E0C2knqM5wTJEexZTdqU1+eTc4tMRAGnWutC30ll0SDhoII+N9b7CGFHb7sZ6i6qviGJ2Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738178018; c=relaxed/simple;
	bh=Msud56ndjxyg3+7UNV4u6VFr093ng8xlqxmmSSFtdh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fj2nrbgWr/jL2J9+tcQl9u3qHeAd29VNJ4FTCp3CVNj/HmPjhMsHPscOnY2C8Sd+/VAkLOiMm+qdYEaU1Mb9s3dFNOjQKWAzIq/a0a6LUvFcOiaeqKVzF+O/Clkll146N/xsKf8FeMXdjhOQ3u2HfZfuOlqr2wefMG8uXvPZV3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wsj/W3yd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C89C4CED1;
	Wed, 29 Jan 2025 19:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738178017;
	bh=Msud56ndjxyg3+7UNV4u6VFr093ng8xlqxmmSSFtdh0=;
	h=From:To:Cc:Subject:Date:From;
	b=Wsj/W3ydP4wKn7qPWzt3gH4fdN5sn8CiEICHc41+E5ml68p/3tBvDFRQbdP6uS/Ln
	 N5KAXQ1xlbedzK4cb9zXnTqp0+VHBwAw+fbKNl8IaFbO9SBs8YMgqhsgVb0wC4n4IY
	 9n54LYJFiUlYodXvQGm1fHRBzQctr+o5KAqEOpJXJ1wqNajdAWRL8XYq1EVuy65W9a
	 3hJ6cuxWkzLMhfz93QPUZ8UMXnLuf9+Jt4uKK839znwgwqToNxMsLkqCdGMdIAcZv/
	 TDKEJDA6/N4s+nh9+mc/kMCzPuSHFo+e1kmxK0tpl94zv87uRAymejMCKjQ4lsCAZV
	 p9HO2pqVNJ76A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ncardwell@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: add Neal to TCP maintainers
Date: Wed, 29 Jan 2025 11:13:32 -0800
Message-ID: <20250129191332.2526140-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neal Cardwell has been indispensable in TCP reviews
and investigations, especially protocol-related.
Neal is also the author of packetdrill.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bcc78c0be70..48030557031e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16524,6 +16524,7 @@ F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
 M:	Eric Dumazet <edumazet@google.com>
+M:	Neal Cardwell <ncardwell@google.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/net_cachelines/tcp_sock.rst
-- 
2.48.1


