Return-Path: <netdev+bounces-159601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EC9A15FE4
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124FB165C7F
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8429D15E90;
	Sun, 19 Jan 2025 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhCZsTmK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B749EAF1;
	Sun, 19 Jan 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252040; cv=none; b=VMD3J4/u4zPsSzZtVJvr40xnt4olil81qI/JVvN/BWVoDgZn8jPzWUpmLNzR0uoHrD0+N3zIS2E1kf5xd+bNtHWWMMtgHPlCkkefNcNCvZF6VLpstXZfbCZBqf2C258kciLxlBGw0/8Z3vffe2iPmzowyR7QO5Pn+64U0+WeH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252040; c=relaxed/simple;
	bh=hr4xTFEq/FmW5CeBgO7+KW8G5Hzhp9cIpSu+1K8bpgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PsZG/+qYZzM77T0W1aMec0N/NpDDpsUuvi93N1vr8y6f7aqkqkthcniF7WQWDFFAtCqWQpswgE/bzdm/YwioNWIb07Y2t6MEobYu7k2kTfOKk0t8ngUeF8K1C5+KsBhy7oNZ2d7jWW7h9fnSe1poFLspIQX25m6y3ak2Za0obpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhCZsTmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D62C4CED1;
	Sun, 19 Jan 2025 02:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252039;
	bh=hr4xTFEq/FmW5CeBgO7+KW8G5Hzhp9cIpSu+1K8bpgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EhCZsTmK8zxzKtSkh0u8/NVBW4gMK9+2dfCxk/pVceucmIFUXVPB604hblEQpKvgY
	 sH2ranasvh8oDDo/nvLjfMM3stM6p83KiBEPUV7tyygTsANAu6CHL3Tj+1TNbM5Oxr
	 mwCWqTuov0d472DB08Wdv/QGu4+Mk8YO2PLfk6oiFcLU2vHUDQNKBv0SZMASyNvHdi
	 la2Oir8V3ONKs7Ik7H6drt/CEQ46ZUiZwa8A07yNnzy65bA3isqUwv9irT88V+VjWb
	 A44PRH7/xmsCkmYLPekNWwgxhFJCOM/TDqsR0yitoqthXUjr7KVQPNcBu4uo2RQizU
	 I/T/CRwSQ1Xxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADECE380AA62;
	Sun, 19 Jan 2025 02:01:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2025-01-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725206323.2534672.8960005298494686018.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 02:01:03 +0000
References: <20250117213203.3921910-1-luiz.dentz@gmail.com>
In-Reply-To: <20250117213203.3921910-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 16:32:03 -0500 you wrote:
> The following changes since commit d90e36f8364d99c737fe73b0c49a51dd5e749d86:
> 
>   Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux (2025-01-14 11:13:35 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-01-15
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2025-01-15
    https://git.kernel.org/netdev/net-next/c/1a280c54fd98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



