Return-Path: <netdev+bounces-247543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4182CFB96B
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8191E301584D
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDE8405C;
	Wed,  7 Jan 2026 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs+PjrIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA02C3C2F;
	Wed,  7 Jan 2026 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749009; cv=none; b=NM8lkdUi9XjTZ9k/kmRCTc7Gau9I6azhT8JQib9DUnudZ2g9WelishnWjdZHJtVz7nQHEqaYHDQue1YYP48nZQgWkcGnWXJL67kcC5JNug0LjihCVUBO6+HCEQOLidh00CTK4PTXxVqmA8G9UDLrlX7pvNPo8+ByoXgX2YdJ5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749009; c=relaxed/simple;
	bh=WekDqgZtqkKfkrvVCpmmKae/JFgoUDTJyK2zOeI8kjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bf6WFsQSYYxFDZTBOJdGBllNi489A94Rg8t79uEILhJ8NWLp6enCrFGrHdXBtJKQT4izZn50G5qsgGRhJLs/5A7qzbMCzRE0ZlxaPg4AlfojpscnvQpacbVY2yIYrdRrUPpUlC7npfiE6KBoYf9lKYsqbuD1AGrc3vnnA9fGRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs+PjrIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47678C116C6;
	Wed,  7 Jan 2026 01:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767749009;
	bh=WekDqgZtqkKfkrvVCpmmKae/JFgoUDTJyK2zOeI8kjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fs+PjrIapaAgvbXjrQgw1dUanyFaJ74KFVptyUGD26MWqoGQ3zVxGMfOBNYVE+7n2
	 DTaY5/cOO3qlcQuu6qRSiR5SZhzbK6rBhPl802iYna5UyniLByZugjKgdGZR5FrQB1
	 oziJwkhMDE06XmGEXAOTXf0DZLs+dx1OeFAsHf5/3Y4TroQB1r/or6f+n39tT3x+kf
	 2Ba/OWGY0J+be5LjMd5hrZ/9FB9kxhG7HEy/Ab3XIPfl2aOff5YhoDotcUrPx8WSg5
	 jv7ruSTAAuIXA2ngAYmnrARflWLdJy3EecD6cP/ikorDH/VlTNWFG72RcEqHRzhqRA
	 sHio3Ov08JyCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2BB0380CEF5;
	Wed,  7 Jan 2026 01:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sfp: return the number of written bytes for
 smbus
 single byte access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774880679.2188953.327787991480765340.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:20:06 +0000
References: <20260105151840.144552-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260105151840.144552-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, jelonek.jonas@gmail.com,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, f.fainelli@gmail.com,
 kory.maincent@bootlin.com, horms@kernel.org, romain.gantois@bootlin.com,
 kabel@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 16:18:39 +0100 you wrote:
> We expect the SFP write accessors to return the number of written bytes.
> We fail to do so for single-byte smbus accesses, which may cause errors
> when setting a module's high-power state and for some cotsworks modules.
> 
> Let's return the amount of written bytes, as expected.
> 
> Fixes: 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net] net: sfp: return the number of written bytes for smbus single byte access
    https://git.kernel.org/netdev/net/c/13ff3e724207

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



