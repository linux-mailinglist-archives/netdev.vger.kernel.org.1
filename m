Return-Path: <netdev+bounces-261107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBPpIaiYn2mucwQAu9opvQ
	(envelope-from <netdev+bounces-261107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F219F9B7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD9B430518F4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74B336F43D;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gozgT/0I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6F36EAB1;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772066966; cv=none; b=tpUgAxrVn4Yex8vmWOFcejEFlIzMCcPjYCIT406L7+8m9CFQlw7AsHdKamguEAojFT4UQhUyzmqr9949X2KUVoZ651JcqQCQSl4Xqa4OhBKSinV4yRkOF/71KDFNPqvMVB7/36Q1sfW/OqBwxamj/N09QOmxmDVFEuOAC9wqMDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772066966; c=relaxed/simple;
	bh=jZffL8U2QVP5FJBgcvEGQCxmQSHTSiBnbGAz5Y5JC7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qoA+bNsacF/4X6STcIVm7iGFIaAvFaTyQehAFMFy+bX3K3QksL7iloXThmQ9oBgkHinqkB7XpiC0Cb1T9e4RUxwZ/wpL8eF6HNqaiBdyKCET8vXmnpOT/J0o/dgr+70izjEPfOAWzW+4V3HqRktaYVGBBRbPdbjFxkrgTuehTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gozgT/0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 671A3C2BCB6;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772066966;
	bh=jZffL8U2QVP5FJBgcvEGQCxmQSHTSiBnbGAz5Y5JC7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gozgT/0IOKSK7CWDxTBzw9L2GcXvVklh79bTFhLmrCyPzcgIAJrUyEyMy5sn34PNS
	 Z3Jtf9Yniq3m78xzszopxeAgnh6hMXWLD9rmDlwvboEvk555KqrMUIXXlvrS606AG0
	 HYbYX1wYMWmUeVqSjZIdx0VDjjomwd7PZWqCugFJ5iInQE87nEAqRWSYiogVyKLUJv
	 jUKnQBxqy/YwlP0qRQrtRlSL/VSzWz3EFk3zl0DcLuOpZpyUwO6ZCtkBvfiOy0dVYa
	 PYakRf9KmduWWOcswqEZsff/j/fl9QTgr9UCJzz5eqt1PUDbplvnuC00dkkiL7CW/b
	 HgYgrR6TmzFRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F883FD45FF;
	Thu, 26 Feb 2026 00:49:26 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Thu, 26 Feb 2026 01:49:10 +0100
Subject: [PATCH RFC net-next v2 4/5] selftests/net: packetdrill: add
 tcp_rcv_wnd_shrink_allowed.pkt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-4-aa3f8f9cc639@gmail.com>
References: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-0-aa3f8f9cc639@gmail.com>
In-Reply-To: <20260226-tcp_rfc7323_retract_wnd_rfc-v2-0-aa3f8f9cc639@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
 mfreemon@cloudflare.com, Shuah Khan <shuah@kernel.org>, 
 Stefano Brivio <sbrivio@redhat.com>
Cc: Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772066964; l=1916;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=MjsZPkGn8QBvDWJIOlx0ttylpFWaDY4F2mI8uGeZDj4=;
 b=YW4cf33OXLAcJwKNDwLdtBUt+Rhl4+Bnu31WmAA5B+E401wN8L3lhdkgqCGNc4YZWFdsBZA01
 9Cz/FplpjcRDdA8KeTgsmKYeCBbPkypbJbSEuuXFaB+go0b6rk930P6
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-261107-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[proxmox.com,vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F7F219F9B7
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

This test verifies the sequence number checks using the maximum
advertised window sequence number when net.ipv4.tcp_shrink_window
is enabled.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..e2c73e464954331f45c11b3152f2eddecc55f88b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+
+--mss=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_shrink_window=1
+sysctl -q net.ipv4.tcp_rmem="4096 32768 $((32*1024*1024))"`
+
+   0 `nstat -n`
+
+// Establish a connection.
+  +0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+  +0 bind(3, ..., ...) = 0
+  +0 listen(3, 1) = 0
+
+  +0 < S 0:0(0) win 32792 <mss 1000,nop,wscale 7>
+  +0 > S. 0:0(0) ack 1 <mss 1460,nop,wscale 10>
+  +0 < . 1:1(0) ack 1 win 257
+
+  +0 accept(3, ..., ...) = 4
+
+  +0 < P. 1:10001(10000) ack 1 win 257
+  * > .  1:1(0) ack 10001 win 15
+
+  +0 < P. 10001:11024(1023) ack 1 win 257
+  * > .  1:1(0) ack 11024 win 13
+
+// Max window seq advertised 10001 + 15*1024 = 25361, last advertised: 11024 + 13*1024 = 24336
+
+// Segment beyond the max window is dropped
+  +0 < P. 11024:25362(14338) ack 1 win 257
+  * > .  1:1(0) ack 11024 win 13
+
+// Segment using the max window is accepted
+  +0 < P. 11024:25361(14337) ack 1 win 257
+  * > .  1:1(0) ack 25361 win 0
+
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented once
+  +0 `nstat | grep TcpExtBeyondWindow | grep -q " 1 "`

-- 
2.53.0



