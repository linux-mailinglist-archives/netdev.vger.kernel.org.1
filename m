Return-Path: <netdev+bounces-246168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7682CE4A19
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 09:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3400300532C
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 08:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F0C277C88;
	Sun, 28 Dec 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFzKUC44"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07D2264B8;
	Sun, 28 Dec 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766909659; cv=none; b=dGSWTkgQipjQ5x1SfP8g52dXrpH7nfmxXbX5WdFzQn4Debxr746tW5Dyy+o4XP+GrphRMS56H9o8/bzGNISBySgIPBpHIPZ3VGQLPe/VbqwwIXt2GvhDXoDfvdhjL/sIoe9eXM4TZu5v9Kwkub5mp3SrLhL8jsB6epMcOu2Qi80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766909659; c=relaxed/simple;
	bh=RgPlcrJL2qc5lDmfQILLTZsDGhBsQyId8WOOSgS3640=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ff52U+Aq+u4kadamD1Qjun1fUxnX1DTljK2Xjz94jhEo3yxsTUTOvxz2PPXH1Ag18y0hfmHbcnQaSJhpV58AeDJHnDXpi9wHkdCyDS8RFFInohVRsciENd82nrv9wy7BDTWJbVdF6joDTZIs7nKSbVV4k2wP8Xsf3kZ/QVuaRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFzKUC44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B2C4CEFB;
	Sun, 28 Dec 2025 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766909659;
	bh=RgPlcrJL2qc5lDmfQILLTZsDGhBsQyId8WOOSgS3640=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gFzKUC44G5YtXcK8TkjKDqDgoDNzFt+V9HdtVU9JAg1gxRas2/ugIpMr3b1CxA18c
	 7n39V2Xr0EeayztvkqyMNuimo8ZfGVDOAMDkcOVAl/CAJfBQpqRIrkO/ayL1OyvOwf
	 +GbAXSvJ/JZQeC9jUwdr0jG1qZjLN1oQcqmkwbE9QZ4nujlQ3rdhQDrKkXgM61Fsnp
	 kNrzEb4pX2kn0D9YTcNCSAxFRgINySsA8+HWzvzX+Zu/nWxlvB+VOZv6gS+/Gs+U+v
	 jUJzfVimjXm697oQ6RIC8zSeTZGeZx+4drOSiLtxpm4cG6qZA3xJQZ6DiXI7GAYvMo
	 Zlc7zVrawC3GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B57D53AB0926;
	Sun, 28 Dec 2025 08:11:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio: rtl9300: use scoped for loops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176690946258.2286348.10433027050448715125.git-patchwork-notify@kernel.org>
Date: Sun, 28 Dec 2025 08:11:02 +0000
References: <20251217210153.14641-1-rosenp@gmail.com>
In-Reply-To: <20251217210153.14641-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, chris.packham@alliedtelesis.co.nz,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Dec 2025 13:01:53 -0800 you wrote:
> Currently in the return path, fwnode_handle_put calls are missing. Just use
> _scoped to avoid the issue.
> 
> Fixes: 24e31e474769 ("net: mdio: Add RTL9300 MDIO driver")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/mdio/mdio-realtek-rtl9300.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net] net: mdio: rtl9300: use scoped for loops
    https://git.kernel.org/netdev/net/c/a4f800c4487d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



