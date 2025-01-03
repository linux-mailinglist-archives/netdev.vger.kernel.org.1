Return-Path: <netdev+bounces-154875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AFBA002DE
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D2F3A372B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A0E43173;
	Fri,  3 Jan 2025 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRK/3cLa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A1A47
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872615; cv=none; b=gosQKh3COgrqSXPWLLv9Iz+2/d72u1KUWJqPlyabAHnefUz66HZkjyISh6UFvgWwjuxmXJHJG4/1ojh/g2rg71QdaDfjG1Inx83Coqs2i22wxP/PLWPVkDfdmqr9LHEQh6IVWyH4EA+yfk83AFtRNQbeySIosmsP8+KzsWBt1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872615; c=relaxed/simple;
	bh=AVsETXKZSeNIY1eRJPDTSGr8qAWwe5OeJJioJHgYVyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RYLMkgvr26hCRuY49HbA7ppfLGGoo832oKKqbQ/GNQzSvS45MFba14iR8M5sOgZi8w49BMMSoQGmJmLaUI1fNnUR91KGhvoh06KuUUNS2+cMfhoNtk7mWH5pImO37e5a1lcQ5LMx9QAI9Md1JyS0KK+2J9fNVSyO4z9z44Nt17s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRK/3cLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C902C4CED0;
	Fri,  3 Jan 2025 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735872615;
	bh=AVsETXKZSeNIY1eRJPDTSGr8qAWwe5OeJJioJHgYVyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mRK/3cLa5VrUyst+mxDO0N2MR0roBd5xqLVspXZ2SYOToaFM9W0dEErMXOas7SbVx
	 BOCYfqUFUuEoslo4sBr2l3ieFa/cVDoYFlOEJcOOZa33JB2OCvgoX2wPL8xb5xee58
	 3Qg0YUaWGkRT+QfdUzuiwGWLlJnVem4oSluyvGr784p2TqDsVxD/jHe4c3i6gxNgYH
	 bz4vEb4SqviOX7XcnUMIP8fFO2l0EYiUcOdKp4tifmzJ3vkLUZ+N6fRlJdySc5okXP
	 qVLre58vmsShJLPZW5ROAWSWjcNy8jjtR9pWC+gxIF5Vro4C3a/aBYrif3wKZhPWRK
	 kOjVcBe4ES6tA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE7F380A964;
	Fri,  3 Jan 2025 02:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ila: serialize calls to nf_register_net_hooks()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587263578.2091902.17556527930580326088.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:50:35 +0000
References: <20241230162849.2795486-1-edumazet@google.com>
In-Reply-To: <20241230162849.2795486-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, eric.dumazet@gmail.com,
 syzbot+47e761d22ecf745f72b9@syzkaller.appspotmail.com, fw@strlen.de,
 tom@herbertland.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Dec 2024 16:28:49 +0000 you wrote:
> syzbot found a race in ila_add_mapping() [1]
> 
> commit 031ae72825ce ("ila: call nf_unregister_net_hooks() sooner")
> attempted to fix a similar issue.
> 
> Looking at the syzbot repro, we have concurrent ILA_CMD_ADD commands.
> 
> [...]

Here is the summary with links:
  - [net] ila: serialize calls to nf_register_net_hooks()
    https://git.kernel.org/netdev/net/c/260466b576bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



