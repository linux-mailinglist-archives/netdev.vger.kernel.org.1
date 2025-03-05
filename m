Return-Path: <netdev+bounces-171889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C71EA4F363
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AAA188D76A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071D4136672;
	Wed,  5 Mar 2025 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeRb9AB/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D185E11187;
	Wed,  5 Mar 2025 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741137599; cv=none; b=HrdH4DL6HzWxvMpvTnOXOm8pCl9rCuoVdUB6Ma+Ykm6vvEWtCuQocEGKs5UQX5QBhfmTeYskJOoonlFL0HfOXM30FUPsqb26SgPsk/hJDPUqFoL7cO2aX9fgHt1VPStB/D7nJlOyAHOtfeoImgV1S0F1A7Nm8Ra2ND9dM97WrB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741137599; c=relaxed/simple;
	bh=Zo1aULGkAE1iQtalKdej5/kWzCNtDu/xrdwQwX+JEHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E/klvnAE5YmEJgOZDpRIHrfaxrYnpz7tA+Zz4pKJ0mnOGoZR6Z+8lUxBsZTM1Y0zuzHB7bIrBg+/UX0n6jt8o4GPj2STD93K/Sr2RTmV9xCbu0dB72+JAQfqudbo96Ulb41TQ7cjR11GqxB/FGhfnme9SqzOG4WxIH7aCmv2hqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeRb9AB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4240FC4CEE5;
	Wed,  5 Mar 2025 01:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741137599;
	bh=Zo1aULGkAE1iQtalKdej5/kWzCNtDu/xrdwQwX+JEHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qeRb9AB/dK9DxTDq3Tvy1mXCAEgv6QPsLIucgKLTT79XycFRf90j97Egn9o2ubQDg
	 /Hq0ILo7De2QZxOPHR33hK5REBVX6RFNhi9bk+J0loyC5XWIJmYn+5OlKbwFchGBgU
	 b8+n0obMSTlk+PPOmYIx28t8ukbrq9jyOVw131Y6ljzJZgh8RDKImzjSyzs3GlzOiw
	 jMlc+XDd14OD8Qft/rzQMrxu70AGRlJBU18iOli2nIHsD9qmqk0tuaN1hjeA9pESrP
	 T3H2kZjcIipz3GY6LTq7+OSU/ZULXAomdDWvrlW/wKikuRmmDio5wQNLoGclAx/MCW
	 23RaUrxik/WpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7106D380CFEB;
	Wed,  5 Mar 2025 01:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethtool: netlink: Allow NULL nlattrs when getting
 a phy_device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113763227.356990.18423879063180957214.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 01:20:32 +0000
References: <20250301141114.97204-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250301141114.97204-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, hkallweit1@gmail.com, parthiban.veerasooran@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 christophe.leroy@csgroup.eu, herve.codina@bootlin.com, f.fainelli@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com, o.rempel@pengutronix.de,
 horms@kernel.org, romain.gantois@bootlin.com, piergiorgio.beruto@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Mar 2025 15:11:13 +0100 you wrote:
> ethnl_req_get_phydev() is used to lookup a phy_device, in the case an
> ethtool netlink command targets a specific phydev within a netdev's
> topology.
> 
> It takes as a parameter a const struct nlattr *header that's used for
> error handling :
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethtool: netlink: Allow NULL nlattrs when getting a phy_device
    https://git.kernel.org/netdev/net/c/637399bf7e77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



