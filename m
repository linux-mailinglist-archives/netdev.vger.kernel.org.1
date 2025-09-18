Return-Path: <netdev+bounces-224479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3559B8569E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643467B6F2B
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71DC30FF27;
	Thu, 18 Sep 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJbiwCTR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289F30FC35
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207619; cv=none; b=baN24WDnb1HYptly8MqhAnL5Utjx/J5XtWtOejp/c21QnhOlaxBXh101AOCdYg91H7V80LaGdlFVYAiiF+0cuIjSCaGeVpAkEPffdp90rTBvBRI5ndlh6tXNTlNy3Zy4euNMJ/pP/0s7ihACSxVS14cMCwCS7d4POsvPNdZWOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207619; c=relaxed/simple;
	bh=XSe4qL04EKcEFh2WeaBDGLaJzlB5IrgJJOOAs9vzvLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hN7owS+pduPiuezmFthv9G/zXv/kXYusRPGT098RKtmApxPqr0F54aZ9gMyiXGl1aY1qQS9kcG4YKkveHt/SDausYfmMIV3Ax2rm5BpIJV+FWELRb/Hscvv38lrs28I/wBY4KuNZOmsLkuEyh5nzJFtfbv8+2mKQJrplZR00yMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJbiwCTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAD5C4CEFB;
	Thu, 18 Sep 2025 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758207619;
	bh=XSe4qL04EKcEFh2WeaBDGLaJzlB5IrgJJOOAs9vzvLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cJbiwCTRfGTDFduHJv2uJzSE427h++UzJxuf/xDaayrEzLOg6Ka+MbRl4Wn4R6Zr8
	 PEUMTDdC37TnVYSk3/5/HC7m8owYCilvpA7fbpzEN9wTX54xIDDLJ7zOws0ipiEFoa
	 qD64dR5JM9qqSbdXW+2FSJOTsCJEUHxsUi8oweC0Gr2TOrc0Rc8txYAWhbWvwzdeRs
	 pXlztZknnfyGli5G5GqWAu43v6T3wYfK70Kh7idHIXwKfHBrPY5huu0yAnhMsZEU9x
	 4Tfd9C7zYUxQU0d/IWSfJdtDAyUlNlVqPlHWB+sxo7ZG7tNLvrfNYHGcQes0Xb/dH6
	 nr13RkB+5aEOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7140439D0C28;
	Thu, 18 Sep 2025 15:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: update sundance entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175820761899.2450229.16093608382045318401.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 15:00:18 +0000
References: <20250918091556.11800-1-kirjanov@gmail.com>
In-Reply-To: <20250918091556.11800-1-kirjanov@gmail.com>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, dsterba@suse.cz

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 12:15:56 +0300 you wrote:
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - MAINTAINERS: update sundance entry
    https://git.kernel.org/netdev/net/c/7736aff47041

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



