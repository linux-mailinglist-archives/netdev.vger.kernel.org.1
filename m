Return-Path: <netdev+bounces-150947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B599EC25C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6AD0168BCC
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651A71FDE1E;
	Wed, 11 Dec 2024 02:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svMowYqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7A1FCF78;
	Wed, 11 Dec 2024 02:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884822; cv=none; b=fwhNOhhrcuhRfz5L7G/yeYY299HrfCxr9P7GpNVgbSFEH/R5aK5eSIjzZS/kUCxXhO0od4sBB2NxNHXC4Xd8psbJuVSqavqYATD3sWIgGGgLyypGMHzfC2DFXd92Fi450APDZPje5h6fYg9iYOZ+GzCERojfAwsBQ9E7eIJb910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884822; c=relaxed/simple;
	bh=8cIQXMiCby+3yuGNOfE5BSFWLVI70HuzLn9UPvD2Hdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hCl7oD/QXMWYjqNdVRKiHezqwgYi4Qa/eqSKCISGu6ZRjLaMXtTLVfqo5Zb/fDv+cooez2VnhRS9xocug7a6gfTT521/zmEG85odZxHzhM+BT0b1QP2jeun0pfcx088ER9Vls8Bm+BhW2YkdQ684O6Ek/Q9tfCb7gKkty0qgWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svMowYqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD386C4CED6;
	Wed, 11 Dec 2024 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733884821;
	bh=8cIQXMiCby+3yuGNOfE5BSFWLVI70HuzLn9UPvD2Hdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=svMowYqC0ePX6rl1zvfxXUVeVllEGcQCv6NyKN40gsgCpIkxd/XKocgQR+Al6d7hG
	 xggt7ajn5R2pcWfEd7PqmZnSOyZQHNeK8uADxIYLIh2ikAD5NSMJV8DE0LVlctTToE
	 psGusYWoLF4/PM+lBpwRo5ygu7SLDZo8BU+L3x8SCdX33RM/BdoeKWLLf3bhzzpUFJ
	 DydOoImLxLldSUBNLxiowhpmDkHTKk/TKjlsu+G34G4M3K2z5GxNha2lT9JGEdW8gM
	 mMYNbNnxV054zl5WTYG8K6wgFHa3eHrBRCA8gYcmAHx8bYn/erBxNywaGil9GohT5N
	 sL+hqlecL4Ouw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD7A380A954;
	Wed, 11 Dec 2024 02:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: dp83822: Replace DP83822_DEVADDR with
 MDIO_MMD_VEND2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388483774.1093253.9609358542133634563.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:40:37 +0000
References: <20241209-dp83822-mdio-mmd-vend2-v1-1-4473c7284b94@liebherr.com>
In-Reply-To: <20241209-dp83822-mdio-mmd-vend2-v1-1-4473c7284b94@liebherr.com>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dima.fedrau@gmail.com,
 dimitri.fedrau@liebherr.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Dec 2024 18:50:42 +0100 you wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Instead of using DP83822_DEVADDR which is locally defined use
> MDIO_MMD_VEND2.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: dp83822: Replace DP83822_DEVADDR with MDIO_MMD_VEND2
    https://git.kernel.org/netdev/net-next/c/4eb0308d78d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



