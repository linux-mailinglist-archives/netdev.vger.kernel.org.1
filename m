Return-Path: <netdev+bounces-43787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B267D4C52
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75ECFB20F81
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06DD241F5;
	Tue, 24 Oct 2023 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD71QzUe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94508241E7
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A348C433CA;
	Tue, 24 Oct 2023 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698139823;
	bh=/K67zN9KD+hd62et4aqubU4Up8mDmO4SmA8qCGpWotc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DD71QzUe/E4YmJFDhc2Tqk9q6pegHTnMspnQM2xZEsM0dlOsmQwckbS9OH2Zf+EoK
	 6T5klBlTsp8RiD8xGOv91cND5NsH0W8QbuIWGrxCp6zDJjRE1Ba07vLqD9Q4+rvZoE
	 Ct0vBYPKvLICP+0ikJtDngcCgdBxAlnOTnBQlFuC4ClxxiLg+vRIe93sj41+EfNhKA
	 hc8FTLi/pHRatabJVZTX43uQGnbtCf3BPFbsDMV5aciWAZoJCcfrkbDz9zO+a5NGU/
	 00Th3xOZndReHD/rp9iIz+rMKMIg1k6RQ79s3BU1okJG+uZ3dJMxawsdKIB9e9Bv7c
	 ikOsLO37Fo3Gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4A26C3959F;
	Tue, 24 Oct 2023 09:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] net: ethernet: davinci_emac: Use MAC Address from Device
 Tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169813982293.23458.3683909591766240051.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 09:30:22 +0000
References: <20231022151911.4279-1-aford173@gmail.com>
In-Reply-To: <20231022151911.4279-1-aford173@gmail.com>
To: Adam Ford <aford173@gmail.com>
Cc: netdev@vger.kernel.org, aford@beaconembedded.com, andrew@lunn.ch,
 grygorii.strashko@ti.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 22 Oct 2023 10:19:11 -0500 you wrote:
> Currently there is a device tree entry called "local-mac-address"
> which can be filled by the bootloader or manually set.This is
> useful when the user does not want to use the MAC address
> programmed into the SoC.
> 
> Currently, the davinci_emac reads the MAC from the DT, copies
> it from pdata->mac_addr to priv->mac_addr, then blindly overwrites
> it by reading from registers in the SoC, and falls back to a
> random MAC if it's still not valid.  This completely ignores any
> MAC address in the device tree.
> 
> [...]

Here is the summary with links:
  - [V2] net: ethernet: davinci_emac: Use MAC Address from Device Tree
    https://git.kernel.org/netdev/net-next/c/f30a51a41828

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



