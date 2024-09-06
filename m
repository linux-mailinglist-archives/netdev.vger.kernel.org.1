Return-Path: <netdev+bounces-125827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DF596EC89
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6E71F21E71
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B26871B3A;
	Fri,  6 Sep 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAOi32KH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643FE1B59A;
	Fri,  6 Sep 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725609026; cv=none; b=TKMEIZePnrrDu3lSLBRQ88yGKi8D+sy7zft++U4MO+ULeyzVsHMlw2KRWBPSAORp7inHJc16UjsVxpkNuOkzqz+/KdB5tHvb034hi7bjbdax+UT+bI/rsvMs2CX2ffTFHXZgzE9oGhyqNeqWgqtOMM7fF0Djrt5DpRQQBlp24h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725609026; c=relaxed/simple;
	bh=/ZO+W4w3QSloFc2T0mo3E6tWzu7uRretG6nQRvJqnMo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e3HHvwsC10MOYb8zNGvSDvM7tBT+MNUXM4kLconDZ9m3MmTp4ZsGJTj3ByWIKrZq6FP+awANv6yKPVsqSF637X8fo2EM6aLQw6C3uanSZFTlSTdnDQzD/Ejw1Y+b+exoTaA1YOuCfkkKn+vW9pM8euELvnKYbUnGMk7Ir9QrdSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAOi32KH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBAFC4CEC4;
	Fri,  6 Sep 2024 07:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725609025;
	bh=/ZO+W4w3QSloFc2T0mo3E6tWzu7uRretG6nQRvJqnMo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AAOi32KH7j5Y0dYSWtCT9mEv4NJ7aqHMp2lkML7GZc90vPHmw19Du2eIRSsQUcA0E
	 NByGzqKhTC0S1AdEYFNE4kFIJm/KiBGXAHp3qsvRz/vQQc3YNtQWOhPJWjANSTS25q
	 nwx05F7JKZWhhNdiUXvrj9eyy1E6Hd9aJ0fm8QvTLZdhWiinTnqrz+6h9aZbFCj77v
	 kcGuxPuJHL3/y+WvIJ97VtfTpKFLT5wDB6gzGnV6Z/6kegGpKV2PMGUhK7CzzhIn1W
	 srG6SEgToXbSgVkqhVdoGlF6xY0ULX6HbFL52w1+bh5cyKiAGIOGB0EERT2xEecIWL
	 QFWQBv1hR4ftA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAECB3806654;
	Fri,  6 Sep 2024 07:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] net: dsa: microchip: rename and clean ksz8
 series files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172560902675.2010941.14519744626903062150.git-patchwork-notify@kernel.org>
Date: Fri, 06 Sep 2024 07:50:26 +0000
References: <20240904062749.466124-1-vtpieter@gmail.com>
In-Reply-To: <20240904062749.466124-1-vtpieter@gmail.com>
To: Pieter <vtpieter@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, Arun.Ramadoss@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tristram.Ha@microchip.com,
 o.rempel@pengutronix.de, pieter.van.trappen@cern.ch

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  4 Sep 2024 08:27:39 +0200 you wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> The first KSZ8 series implementation was done for a KSZ8795 device but
> since several other KSZ8 devices have been added. Rename these files
> to adhere to the ksz8 naming convention as already used in most
> functions and the existing ksz8.h; add an explanatory note.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] net: dsa: microchip: rename ksz8 series files
    https://git.kernel.org/netdev/net-next/c/6e65f5f55b7e
  - [net-next,v4,2/3] net: dsa: microchip: clean up ksz8_reg definition macros
    https://git.kernel.org/netdev/net-next/c/dcff1c05f283
  - [net-next,v4,3/3] net: dsa: microchip: replace unclear KSZ8830 strings
    https://git.kernel.org/netdev/net-next/c/23de126f9248

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



