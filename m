Return-Path: <netdev+bounces-263040-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIzWBtFnpmljPQAAu9opvQ
	(envelope-from <netdev+bounces-263040-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:47:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1031E90A7
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60D25304D14B
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EDC36EAAB;
	Tue,  3 Mar 2026 04:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3lNlvcS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AFF3603D4
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513222; cv=none; b=Dlim/2YEfLd7NNt/SrBTCLSzqtGiBHzm44HxKJqVcsWOqyGYoBhlJJgOpTnpWkMtdoETfDA16COMDEo1tP6HuQpYoxGXfkd99EypqOdf9RDsorfns3yZXETrpvVI2Rhk6XL5h+Pc4RzclA9/dCcG2/6qnJSsUCJe+npb+Ddosjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513222; c=relaxed/simple;
	bh=vj+3M3PLxjwcWXquns4pXjUbSAndqJWRP+3XCK2AL4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZzbXTGC7A9YLoDr1dwk3gdfCX/FUHa1JY34keYldjbmQHe/9OkfDspv5O/MC+DzEKpZZZVC2MioZuq4T+j2TLfbYt2p9ZtGh3wJU3Ls7tQ45vJ4toMc0xGkJj6HxyH14wbpF00drjvid8BlNevrU65bDLS5ydUCDUxPp6e7r44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3lNlvcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1785C19422;
	Tue,  3 Mar 2026 04:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772513221;
	bh=vj+3M3PLxjwcWXquns4pXjUbSAndqJWRP+3XCK2AL4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B3lNlvcSUq3Mz6z39HEL89v4cQBUJvhvt268QK2LF/vfxGMzr78PvWjr3oUFm71sp
	 WNFKfznMEaVyjDA2FbnIbXdMU+6TUJLIhpaL6xAUVzhdbPmUY0skVua9VYJ0r2Nc+b
	 ykLgwaq5bDmMCkLZU5CIGAt5fWiuQAGhbv7OsnxtbCnE2NiNZ8FqAqXUlL9EAku8U8
	 wQpM0Z7NRFZ5pb+6mSb5xExNnl735nfflMOuetys3tu8Qpy+doPegwUdKEhOR2Jfyj
	 PaevsHg+UoxdA+GBwX8xxQM/22VWzHik8DrgYfbnGlOERBEJlU18yEeks8LE9KAsyw
	 cocHJ0UP0G+Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDA83809A80;
	Tue,  3 Mar 2026 04:47:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: remove addr_len argument of recvmsg()
 handlers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177251322304.625663.12519588393329554160.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 04:47:03 +0000
References: <20260227151120.1346573-1-edumazet@google.com>
In-Reply-To: <20260227151120.1346573-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Queue-Id: 8C1031E90A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-263040-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Feb 2026 15:11:20 +0000 you wrote:
> Use msg->msg_namelen as a place holder instead of a
> temporary variable, notably in inet[6]_recvmsg().
> 
> This removes stack canaries and allows tail-calls.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux
> add/remove: 0/0 grow/shrink: 2/19 up/down: 26/-532 (-506)
> Function                                     old     new   delta
> rawv6_recvmsg                                744     767     +23
> vsock_dgram_recvmsg                           55      58      +3
> vsock_connectible_recvmsg                     50      47      -3
> unix_stream_recvmsg                          161     158      -3
> unix_seqpacket_recvmsg                        62      59      -3
> unix_dgram_recvmsg                            42      39      -3
> tcp_recvmsg                                  546     543      -3
> mptcp_recvmsg                               1568    1565      -3
> ping_recvmsg                                 806     800      -6
> tcp_bpf_recvmsg_parser                       983     974      -9
> ip_recv_error                                588     576     -12
> ipv6_recv_rxpmtu                             442     428     -14
> udp_recvmsg                                 1243    1224     -19
> ipv6_recv_error                             1046    1024     -22
> udpv6_recvmsg                               1487    1461     -26
> raw_recvmsg                                  465     437     -28
> udp_bpf_recvmsg                             1027     984     -43
> sock_common_recvmsg                          103      27     -76
> inet_recvmsg                                 257     175     -82
> inet6_recvmsg                                257     175     -82
> tcp_bpf_recvmsg                              663     568     -95
> Total: Before=25143834, After=25143328, chg -0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] net: remove addr_len argument of recvmsg() handlers
    https://git.kernel.org/netdev/net-next/c/8341c989ac77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



