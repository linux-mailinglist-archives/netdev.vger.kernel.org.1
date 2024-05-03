Return-Path: <netdev+bounces-93391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BED8BB7AE
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C41C289685
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31C12FB3F;
	Fri,  3 May 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/5W2Hwq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0312FB25
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714776030; cv=none; b=qmHbHnpcCAmerxy7JbpzLLPZEFU8OsDZj9XvYSvFjX7aiIMOwlOqtgh9MP6kj641NDDE5VYBC/J88faxd+bOpiVz6to9u4+391IFjdB8rbQaJnVSJ4HLzo4CoHmKmtoQzrJumW4LzfrwiPRzyUHuDN5kiofhOHXFo/6fVgvyMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714776030; c=relaxed/simple;
	bh=o70mXKZFNS+6p3nf8LtUlaUhfqSmidFCrN+v7E6q9rQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V2f1omTssquiMRKdPaRhm/Wswm8d15UNfq7LM37TD+TDCYh4kryUAw9eLyJeYJiJ1lEYeNe76OJRcjfA9XHBHm4nJ/fz/XS9Bxd/3j8tNA50GY5cpaRDpU2OAMLFaM47P791+7tMO+iAC4p2x/C/cDK6BQCC/NqaXbSpbnUz//4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/5W2Hwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 055E4C4AF1D;
	Fri,  3 May 2024 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714776030;
	bh=o70mXKZFNS+6p3nf8LtUlaUhfqSmidFCrN+v7E6q9rQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P/5W2Hwqnl4CAMhUKYKXeSqTyCtpAfwa1edsfbNUdV31kkVaKScxLIDLXLSL3C0g+
	 WUGGYwGacTg117EzZ026jPWGxjYheFNTSeptm4m/f19JibEemA9BhFiAAmnosVIkuq
	 Os2EX31YsuDHe4migktifYyGQQjBh2179nmnwBOY1K4GAvKCJMnuxhUbLQ/lnbYknq
	 BZBs36daACxgyfMTJA6rBq5I/Q33HFtFFb3ogOzQu7KBujWTT/rRndOXlHDhrdJLaH
	 Zez9lvO74MBKeHAKCNe1U1VvX70EOx1OOtO1iB1Nzy7j1U6jLZcqvvlDv49zDIUnsK
	 MzAJ/YrI6U+cw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFC70C4339F;
	Fri,  3 May 2024 22:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: add --list-ops and --list-msgs to CLI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171477602997.29342.7703039736446300738.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 22:40:29 +0000
References: <20240502164043.2130184-1-kuba@kernel.org>
In-Reply-To: <20240502164043.2130184-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, jiri@resnulli.us,
 alessandromarcolini99@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 09:40:43 -0700 you wrote:
> I often forget the exact naming of ops and have to look at
> the spec to find it. Add support for listing the operations:
> 
>   $ ./cli.py --spec .../netdev.yaml --list-ops
>   dev-get  [ do, dump ]
>   page-pool-get  [ do, dump ]
>   page-pool-stats-get  [ do, dump ]
>   queue-get  [ do, dump ]
>   napi-get  [ do, dump ]
>   qstats-get  [ dump ]
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: add --list-ops and --list-msgs to CLI
    https://git.kernel.org/netdev/net-next/c/3e51f2cbbc5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



