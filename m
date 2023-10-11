Return-Path: <netdev+bounces-39801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D74237C482B
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07312824F8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5650C127;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STbSyrL2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017A6FC2;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C2ADC43395;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696993826;
	bh=tcn66kt+l9iDn6H9EiJxQxImbQ3H8oPLkbEIEMBGK7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=STbSyrL256HXlI5d8ErZzje4nEtk/t+xxlCs4d4EYW5g9knu9OzqiSKN6frIUSwTq
	 xGrMdGeMxgOFzusTGNJerzoIapceKMb/E7BzBtd8C36y8InP+6HwnOdDoCTAAyCJrA
	 hvMq9dIkLJda1s1XIhaY2E5UaPxkNcjNez0O3vEYyPqRZjKJIJ7pj/KQHp+27CSFck
	 bFg6dhqZfkKaM+JEI7AKkqy46IBP/wa9Y4NTQSeEs5Bs0a2MFrOcmqYO/qbVIqwMj/
	 NMxYsDlOhkFkOr4zYKDzdH9y6dmEPYhbyXPrkgOPdXpxIMxlR8p5xPALq3v814N2gE
	 KhaXfg3AgTyXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5158EE11F44;
	Wed, 11 Oct 2023 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy with
 ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169699382632.3301.16295806677296620947.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 03:10:26 +0000
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Oct 2023 22:43:59 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: dsa: realtek: rtl8365mb: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/e5f061d5e340

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



