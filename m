Return-Path: <netdev+bounces-75294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EAF86904C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CCF1F28304
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8DC13A894;
	Tue, 27 Feb 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgVWso5p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D113957E
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036429; cv=none; b=mDEfsH0x3ptWmP0IoT1KkpNvL07283qVj6trwt2K0cYfm96iodwxutI12T8AsbsNLI7Eo3nrbbvoAjA8/K+ArP3SEjTERo9oHJw+elemS7Aw0ZR0cKEiNkyKnjE8YCjs8fHmFpC6u/Jh4nz5wNRLOCO9t27irtgb9BQJ2kZkNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036429; c=relaxed/simple;
	bh=F5d4lJqULB3P3UxoMD45ZhXS08Me0yEXESdLlT55TdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YBqq0ojUIvIc2wtB3gIvSxYpc8vRQ/DB4vAxCTBPfuSh0fgQ/o9NylEmGwTFlO0je+q2UKBZ2LyorJOY2vvm3G58GlWfqqd+MoMyM3OppkcDaVhFeBoMCRpGD6Hb4z39HJSJum99YAvrs+kXWyJqPGjH7DTP51BgmKm7vMbyN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgVWso5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E71C8C43390;
	Tue, 27 Feb 2024 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709036429;
	bh=F5d4lJqULB3P3UxoMD45ZhXS08Me0yEXESdLlT55TdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CgVWso5pOsX4VhOWm+oeCiPvi+I4qYecJeFeF066IHL6rIeoTnyReMj4Y7BfFGsj1
	 xN4dJSRCU8zPSWtzjcrnUf3CHdADJ/WTIe4zf6Azuw5TgPEs9oxZAGpJcCxfRd/O5f
	 696Im/nQ1SP2cjVyjBJ9SuYSaqgxqw7mPAW1ut+1NOkPVDIoscX/chsgcd7JnnDcaE
	 gJu/mES8gDIF8DEh9oYZBAuEeyixD71962HUrUk5VQJyPBlCMT17+PTdtZJAgEcf0D
	 y0ngTz+P/4irb26w0F2V9GoUgNzQ7Vi1aCJxwHjzJk6uTaBoVElAayoSRHQv5bm934
	 qUBZAla2rOYjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAECBD88FB0;
	Tue, 27 Feb 2024 12:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] ionic: PCI error handling fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170903642882.13677.3100305220509387658.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 12:20:28 +0000
References: <20240223222742.13923-1-shannon.nelson@amd.com>
In-Reply-To: <20240223222742.13923-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 23 Feb 2024 14:27:39 -0800 you wrote:
> These are a few things to make our PCI reset handling better.
> 
> Shannon Nelson (3):
>   ionic: check before releasing pci regions
>   ionic: check cmd_regs before copying in or out
>   ionic: restore netdev feature bits after reset
> 
> [...]

Here is the summary with links:
  - [net,1/3] ionic: check before releasing pci regions
    https://git.kernel.org/netdev/net/c/a36b0787f074
  - [net,2/3] ionic: check cmd_regs before copying in or out
    https://git.kernel.org/netdev/net/c/7662fad348ac
  - [net,3/3] ionic: restore netdev feature bits after reset
    https://git.kernel.org/netdev/net/c/155a1efc9b96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



