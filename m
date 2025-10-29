Return-Path: <netdev+bounces-233750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ED7C17F36
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D121C219DE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC552853FD;
	Wed, 29 Oct 2025 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkw0U1/d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D5023EA80;
	Wed, 29 Oct 2025 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702632; cv=none; b=TputvrQVtW+h+IDlR/D4fkdF1in8+SaJQ4Z2N7ZLu9dopxI7DwHR2eHOX9N1ugtPE+leNYE8YAk7CMpLsjPhTEmEnNjgE5NaRgqxArCIASA/e2FZWOC6S6g+SvwAC1aCOWKZ6uUjSBESaM4kMLlADRG53XDHN04kS+mDuRBrRY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702632; c=relaxed/simple;
	bh=7HoWnbYTpgAaMO2MzRwhUnmcQoyFysyjoG0bhEAQqXM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cz67f2O1TB9x1Gka7QpPwSvWcjLfbO3cF748K6vkQ8myJQksgsQoPpDjGk/gZdBDKn4YulxayaO6p0taOewSvY8jtQ1V8ElC0Dgoa+ZIHsCGSWkt7L1FmqtbapG31bdffuIYGYVR+9VWA6Z/k7GTSsqVumRqjSMgUrRBe/gqFno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkw0U1/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F56C4CEE7;
	Wed, 29 Oct 2025 01:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761702632;
	bh=7HoWnbYTpgAaMO2MzRwhUnmcQoyFysyjoG0bhEAQqXM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mkw0U1/dAMVR08eIQ7+mjgKn0rMLYexAJP5nfJA37fJSh6dZs37klYC/mSXh4Hozz
	 R2qi82mOp2/A4U7sM6INcLvII5X5Ssj5vFGsfkvfmWMxP+Es/3ugZy/YUpzvkpV3jQ
	 hAXxq6eb5swCt9O5hf/oPwqpHBvAY/xRQXyOjFxtA1wkY4aK3EoUB4Qce8F6QDv4ut
	 hGgqMSnoc5N/DkqdppQhgkagWUgZh8THUdeuWClAPGzvmFP8ZXQn51BUgcv3qbLPc2
	 knb0Jjq+dsxpOZcsIGOzervRCz4dvD61ko+q1md76cFiLAKo9Iw4+CtpBaOFDyoFw+
	 p1YXUVUuPXcvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF3139FEB71;
	Wed, 29 Oct 2025 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: realtek: Add RTL8224 cable testing support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170260974.2460121.14328478354659029522.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 01:50:09 +0000
References: <20251024-rtl8224-cable-test-v1-1-e3cda89ac98f@simonwunderlich.de>
In-Reply-To: 
 <20251024-rtl8224-cable-test-v1-1-e3cda89ac98f@simonwunderlich.de>
To: Sven Eckelmann <se@simonwunderlich.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sw@simonwunderlich.de,
 ih@simonwunderlich.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 11:49:00 +0200 you wrote:
> From: Issam Hamdi <ih@simonwunderlich.de>
> 
> The RTL8224 can detect open pairs and short types (in same pair or some
> other pair). The distance to this problem can be estimated. This is done
> for each of the 4 pairs separately.
> 
> It is not meant to be run while there is an active link partner because
> this interferes with the active test pulses.
> 
> [...]

Here is the summary with links:
  - net: phy: realtek: Add RTL8224 cable testing support
    https://git.kernel.org/netdev/net-next/c/61958b33ef0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



