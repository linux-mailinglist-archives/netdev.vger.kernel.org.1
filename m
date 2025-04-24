Return-Path: <netdev+bounces-185335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119D2A99C95
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B8A460FCA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F91E4C96;
	Thu, 24 Apr 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kojRy9LY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002B46B8
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453407; cv=none; b=N+ZJul7SsQcNmW2rckB7QCzz/ivqefvZIIMfNm5RaFYDmcGY21tvPNvNT5Y4JC6n+L8cNLvCA1xQgp1Y3IHswPzbm4LcEOLv42N0gzmC+1a+AnztOMPEyve9/t3/xFU95uVIzSsmiwCcbRk+ZlkGT3+jiqbsLZDfjhtCFkLgiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453407; c=relaxed/simple;
	bh=jPdOnIhETRyYJZs3XLF9lRJf2LnTLt0FyqJnboMkS40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qUSimwhxdRyFmTvNaGFKbvEo1YRaPqHJH/pVmQJE+Du4//Kv4DnZ9ZL1JWjMFKxwAn++7DxfELakHnPbqYxz9v+CQx15Oj4dkpaiFX5isTb0vgPPI5eCmkY8+xGbzbdEJ3TKqg/BK5AWz9ausqMQkqsWwo06EgDYMswdhaHafds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kojRy9LY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDD1C4CEE3;
	Thu, 24 Apr 2025 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745453407;
	bh=jPdOnIhETRyYJZs3XLF9lRJf2LnTLt0FyqJnboMkS40=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kojRy9LY+hUqi/2BBwJsPOgk+ixdI/ifG2oXbTaZz+fuXQyx4nwF03y9rIgJgjFHl
	 pYMo5sJHnaZKUzSli7Ry940jUHwCqgeu22H6klHnUUos3EbR6RIESCp+Njpe0qlzC5
	 ZIA4/2A2wGe0R/OAOeXS527SfgRKjQoudnPn3j51ObGww5gJAltlIXP60N1Mgmuwzs
	 16tpMUsK0ktCx59Y6ZrAqhEOBvxGIIeq3vxP+n1RO19roptXEO7X/kyjjjoombpYNH
	 3arYjiJoxZ7+OcEOP2jT6jyUpepXGPi/TjKUy/MPwPp53OfS5iiUFUfKfmlpM414Xb
	 NQzYokyN5XRtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BAA380CED9;
	Thu, 24 Apr 2025 00:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: remove function stubs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545344574.2807189.3689657743704602309.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 00:10:45 +0000
References: <f7a69a1f-60e9-4ac0-8b7c-481e0cc850e7@gmail.com>
In-Reply-To: <f7a69a1f-60e9-4ac0-8b7c-481e0cc850e7@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Apr 2025 11:04:01 +0200 you wrote:
> All callers of these functions depend on PHYLIB or select it directly
> or indirectly by selecting PHYLINK. Stubs make sense for optional
> functionality, but that's not the case here.
> 
> MDIO_XGENE usually is selected by NET_XGENE which also selects PHYLIB.
> Add a dependency to PHYLIB nevertheless, in order not to break
> randconfig builds.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: remove function stubs
    https://git.kernel.org/netdev/net-next/c/52358dd63e34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



