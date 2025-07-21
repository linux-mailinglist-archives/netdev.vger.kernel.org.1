Return-Path: <netdev+bounces-208537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D710CB0C0AC
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C204B16658F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD528D841;
	Mon, 21 Jul 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXIs09SE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD3C5579E;
	Mon, 21 Jul 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091387; cv=none; b=ui2vUOs/JmcJX1mz6y7X23YIqBdMC6pLgBo/mc5g9Tqm7mb0msh2Mk1zvgG8/oUF4ctnary34DxNjF5cdykjYwpPOqvoMcp0DN6r+NFVndRBzN2ILM3gmd+aHTjVSDB9FoGzOJMj2ou7IP68e/horhtiwc+vHHe67qT9Zd60m5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091387; c=relaxed/simple;
	bh=Q38v6aY+FokTWJGa+hakCqfR9CY7WHzyzp3v3NxqYfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aUi/EKO9MzxIM75TzUCbiT31ib5dIcqi/jcKpphvf+PcI3in0dmGNfjaiFlLGo4yKvTs7b4uFlQeEa1fxtW/4kG8pkREIM9vW1gfOYcxQ1L+MJIvDvrlxUJ6StoLZZ8d47VKLJxzonnYs2UouiuUHvi7wQw4B5t1svPuK2aPTYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXIs09SE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D09C4CEF5;
	Mon, 21 Jul 2025 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753091387;
	bh=Q38v6aY+FokTWJGa+hakCqfR9CY7WHzyzp3v3NxqYfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WXIs09SEydGeWXiTs+Wg1pMe0tgkm3NbZgNz6N2IIUOyS6N0REN/h3TL+lRo9U8Ws
	 mON3Oayu2BPRynVukzngyJcadnBNUdvzWvSUcF/We0xN8ZDJLSNPFl8E8Rens+IdmG
	 oKBo+aA7hC67+TPzUKTlVwXTjSlOAlsm80V+d4Ak2YvQIMvOMPb1wA57hCzfxjdqsu
	 vDLhscRQIBIKAIl5J9SelSKlZoMG72Xjt9UXbaGOazjb7dbv+aDmJpSXZK1sijIIwd
	 oVMg9E5qi53UYfMFZnAYvHe9+4yOsQU0uoigK+EJat3A+eocu9snq6fPU33xm0uCu5
	 aI0Yn83IRr1Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB5383BF4E;
	Mon, 21 Jul 2025 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: Remove duplicate assignments for
 net->pcpu_stat_type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175309140626.4174808.4938048621331802399.git-patchwork-notify@kernel.org>
Date: Mon, 21 Jul 2025 09:50:06 +0000
References: <20250716001524.168110-2-qiang.zhang@linux.dev>
In-Reply-To: <20250716001524.168110-2-qiang.zhang@linux.dev>
To: Zqiang <qiang.zhang@linux.dev>
Cc: oneukum@suse.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 16 Jul 2025 08:15:24 +0800 you wrote:
> This commit remove duplicate assignments for net->pcpu_stat_type
> in usbnet_probe().
> 
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> ---
>  drivers/net/usb/usbnet.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - net: usb: Remove duplicate assignments for net->pcpu_stat_type
    https://git.kernel.org/netdev/net-next/c/dd500e4aecf2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



