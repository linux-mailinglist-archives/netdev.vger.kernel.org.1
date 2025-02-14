Return-Path: <netdev+bounces-166577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B3A367C8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8577A50D4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB141C863E;
	Fri, 14 Feb 2025 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkPZa+0U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986F1C8627
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569810; cv=none; b=XDuMnwyAjUYJXb5QaMSU5vzBmlljoOMZDnwTJUSh6DF40w4pMkZmo4hlvR9JeSodyJGtgpumlINGKJtu5ygBidIpjOya6+nNXdGNCveL+XvNfQpqoEYBz5FgIj+GHEfAQ6Nac97/59zXSfAqdpJaidIpv7n4W/+NOt7fHc0MUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569810; c=relaxed/simple;
	bh=z1h2wB2bK+0PVbZBqeWldkozYIvTn5nsgGbyj9aRZYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MUut0t85E7h32cNQcg0b8rRcaMfjxWcpyMJD5Q7zIHIbtPAPg69Ml7/NUCCuL/tcAhowfvVc87VgGag9Pjpt/1zr4RuSLXl1MO9PCHKYsh/ZrI8tzD6ht8rG7uo3kClmkEbiT3Lanvtc09BsKUQAXusmJnQC2AuJ12OvY8QDLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkPZa+0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398C2C4CED1;
	Fri, 14 Feb 2025 21:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739569810;
	bh=z1h2wB2bK+0PVbZBqeWldkozYIvTn5nsgGbyj9aRZYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DkPZa+0Us/PS8WiwvVjjlaCwyWXc39w7PpXtnVy9xncj1wibdPRNJVqFI3npd32Du
	 xM7CjMfqg0sR8iPN8guuzGZR3U2mvHbeJqJOHVB3HjuDHi2wrmB0dXDBxG1f5S6F2+
	 77jm573zI+itiQ/I7q1YxWW5NTB1TiH+B+bAt3tBIywq2hi5zSh7yoxxoT2YetENRS
	 qtLCuayVtgTVWr7IOwrdKWQAsxdXKDLf9ks3xGGejmcf3q8Z7Pwea4NnxzQJcOexQb
	 B0k0quSPRodsnc575vpREpeK5pv+kfKAzUyV9bVyTSKbXgU8AcBmKeqQgW16Qs4mhO
	 kSd+tlqPxtY6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3C2380CEE8;
	Fri, 14 Feb 2025 21:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] net: phylink,xpcs,stmmac: support PCS EEE
 configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173956983949.2115208.7960791375454243091.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 21:50:39 +0000
References: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
In-Reply-To: <Z6naiPpxfxGr1Ic6@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 10:52:56 +0000 you wrote:
> Hi,
> 
> This series adds support for phylink managed EEE at the PCS level,
> allowing xpcs_config_eee() to be removed. Sadly, we still end up with
> a XPCS specific function to configure the clock multiplier.
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  7 --
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c |  2 +
>  drivers/net/pcs/pcs-xpcs.c                        | 89 +++++++++++++++--------
>  drivers/net/pcs/pcs-xpcs.h                        |  1 +
>  drivers/net/phy/phylink.c                         | 25 ++++++-
>  include/linux/pcs/pcs-xpcs.h                      |  3 +-
>  include/linux/phylink.h                           | 22 ++++++
>  7 files changed, 107 insertions(+), 42 deletions(-)

Here is the summary with links:
  - [net-next,1/8] net: phylink: add support for notifying PCS about EEE
    https://git.kernel.org/netdev/net-next/c/e9f03a6a879b
  - [net-next,2/8] net: xpcs: add function to configure EEE clock multiplying factor
    https://git.kernel.org/netdev/net-next/c/8c841486674a
  - [net-next,3/8] net: stmmac: call xpcs_config_eee_mult_fact()
    https://git.kernel.org/netdev/net-next/c/060fb27060e8
  - [net-next,4/8] net: xpcs: convert to phylink managed EEE
    https://git.kernel.org/netdev/net-next/c/5a12b2cf29c1
  - [net-next,5/8] net: stmmac: remove calls to xpcs_config_eee()
    https://git.kernel.org/netdev/net-next/c/dba7441b3916
  - [net-next,6/8] net: xpcs: remove xpcs_config_eee() from global scope
    https://git.kernel.org/netdev/net-next/c/55faeb89968a
  - [net-next,7/8] net: xpcs: clean up xpcs_config_eee()
    https://git.kernel.org/netdev/net-next/c/760320145a5a
  - [net-next,8/8] net: xpcs: group EEE code together
    https://git.kernel.org/netdev/net-next/c/1d4c99a1ac12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



