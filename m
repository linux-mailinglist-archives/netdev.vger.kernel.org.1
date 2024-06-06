Return-Path: <netdev+bounces-101207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E38FDBD0
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA221F247DD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31201DFF5;
	Thu,  6 Jun 2024 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJil99qE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB151119A;
	Thu,  6 Jun 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635511; cv=none; b=olyP1nYDl3lj4t4KR3eVYQm/nVjNsO0G8WjIIi+XCPJyi4LRwPA7BH2IrVk4r3wgO80Om53N/7QLLGE/U0bhGJQ8xFmhsfKIMTFcD1pgeeU+n6d9Fe96hmw+jUIZGwP/KZ95w7uSrNPlL8JLoBVasfzDRCoNtCSVnABRm0dUAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635511; c=relaxed/simple;
	bh=RJxbRfrwSVRgqNfS+0yMIlRN2XvFthWU7xqbwkPAwrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSeF0k1EYmnjd6x5PlZ9fJjBPAnSrNlzJGk8mc6S5sGmRTJlpdlR79+fijqfUTT0LRcaTMRDpA49NyR/xbyd1mkyY8b6mxoYpy/Pw219PuskKRasGTHcg+OY/BQIxBanmpvhA8nKKVcvfza5lo9GexylqGY3Kq4iYv+nRkNW0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJil99qE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE884C4AF17;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717635511;
	bh=RJxbRfrwSVRgqNfS+0yMIlRN2XvFthWU7xqbwkPAwrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mJil99qEScGbOydj4pAbYDB9P2e10ZgBPSjwz2+zZzp1vGvFd07vlQLMc93097yLP
	 nLw4twQnpga1Ov495xVrlL1YbZxZcRggzx0pMfubbeDDcuA+wSEC58NNEe7Ueqr7uf
	 9WbRFRGIly+DWPKv16jlkEpy6q0khZ7j5XguAHVrFBcM21qv6H6DxTiDmzdLqAMnsK
	 m6vTNuMhsrAXCdIySOXBwr5SXFTDW1h5xxDLbxMTFIjVq/KSmSXdnAbA6Hi2/GA8L2
	 kTjp7hdRV2VpUJs/SgEa88jMFrDIvdh2ihCH3Vy3/w9q2M2V37a7ELEiw8uiait20n
	 8UQVzug9Lp+Qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1187C27C53;
	Thu,  6 Jun 2024 00:58:30 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 06 Jun 2024 01:58:23 +0100
Subject: [PATCH net-next v3 6/6] Documentation/tcp-ao: Add a few lines on
 tracepoints
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-tcp_ao-tracepoints-v3-6-13621988c09f@gmail.com>
References: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com>
In-Reply-To: <20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717635508; l=1312;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=YTvLVmZiUq3+/gRlZqmFldpsbcd2Jw9oBAFB4f9XdXg=;
 b=spAE96jwHq10U5eIzCVaOaXRNUwYiydfcrtFMVOVm6V4AiROo4dFYanfAII8rodHFLA5CeInBo6b
 nPCW4jnmCOANbWV48zCP0lwAckHfHAnnkz3PYjaq/2lfyEcKtCpf
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 Documentation/networking/tcp_ao.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/networking/tcp_ao.rst b/Documentation/networking/tcp_ao.rst
index 8a58321acce7..e96e62d1dab3 100644
--- a/Documentation/networking/tcp_ao.rst
+++ b/Documentation/networking/tcp_ao.rst
@@ -337,6 +337,15 @@ TCP-AO per-socket counters are also duplicated with per-netns counters,
 exposed with SNMP. Those are ``TCPAOGood``, ``TCPAOBad``, ``TCPAOKeyNotFound``,
 ``TCPAORequired`` and ``TCPAODroppedIcmps``.
 
+For monitoring purposes, there are following TCP-AO trace events:
+``tcp_hash_bad_header``, ``tcp_hash_ao_required``, ``tcp_ao_handshake_failure``,
+``tcp_ao_wrong_maclen``, ``tcp_ao_wrong_maclen``, ``tcp_ao_key_not_found``,
+``tcp_ao_rnext_request``, ``tcp_ao_synack_no_key``, ``tcp_ao_snd_sne_update``,
+``tcp_ao_rcv_sne_update``. It's possible to separately enable any of them and
+one can filter them by net-namespace, 4-tuple, family, L3 index, and TCP header
+flags. If a segment has a TCP-AO header, the filters may also include
+keyid, rnext, and maclen. SNE updates include the rolled-over numbers.
+
 RFC 5925 very permissively specifies how TCP port matching can be done for
 MKTs::
 

-- 
2.42.0



