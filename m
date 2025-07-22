Return-Path: <netdev+bounces-208744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C06BFB0CEEE
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6391AA2F64
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FFE15442A;
	Tue, 22 Jul 2025 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtdSqL01"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC8E27454;
	Tue, 22 Jul 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145994; cv=none; b=qLgXVbX5gYzuseUR0ijypz3GV28SVkiewBMhm8g3rN79rzRLmV7gqVfvb1FANvGe2qbJa2Otc6/IhxYq4YkB4stP9fpmRG6zk7nNcLcwzSPKURN78oEFlTzmgNu3VKZjQtnOkjsnvcY52oi/CYDgsXPnOWpb0M2KkwUFfh8mY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145994; c=relaxed/simple;
	bh=PEwAjfoNF2j3j4S0FxkteIpwOLojx+rX+ty+w7Z0/7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NQZMoTijLsTYVyPHoIYdFDN4Tj288lg2FPL8M3n5ilakd4OOuqGwvyqhdcx8BxlGXI62KNVwVkSOtPyBVE/6sYqu0Myf2YM04UPhV2W7LOlto/ZfMNqHBJEisZ4fAzWRDtevA2f+6IgYc/j/QUiZHIwfsD3AuF4mD0jOALZTowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtdSqL01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C260CC4CEED;
	Tue, 22 Jul 2025 00:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753145993;
	bh=PEwAjfoNF2j3j4S0FxkteIpwOLojx+rX+ty+w7Z0/7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HtdSqL01zYGk6i39WNsDVZ0PkXJBohZIa9ofP7OkDPQjUQDFcXT+gggvbaED9qZTK
	 2MoQj/zhrcd3bBnhP6Lq0jVvndf6djs4SKfsrZYfyKGIAiwt3PDMWAYLhN3OwsbhmE
	 3rBYGAn87QOHC47Y4yiok6TRx7GQbOmDhe0a9fATbyMtuFF0BBPiX8S1VFZblY2TfL
	 IeRfNUuaaoB+edIZRENMR7D/RM/yMmaIBOWeJ85t5RnwcyzjzdA+/5VIkuCgn9v2t4
	 2sx/DLE2SlAQ2fhTfMl8Zf76U2bw5xc4X+FzDnTHKlz+ubXNCxmuM5aWh+3zI1USYu
	 +fpK5Pe3jGTzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB0383B267;
	Tue, 22 Jul 2025 01:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] mptcp: add TCP_MAXSEG sockopt support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314601226.250300.15210710669100792848.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 01:00:12 +0000
References: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
In-Reply-To: <20250719-net-next-mptcp-tcp_maxseg-v2-0-8c910fbc5307@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ncardwell@google.com, kuniyu@google.com,
 dsahern@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 moyuanhao3676@163.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 19 Jul 2025 00:06:55 +0200 you wrote:
> The TCP_MAXSEG socket option was not supported by MPTCP, mainly because
> it has never been requested before. But there are still valid use-cases,
> e.g. with HAProxy.
> 
> - Patch 1 is a small cleanup patch in the MPTCP sockopt file.
> 
> - Patch 2 expose some code from TCP, to avoid duplicating it in MPTCP.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] mptcp: sockopt: drop redundant tcp_getsockopt
    https://git.kernel.org/netdev/net-next/c/edd669057c56
  - [net-next,v2,2/4] tcp: add tcp_sock_set_maxseg
    https://git.kernel.org/netdev/net-next/c/51a62199a8aa
  - [net-next,v2,3/4] mptcp: add TCP_MAXSEG sockopt support
    https://git.kernel.org/netdev/net-next/c/51c5fd09e1b4
  - [net-next,v2,4/4] mptcp: fix typo in a comment
    https://git.kernel.org/netdev/net-next/c/154e56a77d81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



