Return-Path: <netdev+bounces-245776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74329CD7667
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 00:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3143A309C072
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 22:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9031346FAA;
	Mon, 22 Dec 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ0QEB3l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD843346E6B;
	Mon, 22 Dec 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444245; cv=none; b=rtznN3wjsYQc53bSK/Q1UJl7athPjG3ydHMN4ikxRJyLbhXYmyBYxsWT+CCRN8acva82a8d3mJKK6u0sTa1Bqq6UES4ewUFPYIe5Bt4E5McES6PSX6lTDdAlfL2G6VxakVAkn+YPNJoUFWfO0G4QI33xGlnu1LJfNfxb/tNJDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444245; c=relaxed/simple;
	bh=mnu/65nkOLYVGKJLRJS1wFV3oVaFZSvkIiASImiT1og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOnKXtsmJ3Hz83xSoCB0Ci2tRNnHyK9hoK2q+rlYFPXDmn2gOu+huvM0fm1AbLIBvMI4zU1ZuJUFOM8EyL6E5pypGqjQQIH9oAHBRE88O5dJ8zFwI9eDedwoiGqcVY5NPtntiAxUgbCRV7uvyh/D7/ig8RcPLOxXZMgChIPu6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ0QEB3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4872C16AAE;
	Mon, 22 Dec 2025 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766444245;
	bh=mnu/65nkOLYVGKJLRJS1wFV3oVaFZSvkIiASImiT1og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQ0QEB3llvXAyckXQmubfldaQrQ/csmppSFOSSlpGBk4qEAlD2qQhcdcqRSTd0l5t
	 OcpltpjhtTKqQGXD+Irtukm3nkIS85gGFKaWQruo6rftavzlfsfzUU535K4NwX83cN
	 qiKeOy4IKX3B9Uf13S4/qM2fsaDI3y56i+W9698stA6FvVL+9A67AoG7CyJiRNRsCP
	 9cvMutU3rP6BvuFmerXle16EIDf2BiVEVk8yrzN6U6nqXGZcOQv6vHDVZkjNOZwKa9
	 bPcIwPtRF74baqJNgZuxTmrS4ejxHQTp283yzy5bnWrZ8hoccfnUjkDqqWSJ2FqPpY
	 y6XdxRMdfzs9w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 10/11] tools headers: Sync linux/socket.h with kernel sources
Date: Mon, 22 Dec 2025 14:57:15 -0800
Message-ID: <20251222225716.3565649-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <20251222225716.3565649-1-namhyung@kernel.org>
References: <20251222225716.3565649-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  d73c167708739137 ("socket: Split out a getsockname helper for io_uring")
  4677e78800bbde62 ("socket: Unify getsockname and getpeername implementation")
  bf33247a90d3e85d ("net: Add struct sockaddr_unsized for sockaddr of unknown length")

This should be used to beautify socket syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h

Please see tools/include/README.kernel-copies.

Cc: netdev@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../perf/trace/beauty/include/linux/socket.h  | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 77d7c59f5d8b1cb2..ec715ad4bf25f5f7 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -32,11 +32,29 @@ typedef __kernel_sa_family_t	sa_family_t;
  *	1003.1g requires sa_family_t and that sa_data is char.
  */
 
+/* Deprecated for in-kernel use. Use struct sockaddr_unsized instead. */
 struct sockaddr {
 	sa_family_t	sa_family;	/* address family, AF_xxx	*/
 	char		sa_data[14];	/* 14 bytes of protocol address	*/
 };
 
+/**
+ * struct sockaddr_unsized - Unspecified size sockaddr for callbacks
+ * @sa_family: Address family (AF_UNIX, AF_INET, AF_INET6, etc.)
+ * @sa_data: Flexible array for address data
+ *
+ * This structure is designed for callback interfaces where the
+ * total size is known via the sockaddr_len parameter. Unlike struct
+ * sockaddr which has a fixed 14-byte sa_data limit or struct
+ * sockaddr_storage which has a fixed 128-byte sa_data limit, this
+ * structure can accommodate addresses of any size, but must be used
+ * carefully.
+ */
+struct sockaddr_unsized {
+	__kernel_sa_family_t	sa_family;	/* address family, AF_xxx */
+	char			sa_data[];	/* flexible address data */
+};
+
 struct linger {
 	int		l_onoff;	/* Linger active		*/
 	int		l_linger;	/* How long to linger for	*/
@@ -450,10 +468,10 @@ extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
 			 int addrlen);
 extern int __sys_listen(int fd, int backlog);
 extern int __sys_listen_socket(struct socket *sock, int backlog);
+extern int do_getsockname(struct socket *sock, int peer,
+			  struct sockaddr __user *usockaddr, int __user *usockaddr_len);
 extern int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
-			     int __user *usockaddr_len);
-extern int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
-			     int __user *usockaddr_len);
+			     int __user *usockaddr_len, int peer);
 extern int __sys_socketpair(int family, int type, int protocol,
 			    int __user *usockvec);
 extern int __sys_shutdown_sock(struct socket *sock, int how);
-- 
2.52.0.351.gbe84eed79e-goog


