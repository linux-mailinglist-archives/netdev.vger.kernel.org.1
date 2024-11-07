Return-Path: <netdev+bounces-142604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874429BFC39
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA81B20B85
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B9D1D7998;
	Thu,  7 Nov 2024 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edgyd72k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21391D6DDA;
	Thu,  7 Nov 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944830; cv=none; b=Mb9GHVRz9DMYfOMrJZi9ccWAH1gEcBQdfqTUTRRHUa7ePuW+8b5sUryVZQ6rttrOmrbrgXUdEPtqxS3Qqzs7FhbdjxtQPhACGmQaxQLQQO4D7f3oFaDDsUTqSlGM5tGOHAFibdP0S9fftxKfvGG04d5iVaQ6ooNJzlhYpj1IMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944830; c=relaxed/simple;
	bh=suI3XWLmTzVhY5fFAttLLgW5p99l4dCslb9Rfr3dJVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QwfPu3ibXwfJvms8SGuHIDZ4rzie4kJN557aiOFPOUKBBWOwX4l21XI1SdafiVKwhpNFHZglIj+MSvQWxCqYiKxCu7YMr8FcRaVy2lR6PenS9XJtYllhoJlzSs5k773jg7BxoHyD/NK73EeAdiS67iWlwM5+ET9NuPqOnadEfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edgyd72k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF6DC4CEC6;
	Thu,  7 Nov 2024 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944829;
	bh=suI3XWLmTzVhY5fFAttLLgW5p99l4dCslb9Rfr3dJVY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=edgyd72ktj7OygPUtVnH5hbl6WphzvoMr5zaS+VELi9RMIXxtdltDVf3dUz7rTRSR
	 NLcGMrwVeLvVKaxncLJ8DwsbjJ0g565L5/du4NkM60gabfGU9HRcjl2i598jNbLEII
	 FKrYgTWKfvWLDIt5vfRVHPGzafHD54S/j62qUhYJNqnnNuh1uU2viOO5jRA1tu/+lg
	 HcyMN8YP15AkmN+CMH2UwVI4A1H9dqI/rc7ATZveGr8MWRct3Fw21arJFkS0EJxEGt
	 KGXhLQjsm+oRk9dCdAf0Nb5+VwJU9NApUWRtohLjDP/9DuE4jD15CIEG+byljl5t28
	 CVsOrVxC5xtAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE1C23809A80;
	Thu,  7 Nov 2024 02:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] bnxt_en: ethtool: Improve wildcard l4proto on
 ip4/ip6 ntuple rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173094483824.1489169.3032891223925266977.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 02:00:38 +0000
References: <cover.1730778566.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1730778566.git.dxu@dxuuu.xyz>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 michael.chan@broadcom.com, kuba@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Nov 2024 21:13:18 -0700 you wrote:
> This patchset improves wildcarding over l4proto on ip4 and ip6 nutple
> rules. Previous support required setting l4proto explicitly to 0xFF if
> you wanted wildcard, which ethtool (naturally) did not do. For example,
> this command would fail with -EOPNOSUPP:
> 
>     ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] bnxt_en: ethtool: Remove ip4/ip6 ntuple support for IPPROTO_RAW
    https://git.kernel.org/netdev/net-next/c/050eb2cebb9e
  - [net-next,v3,2/2] bnxt_en: ethtool: Support unset l4proto on ip4/ip6 ntuple rules
    https://git.kernel.org/netdev/net-next/c/5f143efd3804

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



