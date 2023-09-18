Return-Path: <netdev+bounces-34545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D75E7A4910
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DC51C20A32
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9E11CA9E;
	Mon, 18 Sep 2023 12:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED12594
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1FDDC433C9;
	Mon, 18 Sep 2023 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695038423;
	bh=Ni0eR8OTKOtQebhcs2oSdkQO4hfRNZ1h4rEUJWi0vE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eiiuTscW2dccO8+TpLHSgnSNMxZ0JiqNSAMjd8Wos/kboeacJemeHDVTu5FwFp6rn
	 iHRFUM1L2lxUJBB0AKk5moSdADBuijcZ3Q0vr5pnjiF1R4NxmXbCHhcLo8nEfv0hkj
	 2J73kOE64DXdvNEcz/TBn4aLHhdTsA2L9szhhAxm1uof1o4KG1ABABg1Fj64RH3oZ/
	 vceplLqR6Uf5LzH8Re9erFPqGi0uXqFuge2qcp1iOXqSt7jTtedMIiH5m+orgtLLKs
	 Kk/NTlCX8MUZoni2puvw8h6zVgTh5L/xcD9ITzICuScGD78mJK27m2sCP5Q1gnOrIQ
	 5TFfpZ7VdF1qQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7B0CE11F41;
	Mon, 18 Sep 2023 12:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] ax25: Update link for linux-ax25.org
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169503842374.7731.4777712739974344012.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 12:00:23 +0000
References: <20230917152938.8231-1-peter@n8pjl.ca>
In-Reply-To: <20230917152938.8231-1-peter@n8pjl.ca>
To: Peter Lafreniere <peter@n8pjl.ca>
Cc: linux-hams@vger.kernel.org, thomas@osterried.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ralf@linux-mips.org,
 linux-doc@vger.kernel.org, corbet@lwn.net

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 17 Sep 2023 15:29:44 +0000 you wrote:
> http://linux-ax25.org has been down for nearly a year. Its official
> replacement is https://linux-ax25.in-berlin.de.
> 
> Update all references to the dead link to its replacement.
> 
> As the three touched files are in different areas of the tree, this is
> being sent with one patch per file.
> 
> [...]

Here is the summary with links:
  - [1/3] Documentation: netdev: fix dead link in ax25.rst
    https://git.kernel.org/netdev/net/c/418f438a2db6
  - [2/3] MAINTAINERS: Update link for linux-ax25.org
    https://git.kernel.org/netdev/net/c/1943f2b0ac5a
  - [3/3] ax25: Kconfig: Update link for linux-ax25.org
    https://git.kernel.org/netdev/net/c/71273c46a348

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



