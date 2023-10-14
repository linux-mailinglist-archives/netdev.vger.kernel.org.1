Return-Path: <netdev+bounces-40904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1ED7C9198
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303C31C209B5
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224D12B6E;
	Sat, 14 Oct 2023 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG114B4s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1698F15CD
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D242FC433C9;
	Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697241624;
	bh=kFo4c/EbqDXaAr5wdmeC7WwZTm8WTWty3Y/b3N8NZD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UG114B4sZrEZ2OUbZYts2ro3NdyB4vqpl5ptb+hhFuI6Gity1Tq8t+Y+9LOjscyA3
	 YKd7GiDoUbFs0OoeGHp1LG8c/29QRz+Idv4Z7xHTVtN/heP9/XUMVvbxkzuS4ggjVr
	 7iJintb015NXJ1usn8B/bmAShgMcMJUjZh8Z+u8FBDZZqkxi+SZBDA0WHKchZMk5AW
	 As3HVELAkVPCMJW8XVza2FYSCWZ2WwpUqW6twNO8rZBEIOwmhgSvP4kbbOI+p7SEOA
	 4geo7K5z/oOt9dwCI9YSQtoMScvSu82AYWgcAYYXyVOiycV447BcjHS1Jam6nB1s2Q
	 LjleikjqTBpkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B90C3E1F666;
	Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net/smc: fix smc clc failed issue when netdevice not
 in init_net
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724162475.10042.8870358455598573591.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:00:24 +0000
References: <20231011074851.95280-1-huangjie.albert@bytedance.com>
In-Reply-To: <20231011074851.95280-1-huangjie.albert@bytedance.com>
To: Albert Huang <huangjie.albert@bytedance.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, alibuda@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 15:48:51 +0800 you wrote:
> If the netdevice is within a container and communicates externally
> through network technologies such as VxLAN, we won't be able to find
> routing information in the init_net namespace. To address this issue,
> we need to add a struct net parameter to the smc_ib_find_route function.
> This allow us to locate the routing information within the corresponding
> net namespace, ensuring the correct completion of the SMC CLC interaction.
> 
> [...]

Here is the summary with links:
  - [v2,net] net/smc: fix smc clc failed issue when netdevice not in init_net
    https://git.kernel.org/netdev/net/c/c68681ae46ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



