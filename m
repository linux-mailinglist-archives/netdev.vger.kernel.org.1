Return-Path: <netdev+bounces-218038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6349FB3AEBE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD2F582DC9
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EA62DAFDF;
	Fri, 29 Aug 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buPHN44N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBB52D877F
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425613; cv=none; b=IHV8Mr8ieCL4XGXqSw3gxOEIcR6dRb6C/3Y2XBCftolfkUFXNbFXAw7VNN8+wy/dRf7s/GM9KfDNdJ14TghCUuAmKFdFMk4midQv9ifUe/1n/e4rtxK7JYi/v41nEF2yPlgVbS2kdxP4QN4U0Jlh9eyB3ZsTleII1tQlPnSOfR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425613; c=relaxed/simple;
	bh=bETuWeDYSHxG5nww5B4o0pHKicBEs80t5TggZjI5wc0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=efu/b0I6Jpc5fHa/Cbyucc/FCjbO8RbwmBDafdSW7mMxHzQAK2bTF/inLfc+DqgIcPn4EZs9zEN8b4h4LG7aXEk/WLYxH81XXlY0mJS/TZNoFzzIMC8JRJwHR/H89B/8hJ+DKwKUgsWTB7WsEoEvpilXLKjdz0HA3iVjyxz0ej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buPHN44N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078CCC4CEEB;
	Fri, 29 Aug 2025 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756425613;
	bh=bETuWeDYSHxG5nww5B4o0pHKicBEs80t5TggZjI5wc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=buPHN44NThUo0X1Bw3TUxD3TwQw23tPgjO2aYHD+cGOcZX6PqYaQ7DVjqjPphd7Hq
	 pt2SV3Z+42HCCe3iU7GyKx37D5bzK6PBHTLRrrrZU3l2quxFfSc1HsMZJbachSQfN7
	 HjBnhHvAw3sFzDY7PGiyjs1XvFlirbwzJxAsQPa82Tuaqf6a7RMFMT1Dqx8xg+5A6h
	 y67sBAJjvysryFYr0I8g6s1SCjqHtnjRcsF7mf7QwN+sotOk9jFM9OwP0kI9eDVeV6
	 X/uy3WHFICENpZCIT18v0iamnmEbNrC5JJLC7+o6f3PgvzrJxnAIDEsjBedM6TM4i0
	 CdmX4CITD0S4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FED383BF75;
	Fri, 29 Aug 2025 00:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: mdio: clean up c22/c45 accessor
 split
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175642561974.1653564.13238220645332323952.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 00:00:19 +0000
References: <E1urGBn-00000000DCH-3swS@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1urGBn-00000000DCH-3swS@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Aug 2025 14:27:47 +0100 you wrote:
> The C45 accessors were setting the GR (register number) field twice,
> once with the 16-bit register address truncated to five bits, and
> then overwritten with the C45 devad. This is harmless since the field
> was being cleared prior to being updated with the C45 devad, except
> for the extra work.
> 
> Remove the redundant code.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: mdio: clean up c22/c45 accessor split
    https://git.kernel.org/netdev/net-next/c/24eb86a8170f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



