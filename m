Return-Path: <netdev+bounces-45698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595FA7DF12D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF42CB21067
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98414A98;
	Thu,  2 Nov 2023 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXve6Hu5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75CC8E2
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 11:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AC9AC433C9;
	Thu,  2 Nov 2023 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698924624;
	bh=A+QTuP4H2KqMqbO8ewDZNTpUxhLTk27eTGwNl1gvwUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tXve6Hu5PHF1S084mucTYeLulgOp5aJRp7C2G+efosnckCa5NjMw7Fcg1af9i3I3V
	 /I0vHBGxouaaVfar2kt45UmmHfLxMf9Cb+Q33FtCaazscxnjrrtBt8zEU80ubLYIrA
	 D8HOw+4nQgSuelVTiO5l22S4b2R35mwul290Xu04SuU5is2kG0WCFFqh8gRzoBIsYr
	 3q6NIE67Cf+rpXwmEjVhp7Ym4drkHB9+Q+DL7FPQNQDIFlUGTaELaZwRdSuEfS8drk
	 y9lXWcxAoqi7b4IsCA0Iog+e7Jgb7ByfFvejwV5PTFiilN4gt+o1SC0udTCyATz73b
	 BirGmwhQZp6ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D159C395FC;
	Thu,  2 Nov 2023 11:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: ethtool: Fix documentation of ethtool_sprintf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169892462437.16317.7188504016558577027.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 11:30:24 +0000
References: <20231028192511.100001-1-andrew@lunn.ch>
In-Reply-To: <20231028192511.100001-1-andrew@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, justinstitt@google.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 28 Oct 2023 21:25:11 +0200 you wrote:
> This function takes a pointer to a pointer, unlike sprintf() which is
> passed a plain pointer. Fix up the documentation to make this clear.
> 
> Fixes: 7888fe53b706 ("ethtool: Add common function for filling out strings")
> Cc: Alexander Duyck <alexanderduyck@fb.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [v1,net] net: ethtool: Fix documentation of ethtool_sprintf()
    https://git.kernel.org/netdev/net/c/f55d8e60f109

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



