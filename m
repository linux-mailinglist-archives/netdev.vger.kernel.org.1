Return-Path: <netdev+bounces-38162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF9C7B9952
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 41EC12826A8
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29925627;
	Thu,  5 Oct 2023 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN9FqiaE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DB15B8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83D56C433B9;
	Thu,  5 Oct 2023 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696466429;
	bh=gVMpMBHhfNCTNhptjHWbXIZPIGWQUNaJjz3gg1YA94Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FN9FqiaEBMXrg0L02xWirhUxAPiwRr5rOgwfWJNbJ92+b+jZDoBTTWWjTyYmY+Ero
	 UE63pkP2mqzmXk9yzUmighqQG2SGs2reqIjWD3F5tNiGtMHU15+ndiK3tdtbr5Q+P+
	 wGcUWbtbMVj0+JynK4SAewJJMzS1kTwOQtPpEdVQyrz22+YSFdoADa1KzavRTz/Fq8
	 ngtlvCN577zSgy5gVPAMALell6eJ31xzFI7foRDahDj2lXYd2oM5Ynl9pvPqzoA3xm
	 I7kn0RZRgO1Ot2cDUvvrjFPubVs4S6oHyMHhDYK7niJ8cfbDWDCya54mlv77H+n8T7
	 tmAbPGalulLuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7116CE632D7;
	Thu,  5 Oct 2023 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] ynl Makefile cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169646642946.7507.3710858393417446961.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 00:40:29 +0000
References: <20231003153416.2479808-1-kuba@kernel.org>
In-Reply-To: <20231003153416.2479808-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sdf@google.com, lorenzo@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Oct 2023 08:34:13 -0700 you wrote:
> While catching up on recent changes I noticed unexpected
> changes to Makefiles in YNL. Indeed they were not working
> as intended but the fixes put in place were not what I had
> in mind :)
> 
> Jakub Kicinski (3):
>   ynl: netdev: drop unnecessary enum-as-flags
>   tools: ynl: don't regen on every make
>   tools: ynl: use uAPI include magic for samples
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] ynl: netdev: drop unnecessary enum-as-flags
    https://git.kernel.org/netdev/net-next/c/0629f22ec130
  - [net-next,2/3] tools: ynl: don't regen on every make
    https://git.kernel.org/netdev/net-next/c/a50660173c73
  - [net-next,3/3] tools: ynl: use uAPI include magic for samples
    https://git.kernel.org/netdev/net-next/c/e2ca31cee909

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



