Return-Path: <netdev+bounces-59485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E0A81B07B
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 09:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB94A1C2320A
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A03168D3;
	Thu, 21 Dec 2023 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfowgOoI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A8171A4
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69DFBC433C9;
	Thu, 21 Dec 2023 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703148023;
	bh=1nDl6OLfjVQpXI3B8V5tBxMDbA6FLIm3sFbVsZBEbQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hfowgOoIFN9z1TW3aZRL0NYl2laSDGYAh2QXUoIBFnRSAR1DfvxFgBJqjqjcecPdm
	 iM8dkKtPyMqqjQ/phNU1WyboZ+ZV2YKu06UMKMxlY0Ybpz2P5+bAAKZV/G1Vw17SBC
	 xtPgEsbe2f4YR5LACOZIZjyW+uvnG+rP7RUaxFj1RYh4KpdO4Y4p+qpXovGNt1J2R+
	 9YSfL9YUl3IhAmFZcLsj9EVPQfFAaG5aTZp1FC4I0DzrDIGu+w9YNX2p/nTUsXew2r
	 ZptXuAh2Mh/Gjs2uCNJ+1wuyKAFHSF6NqDKrwCD5Hzre4EPFgm8hxTWGxiW1CfN6Hd
	 YY3iC0m7XTsDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5149BDD4EE4;
	Thu, 21 Dec 2023 08:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] kselftest: rtnetlink.sh: use grep_fail when expecting the
 cmd fail
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170314802332.7847.13935624251523959703.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 08:40:23 +0000
References: <20231219065737.1725120-1-liuhangbin@gmail.com>
In-Reply-To: <20231219065737.1725120-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, dmendes@redhat.com, fw@strlen.de,
 davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Dec 2023 14:57:37 +0800 you wrote:
> run_cmd_grep_fail should be used when expecting the cmd fail, or the ret
> will be set to 1, and the total test return 1 when exiting. This would cause
> the result report to fail if run via run_kselftest.sh.
> 
> Before fix:
>  # ./rtnetlink.sh -t kci_test_addrlft
>  PASS: preferred_lft addresses have expired
>  # echo $?
>  1
> 
> [...]

Here is the summary with links:
  - [net] kselftest: rtnetlink.sh: use grep_fail when expecting the cmd fail
    https://git.kernel.org/netdev/net/c/b8056f2ce07f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



