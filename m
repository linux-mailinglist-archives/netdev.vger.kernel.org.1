Return-Path: <netdev+bounces-117166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0243C94CF3B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF083283F80
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB309192B80;
	Fri,  9 Aug 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO6XtF/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A91917CF;
	Fri,  9 Aug 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201832; cv=none; b=O2kw1Dm2glceqB5AkviDaoW49Fg4+x3hSL7EBdjMpiWhphzDIWrgVubpIcelb+1EN6n8TOWBHjgwYdfI+RSzZ3R+XG+QpRD/gbbUtt+g4/LrJ1zqPHLBE2f6PHUK7/r2TSM4dqbDDIzJT3Fcmg9YkoOVS4xFbNPOVB9ZWFtxHHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201832; c=relaxed/simple;
	bh=l+3NLc6kLreqqAvPUhcN8qRCiIyeWgectbDCMIcPw14=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iMNyScsWED+HUpMsrVeEj0uBUYwTsOO4pXpRwyGJ0C4adXh1BbRKgW2JNzfitNrlnZ8qD1CQ//RwHt86cUbBMdnnZBpHfKNhC+AD18Kbe+fTMKixSEje4KlT0Hc/SIZ9KC+KFL0/jFWnzcyo0iC+X8WaUI20LxZKTAGrcY//IEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO6XtF/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70B9C32786;
	Fri,  9 Aug 2024 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723201830;
	bh=l+3NLc6kLreqqAvPUhcN8qRCiIyeWgectbDCMIcPw14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HO6XtF/WzAXOvxuZSDVueWUBGVWxdJOFf9fxI3JZuMtwHjP5Zj4EGlVwb+6vfoA0l
	 wkbuoQWhnh0WgEzXy/JTcAqCuDGpmXUbXLLQirbIZCH1WwRKLk3LdWsM/cmVUDUUNU
	 jE3RvZN7LF/0FODwa2KaCBGyxpzxlEJ0o2KTuXnSjE0xe4VjJ2qGo49V36D5kUssEC
	 7qudnEA0ogYlb2r4zSrLNCCkkZjqwzFEZZ8lkXSD74uupjnMQccrE/iwjBUJJJYMVp
	 yH6zPapqZC0WGv85EQ1GA6FTD6IeLE7RzelFxqwtjGjjvtTIyddh3hh+gVIfpd07bg
	 qkF9GQ0ZxAC6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF88382333D;
	Fri,  9 Aug 2024 11:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: vsc73xx: use defined values in phy
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172320182976.3757285.14869358103805735046.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 11:10:29 +0000
References: <20240805212322.1696789-1-paweldembicki@gmail.com>
In-Reply-To: <20240805212322.1696789-1-paweldembicki@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
 florian.fainelli@broadcom.com, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  5 Aug 2024 23:23:22 +0200 you wrote:
> This commit changes magic numbers in phy operations.
> Some shifted registers was replaced with bitfield macros.
> 
> No functional changes done.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: vsc73xx: use defined values in phy operations
    https://git.kernel.org/netdev/net-next/c/2524d6c28bdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



