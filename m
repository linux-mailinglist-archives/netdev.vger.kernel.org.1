Return-Path: <netdev+bounces-18055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A92927546A1
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 05:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC61B1C216B2
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 03:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B3EBB;
	Sat, 15 Jul 2023 03:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75DEA6
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AAD0C433C9;
	Sat, 15 Jul 2023 03:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689393022;
	bh=mjhOLI+yCD9rfoSJAQ1b1UeP1kkeR8pIp7XLs7anurs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hqYHDGlIuqx6UIDdefgNxJVFK2OVcg5sTDqrD9CRqRpHncmwTEWXKqaOlVTXZHKOZ
	 O/i/TM55YwqHMkx89KmekKuyrO5UNCJbRsTboIcYDQgKvyqAANFJylV2xJt+y6n+uy
	 MFcFzQ8w8vPePjo/KAI0DgTCbO72KdRLJEpAucTPj/5REYOOn7vget+t9MJ+inrqLs
	 5NHnS8e64q1B0CgZDwpKiW1opfWxSH2fRggIT438XtB5gmn/JLDJDVXaK1LxUkM7Ak
	 mmBKc0/4cmdznxjbiGgHpeR6ccYMUqNO5axQyfgPNnWUZsGjiB40wLMnRDTOWlk7di
	 Q0iW1e0kz/nTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11A75E49BBF;
	Sat, 15 Jul 2023 03:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/9] net: fix kernel-doc problems in include/net/
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168939302206.24345.17268044128458529302.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jul 2023 03:50:22 +0000
References: <20230714045127.18752-1-rdunlap@infradead.org>
In-Reply-To: <20230714045127.18752-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
 linux-wpan@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
 johannes@sipsolutions.net, mchehab@kernel.org, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, marcel@holtmann.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 dave.taht@bufferbloat.net, moshe@mellanox.com, jacob.e.keller@intel.com,
 razor@blackwall.org, benjamin.berg@intel.com, jbenc@redhat.com,
 lesliemonis@gmail.com, tahiliani@nitk.edu.in, gautamramk@gmail.com,
 prameela.j04cs@gmail.com, siva.rebbagondla@redpinesignals.com,
 kvalo@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jul 2023 21:51:18 -0700 you wrote:
> Fix many (but not all) kernel-doc warnings in include/net/.
> 
>  [PATCH v2 net 1/9] net: bonding: remove kernel-doc comment marker
>  [PATCH v2 net 2/9] net: cfg802154: fix kernel-doc notation warnings
>  [PATCH v2 net 3/9] codel: fix kernel-doc notation warnings
>  [PATCH v2 net 4/9] devlink: fix kernel-doc notation warnings
>  [PATCH v2 net 5/9] inet: frags: remove kernel-doc comment marker
>  [PATCH v2 net 6/9] net: llc: fix kernel-doc notation warnings
>  [PATCH v2 net 7/9] net: NSH: fix kernel-doc notation warning
>  [PATCH v2 net 8/9] pie: fix kernel-doc notation warning
>  [PATCH v2 net 9/9] rsi: remove kernel-doc comment marker
> 
> [...]

Here is the summary with links:
  - [v2,net,1/9] net: bonding: remove kernel-doc comment marker
    https://git.kernel.org/netdev/net/c/a66557c79020
  - [v2,net,2/9] net: cfg802154: fix kernel-doc notation warnings
    https://git.kernel.org/netdev/net/c/a63e40444e1b
  - [v2,net,3/9] codel: fix kernel-doc notation warnings
    https://git.kernel.org/netdev/net/c/cfe57122bba5
  - [v2,net,4/9] devlink: fix kernel-doc notation warnings
    https://git.kernel.org/netdev/net/c/839f55c5ebdf
  - [v2,net,5/9] inet: frags: eliminate kernel-doc warning
    https://git.kernel.org/netdev/net/c/d20909a0689f
  - [v2,net,6/9] net: llc: fix kernel-doc notation warnings
    https://git.kernel.org/netdev/net/c/201a08830d8c
  - [v2,net,7/9] net: NSH: fix kernel-doc notation warning
    https://git.kernel.org/netdev/net/c/d1533d726aa1
  - [v2,net,8/9] pie: fix kernel-doc notation warning
    https://git.kernel.org/netdev/net/c/d1cca974548d
  - [v2,net,9/9] rsi: remove kernel-doc comment marker
    https://git.kernel.org/netdev/net/c/04be3c95da82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



