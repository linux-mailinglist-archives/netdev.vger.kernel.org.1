Return-Path: <netdev+bounces-177525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DB6A7072B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E696C168BE8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F170C25A323;
	Tue, 25 Mar 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxraOzyl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50A619F13B;
	Tue, 25 Mar 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920798; cv=none; b=LoT5BuxBQtSKTDm7i5uyi/qm5CAJBCyuriBoydcdtIPBfBjmPrBMDVGrkBucH9+FudKktIyERu/3IZyglCuENZQLKRBril7dWDl+jEtBNl5Ya3JAQ97BsU/uya61PH0j5cyGeWd5+HE5e+0ztWa1c3JSNJgB8i3eFsBTiWSWnlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920798; c=relaxed/simple;
	bh=CcCpmQ2C/F3isCH+LAunPzZPAfUEnTS/eOJ5mm5dvFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YTzFAj1UU6hyJZ4QsixhsXq/LkzoqJQdZ7suXuk3vLS1F1vrHMixsQF7qOcTsuf0+RxXSeHqiEkJXOxjPhN/5b5jidG3rP0W40FL6cAor0JzxDYjXcZNH3NTIAi1pbjyDNJ9sxqyj2hRqmIm1i9MLoEXQOm73khpJfaRvWLswDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxraOzyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D7FC4CEE4;
	Tue, 25 Mar 2025 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742920798;
	bh=CcCpmQ2C/F3isCH+LAunPzZPAfUEnTS/eOJ5mm5dvFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fxraOzylm1CY40Xy/mCXija6raz9hEyNcNGcg2QMH4tIxUBqmJmizWmylTXkoFI2l
	 jJdjezHNKQ2sS4ThVC5NuVJDryDHGESpZUBfVmVMUW+3CBjvlaFvNZiir2DnVBGSWd
	 1da8yCeJzBE/0/1HzUcI2IhYVuK3oYHjGqI1Be3P0AY3tvfcI8R3k95X0wKlAuCBMF
	 00LN1eYfmhtBtbbDIMHAcd8fqhV/aSGSchiPF0CJjACl4ycErXGf2lB8Y00hUMEzWu
	 inVUIhNgutQhDS1/+FNqzQGFaVmt/H0Yf6BHpwVNiGJ5QYCQ780HYpnHKlA/PH/j53
	 aRe6wz1r3UVyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFEE380CFE7;
	Tue, 25 Mar 2025 16:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] virtio_net: Fixes and improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174292083452.643641.3571008462591384727.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 16:40:34 +0000
References: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
In-Reply-To: <20250321-virtio-v2-0-33afb8f4640b@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@daynix.com,
 jdamato@fastly.com, lulie@linux.alibaba.com, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devel@daynix.com,
 leiyang@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Mar 2025 15:48:31 +0900 you wrote:
> Jason Wang recently proposed an improvement to struct
> virtio_net_rss_config:
> https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com
> 
> This patch series implements it and also fixes a few minor bugs I found
> when writing patches.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] virtio_net: Split struct virtio_net_rss_config
    https://git.kernel.org/netdev/net-next/c/976c2696b71d
  - [net-next,v2,2/4] virtio_net: Fix endian with virtio_net_ctrl_rss
    https://git.kernel.org/netdev/net-next/c/97841341e302
  - [net-next,v2,3/4] virtio_net: Use new RSS config structs
    https://git.kernel.org/netdev/net-next/c/ed3100e90d0d
  - [net-next,v2,4/4] virtio_net: Allocate rss_hdr with devres
    https://git.kernel.org/netdev/net-next/c/4944be2f5ad8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



