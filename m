Return-Path: <netdev+bounces-165350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5DAA31BAB
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D51888625
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E306F1487DD;
	Wed, 12 Feb 2025 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJArGJoe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26E13DB9F;
	Wed, 12 Feb 2025 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325606; cv=none; b=peJXYF7MxV5SMSmxnT+k3Y4lRXmzIGrq/CIrxE0XOxU0e7GgrwcIjSSVft8Zl4D1v/ENlZa+eqqfeWW/E3mKQAGJRbJHTjBkj3rXFpnaxtyXfM4OCUpR2SrUgyBz56lKRsxZU8fgz++opXMVi5qMMC3AGWkpoHGrPEZNBiwu5yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325606; c=relaxed/simple;
	bh=oilJiX+VeDtt6XMyhc6T4ILKvqJAoN3URIWrJE3VgHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QVqZ8tp629dv7GAAZCe4KJ5tFaSGvTVaquBZCUbOi7hNYPEEtorZ3i8l4nkgQquiqmXS1XZEWo4WgAVTFzYN6ITyUZeG/sSMfu8q1oX/3j2NGVCup2uxprzv55bRpTzFllKET8zCNQKc4XL5iELO/noaFzngIIifP3abXfys4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJArGJoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A86C4CEDD;
	Wed, 12 Feb 2025 02:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739325606;
	bh=oilJiX+VeDtt6XMyhc6T4ILKvqJAoN3URIWrJE3VgHU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gJArGJoeKrymHt+AHoegfgrxkW/c84h3HcxZgUROZHEyIDEdkCyqsoRJ083JvkSSE
	 d8GJs/1LNq1y9wjtcIbxMctRYIv41LmGXGZA+8ZIm7oLoY2USWfsEMh//El9wgt5LD
	 dBqRgJjKIh3zn18XULsttCm8xMU4nCR0FT4wS+OYkynFdHO1AjiPfJI6fNwiVEH0yf
	 GNg+nKkxdBW+jHGcNfyJfgmUC+ORjzdizUAf7Aj5zVndsKWALUnvY7bOfcTLj289Mc
	 +AxR3pqfG9D2TqB1gj7OJ4w1et01N6hCQ9nzsES0lFKiUag3inbe9qE5JoeZbVArPg
	 stj/h8xFDhlzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34084380AAFF;
	Wed, 12 Feb 2025 02:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] Use HWMON_CHANNEL_INFO macro to simplify code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173932563500.69529.13441437064879744393.git-patchwork-notify@kernel.org>
Date: Wed, 12 Feb 2025 02:00:35 +0000
References: <20250210054710.12855-1-lihuisong@huawei.com>
In-Reply-To: <20250210054710.12855-1-lihuisong@huawei.com>
To: Huisong Li <lihuisong@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, irusskikh@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 louis.peens@corigine.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 kabel@kernel.org, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com,
 liuyonglong@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 13:47:05 +0800 you wrote:
> The HWMON_CHANNEL_INFO macro is provided by hwmon.h and used widely by many
> other drivers. This series use HWMON_CHANNEL_INFO macro to simplify code
> in net subsystem.
> 
> Note: These patches do not depend on each other. Put them togeter just for
> belonging to the same subsystem.
> 
> [...]

Here is the summary with links:
  - [v2,1/5] net: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
    https://git.kernel.org/netdev/net-next/c/43a0d7f26ad7
  - [v2,2/5] net: nfp: Use HWMON_CHANNEL_INFO macro to simplify code
    https://git.kernel.org/netdev/net-next/c/e05427c4d138
  - [v2,3/5] net: phy: marvell: Use HWMON_CHANNEL_INFO macro to simplify code
    https://git.kernel.org/netdev/net-next/c/0cb595e80edc
  - [v2,4/5] net: phy: marvell10g: Use HWMON_CHANNEL_INFO macro to simplify code
    https://git.kernel.org/netdev/net-next/c/4798f4834b2e
  - [v2,5/5] net: phy: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
    https://git.kernel.org/netdev/net-next/c/d6085a23b3b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



