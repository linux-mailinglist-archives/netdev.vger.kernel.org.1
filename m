Return-Path: <netdev+bounces-15061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204D7745753
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF3B1C20913
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6206C80A;
	Mon,  3 Jul 2023 08:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074162115
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C6BAC433C8;
	Mon,  3 Jul 2023 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688373020;
	bh=en4IMgzUw/R5Cxp3guHimSlytEJd09sz1saQQhNLWEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mOZLIv2mpyvUhA9leIdespQO4uciNkfl7wH8RIxlqQK1xS/1Q/qNGbm8U4+TI0mld
	 AeZgGsMxg2BBA/J52jJsLf4fvPRYooH44VPH1CXSxukGESPPzvJfzRIR+A4j8Gm1pB
	 nktTkmI8CdnJkTmE9CF4EPGduUX0IFIJSpvrVDmYDQsdGYaEXwbfD1B55VSTIugOdj
	 0n3Cyi69Kc5h4okG/UdXVvAJE/LFF+WQuvuPRmUxFq9yBsNDLkpPu2fIftyPZsbczO
	 A7qnqee2w1FpLWLvx77dsBR26AYE7zSt+Qo+xMkYAh1E9BgiG9ctfJhiUqFt/qXsD9
	 Eu1MU3TTH13YA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3523EC64458;
	Mon,  3 Jul 2023 08:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Documentation: ABI: sysfs-class-net-qmi: pass_through
 contact update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168837302021.15739.3452355484748361369.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jul 2023 08:30:20 +0000
References: <1688109620-23833-1-git-send-email-quic_subashab@quicinc.com>
In-Reply-To: <1688109620-23833-1-git-send-email-quic_subashab@quicinc.com>
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 corbet@lwn.net, quic_jhugo@quicinc.com, dnlplm@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 30 Jun 2023 01:20:20 -0600 you wrote:
> Switch to the quicinc.com id.
> 
> Fixes: bd1af6b5fffd ("Documentation: ABI: sysfs-class-net-qmi: document pass-through file")
> Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
> ---
>  Documentation/ABI/testing/sysfs-class-net-qmi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net] Documentation: ABI: sysfs-class-net-qmi: pass_through contact update
    https://git.kernel.org/netdev/net/c/acd9755894c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



