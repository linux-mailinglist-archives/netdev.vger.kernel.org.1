Return-Path: <netdev+bounces-109342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B234928070
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 04:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE941F21A94
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E747DF9C8;
	Fri,  5 Jul 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESQVLWuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC71862;
	Fri,  5 Jul 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720146628; cv=none; b=JzOljMVk6/blsN0+mWCqkfIWDZ7Bg9COjeCzxThEHq47OnEeFz5OVGw9+Z2VREdodMVcdo/L1sH7mCq8cRm6KUOfaDJJl9WRzKw238L4Fay77DpOXBwkT1zWM96ovOZAFvBC2a0RSuHrVKCORVdEiy04W2l8r+ZqQvpIYCtJTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720146628; c=relaxed/simple;
	bh=OG0jnfMsrsYkJOEeq2fiGpITMFALAP84+mvUjCJLqS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H87QGj9g1rWM0s02vQ8TfIl3kW1ZZHf3If4WEu9TZxkcLNXft4F1FiTr4AhLdj25N/uZEATQv7eaNrtRnZhPLhpH7okX7ymppK13MFSnebikyAy8azitN422U/gVzRKH9HHNhHMGdDMnqfUOb1vIHevM6QCLqYQ/WgyzzZHj0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESQVLWuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F5FEC4AF07;
	Fri,  5 Jul 2024 02:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720146628;
	bh=OG0jnfMsrsYkJOEeq2fiGpITMFALAP84+mvUjCJLqS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ESQVLWuuele1+yAJBvxJNgxlEpJREWBHgwJm4egu6ooaV+ecJt5h7LgVXt/65yUM1
	 0WOY0KPdZNgq+fHHm/WRFq/k6Y8J/ymF7nkXyxiocfmfDSROlCNXACFfHqecEt8Moh
	 z0EU0UvJr7TdnIXIAfP5E5kNrKoRMa2PRGJ4kAcVhbR8VR1dC2/qeJLYNui390YaMb
	 RyVsgyXgN89d+bMaq7LbUfVZMuK6jPO8r/fhTeg7k0mur25hPCsCn1AlGlZK/IIpWJ
	 yOsyycBYJQ8jgYy42Z/9ZNJc0+UFBgdFmztf1IsWkyMxIt3ee0ti7Kdw2jPFGhv4kg
	 8c5HeO2cbFZrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 409B9C433A2;
	Fri,  5 Jul 2024 02:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] dsa: lan9303: Fix mapping between DSA port number and
 PHY address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172014662826.21730.5141774575339835700.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jul 2024 02:30:28 +0000
References: <20240703145718.19951-1-ceggers@arri.de>
In-Reply-To: <20240703145718.19951-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jbe@pengutronix.de, sr@denx.de, kernel@pengutronix.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 3 Jul 2024 16:57:17 +0200 you wrote:
> The 'phy' parameter supplied to lan9303_phy_read/_write was sometimes a
> DSA port number and sometimes a PHY address. This isn't a problem as
> long as they are equal.  But if the external phy_addr_sel_strap pin is
> wired to 'high', the PHY addresses change from 0-1-2 to 1-2-3 (CPU,
> slave0, slave1).  In this case, lan9303_phy_read/_write must translate
> between DSA port numbers and the corresponding PHY address.
> 
> [...]

Here is the summary with links:
  - [net,1/2] dsa: lan9303: Fix mapping between DSA port number and PHY address
    https://git.kernel.org/netdev/net/c/0005b2dc43f9
  - [net,2/2] dsa: lan9303: consistent naming for PHY address parameter
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



