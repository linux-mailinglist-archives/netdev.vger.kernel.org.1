Return-Path: <netdev+bounces-225364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF27B92C6E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 21:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210682A49B6
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD271519AC;
	Mon, 22 Sep 2025 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgetPwGN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE327B320;
	Mon, 22 Sep 2025 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569414; cv=none; b=m/g5klpwfBxom57Rf2idRCLAm0FbgidpZZK6ebzUTmhTtLDdhpQHgLHrpBeIcR7dmCsta2wgOxs64BugmCPA62B8cXmHKTkq4bKtAwgc0R2XBNfb/M02vxFTmXD2n4D9NuSFxd3ePEd7AUlYNRss9DHML61g5xZBVv9fmIULePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569414; c=relaxed/simple;
	bh=Zb4CnGqbdWHuBl8Wa/9Nf/wm2ybUtmj5x+KFqEyc4/0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qC7UZX6O0QlF4tBMbgW5bO7egcqZ+tFWO/kCU9ixLM+dcidQe1dAaA0D7pWsDyQGeNY9p9z4CKl5b2XKLBS7OB0IlxUqfk3czVCA8trDm4uZ7tnY+JxCYk6BhkgVsHF1HAbO/aE9WClmHCoBt3QoH2Y/Vp03513Ixu0L/TlMGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgetPwGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33634C4CEF0;
	Mon, 22 Sep 2025 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758569413;
	bh=Zb4CnGqbdWHuBl8Wa/9Nf/wm2ybUtmj5x+KFqEyc4/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WgetPwGN0U1IjpdB8PJFDF5zyA0lkOOmikD2cdKUD2h320QDpfyg2c5mNjwY1SnLm
	 n+MhwUwomG23wOtMJ0BXTDNm/EzHADPEbaw64hb/KMqrWAU+jByCvLMbWykQZrUKPp
	 3TfY+TxWSV5/66hVnATPZpDK+EBRzDgTunTn56HzPeQYmmc12XIYSMJ9yBxwoOqedT
	 GgJJ9NAH9l6XU7JQebzoWBPhGxQ4r1HmXl4oackqtpD+ixRfipce2jnEw9ATpEQrXp
	 kSbFMrxTCOu1BDFVL0VFA1LhF4ZNsqgTSHlFZ2k9VWR+dkkYbWBG79khlEJW3Bg6SV
	 /7AodIJwsu0aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4639D0C20;
	Mon, 22 Sep 2025 19:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] broadcom: report the supported flags for
 ancillary
 features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175856941075.1131614.13932176930823892917.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 19:30:10 +0000
References: 
 <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
In-Reply-To: 
 <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, kory.maincent@bootlin.com,
 richardcochran@gmail.com, yrk@meta.com, jjc@jclark.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Sep 2025 17:33:15 -0700 you wrote:
> James Clark reported off list that the broadcom PHY PTP driver was
> incorrectly handling PTP_EXTTS_REQUEST and PTP_PEROUT_REQUEST ioctls since
> the conversion to the .supported_*_flags fields. This series fixes the
> driver to correctly report its flags through the .supported_perout_flags
> and .supported_extts_flags fields. It also contains an update to comment
> the behavior of the PTP_STRICT_FLAGS being always enabled for
> PTP_EXTTS_REQUEST2.
> 
> [...]

Here is the summary with links:
  - [net,1/3] broadcom: fix support for PTP_PEROUT_DUTY_CYCLE
    https://git.kernel.org/netdev/net/c/6e6c88d85623
  - [net,2/3] broadcom: fix support for PTP_EXTTS_REQUEST2 ioctl
    https://git.kernel.org/netdev/net/c/3200fdd4021d
  - [net,3/3] ptp: document behavior of PTP_STRICT_FLAGS
    https://git.kernel.org/netdev/net/c/cd875625b475

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



