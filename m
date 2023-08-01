Return-Path: <netdev+bounces-23041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B276A76C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 05:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD491C20E48
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256E1C30;
	Tue,  1 Aug 2023 03:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B415C8
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 03:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7D3DC4339A;
	Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690860023;
	bh=iTMikfldINqWqsR1JIcAlJUaV/udL2WHA91wXWhrUS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sA6emx7gv3Ox5ESHA264b0zyShHx16gwFx3Ufigr4DxORTc5k4jis0tIwiJ4z0Uv4
	 kATRdooJbVronWNxx70GsiKwEitMCCGsANs2gc9Dxya76CWAxbNsBAGoVPx5cGipOO
	 QCWyrYMa9yUOOO05JJprHuL/JiebhuMk1kaOOwTV5qRJ6Du+vwtgL/8QEnsLvA0cgT
	 tJZZXEv4EL5Kv7mIl9QzeCOL0yztqkMAehvg+LnnPmQG/17iM/IbN8jH1CojIbQNAw
	 kXqrpxzNkOA9FPR5PCxDLeYknq+KFr9GWrTDLialzQrUe+pIvvPOrK1dx1lfAxW0UB
	 A+Jrm0hoUU/hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A88DCC64458;
	Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v2] selftests:connector: Fix input argument error paths
 to skip
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169086002368.11962.9239503173923058781.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 03:20:23 +0000
References: <20230729002403.4278-1-skhan@linuxfoundation.org>
In-Reply-To: <20230729002403.4278-1-skhan@linuxfoundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, Liam.Howlett@oracle.com, anjali.k.kulkarni@oracle.com,
 kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 18:24:03 -0600 you wrote:
> Fix input argument parsing paths to skip from their error legs.
> This fix helps to avoid false test failure reports without running
> the test.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> v2: Removed root check based on Anjali's review comments.
> Add netdev to RESEND
> 
> [...]

Here is the summary with links:
  - [RESEND,v2] selftests:connector: Fix input argument error paths to skip
    https://git.kernel.org/netdev/net-next/c/04786c0659db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



