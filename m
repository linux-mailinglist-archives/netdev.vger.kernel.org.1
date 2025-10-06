Return-Path: <netdev+bounces-228000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C51BBEF19
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D809D4F0CE8
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A092D77FA;
	Mon,  6 Oct 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWbRb0bn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA027FB05;
	Mon,  6 Oct 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759774816; cv=none; b=W+RnP17EsqAOg3ool98QH8/KPh8SS8KWtsWx0SF+EopHj5U+2x717b0/AN6fjCWXxKKicgVT/vZDWizG3+q5aakyVXn7KwLX6rQa2rIjalktYHvraPBG59e2ZzIEgIiwupI3KOdV84FGyTTQvryC5aycQ390lSmVNPuI5dDrFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759774816; c=relaxed/simple;
	bh=W5BrOOPRRKzFIbtAk/yy2aIvw1AczkIB0liTrN13Hkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L4KKDQn2FU2LvCROY9hRlPl+5jviDsXWXxCqxZWsJYnaJhU8f3/YQ+B1fw9LxPslqWYDJd6M6VjM3QO44j3Mv4XgrHsEvMDt7dcLyGJN7/9k5uj2SlBt4AZYLBWyrk+i60cYo5uYdxIgu5nJPM+ux8TRP86m4NQKigCR/YS7YOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWbRb0bn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A112C4CEF5;
	Mon,  6 Oct 2025 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759774815;
	bh=W5BrOOPRRKzFIbtAk/yy2aIvw1AczkIB0liTrN13Hkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gWbRb0bnAs36W8jphHw0cdPVlU7iYFKVAPzNydI1oVrmdLhFNnf2FtgIH2nRIgZkx
	 Lp53MCJleXtHytE+tkqwt5OROIUSeEI1+rtzXaBrdwlz50Oi+g3m4oAS78YQcZiTV/
	 8je7I3PIT7atYggbs/ZPTR4UFplY49ifeLchKC1L/+pu3RFnp64pe8eBB1AXsavctb
	 d4P0mAperyBBfgUu49w08yspROo62L8K48uWQ7SEo0T2wznF2N3eSMZHOiTPfmh66T
	 +EzblvErwCd8NE0XNE8nRfE6MoxTjfjwfDk9k5GONaUnogbXHj3aeSWJJSV0xpogw7
	 79QGxOvMwIYRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F8639D0C1A;
	Mon,  6 Oct 2025 18:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: t7xx: add support for HP DRMR-H01
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175977480526.1504508.15952755336365237817.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 18:20:05 +0000
References: <20251002024841.5979-1-sammy.hsu@wnc.com.tw>
In-Reply-To: <20251002024841.5979-1-sammy.hsu@wnc.com.tw>
To: SAMMY HSU <zelda3121@gmail.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, ricardo.martinez@linux.intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sammy.hsu@wnc.com.tw

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Oct 2025 10:48:41 +0800 you wrote:
> add support for HP DRMR-H01 (0x03f0, 0x09c8)
> 
> Signed-off-by: Sammy Hsu <sammy.hsu@wnc.com.tw>
> ---
>  drivers/net/wwan/t7xx/t7xx_pci.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - net: wwan: t7xx: add support for HP DRMR-H01
    https://git.kernel.org/netdev/net/c/370e98728bda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



