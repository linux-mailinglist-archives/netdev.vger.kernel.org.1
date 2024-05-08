Return-Path: <netdev+bounces-94347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431078BF3D5
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 02:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EB01C23691
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 00:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60AC399;
	Wed,  8 May 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVxckFOG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F314624
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715129429; cv=none; b=F4Juh0HPS1Ct3z2EqBRk1qu3IqquGu8Tf5LGGCQ0PaFlCcoe4lk/ewH2UxEjYq2+rpg3gMmx0lZp3zyPkxQXK1C50sF3Gm3vXloXzzsQ+5U+pWEo7t16dEXtMtH4BW7QbfuNQewqtNkfsEaLGjpJWyXnUOIEXejd53YbT6Y5x2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715129429; c=relaxed/simple;
	bh=yYviayjO6zSqwScGJnejGV9LYw8GPG8BieWtdhmb3wc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ar/aDbCbC+fYfZLZlBu9vek/a+tyQ6P9LAfKtADjK8PzmHayCHRZfNZvRnX1WUQ3BwZ/ajvg5AYfV7paLbTwa760D4ElCmWEEPAWx+VkPVJdleR1dbiBrvRJLtW1uep4eAUIesPj4OgSZ4DPdRq3OYUBJ3SDgI+kcearM5oK9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVxckFOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E01CC4AF63;
	Wed,  8 May 2024 00:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715129429;
	bh=yYviayjO6zSqwScGJnejGV9LYw8GPG8BieWtdhmb3wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FVxckFOGm+Vt7x3UzHALRy9XiR2EPigEC5h+nOQWtto2sSCFnllk89GitsS7uFgG+
	 BIRtkk4ufasmhaLayKby+MaOS3m0eYY0AN+Of5OcdmGE5yFOhS/ZicJrVw2QXfk/kw
	 ZPxUUS1QDUrWCYcY6KW4GEZ6RK+YN/a41AMffYw15ms7RxW4dMS8LxKNUUfwZFS0bG
	 pcbvPYqwvxA7HVxkL2hT9adwyBOzCjo3XbbAIC+Lc5WAua1xQ4MkuGlWvkb6bSXKe8
	 3KvxJ2yDhPaBiIaMbwll0n0opan3pUFVzJJ+cEgfqHyFBGc+57UOnzD1A46cT5Mkxf
	 LOg4ebmWIcp8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED47EC43617;
	Wed,  8 May 2024 00:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: smsc75xx: stop lying about skb->truesize
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512942896.28907.15415634524088475553.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 00:50:28 +0000
References: <20240506142358.3657918-1-edumazet@google.com>
In-Reply-To: <20240506142358.3657918-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, steve.glendinning@shawell.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 May 2024 14:23:58 +0000 you wrote:
> Some usb drivers try to set small skb->truesize and break
> core networking stacks.
> 
> In this patch, I removed one of the skb->truesize override.
> 
> I also replaced one skb_clone() by an allocation of a fresh
> and small skb, to get minimally sized skbs, like we did
> in commit 1e2c61172342 ("net: cdc_ncm: reduce skb truesize
> in rx path") and 4ce62d5b2f7a ("net: usb: ax88179_178a:
> stop lying about skb->truesize")
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: smsc75xx: stop lying about skb->truesize
    https://git.kernel.org/netdev/net-next/c/1b3b2d9e772b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



