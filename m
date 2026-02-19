Return-Path: <netdev+bounces-259612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOI8FR2jl2mh3wIAu9opvQ
	(envelope-from <netdev+bounces-259612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:56:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68667163B49
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E79030093B5
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 23:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C7432AAC5;
	Thu, 19 Feb 2026 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbuwRhxE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12412ED17B;
	Thu, 19 Feb 2026 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545364; cv=none; b=P1Yu+LgnkEk8/jtJj/PPA7zL7YiSp6wUluRJoHofr7p8UR+9MMsttYjmHUXW0o9HrI61ONiMa3P1fwuYVA5EYb5VVhQszDUTtmZc/YxbR0PtwWUyW7093HYeyZ8xCuUgir/o/vAxSujQB4Nneog4Eq74J9MhNsr7y/SR0ctGH8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545364; c=relaxed/simple;
	bh=C4gSVFnYg5++CFNc34hzfGOq8P8bBYXRheFgxrJCKsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GjI4jztQCFI3fV6u84/3NJ0OgbhRBU6pHkxFJ1uuIX1L0VM8vD2EPBTgoaEa4BFsG4+2QGz4M1eEN5Dcph9RV7YTsX/onDo3sk9I679wj/VSaTdvwiFkMZys5EczbC6Ylr2gmeB26lyOku/j1inx8TyNlcnjeXsLjlV3Iyk2hmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbuwRhxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 929F8C2BC86;
	Thu, 19 Feb 2026 23:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771545364;
	bh=C4gSVFnYg5++CFNc34hzfGOq8P8bBYXRheFgxrJCKsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KbuwRhxEPLSExomQIgfpQ8xJKFRyuQyQ7up4wyojd1kh05CHFGNqWuS+nbw4p4QcF
	 Yz3D9np1pfQfLBOLuL5eNm/TcU4Yy9918g2Ppt68FNixNWCizXc8jgsvofrXOa0jbe
	 WLotBWOt9hWaQnGw7RqsIaND8R8jb63Kc+HOW5ccV8X6uwvjvSBbkucBiGMe6Ou1oQ
	 65O0BCnSyBGQTzWO6Y9oBoRFQ3Ye5UhCtOSCrUiU40V2bahoIWrfwtvpw8IjvYarg5
	 DU4nETjfYI2YKD1mFGRPsX0YXTq4YrqvIJ7OnY0j4hWQWJKuSGsWcYRdC8Kz4XEAPm
	 0yr3emla62yTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8558EC531F5;
	Thu, 19 Feb 2026 23:56:04 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Fri, 20 Feb 2026 00:55:16 +0100
Subject: [PATCH RFC net-next 3/4] selftests/net: packetdrill: add
 tcp_rcv_wnd_shrink_allowed.pkt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-3-904942561479@gmail.com>
References: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
In-Reply-To: <20260220-tcp_rfc7323_retract_wnd_rfc-v1-0-904942561479@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, 
 mfreemon@cloudflare.com, Shuah Khan <shuah@kernel.org>
Cc: Christian Ebner <c.ebner@proxmox.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771545363; l=1786;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=oKm7bY6qUSKUrF1CxDw0iF2RGU/iw3vtuznU1zR8gNE=;
 b=fcYQsswm3knIaJZc2daU7EEc8LAuzEvzroYXAnuQr+pIsLl24xJxGnRemX7cvbpaExaB8InVR
 Tc/wCCg2TdCArN8VRwmT6iis0cfW4dkRbpkr4atEewVnUnCUn3KU7G/
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259612-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[proxmox.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com]
X-Rspamd-Queue-Id: 68667163B49
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

This test verifies the sequence number checks using the maximum
advertised window sequence number when net.ipv4.tcp_shrink_window
is enabled.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..8f9b689d3f6d49c3bbc26cca8e408b905af129cb
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed.pkt
@@ -0,0 +1,35 @@
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
+// Segment using the max window is accepted
+  +0 < P. 11024:25361(14337) ack 1 win 257
+  * > .  1:1(0) ack 25361 win 0
+
+// Check LINUX_MIB_BEYOND_WINDOW has not been incremented
+  +0 `nstat -z | grep TcpExtBeyondWindow | grep -q " 0 "`

-- 
2.52.0



