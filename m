Return-Path: <netdev+bounces-265400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFsROiZ/rmlfFQIAu9opvQ
	(envelope-from <netdev+bounces-265400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:04:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A444F235448
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6892F302E86E
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0882236BCE1;
	Mon,  9 Mar 2026 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEv3G+sF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6B367F27;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043426; cv=none; b=mGVYlnS/VJe5vUyrejcV2V/MIwiNUMcTYYI16Oeg474ukcY/I5H1k6G2GIBbFxEN2Nnr3juo1xuxkf4Fn9Sna76Gk4ufaCBO5NeTGgQHU+yWWin4fN/Mn0+oWQNtvy3ETVZpmj0vSC8LeZhiWVijiJctmBU8WsPIEht+Bf9njyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043426; c=relaxed/simple;
	bh=SbrAJGk70EbIW4bgCwqcNeA0pD4BpRhVNFzp7yOtJi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7qoTZK87wWiQnaQvT35x5TMlnthCLIKpHWaO/FI1Hj6eQLV3pIgadzndZPyv/aO3ZgM5h4O/wtjxvhxDsHimAWORMGrrudnwjw1JkpdFjbzQ/4QsHVR/Q3YpZi+I71bfFBnCE6SOOcZmjmXD3sK4uMC9mFE/l70H0T6BV2eo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEv3G+sF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C288C2BCB0;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043426;
	bh=SbrAJGk70EbIW4bgCwqcNeA0pD4BpRhVNFzp7yOtJi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CEv3G+sFENvoUP3eYAHiYa0LR1jTIU2qbjakGQDpCVz2NKn6apDqroVnUAqLZn71F
	 zdJZ9NIyPb3NQ6gqbrs6LEWJWzvvVCuRcQYzdc+B4zb0UGh1yhUKVA/5xT6pQJI/ZJ
	 xkU/BGPGPO8X3BEKOCUHDi0cAdk5OrB2d+6FRz55li8q2ryDYeU1JJGFd/hYtj9tnc
	 ZgjvA2FYLDJA4B82oDopBk0RZLNpkGqLKhFRK37Pq1DVQQWUCz31wwchCbLUP+P7NV
	 IXd4gqSKIEtoLhUKF5A4NEe07DGeBRFaYrM2SqP60p7IKCCwHdyTIhYrhFzVuCg6fR
	 9FlP0+xg7V4QQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824F6EF3706;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Mon, 09 Mar 2026 09:02:29 +0100
Subject: [PATCH net-next v3 4/6] selftests/net: packetdrill: add
 tcp_rcv_wnd_shrink_nomem.pkt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-4-4c7f96b1ec69@gmail.com>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
 Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 mptcp@lists.linux.dev, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773043425; l=6675;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=N/81u3UphdzG27V80GBzm+l0tP/HFFOfJpFHiI1//LI=;
 b=O6x0ANLGhslVcC1+3RGJ5nFPK+fcPMRzB4O0ymz76PjW+o4CTIwgiCU1iTUE5+i24Jcz/9EJP
 t4n8hUyXVyuDPjjAlT9nSgVACT1jy1vPFra7fTpVnE0+xh2xq37MYQN
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Rspamd-Queue-Id: A444F235448
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-265400-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Simon Baatz <gmbnomis@gmail.com>

This test verifies
- the sequence number checks using the maximum advertised window
  sequence number and
- the logic for handling received data in tcp_data_queue()

for the cases:

1. The window is reduced to zero because of memory

2. The window grows again but still does not reach the originally
   advertised window

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt   | 132 +++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt
new file mode 100644
index 0000000000000000000000000000000000000000..69b060c548eac50f5dc5c034c90f0b8eae4b4fa6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_nomem.pkt
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+// When tcp_receive_window() < tcp_max_receive_window(), tcp_sequence() accepts
+// packets that would be dropped under normal conditions (i.e. tcp_receive_window()
+// equal to tcp_max_receive_window()).
+// Test that such packets are handled as expected for RWIN == 0 and for RWIN > 0.
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
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [1000000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792 <mss 1000,nop,nop,sackOK,nop,wscale 7>
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 4>
+   +0 < . 1:1(0) ack 1 win 257
+
+   +0 accept(3, ..., ...) = 4
+
+// Put 1040000 bytes into the receive buffer
+   +0 < P. 1:65001(65000) ack 1 win 257
+    * > .  1:1(0) ack 65001
+   +0 < P. 65001:130001(65000) ack 1 win 257
+    * > .  1:1(0) ack 130001
+   +0 < P. 130001:195001(65000) ack 1 win 257
+    * > .  1:1(0) ack 195001
+   +0 < P. 195001:260001(65000) ack 1 win 257
+    * > .  1:1(0) ack 260001
+   +0 < P. 260001:325001(65000) ack 1 win 257
+    * > .  1:1(0) ack 325001
+   +0 < P. 325001:390001(65000) ack 1 win 257
+    * > .  1:1(0) ack 390001
+   +0 < P. 390001:455001(65000) ack 1 win 257
+    * > .  1:1(0) ack 455001
+   +0 < P. 455001:520001(65000) ack 1 win 257
+    * > .  1:1(0) ack 520001
+   +0 < P. 520001:585001(65000) ack 1 win 257
+    * > .  1:1(0) ack 585001
+   +0 < P. 585001:650001(65000) ack 1 win 257
+    * > .  1:1(0) ack 650001
+   +0 < P. 650001:715001(65000) ack 1 win 257
+    * > .  1:1(0) ack 715001
+   +0 < P. 715001:780001(65000) ack 1 win 257
+    * > .  1:1(0) ack 780001
+   +0 < P. 780001:845001(65000) ack 1 win 257
+    * > .  1:1(0) ack 845001
+   +0 < P. 845001:910001(65000) ack 1 win 257
+    * > .  1:1(0) ack 910001
+   +0 < P. 910001:975001(65000) ack 1 win 257
+    * > .  1:1(0) ack 975001
+   +0 < P. 975001:1040001(65000) ack 1 win 257
+    * > .  1:1(0) ack 1040001
+
+// Trigger an extreme memory squeeze by shrinking SO_RCVBUF
+   +0 setsockopt(4, SOL_SOCKET, SO_RCVBUF, [16000], 4) = 0
+
+   +0 < P. 1040001:1105001(65000) ack 1 win 257
+    * > .  1:1(0) ack 1040001 win 0
+// Check LINUX_MIB_TCPRCVQDROP has been incremented
+   +0 `nstat -s | grep TcpExtTCPRcvQDrop| grep -q " 1 "`
+
+// RWIN == 0: rcv_wup = 1040001, rcv_wnd = 0, rcv_mwnd_seq > 1105001 (significantly larger, typically ~1970000)
+
+// Accept pure ack with seq in max adv. window
+   +0 write(4, ..., 1000) = 1000
+   +0 > P. 1:1001(1000) ack 1040001 win 0
+   +0 < .  1105001:1105001(0) ack 1001 win 257
+
+// In order segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_ZEROWINDOW)
+   +0 < P. 1040001:1041001(1000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0
+// Ooo partial segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_ZEROWINDOW)
+   +0 < P. 1039001:1041001(2000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0 <nop,nop,sack 1039001:1040001>
+// Check LINUX_MIB_TCPZEROWINDOWDROP has been incremented twice
+   +0 `nstat -s | grep TcpExtTCPZeroWindowDrop| grep -q " 2 "`
+
+// Ooo segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_OVERWINDOW)
+   +0 < P. 1105001:1106001(1000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0
+// Ooo segment, beyond max adv. window -> drop (SKB_DROP_REASON_TCP_INVALID_SEQUENCE)
+   +0 < P. 2000001:2001001(1000) ack 1001 win 257
+   +0 > .  1001:1001(0) ack 1040001 win 0
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented twice
+   +0 `nstat -s | grep TcpExtBeyondWindow | grep -q " 2 "`
+
+// Read all data
+   +0 read(4, ..., 2000000) = 1040000
+    * > .  1001:1001(0) ack 1040001
+
+// RWIN > 0: rcv_wup = 1040001, 0 < rcv_wnd < 32000, rcv_mwnd_seq > 1105001 (significantly larger, typically ~1970000)
+
+// Accept pure ack with seq in max adv. window, beyond adv. window
+   +0 write(4, ..., 1000) = 1000
+   +0 > P.  1001:2001(1000) ack 1040001
+   +0 < . 1105001:1105001(0) ack 2001 win 257
+
+// In order segment, in max adv. window, in adv. window -> accept
+// Note: This also ensures that we cannot hit the empty queue exception in tcp_sequence() in the following tests
+   +0 < P. 1040001:1041001(1000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1041001
+
+// Ooo partial segment, in adv. window -> accept
+   +0 < P. 1040001:1042001(2000) ack 2001 win 257
+   +0 > .  2001:2001(0) ack 1042001 <nop,nop,sack 1040001:1041001>
+
+// Ooo segment, in max adv. window, beyond adv. window -> drop (SKB_DROP_REASON_TCP_OVERWINDOW)
+   +0 < P. 1105001:1106001(1000) ack 2001 win 257
+   +0 > .  2001:2001(0) ack 1042001
+// Ooo segment, beyond max adv. window, beyond adv. window -> drop (SKB_DROP_REASON_TCP_INVALID_SEQUENCE)
+   +0 < P. 2000001:2001001(1000) ack 2001 win 257
+   +0 > .  2001:2001(0) ack 1042001
+// Check LINUX_MIB_BEYOND_WINDOW has been incremented twice
+   +0 `nstat -s | grep TcpExtBeyondWindow | grep -q " 4 "`
+
+// We are allowed to go beyond the window and buffer with one packet
+   +0 < P. 1042001:1062001(20000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1062001
+   +0 < P. 1062001:1082001(20000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1082001 win 0
+
+// But not more: In order segment, in max adv. window -> drop (SKB_DROP_REASON_TCP_ZEROWINDOW) 
+   +0 < P. 1082001:1083001(1000) ack 2001 win 257
+    * > .  2001:2001(0) ack 1082001
+// Check LINUX_MIB_TCPZEROWINDOWDROP has been incremented again
+   +0 `nstat -s | grep TcpExtTCPZeroWindowDrop| grep -q " 3 "`

-- 
2.53.0



