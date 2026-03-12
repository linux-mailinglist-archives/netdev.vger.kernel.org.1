Return-Path: <netdev+bounces-266850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJuGNfMismnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:20:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 728CA26C2A3
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDDD33012E69
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B748F3375C5;
	Thu, 12 Mar 2026 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM+1cLNQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9409831F982;
	Thu, 12 Mar 2026 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282033; cv=none; b=IFaapCfM3EuEJUauXRKjTvKHgll1kpoI9qgQIi/9kXvQMF90Sc66PM2Un6qrzzgn2HsU6oS2yu2n5kCtzTNY+40a1j87HDZ+GwEzgXPAeZdF05DOgtNpdiKsXjQRKzkOOLAovXXkEeUeF0u0U7SREBKs+xs7e2qhYcAE/rIr7SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282033; c=relaxed/simple;
	bh=s6Ldrwxa8TCsXJ6guk5S+vJu8KVnchMxsGiTjBsLFFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DWMmEAnoQAcvZpFGXrOqsy17+E7L4JXKas1GdwAoCa2MqJwu0b6LhrFoUOAQHxg+RPdJARNQdPzMkaAx42JoJNMRixl1hbr5RSrSa49XbSf0wG3zxT9Z3YbieFoNjRBRJ88Scvp+KZgWD3GMfq7t9hYxG8SPB7cFDnoZCrFyhLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM+1cLNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDB3C4CEF7;
	Thu, 12 Mar 2026 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773282033;
	bh=s6Ldrwxa8TCsXJ6guk5S+vJu8KVnchMxsGiTjBsLFFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eM+1cLNQm1eoa80QTRCHUe4PyrxBnjFPMDGpaiVA570HYP3erMqAymqQh59Qyh352
	 RSNQKdQ3hnHj8wWRoMHyAzmZDI6QTQlmQUhObIawl4UgisIaaX+hVdvg9dV78ezGE1
	 5OozTOkJFooDBUATZMVemCUJXiAuvmEdOw/KaBaXLopqlAvuuZ9cx/YqI9HldyqScJ
	 vgqLX3IG8jZXcJMDiSJvpVTmtjRHFJ7Vj3P7aRE4YbUIbeLBlbmj2jBNcho0Z1knj5
	 XUoHK4Mxuojt6zUEeRzkiOWZxAcyukrzabtdWygzA6EdxZXZFilMCrMjHQoAPoiq4T
	 UkwvWIoFP5low==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD63808200;
	Thu, 12 Mar 2026 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] selftests: net: fix cmd.process() timeout
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328202904.3908053.2650272713884965081.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 02:20:29 +0000
References: <20260310115803.2521050-1-gal@nvidia.com>
In-Reply-To: <20260310115803.2521050-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 horms@kernel.org, shuah@kernel.org, leitao@debian.org, dw@davidwei.uk,
 linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266850-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 728CA26C2A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 13:58:01 +0200 you wrote:
> Pass the timeout argument correctly in cmd.process().
> As Jakub noted, fixing the timeout broke the bpftrace() command in
> netpoll_basic.py, so fix it first.
> 
> Changelog:
> v2->v3: https://lore.kernel.org/all/20260308192126.2490631-1-gal@nvidia.com/
> * Resubmit to net-next.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] selftests: net: pass bpftrace timeout to cmd()
    https://git.kernel.org/netdev/net-next/c/82562972b854
  - [net-next,v3,2/2] selftests: net: fix timeout passed as positional argument to communicate()
    https://git.kernel.org/netdev/net-next/c/f0bd19316663

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



