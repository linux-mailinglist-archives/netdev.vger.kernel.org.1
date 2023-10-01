Return-Path: <netdev+bounces-37267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2077B4787
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 15:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 80FF028183C
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC2171C7;
	Sun,  1 Oct 2023 13:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61809CA61
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 13:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D017C433C9;
	Sun,  1 Oct 2023 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696165823;
	bh=5ZIW3UmcJpV9ryoeHI68kk41pOEpE6VkLMA3C0l5oNQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tNl4mvplbfFNjbA97OBD9BOg25ApHk3bcJZrjtaQlixtMuJjWkYQcqe0VRSiBf642
	 cqdNTJzwaKRiv7+EwoGzxmIDGNLWSlPv/IQ3dyMPwMZUWT2f0iNt5spJkaraYvvj1t
	 JRCCaRkRx6liolxVkzbCE4XLuDlzEEd7QiACcThMmvzLrHFncEG/QvgFOInCuF0jEz
	 AirUONBCquQ8n/vyzHXcFqvx3Yq6XoZ2x2krn54wUF803ZFooxkx6pu4GrFcLdJqaD
	 rnB6wxBdNXn9wvAh6djKoWYYu8eZqVpf2kb0oapoeXRru6cKoZ6L1ypDBVzXC8MIvg
	 DNN/BNr9CDx8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 414E3C64457;
	Sun,  1 Oct 2023 13:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: xilinx: Drop kernel doc comment about
 return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169616582326.2903.10174683608537973938.git-patchwork-notify@kernel.org>
Date: Sun, 01 Oct 2023 13:10:23 +0000
References: <20230921063501.1571222-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230921063501.1571222-1-u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@codeaurora.org
Cc: davem@davemloft.net, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 kernel@pengutronix.de, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Sep 2023 08:35:01 +0200 you wrote:
> During review of the patch that became 2e0ec0afa902 ("net: ethernet:
> xilinx: Convert to platform remove callback returning void") in
> net-next, Radhey Shyam Pandey pointed out that the change makes the
> documentation about the return value obsolete. The patch was applied
> without addressing this feedback, so here comes a fix in a separate
> patch.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: xilinx: Drop kernel doc comment about return value
    https://git.kernel.org/netdev/net-next/c/f77e9f13ba09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



