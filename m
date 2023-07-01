Return-Path: <netdev+bounces-14952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E647448DB
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7671C208CC
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03F8837;
	Sat,  1 Jul 2023 12:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49D79DC
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 12:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93D08C433C9;
	Sat,  1 Jul 2023 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688214022;
	bh=j/F3EMJmjt1TzwbrXWlUlIvyAVC9WhXfUj+oiJF+y4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j21R695fzgXGo42ajgxlOziLZtRqvaNrpkC/b4v+yj9eC5iodwW+ZzEt7Y0aTYXw6
	 An5NR2hsIkoLlNnGxdlJuqMGtvz3BDjjblGoalf3huASnz2WkWs0WSOAxnQjgZGjWQ
	 fN7JxeC73BMQo66rgUfG/9Lr1tpSXKV5Bmfy03SCjpDbZ/S1BW4/NmrlxTGpyqF3Mc
	 +RDj6gaywXoSRt3Mu1q9U7OuN+nmJmr2Mu2acTD0B4lY+EFN0FKVUNsL6zSMSy3mka
	 IXaSfU/tVYEHoQVqMxcr/XVZj4KauNylaweGB6kI2kd2eZ9JPH0WDbhAyJl2hisI39
	 xSOi3fSv6Nl4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79282C6445B;
	Sat,  1 Jul 2023 12:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] docs: netdev: broaden mailbot to all MAINTAINERS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168821402249.27463.14270246072324876114.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jul 2023 12:20:22 +0000
References: <20230630160025.114692-1-kuba@kernel.org>
In-Reply-To: <20230630160025.114692-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 Jun 2023 09:00:25 -0700 you wrote:
> Reword slightly now that all MAINTAINERS have access to the commands.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/process/maintainer-netdev.rst | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net] docs: netdev: broaden mailbot to all MAINTAINERS
    https://git.kernel.org/netdev/net/c/d5dc39459bda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



