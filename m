Return-Path: <netdev+bounces-250419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1394D2AEA4
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35D2D3082A31
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523893431EF;
	Fri, 16 Jan 2026 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBmRG28x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F314342CBB
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535032; cv=none; b=nJ8QIgNA64jhBhuXaYI50Ay+4F5hoH7rVUcc/5OivnJuhg36TJEpqN/F+Uy2ggpGY1XQdZVAqZbRJqPqabrR5a+wbsOYv9mP7G5Demc1t28bGLnvZZ/HY23fkk5ceOXveErY5QqtRdUe/eawHrnSafX/xER1r+tkRKcWd+HmiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535032; c=relaxed/simple;
	bh=L02Y2R7LpNrV3GT0d864plT7u3FbUklHIX6aHiChijw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hSmLnRnbowMXD9qh2fmX//dbs0Oio/99BkEt3mPAS1JjtgAKmr1UBGQsG5g3amc5RHGgtvcpzpvQ1ydDmgLFF07N27bBowvAjOe83sbueEiZLiynab4o4WnKhD7yvxqEU8h7mOm10BN3Vi9+DxhqV46wI68zngIR4y7u4zTsuoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBmRG28x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ABCC19422;
	Fri, 16 Jan 2026 03:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768535031;
	bh=L02Y2R7LpNrV3GT0d864plT7u3FbUklHIX6aHiChijw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NBmRG28x6JFkZbNfde9wS4SSBkbnmxe3G33OzLZhTZeemJyNTGlBDTB+xFVRR4kAc
	 j4qJ+CDUnMQO6sOmpvomcHOdjXWdhLtkStnE+utq6NpyzCaXCUdPRkVMG0ZRXqtfAH
	 wQMpkZlVoOqenPGbv6DfW9HDGjLiQ6B7gUGRQwx3hdiYxttHJzswSFfrw2G15Xg64G
	 rnqsdikqTLoW3Eq2jWA5lBtWdkDIFGObDKrQLbXsq0/eHUqFFrUOxS/up5FXQM8OD8
	 xy1cDBKo/DFEW8nkjhH5AmLlJr0bCmidDc6M6q3sAlUBTthYnzq+Qhu79AVX2glwLG
	 UhyfQcm6qgxtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A95380AA4C;
	Fri, 16 Jan 2026 03:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: ethernet: dnet: remove driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853482352.70930.5041536219342817635.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 03:40:23 +0000
References: <cef7c728-28ee-439f-b747-eb1c9394fe51@gmail.com>
In-Reply-To: <cef7c728-28ee-439f-b747-eb1c9394fe51@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew+netdev@lunn.ch, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, lorenzo@kernel.org, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 21:11:04 +0100 you wrote:
> This legacy platform driver was used with some Qong board. Support for this
> board was removed with e731f3146ff3 ("Merge tag 'armsoc-soc' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc") in 2020.
> So remove this now orphaned driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: ethernet: dnet: remove driver
    https://git.kernel.org/netdev/net-next/c/2c297957912b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



