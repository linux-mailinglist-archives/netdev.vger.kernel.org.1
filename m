Return-Path: <netdev+bounces-186877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13DAA3B62
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6331A88876
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1215277035;
	Tue, 29 Apr 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5udXlp0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961102750E4;
	Tue, 29 Apr 2025 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745965202; cv=none; b=gLuShzzb/YdVCmjaHBgzSFBxXg5e6sRfAqynmkZmxDT9dmPE1ELw90XGnTsLdJy5Nk2PLRPi35ZnOe7e3XPjj3eHrBpAzqJ6dnsEUhGgecGaMW27qVF1OPhbHuyClF8FHUcOEUj0KNffYqxbSlBQg8XVlMVxC3pRXCPXgIA+C/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745965202; c=relaxed/simple;
	bh=VkGYHMrQt8tSK2OqdoYh+t1XFUMrak7LA/Mk8+kBwkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xdxfpxz6L+DJ4e9IXBV5zGTJUjXJ5kY3/A8MaPkmxMxICHRYlBANDXdnTwS8MbImvdO3ZG2d4Nua5faZ2jbNgOXrV46jGW9KaCXR2gWY6GBhXSeRL2k/bDcr0rlaw2YJ2Q3ddykVzR5ovMUrcoV259gohRxuLZfa+QTQPdVKovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5udXlp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FB7C4CEE3;
	Tue, 29 Apr 2025 22:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745965202;
	bh=VkGYHMrQt8tSK2OqdoYh+t1XFUMrak7LA/Mk8+kBwkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X5udXlp0wCBppOrBzigADTdp/8hC1auxLw/clsZSHj2h4v0Sy5wU+yrg7n1PVwx4x
	 ssck5Uni8O8RgygJ3kmztSVLml3IktoIuaJcM/NZr/h1yXgEHQoXa8JzRwvJCLA4Sr
	 nOkqiw25Quq37a7raCgva0Cto/SU8IkKDSlGvd55xmEy1zexG6RwApsyD6EkzFV9gb
	 kSQajONb3wAWc54Egrct35WaN2sePs7+5bMt9Qbx9rOHJbLeL3poFpQpwcVsiIgZ0X
	 F3TJSPTnd4txyJ4JWMd4mslajT7DPbTD3pf3Sd19m27mrFQPZFla3XZgXePF07O682
	 i0Ig85ahNI3fA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343283822D4E;
	Tue, 29 Apr 2025 22:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v0] net: phy: aquantia: fix commenting format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174596524099.1813341.8585751899940551471.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 22:20:40 +0000
References: <20250428214920.813038-1-aryan.srivastava@alliedtelesis.co.nz>
In-Reply-To: <20250428214920.813038-1-aryan.srivastava@alliedtelesis.co.nz>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: andrew@lunn.ch, hfdevel@gmx.net, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Apr 2025 09:49:20 +1200 you wrote:
> Comment was erroneously added with /**, amend this to use /* as it is
> not a kernel-doc.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504262247.1UBrDBVN-lkp@intel.com/
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
> 
> [...]

Here is the summary with links:
  - [net-next,v0] net: phy: aquantia: fix commenting format
    https://git.kernel.org/netdev/net-next/c/aa6dcab1ea92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



