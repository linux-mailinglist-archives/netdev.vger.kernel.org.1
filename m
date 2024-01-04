Return-Path: <netdev+bounces-61499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F6F8240A9
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76B22824EB
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5988421112;
	Thu,  4 Jan 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IusnRF5j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407592110D
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 11:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0D2CC433C8;
	Thu,  4 Jan 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704367827;
	bh=qLjZf7N+jpNBK5VvIxQ9Nf/5qOVll0H9xaqA3R9jzic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IusnRF5jFHr/PzLudQWDDpgzy5LDRq+ul8QHNIdaHAWgfkQc78pJ5LK2JRot3KJER
	 FLk8T5R+LD5bzVYbMZOLrXKQ60L3SwtYbashEWmRNZf9pmxHvrTmLVGjSH0Ti/hsFf
	 gCgfHVoxSDwuvSEJgRXBasdTtGGhi24jXkUPVi6/6fde+SzuUKOA0Qk+LOyfKb/caH
	 Rw3UpNrRDuOMBoklr8EMRSeUAkpKIp61GrX0vonazyLm3JWHy/BlnsSA5Zri4nhL5/
	 e+DfFI809rsmBtrEDubkhGKwOXaqowRvsozI+dqlEgwdEoB7Pxm89Iwqmh8ggY2Ymr
	 HDQ/vrjn3TdhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5939C43168;
	Thu,  4 Jan 2024 11:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio_bus: add refcounting for fwnodes to
 mdiobus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436782773.30686.8500264953951614207.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 11:30:27 +0000
References: <E1rLL6p-00EvAd-Ej@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rLL6p-00EvAd-Ej@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, luizluca@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 04 Jan 2024 10:37:55 +0000 you wrote:
> Luiz Angelo Daros de Luca reports that the MDIO bus code maintains a
> reference to the DT node, but does not hold a refcount on the node.
> 
> The simple solution to this is to add the necessary refcounting into
> the MDIO bus code for all users, ensuring that on registration, the
> refcount is incremented, and only dropped when the MDIO bus is
> released.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mdio_bus: add refcounting for fwnodes to mdiobus
    https://git.kernel.org/netdev/net-next/c/3b73a7b8ec38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



