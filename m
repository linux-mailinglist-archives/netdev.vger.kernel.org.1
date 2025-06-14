Return-Path: <netdev+bounces-197683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E6AD9907
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2730B1BC130E
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ADA3FC7;
	Sat, 14 Jun 2025 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFsXDFZM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3582E11CF
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749860405; cv=none; b=KF27qXwxegCNWYgNMAF/Xs2J4lfJsRFPsvsOaX0oqskL8kHVyAx4uvpxZ9YCjaToxhfTj+AhRwTgWAU4NGeeQvT9UoV3et6+6DOkPe0ca8lSGs60bW3VAxJKqKUURdd+eZgooR8jiTC608NqBlJnT0deuxb5pzoMII9VBHHQpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749860405; c=relaxed/simple;
	bh=TQf7DovxfkiMlPVn555Wfi5RRB1XVfY1BU7L14/UYnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eYtfarKBbK+qbA1e7LmOV/R0HdrFXzogtqRIo3QWBQhtbBGx2MvFA2stKAMlDKHfSROczuetAE52m2oRZV1ZuR/qzXB0EBC2G64s2GoJbuyEzFvPa5aZOpc1Jzt4FDJrFyHTQfKIpa9hXLujp4m0dR6069Dv8ZUjRRQcnq4zxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFsXDFZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37324C4CEE3;
	Sat, 14 Jun 2025 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749860405;
	bh=TQf7DovxfkiMlPVn555Wfi5RRB1XVfY1BU7L14/UYnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bFsXDFZM8Hbh5gj0ND3+1ITeENhTadck4qfP5xlBbBc9dFBUAhvh0ARihbu3VGG/Y
	 S7RPMH8ZRSY14wbC3VQJZS8E/HDwNlOl9NHbb1ZWPvsmh29r+mq8p7T/D7oCPlTH4m
	 Etj7/DLBjDqXZ76IwknJ7YQlmBMGUX919caUOG1Py2Jhxx8GnWL6H4AntuhC4GZPYE
	 LZZ2ntvcPUUyno+Q9tzd1djCEumKp++K/7Za9s3wyg96aAxHZj/d0RA5iYmHJqXU1f
	 UgGx/WHSJx5Yp8EHRWD1bcFyovj1OvgZ+2/uY5gj6fE9uLedfglr1tWPxWWD3us/7x
	 0Peev16a1tOjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB156380AAD0;
	Sat, 14 Jun 2025 00:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: phy: improve mdio-boardinfo handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174986043475.936138.18267406889399863669.git-patchwork-notify@kernel.org>
Date: Sat, 14 Jun 2025 00:20:34 +0000
References: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
In-Reply-To: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org, andrew@lunn.ch,
 linux@armlinux.org.uk, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 22:08:47 +0200 you wrote:
> This series includes smaller improvements to mdio-boardinfo handling.
> 
> Heiner Kallweit (4):
>   net: phy: simplify mdiobus_setup_mdiodev_from_board_info
>   net: phy: move definition of struct mdio_board_entry to
>     mdio-boardinfo.c
>   net: phy: improve mdio-boardinfo.h
>   net: phy: directly copy struct mdio_board_info in
>     mdiobus_register_board_info
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: phy: simplify mdiobus_setup_mdiodev_from_board_info
    https://git.kernel.org/netdev/net-next/c/0893bf6bb414
  - [net-next,2/4] net: phy: move definition of struct mdio_board_entry to mdio-boardinfo.c
    https://git.kernel.org/netdev/net-next/c/db4920604a3f
  - [net-next,3/4] net: phy: improve mdio-boardinfo.h
    https://git.kernel.org/netdev/net-next/c/11d40db27155
  - [net-next,4/4] net: phy: directly copy struct mdio_board_info in mdiobus_register_board_info
    https://git.kernel.org/netdev/net-next/c/f59fdcef3a58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



