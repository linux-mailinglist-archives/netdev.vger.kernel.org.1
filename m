Return-Path: <netdev+bounces-132296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1529F9912E7
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C3AB22FD2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BC114F9EE;
	Fri,  4 Oct 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfL63Wah"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251A15443D;
	Fri,  4 Oct 2024 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084034; cv=none; b=vBpXXEe8FUMiMltH/WMh+VFNgBRXpmCNFnXlOyDYynNsVJcHaaethSUgWV/x3uwT3/Jb+/4oNjiv7dMajZph82DvAFiMVBpMtjA82kyAxp+msFT3lROxYklSnhWgb1g+yzB/G35F0bpN7vrIxtg5pang/YpEWmI6QLY11G9w3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084034; c=relaxed/simple;
	bh=YMlBQyXHEWG0EsDj0gFrvnTBeeW/2Vo6Y09KTE3Eoqs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mlUSO2v+wqA7dOWBq7M9ZuqZlHsZZA+updS8WXrV8c4jjODv0r1dD1g6IHRzeXuSrLvkj2WU3OiDcvhyhejAp/WCRprJMYU1b+y7SbbL3dCfbKDPhO4CGZ/jrqMk51qZkjXZjnk4gUKD+DbXnAnq2OolfzxCoawF2hHo22UAkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfL63Wah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2EDC4CEC6;
	Fri,  4 Oct 2024 23:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084033;
	bh=YMlBQyXHEWG0EsDj0gFrvnTBeeW/2Vo6Y09KTE3Eoqs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bfL63WahfK8By7BV8OTKGDt5tfC7Z/LpePc7WqdIMLeF4OCtfCGn1Jy7Byb3B7qud
	 bpg1eFUHoAW9j2RZPND+Hv6sw+auXoNvmtUomLqk95rbDYcR1cz0FCqJHY6FWxb7TW
	 ZTYIaXOzN0K0LUQLNNt+AWArirERh70d+WQCoCp7ry4A8pdMwE11qt/X1HDtFEUhsy
	 x8hTAAuY/TWtfOpvX9Hbait3YBQPDvGJuDmb5Yq7HLf0yCtv+oGLZJvkLF+duqEQwu
	 mXDOuEXygQrTFlVEdA0+cjHdz0yP8Bmu7YqQU/B8yR6OW3Ggd/MyVt5pCt5u/gD19b
	 apB7ZICe+6viQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE01239F76FF;
	Fri,  4 Oct 2024 23:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: dsa: mv88e6xxx: Support LED control
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808403725.2772330.11872503207643083402.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:20:37 +0000
References: <20241001-mv88e6xxx-leds-v4-1-cc11c4f49b18@linaro.org>
In-Reply-To: <20241001-mv88e6xxx-leds-v4-1-cc11c4f49b18@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, tharvey@gateworks.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 01 Oct 2024 11:27:21 +0200 you wrote:
> This adds control over the hardware LEDs in the Marvell
> MV88E6xxx DSA switch and enables it for MV88E6352.
> 
> This fixes an imminent problem on the Inteno XG6846 which
> has a WAN LED that simply do not work with hardware
> defaults: driver amendment is necessary.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: dsa: mv88e6xxx: Support LED control
    https://git.kernel.org/netdev/net-next/c/94a2a84f5e9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



