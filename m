Return-Path: <netdev+bounces-28987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D5781574
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6EE1C20BB3
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D891774C;
	Fri, 18 Aug 2023 22:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7C378
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 22:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02602C433C9;
	Fri, 18 Aug 2023 22:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692398422;
	bh=pphJOl9LcFEZfc59hQjrvgqeXPyUvIX5+2mgM8hIiEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gUWo3mUNIMdzj8iXHIj565OjfnBqZ+HHuk3n6o29sXre0/8M3IMuSy05Bw5RU2e7i
	 cINMR7VYgJinU9sFDw/xY2MJHeL/mZwAPj7ijGj4XkVxg8U3K2p2POxTlMpd8uwyWs
	 DDbtDmUIxjktYn4K/Pcw3AD72PW7Q7q4I/adQxa71M6hTD16+0wdym0XppgDnyKr1R
	 YrepK3lCl0o9GzyMG3Up0PQD9iQmcfMt3GL4/fXJlWuPF9uwYEZripbYPMeQS4Fnse
	 okXqR74Q+BzixfjwFhC2dgoRMWxaBa+v0cRnH1dhR2j8u/e3CwHxOe90SyfiIBk4EA
	 MKalbsKrrA2qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D449AC395DC;
	Fri, 18 Aug 2023 22:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] octeontx2-af: SDP: fix receive link config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169239842186.2718.13546826553275633730.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 22:40:21 +0000
References: <20230817063006.10366-1-hkelam@marvell.com>
In-Reply-To: <20230817063006.10366-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 12:00:06 +0530 you wrote:
> On SDP interfaces, frame oversize and undersize errors are
> observed as driver is not considering packet sizes of all
> subscribers of the link before updating the link config.
> 
> This patch fixes the same.
> 
> Fixes: 9b7dd87ac071 ("octeontx2-af: Support to modify min/max allowed packet lengths")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: SDP: fix receive link config
    https://git.kernel.org/netdev/net/c/05f3d5bc2352

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



