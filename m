Return-Path: <netdev+bounces-272715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Aa7DrpNx2k7VQUAu9opvQ
	(envelope-from <netdev+bounces-272715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:40:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D734D302
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A70B303C681
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 03:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E023603E7;
	Sat, 28 Mar 2026 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeFe9J5d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6A35FF6B
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774669229; cv=none; b=SHBw/2IIWipWFrU/9YIqEL5zHyoJu0XkHywhottkMuXvtP20UZO3GGFb+LVxfYm/AGXC58PirSZDNLufVvuVQtwHcm8SwAEaFTd5FRSrcfuxrnkHdLd3W2L/TqNWuvvEfVIowiSrw4gNuneekYPtSRJD4T97idNVdqlQkMrApxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774669229; c=relaxed/simple;
	bh=xKgSQtOM+CtRChF3giWqmyUjr1/tlqIWkzrB2vVCbMg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nigmd5w20H4qK6ZHUyxG+w0+bZdMkbuKMBIaAyO1mZzdPmHFg9BzkyCHiZBJPDBWsP0KgKEBpgv2Jv2FUzu7nbrTRvLPkj/+ZiUH6JXRF7YP4/SgNtQjVYlCoz2hJ2VUrWoLM6iLWOTuNmD/pZPu8PdhtF9Sy5T5cgpbsojWXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeFe9J5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4252C4CEF7;
	Sat, 28 Mar 2026 03:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774669228;
	bh=xKgSQtOM+CtRChF3giWqmyUjr1/tlqIWkzrB2vVCbMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SeFe9J5djPix8UH+9axBH0tKh9GS/DDEu6q8a29VZDw8trqjHg6Y7fxJLmo2iVD2H
	 iX6E+2boMgC0ffFE0czhpmFGjLfpTun+agchsMqiC44pyUiou0MoCcxyzQDYmwIme1
	 h0Yw0tpwdTUwFnG1hEgRDog9jZ2W3Q6w5oSYv0vwwIZtuy7NMGE3kgE9huPRyJ8Vhn
	 ij9VNZD4t72awZDwEE3ot7FVyzk+7OzFUycGIWwm1yFcy8mF6mxqgnvezRPrts8CJa
	 soUUfPtvksnPAzEd5qMi+5sNPgWmaFY1HrIsL2woBMVbIAi52lsCW/kMfCbVcJez8D
	 XAbNc6DW/qp4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0893930181;
	Sat, 28 Mar 2026 03:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Fix page fragment handling when PAGE_SIZE > 4K
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177466921428.4169512.12440330427205497180.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 03:40:14 +0000
References: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, alexanderduyck@fb.com, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, mike.marciniszyn@gmail.com, lee@trager.us,
 jacob.e.keller@intel.com, mohsin.bashr@gmail.com, almasrymina@google.com,
 netdev@vger.kernel.org, kernel-team@meta.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272715-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,fb.com,kernel.org,google.com,redhat.com,lunn.ch,gmail.com,trager.us,intel.com,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: C25D734D302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 12:51:21 -0700 you wrote:
> From: Dimitri Daskalakis <daskald@meta.com>
> 
> FBNIC operates on fixed size descriptors (4K). When the OS supports pages
> larger than 4K, we fragment the page across multiple descriptors.
> 
> While performance testing, I found several issues with our page fragment
> handling, resulting in low throughput and potential RX stalls.
> 
> [...]

Here is the summary with links:
  - [net,1/2] eth: fbnic: Account for page fragments when updating BDQ tail
    https://git.kernel.org/netdev/net/c/b38c55320bf8
  - [net,2/2] eth: fbnic: Fix debugfs output for BDQ's with page frags
    https://git.kernel.org/netdev/net/c/f3567dd428b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



