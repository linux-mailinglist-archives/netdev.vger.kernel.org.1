Return-Path: <netdev+bounces-158352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E95A11779
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB411889023
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E094E14B946;
	Wed, 15 Jan 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ro8Q5VSG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4F5846D
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909412; cv=none; b=FK+cm9ps1binm0Pitb3JDpSAP+6WS5kBQr7y4StdHG4dE8rxhnq55kAIjj5dsRzXZ0uk1WZyOtTmhRDImShpw9xyU+9FPILl0dZWJ9Q+UMGNIS9lFGDArsdYotYrLOp4lN1lPUYhLmfAscZuKx0OzOnKSis9fW9nX9yJAKxWcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909412; c=relaxed/simple;
	bh=XZnxBk+FcFoHxx191qImvZNg7w+IyFMnBMHTXx6L5ZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQDaemVJPGr6DiOMVw2/b8p714ZGA5UX2hVY6poo6aTWMj5PohPRO/Htx24jB4pkpoAqqcUZM0UZ5AENMFSH2KLhswbSh5XVDOpXExbbg4p7wYyKN7Nbl32RLYbEIynDlowUSE8SdfOFOVR/FRGxSMLHTXPdRpBnBByJwLP1IC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ro8Q5VSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C91EC4CEDD;
	Wed, 15 Jan 2025 02:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736909412;
	bh=XZnxBk+FcFoHxx191qImvZNg7w+IyFMnBMHTXx6L5ZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ro8Q5VSGF3ozPz8UtYtwIDdO3bUq+DZXh2zvyVFoMzBbsLYiAfm0Vhyg06qEZ6YAm
	 hUU7XtQe6frBDOBahLq5YkoW0eCCXPnnQrKvt9HrlyJ7sADGmfRjJyL84Y7sVoDhEY
	 xyeLkf5MwkMqaeLR2neatqE0uO95H+6LLQotiMElQEwL2hd20j4CxXyRxVq6b1CFhv
	 1BDnko5EJzTjyqnD38D9cijquhOAfRudMIUk62JMZc55P0HJvHJCJ95c4bshAwlSYQ
	 YWsmpNQDzQyrO8HcMLjOlVmpNMEoRPRe0QH71rBohz9nhmnTjuCtVBYevmCab+XFwS
	 c5TgBbBqAT9Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A5F380AA5F;
	Wed, 15 Jan 2025 02:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] net: stmmac: further EEE cleanups (and one fix!)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173690943498.230797.5869251402223823826.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 02:50:34 +0000
References: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
In-Reply-To: <Z4T84SbaC4D-fN5y@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 ericwouds@gmail.com, kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jan 2025 11:45:37 +0000 you wrote:
> Hi,
> 
> This series continues the EEE cleanup of the stmmac driver, and
> includes one fix.
> 
> As mentioned in the previous series, I wasn't entirely happy with the
> "stmmac_disable_sw_eee_mode" name, so the first patch renames this to
> "stmmac_stop_sw_lpi" instead, which I think better describes what this
> function is doing - stopping the transmit of the LPI state because we
> have a packet ot send.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] net: stmmac: rename stmmac_disable_sw_eee_mode()
    https://git.kernel.org/netdev/net-next/c/900782a029e5
  - [net-next,2/9] net: stmmac: correct priv->eee_sw_timer_en setting
    https://git.kernel.org/netdev/net-next/c/4fe09a0d64d5
  - [net-next,3/9] net: stmmac: simplify TX cleanup decision for ending sw LPI mode
    https://git.kernel.org/netdev/net-next/c/bfa9e131c9b2
  - [net-next,4/9] net: stmmac: check priv->eee_sw_timer_en in suspend path
    https://git.kernel.org/netdev/net-next/c/c920e6402523
  - [net-next,5/9] net: stmmac: add stmmac_try_to_start_sw_lpi()
    https://git.kernel.org/netdev/net-next/c/0cf44bd0c118
  - [net-next,6/9] net: stmmac: provide stmmac_eee_tx_busy()
    https://git.kernel.org/netdev/net-next/c/82f2025dda76
  - [net-next,7/9] net: stmmac: provide function for restarting sw LPI timer
    https://git.kernel.org/netdev/net-next/c/af5dc22bdb5f
  - [net-next,8/9] net: stmmac: combine stmmac_enable_eee_mode()
    https://git.kernel.org/netdev/net-next/c/ec8553673b1f
  - [net-next,9/9] net: stmmac: restart LPI timer after cleaning transmit descriptors
    https://git.kernel.org/netdev/net-next/c/d28e89244978

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



