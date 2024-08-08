Return-Path: <netdev+bounces-116681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9184E94B590
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0782839AF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89AC40BF2;
	Thu,  8 Aug 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+eztTKq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E762A02;
	Thu,  8 Aug 2024 03:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723088430; cv=none; b=eHcyTVZ+H/SK5MfrOanzoa3U+gItJOcNsp6kfbfqt2AICgPrxqwpNivlQu9Nz6REx37x5ayEhN8amceOXOUlYEnQLy0bbDN/558yXuKy9d5BOsZSVtX9h0ve9pWhXIPWsGMGL9+282sSuDk8VJ8M5Mnm43ScA0EfHT+qnxN1NYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723088430; c=relaxed/simple;
	bh=DqibG60X2xK/4jEwte3Q1mAW4ZejbXnY8CJwiBzXhy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNWi9OKmOSHCv71128mJQYbcz2c4iRnN+f63esScKOMLlkRALWkGwpcbJQ1Qtmy/EX/aDm8mJXBCU+LvZ5VoTkQp1e7l554+QDhj9mIXJ9Bp7/to+zi3leCwM4QQIU7oSgTK2y3JnMn4udThNRSEOFnBiCzLpkFeeA2HwwNPCZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+eztTKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA42DC32781;
	Thu,  8 Aug 2024 03:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723088429;
	bh=DqibG60X2xK/4jEwte3Q1mAW4ZejbXnY8CJwiBzXhy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C+eztTKqHXQU2XAZlvRr2I60lKLfb0/PxIH5VyPVVlY4i0Cck8NM2CM6+7g8O0e1r
	 6cMF552VRSte/oQ/WmRuMHz6EUCdbn16HvoaFmCRNjO9TMXoRA9ABfM7Geuol3tRuU
	 sVoCQ/AaTncjYVCQ6S93vC88rbqWPHnvSEZ1kfGbCJ72QhndJ7v/tBikDkFMB3CX94
	 uY+2fKsgn7cFOj9FZuab76RFqKipk4mzZRjT5t6qdbnh1kFxHbgAqqtHLonqT5iuGW
	 hM7UurJTLttHh+Npa7fGtNA/3LJqcd+I8NuIFPDDvUGN8T6QxRBFtKT2fTXr1tL903
	 iJipVpMBt4GOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADCB3822D3B;
	Thu,  8 Aug 2024 03:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-07-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172308842863.2761812.8638817331652488290.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 03:40:28 +0000
References: <20240807210103.142483-1-luiz.dentz@gmail.com>
In-Reply-To: <20240807210103.142483-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Aug 2024 17:01:03 -0400 you wrote:
> The following changes since commit 1ca645a2f74a4290527ae27130c8611391b07dbf:
> 
>   net: usb: qmi_wwan: add MeiG Smart SRM825L (2024-08-06 19:35:08 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-08-07
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-07-26
    https://git.kernel.org/netdev/net/c/b928e7d19dfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



