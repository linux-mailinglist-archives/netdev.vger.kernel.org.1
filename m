Return-Path: <netdev+bounces-226798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A573DBA5388
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5B4D1C05CE8
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9261298987;
	Fri, 26 Sep 2025 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMq7exxK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8E928D8D1;
	Fri, 26 Sep 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922217; cv=none; b=pIK2DzR2oRcM5Wm2J2+uDIQoEsQpcoL7+3roFERfNeR5sj4aWjmw73Rj6WKxlaxj64oC13ISwLtSuSpfP7qLnn2fv7K9UuRpgXlkxfZY7ZK2YrId2ezUQF6GY1v6qS599WWxK9T6AEgqyTDAJt/ZX8e8r4ZORdprukdHXOTyE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922217; c=relaxed/simple;
	bh=4CQbm/dSBZESDr1KnSOF86lrnLhJKq9dRZEoa+hqPsU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FqC5uvx21SbVBH65z95u+0mMPm10lpezFvVEJw31WrDppERv7/9c+PcFWAgOH4+e5OkFtmnVnu8jj6Gnu3foTT6ifItWcrllegK2KrXhHpiVjZ1TFJBC21jmCBo2z+2wca02E10F5DuuVcTt27iOqZ8zdMwaI8iwQgvAWAFRJcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMq7exxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3EBC113CF;
	Fri, 26 Sep 2025 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758922214;
	bh=4CQbm/dSBZESDr1KnSOF86lrnLhJKq9dRZEoa+hqPsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KMq7exxKjArbB9sE83i3fqHNfwwQs97I6daBELYT3mzueUgWogKsmwmSoLt9WzKLg
	 +SIY7X9Yo6IGlhLLvX8ev8SMgG0KPnPjpjQAT+VsVkvnel46ryeWlmODdaPArjaqu8
	 Lqt4dmSipMRv2EU1WVLbP+Z7S3k05zx6PI/sJNuHt+xj5lr+YLwnhzue456bEbdyAu
	 9QxUX9IkLgfyapW4Ulmi+4sTEp/VVC0MxaNSU/ayp6X9ansgySgBEFjBlvzxghZ6PY
	 1MOp/ih8U+kVo+G/I7zH2pbBZnFMOMP6i59oumdJ37I/7oRSi0ugjro8IAX7QXTOrx
	 A9ouyLDZLhHPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C0D39D0C3F;
	Fri, 26 Sep 2025 21:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] psp: Expand PSP acronym in INET_PSP help description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892220924.64518.3812772280435646061.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 21:30:09 +0000
References: 
 <ae13c3ed7f80e604b8ae1561437a67b73549e599.1758784164.git.geert+renesas@glider.be>
In-Reply-To: 
 <ae13c3ed7f80e604b8ae1561437a67b73549e599.1758784164.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 09:09:50 +0200 you wrote:
> People not very intimate with PSP may not know the meaning of this
> recursive acronym.  Hence replace the half-explanatory "PSP protocol" in
> the help description by the full expansion, like is done in the linked
> PSP Architecture Specification document.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [...]

Here is the summary with links:
  - psp: Expand PSP acronym in INET_PSP help description
    https://git.kernel.org/netdev/net-next/c/6c85fb5486c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



