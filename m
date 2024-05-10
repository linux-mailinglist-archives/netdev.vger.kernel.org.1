Return-Path: <netdev+bounces-95417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3388C2303
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 009B8B20DCE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980CA17164F;
	Fri, 10 May 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gksBMzTm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95D171647;
	Fri, 10 May 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339955; cv=none; b=IhAISdGj1KqtkxCvST72a5NZGZlGXAbjrdgvLR6l/PNhWIl6wfHf1Q5R9C2d4MSD4g91F1WaFFSY9atg3ym2kprqtj+wAAg63vlxkLgfTmFokzdr3Lp8mMyQJXv8fqutQaEZrRCdyN0Cwiscz0F/ixpUaGyaRwmRsOyz+NGxNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339955; c=relaxed/simple;
	bh=0qU/gOVgR4w23LOX1Zx5qlGuFAeDrYdyX/AcBPsUaTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=baC7Sx4vgmjt7uX3B/37npE9x/ybRrhNKVov0XO5llbKP4DopmjMFqy0yZEk3QafizqVxRxdQXyDb0AfZHLzleQ4GfvgIlHFOzY1chLVr6X7PmolnYJX6XeKEecgaBN3RG54lL+i9V4XrEAVT00hJN+LU63nspPua9W8yzRhiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gksBMzTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2948C32783;
	Fri, 10 May 2024 11:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339955;
	bh=0qU/gOVgR4w23LOX1Zx5qlGuFAeDrYdyX/AcBPsUaTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gksBMzTmGSGTENEl2EH6c4CyIwlcoGV/0tklnj7AdXV1WoVD+93L8+1vrZyto+UV4
	 4kcFvNCw42wPjO4PNtCTjIc6u/PAdWma5AFA1WteqhJb0P7769l41oPgBdr7VVTz91
	 SWCvLKKCdMRCgdzoIMmKZCsnvJW9mLKKq1mc50lz0GKzr9uOsurdwD3Qw8RuH9ss+L
	 2HPD62zaDKH6HuJky8qIZCN5Wz1tm/ASSSlWbJU+HWU2nm/gr8LnWuDaW5RauxO+RE
	 CwS9FoUrOgjgoUP6vRen7p33WYMvdNE2hdcrFn/Xe3MuityLBq1BHfEPmzYTed67IJ
	 Jag86unjwxB3Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 May 2024 13:18:37 +0200
Subject: [PATCH net-next 7/8] mptcp: move mptcp_pm_gen.h's include
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-upstream-net-next-20240509-misc-improvements-v1-7-4f25579e62ba@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
In-Reply-To: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=0qU/gOVgR4w23LOX1Zx5qlGuFAeDrYdyX/AcBPsUaTU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPgKcyj0TQnpFbvKf9qbjboDG/3ukzMr1dnpsH
 YHr/OTLFvaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj4CnAAKCRD2t4JPQmmg
 c5gKD/4/Qf6JyFQojNqOHb83IgZ06inLDIryY6SJ8JXugXsJtEQ/2k3cbltqI9xau7TRP376NIU
 BRlhMQ7C/ni/Q9uRPHUdo2lkXM2flbAFQKSldXOzNkSmL46QwdOd81d4fb+IazfOYPQPIcnQVSr
 niR1WbRz6LsYl+9nqyaP7sSdNVhzSKwQY93sqdFp1jdrGotMUu36DU0rytvo65f5aIItBgEIgCU
 oRaYwmv9nc/nsHlbEt8MPvI3lpaIO9vtizq/15ZNTYLZ66MM1seOSmdK0l7+id0ensOOzpj2VAI
 bSVSS5VrjFKFxnRz0+Zi+kcFgyZW8rb73lFxPlhFF5KmAGr5cC7A7aRvoVH5stCzn4Q2e1yHCT6
 A8FFxC/aQ+RuN0Qk8vDuBpgRccYKqeOfGqWjFOf8QHRE38SayzW5zOWSi/0MO4pn+9kPs5QBQ8g
 18raPSEs1u1tragJecfRRM84inYKUb8x8leqr8SPpGA/XmDHmBQbZlY1doRSwg7rM9m6MEbkJep
 HEoR8Shcir2HKwd1qP8bzebzFN8FULwqEgwuCGLgE79JKQ8S/iGNB1Tj2lV5yHPnQwnqCkFzylf
 Dl4Uk29CQv0OzXbTPGa9SFYkZBBhuHkJJ0IgzWfBwZy8xwgs0yq3F31n3MLyfrCdwo5Dge+t2Kx
 Y953lIbJWdEmdHA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Nothing from protocol.h depends on mptcp_pm_gen.h, only code from
pm_netlink.c and pm_userspace.c depends on it.

So this include can be moved where it is needed to avoid a "unused
includes" warning.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
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
2.43.0


