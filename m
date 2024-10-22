Return-Path: <netdev+bounces-138031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E29AB9DF
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53511F23BEB
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160671CEADF;
	Tue, 22 Oct 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmQfPSXs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE1C1CEAD2;
	Tue, 22 Oct 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638632; cv=none; b=lfpD62ABK2dH21n6UqMWbTktyoHzkIX5vS8JxNoEr6n7r3UoLqHIb8Km3e9iMXE7PZC5RUS40x7AzVx24fj5UcMHaixwlEDZslfiMbn9HpihK5T3htleknhDOkXzl4J7guvLBzMX7v/R4HeCgvj8Zew6lPvL/ZC8yeEI0tH7cQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638632; c=relaxed/simple;
	bh=10MRjs6fjvYT3xA4H31MWtpz+g/GyNk/xP/eyYjIJJ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j21Wpl7T04JUTmTsiTUsOBo27XrvNGpG8LNHhpooxtZvOWV+9slZvUFd0TdeQmF/puzcz8FZxHFXBaG3wkUAICbvIJTb5oBMAbUVRhhhyu07m52w9x3BgFJbeVtOgF/GFrxhNV261WWU7fI+tludAUnDo7sYeSekmZOhsqk2vcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmQfPSXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAD8C4CEC3;
	Tue, 22 Oct 2024 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729638631;
	bh=10MRjs6fjvYT3xA4H31MWtpz+g/GyNk/xP/eyYjIJJ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WmQfPSXsp2G/c05zmQVfKbjaPPyqoPGFuhVGHRq/stC+AXdu3Q/2MEoJKys49sRBm
	 +ERtcyDf2h5pe8J0AAkijwccyAZ6ls09U2n6sZXOkkHR00cQT20nq37zhKsZlqwlSj
	 A0xqetZ1HCPHHs3f/pkn73+MbvjQGPJOkwNVmYOlye1dzNrDtrkbXEaha/t7ooSziQ
	 II/GU07l1WjYOPqalZ5QF7IP51cqk824IYN9Ke+RYEs6T+4c2J7LJqQUx6U69WJSxO
	 gBiGvpCuLMnDz476QARwi641/ucH5kvTFsv8PC5MEx69YxkgzxqAMI59A5bRmgEbh6
	 UmnAfJpj3I+yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE423822D22;
	Tue, 22 Oct 2024 23:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mv643xx: use ethtool_puts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172963863751.1106081.7315507635710277838.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 23:10:37 +0000
References: <20241018200522.12506-1-rosenp@gmail.com>
In-Reply-To: <20241018200522.12506-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, sebastian.hesselbarth@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Fri, 18 Oct 2024 13:05:22 -0700 you wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [net-next] net: mv643xx: use ethtool_puts
    https://git.kernel.org/netdev/net-next/c/73840ca5ef36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



