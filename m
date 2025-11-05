Return-Path: <netdev+bounces-235654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D088C33978
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3975042803C
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A32E184540;
	Wed,  5 Nov 2025 01:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv2juyZ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7483EACE;
	Wed,  5 Nov 2025 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305039; cv=none; b=LKzPJGcXY4RHsXrwI3SD/V1KREq/TMordPhoidVeAx1Q3NO9wtRNmrhj/vNF2HfA8ErsrZYrU8h42hGp2O1K5vvTXYV/oRx+ur/RahoyGk+G/w0IzpnZ8lU7EIlz6gMJuQyPzPwAWhwi1gfU22jTGpaxdJ3DT36iZkZ2YgdsIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305039; c=relaxed/simple;
	bh=nzW5knNnDIiz1vAzKZBXSGQm7IQsdPAMRxiQqDCZQF0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gMcgYfAMjQAVJ9GvIELLFBVkEqlZ8ogBKbPc07oYGenM2gC78gjtNhqi3lWop85B4Pc0K22NpVRC5iMzn4PyoTQlKZcT7mDzVOwrCZU/VjCYNPbl0FV3Q8JNNNUwD60TYWxP5hIulKoe+OyaFLglPLfe/0mQsrVnGfobVs8KfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv2juyZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C028C4CEF7;
	Wed,  5 Nov 2025 01:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762305039;
	bh=nzW5knNnDIiz1vAzKZBXSGQm7IQsdPAMRxiQqDCZQF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hv2juyZ5q32TCg6Vu0IEb6nmdwjycFiXo+OiaSTmV6Kz3V55W0aigVPkOUvgbLehR
	 esmQWq2gSLChEcMy+mGQHi+GFuoEd8Tqda/qtnQFn6mxqyiZMK4G6Tfc/h+V4fu/4V
	 TCm4WqgXsZcWkHzFco3Qi6GOBJjn3jlRMX1WNrHIRXZ0Ad74cTrUWECom/2MKW3Qjp
	 MLNZZCrtbrKdcPMeXdqQRwrtowLGstd2Ag06eRJ7ApGDe+hhrhhr0r42f1Padts16r
	 BSyWoh+g9V6+KfIEnY0Rd5eX/sayg15tvtLiLnVJSerCpvT3vP9hBdOYPv6FYNEwxc
	 6i9PieYK2KDcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D73380AA54;
	Wed,  5 Nov 2025 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] veth: Fix a typo error in veth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230501325.3047110.3705400838516504143.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:10:13 +0000
References: <20251103055351.3150-1-chuguangqing@inspur.com>
In-Reply-To: <20251103055351.3150-1-chuguangqing@inspur.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 13:53:51 +0800 you wrote:
> Fix a spellling error for resources
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/veth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - veth: Fix a typo error in veth
    https://git.kernel.org/netdev/net-next/c/9781642e5890

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



