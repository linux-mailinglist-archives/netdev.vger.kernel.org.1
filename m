Return-Path: <netdev+bounces-238430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E72C58BE1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9053AC84B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E335B139;
	Thu, 13 Nov 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ/w9Dlz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7135B134;
	Thu, 13 Nov 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050241; cv=none; b=mDn8RBQsf17gTFZHSVwWvakZx3bXl20TEMvPWpjbU/Hn3D4R9cEgVON8ck70FcSjA4wjd21VoySJ90Da6FBzxWnD7DfqLb3SmqhB5OU+Qi0QvpeLw5AKW9sEezaI3M1CTkzP1ENoFgCYiRzIoUk9fTDuqdJXfNjo0HL7hQv8yKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050241; c=relaxed/simple;
	bh=veR8/nbDtLvQOcg0BwdTy39yB/WVz1ADHJK/sjmFuRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jbFfKpZFNNqaZgoAOyZkt5OB6I3dZPlXwYNSLEhOF/+kVEIL6ajTV3p/Z4eZdE1/hGsZgHcg/41KOuRre6kE8LXwzEPIPAHsF3I5c8wJ6VaM1VB5l9VAEUarTYJTCpOReceOR1SbrYfoT+y1ZcZnNOdJrKgWlFsW9n6zVbWgdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ/w9Dlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92349C19424;
	Thu, 13 Nov 2025 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763050240;
	bh=veR8/nbDtLvQOcg0BwdTy39yB/WVz1ADHJK/sjmFuRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hZ/w9DlzOSe155fEEvNIKgEaJAfii5826P755bO5SGR6Inmfarl8sWNLaK8wVLJ3V
	 6/nyyb+pM3M78fa3dtzU7kF7nZCviHQ8G66us/WC7nynQ72xVshcSPM1rNaY9+xRIB
	 /GEx2457CxujiDZJ9/CUOp00QqjpXbtyMw3NC2QoHbkgyjRSH8Alipk9T/Tayy0tug
	 gALnDJ+bd9H46n84MFtObcf3eW/tRH1qqszz/w7KiOmOEuEmdd+veSYp3CzwIoUe6T
	 gkOiZG7kdYZd9X5rZ+oeRphjhl/ytJKrLMbWuT6r0RRx4szDetORNhN3cU2DLnhOrQ
	 +mYyBnVCd/82A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9C380DBD2;
	Thu, 13 Nov 2025 16:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: always allocate mac_device_info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176305020974.908070.1045942084214006271.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 16:10:09 +0000
References: <E1vImWK-0000000DrIx-28vO@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vImWK-0000000DrIx-28vO@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, wens@csie.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jernej.skrabec@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 samuel@sholland.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Nov 2025 11:26:44 +0000 you wrote:
> The ->setup() method implemented by dwmac-loongson and dwmac-sun8i
> allocate the mac_device_info structure, as does stmmac_hwif_init().
> This makes no sense.
> 
> Have stmmac_hwif_init() always allocate this structure, and pass it to
> the ->setup() method to initialise when it is provided. Rename this
> method to "mac_setup" to more accurately describe what it is doing.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: always allocate mac_device_info
    https://git.kernel.org/netdev/net-next/c/f694d215d340

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



