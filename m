Return-Path: <netdev+bounces-104485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D441A90CA94
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C87F2890A6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A871156890;
	Tue, 18 Jun 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdLtsA24"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD6156672;
	Tue, 18 Jun 2024 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710829; cv=none; b=fZadtqtwjzMsC8lFMnGeOGw++oVMZcs2nW7W+9OA6tsP0mG9g7CVzPzLOUFo5V3ASveoU+QdZINTFV5X9BUV7GZJpZIT8nsuWSuR1+6sn6L64Rd+Np3MyEhXqWkd7+lPKuQRVdOGNkYPm7mGxE/GhdaHQEe/APIv8adO0lv/X2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710829; c=relaxed/simple;
	bh=6XCAr2mYKvzKVAFGzZelSVJo2mipIQQ42ELvJnsHiG4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h9epPNVM7+YSIDfT3YY9wDzCUjrJI0jqzzW0bP2Yop4WS11pMFxjnpRxLdT5kmy0/eb2Zdaf3/RF+7HAEcxqvVTJ0JLheS35kIAmvl/cdaCpqYR9PmIY8L/5hszqRE41Yw8b/5LppHl9MXkK14zmtyn7dp7sWZcegGfY/Yhou9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdLtsA24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4BFCC4AF48;
	Tue, 18 Jun 2024 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718710828;
	bh=6XCAr2mYKvzKVAFGzZelSVJo2mipIQQ42ELvJnsHiG4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OdLtsA24lWJMUjHRPvxkYb6AgasZXvPNvp4GvbpWo/VvCGL2OuKSbzNHpc5n0tdwp
	 74A2ODLVNiLH47fVb0CKq1W4Md/Y7Ins9YHQKmAeeQ9lOSnCJglUhg93dOhh0hUvPH
	 868CqjN1NwPYsr/t4ogsIQCyXlMumIYbpnCfhUEZx+CFDAq2o9FXnu24X5OPZYiKQ/
	 sNhVisY5rZIm/kcpyMwJWzQro4GIBH+yvLRATtbY8L9mZgA0kL/QONOrHqqlhJEWKU
	 TCYYYRjMlnkuIzwRIO+8uEqCagJWy1B4uAliGEanLA0wkNfw+XijIOmLYPUokmFHBf
	 4rgnmV9Z1Njyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1D41D2D0F8;
	Tue, 18 Jun 2024 11:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] Introduce PHY mode 10G-QXGMII
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171871082872.5930.6285205303729820096.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 11:40:28 +0000
References: <20240615120028.2384732-1-quic_luoj@quicinc.com>
In-Reply-To: <20240615120028.2384732-1-quic_luoj@quicinc.com>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 15 Jun 2024 20:00:26 +0800 you wrote:
> This patch series adds 10G-QXGMII mode for PHY driver. The patch
> series is split from the QCA8084 PHY driver patch series below.
> https://lore.kernel.org/all/20231215074005.26976-1-quic_luoj@quicinc.com/
> 
> Per Andrew Lunn’s advice, submitting this patch series for acceptance
> as they already include the necessary 'Reviewed-by:' tags. This way,
> they need not wait for QCA8084 series patches to conclude review.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: introduce core support for phy-mode = "10g-qxgmii"
    https://git.kernel.org/netdev/net-next/c/777b8afb8179
  - [net-next,v2,2/2] dt-bindings: net: ethernet-controller: add 10g-qxgmii mode
    https://git.kernel.org/netdev/net-next/c/5dfabcdd76b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



