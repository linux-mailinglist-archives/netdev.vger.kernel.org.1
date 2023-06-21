Return-Path: <netdev+bounces-12462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C07EF7379D2
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E3D1C20D5C
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4A35C9B;
	Wed, 21 Jun 2023 03:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7EA3C2D;
	Wed, 21 Jun 2023 03:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88EB7C433B6;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687318822;
	bh=D8jvkOTPdmO0u5o55l9cr1Aye25QMAx0UYHTkGhgK08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=llr3kw6qEFuHcHIllGiEPl2yFyAGiJ3KZJ9tkteZhuGDNAyG6Spc2RBp4KTATfblU
	 ZB1Qcp/xu8B2b/m13U4At2RepuRZ8Br4EsWdURcJUvoquZ8XITy+pp0cufxXURbbpa
	 D5//JacKlnU2B6Rb/byjzX9k8H+4LVReqruNY2FZ3wn87dAwnrSF005yqOkvp8bAT2
	 29gGG7GAEZOJjc3b1RgsA380kbuxTyGAnXozOas98YJbANITKQExieRUIszZEmmgWl
	 KNLV58Q79WGnTfq9zvyB42EcYaODat9iFagrEyakC4mlJH/z7kyzkzcH5o8AQKV79G
	 S6UaA94++Uzaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48DF9E2A037;
	Wed, 21 Jun 2023 03:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: Reorder fields in 'struct mptcp_pm_add_entry'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168731882229.8371.954122790611949786.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jun 2023 03:40:22 +0000
References: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e47b71de54fd3e580544be56fc1bb2985c77b0f4.1687081558.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: matthieu.baerts@tessares.net, martineau@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 18 Jun 2023 11:46:46 +0200 you wrote:
> Group some variables based on their sizes to reduce hole and avoid padding.
> On x86_64, this shrinks the size of 'struct mptcp_pm_add_entry'
> from 136 to 128 bytes.
> 
> It saves a few bytes of memory and is more cache-line friendly.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - [net-next] mptcp: Reorder fields in 'struct mptcp_pm_add_entry'
    https://git.kernel.org/netdev/net-next/c/92b08290859b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



