Return-Path: <netdev+bounces-224198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EFEB822CB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194A71C232B0
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3F730F54F;
	Wed, 17 Sep 2025 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghF4RGBC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4521CA00
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148808; cv=none; b=gkz+MDdcD5DBee3nuCa9AlPxP7Itc6lVTSgaK3mH2I4CjVBfMpkSA9k1MwkCH5e9Gf6DeGXbhUHPh1PJ72sLcNGksaPWrh0/elDzysmnKzrI/wvsjo5PPbzm7f2wLrOzjf3UDKZtuhl4G+pCHuW6FRCDCCGpw+JbioDsUexhi7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148808; c=relaxed/simple;
	bh=yI9nm4QsycRJhS42d9IhnRFiDRAW+gLNDN0KyILl3qE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LoOHyOSTa0FaqZJKqMKkslnogZ0UYc1W6cKZoPYxB2Qr6sdqJBfBSEvPeHrRvGVGOdK1mZNaIBtce2u06z9YxOr7AHfxiyol/cv/mvxsq2j7ruKojxHdA74sYbIa5YQTq4BiZwMCznPLBB+XMfvNnWi78QU3uQGd/xCkl+zelK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghF4RGBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB914C4CEE7;
	Wed, 17 Sep 2025 22:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758148807;
	bh=yI9nm4QsycRJhS42d9IhnRFiDRAW+gLNDN0KyILl3qE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ghF4RGBC1Ybn0FQs2/QT+JBa+ArY3x0mZ5nB9LwIqaxwpn5F19i4aneoTcpHYsRDA
	 rRlPio4ruF0Q2AZe77a/7284yNqalXuSYIknt1K42cPlU/auNvhQVOo9gNil6zXdTz
	 IHWn/eWZFPEkSM+5h+I7jNR5QuyfOfCEsTrQsmCSKN3ZUSnRzs8iaWRndTD4oic8/c
	 HnEgZpiZMhDXBL372RPJet5Fdvs17kc+4noDhkhAqp7G8CWA9tgfW2M87LJKFIpBI/
	 Y8X0QpnElrJPvGiXDcTt0/Vozk54/7lLi0frDrkQDzNyUE6KntIGvxXQJZRjR2QWPV
	 BnoOVbE5vytYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FE139D0C28;
	Wed, 17 Sep 2025 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: phy: remove mdio_board_info support
 from
 phylib
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175814880825.2172991.6411163169375469216.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 22:40:08 +0000
References: <4ccf7476-0744-4f6b-aafc-7ba84d15a432@gmail.com>
In-Reply-To: <4ccf7476-0744-4f6b-aafc-7ba84d15a432@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, andrew+netdev@lunn.ch,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 olteanv@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 13 Sep 2025 23:05:15 +0200 you wrote:
> Since its introduction in 2017 mdio_board_info has had only two users:
> - dsa_loop (still existing)
> - arm orion, added in 2017 and removed with fd68572b57f2 ("ARM: orion5x:
>   remove dsa_chip_data references")
> 
> So let's remove usage of mdio_board_info from dsa_loop, then support
> for mdio_board_info can be dropped from phylib.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dsa: dsa_loop: remove usage of mdio_board_info
    https://git.kernel.org/netdev/net-next/c/41357bc7b94b
  - [net-next,2/2] net: phy: remove mdio_board_info support from phylib
    https://git.kernel.org/netdev/net-next/c/b67a8631a4a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



