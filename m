Return-Path: <netdev+bounces-262380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ1zBcr7o2lPTgUAu9opvQ
	(envelope-from <netdev+bounces-262380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 09:41:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B0E1CEE23
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 09:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E265F3018D57
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F68296BCD;
	Sun,  1 Mar 2026 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdjJ3l8Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA9A932;
	Sun,  1 Mar 2026 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772354503; cv=none; b=ZS/F8bffZElABzeB2AnDzuZoTt3hwmXp/xpNSmOQK+7ExGeCJbtK9SbFLJ5rZGM1LkR8Xxa9ooYXYpPKfS/ucgjc6rRrod+cdrcWhdDOUkLs8OG9pkWlSeWNJ7tQyLkniV6jtH9VMjsTxazXZAAPXWy7zX5P/UrXwUhgjQiDIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772354503; c=relaxed/simple;
	bh=lCipjIFtZ7gKyzq5btTB15yO0keo4NhyPRosOJ2MUIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m+7s1dCXivdWwyJC0fFcuIRsZq1ogLdGyA6PbHCmYP1fjWBfLyJvtI71TDNnaYmALmZYoNb62w41rkFWLzBstmPNM/2gfMtoqxsfp/B4BOBP9+ZB6Tv1fGrXswaMlDoBZPauTxkvokX7RwEOFqQn8Hvvofm08WUT6kUbh4e4HmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdjJ3l8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94AF8C116C6;
	Sun,  1 Mar 2026 08:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772354502;
	bh=lCipjIFtZ7gKyzq5btTB15yO0keo4NhyPRosOJ2MUIQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fdjJ3l8YzX7SQ6atzcxngUN3M93TwVYTJIEYOyVXFRPKDU6Pee1OaKx/kYUtxHuyo
	 d6/18pUY5CMR7VLMPdZ0Z2jWXZNJ6bsPN+cy7nNDedV6lloOv4xT17yUEbmzc7gqN2
	 WPfVBGfyfyV1dTveq+vv6RYgJYC/3KKQW66PqH0n/NzHw5JGTzhfIDtZ+Rbs2uCxZb
	 eiz65KwamZ+9gmE4PfYPKAxvtlAV1uGam/l6CwUwog5MjgMjZQUkTa7E2LYpk2k8X9
	 VrzgguYnBjl006UCiIbjBgWoKUQUvsShsLBC7eLAD1QUc82c63ol3DOkUuQT+1HNoO
	 R6JD/MNP6RyoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFCDFD0040;
	Sun,  1 Mar 2026 08:41:42 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Sun, 01 Mar 2026 09:41:33 +0100
Subject: [PATCH] selftests/net: packetdrill: restore tcp_rcv_big_endseq.pkt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-tcp_rcv_big_endseq-v1-1-86ab7415ab58@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avIrBNSor+rRIjpaLMx05AgunvS8
 lu890DGRJhhZg8kLJTpCBWiYWB2HTxystUgW9m3Uo78MlElU9RGXmGwGU9uRidwmESnBws1jAk
 d3f90Wd/3AzlIkn9kAAAA
X-Change-ID: 20260228-tcp_rcv_big_endseq-c8f1e7914a7d
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772354501; l=2571;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=y5Qga6QOLux9usDOxXwZ0c1UWnBSsfdcWFsVJAvrhHI=;
 b=o5FudX9jHGh+XH4xjuB9TRyfPib3PPUV14pl2IJlNizXNWR68+AE0ZA5cQNh2KDpZiUPNUAj7
 hISaYNu4DUhDqv4NtAg/77TOI+mb7VHW+0Ra/aVGtPHIWTTmk3GALw2
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262380-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64B0E1CEE23
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

Commit 1cc93c48b5d7 ("selftests/net: packetdrill: remove tests for
tcp_rcv_*big") removed the test for the reverted commit 1d2fbaad7cd8
("tcp: stronger sk_rcvbuf checks") but also the one for commit
9ca48d616ed7 ("tcp: do not accept packets beyond window").

Restore the test with the necessary adaptation: expect a delayed ACK
instead of an immediate one, since tcp_can_ingest() does not fail
anymore for the last data packet.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../net/packetdrill/tcp_rcv_big_endseq.pkt         | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..6c0f32c40f19be2a750fc9d69bbf64250cd7b525
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_big_endseq.pkt
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh`
+
+    0 `nstat -n`
+
+// Establish a connection.
+   +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [10000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 0>
+  +.1 < . 1:1(0) ack 1 win 257
+
+  +0 accept(3, ..., ...) = 4
+
+  +0 < P. 1:4001(4000) ack 1 win 257
+  +0 > .  1:1(0) ack 4001 win 5000
+
+// packet in sequence : SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE / LINUX_MIB_BEYOND_WINDOW
+  +0 < P. 4001:54001(50000) ack 1 win 257
+  +0 > .  1:1(0) ack 4001 win 5000
+
+// ooo packet. : SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE / LINUX_MIB_BEYOND_WINDOW
+  +1 < P. 5001:55001(50000) ack 1 win 257
+  +0 > .  1:1(0) ack 4001 win 5000
+
+// SKB_DROP_REASON_TCP_INVALID_SEQUENCE / LINUX_MIB_BEYOND_WINDOW
+  +0 < P. 70001:80001(10000) ack 1 win 257
+  +0 > .  1:1(0) ack 4001 win 5000
+
+  +0 read(4, ..., 100000) = 4000
+
+// If queue is empty, accept a packet even if its end_seq is above wup + rcv_wnd
+  +0 < P. 4001:54001(50000) ack 1 win 257
+   * > .  1:1(0) ack 54001 win 0
+
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented 3 times.
++0 `nstat | grep TcpExtBeyondWindow | grep -q " 3 "`

---
base-commit: 9439a661c2e80485406ce2c90b107ca17858382d
change-id: 20260228-tcp_rcv_big_endseq-c8f1e7914a7d

Best regards,
-- 
Simon Baatz <gmbnomis@gmail.com>



