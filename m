Return-Path: <netdev+bounces-276722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLjoCy3O1mnAIggAu9opvQ
	(envelope-from <netdev+bounces-276722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:52:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A313C437E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28B373098B19
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FCA3A5E68;
	Wed,  8 Apr 2026 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFVDdCXu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55638839C;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775685042; cv=none; b=THms7K8V+o+Zd4v8ptNzly+2KbJ7afj9ICqT/bZxFRwpJddABOXC+tPW++6VRz5JY1gtH+/TKcKdXJgQChNL036L8eYudHxArLFtp1PDRbOyayOV90XgtklGQfcIUvu6SdWzK79PDsOqC34ROFgo1KokY2LGeoivBjhZOa/k7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775685042; c=relaxed/simple;
	bh=hRk7AedOBquVMuQbZKSP0j2rlUDei3LqUvzOUZS0iys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtucKP/ZF7ZsRwCOhz6CNPT2wQ89rJviBvtT3daGrd6ghmoUuPQMlz2VqX76j96Dn5XcTxXlgFyxzWtTLLSJNDv42dpFkL/ZhQHeKfETc6MkLT70PDJIOaQwftkttnGJUo2ZI5FAncvTdQtqatpRvcp85+cEpDGR4+hyxel3AMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFVDdCXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44C00C4AF0F;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775685042;
	bh=hRk7AedOBquVMuQbZKSP0j2rlUDei3LqUvzOUZS0iys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rFVDdCXuI9c3J7oE9ptfIdRKZSbLmhurunKU/j45chFd74NU3ebN0+kebY1TOOT2o
	 c4tvdeU7gEoEKBk27etB6YRZ230J38wQKV8h76Y2oykJYw1pyNPpsl7M2yk3veKrj6
	 Ka73ZovCq+YjBTcXbpozno21jUasEuZSofzywoiN+ItPO0aNaFwtpS9Ue0+s5VHzru
	 EDwQsZ/ayZwibzkoE12GAMTYliFK5+H+x1BOgn47lbsTvgvxxbM4AawzJUUjQPAHDY
	 LfsYD6bzDqKDQSY8ftMrpQN0CWjjezL1O22lf9NvZRw43UsXrPEJGQFNzfbN6fwXAw
	 DbrUKOxSZEQtQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398AF10FC44E;
	Wed,  8 Apr 2026 21:50:42 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Wed, 08 Apr 2026 23:50:05 +0200
Subject: [PATCH net-next 4/7] selftests/net: packetdrill: add
 tcp_rcv_wnd_snd_ack_no_scaling.pkt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-4-76a6f212e153@gmail.com>
References: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
In-Reply-To: <20260408-tcp_rcv_exact_clamp_and_wnd-v1-0-76a6f212e153@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775685040; l=2164;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=3UD78GSmL8ZM19AY/0d9FZwB1822EnTOwXfy0idIPhY=;
 b=63aS0f7Hf24M3Z/9aXF1uyxaeIDIWMqQkDKXmH8Hxy4rrkgc1FEZ7MtW3FgIkJvPfqK0z/qfd
 u97GMpuJIHPDF0MiaLdaaSjz5tHe8Pgvs16YbUeZWernVMwjfqY+hly
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276722-lists,netdev=lfdr.de,gmbnomis.gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[gmbnomis@gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87A313C437E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Simon Baatz <gmbnomis@gmail.com>

Verify that, when no TCP window scaling is used, each packet that
substantially advances the right edge of the receive window is ACKed
immediately.

Multiple packets are used so that the scaling_ratio receive window
adaptation can settle and does not by itself cause immediate ACKs,
avoiding false positives.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../packetdrill/tcp_rcv_wnd_snd_ack_no_scaling.pkt | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_snd_ack_no_scaling.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_snd_ack_no_scaling.pkt
new file mode 100644
index 0000000000000..41561b026da85
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_snd_ack_no_scaling.pkt
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Every packet must be ACKed immediately if the right edge of receive window
+// advances substantially. This test verifies that behavior when the connection
+// does not use window scaling.
+--mss=1000
+
+`./defaults.sh`
+
+// Initialize connection
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [256000], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:0(0) win 32792
+   +0 > S. 0:0(0) ack 1 win 65535 <mss 1460>
+   +0 < . 1:1(0) ack 1 win 32792
+
+   +0 accept(3, ..., ...) = 4
+
+   +0 < P. 1:65001(65000) ack 1 win 32792
+   +0 > . 1:1(0) ack 65001 win 65535
+   +0 < P. 65001:130001(65000) ack 1 win 32792
+   +0 > . 1:1(0) ack 130001 win 65535
+   +0 < P. 130001:195001(65000) ack 1 win 32792
+   +0 > . 1:1(0) ack 195001 win 65535
+   +0 < P. 195001:260001(65000) ack 1 win 32792
+   +0 > . 1:1(0) ack 260001 win 65535
+   +0 < P. 260001:325001(65000) ack 1 win 32792
+   +0 > . 1:1(0) ack 325001 win 65535
+
+// reading all data does not open the window further -> no ACK
+   +0 read(4, ..., 325000) = 325000
+ +0.2 < P. 325001:390001(65000) ack 1 win 32792
+   +0 > . 1:1(0) ack 390001 win 65535

-- 
2.53.0



