Return-Path: <netdev+bounces-261182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBWhIXPFn2kRdwQAu9opvQ
	(envelope-from <netdev+bounces-261182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:00:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2697E1A0BD7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 05:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F49F30776BC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52D2389DEF;
	Thu, 26 Feb 2026 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcpnGrOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8225A3876B2;
	Thu, 26 Feb 2026 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078409; cv=none; b=nNl8/ZDw2f+6p/RMx5ACuVwVjxggandLVaQI6IDOqdOuRpCLWyUyxqxKeSwRI/76daomw8VdrUOaNO4zJqQui1aOiBQ8eYzg6NVMdZ7FHDzcvtjQetHoAKCScwynIGqaQk+179XCnrbXP1zYzlYCBoYLw8XM/EBcA/nUqu65MnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078409; c=relaxed/simple;
	bh=JH5k4Onh0+/vyJWFumwNzLVVfln/BXDOl0TSF8xicPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YD+Th4aGcgdVpk/nTCxxWetI5bFWLg5s4ICIsWMv/xiG4yko0P/kOhTuYH0vhWTxH3bfqGR0ZazhSU/MipX4c/64IuCjRKCl5NZtRuyFnz0UUyZIvOBeOsi2ay5xZFNu56GwHouaGNO+90j4/G36uOG35vX30viFg90c5fXUwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcpnGrOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE0C116C6;
	Thu, 26 Feb 2026 04:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772078409;
	bh=JH5k4Onh0+/vyJWFumwNzLVVfln/BXDOl0TSF8xicPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fcpnGrOCyy8cJpioEdlL+YUPGiBcKKU3RFK2jVaGJFW57h2/JUm5jGzXL5g6qgzCe
	 wIxCtNC9ay7G579pCVjL+CAawnTVJSvRElNvhn40SLPpRBq4oB88i+7o0xJc/ZR9MB
	 COeKvY6IlVnRzUDtAkst1nu6kulVbQ2AXpszRgrM6TOI3JKnCLeV6kgELR5AKqq4cB
	 QrmDdgn7YlB3zN13FCB//Ptr+/LINJ4EFOQY/+DWxjEWjbfWgN/TqnNf/wgOA2eTCB
	 WeMu1tgPYmoGh+gGTI3iPhMirvarGM3/wGXcUhJm3KaDPfqPpq/mRQ8GxayAAXfiMU
	 CmtgZtoeY4fTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DA2380A94B;
	Thu, 26 Feb 2026 04:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Add selftests helper to get N unique ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207841354.1030125.14442366564236324185.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 04:00:13 +0000
References: <20260224224659.1507082-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260224224659.1507082-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 willemb@google.com, sdf@fomichev.me, daniel.zahka@gmail.com,
 cjubran@nvidia.com, gal@nvidia.com, dw@davidwei.uk, mohsin.bashr@gmail.com,
 noren@nvidia.com, leitao@debian.org, petrm@nvidia.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261182-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,google.com,kernel.org,redhat.com,fomichev.me,gmail.com,nvidia.com,davidwei.uk,debian.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rss_ctx.py:url]
X-Rspamd-Queue-Id: 2697E1A0BD7
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 14:46:57 -0800 you wrote:
> The rss_ctx.py tests would occasionally flake. I found that the successive
> calls to rand_port would occasionally return duplicate ports, breaking the
> tests invariants.
> 
> Add a new helper that guarantees generated ports are unique.
> 
> Dimitri Daskalakis (2):
>   selftests: net: py: Add rand_ports helper method
>   selftests: drv-net: rss: Generate unique ports for RSS context tests
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] selftests: net: py: Add rand_ports helper method
    https://git.kernel.org/netdev/net-next/c/b0249c0d41b3
  - [net-next,2/2] selftests: drv-net: rss: Generate unique ports for RSS context tests
    https://git.kernel.org/netdev/net-next/c/19c3a2a81d2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



