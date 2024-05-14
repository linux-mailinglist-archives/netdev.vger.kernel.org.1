Return-Path: <netdev+bounces-96231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D5A8C4ACE
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 03:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50321C212F7
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73283EDC;
	Tue, 14 May 2024 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ra2pHEDd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9F610942;
	Tue, 14 May 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649224; cv=none; b=M9wSRzXz1Juc086V7IXv2w9Zlsgt38YiWLycfs1xKgYETqvpbkxhOmYqulvrFzhmYyr0C3hDghPaC8VJJ7oDkalMYqdx2nL9+vbjZMr6NNCHWl7Dgoy5WhOL8G+usp6c2KgmOvRX1sw8GkcEbB1F0rYwqA9FxDJgzYz9w2lHLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649224; c=relaxed/simple;
	bh=NgVt6XeU+I2oaazTnOoG5Kow+tEb+mvwZ+uG+3wUE0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doTI/469c7WLtXk/Xx3wMEx2klnM52FFKVxLpInU+BfXYHIkxrTq8bCIONFs9TjbzQjbzmBIaO2ok/zhUJMshMxrKqx7I7g/Gauc0RgmhctNiphOIAywuADKwvlax1NbJxIT4sT1p12fxebvX8hIewDB2RjbemNZ4/T78l+OErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ra2pHEDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FD9C4AF17;
	Tue, 14 May 2024 01:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715649223;
	bh=NgVt6XeU+I2oaazTnOoG5Kow+tEb+mvwZ+uG+3wUE0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ra2pHEDdNC0Cx58ex+NYJiXBZ5QKkEqBMl/n+XcOy87AveUpF3jHvLFB+4PzFKjjz
	 O32eUknpczKuPe8A7QuRxQMQl8Y37XZz8hAl1DrPrhZCdTJoWd3J/OrxMnbvWQ/3LV
	 8LnISjskjCxFo5kdPMzmfXtbByQY+Gb1Q9XuK4qWlg94ltPKslDdYPmUxDjF1M1Ucg
	 KiPbZi0g0cFllYtme1Fo/lXL1VxSmA4H0frUrS/u0B0deeeOl5ryBu6tiVu4XLKkG0
	 Z8FwS4iacLSD8RJ4BmQp5K8QmMxQsfJVjVYFtSBNEZTeJZhi01L5AtbC8rZvJjT+AX
	 cSZImGNcM5nuQ==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fw@strlen.de
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	netdev@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH net-next v2 7/8] mptcp: move mptcp_pm_gen.h's include
Date: Mon, 13 May 2024 18:13:31 -0700
Message-ID: <20240514011335.176158-8-martineau@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240514011335.176158-1-martineau@kernel.org>
References: <20240514011335.176158-1-martineau@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Nothing from protocol.h depends on mptcp_pm_gen.h, only code from
pm_netlink.c and pm_userspace.c depends on it.

So this include can be moved where it is needed to avoid a "unused
includes" warning.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 net/mptcp/pm_netlink.c   | 1 +
 net/mptcp/pm_userspace.c | 1 +
 net/mptcp/protocol.h     | 2 --
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5c17d39146ea..7f53e022e27e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -14,6 +14,7 @@
 
 #include "protocol.h"
 #include "mib.h"
+#include "mptcp_pm_gen.h"
 
 static int pm_nl_pernet_id;
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9f5d422d5ef6..f0a4590506c6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -6,6 +6,7 @@
 
 #include "protocol.h"
 #include "mib.h"
+#include "mptcp_pm_gen.h"
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 39fc47e6b88a..7aa47e2dd52b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -14,8 +14,6 @@
 #include <net/genetlink.h>
 #include <net/rstreason.h>
 
-#include "mptcp_pm_gen.h"
-
 #define MPTCP_SUPPORTED_VERSION	1
 
 /* MPTCP option bits */
-- 
2.45.0


