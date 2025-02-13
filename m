Return-Path: <netdev+bounces-165955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0A7A33C8B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822D17A2ABB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254F9212FB4;
	Thu, 13 Feb 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHZc6mRL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE5212F98;
	Thu, 13 Feb 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442003; cv=none; b=pjOI+y638csKJ9b177AeDbXTUs4qpC059ZqN7YcZDhaEosSUIzNcBD0BScqqXQzFZG7qcRkal5+Q8HLmRnI16lRKGPdZwebostEklxuebVU5KbVha+htyJ2EummngPRgSn29YFP0/mPLwpUTCFpugAJSuMyYa0+uChdJa8H4S3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442003; c=relaxed/simple;
	bh=ubDuH7hIXZ9K8tjHoZXSqPPrTCGD+bzOS8Ci1+eNjuM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UtTApEc+0CRHw/OYPFkd8E3rtXOHh0jJh77Q2UUf/x8++jp0pu/tL+b+k8jzn9xoAWWO2ksV4zcGgW0etfbYP2nnyCBHHMH3SndCwJgQIfR8i+kfqEDIV16roEzOQB/w/KRz67Pzu8wVFYuhjmHikoUGouQLvvb1K13pnIaZEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHZc6mRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCE0C4CED1;
	Thu, 13 Feb 2025 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739442002;
	bh=ubDuH7hIXZ9K8tjHoZXSqPPrTCGD+bzOS8Ci1+eNjuM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XHZc6mRLoraVJj6EP6646iMFnU41WR7jU/CbI7zLbx2JvzGHN6o8Dgyzq0c6B2u0u
	 aeQfZxvwPETBQMkVeKJEBWRdgvEg5wYtPZkXFVg3iaqx4feqSvAjatEtfzbkSbkotI
	 7CaB7jSovA5/ESZSlzjFbITNESJuD8RmhHZ7ybIGZfvntrH0rxxPLQFj9FPIXZASRD
	 9nQLw48w0B+w7QMWjvIx6lQbSeqYpjwZxGy85h69YJLdgHJWFrFVTSZJVxk0Dc2SoH
	 zekRhs9la6KQmrE0eVMnxgNHt+fzfX/P9hzEuqJlBNwHy5yX9vqqdsabv+UeE5ZRmz
	 zxPxAh4ZopvoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B05A9380CEEF;
	Thu, 13 Feb 2025 10:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: phy: marvell-88q2xxx: Add support for PHY
 LEDs on 88q2xxx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173944203151.1174456.330719028467783951.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 10:20:31 +0000
References: <20250210-marvell-88q2xxx-leds-v4-1-3a0900dc121f@gmail.com>
In-Reply-To: <20250210-marvell-88q2xxx-leds-v4-1-3a0900dc121f@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 niklas.soderlund+renesas@ragnatech.se, gregor.herburger@ew.tq-group.com,
 eichest@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Feb 2025 15:53:40 +0100 you wrote:
> Marvell 88Q2XXX devices support up to two configurable Light Emitting
> Diode (LED). Add minimal LED controller driver supporting the most common
> uses with the 'netdev' trigger.
> 
> Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: phy: marvell-88q2xxx: Add support for PHY LEDs on 88q2xxx
    https://git.kernel.org/netdev/net-next/c/a3783dbf2574

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



