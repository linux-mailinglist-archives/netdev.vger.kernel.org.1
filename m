Return-Path: <netdev+bounces-209925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EF4B11556
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AB858007E
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B5314386D;
	Fri, 25 Jul 2025 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRYWSZG4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127611CA9
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404123; cv=none; b=DyPh+ydSesUIfjs0zINkcj2Ff+QPRJ1iBn7K3Oq+KLBJQ+hGXeOkQxXIuZDgSFROcpjb0krViW2B1TFLe0PD2h7Zm0c9b0JCu00WOIdVm1qYsVHdVvBO/TKwWf34t7qqCAHtWaueT04Ih4KuojPUFRx/Qor6IwUVkU6+UdjAfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404123; c=relaxed/simple;
	bh=b01dtZOOvgNke88uckfC4MYqIjs6SFUMWM91MEl6a2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eiEnQkhIi821LatT1S7hoK1yhxCHTbXpZoDGgMfEwE4mVMzDvzmz+eVOakMdycz2gyP7bvcvYDksSu8xrQPKtra/6vzN2T+stCAfyXTrQWMg2aIpe5RSxLUtoOVplmC4Rmzdt0hbb8sd90tJPsijNOn72pH6bvngPAok3s9pA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRYWSZG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36567C4CEED;
	Fri, 25 Jul 2025 00:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753404123;
	bh=b01dtZOOvgNke88uckfC4MYqIjs6SFUMWM91MEl6a2s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HRYWSZG4Un0wS6o1jZK7dKi/xfSn48O4mvKYwCoXQmfCJgrIi+c/xM7bDnIOakdBq
	 aSIS7kJwz0vMWs5Cr3GVDvEZu18d7KAD2ixJueTNP3T99l68bMHnYImARcE7UhmDzG
	 FtF1v6QShu3vMtXBSCL1N9xy6QzTDfk2BrLJv7x6dzxY+PQrYdpioHRlHdtvPf80ZD
	 2eV0rp7BcBTRpPTMx8x5bpheQ6qNXgFhNmiKzZ7Ppirc7VZV3oPC/4jIF85+Vw7YTJ
	 qZ2Nsu7uXxtLGOhA61EIBaAUY6qDnXYcQt/wPRSeoo7Okl9Gl7E5+xBYzHnjHdKr+a
	 MmrEZKFsAaNjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B22383BF4E;
	Fri, 25 Jul 2025 00:42:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] tools: ynl-gen: print setters for
 multi-val
 attrs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175340414100.2585720.17721839956560285304.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 00:42:21 +0000
References: <20250723171046.4027470-1-kuba@kernel.org>
In-Reply-To: <20250723171046.4027470-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, almasrymina@google.com, sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Jul 2025 10:10:41 -0700 you wrote:
> ncdevmem seems to manually prepare the queue attributes.
> This is not ideal, YNL should be providing helpers for this.
> Make YNL output allocation and setter helpers for multi-val attrs.
> 
> v2:
>  - rename a variable to args
> v1: https://lore.kernel.org/20250722161927.3489203-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] tools: ynl-gen: don't add suffix for pure types
    https://git.kernel.org/netdev/net-next/c/a8a9fd042e09
  - [net-next,v2,2/5] tools: ynl-gen: move free printing to the print_type_full() helper
    https://git.kernel.org/netdev/net-next/c/cf5869977702
  - [net-next,v2,3/5] tools: ynl-gen: print alloc helper for multi-val attrs
    https://git.kernel.org/netdev/net-next/c/2c222dde61c4
  - [net-next,v2,4/5] tools: ynl-gen: print setters for multi-val attrs
    https://git.kernel.org/netdev/net-next/c/8553fb7c555c
  - [net-next,v2,5/5] selftests: drv-net: devmem: use new mattr ynl helpers
    https://git.kernel.org/netdev/net-next/c/f70d9819c779

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



