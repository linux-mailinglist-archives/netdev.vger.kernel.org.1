Return-Path: <netdev+bounces-42984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D097D0F1D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00DC7B21441
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05A199B6;
	Fri, 20 Oct 2023 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex002MOg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E22199AF
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 11:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E67D9C433C9;
	Fri, 20 Oct 2023 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697802623;
	bh=RVmO07tzj/SdstlG+yv3cQ+Z3KTGbsEa4x6K3JeX8Tk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ex002MOg19HBM5FGfap7svZaYUyGagyQPAGgB/z5cj2O1yTVeMWZ/4oeRybYG7QfE
	 Axu8iQShHGlcJtS0kDe+2vBNWmOJTX6aYVxczAogp+Mwta2X4gOpFi/VNYktTKK2jN
	 u+AG0VfyXDHiTjppmn1ZO5LAE99E5DjgOmULXd4kqg0Q/chDi3Q1vGl9CQWPWSWh9A
	 CzJKJLN//TxUKtQaGcaFGNBix4EdJ4jeEKiMh4vwg2SpAZJ4Pxgo/mrWaLsjpGf06z
	 Am9b8+3Kj2ZJiqg0IAqTOjBDDFeyNaD7pp8ocBEGaSfrE72EY0joYy1sthJknDfLPp
	 30b71p/q8G9Rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA898C595CB;
	Fri, 20 Oct 2023 11:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: untangle the linkmode and ethtool headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169780262282.5050.306569060404791845.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 11:50:22 +0000
References: <20231019152815.2840783-1-kuba@kernel.org>
In-Reply-To: <20231019152815.2840783-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew@lunn.ch, paul.greenwalt@intel.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, vladimir.oltean@nxp.com,
 gal@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 19 Oct 2023 08:28:15 -0700 you wrote:
> Commit 26c5334d344d ("ethtool: Add forced speed to supported link
> modes maps") added a dependency between ethtool.h and linkmode.h.
> The dependency in the opposite direction already exists so the
> new code was inserted in an awkward place.
> 
> The reason for ethtool.h to include linkmode.h, is that
> ethtool_forced_speed_maps_init() is a static inline helper.
> That's not really necessary.
> 
> [...]

Here is the summary with links:
  - [net-next] ethtool: untangle the linkmode and ethtool headers
    https://git.kernel.org/netdev/net-next/c/20c6e05bd33d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



