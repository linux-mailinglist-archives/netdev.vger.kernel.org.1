Return-Path: <netdev+bounces-173131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E04A577EA
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B131897C04
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6032714EC5B;
	Sat,  8 Mar 2025 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUWsEbIc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D315687D;
	Sat,  8 Mar 2025 03:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405199; cv=none; b=ckTJshXfsUgOGVTyg4D62SiWTWf8VO7oXgp4yi5tL1WkRtKp+8P73y++T7M7mcGPh+IY6TQFtn6njAls7xLf/ixfaaXG7YhCORXRzTtUyRYHTu681+gwY5dakP1+2vyD7iZ4raRSJSJQQpO6gknr4Txy0XkZoLbaytiep1Jhwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405199; c=relaxed/simple;
	bh=kbsiYEqhNHYL0PjMtoxmZx8IcD1aWspghljh7seFO0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uJz6a1EGZ+GGiuXO3lJL1jr9OHtlywsIyurnC1rKJWx8YiBdAgoRxCuwxP0V35QvhUP9CQE2OjvpfTiA81xWniateJscN4A/qNkogwVWy7gSRqTtjMrP/NnNwpEFCi3gNd0DvNCRYQxKESEUk8MlH8fFxdiDh0QgYkLwndEKUDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUWsEbIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CD7C4CED1;
	Sat,  8 Mar 2025 03:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405198;
	bh=kbsiYEqhNHYL0PjMtoxmZx8IcD1aWspghljh7seFO0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NUWsEbIc0TBT3TXud3u3CB6sYpG1DzwcnYAzKEPXw3LBatiNtYlml2GAHE2NEX5MZ
	 F0wRlib45CEEBSLvdSvdUOJAW5Gv77gJupFMHAwF2/0IgPzGoDI/SdSFRrFmvQT+Gv
	 7986KyejM0/rdNvAuGDeZ8vILJ5CHj+sJKQAzSVScJJYTvu4en8BuB0CetmvBFrXkQ
	 Lxfh/ykp4r3hM4krH4ShjQcGCBg905taMHwOP2LI78OGXmXTZpyuw7NSWL5dGMwxDP
	 5rMWbZy6v2UaAejdeJZbVJxg3H6jcNMo+GuCvwGCo4Hlugao5QW2KGqvxd0K8ASiKk
	 ICDcvGk2q4hDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E4B380CFFB;
	Sat,  8 Mar 2025 03:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-03-07
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140523225.2565853.4200581465597427753.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:32 +0000
References: <20250307181854.99433-1-luiz.dentz@gmail.com>
In-Reply-To: <20250307181854.99433-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 13:18:54 -0500 you wrote:
> The following changes since commit fc14f9c02639dfbfe3529850eae23aef077939a6:
> 
>   Merge tag 'nf-25-03-06' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2025-03-06 17:58:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-03-07
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-03-07
    https://git.kernel.org/netdev/net/c/8ef0f2c01898

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



