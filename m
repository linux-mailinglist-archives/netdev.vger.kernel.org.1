Return-Path: <netdev+bounces-92307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749748B67EA
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284C41F23040
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8E6C132;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJQNYRvc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555B8BF6
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714443632; cv=none; b=T/8z5q6Rg4ZwSyULGCkGBh2SmmhotVTLwaUoD6nVH89Z/P48/zeqUBdakjOTlf2SRVzuzUzcGKT2v+fD7vyrSRe2X8NIkmUCnLM+ZlW1uwAFB3tIJ+/JbWYh4fsyz7tovb20RwZu731vb4zJuuq8DcbXI266gKgK/meLdmGTCIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714443632; c=relaxed/simple;
	bh=5s9NUzrFFe1YtxGu7LU6h2Xa1i9ZGkkmfOsQ28Cj6xY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eAtb1+CeLd47OVtmzfVhzj0yCkEuXN38tbeqXDRH1Py+LGtvD3IwiaGoF8j1ejEkoCSgUcmFileG7Cqa04Avs6gJTF4zEzAK9PQS5qRk3uXuNo3CQYPqOAdbWHLBo+BJ7Cz1jYcynPSPpmc+z3rKUzhMitKmQGqAZPaTpeT5v50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJQNYRvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31696C4AF19;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714443632;
	bh=5s9NUzrFFe1YtxGu7LU6h2Xa1i9ZGkkmfOsQ28Cj6xY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qJQNYRvcMaIrbTxMrrApDc/XUYCD2C7/81GixzaRHSu0LmM5GwDLcY0FoL7+mn5Vb
	 YADpvRfDTwcLN0lDjOiTyw+qLNDHrPueiAO30lRrDEw0L+VTUdmafQxHu/GUdh31K7
	 5ccX38+s3HBhejJY3fjbfzK6jSkprlSjt+9O7ipUxKst2cJ2OwTq6tL6XyXxpdIULo
	 O0x4+b3O+Xe+nnHkdSgRBYV0nbekIXhsGUm/rhH8u9eTLahzYY+UA/nNeMVKTCpaUt
	 Irn2mRomKNoAyLkyx6nVfUKueaFUCTuRoQovg+nFs6KULQbEl7uuwyouDiz2QSay6n
	 RYjJjH25GR6QQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 213D5C54BA4;
	Tue, 30 Apr 2024 02:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: dsa: microchip: use phylink_mac_ops for
 ksz driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171444363212.30384.6766303891232802654.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 02:20:32 +0000
References: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
In-Reply-To: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 woojung.huh@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Apr 2024 17:02:05 +0100 you wrote:
> Hi,
> 
> This four patch series switches the Microchip KSZ DSA driver to use
> phylink_mac_ops support, and for this one we go a little further
> beyond a simple conversion. This driver has four distinct cases:
> 
> lan937x
> ksz9477
> ksz8
> ksz8830
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: dsa: ksz_common: remove phylink_mac_config from ksz_dev_ops
    https://git.kernel.org/netdev/net-next/c/8433c5833ed9
  - [net-next,2/4] net: dsa: ksz_common: provide own phylink MAC operations
    https://git.kernel.org/netdev/net-next/c/95fe2662c56f
  - [net-next,3/4] net: dsa: ksz_common: sub-driver phylink ops
    https://git.kernel.org/netdev/net-next/c/9424c0731355
  - [net-next,4/4] net: dsa: ksz_common: use separate phylink_mac_ops for ksz8830
    https://git.kernel.org/netdev/net-next/c/968d068e5476

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



