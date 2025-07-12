Return-Path: <netdev+bounces-206301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFF1B0285D
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 02:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3EC1C4002E
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605A24AEE2;
	Sat, 12 Jul 2025 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoY/W4OH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D62F43
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280791; cv=none; b=fx+xdiOsn3TNEj8cfqkCRn9Vg1TmP18uezI2SJMJuRV9IPPrPw+mDBHRLmppDRaTxLThX3iONrLC95lHIPPWt6GTMJLWDtTRLBlLMYEcESAzCozGjtR+P0fddboSxwkkupZ1c+TLnCy/2f45DjaVfrrcZpUugW1eMQbfPM8TL/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280791; c=relaxed/simple;
	bh=AM8Ex3lbY9TDO6LMrBvqr+3eea9dOtg22TLMq5QhTMk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tm4hU/BJbg/mPs2TxgJNM2LwXyxq6JsAiifDL8LwcLE74ZvaCXLrYZ8qi2/7Fsyjmw98AaBfRkUSx+CmwZ7K448Ku5J/tdLo3sQAz835ydzWslYa1YSCqnIfJpLKDGJnFsL1MQonqYyem0CjHTkCwy0FmJh8l+kjIAkbHv/ifnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoY/W4OH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A069AC4CEED;
	Sat, 12 Jul 2025 00:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752280790;
	bh=AM8Ex3lbY9TDO6LMrBvqr+3eea9dOtg22TLMq5QhTMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IoY/W4OH/fmqE5xHsXym8LWoWEroWcFtnipWErnxWNSpEEWYvC/sv+ZdTeaBmPh05
	 PYwSb4lb1IjTveoPUZnjSVKiizgrnRCslQxcvKX/Ri1UlELbu6ng37w5Iny73qEdK9
	 3KovJIz0VSqZO36dU78SHZR4zeha6xsGgJaGek4uss7osLP7frYWWZj9SlE+OMhWiP
	 ILAdF6mMp1ID6w5h3IyEGjSlMq5C4/tuD6puATWEZVF/L0sKhhC56/zsU/iUMEWY0o
	 tQR1GeehmBEBvm8UZykj1LUj+24p8UGLoPuyEOt1824Q+Gw1YIeZ4VPG1U1eqvx7xF
	 q6totuptRamKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4E383B275;
	Sat, 12 Jul 2025 00:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] netdevsim: support setting a permanent
 address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175228081251.2448508.13236014338769214140.git-patchwork-notify@kernel.org>
Date: Sat, 12 Jul 2025 00:40:12 +0000
References: <20250710-netdevsim-perm_addr-v4-0-c9db2fecf3bf@redhat.com>
In-Reply-To: <20250710-netdevsim-perm_addr-v4-0-c9db2fecf3bf@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 13:18:32 +0200 you wrote:
> Network management daemons that match on the device permanent address
> currently have no virtual interface types to test against.
> NetworkManager, in particular, has carried an out of tree patch to set
> the permanent address on netdevsim devices to use in its CI for this
> purpose.
> 
> This series adds support to netdevsim to set a permanent address on port
> creation, and adds a test script to test setting and getting of the
> different L2 address types.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: netdevsim: Support setting dev->perm_addr on port creation
    https://git.kernel.org/netdev/net-next/c/54cb59cf81b0
  - [net-next,v4,2/2] selftests: net: add netdev-l2addr.sh for testing L2 address functionality
    https://git.kernel.org/netdev/net-next/c/963c94c95a31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



