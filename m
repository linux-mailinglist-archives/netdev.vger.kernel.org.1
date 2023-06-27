Return-Path: <netdev+bounces-14332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C2F7402D9
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 20:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5091C20B12
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5F1990D;
	Tue, 27 Jun 2023 18:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C61308A
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 18:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5CB4C433C0;
	Tue, 27 Jun 2023 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687889422;
	bh=kfiAacQdD7qLCWrdw5MVrFHxdOHYaIiUktgveu5w3Is=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qnh3py2faCSBjAQvGp3cnGrNFaMor7DytEuR4gXwTd4XYF/uyAZ1eZKFFgeN/yiZU
	 VR892rDRWYHHuI8AKGjP7NVNgPKMOwIG4gVNnc7BecxCy3y7Oya/cHLvSjgxRy0HWp
	 N/hZKdcVFinpgPTrt5iSxkS/QelgbHICkuk4sShYcrG/bVsBUH7i7RF6yz8tGdPFzT
	 cPYtZVmqHVS/gRh9f0Xhh3r/3fBPrIKiw/K0LGuPNuAmHZDi+Q3MXFKiN1dPUfuDJ/
	 E/7JfSPQ+ti+NoM4OGTkq0L3yGI4pzJP0yDkghfG20LhSEPTorraQuHj17DEF5B5+F
	 wsg3mGRGoxFjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA55BE53807;
	Tue, 27 Jun 2023 18:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/2] af_unix: Followup fixes for SO_PASSPIDFD.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168788942182.15653.17504067646804498753.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 18:10:21 +0000
References: <20230627174314.67688-1-kuniyu@amazon.com>
In-Reply-To: <20230627174314.67688-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alexander@mihalicyn.com, brauner@kernel.org,
 luiz.von.dentz@intel.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 linux-bluetooth@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jun 2023 10:43:12 -0700 you wrote:
> This series fixes 2 issues introduced by commit 5e2ff6704a27 ("scm: add
> SO_PASSPIDFD and SCM_PIDFD").
> 
> The 1st patch fixes a warning in scm_pidfd_recv() reported by syzkaller.
> The 2nd patch fixes a regression that bluetooth can't be built as module.
> 
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/2] af_unix: Skip SCM_PIDFD if scm->pid is NULL.
    https://git.kernel.org/netdev/net-next/c/603fc57ab70c
  - [v1,net-next,2/2] net: scm: introduce and use scm_recv_unix helper
    https://git.kernel.org/netdev/net-next/c/a9c49cc2f5b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



