Return-Path: <netdev+bounces-133378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB77995C3E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A411F24520
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBF023D2;
	Wed,  9 Oct 2024 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q483hAmK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FB257D;
	Wed,  9 Oct 2024 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433225; cv=none; b=RLo8/3y4+e7UvtubDhYP2dPUlWzQKPZNEk48q0oVYuTqNm/gwj1Mef/Qt7XoY2cjlweVcKhSavfcpm99UZ4ogBb1b9qxanY4f7SrfI867IcyhYe4GHsyN8HG4my5k7NW2kTo3EAzQO6mbjtRx8ppJ7XYJz8vsAX5qfl7DDU47AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433225; c=relaxed/simple;
	bh=wP9Yk9Ap5L0hCZPbP13WfpYwJsJr5EdLYuTc2oB6V6g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=je3V1hcn2dJsfUvwTOwoHz/9Gkfrxuh/I9P+rFOWo3QT9/HGhC2gwJBgsMYexVQYhvPLoXu05fvzVaRaHeRyKWXw1iKA0lPAJkEAKV63f4l870dp3dnMvbjwhbpEpdsRcLKwSlHQOEAZclwYxFb0EZmwdU2/p7dC1meLBQvcZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q483hAmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8647CC4CEC7;
	Wed,  9 Oct 2024 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728433224;
	bh=wP9Yk9Ap5L0hCZPbP13WfpYwJsJr5EdLYuTc2oB6V6g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q483hAmKvCExiSk4mkztUjUWLTXTVAQwLGRJkjObEu7yZVez4tfrs2uwy2BKJHiTT
	 /sEaaM62jc9HMXz1QCE3PrY9Ts3R4EcPeVoOfUEQbuSPo+9rOu+dCABOqFILcwh3z6
	 KzAgLqF6nydSs+17BPd647MRBRI8RYCZwx2tziq6hzS7yHxg6zzjGh8OQsJX4f/pqq
	 5QOKuwWI4ct6ucHOmeEkpYdJ/2nqk+u62RI9hRTq8RIEZMZF1Q+Fv1E7Wurfwb+7nD
	 +rjI6Ci2PWern4nSGzXF+W+ZuiAm5bClrDH42UTuIW4v17KU/KtpRlVaMaZ9UrtW73
	 NgooZwY7DG4HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFD03A8D14D;
	Wed,  9 Oct 2024 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: marvell,aquantia: add
 property to override MDI_CFG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172843322875.732995.4891642157251692023.git-patchwork-notify@kernel.org>
Date: Wed, 09 Oct 2024 00:20:28 +0000
References: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
In-Reply-To: <7ccf25d6d7859f1ce9983c81a2051cfdfb0e0a99.1728058550.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 ansuelsmth@gmail.com, bartosz.golaszewski@linaro.org, robimarko@gmail.com,
 frut3k7@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Oct 2024 17:18:05 +0100 you wrote:
> Usually the MDI pair order reversal configuration is defined by
> bootstrap pin MDI_CFG. Some designs, however, require overriding the MDI
> pair order and force either normal or reverse order.
> 
> Add property 'marvell,mdi-cfg-order' to allow forcing either normal or
> reverse order of the MDI pairs.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: marvell,aquantia: add property to override MDI_CFG
    https://git.kernel.org/netdev/net-next/c/1432965bf5ce
  - [net-next,v3,2/2] net: phy: aquantia: allow forcing order of MDI pairs
    https://git.kernel.org/netdev/net-next/c/a2e1ba275eae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



