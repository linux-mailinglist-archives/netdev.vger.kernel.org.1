Return-Path: <netdev+bounces-242143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317D7C8CBC7
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7183ABE51
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07A92BEC20;
	Thu, 27 Nov 2025 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGDeMSEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861AB28D83D;
	Thu, 27 Nov 2025 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213444; cv=none; b=t6PagBRNZ9kRHoCIwphr35/qUKNTWV7wfYtBQ3agqyvJXf5TMNF8872TtSgXGVafkLFYS0r/Fl46c+Z3Djq6WFnjGwgnWOAtLnQ02dnT8giWjD4IeGXa1VVIa9kNJOBpt+l1pKMQZbCyfGIGFft0SIqoG100uhaeQIZYqbnOALY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213444; c=relaxed/simple;
	bh=2cXytggNI5GLYef4VikXaYI3k2c4s0Q9c/JbRA3BtEs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pmABvcVSIuQyilDKaXB7i8Vhc35t4gdNh7tcy1E+mV6Y/o88x/5si2QXMDpJLcPA/oW5vFNGWG9tCjkGcCyqeelo74z2o1x3tGKTDju1OeO4YTww7JnYI7xcvhHq6cPwpc41mdFoLvsfd+Ok5Ohl0AxpNZAC1tKZZtloycyr4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGDeMSEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0C3C4CEF7;
	Thu, 27 Nov 2025 03:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764213444;
	bh=2cXytggNI5GLYef4VikXaYI3k2c4s0Q9c/JbRA3BtEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rGDeMSEiHKjZmHgfMLy5vfoKe3UR3pnVAtuI9PU9GfnS9ugSnx+WfE1juYNm2AvEH
	 JAzWUHWDlna0Rvpkihi5HGIDo3dMAjwdRSfVrOULe8MCoxX6CL4D68/2sAxGzOYYWk
	 i5d6d3cQZ7M4vZqvQB2CzUEZ+7sEBmuwMLbdYuILG6OhFycR3eNrzLKIgRPNIjrm/0
	 d1NOcw1ONoK4z1E4M7dtkXQ2xRCL74b1X9gbvJuFMcf5NP0Vw5FEgtUYAP5W+a1LtI
	 BK0wPGD3/MA3IKDhRUUU+5tTLlvO329CIateWFo2v3e4iOaCxblUxrPQgzOtpGyN58
	 db8yzjIxwndNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBB380CEF8;
	Thu, 27 Nov 2025 03:16:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: dp83867: implement configurability for
 SGMII in-band auto-negotiation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176421340549.1916399.17100394278180351848.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 03:16:45 +0000
References: <20251122110427.133035-1-vladimir.oltean@nxp.com>
In-Reply-To: <20251122110427.133035-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tee.min.tan@linux.intel.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 22 Nov 2025 13:04:27 +0200 you wrote:
> Implement the inband_caps() and config_inband() PHY driver methods, to
> allow working with PCS devices that do not support or want in-band to be
> used.
> 
> There is a complication due to existing logic from commit c76acfb7e19d
> ("net: phy: dp83867: retrigger SGMII AN when link change") which might
> re-enable what dp83867_config_inband() has disabled. So we need to
> modify dp83867_link_change_notify() to use phy_modify_changed() when
> temporarily disabling in-band autoneg. If the return code is 0, it means
> the original in-band was disabled and we need to keep it disabled.
> If the return code is 1, the original was enabled and we need to
> re-enable it. If negative, there was an error, which was silent before,
> and remains silent now.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: dp83867: implement configurability for SGMII in-band auto-negotiation
    https://git.kernel.org/netdev/net-next/c/002373a8b01d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



