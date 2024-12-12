Return-Path: <netdev+bounces-151284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA369EDE59
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6361884465
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F046314A627;
	Thu, 12 Dec 2024 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqDUFiJw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF613B288;
	Thu, 12 Dec 2024 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977214; cv=none; b=YyVyfNfxqXbSFWoJr9rNHtRmjpI9OyKlEV9iHpHt9jY81E5D6Ga6+urRq+pe4aqtyqFtdotRtAoVW5l3FXHKdyKZn4esOCH0XsQpjU561nMVNhVfy14rP6AEr26/cP/uU2AD7iR8xorvS9UhbIbPUiGTzCirXzj1Yujgu/7q4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977214; c=relaxed/simple;
	bh=WYupl2GeukecHHDy7KU4ArYkTIXK8OJyOiIvH99hasw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aPkKB5oqkl5X1OWDmeUFULVV1zHUJblwDkk1xcorSVlXWNbcmuntdXiPIQTefbpUYOTvfJqoP04TxIwUiEtjAtFZNwTtIsuYsQJol4LF6DOFylyINQfkJ0jyhCh3sCwCWJcXQkAZipsC+995yPPCohNjscyQM4chu4pVNKNAC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqDUFiJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290F5C4CED0;
	Thu, 12 Dec 2024 04:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977214;
	bh=WYupl2GeukecHHDy7KU4ArYkTIXK8OJyOiIvH99hasw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nqDUFiJwCyFW2pbMwwvOvKzABq/bJoCG01It0t5wSJa0rMs2d2pL+MHHZvq7w//oE
	 v+eMI67s9fH/+kg4g474giLicvYqmb7LmelQyHPVQ669ALxz4t5e7g39Ar2bn+XQWW
	 6vNRLS1c4StybURZVuYHVcjjgZYJxXpTgbuo2zy1SqqCxNjOv9dm7kMJ2Ix+/LAY6n
	 QfkfQaMOtP3ICCpRN0MVq5roMy6ZW1QH9Y7QcHThsACXrgBfvFZ2h5nncyUrQ826RO
	 LiMNQ27Wf3oGD4Tbp8m8VC1l96kgvSv6q12vaboSRXjVE1P4yAN9cL2NFC5cB34E+f
	 dDAvwxLWyXA2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F7F380A959;
	Thu, 12 Dec 2024 04:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] cn10k-ipsec: Fix compilation error when
 CONFIG_XFRM_OFFLOAD disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397723031.1845437.10790419708591220845.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:20:30 +0000
References: <20241211062419.2587111-1-bbhushan2@marvell.com>
In-Reply-To: <20241211062419.2587111-1-bbhushan2@marvell.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Dec 2024 11:54:19 +0530 you wrote:
> Define static branch variable "cn10k_ipsec_sa_enabled"
> in "otx2_txrx.c". This fixes below compilation error
> when CONFIG_XFRM_OFFLOAD is disabled.
> 
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.o:(__jump_table+0x8): undefined reference to `cn10k_ipsec_sa_enabled'
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.o:(__jump_table+0x18): undefined reference to `cn10k_ipsec_sa_enabled'
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.o:(__jump_table+0x28): undefined reference to `cn10k_ipsec_sa_enabled'
> 
> [...]

Here is the summary with links:
  - [net-next] cn10k-ipsec: Fix compilation error when CONFIG_XFRM_OFFLOAD disabled
    https://git.kernel.org/netdev/net-next/c/b82ca90d5512

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



