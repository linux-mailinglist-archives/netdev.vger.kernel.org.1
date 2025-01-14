Return-Path: <netdev+bounces-158274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBEFA114E6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B3816984E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C02236E0;
	Tue, 14 Jan 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm6cM5x6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF42147EE
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895619; cv=none; b=Yy0wIb+/yl7KJJxWRVtd9PkmEY49yiucat0YID1Di05r/DjUx8sH7dKJbLyY6Co3HFdeA2XzkIgExSWf/OxEgySq4pCI4dWZZTP6ikPfwa5qvWYc9I1Xcp7///gtl5I5CNpjRaZUU+ISzf6orY74sTVQJ6zjOWPDU/mcxLsVJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895619; c=relaxed/simple;
	bh=f/QShmR0dYDVRn6FrchQOZ+I/J2lxvBfmSj2QNMw5kI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s90C+/WGZogJrPY55AV+IGmJo3vceRlZWrX3z7j1KKMdoNaveExiTZCJR7OUGNCMuSav6hHbV8J3y6xCMOCnJWq7OXC6oksfBxiO3wohPvC/JXee1aKLuWsT5o037+0oRQz0XYzl2dg2noMNvSC0Tt2Uz8BWJ0OMC3nhnzcOe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm6cM5x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8171EC2BCC4;
	Tue, 14 Jan 2025 23:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736895616;
	bh=f/QShmR0dYDVRn6FrchQOZ+I/J2lxvBfmSj2QNMw5kI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qm6cM5x6+iIMnFNgOJMaPUx2pumZzEDEbGlA0+cTVW8uHhxcxGAzOmEiLtnAsAw1q
	 CpjtLnUYtbJSdxXGAmINvt+jfxrCZbiBxrzct2hmXTsWG4oNGDWI2ue7iREc9+tbc4
	 yiQfYfjaovDEbXfvR2KL5fvZ4wWc4JTsthkA7IZsvpf6PE2MHv9aJHNk5LR0NMlS90
	 wXWlh3oo0S2LF1VNG3g+T7c821gGLpl4vjECF5+Rx7hTG180TLMiuUrK7dfBZpFLeE
	 +8DENxrnY2/ldRqCenKCTJeDoszdngPpHUwAKVTgwBw/IL73a3y5ZtIPXlab48PFQ1
	 scxAwa0M+OnYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71DFC380AA5F;
	Tue, 14 Jan 2025 23:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] docs: netdev: document requirements for
 Supported status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689563899.170851.15442144645788945342.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 23:00:38 +0000
References: <20250111024359.3678956-1-kuba@kernel.org>
In-Reply-To: <20250111024359.3678956-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 aleksander.lobakin@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jan 2025 18:43:56 -0800 you wrote:
> As announced back in April, require running upstream tests
> to maintain Supported status for NIC drivers:
> 
>   https://lore.kernel.org/20240425114200.3effe773@kernel.org
> 
> Multiple vendors have been "working on it" for months.
> Let's make it official.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] docs: netdev: document requirements for Supported status
    https://git.kernel.org/netdev/net-next/c/05baba80f2c4
  - [net-next,v2,2/2] MAINTAINERS: downgrade Ethernet NIC drivers without CI reporting
    https://git.kernel.org/netdev/net-next/c/af2bcb5774f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



