Return-Path: <netdev+bounces-153568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FC69F8A94
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435007A1322
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22C378F26;
	Fri, 20 Dec 2024 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q75eMiRR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726ED7083F;
	Fri, 20 Dec 2024 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665415; cv=none; b=JLcOC0wVTFCTmGn9C5A4U9TAqMsHQ9EKP8hy7NG0QmLPLwnIZdOvAILutRU4HjTZwmR123g4RkB2OUNwtCa8eTmjLHNsWRP5gtvnLUjXGxxW0kNn2XeyjR3AW+GM9isINOWC2VZ31ajtYnKfUj3E4nHfyiWUYm4YMXOwqRPPLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665415; c=relaxed/simple;
	bh=rVkvLtbIfEEDfTpqjYR7xdylntTYtBuhIt+y8QkcHcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CsmHBUvz+HQJJLbFZyFIcYLjOlJ2gRd75UHV+7btAUkyM6BGDS+4p6fmBa0UVjiOJONZyUy4JH7DZDuelvGjY89LVPWMlu1MNRTp6yJHsNJJ6Nj6zVNgUMJVsXCl9dt5/6y9JIyK1oOUFgym4o0vXEKZcYGU2IPv5DGSCZelqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q75eMiRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37B2C4CECE;
	Fri, 20 Dec 2024 03:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734665415;
	bh=rVkvLtbIfEEDfTpqjYR7xdylntTYtBuhIt+y8QkcHcM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q75eMiRR+KUXp+KZkFgzom9pJ5Qvo721/RM2le/1sWrFX7hVx9yZ9zenxc/5wQFxF
	 Qlbm/hgrBmS2PhlIlG/p1sccg2am/tkI27Ny8Htcjkwe5wf2eSQovxl3FAZexFJjQv
	 dyGSyS1kQveW/SufPM7rTfLqLMSorTdT82C9k6ccGoaCPRkSGKZx6Q8xP96oqfvpqu
	 /uIIQzlFbdFzF0G1+r6XqykvvCIHa/Z76KBGI1h0vFuwxUlE9QKTFE2t2ADh4POWAC
	 qEF9ut9rIKP7im/eo4ysCZ/CMJ6ag3cAlum01+YO0+snqQ5zS79nhJuW7WzHuSzt+Y
	 2oztR8skfR+Ag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE353806656;
	Fri, 20 Dec 2024 03:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] af_unix: Add a prompt to CONFIG_AF_UNIX_OOB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466543277.2462446.7737088595496502937.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 03:30:32 +0000
References: <20241218143334.1507465-1-revest@chromium.org>
In-Reply-To: <20241218143334.1507465-1-revest@chromium.org>
To: Florent Revest <revest@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@amazon.com, rao.shoaib@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Dec 2024 15:33:34 +0100 you wrote:
> This makes it possible to disable the MSG_OOB support in .config.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  net/unix/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] af_unix: Add a prompt to CONFIG_AF_UNIX_OOB
    https://git.kernel.org/netdev/net-next/c/5155cbcdbf03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



