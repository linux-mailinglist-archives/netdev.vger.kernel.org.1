Return-Path: <netdev+bounces-99250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5598D4342
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E0B243C6
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB57F2135B;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwG0bzj1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91ED20B04
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034434; cv=none; b=Uqz9apP2wr+q96bYuEqIQrtWjtjs3pgdkbgczx0DJ07Zu9jR9jdWpdbE+EujbhDZqxpBvkg4/jExf4pYyQge9mLo5ydmO75olk/h6jQlcG2ob2E0UpUPZon2RkzJQYKUYPN+x+G9GKPzh9yE2RsAa1FP87ypJGGa0SsePrJfp/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034434; c=relaxed/simple;
	bh=EyvYRNvnKdW068kDb0Ki3TqfMipMNvlmZdP98Jj+Ye8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JjeeS21lT/Y+vlFNgH74gyf5C8DfySlfEhKEjLb7eYggA82nv9WEFhOZRp5Rlx5Q06TzY1TnmgIj9o1EozS1KkGaRe1AGNbrIyJxpc6iWKjJo0edoXOd9gl4ZH/2rJ2VANKCcWTAYsgrSGYJdbp1esHKMoTXHv5Iwsf7n8Avmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwG0bzj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3605AC116B1;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034434;
	bh=EyvYRNvnKdW068kDb0Ki3TqfMipMNvlmZdP98Jj+Ye8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FwG0bzj1CZfdH5PQT05xO4+07e5FZDBOrCDoeCZNi3VFiPtdYh8uQWZpEi4svzv2Q
	 qFY8Kpqj662mLjRZoTjVYpiBIBKumKswXKYBUmBpv5EYWk4rgYKnvnQHFMsilEwdcW
	 iA0JDA0xoNg8TzqCZzOXvrKR18mpYnXs5N8AROh+89Vkh3mNwdYTXfp7iFNsRSL+tf
	 UtD7fha8NrJ9QNqBaV5LKhjrSPsEbniGJnX6OSifoRTfZo3d1tWvXRSdG0pqsMqI3z
	 y9eMzjiu/53X/m1eKyDXzgcgMHGYNn899h7u3AYojnP+w70PbnmEcSSGdExKlvSzQM
	 McJuGVLR+rLyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29366CF21E0;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: remove mac_prepare()/mac_finish() shims
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171703443415.3291.470886317770353226.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 02:00:34 +0000
References: <E1sByNx-00ELW1-Vp@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1sByNx-00ELW1-Vp@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 16:05:09 +0100 you wrote:
> No DSA driver makes use of the mac_prepare()/mac_finish() shimmed
> operations anymore, so we can remove these.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  include/net/dsa.h |  6 ------
>  net/dsa/dsa.c     |  2 --
>  net/dsa/port.c    | 32 --------------------------------
>  3 files changed, 40 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: remove mac_prepare()/mac_finish() shims
    https://git.kernel.org/netdev/net-next/c/bbb31b7ae145

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



