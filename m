Return-Path: <netdev+bounces-161957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF36FA24C75
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 02:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09207A23B0
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 01:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE3182D7;
	Sun,  2 Feb 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3lmYqYN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E31798F
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738460853; cv=none; b=A8hxjJgeqQEB29GJ2hB/lO8giO4i82LlFWPvbhpiOMqD/NV2EMUJFcsTSGQP1YilliqSnN9tmRVqUr5FrBpPa+enEa3vlDUH1DnK+jaURfbYDHsxJjBasNyFnjrnj6HU44Mx0gX5/3INABlhfN8A+hU/sSFQvdWrpv2vy/2C8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738460853; c=relaxed/simple;
	bh=klOsCPM0XywMAWQwqPdFP0d84MqHXOAKVodnOpclkXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLr/6RvWNXKxooyLl+Ej87jrfall4R4Vpf2Bd9l25xVV12aKV/09cEQo8fO57wsiLoo1o3tNjSSnRWbVrwiKFaq7kyFT2RZRM/8mN8423vdtU4FPKtDqP2lIwKUkH7vXNCvMlnXvZUD+q2J17o7gGwhy+adseAjCemSHAqDj1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3lmYqYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEF4C4CEE1;
	Sun,  2 Feb 2025 01:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738460853;
	bh=klOsCPM0XywMAWQwqPdFP0d84MqHXOAKVodnOpclkXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p3lmYqYNwqy3g+jtlJQAv5eokxj2UFS7GgForwlnYuSUttyA1cRXsRlhAVl09gXzD
	 bPK9unNkd6D8rBcQbMhsD+qBi//QKVhDY2iH/IVGzIDNKDZ8k7vvvt2eVMvJqHE87s
	 dCEHCDQ07lsGDaA7iJpnAzkvTPpXiYsZeycA/4Ma2N431CLrotYjvPkBid6TPuSI1A
	 SEoO1Em0LKHS1GKW5YZ0lhVUu+x1jkztmfe+stjO7kNL/26WuF5XnMvhsBb7RN+8jZ
	 JB7X4pdFximvZHlwM4XwUyPuairaA1ZFq3irzezHFwT4+4Scmn8DHy1ajRXGu7t5kU
	 CAR8BHir9GtWA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	kuniyu@amazon.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/3] MAINTAINERS: add a general entry for BSD sockets
Date: Sat,  1 Feb 2025 17:47:27 -0800
Message-ID: <20250202014728.1005003-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250202014728.1005003-1-kuba@kernel.org>
References: <20250202014728.1005003-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a MAINTAINERS entry for BSD sockets. List the top 3
reviewers as maintainers. The entry is meant to cover core
socket code (of which there isn't much) but also reviews
of any new socket families.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5c59ec5126..f61a8815fd28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16647,6 +16647,22 @@ F:	include/net/tls.h
 F:	include/uapi/linux/tls.h
 F:	net/tls/*
 
+NETWORKING [SOCKETS]
+M:	Eric Dumazet <edumazet@google.com>
+M:	Kuniyuki Iwashima <kuniyu@amazon.com>
+M:	Paolo Abeni <pabeni@redhat.com>
+M:	Willem de Bruijn <willemb@google.com>
+S:	Maintained
+F:	include/linux/sock_diag.h
+F:	include/linux/socket.h
+F:	include/linux/sockptr.h
+F:	include/net/sock.h
+F:	include/net/sock_reuseport.h
+F:	include/uapi/linux/socket.h
+F:	net/core/*sock*
+F:	net/core/scm.c
+F:	net/socket.c
+
 NETXEN (1/10) GbE SUPPORT
 M:	Manish Chopra <manishc@marvell.com>
 M:	Rahul Verma <rahulv@marvell.com>
-- 
2.48.1


