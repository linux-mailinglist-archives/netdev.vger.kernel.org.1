Return-Path: <netdev+bounces-144669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948CE9C8141
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF60283226
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E083A1EABA9;
	Thu, 14 Nov 2024 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHfQhXqF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD53A1E909D
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553243; cv=none; b=oNPnM180VoPuDznXSF9KFl8HY8+Ju7Ksr/0vwMLN4S2bjkfl/IoOQmG5pCDoF4BnyVGVIKSCkAqHz9HQ0ULrj3xo56Q/ftiN+GUi9ZubsuSil3Wh5XMbY37ANNqer7pMScxwAbbWWjqJBv9Nq2QpnUKEK55v9u8uDVerm0NJSTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553243; c=relaxed/simple;
	bh=5Ugg/GskX50zMh9pORVgXpQHNNeB39R6bKrEA26XzDg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e/f192+qpdFHlv5wynojsSRVXIO9OeedbZqDTxpcfLaZrUdO9LUyE8+hAeCJM9uqzy9VBhvNq1+VYLLhn0h4Wus6plV/kzbB/EVI6kz+HriV2Z0lA1zNBGm/d4TsiIhLsuDnq24rD2BlvympaagQWIevNvpYJtJdMxpJLVZAB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHfQhXqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEFCC4CED0;
	Thu, 14 Nov 2024 03:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731553243;
	bh=5Ugg/GskX50zMh9pORVgXpQHNNeB39R6bKrEA26XzDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DHfQhXqF1oyexGuxpUkOqPoDas5+QswjF/oyFKcdOyDLnogufzeA5L3nfjb18ziml
	 oNOSgIhn5Msw8pHQ7DX5e/4FHHH7JqNXJngpQAquiCVZSgUZCfHVSICeZkStxuk6Z3
	 Mu5ypIU28iO9kiufds5NJTqv9qM9f8ViN4iAKuMPbTXbJndHFYdBo5yiTgwTHLMSNc
	 qj89FgO8igbbcwUIEBZ02Y5W18OKg1ZVX04Of+z2HlD4GpuE/Dykt+UYIaM/WLeW1q
	 c+tNRTq5+sV7va1FN01g17Q2kxgmNXxFIPAumDMruSrSOQXffdDUnYpsPyTe/WOxve
	 qhU7ofDZ1iuVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABF23809A80;
	Thu, 14 Nov 2024 03:00:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: simplify eeecfg_mac_can_tx_lpi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155325374.1464897.14471967015407477830.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 03:00:53 +0000
References: <f9a4623b-b94c-466c-8733-62057c6d9a17@gmail.com>
In-Reply-To: <f9a4623b-b94c-466c-8733-62057c6d9a17@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 21:36:29 +0100 you wrote:
> Simplify the function.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/net/eee.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: simplify eeecfg_mac_can_tx_lpi
    https://git.kernel.org/netdev/net-next/c/6b998404c71e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



