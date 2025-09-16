Return-Path: <netdev+bounces-223785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E74B7DE3F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8BA325EAC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBE12D4B61;
	Tue, 16 Sep 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN96c7Zm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760D2D46AC
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066011; cv=none; b=rCdfgkFV0TnOY/7a4foiXU+ZgAqtsF3FBho74slsUdd/iAa6fxJ1kuoY79Z5L3g4Bsg9Y44d3ZOttRE0CgC1LVEZ0oPFOdtlB006TJ+Nvj9sEI+rVB1CMjhnnhS6UKxEHs0pAltQ/0doFJDy/k+fv3P3j2CnZgs5WRRFwahGFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066011; c=relaxed/simple;
	bh=bV0J60wYyd89lBIvFVoGN3J81v5eo5jfW6fNE/1m88M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jrtbg2qWVVjuCkl416XV1tczuyzBG2J/vH/VYKH/jjGW70+UFDH8kwo5AIUlgsYo9YAdOvaFiLpE8M1lrrj2hKVWmWMLTwPj1JfgcrOD+ShAwV4sKVERRzdTa32bLrONfWQG5ZlK5OwgPrZN+tFLot9yVcYZvsGSR1+VyKtyv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN96c7Zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B41C4CEEB;
	Tue, 16 Sep 2025 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758066011;
	bh=bV0J60wYyd89lBIvFVoGN3J81v5eo5jfW6fNE/1m88M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jN96c7ZmofvONAG1wqsECm8Mz1j9SJYTnB+xeqDZ/qgFXc4mP0nl0TNFWrT9iWqOk
	 gOOIaZV2sDkiIYsD/Ysf1gnxmrS6hzR6zHZAH5DZcmFrZT15dzO/kQMWOHgf7zBBtA
	 0Y/kvRMw+HDcACA9oLQzfJYq7zaeEIzae4z3YSwdfuzab2igxBxAbLFY7Y3oVV8Vka
	 /Nnp+M6N44MzxWdLeurzMtL+0MNShbUwFuSLJJVPB9KursNWjOTVtH4vLQIIFLIK9d
	 xg9b3lTtHCzH3P6o8rWw5oSCLOppVx+GFulrd7WQlAz1LA5OrBeUDtdc2EKSXuBwKk
	 CiUw53Yyg3iew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7242639D0C1A;
	Tue, 16 Sep 2025 23:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: clean up PTP clock during
 setup
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806601199.1401398.2938069839255224498.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 23:40:11 +0000
References: <E1uy84w-00000005Spi-46iF@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uy84w-00000005Spi-46iF@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, olteanv@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Sep 2025 13:13:06 +0100 you wrote:
> If an error occurs during mv88e6xxx_setup() and the PTP clock has been
> registered, the clock will not be unregistered as mv88e6xxx_ptp_free()
> will not be called. mv88e6xxx_hwtstamp_free() also is not called.
> 
> As mv88e6xxx_ptp_free() can cope with being called without a successful
> call to mv88e6xxx_ptp_setup(), and mv88e6xxx_hwtstamp_free() is empty,
> add both these *_free() calls to the error cleanup paths in
> mv88e6xxx_setup().
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mv88e6xxx: clean up PTP clock during setup failure
    https://git.kernel.org/netdev/net-next/c/c94ef36ec9d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



