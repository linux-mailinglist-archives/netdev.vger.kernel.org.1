Return-Path: <netdev+bounces-112001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39C9347A0
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A55FB21488
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB21E515;
	Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uw8tiJiy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024B1B86FE
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721280632; cv=none; b=aO0bkBPaPZFAqUSDXfdVIcwa7VZLFGD9B6P3U3G/fy8mjwTA+d9bmydSnQ9Aki5UH6ZtyjtY2RYaXHp6NvPN62WwixxVbkkuVdUSULKljIheI6SygZARctQLyqkRg9UopxERLRDan9bfpjYdoBpZCFR/ikpLWhOVrR/0/fOlOhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721280632; c=relaxed/simple;
	bh=9lUEuqjJcgmh3O/FvyN+BOkfzdonfVAsHWRIedYwAFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dbsyJk2RExjmDVP++vhaC4Boeetm5jHn/xwecfn2Vyjhs19NOCFkOKFyPp7eJPLV/AmM94yCd1ysnxTENAgCp/clUOuIH7Bs1IcJzm/TsfGvk8rveLD2On/dmwR5s4u3Hph6Xntsh+ss6g0CzUg/NgVqEC1mN9F94Bep+fsPEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uw8tiJiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BA79C4AF0B;
	Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721280632;
	bh=9lUEuqjJcgmh3O/FvyN+BOkfzdonfVAsHWRIedYwAFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uw8tiJiyAja6E7cdJLHDPZZr+JcQHikw9iqWz8yKg9WUp+5ziaGu7YlgKvg1cCc+c
	 lJPPlu618UL4huCAVrN0BN4SJenLsrH6EjuS+AJ9zb9tStsjAbqddhz45i9eTSrtq8
	 XP6Dbc7jqO5hrCxfYV3ao7YcdvsxHOAhTFyj7WgFGgCmDFCHSk+mvH/vN79zmORd4T
	 TWqS3wHO6tVd5gHDoPdIOGgkaNlYDikgLJU0S9IkFUcEVbEPeAYDmd2d6IAf+pfGAX
	 hpqI2/zWW/VneN1Iz38iFxQdtbpyN9/cgCZDC10+2rJWM6Xfksgq5OHjrIjSAMB/BI
	 JzSEOma4F+pXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36397C4333C;
	Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: fix error branch in airoha_dev_xmit and
 airoha_set_gdm_ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172128063221.29494.11281555068921208480.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 05:30:32 +0000
References: <b628871bc8ae4861b5e2ab4db90aaf373cbb7cee.1721203880.git.lorenzo@kernel.org>
In-Reply-To: <b628871bc8ae4861b5e2ab4db90aaf373cbb7cee.1721203880.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, angelogioacchino.delregno@collabora.com,
 lorenzo.bianconi83@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jul 2024 10:15:46 +0200 you wrote:
> Fix error case management in airoha_dev_xmit routine since we need to
> DMA unmap pending buffers starting from q->head.
> Moreover fix a typo in error case branch in airoha_set_gdm_ports
> routine.
> 
> Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: fix error branch in airoha_dev_xmit and airoha_set_gdm_ports
    https://git.kernel.org/netdev/net/c/1f038d5897fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



