Return-Path: <netdev+bounces-167595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B414A3AFB9
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D767A4FD2
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3ED19CC33;
	Wed, 19 Feb 2025 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB+Iin3X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813D0190072;
	Wed, 19 Feb 2025 02:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932809; cv=none; b=Rbz/NSdbvApzbvpxtzs0SnMm6ZQiS1FPBuhretimrlTCzmfgWyLDWxh6NxBR4lO4NBVyAde/Jq+i+UeWC3tWHyYZsNM7OFc0s480yGRkzI6sIUroSOmnI8YzjMjxWRTsXmpdZH/9x4VRyJP0jLLG7Av4nM/7vbOxZc7UN0j6zos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932809; c=relaxed/simple;
	bh=tiloIvKYtmvXtq9n1DhVPEZySCD0vWC9KJmidWCd6WI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=egDJ6bc7qgYqTn9tVN6n7y34emiL2WMJu0nmWIIJGYFD3C/Of+gc3GJYjOY7YMlr1x66RbdmZhCidUmotVz5a/u/55C8/WABbsrY4N/A19g1PjdC+AluVfYgVSZfoa/yWNaV6SYk32SMoQqOHZpMDoX977ccP8tNIEcGDm45t74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB+Iin3X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C97DC4CEE2;
	Wed, 19 Feb 2025 02:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739932809;
	bh=tiloIvKYtmvXtq9n1DhVPEZySCD0vWC9KJmidWCd6WI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XB+Iin3XPAjVvL9N79BtkHn77dq1a1SJnFIzHpUj16mDKcT2YG8XFxuYml5chlHL6
	 aOno2cdTwrJ3pCGVsD1SWy0MpNbh3s+d6CzSmtNcY3VxWYs9OBUZWzglENxTvRk5o0
	 9nKLAvNS6nefRCBLcu4r9rJPUA4TWiH+HjpA46Yowab/fx8w6ieu+vA6HfyDL/+tHT
	 5SM8Ue9b+cqW4Nrcq+pUDHtwhlj+LhOF+I3sqyIcSmn/K6LdP9ySU+rgfv+Wo5Ex9f
	 3cs50kXPb6OErfAJzQR83wdbHW35fJHF19A9LC9Glm58VAY4/ikfroaJjCOAnlQUMt
	 hblzaZNmkiLUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC00380AAE9;
	Wed, 19 Feb 2025 02:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: Use str_enabled_disabled() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993283976.110799.6484723718905539141.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:40:39 +0000
References: <20250217155833.3105775-1-eleanor15x@gmail.com>
In-Reply-To: <20250217155833.3105775-1-eleanor15x@gmail.com>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 jserv@ccns.ncku.edu.tw, visitorckw@gmail.com, lkp@intel.com,
 chenhuacai@loongson.cn, rmk+kernel@armlinux.org.uk

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 23:58:33 +0800 you wrote:
> As kernel test robot reported, the following warning occurs:
> 
> cocci warnings: (new ones prefixed by >>)
> >> drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:582:6-8: opportunity for str_enabled_disabled(on)
> 
> Replace ternary (condition ? "enabled" : "disabled") with
> str_enabled_disabled() from string_choices.h to improve readability,
> maintain uniform string usage, and reduce binary size through linker
> deduplication.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: Use str_enabled_disabled() helper
    https://git.kernel.org/netdev/net-next/c/3a03f9ec5d33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



