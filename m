Return-Path: <netdev+bounces-70072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC8284D82F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF7BC1C21C1F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82301CFA9;
	Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYWXOVqB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2A1D52B
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361831; cv=none; b=isutdvwbslHxGiAnThlw4Uhprr6nY2o5gSaxW0mnhrAV+UNezH5gV1BQiAa/ShciTxbTbblwr75r8di2eFViJQMs/eLvpPApMpquvE9MmhgDKsT2WyTvUgfjeKOFTXYD4PA1m/t/E5Td9/PRF/5gxFD3+gIz9+vkLDNBmz6lyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361831; c=relaxed/simple;
	bh=b5kqfy2IdoAUtMHcBRVUpdmLeRpghW9q53UrHIOEhuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZhnkYH/9TG95MYtaR/toQCz/ci2bcvtKtYXh9tYvWIWd8DE8YQvFuUM9v8q75CETgzE1Pkw/7e9cQfA2d0nNzAcVYdSn1aESbrO2V/ZA2u55ymStqQlYh8hkTVLD6EkJd5MHMQOeVoyjQnm4KJS94uihC6wAhe1VV3xlF5MOKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYWXOVqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49E84C43390;
	Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707361831;
	bh=b5kqfy2IdoAUtMHcBRVUpdmLeRpghW9q53UrHIOEhuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HYWXOVqB+RNJF4EhayjUw/XRwWFxZr+q5M7ih773037X74lNHBaQAHklEysF3HMxF
	 Q466a6eSkyDNlkNI6NQA8oOAxJ9fkMNYkR6tGf1BjMAEqK8XYeLJevu9I7spsA6uyG
	 kWb28axjuwfvNLjI+l3X+mkN4sPXR4w+p+rRkYpP+Jh1skF1DcbYZ31JIpXaDzFW8q
	 KuWHSyK4Z1/nMTnadzG0c/NCte735wHA4oyqGPbjrhZqqQNpfUVnKxOyi3S7F6wXXG
	 tLL4dSGrotxu3i48S6d3ZH6uoidaDAMaKKUQxB8qsQWSxX2rLqVSpRkRisENGQ9Ovy
	 ZNH7nQnZiEDJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2ACB0D8C96F;
	Thu,  8 Feb 2024 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove setting LED default trigger, this is
 done by LED core now
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170736183117.28016.9629126186944895009.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 03:10:31 +0000
References: <3a9cd1a1-40ad-487d-8b1e-6bf255419232@gmail.com>
In-Reply-To: <3a9cd1a1-40ad-487d-8b1e-6bf255419232@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 Feb 2024 22:54:08 +0100 you wrote:
> After 1c75c424bd43 ("leds: class: If no default trigger is given, make
> hw_control trigger the default trigger") this line isn't needed any
> longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_leds.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] r8169: remove setting LED default trigger, this is done by LED core now
    https://git.kernel.org/netdev/net-next/c/c885b95c58dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



