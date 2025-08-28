Return-Path: <netdev+bounces-217549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADCB3903A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69583641DE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9ED19ADBA;
	Thu, 28 Aug 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBDH3p+P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A4C13EFF3;
	Thu, 28 Aug 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756342199; cv=none; b=sysCplvEC0jXoZodJ4IcQtgxmkNwB/a3YgttjhdfQr6qO24PJZz47F3RrpkQF8Krs9QLqJxq5Qp2GVyzuazdCyrN2Vj8QHSAt8XhEMFw/LFYVc6kGLjelGqo+Yl+ac0LSgjHF+y+378TeQS8WQ2MtUkjD5cUrkZ/61Um7gBGQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756342199; c=relaxed/simple;
	bh=qOJT2O/P45y1TMQ19RbfaBGaSVM7euzDXVZ+E+zezvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dJY2y3BYjj49p6Hpd3K/4GD+lAoCZewNy5nNuXvvAQTkXhsFdC84AE0dYTHGUv6equ3U8+6MnzusHAGKN43IiO7srh+vv0uyPyZ2K40k+6HXp3C3PVYjP+UmftYQw8uQFp6cTLgWP6PidJHAAr+caHx0L+Pay/6UA79YIzf+92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBDH3p+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35693C4CEEB;
	Thu, 28 Aug 2025 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756342199;
	bh=qOJT2O/P45y1TMQ19RbfaBGaSVM7euzDXVZ+E+zezvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bBDH3p+P2+FEn+Axe0gXs9DyscQRI25EcxY6ZamYBueHYgiipm+bu40cS4vHRJVbF
	 pwURqylxH5UeYXNkrsEhUXq7+2OtEL2//QQaA64bwX0ZVIzJh7vW3KsayshGZvy6qD
	 ChOn5xOdeid2fYzrkzxeCds/qt6MIz9h8GH0CSnoE0IeLniZ4d9kDJfyE0u4Om9DjO
	 2cf6HnuyQIJAuhzqlL2AlY+7n+tBwMMOwa0qSME8WPXAQpp3jZJv762qFcb64QKpQ0
	 doEEKsUtArrp87qIiocyiVnkttzQixC79vQT9/I2xegnqQwdv5thNMn67b14qr3OUc
	 mhex8l5fOce/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE08383BF76;
	Thu, 28 Aug 2025 00:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: sun8i: drop unneeded default syscon
 value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634220652.891202.7808539694253002110.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 00:50:06 +0000
References: <20250825172055.19794-1-andre.przywara@arm.com>
In-Reply-To: <20250825172055.19794-1-andre.przywara@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, wens@csie.org, samuel@sholland.org,
 jernej.skrabec@gmail.com, clabbe.montjoie@gmail.com, paulk@sys-base.io,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 18:20:55 +0100 you wrote:
> For some odd reason we were very jealous about the value of the EMAC
> clock register from the syscon block, insisting on a reset value and
> only doing read-modify-write operations on that register, even though we
> pretty much know the register layout.
> This already led to a basically redundant entry for the H6, which only
> differs by that value. We seem to have the same situation with the new
> A523 SoC, which again is compatible to the A64, but has a different
> syscon reset value.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: sun8i: drop unneeded default syscon value
    https://git.kernel.org/netdev/net-next/c/330355191a2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



