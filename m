Return-Path: <netdev+bounces-242125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 228A7C8C894
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 02:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 529664E7836
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288929B216;
	Thu, 27 Nov 2025 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp9X5oiU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07628A704;
	Thu, 27 Nov 2025 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764206467; cv=none; b=u5h1BAwC62oKsmsrCrmpmtNOU7jOh5U+ypRWh5XpGo741IK5S8a+vl/rt66ziLvO7/UT7GJkVn6vPM21826FEvUbfdE8qwDYWiECpCkIWM7Ry2dW/5nRovckPtBrQI+LHR5YeH4hysVN1IS6hfskyWv2Wiq/27oNQNvWYg8cx7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764206467; c=relaxed/simple;
	bh=hRlrqIyxOAM7OdUT/dqiQ8MC4Iz+96bFTNRSgwoQCY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q3Du56yvE9eYGnR7tUf2JDhL0vbNiKaOJmI3YqUNeDt/U+r4o1ppp+WEQ/GGMvKvVBztaq6dwPUxEyABsqDh7Y75NTpEanAiToeF4fXnyPmPtvmOaOPAhyMmLEmxT14YiRJVZ4WT4IaME5oxsPo6LlKkGI9oqnB25lz48OG3yEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp9X5oiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127BFC4CEF8;
	Thu, 27 Nov 2025 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764206467;
	bh=hRlrqIyxOAM7OdUT/dqiQ8MC4Iz+96bFTNRSgwoQCY4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bp9X5oiUeLWAzIfo7KaTG4oroTnQqPpXhyJbN6uyIV4ofQI8nynZSXA7VE49dD9Ww
	 eTJseH3QAcslR7HW6dgOd+dFB/Ua4Ootz/mwhbbgL9slr7rIpX0jr++91cgxOHfETd
	 jwW2PYK6UHicNS5ycHLuIuk2Jnqb+KVnEiuswxB3qSNGgP/punYYHlYG1hE1q9leJg
	 fxHTCF365d+CfDG/+PBZW7DBH0DI7miIX0dnXDS74bSkIror9PQQfPX2DS9S4qO/yq
	 Vo+j7d3JN/v1Kyha+12miB3s/jg2Tc3KY8+3cfn6yZGf/ruCSmpG7YbKSdKNQDyJGB
	 LaYru41mYHoLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB282380CEF8;
	Thu, 27 Nov 2025 01:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] Unify platform suspend/resume routines
 for
 PCI DWMAC glue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176420642874.1910295.6702519281405893980.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 01:20:28 +0000
References: <20251124160417.51514-1-ziyao@disroot.org>
In-Reply-To: <20251124160417.51514-1-ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, si.yanteng@linux.dev,
 chenhuacai@kernel.org, rmk+kernel@armlinux.org.uk, phasta@kernel.org,
 yangtiezhu@loongson.cn, zhaoqunqin@loongson.cn, vladimir.oltean@nxp.com,
 0x1207@gmail.com, hayashi.kunihiko@socionext.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jeffbai@aosc.io,
 kexybiscuit@aosc.io

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 16:04:14 +0000 you wrote:
> There are currently three PCI-based DWMAC glue drivers in tree,
> stmmac_pci.c, dwmac-intel.c, and dwmac-loongson.c. Both stmmac_pci.c and
> dwmac-intel.c implements the same and duplicated platform suspend/resume
> routines.
> 
> This series introduces a new PCI helper library, stmmac_libpci.c,
> providing a pair of helpers, stmmac_pci_plat_{suspend,resume}, and
> replaces the driver-specific implementation with the helpers to reduce
> code duplication. The helper will also simplify the Motorcomm DWMAC glue
> driver which I'm working on.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] net: stmmac: Add generic suspend/resume helper for PCI-based controllers
    https://git.kernel.org/netdev/net-next/c/4440bf5f2e75
  - [net-next,v5,2/3] net: stmmac: loongson: Use generic PCI suspend/resume routines
    https://git.kernel.org/netdev/net-next/c/c4064af1c7e3
  - [net-next,v5,3/3] net: stmmac: pci: Use generic PCI suspend/resume routines
    https://git.kernel.org/netdev/net-next/c/b35e94edf229

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



