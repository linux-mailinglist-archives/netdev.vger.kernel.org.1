Return-Path: <netdev+bounces-145171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8203E9CD5F7
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EABB23B4E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E0617B427;
	Fri, 15 Nov 2024 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz/QCJTk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21C17A596;
	Fri, 15 Nov 2024 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642024; cv=none; b=SBiG/n/8h1C9uNZI8P7snO8bXpg8Od1dGFPcdXDHaEgejSqUou0BTRc6+tXQKgRMXBvdI1N10RcgxRnp3tkluuXhondWsO+sf6iM9a2PpCB3+dpSUZFFbJcPsSRJxV/UGxC5qtXts+qxn7iT6IWhh4VQ2MDtignXOi9Y4woYpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642024; c=relaxed/simple;
	bh=f0ZQsNAzzD5s1aH0RpbD7imVYadO9+UqQZvmGcVGCNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RIDhykX8Y1sRS0LsXtRgavn1EtCF7ExvQVr2gEBCPITklNkFvY5BnCdrLN1FfAyjV68YhaGNYLp8RVUAWx41/MBod0QPhCJixLKeMgmKh6rkUjHB5cqaDOXnrcnhYOmbRayKHP+LWRBYfR2W8CNGvLickWykfeq+SnSnavs1XPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz/QCJTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08CEC4AF09;
	Fri, 15 Nov 2024 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731642023;
	bh=f0ZQsNAzzD5s1aH0RpbD7imVYadO9+UqQZvmGcVGCNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dz/QCJTkz8kQNoEOJCyPWN5ndC8Rh8nS+XhkQHWVp3d947FQh2FyrWTvRQdNzhroG
	 iTygW/apJ5mMLFgT6d3nbyzkyA3oNikggmdG9Y/fnUcF0Irs/9aSuF/rY98ZP4uySf
	 Kqgb4+dLLrfn5hRypQce0g6XC8/ne6MEjxoGU3PA7cVDJPGPjiHSQnWgHGeOMyEF/d
	 Xpi6k3GvlRRPzMk9sxksedlx9hHuYGxuLNwoskxMH5buxD3Oa7gVuwUBioHL4tpUs3
	 8g0+pfKR5wlagkEdbwtSMP9/9n1yjx9yKehLohFD8yU+lDMBv4UcP6pIFOnaatX6oU
	 MLKyED1y5AzAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AECEA3809A80;
	Fri, 15 Nov 2024 03:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sparx5: add missing lan969x Kconfig dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173164203424.2141101.17831622786298437732.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 03:40:34 +0000
References: <20241113115513.4132548-1-arnd@kernel.org>
In-Reply-To: <20241113115513.4132548-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 arnd@arndb.de, jensemil.schulzostergaard@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 12:55:08 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sparx5 switchdev driver can be built either with or without support
> for the Lan969x switch. However, it cannot be built-in when the lan969x
> driver is a loadable module because of a link-time dependency:
> 
> arm-linux-gnueabi-ld: drivers/net/ethernet/microchip/sparx5/sparx5_main.o:(.rodata+0xd44): undefined reference to `lan969x_desc'
> 
> [...]

Here is the summary with links:
  - [net-next] net: sparx5: add missing lan969x Kconfig dependency
    https://git.kernel.org/netdev/net-next/c/4c54e9497d9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



