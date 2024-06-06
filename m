Return-Path: <netdev+bounces-101589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9558FF82A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 01:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96541F263F3
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BAC14A08E;
	Thu,  6 Jun 2024 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hablaiup"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0613E3FF;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716374; cv=none; b=g14kQYaSXg8z20JMq2w+TESbz9Z2yUYJ7iScgUqUfPOeJSL0B1t4TWJkkYooTPdXBqCBsXxpC/wuk+Ya1DEeI3iZqk55CM4eGMADfg7CUxRHhiwFHGpOKSL09muOb/HMBn+u7g1uHUjL1Srtp9gd3FkCJaqFY8QCMzIlbMaofHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716374; c=relaxed/simple;
	bh=RJxbRfrwSVRgqNfS+0yMIlRN2XvFthWU7xqbwkPAwrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOWhWITYDbnz+5bx1AlycosB8jcmJcWp8bHJMQXWompowaAz9eKH/Qw2AcIekxeI3ea2XVfCTKMpALa3b8It/w8lItSy9/JH6UG+bGRaA7i0gqvfF3c8agsUUg5cWi2JPSjH+PH4lq9LTplh1fful6vEq9kCq/ByApeHomWGtrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hablaiup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65A91C4AF49;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717716374;
	bh=RJxbRfrwSVRgqNfS+0yMIlRN2XvFthWU7xqbwkPAwrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hablaiup5tuFY/nHjVpPMK7XMWflfCfDT5LOp2auDxk/IsWIMpVrtxJKZ3j9b4cJd
	 Gd2k2Yl8CzyiF53jqxeUBxeRwuJbYYosXkacp5ZCsaM5eexSw4+zUGH9DurAIfsidQ
	 4MMJsiwqJe5DYl7HmcCEZyJfQkUfkU6lPkFBaxJTVejCc3o1fp4sO2isKBq7pc1rns
	 rSRKEUPVpt6jgFmHU4Uw1eB75UWDCIssjP/DT1ALOOV8GyJllbtg3yYt3Me1X1pGS4
	 xRifQ35nCguu2hrudLrf354z7Kb2oBYMPnbYEFAvwOje05ObSX2bBsDAjYa5od5USc
	 1XP2vxzpcJ+OQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5E1C27C52;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 07 Jun 2024 00:26:00 +0100
Subject: [PATCH net-next v4 6/6] Documentation/tcp-ao: Add a few lines on
 tracepoints
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-tcp_ao-tracepoints-v4-6-88dc245c1f39@gmail.com>
References: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
In-Reply-To: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717716372; l=1312;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=YTvLVmZiUq3+/gRlZqmFldpsbcd2Jw9oBAFB4f9XdXg=;
 b=yBoZ3XI+U9N6yjIg9OPIw3XAbfb8H+9R7O49RdavjZgRFul6opVKoRDnbgKXoKGQovgFtKxRwu+n
 /JokHbbvCr7fWvjB6R2vjraI3PWvVf5wugCuxEAWZ2bR5C3ZQDss
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



