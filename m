Return-Path: <netdev+bounces-159594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 852E1A15FD9
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2107A18A1
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE7175D39;
	Sun, 19 Jan 2025 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7pUjvj4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563151632CA
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251418; cv=none; b=CrJtTRSslrlu+YbpjHVEUfGmL68gpCXzl0lKxQ2UG1tDsAYP82lecjDi8Q+GJKOFPk6JvxqynOH4pgG/HwFH1kh/5buP04brs7+och/qXxDj8qsMAi0Wvu7UVEaSFauqXXWlBDENdzleX1GxQnD+CzjyxmEcWDTKH497yie2j9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251418; c=relaxed/simple;
	bh=qxVJJ/PnOwuBzyY3ceD6c7lBBoTMuZXUoKAXwRBWvVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dkkm0+RZ4TVrkhuqJEoUFrgyr1QLikr4RREKofYF7wC7cepVxzdDkFbZa4ZyIQ5eOOkvWdnxzU88qGnTR9USV0BILf/ok4qnJV6irbue97oVfXiyZ0tEMsf746NtmnxM//0klhJ6N8pVj/rMhi0my2r3fOwvvcCkpMCZhj4Zop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7pUjvj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DB3C4CEE3;
	Sun, 19 Jan 2025 01:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251416;
	bh=qxVJJ/PnOwuBzyY3ceD6c7lBBoTMuZXUoKAXwRBWvVw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i7pUjvj42uW2hHkqTiEjboGhYT3SJ4ydSOu2i659IIokTJobHV653JKMTMd1Ger3f
	 4clY3nHFzLuU1OtQ2kRWZ44Eajow9c7mifPMmdLrZkv4/a76jkczpK/u7WjDl1QFhA
	 3VS2ZMssjXTKo8b0pUHDE4PiMgBUwKwOqbRCLY/ov1V1V9dw7TtGbSnHI2rgIEgGNE
	 rl7rKSEQDn9eOEvX85/yskfal5EF7t8jVXvFQVe3EXFzXQxVaUlgtyg49eRfuM/JH7
	 //HYRidDbbAMhH0HvceZPN9T/raulrUYNB9L87FzAgp+l2zQ+PatEDLEqqX2TvWseN
	 X5gl1vq7N6MZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB4A380AA62;
	Sun, 19 Jan 2025 01:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: introduce netdev_napi_exit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725144048.2533015.1081621461561304322.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:40 +0000
References: <20250117232113.1612899-1-edumazet@google.com>
In-Reply-To: <20250117232113.1612899-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, kuniyu@amazon.com,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 23:21:13 +0000 you wrote:
> After 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
> it makes sense to iterate through dev->napi_list while holding
> the device lock.
> 
> Also call synchronize_net() at most one time.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: introduce netdev_napi_exit()
    https://git.kernel.org/netdev/net-next/c/185e5b869071

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



