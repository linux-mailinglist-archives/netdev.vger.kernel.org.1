Return-Path: <netdev+bounces-50896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7320B7F77D6
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0FFB214B4
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE9D2EB09;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLgs4ogk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1D2EAED
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35CB2C433C7;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700839826;
	bh=WexwOzpVrFkDu3mYppP5sTkcgfWf//SGzVEzAkH6E5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qLgs4ogkvcGmG0O/Rhju8feyfz6Nm8+mZQpjLvolQxfcauzMjv6BO5W9OLpk2hsyj
	 dCuMW+DPLN9G3lUqk6BUHjh+sn18Dqc0qTq35uv/HfpK4iemGZgDwnCX0e8Zk/9Tmu
	 H4a7YvWqPL2SuK9agdNKTyLaOOlRFfwn22LSBLPaKTFoOt+jHSyf0F2bw8c9Xun3J3
	 JhQtmCTJQ6fZOYozTiaQ9CTP+GRUZB5f/SiYKy9LbcjTGTOns2/Bjp0sx/TdRvLQdK
	 P4gTuTbO6SawcxVX7PKf6Yj3/FNQuUfx7tLDb8Wq9r+j73P0hIXM1aeQ1/YeKAmTGv
	 sNat4uOn9Mn9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22E23E00087;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: use enum name from the spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170083982613.9628.7993750148268572419.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 15:30:26 +0000
References: <20231123031050.1614505-1-kuba@kernel.org>
In-Reply-To: <20231123031050.1614505-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 19:10:50 -0800 you wrote:
> The enum name used for id-to-str table does not handle
> the enum-name override in the spec correctly.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/ynl-gen-c.py | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] tools: ynl-gen: use enum name from the spec
    https://git.kernel.org/netdev/net-next/c/30c902001534

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



