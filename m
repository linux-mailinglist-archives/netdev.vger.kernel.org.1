Return-Path: <netdev+bounces-48492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945307EE92C
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 23:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E7AB20A90
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2443214F87;
	Thu, 16 Nov 2023 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgvP4NMY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140449F96;
	Thu, 16 Nov 2023 22:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D227C433C9;
	Thu, 16 Nov 2023 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700173224;
	bh=y2tdWV5+WM4fXRfgOiOyz6S5uMTan+kf+sRDuHkILNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cgvP4NMYXNMYwLpdHQo5EDFmgE+kc9nQeZd+dnVGoj5wNaoIdeloWt93CbBvlAwWT
	 zWzTsKVuHTa8ZK1VZQuMOVjJ550LTERG6sS7OJzGzElf511l3qP5g2cN85U1w5Y6g8
	 MlRBMqzCtThejQbWXHSjasdtLAKBn+Qd9qEfZ7Mudtd6XOnrs+Dyx1hN7kJDf/McBr
	 XY1GC6NFCRFmav5gV6Xh5Q9vrv5qY57ySWC8rkBnlQgePvSFlj+HaiyYKfNUQq141f
	 ch//shzHr1ohw9ze2jlE7vGwW7JdlaeUXX46R2gtH5VUQU25gafcOdOotaBEaTaOnc
	 R9ctE5z4PmJKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40851C395F0;
	Thu, 16 Nov 2023 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v8 1/4] net: phy: aquantia: move to separate
 directory
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170017322426.10772.15208899702041865337.git-patchwork-notify@kernel.org>
Date: Thu, 16 Nov 2023 22:20:24 +0000
References: <20231114140844.9596-1-ansuelsmth@gmail.com>
In-Reply-To: <20231114140844.9596-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, robimarko@gmail.com, vladimir.oltean@nxp.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 14 Nov 2023 15:08:41 +0100 you wrote:
> Move aquantia PHY driver to separate driectory in preparation for
> firmware loading support to keep things tidy.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Changes v8:
> - Out of RFC
> Changes v7:
> - Add Reviewed-by tag
> Changes v4:
> - Keep order for kconfig config
> Changes v3:
> - Add this patch
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/4] net: phy: aquantia: move to separate directory
    https://git.kernel.org/netdev/net-next/c/d2213db3f49b
  - [net-next,v8,2/4] net: phy: aquantia: move MMD_VEND define to header
    https://git.kernel.org/netdev/net-next/c/e1fbfa4a995d
  - [net-next,v8,3/4] net: phy: aquantia: add firmware load support
    https://git.kernel.org/netdev/net-next/c/e93984ebc1c8
  - [net-next,v8,4/4] dt-bindings: Document Marvell Aquantia PHY
    https://git.kernel.org/netdev/net-next/c/0fbe92b9fd4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



