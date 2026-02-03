Return-Path: <netdev+bounces-256094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDyLE8pdgWmdFwMAu9opvQ
	(envelope-from <netdev+bounces-256094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:30:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EB5D3C89
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D8FB3006997
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC442FF652;
	Tue,  3 Feb 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIlV0kgT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5C1A073F;
	Tue,  3 Feb 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770085827; cv=none; b=pvJI9y853j1PWqJPdc5TFrh71uewYOIblRQC49OQZXMY/+WEpU5AVPP+0sf476i0yEAVBPQeI7RXq1hBdphm2rBA19p7OrXZ1+XZAgcJ1KAxZeGZGRkigwfVl7SqQg5mX8GVHqrwMOrPSLikLwOT/V6j4SgvjJ37x+CIHzoTPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770085827; c=relaxed/simple;
	bh=lX8dUKz+kZPoLRJ/NK05u+YSz9Nvge7N8Rt8EjIGNgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NYc1/GeCYGmBvcEw3FJEAD9knF8CL4BnRrRaFIhLB3Kn04qVaANVBcF3G55LPDaOUd9gtaeICUbKk708pNftNbn67vMeOal9TkCKrFJVqB7xbcrPnQoHyohZjNb6BvA3CAFPrf4SPf1FnSWZHCLfbRpzNH4OXFgDlSLn9kWmuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIlV0kgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261F2C116C6;
	Tue,  3 Feb 2026 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770085827;
	bh=lX8dUKz+kZPoLRJ/NK05u+YSz9Nvge7N8Rt8EjIGNgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qIlV0kgT3rG4JV3oDiQ60I/HYU5JvsuLwZGU2fEdZYx+RWCR7+Z2qgxhaBtDxFGY6
	 O4zgJPrxFAlpWJgY9OlkuktipA1JZ37OI3G5hwCWTBGkpuS6FtuMbM+G1tB6hIb14y
	 b89d0f+Isp1sWBWGUZrFGqXnQa/w8mX/t1npep9L7eBmsb07hS4olOfeG2779eCrLg
	 e9e/74BNW3FDVkZHpsykUm4PrSW69WIR4y0FxJyC6IpxXBQg8InIOfJq/Uhq66wvF8
	 x6SwsLz5OdIGeRmas3ucLXc+KMeKG6vtbvCIVEdKsLcx1GNlC6GZdBjQi+ctrUr1Vo
	 00eQrips+/aaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16E543808200;
	Tue,  3 Feb 2026 02:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] mptcp: implement .read_sock and
 .splice_read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008582361.1282989.10777198341213634475.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 02:30:23 +0000
References: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
In-Reply-To: <20260130-net-next-mptcp-splice-v2-0-31332ba70d7f@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
 shuah@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 hare@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256094-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71EB5D3C89
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 20:24:23 +0100 you wrote:
> This series is a preparation work for future in-kernel MPTCP sockets
> usage. Here, two interfaces are implemented: read_sock and splice_read.
> As a result of this series, splice() with MPTCP sockets -- which was
> already supported -- is now improved.
> 
> - Patches 1-2: .read_sock implementation
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] mptcp: add eat_recv_skb helper
    https://git.kernel.org/netdev/net-next/c/436510df0caf
  - [net-next,v2,2/6] mptcp: implement .read_sock
    https://git.kernel.org/netdev/net-next/c/250d9766a984
  - [net-next,v2,3/6] tcp: export tcp_splice_state
    https://git.kernel.org/netdev/net-next/c/2d85088d467f
  - [net-next,v2,4/6] mptcp: implement .splice_read
    https://git.kernel.org/netdev/net-next/c/22f3bd9bf8e8
  - [net-next,v2,5/6] selftests: mptcp: add splice io mode
    https://git.kernel.org/netdev/net-next/c/6a059c6bfb55
  - [net-next,v2,6/6] selftests: mptcp: connect: cover splice mode
    https://git.kernel.org/netdev/net-next/c/2f2dc84645fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



