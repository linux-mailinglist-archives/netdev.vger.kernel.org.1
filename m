Return-Path: <netdev+bounces-153811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165309F9BF2
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C89116DD5D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876DA226883;
	Fri, 20 Dec 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6YBf+39"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F16E225A57;
	Fri, 20 Dec 2024 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730220; cv=none; b=H08GW2jjVNP1kq+kGGZ6vlwE62k33dfBhGzFssSh3092DjP0szmbANV44n33UAYECTUOwNhIIHNmbjI+vZd/d5BaLUWwE6cD/QYqjVvnDpN7v1/HC4sFhZM9gpw87JhYd5KlVxA0Ng/HMZnE1uoC85FODfHRnG6sDjdMTDRbvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730220; c=relaxed/simple;
	bh=p6xNFKxjK/wZ6s/Ncz8uxG0uhBBRUTqjP7cm7xBq2VM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=raEIEfx0txmqvprETWd0129uLvEPBRI+2s4wviziNVQqtq0wp8vkWw8LSl7mpeOlILc6JP/LfoHL3LVT3SImkbpyu6kD6H9YkYRzCxEBgo+91/oXnk9JnL1CVU9koY/f2i7gq2xlneDK1lijTE1tOg9ZL466b8aBkRtkbDhZx8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6YBf+39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A1BC4CECD;
	Fri, 20 Dec 2024 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734730219;
	bh=p6xNFKxjK/wZ6s/Ncz8uxG0uhBBRUTqjP7cm7xBq2VM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r6YBf+39Sig4BG+HaDf9rMZ1YMoC8/fPcVWYf0eEOmbk8kG/WqUzlCLRM7T1oH3tU
	 0SC2py3hzBjeWUSQohPyz/QJmlXnVA3YfyxQZSuS6684WFzv+jzqtC7smpjPt0jd7u
	 srZx9OKkegvvB7LG3XItOg5H8lrY21P7Q0T3mpAuMYSigj3fi5n8GmxMuQfQczlc3v
	 QxGM7JXSkcjiLmHdVNAhppZs5L/1unYIk2B8zVz4NOLte+tBveKABrNa+3ovATInH2
	 8H1s2/nuYe4SYJ90syUq5iF3Z5z9a/OIy15rKai63zfpk6Rhsj4b97mBH9QLQ7bI5F
	 H2kj6V/e1PPdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFDE3806656;
	Fri, 20 Dec 2024 21:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] qlcnic: use const 'struct bin_attribute'
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173473023760.3026071.11543865744129947206.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 21:30:37 +0000
References: <20241219-sysfs-const-bin_attr-net-v2-1-93bdaece3c90@weissschuh.net>
In-Reply-To: <20241219-sysfs-const-bin_attr-net-v2-1-93bdaece3c90@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: shshaikh@marvell.com, manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 11:00:19 +0100 you wrote:
> The sysfs core now provides callback variants that explicitly take a
> const pointer. Use them so the non-const variants can be removed.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Drop already applied patches
> - Drop unnecessary write_new = NULL assignment
> - Clarify commit message a bit
> - Link to v1: https://lore.kernel.org/r/20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net
> 
> [...]

Here is the summary with links:
  - [net-next,v2] qlcnic: use const 'struct bin_attribute' callbacks
    https://git.kernel.org/netdev/net-next/c/3272040790eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



