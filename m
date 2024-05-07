Return-Path: <netdev+bounces-94010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6668BDEC7
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1A91C22B8B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603E2153583;
	Tue,  7 May 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTV37SJl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C015253E;
	Tue,  7 May 2024 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074842; cv=none; b=o9cSqbb7qhn57uZMkPBzUq378GcMgWmOZO3/v8QuuWepobU+GVsfk0oPb4QawAk2siaNPiX540SMIMgdLebEOzEqm9Zg5c0MrDQanC8r+cGKyAdOX87ovPnwMnAvR4k4KXEB7YJiPFTjVIrlN4y9kiem9YS2IzW78lxuyVgHyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074842; c=relaxed/simple;
	bh=XYhvyyqBPbCPPManGWzSD8bIWNDcaeNrlref3PG2kY0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X5Arqx75+srCWXLtaKrpfAz7Jrr1/RR6/baecYdtOHgCk9T6hqLOmqRoKQwA96sDEuMe/88MUHUWv2cKjTAmOkKS8+RJPq3+GbItN6hiaV/e47X4kTNukToDXRtGUN0nTVM6bB4W3dboKmNkrpKlet0evmg3hQFvp1jxv49rP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTV37SJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C723CC4AF68;
	Tue,  7 May 2024 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715074841;
	bh=XYhvyyqBPbCPPManGWzSD8bIWNDcaeNrlref3PG2kY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FTV37SJlOgl+6N1CNIdrbryReVPROt0XMJcJojUTOmJjEGL9WT8wrrxc07vwfnBac
	 COG9xisdc2rBkShWxq2LMlyrZJnjpvbATDBknzCOSNk1T2soXuMSDpB4qYq0nPyElG
	 9iJsQfEvXsQPtXWuZr1SKNsGxsGnsX7QmckHstUInp1hpKs3szqH9jI0hxspDq67QG
	 O+SaaILdl9NhOWUZXEvuYG6YSl36a3jHd9ohdqvaw5HZMZxuTSrFQNv9QNm2eLlhAT
	 3A4nXcSfFFSk4VS07D058WHV4mXImrEf2VS+hKs1MducGufgM/2VuuuEcFbgvIGNKM
	 zUc8lNwjBhlfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9480C3276B;
	Tue,  7 May 2024 09:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: mt7530: detect PHY muxing when PHY
 is defined on switch MDIO bus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171507484175.24942.8565731423432452647.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 09:40:41 +0000
References: <20240430-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v2-1-9104d886d0db@arinc9.com>
In-Reply-To: <20240430-b4-for-netnext-mt7530-use-switch-mdio-bus-for-phy-muxing-v2-1-9104d886d0db@arinc9.com>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTCB2aWEgQjQgUmVsYXkgPGRldm51bGwrYXJpbmMudW5hbC5h?=@codeaurora.org,
	=?utf-8?b?cmluYzkuY29tQGtlcm5lbC5vcmc+?=@codeaurora.org
Cc: daniel@makrotopia.org, dqfext@gmail.com, sean.wang@mediatek.com,
 andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 bartel.eerdekens@constell8.be, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, arinc.unal@arinc9.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Apr 2024 08:01:33 +0300 you wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Currently, the MT7530 DSA subdriver configures the MT7530 switch to provide
> direct access to switch PHYs, meaning, the switch PHYs listen on the MDIO
> bus the switch listens on. The PHY muxing feature makes use of this.
> 
> This is problematic as the PHY may be attached before the switch is
> initialised, in which case, the PHY will fail to be attached.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: mt7530: detect PHY muxing when PHY is defined on switch MDIO bus
    https://git.kernel.org/netdev/net-next/c/d8dcf5bd6d0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



