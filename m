Return-Path: <netdev+bounces-22962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C176A352
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F451C20D35
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B31E51A;
	Mon, 31 Jul 2023 21:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC231DDDC;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 830EEC433CA;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690840222;
	bh=HRUAYLY4xMp5A21cfdxIGXZgK/4NLgM8TKnmkB3vKl4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J+oiR05Po6f7gdgEkH5gS0PcUNqJP2avdwKvcHmq8EI3N9+EDfRFntp+oTIxBnRTT
	 Fa63T58zWEGqkBpOKeMRwjJ8ZUkZMDFDMGJFar2QowBOaIMY9Lmwv+Gq3k2D6oOL2T
	 qnYPy/144SO6E38pnoEwmKjaKt8OCgVjUUjAbBbsJltvsiYA0NPd15nhcM7SrhP0zZ
	 UU/7SKzlhf9htf1vjLQqn4ppEi3vHt7uIskHmU1qxDRSOL9yFnA8YcjVefwmvoXIaY
	 jMo461lprdODQc0sIV5GxIw6fbGaEfNnv9etHoowiWkW/ZqfobV4qneSUu8god3Z6Q
	 ejN+O6YPpUucg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58455C595C5;
	Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next 0/3] Connector/proc_filter test fixes 
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169084022235.13504.17826979255292322380.git-patchwork-notify@kernel.org>
Date: Mon, 31 Jul 2023 21:50:22 +0000
References: <cover.1690564372.git.skhan@linuxfoundation.org>
In-Reply-To: <cover.1690564372.git.skhan@linuxfoundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, Liam.Howlett@oracle.com, anjali.k.kulkarni@oracle.com,
 naresh.kamboju@linaro.org, kuba@kernel.org, davem@davemloft.net,
 lkft-triage@lists.linaro.org, netdev@vger.kernel.org, llvm@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 11:29:25 -0600 you wrote:
> This 3 patch series consists of fixes to proc_filter test
> found during linun-next testing.
> 
> The first patch fixes the LKFT reported compile error, second
> one adds .gitignore and the third fixes error paths to skip
> instead of fail (root check, and argument checks)
> 
> [...]

Here is the summary with links:
  - [next,1/3] selftests:connector: Fix Makefile to include KHDR_INCLUDES
    https://git.kernel.org/netdev/net-next/c/165f6890586e
  - [next,2/3] selftests:connector: Add .gitignore and poupulate it with test
    https://git.kernel.org/netdev/net-next/c/f4dcfa6fa1a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



