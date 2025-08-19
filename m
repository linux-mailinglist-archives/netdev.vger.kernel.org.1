Return-Path: <netdev+bounces-214799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D854B2B553
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 02:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65F11967FF9
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 00:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4C37FBAC;
	Tue, 19 Aug 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYOpZ+zU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A454155389
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 00:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563402; cv=none; b=AdNgV8KHq8Vi69nu2HPmvoKBh7LK9w8QNOfOpir6tqmFqhRAFd2t8fvRYeI98RZxYux87rYFdWAKMWqV6oKfT9aXJOBruxM7SVFL8IP5OPkpAgeOU7GHCWiOBpLy7kaLkwVktHNIoXUPmYFReP3zmViEh8vpp9yMXLsg7x3bhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563402; c=relaxed/simple;
	bh=V4IY+Nb+EseUx6orQ/yqWmUHE0XUMSkoKzV3mW+x3Z4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qPZVymxzb8hkFR4ZMO/NQ10L6/uZKm948mu7UHS5AH3VYGnHbPupYfRNvRTlJfJoTdU/tduzYm//TlnjKv24FHxABQLXOROZ7QGz9TDsSQ7Lzec5ek1ip9Rg4gmt37rz1QWksp73lUHmCgTmlU4FR8PGApjMeD7jS0b5b8IYF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYOpZ+zU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F76CC4CEF1;
	Tue, 19 Aug 2025 00:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563402;
	bh=V4IY+Nb+EseUx6orQ/yqWmUHE0XUMSkoKzV3mW+x3Z4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PYOpZ+zUHzlWl41jT732St+ZQ8VnPDImlFVRpycVeXgp4ak3etjzlUwYvG63es/o5
	 QhJQTstCyBYf0ni3PI94Lv0vAdg8Um01WMBiPu7JTw+e9cZnMVvVA9Xpo9HiHF8YLo
	 s23HU1cJjKJIWupIj23X3eL3GqNTiljQ6nQVQenL4V2HM1cUpVRF4HjCNk5+HumM71
	 DhNGR/aODbX/wc58UaxO71MlJP3CelsuxTUqCQ68sUA4phmxvDfebfuHhUk7OswLbl
	 vbCxSxI0wNK/aMirF2zZF0XdxhPG3QF7P0jUN5SrlOX1sqfiGaIiExRXAVhq2ilVEr
	 /dEmKj2qlO58g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC77383BF4E;
	Tue, 19 Aug 2025 00:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: fix RTL8211F wake-on-lan
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175556341224.2959470.2583633731619905496.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 00:30:12 +0000
References: <E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1um8Ld-008jxD-Mc@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jonathanh@nvidia.com,
 netdev@vger.kernel.org, pabeni@redhat.com, treding@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 11:04:45 +0100 you wrote:
> Implement Wake-on-Lan for RTL8211F correctly. The existing
> implementation has multiple issues:
> 
> 1. It assumes that Wake-on-Lan can always be used, whether or not the
>    interrupt is wired, and whether or not the interrupt is capable of
>    waking the system. This breaks the ability for MAC drivers to detect
>    whether the PHY WoL is functional.
> 2. switching the interrupt pin in the .set_wol() method to PMEB mode
>    immediately silences link-state interrupts, which breaks phylib
>    when interrupts are being used rather than polling mode.
> 3. the code claiming to "reset WOL status" was doing nothing of the
>    sort. Bit 15 in page 0xd8a register 17 controls WoL reset, and
>    needs to be pulsed low to reset the WoL state. This bit was always
>    written as '1', resulting in no reset.
> 4. not resetting WoL state results in the PMEB pin remaining asserted,
>    which in turn leads to an interrupt storm. Only resetting the WoL
>    state in .set_wol() is not sufficient.
> 5. PMEB mode does not allow software detection of the wake-up event as
>    there is no status bit to indicate we received the WoL packet.
> 6. across reboots of at least the Jetson Xavier NX system, the WoL
>    configuration is preserved.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: fix RTL8211F wake-on-lan support
    https://git.kernel.org/netdev/net-next/c/b826bf795564

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



