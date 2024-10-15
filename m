Return-Path: <netdev+bounces-135800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D380999F3BB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11A8A1C215A0
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B651F76CF;
	Tue, 15 Oct 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtBi+PAz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BA1F76BA
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012234; cv=none; b=Qw5C2heH4Qa3f/i9pxSwkqd/Txk5nHpUzOjgyzic6LzfpeDLYzqpKgaYqW7BJ3aQ4qQ6W8/jxH1x3FzkjOGwI5iiMVcgv4Tl78e72KZh4/6bQR9wggTlm4yZGFp+uJlAUTviccm2ZPXoZShIhy8ZgqJy9rnk2CP3b8EhccVVaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012234; c=relaxed/simple;
	bh=jK+UohJxLuIk48WbZMpUliCXxqKAiRUrE9MC0InD/r0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gsFK/CovVI1mcW9LRPr9MBTqt9WJjnFr2xaxJlfKWek+2SjxS6ZKNu2CHBMqvY1e9UXe9Y+aQyguzlAcvhHegVpsdb5WDJIs+ePOEuJCwU61CuvLJ01fquDkrweah+XLryOP5ByXYO5rU9r2kknNm4y3CBPpoPibhgO/F/94Xno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtBi+PAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB7CC4CEC6;
	Tue, 15 Oct 2024 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012234;
	bh=jK+UohJxLuIk48WbZMpUliCXxqKAiRUrE9MC0InD/r0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qtBi+PAz0mo40r3E/9D1gY7L/DMtAlJkbXM8yyloh8OSkITxk/C2B7sF/ZkO0v7dZ
	 2yVSMmoFeOPeKXnzoy4TO3Q0h3UFr/2WdGXoT8oioJ+APshnbNGwxLRe5OjI+rSF2k
	 anS//R7/x5rSW3OOjazXWfNKT1sTWfGnOYUDzUiOzDyZz+MImZyP7Rr4oiNXWXIVZ/
	 EZOiqJdM70oL2f03jcGWYVcn4usl2bySmQ0ZOxTqST6tzoFJIxJFR0Ld0YAao0/lU1
	 M0bkajF3uVSLvtGUkP897lGVDSCCnB+jNVexbTJgNW2+7Za93sXBcMir0sg5wxU96N
	 wRiKQ3vBQhcZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E5E3809A8A;
	Tue, 15 Oct 2024 17:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: Implement BQL support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901223901.1230547.8692511851110957359.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 17:10:39 +0000
References: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
In-Reply-To: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, upstream@airoha.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Oct 2024 11:01:11 +0200 you wrote:
> Introduce BQL support in the airoha_eth driver reporting to the kernel
> info about tx hw DMA queues in order to avoid bufferbloat and keep the
> latency small.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - simplify BQL support and rebase on top of net-next main
> - Link to v1: https://lore.kernel.org/r/20240930-en7581-bql-v1-1-064cdd570068@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: Implement BQL support
    https://git.kernel.org/netdev/net-next/c/1d304174106c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



