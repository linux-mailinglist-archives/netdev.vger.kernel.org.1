Return-Path: <netdev+bounces-171891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8905BA4F369
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796573A7427
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257711519B8;
	Wed,  5 Mar 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHZXLhlq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20561519A1;
	Wed,  5 Mar 2025 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137607; cv=none; b=a4fUo46yzy3CG8V44tToUEkrso1ol9uwwfl/TA/A5jSXNYtuqzuZ4YsdEo99gzOisaSTN4ZkoMZz8eCy4PJiTVLr+q7oMilktnbKr7t08r3D2KM5Lf779KTF3qE8QLphnR2NvCUEDAD7JShrIw7lVd9voKhtdNdCthqS0KpAg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137607; c=relaxed/simple;
	bh=2bT41wOgGM0dQY3OubedrgWzZBbizLWRIDcVaoWa1lg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SXn950KX/GYXxskCVNYJFPd3slSLehh/vB2mWhQ/b4nT7JbTp54H/OCM7FqkhVb9mANABNinoAZ6DxQkCf6K7+mVDS4fPu1IAzGVzTMC6ktLKNx489fMXcwPrJ9ndXgoNR7B4urBRN+iUjEsHQ5wa7SOd9mTDFDraAWMBf2gL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHZXLhlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0E0C4CEE5;
	Wed,  5 Mar 2025 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741137606;
	bh=2bT41wOgGM0dQY3OubedrgWzZBbizLWRIDcVaoWa1lg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NHZXLhlqV2FZ8NrAdRgjM82HkvqKolZa4JFy4QB5PSzzs5aaJpQiecoOSgRwGW38q
	 B4bu4yvythoB7gTM4YprLOs4mIgjzfbTnLTc1ALqHZGzoGghS+6DcYA/C4rISH5MjJ
	 bNU//xfJQncvlpMtFpWU5GnUMv6sjxd5Muc9e35OWoAwkbC03B2Bfg+GjaiUdtA9nV
	 mq2EjCDwX15NnBjUwzAZwvrPvolyY9Jv20pX7PgVWJn7w5bGzTYkTfrGe7UjqbNyrk
	 2ye1i7rQ2tlXV+zRsCw6uwqdyyKkldyeBDJ5niswKYSz/N2Hrgn3UK7dTPFrWPZ4l8
	 mtCN7dQ5GhG5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F26380CFEB;
	Wed,  5 Mar 2025 01:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dsa: mt7530: Utilize REGMAP_IRQ for interrupt
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113763901.356990.6788752081470910551.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:20:39 +0000
References: <221013c3530b61504599e285c341a993f6188f00.1740792674.git.daniel@makrotopia.org>
In-Reply-To: <221013c3530b61504599e285c341a993f6188f00.1740792674.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 chester.a.unal@arinc9.com, dqfext@gmail.com, sean.wang@mediatek.com,
 SkyLake.Huang@mediatek.com, ansuelsmth@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, frank-w@public-files.de,
 john@phrozen.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 1 Mar 2025 01:41:18 +0000 you wrote:
> Replace the custom IRQ chip handler and mask/unmask functions with
> REGMAP_IRQ. This significantly simplifies the code and allows for the
> removal of almost all interrupt-related functions from mt7530.c.
> 
> Tested on MT7988A built-in switch (MMIO) as well as MT7531AE IC (MDIO).
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dsa: mt7530: Utilize REGMAP_IRQ for interrupt handling
    https://git.kernel.org/netdev/net-next/c/254f6b272e3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



