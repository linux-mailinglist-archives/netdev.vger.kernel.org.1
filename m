Return-Path: <netdev+bounces-216540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB9B34680
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 17:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC202A49C2
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E972FE595;
	Mon, 25 Aug 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBIwN+nB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA802D0278
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137477; cv=none; b=FIm+6two8IXJ+5GqpKfXLJXL/BgVNzUgbT7byZhSLNU7BaMFOrwD5st1fbVgY28X/j0ZvPw5t+yl4YiJ/2tPp8SVWxbI64NxwLprxRgPPTNoCGxLDIigMVQSGcTRAcMwFOgbRjJGADHK6usMCPZy7KkZ2qN8eDfrfEgGF4p/fKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137477; c=relaxed/simple;
	bh=Vr5NE99oavi33Y3SF/I3tW6QtyNajfUPhB5mdYrmT5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFiWE3+pAEi8JPk5dYfi4Jsb6OOJ38p2DuBn9lDkXEyLl1l7JENYcbRDVOOWIJ3yNw+vrq4D6xSirxcC1zasLEvun7f7Whm2EjcD8+Z3sTvTYg8+1yeb9vlzZ1fnDAovi9ihr8nPsz4zBQ/XBPsGOVSctwWvFszCzPz7mg9pQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBIwN+nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F50C4CEED;
	Mon, 25 Aug 2025 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756137477;
	bh=Vr5NE99oavi33Y3SF/I3tW6QtyNajfUPhB5mdYrmT5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=bBIwN+nBBWsK6/c3UwRdrV7Pk3j7Z756sQz+PsRjqLTpurdS4RmelP1/LPGVK2uqU
	 s2N+m2uoa9wVdVMDvSXKxtdQ2K8/SjTLXKtN64yyZZi5P55ETwyu4FThNLUsthG6zE
	 IcRFsNK2nMiTrhjKZ9qAruMU1i1V+dCoXkEEo39deO9ZBbYENNCkGkcPzZCc9/c86r
	 hOTi4rsHt+97xavckHCRQMhLVBl54wzlGCxaZ9FsffkNXJeLqthVNTaQfYSqYqVRvy
	 X9rrFQqlGMU0ul9L0uiH7n18v3YFRhnew5c89ko4/tBEldzEiynbbOF3jLMTizggIA
	 C9Wz9U6EoUlWw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: retire Boris from TLS maintainers
Date: Mon, 25 Aug 2025 08:57:53 -0700
Message-ID: <20250825155753.2178045-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a steady stream of TLS changes and bugs. We need active
maintainers in this area, and Boris hasn't been participating
much in upstream work. Move him to CREDITS. While at it also
add Dave Watson there who was the author of the initial SW
implementation, AFAIU.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 1 -
 CREDITS     | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9567c9448fc8..ccb2327b6133 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17832,7 +17832,6 @@ F:	net/ipv6/syncookies.c
 F:	net/ipv6/tcp*.c
 
 NETWORKING [TLS]
-M:	Boris Pismenny <borisp@nvidia.com>
 M:	John Fastabend <john.fastabend@gmail.com>
 M:	Jakub Kicinski <kuba@kernel.org>
 L:	netdev@vger.kernel.org
diff --git a/CREDITS b/CREDITS
index a357f9cbb05d..a687c3c35c4c 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3222,6 +3222,10 @@ D: AIC5800 IEEE 1394, RAW I/O on 1394
 D: Starter of Linux1394 effort
 S: ask per mail for current address
 
+N: Boris Pismenny
+E: borisp@mellanox.com
+D: Kernel TLS implementation and offload support.
+
 N: Nicolas Pitre
 E: nico@fluxnic.net
 D: StrongARM SA1100 support integrator & hacker
@@ -4168,6 +4172,9 @@ S: 1513 Brewster Dr.
 S: Carrollton, TX 75010
 S: USA
 
+N: Dave Watson
+D: Kernel TLS implementation.
+
 N: Tim Waugh
 E: tim@cyberelk.net
 D: Co-architect of the parallel-port sharing system
-- 
2.51.0


