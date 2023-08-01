Return-Path: <netdev+bounces-23453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB5176C02F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9A91C210DF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E2275CC;
	Tue,  1 Aug 2023 22:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592C026B10
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5E1CC433CA;
	Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927824;
	bh=GxUDkSf6Hr/lFjnCqty6xdSEBRrcbNy0/iZGOnBIe6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fg9tvmtNzukcZrcUjastiE0mkN1wzneav/c4Z92WyLUod2WtuhbiL0Le8ZjjTGQJb
	 31rrZY9ZyXz8QE8SjXpppOW4tn3GopyQ9ekoc//pcqLiLDu346mHY6y4x/Nsk4CiAC
	 vzS8VOlgmiSMHfXu4h70OtqE4B8XtYFIFKQq7YjQ3Ksu4I4Rd2gXThH+imBhErJ/iH
	 wnwabcCynE0wcv26QuXrcCKpRPSscGUlSR0ER+H0t5NpFfNijD5MRFagyj09lURqXy
	 KQ8qBOSJ48yHQzB4Y/kUSAZoJ5IKlGHd7MWABuUINTbL2Uxdt6QCx3d+NC/krTO/Jo
	 KZemY8TkUL1Nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3475E96AD8;
	Tue,  1 Aug 2023 22:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169092782473.18672.14985341602368675273.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 22:10:24 +0000
References: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org>
In-Reply-To: <20230731-synquacer-net-v3-1-944be5f06428@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: jaswinder.singh@linaro.org, ilias.apalodimas@linaro.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ardb@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 11:48:32 +0100 you wrote:
> As documented in acd7aaf51b20 ("netsec: ignore 'phy-mode' device
> property on ACPI systems") the SocioNext SynQuacer platform ships with
> firmware defining the PHY mode as RGMII even though the physical
> configuration of the PHY is for TX and RX delays.  Since bbc4d71d63549bc
> ("net: phy: realtek: fix rtl8211e rx/tx delay config") this has caused
> misconfiguration of the PHY, rendering the network unusable.
> 
> [...]

Here is the summary with links:
  - [v3] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
    https://git.kernel.org/netdev/net/c/f3bb7759a924

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



