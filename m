Return-Path: <netdev+bounces-268254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ9+NmJSuGmKcAEAu9opvQ
	(envelope-from <netdev+bounces-268254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:56:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6115929F5F1
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2AB33039300
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D6A3E5EFC;
	Mon, 16 Mar 2026 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI9OwbAr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703053DB627;
	Mon, 16 Mar 2026 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687086; cv=none; b=YmsSDPBcJEIr1uXMFqpWBwEjOL0V/ku2qDkc7iE0jbIU2moG6oP5qekM378sA6ujnDJe8IIK/jKZF87E8Mg4zTvVnEG5WYl+P2olMazrt10r5Dd1TpIVhZtQQP+sIYvkfQQ4bNJXxHpY2HmtzccH5TylW46tEsGGbdngdGGc7Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687086; c=relaxed/simple;
	bh=c5BLHuGtkY+WxXe6JvvfcNckrVRMkknyPNj8lzgWAGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IAAzVioqjhOqWVazLmgUEV9s+jmbtcgaLoCU6qiX+Nwk2Wrisi2cc8v3y8plHfSn4e0sm23GwXvKKRM6FbuCVMcmsi2apmd6O0rI7kBYR4/335kCuiBsIjiKs6N2LaPyvfV4bGqWttqfD0D+2R4HZYoTbIGI7YW5cPAuCXukrgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI9OwbAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 122A7C19421;
	Mon, 16 Mar 2026 18:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773687086;
	bh=c5BLHuGtkY+WxXe6JvvfcNckrVRMkknyPNj8lzgWAGA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=TI9OwbAreyKJpxRuEvgrPZSlxbkvbS3zpQMBLErdVOEHD8TWXPhbo0t96YGso2gCF
	 zum9L1rdWr1k9XWY+eTu2LriBGySqk2YAfgNk94ejcBRM21mBBO58PfsHHt2XwKgcq
	 ecRvTpui7tgQiy0daUGqiYc7cS5EJi8sYlJYAqz7m8044Z86tuKNHtfAQDgrDka2Ma
	 /9qwMdBfTXSK0k4SRss3toaFySzx547ix/livfiscNQ0uGx9N8vQGhlMm2E3+GD9Vo
	 9bZmMKZUF2ktVE3g02F21tthRZwiEs1gyMM/7a8aiDvr4RtN5xOKGN0wPXHb42rrxc
	 +rVx6Uj6qqshA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026DAF53D8B;
	Mon, 16 Mar 2026 18:51:26 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Mon, 16 Mar 2026 19:51:10 +0100
Subject: [PATCH net-next] selftests/net: packetdrill: improve
 tcp_rcv_neg_window.pkt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-improve_tcp_neg_usable_wnd_test-v1-1-f16d5e365107@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQrCMBBG4auUWRtoUivoVUSGmPzWAZ2GJNZC6
 d0NLr/NexsVZEGhS7dRxiJFZm2wh47C0+sEI7GZXO9O/WBHI++U5wVcQ2LFxJ/i7y/wVyNXlGq
 ct4M7x2PwdqRWSRkPWf+HKymqUayVbvv+AxTGEoB7AAAA
X-Change-ID: 20260315-improve_tcp_neg_usable_wnd_test-2a1329d4ca15
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773687085; l=2076;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=ns9OJwOj9IGXzUoNWp91AiRCpz66QceoQnlEDdYlvAg=;
 b=aGLkhiswPMUPyKJ30KormGEXHe9rlLCtTcgK3UyAcW1S57f5CBIuxVzZENkkCoVI0stE9jFtS
 15RLqZ4BcOvBtElun7+2vJzfo+ZGtH9lmc+5i+iqgra7IWtpM6KQ5yN
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268254-lists,netdev=lfdr.de,gmbnomis.gmail.com];
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
	NEURAL_HAM(-0.00)[-0.929];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6115929F5F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Simon Baatz <gmbnomis@gmail.com>

The test depends on accepting a packet that is larger than the
advertised window and that does not trigger an immediate ACK.

Previously, the test might still pass even if kernel behavior changed
unexpectedly. Add assertions verifying that the large packet was
accepted and no ACK was sent.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 .../selftests/net/packetdrill/tcp_rcv_neg_window.pkt       | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
index 15a9b4938f16d175ac54f3fd192ed2b59b0a4399..b9ab264b2a118f273af269d83a371740ae47359c 100644
--- a/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
+++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window.pkt
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+// Test maximum advertised window limit when rcv_nxt advances past
+// rcv_mwnd_seq. The "usable window" must be properly clamped to zero
+// rather than becoming negative.
 
 --mss=1000
 
@@ -17,10 +20,15 @@
 
    +0 accept(3, ..., ...) = 4
 
-// A too big packet is accepted if the receive queue is empty
+// A too big packet is accepted if the receive queue is empty. It
+// does not trigger an immediate ACK.
    +0 < P. 1:20001(20000) ack 1 win 257
+   +0 %{ assert tcpi_bytes_received == 20000, tcpi_bytes_received; }%
+
 // Send a RST immediately so that there is no rcv_wup/rcv_mwnd_seq update yet
    +0 < R. 20001:20001(0) ack 1 win 257
 
-  +.1 %{ assert tcpi_state == TCP_CLOSE, tcpi_state }%
-
+// Verify that the RST was accepted. Indirectly this also verifies that no
+// immediate ACK was sent for the data packet above.
+   +0 < . 20001:20001(0) ack 1 win 257
+   +0 > R 1:1(0)

---
base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
change-id: 20260315-improve_tcp_neg_usable_wnd_test-2a1329d4ca15

Best regards,
-- 
Simon Baatz <gmbnomis@gmail.com>



