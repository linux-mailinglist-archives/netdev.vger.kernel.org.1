Return-Path: <netdev+bounces-62292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF04B826733
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 02:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00CC7B209EA
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068FA800;
	Mon,  8 Jan 2024 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGh8feVE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CE7F
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 01:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5569BC433C9;
	Mon,  8 Jan 2024 01:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704678623;
	bh=mAT4nJ+985NRnS2/lJoWIBGCvYwZZD5pnRmy20/JGfE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YGh8feVEUyxCPkw1LaNHV/r2rFSVqYE7EoguhAIvf6di+MmaQhB7W+VM429GgNX+Q
	 T9QmvBjQyG15MmykgrLs6qudRBUMysxN29tpx5gJgNVXMu7K+xprilb3RimThYMNcT
	 JHqcs3UkIKLwb1Nhw16cQGzBsgiYQtUqr/PAMggu0UyQ+BllpDENlw2YHsATVJTIuq
	 KUyEUNQYbxpob9u94xXW5a5bgUx+r6fdanBuYAD8vszMWmql3rhhkn3yKmpCswqOST
	 J4E5FH7dOKXswpKlOFPu4OTg3c44i57K2mxqc16VyVPcnzFEnHMDbWd1H4S5fHLviI
	 xfIhnsU8LWrkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BE8EC41620;
	Mon,  8 Jan 2024 01:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] remove support for iptables action
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170467862324.24659.6040892717113322740.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jan 2024 01:50:23 +0000
References: <20231226182531.34717-1-stephen@networkplumber.org>
In-Reply-To: <20231226182531.34717-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: jhs@mojatatu.com, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 26 Dec 2023 10:25:09 -0800 you wrote:
> There is an open upstream kernel patch to remove ipt action from
> kernel. This is corresponding iproute2 change.
> 
>  - Remove support fot ipt and xt in tc.
>  - Remove no longer used header files.
>  - Update man pages.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] remove support for iptables action
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=45dc10463dd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



