Return-Path: <netdev+bounces-165335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CCAA31AA5
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 01:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0395E188864C
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 00:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E778E555;
	Wed, 12 Feb 2025 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW5nFlcO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793C79F2;
	Wed, 12 Feb 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320817; cv=none; b=TmWoymiXdIJsyG+LGRh/WSu5fhhzqKmlm5/UAuaK7Vk6XnFCEwIXzp/Vf/BStKEDSDyfQRl49kjpbvZN7yfs10bU2I0EhzFQYUiNIOALLfX4qu321s6nRycDeWB0cB6S4JdsInFpHdfi3bpgPY8r7txnPeMyiAuBKR3UFNluoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320817; c=relaxed/simple;
	bh=hObQGVu7Y1GI6QKEV3LMHYulIKErStEVHWh8dzpl4qM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UPsi5xu88jtQyeniPCspJO3U9Hdie5MZ22N9pAo9XRCh2qUBx1dp9Nw3lML/6Qb9RORZ9rawLF7ekYwRB49rvmyAZT5wiKSvXtLjDTab7ZoL8SqMaBzqoh72FgWlV3vWi5LFRH25yTg3P13icbnGkS/lHiQly5M8Cn7+eTplu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW5nFlcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40FFC4CEE5;
	Wed, 12 Feb 2025 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739320815;
	bh=hObQGVu7Y1GI6QKEV3LMHYulIKErStEVHWh8dzpl4qM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OW5nFlcOXYyuiIcR9zcgVpf0ckL7bOyqEYvDuenWfUHeueVWe3BNps8X6+tC+FZCR
	 bVRetV3dQQAEzjdEXzuWr/v7hySqpUhmz0GJ8gIAyJNcRVWYq4B52DmaTLEJam7SVi
	 wKUPXt917NJevf7blR9eW9nax+5WzQZL29cvYI7xzK4GQm4+BLJynb/VNs2oF3R8h0
	 +dEFA/CAakCJyxea2JH0S7ZCS44hXPh2FWNRBr4pWYFiN+4FSgUPX9cd0aDvtd7TWv
	 hm3Ppl4+Ye+YmgqjS7qFf5FEO8nr1Y5R53hh0iOg7MZ/xSDwYgsnEDr0zXdvUrFvFG
	 LuuMi9PpXCTZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBBE6380AA7A;
	Wed, 12 Feb 2025 00:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] net: phy: broadcom: don't include
 '<linux/pm_wakeup.h>' directly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932084349.51333.4089445627229532241.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 00:40:43 +0000
References: <20250210113658.52019-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250210113658.52019-2-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 12:36:59 +0100 you wrote:
> The header clearly states that it does not want to be included directly,
> only via '<linux/(platform_)?device.h>'. Replace the include accordingly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/phy/broadcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [RESEND] net: phy: broadcom: don't include '<linux/pm_wakeup.h>' directly
    https://git.kernel.org/netdev/net-next/c/ad30ee801388

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



