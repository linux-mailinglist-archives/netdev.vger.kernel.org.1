Return-Path: <netdev+bounces-69452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FC884B525
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52611C2453D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5695312D157;
	Tue,  6 Feb 2024 12:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfBXdH3C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8943AB8
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221429; cv=none; b=luOdu3sq2rwLwMmzwGDUC9HYeK/ZDQ5PbmkCnlDQl2ClLXec09Ddy9AbMP+DF8EcrzdTMrlxNceIrbaGduzYAmJNXlzBH5a7c88Hrs6E2UU+g0qRDC8aiYs3VkUMntZJueLwBh9dk+UAsE/kFJ68X40cSIrGm3a/01sw3ZgUZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221429; c=relaxed/simple;
	bh=NoIB0YYdfgi2x61oGDDmdBcGlv4yKll9ediWiWPD6gY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QKgaWp8gXBYEK5TOwrwPB3G4+kwa0UtqNhte/gkXTBvPiU4wT7KZrkwHGplV8Fq6Y8K3BTIPyDpLA/zfcY1JKmXVOwAlC2GuHo4I1VqjTugiZE8WuWm2YkCNB8CoKfm2beNR1VPIz1JSCoR8x4bLaUTbEZyOWhiNv/yq+iSFsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfBXdH3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B37F3C433F1;
	Tue,  6 Feb 2024 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707221428;
	bh=NoIB0YYdfgi2x61oGDDmdBcGlv4yKll9ediWiWPD6gY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IfBXdH3CoRpPVvr3v0/iYv0hv/rQ7+z04qi6S6KTL/yVX2HZI6ISk03jeUuHdXz3Q
	 3ocfM9p8MxsVDqnIEmwDdkeCMJcZ4ixPf6Lkgu6puY5XIwnladQOfXnOuVyIslqwdU
	 70wQyoB3KKkCX7XQb/Dnw0X3aUNHjXUWntQbRwoZ/DjdPPzzH3dHmA9v2kdNcgB/Lw
	 fEk2m+w8nY7XsSMBJQRyPwWzH06pVUeLmb8TPhuoGCR3x4olmpY4BZghGB48QlUSPK
	 MogQET8Y+K/acAXmZjbVJIBXnxzefwdT3+6JsUlIbhCWxxKeICYTVUWbx7mFHb3oXU
	 sFljBcKEQiX0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AF32E2F2F9;
	Tue,  6 Feb 2024 12:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: constify phydev->drv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170722142863.5713.2764946066155223415.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 12:10:28 +0000
References: <E1rVxXt-002YqY-9G@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rVxXt-002YqY-9G@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, ansuelsmth@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 02 Feb 2024 17:41:45 +0000 you wrote:
> Device driver structures are shared between all devices that they
> match, and thus nothing should never write to the device driver
> structure through the phydev->drv pointer. Let's make this pointer
> const to catch code that attempts to do so.
> 
> Suggested-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: constify phydev->drv
    https://git.kernel.org/netdev/net-next/c/0bd199fd9c19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



