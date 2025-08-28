Return-Path: <netdev+bounces-217557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C4AB390D0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 03:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C680E189EAD3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D791DF258;
	Thu, 28 Aug 2025 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghKuZKVm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37991DED40;
	Thu, 28 Aug 2025 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756343404; cv=none; b=WRLEjyGfytbD9dugWj/qotnrVhr8tAnuPWxji/S44nc5GPO0MyWf4p/29DT3aXlTh5vvBmoaV7SfEc1xBcYY5XMT9tZ7Hpa/3/Y5yDApu+PAuo8UHSPBXMnmSuTJ8JmZ+mFgtnKztdbVp/QgnoyQpliui7yehHvfwIDtkgAW4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756343404; c=relaxed/simple;
	bh=9epErMzKwEF73B1z1uZQqR7IOWewVgK6nclV/VwLCFI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VIcXqrw9SUGpRmd+K74Sy6DI/2HkiuZkBJmbiEMTE1MHK3hiAvZfcL7WdKad/tk3GIMTSh8T1tjZ3Nv6RbkE27VIqzfvrBmQ9f+WwcGslddjfKY2g4wji/Xpu3wSUJOhUdv2YhW4Xeu3no7EX8Jojd8lo4nNluL+kUen0Ri1ElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghKuZKVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C290C4CEF9;
	Thu, 28 Aug 2025 01:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756343403;
	bh=9epErMzKwEF73B1z1uZQqR7IOWewVgK6nclV/VwLCFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ghKuZKVmA0U7YggCEOOsk05ZzrFAIuXRHH5nsZqvUDwLBYJUZalyLvsU7goP3Zw1l
	 siY2/wYGtd5vJZ/cBOFL3rj34TbPSy98XtR5aGA1iEC7f0lOMKEbNCzEWM6vwzkUYt
	 SPOANcU9iKoOmkHbqw3WPZnOyZzT/PA6f/d/NiX08c6NFbNKjkRnCpqjXwj0YwDH/n
	 lSORYyoCg76RsWZLK0CvRfoAUvGgFe1k05Z4bGz6TTVONDfW/2EHc72NUoMQc1RyYs
	 WyMiUPebc3ilr6X8ETrOHeoykfI6wr1vj2A0cBQ+eT6gMPWk69i1clAW1tYm66f+23
	 a/jDkW0wpY4LA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD79383BF77;
	Thu, 28 Aug 2025 01:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] amd-xgbe: Use int type to store negative error codes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634341072.896460.8805791812563148479.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 01:10:10 +0000
References: <20250826142159.525059-1-rongqianfeng@vivo.com>
In-Reply-To: <20250826142159.525059-1-rongqianfeng@vivo.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Aug 2025 22:21:59 +0800 you wrote:
> Use int instead of unsigned int for the 'ret' variable to store return
> values from functions that either return zero on success or negative error
> codes on failure.  Storing negative error codes in an unsigned int causes
> no runtime issues, but it's ugly as pants,  Change 'ret' from unsigned int
> to int type - this change has no runtime impact.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> 
> [...]

Here is the summary with links:
  - amd-xgbe: Use int type to store negative error codes
    https://git.kernel.org/netdev/net-next/c/a6bac1822931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



