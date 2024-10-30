Return-Path: <netdev+bounces-140207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4769B58A1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD091F215FB
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88012CA64;
	Wed, 30 Oct 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilJfADuP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5C23D7;
	Wed, 30 Oct 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248228; cv=none; b=FAda2zJr7zMwcXUPuYTFl4NrIUxJc+2ifVkjJxyvbVAwd5sHO9oFI6CEipHXbDzJ5L95JGQziyGwh34FYFrNaZ6YO2SbLWfntTy3spJdLTfnB7CiRe3V8jrpfgIW2h1Mtcj41MpJRgf3iYddVcUmS25Eb5yPO7rKZONzs5Q6bR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248228; c=relaxed/simple;
	bh=oVlw9SNzmrWdMDpxLIFpo1SZYL350HBgiiN3l+EP2Z0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dur/HptRfHfL1ngHKiQ2WCABEKTBcAWNLjGk1E3UH4bvXlzLgDUux61jRxm9lVcEYspFvVunFtrPlPoPm8B/L0e4zp2djub4sosDYTtheRNgShfmpE3bxCA8DldOaEcXWT2ERc0Iuqploxm5qAYupLHD+mMGX1ObS6CnNP3gTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilJfADuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3987C4CECD;
	Wed, 30 Oct 2024 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248227;
	bh=oVlw9SNzmrWdMDpxLIFpo1SZYL350HBgiiN3l+EP2Z0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ilJfADuPycc2zSWqFUXrm2MFV7PLskhO//pz1N6tNalUHjvhlDk9QC6r17mCCNOeS
	 L/etVO7z35MKEbTo5vat+ajZXXs1j0e40dFrs9cHNWMHiBSw9ZjAqae3T035ojIBpO
	 B9qBtRUQX87xk2tbuiL8QcONkxJbvjpBJVK+k1GhJaV2YitE/xn+ksXus2ekccHyMF
	 2wmDaZjtDvfOIWd3Hub98vVDJVYtRf0lbPdEsxQJ8UoHMjVZfOVYp8N2YdnpJXz9u4
	 CccMKsJuM7ZkRpFqM000nZaF76anCLGE+uTL7T5vDbpkeaR0orYvEM++p6439NxA1t
	 Up5g0xgBhwJwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0F0380AC00;
	Wed, 30 Oct 2024 00:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] devlink: minor cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024823550.867081.16818826331864738249.git-patchwork-notify@kernel.org>
Date: Wed, 30 Oct 2024 00:30:35 +0000
References: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20241023131248.27192-1-przemyslaw.kitszel@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, marcin.szycik@linux.intel.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Oct 2024 15:09:00 +0200 you wrote:
> (Patch 1, 2) Add one helper shortcut to put u64 values into skb.
> (Patch 3, 4) Minor cleanup for error codes.
> (Patch 5, 6, 7) Remove some devlink_resource_*() usage and functions
> 		itself via replacing devlink_* variants by devl_* ones.
> 
> v2: fix metadata (cc list, target tree) - Jiri; rebase; tags collected
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] devlink: introduce devlink_nl_put_u64()
    https://git.kernel.org/netdev/net-next/c/da3ee3cd79ca
  - [net-next,v2,2/7] devlink: use devlink_nl_put_u64() helper
    https://git.kernel.org/netdev/net-next/c/a788acf154eb
  - [net-next,v2,3/7] devlink: devl_resource_register(): differentiate error codes
    https://git.kernel.org/netdev/net-next/c/e0b140c44f32
  - [net-next,v2,4/7] devlink: region: snapshot IDs: consolidate error values
    https://git.kernel.org/netdev/net-next/c/72429e9e0cfb
  - [net-next,v2,5/7] net: dsa: replace devlink resource registration calls by devl_ variants
    https://git.kernel.org/netdev/net-next/c/d5020cb41e3c
  - [net-next,v2,6/7] devlink: remove unused devlink_resource_occ_get_register() and _unregister()
    https://git.kernel.org/netdev/net-next/c/2a0df10434dd
  - [net-next,v2,7/7] devlink: remove unused devlink_resource_register()
    https://git.kernel.org/netdev/net-next/c/e3302f9a503a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



