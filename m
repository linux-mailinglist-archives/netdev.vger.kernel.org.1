Return-Path: <netdev+bounces-188191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C6AAAB84D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251301C40B8A
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A6572604;
	Tue,  6 May 2025 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fle8Mopk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6D72600;
	Tue,  6 May 2025 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489651; cv=none; b=URkV1JbjkrO8LEO4GVYG9hwInJHYZaxTXelfXjIlv+UVocIMcYpopXiHvNi5wmDXgavQvAgrL2xxymf/4HEV2fyHWUMegzI14MI4OeELIvrk2qKFrPEMGXyU2goyBEF1UNR0NFp6ANLTU+LQInH5OoJ9gx01PG3jUdzLJ187RWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489651; c=relaxed/simple;
	bh=CkfsacEolnjo/HZAPOJ4dxJVs/k8AtJvzPKPK+4rwaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ul/w9IJ05+sPa3dLUUxBWwWhxTE4O8nr8YvQyYIBlqOa0kbjqs7VHRkaGr3QMkGMvlk8Yf3sSx5PWfRp5V5jEUt7zxJ2vBzTCLsQ2unYodkh9NrIeDdFmwSc1bYP+WWZOWlXu9yoViy2sKnKCC2HdTbItad0lXMFg+K6BdP3keI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fle8Mopk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3CEC4CEE4;
	Tue,  6 May 2025 00:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489649;
	bh=CkfsacEolnjo/HZAPOJ4dxJVs/k8AtJvzPKPK+4rwaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fle8Mopk5gqiowF3k15xLp5/GqSuOsRf/mOtC2b4iNYPnS6qJeN1IBDUQ2ouuoxeK
	 wO7Ubj9gnb7C8F6eUP+HuUkza+MPIKjmUPZpTbFIKc8e17Dmg3nuieUh92+QiDE2hk
	 PN/X37BZx/hw4jcaOsms7YllchWsPYoLk/5qVj55chZpRY0YrE6B8wyDPoHdFAjMne
	 XNaKUH+3Bl86trj+YtECNd58uhve1WINvbM7cT0UHtzSIOVIJdmdCIZNL09KKQh0Rh
	 ViuJznNoX5t0CJ80gsid39Rjboqz0VNSEMAq3HE8otv/zcbYapWARzBcEqu8iLjHWf
	 79cjL6kI4qL8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AD3380CFD9;
	Tue,  6 May 2025 00:01:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: phy: Refactor fwnode_get_phy_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648968873.970984.17480879159715455659.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 00:01:28 +0000
References: <20250430143802.3714405-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250430143802.3714405-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: hkallweit1@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Apr 2025 17:38:02 +0300 you wrote:
> Refactor to check if the fwnode we got is correct and return if so,
> otherwise do additional checks. Using same pattern in all conditionals
> makes it slightly easier to read and understand.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/phy/phy_device.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: phy: Refactor fwnode_get_phy_node()
    https://git.kernel.org/netdev/net-next/c/1f586017f517

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



