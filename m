Return-Path: <netdev+bounces-162933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE30A287B0
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960807A85B5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D059022ACFD;
	Wed,  5 Feb 2025 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGdwxwCy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE621A44A
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738750208; cv=none; b=l2sszvXplOiRT7nYOKw75skxPQbwDQG68k+aRXhkDD8F23CuBlhvqcTHMMsQu7T/LfjJlzu66c8IPQSpM6IvYVPQ9PaXudr8AaSDi6lsC3Gqsoaug8qPF1YxUa2XxnHBxUF/T6JARtKbql1l+FhYl1+/fOlkE6bexxVIdpqODvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738750208; c=relaxed/simple;
	bh=cP+nh8SfR6zxsjYrypZYKabl72wCpsgUBXbfLTT2U1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l9CK8nzq+IHl47fCl9a9oyYvuMb+pIkCpKz2hA+llxkYmK+ypMzylK9IbG/lzmlb652PR/TytdKG4iAMA5cnrgf5XXn/Xa6DjAu+sXSPfezWsZgXDuYIKQnLokV2ZaVEG863EIq7O3mu4hGe1WRrr0gcGNmS2Yrr2d9RWflqklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGdwxwCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192EEC4CED1;
	Wed,  5 Feb 2025 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738750208;
	bh=cP+nh8SfR6zxsjYrypZYKabl72wCpsgUBXbfLTT2U1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EGdwxwCyFdL2yoMcQcGHCS/beD8K63Y8P83AYbA3We4l5ar6kxYM8CIUoJLhLD8qD
	 cGQSUjvq4dY1nNLjaXtklEYyOZnD6mDA5ejjBxKkATGk1EPYzLODXMzSTfCWN9EGLF
	 WdZzLSlmUtCjOhOp4ZNjO/6J+iZbzD4X4tT+dK0ggV4i/sL22HkiMINxgLMrPsp069
	 TokA7HLyBHFqRDCICSSm1B+VIRxKovwvEQr29W8wF7VV4ZXFGodxcd1z0yzmPa9uti
	 bwy/6TH0l3D0JnfuqLKee6yieSvisIJinLta+A/8IwUl1Lwgh9/Dny+X6ZZcqpobSo
	 Ybkg6siGtD9Fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3C9380AAD0;
	Wed,  5 Feb 2025 10:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: use string choices helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173875023527.701693.2771806850516376864.git-patchwork-notify@kernel.org>
Date: Wed, 05 Feb 2025 10:10:35 +0000
References: <d01c4b60-7218-4c40-875e-c0cace910943@gmail.com>
In-Reply-To: <d01c4b60-7218-4c40-875e-c0cace910943@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 3 Feb 2025 21:41:36 +0100 you wrote:
> Use string choices helpers to simplify the code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501190707.qQS8PGHW-lkp@intel.com/
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: realtek: use string choices helpers
    https://git.kernel.org/netdev/net-next/c/0bea93fdbaf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



