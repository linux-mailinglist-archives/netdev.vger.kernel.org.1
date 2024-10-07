Return-Path: <netdev+bounces-132904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E731993B56
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D072A1C23CC7
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EF01B4F37;
	Mon,  7 Oct 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fys5T9eH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108B1AFB3E
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344435; cv=none; b=qGDWiVckqXeV+3CHeK1XVqcQntmIBKlki3eI6XtTmRYhauxDV07LiWY3wxCI3NmgaJrwZp2ghDa55Cu4JnVd96bH4zq8c1Uz1g1B8Q3ocgrBakYCyR4LRmcAdAnHJmowt9pNCjwcOc8lldoawNxodhu7mbCoLUALm/6+HjSsjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344435; c=relaxed/simple;
	bh=AcVLHBx379Jxjp8pml0KIQWp4ijOLADTYKje4ZigE9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R6kjK+H9EaHf65hslhgyQsItJiHYv1PFLtoZ0dF61WmEKExG8cOXJeV1MHHq5/wQFFWgGW4AINH0wWTGmXnWhUzQ6khUQN1/3QzMSs3tsvYkFDjqj0cocz9yuitq3dQJteyOMxwmGXa+vuuzHBv/zlzsG1iACNNfhAE51Yuk+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fys5T9eH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78F7C4CEC6;
	Mon,  7 Oct 2024 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728344434;
	bh=AcVLHBx379Jxjp8pml0KIQWp4ijOLADTYKje4ZigE9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fys5T9eH+rHo6A7Yu8NhTnCUlMzUhUT/pw3F8FrsbudfeBC+I4XT5XGKv7rGRS6Ge
	 AIlIs1pn4BchSWHzdK78G1PlkFS99SzmHrCf1wQmZC63fN7d9B/Th8EXnn4p/8QOUv
	 DfICddf6JoJr2l4G3t5cah9LGhwJMvWDGjwPezU6InQM88W3WKHSXMP6se+lb9hfr6
	 n1GdFxaXBkoqqka+aBmmgj3AqLi5ONvdNvlvQSeogLdYjGjwvuLGLpBqTwCyoyusWh
	 U78ynFWfm5ISfEj9j07Er0L4y2qHwh5ilWyAovcgj8fo3gkV3G8P4cnHqqjyb58PV0
	 jcUh4rYSRKECA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CFC3803262;
	Mon,  7 Oct 2024 23:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: dsa: remove obsolete phylink dsa_switch
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834443881.18821.12277743136953024794.git-patchwork-notify@kernel.org>
Date: Mon, 07 Oct 2024 23:40:38 +0000
References: <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1swKNV-0060oN-1b@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 03 Oct 2024 12:52:17 +0100 you wrote:
> No driver now uses the DSA switch phylink members, so we can now remove
> the method pointers, but we need to leave empty shim functions to allow
> those drivers that do not provide phylink MAC operations structure to
> continue functioning.
> 
> Signed-off-by: Russell King (oracle) <rmk+kernel@armlinux.org.uk>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: dsa: remove obsolete phylink dsa_switch operations
    https://git.kernel.org/netdev/net-next/c/539770616521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



