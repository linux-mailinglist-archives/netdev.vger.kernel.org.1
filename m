Return-Path: <netdev+bounces-189944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E49AB48F4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAFB1757AF
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C2193436;
	Tue, 13 May 2025 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3hZCabm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41281922FD;
	Tue, 13 May 2025 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101004; cv=none; b=Hb2EHmjoU/s5RnYq5E0z/45eAGRZA+ycPsNeQZ1/TNPn/KuQeUpdmhpOw3btjgep95Ni2mncIYvdjg/Sy9TVgjF5XwRckcvQH09ZE/PjKlHddZte/ECwLy6lnAoEvzdE2gjpXvM/YO4Mt6h1SotoK6iGrIWlDFO1PiscaZJSUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101004; c=relaxed/simple;
	bh=2yLViFdhxJtXfL/1RvBc2ShZELLoLFBdEAaBvbdfS88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dGmHKjjwQxFk0Vnq9W5+6vK7iLnQBrxW8Hng+Fotf68+wSzjJj47ieBcwwrvAdqdG7epj655/+XrnE2BCYkOJ7/0eHLhWvfU2R2+bv5tZVTtSs483JpfIqE/JHmsDHuV3Q5oXRPBjlA7ttOx8WyENAzXZ9RJ/4L5xWtSgJHqRuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3hZCabm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53130C4CEE7;
	Tue, 13 May 2025 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747101003;
	bh=2yLViFdhxJtXfL/1RvBc2ShZELLoLFBdEAaBvbdfS88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M3hZCabmeUowcLFnnvduM9yblPvFhg+iK6Ol9rgMTuVt0qbOpJI7rY8tVJfN7o3+u
	 a5uT6FhKTAsD1yDYHXa8qGKSLmaLh+9gHasUeduIi/b/qKaTIQdPDxD+xjUWnPjwLV
	 E6gn/YPI2S+Y0fzfHKUpbQEu+Bqh3DNmUxeOxkNRpQ+Yfe+zJA5CDpkmXnYehkH3D0
	 rZmQbRHORUSzVGwPBWsd58JMxF/fuM2+91dpytJ2pR9fDazCWKvHLdEItyfss0rW69
	 XnjirvCGm07T8e8gZylc52FWayBd1u3I7i0WKmzwNA2EbvJKH5egA1wOsFaunryKf8
	 3zz8nkznXiKkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AEC39D60BB;
	Tue, 13 May 2025 01:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] net: phy: dp83867: remove check of delay
 strap configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710104099.1140764.3443141386410446022.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 01:50:40 +0000
References: <8a286207cd11b460bb0dbd27931de3626b9d7575.1746612711.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <8a286207cd11b460bb0dbd27931de3626b9d7575.1746612711.git.matthias.schiffer@ew.tq-group.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 May 2025 12:13:20 +0200 you wrote:
> The check that intended to handle "rgmii" PHY mode differently to the
> RGMII modes with internal delay never worked as intended:
> 
> - added in commit 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy"):
>   logic error caused the condition to always evaluate to true
> - changed in commit a46fa260f6f5 ("net: phy: dp83867: Fix warning check
>   for setting the internal delay"): now the condition incorrectly
>   evaluates to false for rgmii-txid
> - removed in commit 2b892649254f ("net: phy: dp83867: Set up RGMII TX
>   delay")
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: dp83867: remove check of delay strap configuration
    https://git.kernel.org/netdev/net-next/c/cc7734e03e81
  - [net-next,v2,2/2] net: phy: dp83867: use 2ns delay if not specified in DTB
    https://git.kernel.org/netdev/net-next/c/6bf78849371d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



