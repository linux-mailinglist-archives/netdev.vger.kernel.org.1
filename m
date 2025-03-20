Return-Path: <netdev+bounces-176397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607D5A6A0C5
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FAD19C012F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728831F09B7;
	Thu, 20 Mar 2025 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+F657lF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF891E32C6
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457000; cv=none; b=umibM2Z0iIFQR+p2Jz8ZEmR4wzNF3OFI9G5BC9Di5u+7/KUkdhy322mq0NhOL0/hUtkBcDQ5us+lJ1NyY0Nyn5nKyBd1Y362oEY0XVhsLBH3utzgpdfGY3lIftJe3tnK0RlcVFwQqA0fypukNuMXuxEvsJ/yfWsarygZowjON0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457000; c=relaxed/simple;
	bh=cOwcSqEIBwnv9CSI1TRDkBzcayPcci6M5jUxRZ73/Ec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WXnsQqR86TuRnyUjXZCy26GXk6K/n/JICZy7N8ReLv31VjJDF/NpmDVpU//o+J38pwlOsvPGrF2msuhCafl9NmNVHtoe40N4G5icegQDDqnZy21fH2x9yH+RVvL/fvmcPVNpoLQ9nVHYYu1g9744khtadvd+Ime83OHbOQH3OW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+F657lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03AFC4CEDD;
	Thu, 20 Mar 2025 07:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742456999;
	bh=cOwcSqEIBwnv9CSI1TRDkBzcayPcci6M5jUxRZ73/Ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f+F657lFNrozShHcjQ1Sh7LripXGdAcGAQ3Jl06t8PpgxhE53P4INZp/2Ez902zUY
	 mKVXIysGqGTXPY4KmgqPQJLt429I0sPITXDrr04kg+9PIcT5Clm8/vG+XQVnwTV4ZF
	 RmxsvSgE0kbcmCCSgF1VLGfwsNNH3mEIlaJ1FaIKJNBz9rw1lr5RACZxOr2yEvehBp
	 kIZ4Kxy96l0ZEwM0gtqF5Qp4jW3UgGXV0qIgrSowB3sEEfJ4JbR9URqyCtGNu/SIEQ
	 vh0QeNN8wylb2s8+fCTp6Gwm3KCTbiszhogsDbWYmjuMxZxa7sHVTYdOTQ6is5h53p
	 q0vIghsTosUVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE47B3806654;
	Thu, 20 Mar 2025 07:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 0/5] Support loopback mode speed selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174245703551.1336672.1445153240508578190.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 07:50:35 +0000
References: <20250312203010.47429-1-gerhard@engleder-embedded.com>
In-Reply-To: <20250312203010.47429-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 21:30:05 +0100 you wrote:
> Previously to commit 6ff3cddc365b ("net: phylib: do not disable autoneg
> for fixed speeds >= 1G") it was possible to select the speed of the
> loopback mode by configuring a fixed speed before enabling the loopback
> mode. Now autoneg is always enabled for >= 1G and a fixed speed of >= 1G
> requires successful autoneg. Thus, the speed of the loopback mode depends
> on the link partner for >= 1G. There is no technical reason to depend on
> the link partner for loopback mode. With this behavior the loopback mode
> is less useful for testing.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/5] net: phy: Allow loopback speed selection for PHY drivers
    https://git.kernel.org/netdev/net-next/c/45456e38c44e
  - [net-next,v10,2/5] net: phy: Support speed selection for PHY loopback
    https://git.kernel.org/netdev/net-next/c/0d60fd50328a
  - [net-next,v10,3/5] net: phy: micrel: Add loopback support
    https://git.kernel.org/netdev/net-next/c/fe4bf60ffdff
  - [net-next,v10,4/5] net: phy: marvell: Align set_loopback() implementation
    https://git.kernel.org/netdev/net-next/c/1a0df6c96ce5
  - [net-next,v10,5/5] tsnep: Select speed for loopback
    https://git.kernel.org/netdev/net-next/c/163d744d020e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



