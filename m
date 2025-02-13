Return-Path: <netdev+bounces-166217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D6A350AD
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157B01890BFA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0B200132;
	Thu, 13 Feb 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMNEh3cL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF08269829;
	Thu, 13 Feb 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483280; cv=none; b=ESBG8cvnbxhO6lDtLPxKccfUVybq2lvPMuAITaOJcyYrUYHuMzdOW7le2et7m2bi+RlOpgolUut6vJt3TQMU1iJ/7g6MDy2jvuUmCP73Ym/Jmak7Yg8GKeKqbaAGpTPZSpgrx6pIDDApbJAwixobeg2bjCQr206ihEY2bMwhvxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483280; c=relaxed/simple;
	bh=ahDqWKBSM/FgTv4mXWtzfbcOL5LXWqkL8vxC5sdih9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QczpNSeJdxPR+8+9lqFuHsWDRTHQgX0FCDEmsVNst1KjGJYVpsZZVspxMjQ4F9HvYxnLEPrRym2vBT7XunNX3l27MoBVQGfA9g4wEzjoCS1R+16nNIAVr0LOZD8PwkxBXlWIYeXOiRBIvGThO+AY6ZuXPrrQ6bBebfD7V2DdOak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMNEh3cL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABA6C4CED1;
	Thu, 13 Feb 2025 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739483280;
	bh=ahDqWKBSM/FgTv4mXWtzfbcOL5LXWqkL8vxC5sdih9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lMNEh3cLGCVn8MQ7WGZ/zcnDnoLJOdnQS2wBZEerRLaogBgsZWwQtiNJBdzEURRq5
	 m4EfwYS97HTKW9G49+djrP5MAttxAxim4+RZJn8SjYxQR82iKHFu9Yz65kX3rhSqMr
	 cXk0bcZy9IqQl1aISx8yehl2VV0sYmhA61+PG5WPqBYqV/j793VfiiDwx5edVzm0re
	 O3x+tHKX8Hgbu5jvDwO8eCMbsbJAV1aCH1hhagM5omhqNAXZckqmmlhp71HqHNwEbc
	 JtsgvF5tU9LfNSkBXL1J/xiKhGD5qeowW7cLTJ7dQhh9DPbBPAZodUq5SCuGK2wavh
	 yfcWOFPjE/r0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71EF6380CEF1;
	Thu, 13 Feb 2025 21:48:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2025-01-15
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173948330900.1382183.11698192681233952381.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 21:48:29 +0000
References: <20250117213203.3921910-1-luiz.dentz@gmail.com>
In-Reply-To: <20250117213203.3921910-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
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
    https://git.kernel.org/bluetooth/bluetooth-next/c/1a280c54fd98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



