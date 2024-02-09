Return-Path: <netdev+bounces-70668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CB84FF23
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7731F21802
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7E91B7E9;
	Fri,  9 Feb 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJad+wED"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2FD294
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515429; cv=none; b=iPcyR27rJyJBRrSQCsDVL3hxAB3H7WeJTRbIxzqWWr8NZd1YFmza1ZJOlrxg4ru2xEtpPXdHGU5GhLeyis/8dqCuo6cWZRwt0z4gakMvYBDwyx0e6+TSQKupPGyRvBHGJt7PYTyUbX5gdBL1z42v4THvv0u42ci4OixpxTHUNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515429; c=relaxed/simple;
	bh=kLcKpFsdldIg1H1ZCwuXdsbLGiY/stP9APCY9DWk5gs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hmyiSkHW4rQq8vx2qsoDD60U6qbZ3s79kVDM8tFjIOvINY8QtwwC56d97FOB8O4T8mi1maIGdPFJCYrTjYJG1rMOmxDo9RhkiwaQcm5a9fAL54DFlQw6OwjRxtFvBK6ixQqlkHV4A+tvJCA834wQGgfykOIJ1R60F386Ap01H7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJad+wED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE697C433F1;
	Fri,  9 Feb 2024 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515428;
	bh=kLcKpFsdldIg1H1ZCwuXdsbLGiY/stP9APCY9DWk5gs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gJad+wEDo+cVRUN2xQ39Esjfu2eq9VY3h9WCTdl/Gae/JAL7YoZtNYeXQuMPUlhmA
	 7ROlEnEookXcvrIeEeH5Ow/og64yBAT/XglOeM9xIEU2Fiuesz0KzGowuogesFFSTn
	 veAQtNeIkEdJ6mItZ5+Te9q/fQ8+sZJaP8qMbMbHKQwsM+hlpy4knVrxwqn7sds17Q
	 OcTgIe5LH2rkIejU6J242dRD0GxvEvb9TP2+bndSVOWbyxNIPhAgDye4cuCC7ebd9S
	 uaiMXMri2h/YWmMYkWfoRKWdNnC8T6cT16AijWfsHtgD2W3dEjsKp6Z0jOJX/RqM7J
	 3e+zf7S0841Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4A0BC395F1;
	Fri,  9 Feb 2024 21:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] selftests: udpgso: Pull up network setup into
 shell script
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751542866.4610.9098339626144735587.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 21:50:28 +0000
References: <20240207-jakub-krn-635-v3-1-3dfa3da8a7d3@cloudflare.com>
In-Reply-To: <20240207-jakub-krn-635-v3-1-3dfa3da8a7d3@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kernel-team@cloudflare.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 07 Feb 2024 21:35:22 +0100 you wrote:
> udpgso regression test configures routing and device MTU directly through
> uAPI (Netlink, ioctl) to do its job. While there is nothing wrong with it,
> it takes more effort than doing it from shell.
> 
> Looking forward, we would like to extend the udpgso regression tests to
> cover the EIO corner case [1], once it gets addressed. That will require a
> dummy device and device feature manipulation to set it up. Which means more
> Netlink code.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] selftests: udpgso: Pull up network setup into shell script
    https://git.kernel.org/netdev/net-next/c/d45f5fa8b4ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



