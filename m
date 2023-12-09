Return-Path: <netdev+bounces-55500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5505080B0E4
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 01:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E4E281C30
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00432622;
	Sat,  9 Dec 2023 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EH+gHye7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4484373;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51315C433CB;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702081229;
	bh=aM88ROu9oL88auUmLTsCQpwQxZMkwdmXBiQMpTTqQSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EH+gHye7xYb8y3BphwLd0UBFG9LNPfZMuF9s8jX/29WeT3UEwoXEpkFxvC0luhwGO
	 Z/XRv0iKrW1ulErGVEWdm+i/hKiytgTX/WvKB96iDUsMxidioJP/WhFbTE+MTa7Q4c
	 O2AmMOrOktlIfMSD0U30VbNHfP5xj94BBsVj366w6/UUpfPpPt3EBzZepqGJCVYwsL
	 WbT1AGnpzR4+JGYPOItjCYLXlXrQvjBeA/sRLX+g6B39wm8y8u8Pvh1O+6rHeYJy/M
	 zltrn7O2xYfbErzS7HZwmps/rb6EkiT3h4kD7y2EF03rZECBntSj1DGLi1CFHqAz4G
	 piDMcXlJvJgjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33D1CDD4F1E;
	Sat,  9 Dec 2023 00:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: remove myself as maintainer of SMC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170208122920.21357.7598975348992101022.git-patchwork-notify@kernel.org>
Date: Sat, 09 Dec 2023 00:20:29 +0000
References: <20231207202358.53502-1-wenjia@linux.ibm.com>
In-Reply-To: <20231207202358.53502-1-wenjia@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 kgraul@linux.ibm.com, raspl@linux.ibm.com, gbayer@linux.ibm.com,
 twinkler@linux.ibm.com, pasic@linux.ibm.com, niho@linux.ibm.com,
 schnelle@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 alibuda@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Dec 2023 21:23:58 +0100 you wrote:
> From: Karsten Graul <kgraul@linux.ibm.com>
> 
> I changed responsibilities some time ago, its time
> to remove myself as maintainer of the SMC component.
> 
> Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: remove myself as maintainer of SMC
    https://git.kernel.org/netdev/net/c/a45f1e462742

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



