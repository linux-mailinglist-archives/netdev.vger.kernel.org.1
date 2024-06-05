Return-Path: <netdev+bounces-100810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFC98FC1BA
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6713C282F7B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EB113A248;
	Wed,  5 Jun 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCeOoo/E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979F61FEC;
	Wed,  5 Jun 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554032; cv=none; b=JCrzu86onUukqhUC77e3GP3jvxS18iHKy1Yt91ggar+dA72se3drfKQ4sUOOw6cl0avYM65PgM+MJRgOntwljeUGEDxrGe6qG0cxNprU0BmVW7U/57a6ZGN9Z49Km1m2q5axQMy44gQTYg/cmZb7qZuGgZdEFiCrI/vyQVZ1zkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554032; c=relaxed/simple;
	bh=RJxbRfrwSVRgqNfS+0yMIlRN2XvFthWU7xqbwkPAwrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAgEfmhon2YKNxxAp3VukYzWNDK/H3G2LvLrCoR0RRI2Duz7MZFglHxK25KNJqgrKlo8W5LLb9DiNGjsHRdN4nLpul5oktF8oe78DIJ7Bq0i9D/6bls34TPrYhyxDJup5nY7zztOcrz6ZutcNTJPCxYAF1LjaK1pQnbGXGJMOd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCeOoo/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE1F0C4AF49;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717554032;
	bh=RJxbRfrwSVRgqNfS+0yMIlRN2XvFthWU7xqbwkPAwrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mCeOoo/EC6kwpsdT9kN/H6mgXQnj7UUHDkbkYKCyTH/vqtIJUft2iHe/nmUmY5cV9
	 RdwVV28jPohhE1q51YkSl9o3J5/WgGeDZY+8IFCeQixf+n1LLTTlUTWzmKzlQBt+I0
	 FRwr4GS88yU6Z4nYDljMYaSD/2BHZEODlYboSAwvjqStBJOcdH0iUMiXCXeZzM7PYe
	 IN8+F9DBCAgpMkNre8xoj2gIm+zqr9ku7r4XeTGRr4kGDrwntrdE2Ayypj2I9WZ2kf
	 aQDA5qleF3/NEOImH7LqFZb0MLhQ3Zok/b0R0fb/QwVOw2ICaYuCFJg7mdGfPELjje
	 Xx1qmfNKt7Pmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E94C27C55;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 05 Jun 2024 03:20:07 +0100
Subject: [PATCH net-next v2 6/6] Documentation/tcp-ao: Add a few lines on
 tracepoints
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-tcp_ao-tracepoints-v2-6-e91e161282ef@gmail.com>
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717554029; l=1312;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=YTvLVmZiUq3+/gRlZqmFldpsbcd2Jw9oBAFB4f9XdXg=;
 b=RsSaCGXsj/jPHoR99Jtp1W5cn2z9hTlKuGseFZRWBrjpDHbnkYvmAQoTdQ2gab432wl0lJZpXbKq
 3bSuBg/UAW6PgkFv7AsJgMTpHAzCkqnU6C12t8cCkJU8XnmmkoHp
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



