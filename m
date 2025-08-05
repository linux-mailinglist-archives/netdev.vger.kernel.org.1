Return-Path: <netdev+bounces-211639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5358FB1ABBF
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 02:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92C867A7A95
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF71DAC95;
	Tue,  5 Aug 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFFv1lk7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCBA1C8604
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754353809; cv=none; b=jKbQTwZX5VVTKcY2SpZcT+8YOFO62SJNh0s/kT7G5a1XE5+ssvEmudD64ZwAhU+V0pX+Oco/KDzVeZiGJOiYtTaScpZ8hoRkWxt2mwVDRDKzIPqej+pP6B4jsrK4OXIqzaX7Y5w1Ruk8pS7SKaXKwptA6ZgLtiC63DMjmSnJZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754353809; c=relaxed/simple;
	bh=6ex0L8BacR5uN/wRdRqQhHNsH3G1ubCxCVN7zJgPels=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JE3SDz75y75pNVHSoQioWkOtqZT/A83xnUQ9lsJdtoKnftOhW93YxCylNHyqZodOqnT0MuAgICB3xYZtROwuhkttE+wFxgu9PsYK0Vz0ADoRR2pByauQ/3I0YttdLDy3soNxw1ROc+XXKS4LSNu3xJ5QRDPGrBsaz8l5Grg0+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFFv1lk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34420C4CEF0;
	Tue,  5 Aug 2025 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754353809;
	bh=6ex0L8BacR5uN/wRdRqQhHNsH3G1ubCxCVN7zJgPels=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SFFv1lk7dEtVbWQeU+U29dI6QabEC+J7XpAu2aYSBqNmeIqe3VImzOWRIDxAl+l/p
	 uu4n1H+iSJ/7U3/+ftA0SAk9lD5e9B5jIGwlOiTpVdK0ZW78soK31fVzuPsPwmEMaN
	 /kxeQek0vAEBBIFtMmng6dfbZ7UHipFkoQgpC8EUYJFpPbhEVgIf6+nU5KZzpERPZC
	 IbpHNujnuabg489U/6I8JMYh9+7mWSd0uNs6KZ80OrpYxQ1l6pKCi5Rvmnl4tvmLwe
	 jXS9XZrtCYH2goycTeRSr7JrkeEV0lSrvY8s9gfXakySNBrUGcqHxAl/VzFgOXCHKF
	 Gwphy9sPz7yvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1C383BF62;
	Tue,  5 Aug 2025 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net: mdio_bus: Use devm for getting reset
 GPIO"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175435382325.1400451.12554167872248751085.git-patchwork-notify@kernel.org>
Date: Tue, 05 Aug 2025 00:30:23 +0000
References: <20250801212742.2607149-1-kuba@kernel.org>
In-Reply-To: <20250801212742.2607149-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 broonie@kernel.org, rmk+kernel@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, csokas.bence@prolan.hu,
 geert@linux-m68k.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Aug 2025 14:27:42 -0700 you wrote:
> This reverts commit 3b98c9352511db627b606477fc7944b2fa53a165.
> 
> Russell says:
> 
>   Using devm_*() [here] is completely wrong, because this is called
>   from mdiobus_register_device(). This is not the probe function
>   for the device, and thus there is no code to trigger the release of
>   the resource on unregistration.
> 
> [...]

Here is the summary with links:
  - [net] Revert "net: mdio_bus: Use devm for getting reset GPIO"
    https://git.kernel.org/netdev/net/c/175811b8f05f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



