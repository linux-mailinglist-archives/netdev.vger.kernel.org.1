Return-Path: <netdev+bounces-181867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B1A86A97
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 05:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7CF7B67F1
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 03:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9706F171E49;
	Sat, 12 Apr 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFHwJu4I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07517C77;
	Sat, 12 Apr 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744428601; cv=none; b=o+poQa2whDHdBFTmBOZLMUkVbGn5OxfuzT5LUJd3F17TEPj0kUHX/kOaG740svbuK+u/chthslFCK2NVGs/bMB/BL2AIMq/17vp/jtB9HHJKFG7zK2qkAkDHP08Ldh08/afuAAcihohQJlskmtSuq+egzZKdcMEygPqandV7qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744428601; c=relaxed/simple;
	bh=iTao/PD4wBGBtQXKQE7u/ERT3gg5FuPO+Oacyr84mXQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=loW/h/HH78hf6YNlIS66RyuLS9rl/PPix7ZMI6oczG/MvhOwlzRvsfRSG86uX1bXl+XJy7SmJrnJ9gIgGIC4Ktn9E7hiAndVj2k1hGvgT3NAf+aTJ57Y0G4kW5Gkw8bNTj2WBaz6eutqiEXeoKzOII7Z4Ukwu7LHpUaOGsLRG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFHwJu4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26978C4CEE2;
	Sat, 12 Apr 2025 03:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744428601;
	bh=iTao/PD4wBGBtQXKQE7u/ERT3gg5FuPO+Oacyr84mXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kFHwJu4IUwdbRkhKVEo44qRC0GXdUmi3QC7g810KAghAEq44AVxoz90arTMBkkr1d
	 1iEUAiwKFkTUq8W7CeP0l0HnNUfHP+xfy2wmzE/zKYeAMdBpCsaDFXOW9VfRB4mY9T
	 oqRagmHrB6ZSZXKcLqnxU7DKeUPD6YGe8hH09rlv4dmbTHYkSD99Vco16kM8NbQcKP
	 YAe8zja4ZWvFiou9YVPrimdwxNviIyWZO8J2UR9xYF2ihxIlg+H7WgaiFuLUfPbvBX
	 0d4JDl6wP4L1FrsVJbscPD4T1J7ksaVFLD3qsWPIIYiaRsgU7cR6Z/yN9ZRb8ImL3x
	 BS3yBQA5976BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEBBF38111DD;
	Sat, 12 Apr 2025 03:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v2 1/2] net: phy: mediatek: permit to compile test GE
 SOC PHY driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174442863837.564205.525702135577856818.git-patchwork-notify@kernel.org>
Date: Sat, 12 Apr 2025 03:30:38 +0000
References: <20250410100410.348-1-ansuelsmth@gmail.com>
In-Reply-To: <20250410100410.348-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 rdunlap@infradead.org, horms@kernel.org, arnd@arndb.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Apr 2025 12:04:03 +0200 you wrote:
> When commit 462a3daad679 ("net: phy: mediatek: fix compile-test
> dependencies") fixed the dependency, it should have also introduced
> an or on COMPILE_TEST to permit this driver to be compile-tested even if
> NVMEM_MTK_EFUSE wasn't selected. The driver makes use of NVMEM API that
> are always compiled (return error) so the driver can actually be
> compiled even without that config.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: mediatek: permit to compile test GE SOC PHY driver
    https://git.kernel.org/netdev/net-next/c/e5566162af8b
  - [net-next,v2,2/2] net: phy: mediatek: add Airoha PHY ID to SoC driver
    https://git.kernel.org/netdev/net-next/c/6a325aed130b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



