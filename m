Return-Path: <netdev+bounces-256378-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R1gKKdsvgml5QQMAu9opvQ
	(envelope-from <netdev+bounces-256378-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:26:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA19DCC4C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 18:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B138F302F25B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4933191B0;
	Tue,  3 Feb 2026 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tokaXIh4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D331197A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139598; cv=none; b=ZflSfv1DgmBSF3as1aIKq3jgj9sktPNK/xvbE3xT9qgiaf+9C1VRnIqpyLrueZvJ9T5aS0YLAztzlnDsuAvFv1fU79Qz1m62KMi68cSqgc7LYX8GvUAwxrZTa9w6nPiA7P+5ibvM6EFxzut+6Q4ZBxnGwVWfX9sjyoCIBed2bHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139598; c=relaxed/simple;
	bh=IrL/IsVyXY+jd6coKppEwCofIGbOeIgNfDbnpYMc+nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQ7dr7uTMBN7ZQEJG0CvDMvBw6Of0hRyHu9U+NpW8Q3eMiuE7Q5qc6pza5b8ehnJFtNjRlBK1Th2AWVnGW0SAtGnoF7DNpklxhcaBHptrmwSthkpHv2RCE4CDWdp7TrMb8gwfbLkcMIBdoK+XEHzuUYHMadrXCuDp4fyLijbwJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tokaXIh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ADBC2BCB0;
	Tue,  3 Feb 2026 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770139597;
	bh=IrL/IsVyXY+jd6coKppEwCofIGbOeIgNfDbnpYMc+nI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tokaXIh4mJkA9A2wps2JGC+JN60csYa3I3gEtqsdA4igNrobzu220Kv4l3jn1cIrF
	 N6EJgTmMQ0J3RW7V1I3HYSDuaVjCSHqwrPA8ua0+D90iBlNEWtnVQACWf24cSI9/y1
	 PReyVptyB8rmbpL4JAHfN5vFCEMUDqGl6wKj8E2U+K19rt/gVBRL9SV2KG3vIGtApI
	 Ap0Een9gsjEJM2byCklZzAG4J7zQ4GOouq6gJFotYJRSI2Uz9vMXKPOUSyU6CSJBKb
	 wPSkmjiZOYlBlxqTkmNKCpWX1WUubgV5sZC5OOuD5fS5Cz2gUEuUukXil6E1vVjekr
	 wna7I7EC9Vrhw==
Date: Tue, 3 Feb 2026 09:26:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/3] tcp: make tcp_v{4,6}_send_check() static
Message-ID: <20260203092636.20c6bb6e@kernel.org>
In-Reply-To: <20260203144053.83193-4-edumazet@google.com>
References: <20260203144053.83193-1-edumazet@google.com>
	<20260203144053.83193-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-256378-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3AA19DCC4C
X-Rspamd-Action: no action

On Tue,  3 Feb 2026 14:40:53 +0000 Eric Dumazet wrote:
> tcp_v{4,6}_send_check() are only called from tcp_output.c
> and should be made static so that the compiler does not need
> to put an out of line copy of them.
> 
> Remove (struct inet_connection_sock_af_ops) send_check field
> and use instead @net_header_len.
> 
> Move @net_header_len close to @queue_xmit for data locality
> as both are used in TCP tx fast path.

Seeing this in allmodconfig:

net/ipv4/tcp_output.c:1482:13: warning: unused function 'tcp_v4_send_check' [-Wunused-function]
 1482 | static void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
      |             ^~~~~~~~~~~~~~~~~
-- 
pw-bot: cr

