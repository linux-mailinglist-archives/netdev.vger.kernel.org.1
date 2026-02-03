Return-Path: <netdev+bounces-256433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A12GLxDgmlHRQMAu9opvQ
	(envelope-from <netdev+bounces-256433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:51:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9FDDDB7
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B345330B18B3
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56613D3483;
	Tue,  3 Feb 2026 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My4hZQWz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4736BCC8;
	Tue,  3 Feb 2026 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144168; cv=none; b=PuavWVS2wd2gVm7BkI+W4KkIz84xhph1h3QaMIO5l0mrcIptULpz6DX6mJ28OycsG15M42HXfW3gQRYxcFGhanyVFwogMf95EIdY5S8lELaOByQyO504n6Xdp/94zLPsSMPARAgrhO4k2rknMYjIK7EEyJXPU2XBRUX0scMYHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144168; c=relaxed/simple;
	bh=OxsHJsEpBsBqQlUneKansVWA0qFRLyQcVMEAkQSy+BA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aq2WzydMaoYsJN41E3wv5cBSbuzub9hZ9gxZ9EwawnMN5kbAHZ3gqbXC3fAv9BIabDZYJ2RC3acbGEY7YTNceC9j9t8KrKCvEfsCeHgTM9WzZe4GnLzWyg4Ku2aIYRBb1h783rgExO/xk3TUz4IwPkF1fFLPCI21bvC96SvOqtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My4hZQWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3BAC116D0;
	Tue,  3 Feb 2026 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144168;
	bh=OxsHJsEpBsBqQlUneKansVWA0qFRLyQcVMEAkQSy+BA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=My4hZQWzWigVsq87B/njT2EeuXsfEkLhz8ve6e6k5Aj6UAt4SYayxbbl9bR70QkPD
	 bSNliKMF+GOSRCMVlvJ7fRZ+7zoMFz/bP/f9kgm2BGmslZ61y67V/p6Za+KRkHAzxG
	 kZSuYex6JyLfWofthCjR/ub7dtObMAisw3+9SCQgH0QWCPsgAI0EZrOApu5DXCsvUB
	 /A1VwXH7n6oqOKVA62LfynOvG15nd7cdDGKD/xgChal9C5S/sS4ZSkUMuW/2mgPtvB
	 Av37Juc6JflYkjMelnRI9yiliHBHUd1qO/sM4732WxkySibA3PLKjIk78k5UruzfIL
	 +Wetxr0lYWFtQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Feb 2026 19:41:24 +0100
Subject: [PATCH net-next 08/15] selftests: mptcp: diag: sort all #include
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260203-net-next-mptcp-misc-feat-6-20-v1-8-31ec8bfc56d1@kernel.org>
References: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
In-Reply-To: <20260203-net-next-mptcp-misc-feat-6-20-v1-0-31ec8bfc56d1@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OxsHJsEpBsBqQlUneKansVWA0qFRLyQcVMEAkQSy+BA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbHLt/h6d1Tjh0lLVC54P17P5Dv7WPX1doV9m7V4ql8
 4/nQ7bXHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNJOcPwz7Zg/s2Z+w41h1qf
 +2ygsj4wJSbe8P2MIKEf275FLpV62MbIsK2LcbvWo/dbgmc4b7qxwiuz8PO+SSGz2E52XeD9Kr9
 RlxsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256433-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: B8F9FDDDB7
X-Rspamd-Action: no action

This file is the only one from this directory not to have all these
header inclusions sorted by type and alphabetical order.

Adapt them, to ease the reading, prevent conflicts during potential
future backport modifying these lines, and also to avoid having UAPI
header inclusions before libc ones, see [1].

Link: https://lore.kernel.org/20260120-uapi-sockaddr-v2-1-63c319111cf6@linutronix.de
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 8e0b1b8d84b6..5e222ba977e4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -1,21 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025, Kylin Software */
 
-#include <linux/sock_diag.h>
-#include <linux/rtnetlink.h>
-#include <linux/inet_diag.h>
-#include <linux/netlink.h>
-#include <linux/compiler.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <linux/tcp.h>
-#include <arpa/inet.h>
-
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
 #include <errno.h>
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/socket.h>
+
+#include <arpa/inet.h>
+
+#include <netinet/in.h>
+
+#include <linux/compiler.h>
+#include <linux/inet_diag.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/sock_diag.h>
+#include <linux/tcp.h>
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262

-- 
2.51.0


