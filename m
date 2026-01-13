Return-Path: <netdev+bounces-249295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E671AD1683F
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 799A23033986
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C84346E62;
	Tue, 13 Jan 2026 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMyrmpwP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504A2E173B
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768275213; cv=none; b=mDsC1xmpgChqoBEziAapxz/1UGDqhotoucG0LeIuEtdbjbiwENcAKHN4RVe301GgV20JY8MA4Rw1oCqZSXdPxttIoEp0IeGkC5/WRN1HyjVm45+uN+RFYh4ldfQTttG/BVuM7bnZUlNWTSJbCvblre52vR9JbPTcXhFK4AnZh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768275213; c=relaxed/simple;
	bh=spgkXTbeqnIy58cj1/9lfs3zCULO03AiiPx6WBBkw64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DR3D6AgfXC6J6o/f+ZeOxN02G9SqMKRmEjprDjiMM/ThFIrBHYmCUf0thBqQwIHe+4HAHgVLVrEOybWJDeI5xnn1OHpGvoiJg+fHb+BKDOu/F6wjNB8jECuQ1jFDDs/wOh9unbM/QXVsR3ghaJu4y5kg4p8fE8JGJ4gwLR9h4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMyrmpwP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A2EC116D0;
	Tue, 13 Jan 2026 03:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768275213;
	bh=spgkXTbeqnIy58cj1/9lfs3zCULO03AiiPx6WBBkw64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bMyrmpwPlQAZYNzq7C1EIjw/cF5OoutO4g/uUqhUZSpdvUVKGdkj2uz9qOCjIqCxQ
	 HWF4eBSllxC5djL6+8YYMCo1ooUhjy+i43GDuVGAyykzOEkY3fYWHeDZ96yvIzB3FZ
	 3Q3b2nzKtJFFWhjqVdPSwJaVSydUq73sFNPiUNOXQE4Gm0WDsJO83M9cB1KM1RHTWW
	 9X3Gxy0VZxur47BD3v290ZbvhM2nwc5ZTMyXswqKiQtBT+umnUV2hnDj5aKitkcYis
	 9MODRdKyAuBoZGpjXAZtSYgN7JTO2bIRt1EeazlftzgQlZg4/kKlRXi9LBljCh8b9Y
	 gHyBfFiCkrtMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A5D380CFE1;
	Tue, 13 Jan 2026 03:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Fix typo in airoha_ppe_setup_tc_block_cb
 definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827500730.1659151.13605466861154324453.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 03:30:07 +0000
References: 
 <20260109-airoha_ppe_dev_setup_tc_block_cb-typo-v1-1-282e8834a9f9@kernel.org>
In-Reply-To: 
 <20260109-airoha_ppe_dev_setup_tc_block_cb-typo-v1-1-282e8834a9f9@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 09 Jan 2026 10:29:06 +0100 you wrote:
> Fix Typo in airoha_ppe_dev_setup_tc_block_cb routine definition when
> CONFIG_NET_AIROHA is not enabled.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601090517.Fj6v501r-lkp@intel.com/
> Fixes: f45fc18b6de04 ("net: airoha: Add airoha_ppe_dev struct definition")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Fix typo in airoha_ppe_setup_tc_block_cb definition
    https://git.kernel.org/netdev/net/c/dfdf77465620

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



