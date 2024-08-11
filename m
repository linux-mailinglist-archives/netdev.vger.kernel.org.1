Return-Path: <netdev+bounces-117506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790B94E23C
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BA1C20884
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B040E446AF;
	Sun, 11 Aug 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcs3Sfhi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A0C8E9
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723393309; cv=none; b=dWSvlTIoJ4qRrtIyyxKAtpqoP0GCKcSuBW982jwriKQHggAXptYMgnfrYJhVkTZ4L7W9dCKOxmb9sqAttWoeaAnK9qsxKxSPHwHZxoVJTqemmgasDj5OAOENsAnSXKTUI9ODMz5kJt0LPfIv/mfIW/iPxm5peQEZqPdN151uRiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723393309; c=relaxed/simple;
	bh=wrs78BZfEL2QOGTHcdaLIqCPvyyS7b2fP5G4GXvEDsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lwnda3S6QmxyYQAXnIwN03SKceUGOHEsmnldfHMY/nOuzv5pof2a8g6WndWAATrMuwvRCiARrmlGyrn/rfsbJ8gzC/IV3QQUF2ien3D8W6JDJgXYhwU1eGu3Xnc97O5APzz2qvF59VPXCgqNg27YzM9Gypk2rUCLN3j8fESzLJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcs3Sfhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D0BC32786;
	Sun, 11 Aug 2024 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723393309;
	bh=wrs78BZfEL2QOGTHcdaLIqCPvyyS7b2fP5G4GXvEDsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lcs3SfhivbvicPvrFLSvajix+n3IIkanNU2TuHYtAmBAoJAJrcrP7ErQ4aZn9+giW
	 GMj4yXe63bknXdWEk5LXFY0FI6ZAcPwXoYxBZKrYLRHTe5JEzqLuPTN6oiVoXIOwau
	 JHnrY1RoxQxwtbrZraWIEC4xNVdqBc+mPPWLyPsqx2Yin6n6ggHIeienN6Hs7cOB6l
	 NAWaJTrisQ55qvSTDC8LJRT1KnDuubZlVyuCWIvRriMCMOaMQx3nhbGiYL6aCCn9Os
	 73P0r+5zWND3aHwpjvZgLe2XSqNvvMKEuWBxsfbh6iw/NXLRcMvcklyRcnJ+FZ9erG
	 zaDIxKNbXVCnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C393823358;
	Sun, 11 Aug 2024 16:21:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: dsa: microchip: ksz9477: split half-duplex
 monitoring function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172339330781.220939.6785517478852733441.git-patchwork-notify@kernel.org>
Date: Sun, 11 Aug 2024 16:21:47 +0000
References: <20240808151421.636937-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
In-Reply-To: <20240808151421.636937-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, kuba@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  8 Aug 2024 15:14:21 +0000 you wrote:
> In order to respect the 80 columns limit, split the half-duplex
> monitoring function in two.
> 
> This is just a styling change, no functional change.
> 
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: dsa: microchip: ksz9477: split half-duplex monitoring function
    https://git.kernel.org/netdev/net-next/c/c4e82c025b3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



