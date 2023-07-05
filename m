Return-Path: <netdev+bounces-15499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E327B74816E
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4D81C20AD5
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 09:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC04C8A;
	Wed,  5 Jul 2023 09:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632C4A2C
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 09:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 356D6C433C8;
	Wed,  5 Jul 2023 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688550621;
	bh=aBZJ37AQ3B6gDkew2/GdvBukbROjBz5nfjoFvF/MOF0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rxoflrXlIT3aLpjSc37URPSqzNseuT8ivjTqIdxqNUw1WBK2WiyWYrNWsQNLPBTrb
	 ra0voMvkwJ5oZOPLwyJPE7LNGrxazGJfWVM3ZO4Ii4ozcVmpLCPfxqi/JVIUsxiAQq
	 4qgYRdCZVOHFFBDVPWUXgGC6gewl+y8HZ8QS4qYO+qZXVYBJ18uIHIlyvzII9A9GPX
	 5ENQBiygkPSEswqDYjbMj+cw+eYl4myewikjdRm5dZ/T/a53Ee62vzQGKOpfVdKLg0
	 fkPbIZq5oafSIG2HlUEqY/MBuv4hNchHhzvloP1Tde1Zbe1CtbMU9Fy61iOaeuQZiJ
	 u9v4c6ah5o8gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 109B8C561EE;
	Wed,  5 Jul 2023 09:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] s390/qeth: Fix vipa deletion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168855062106.9766.9208321463101789168.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jul 2023 09:50:21 +0000
References: <20230704144121.3737032-1-wintera@linux.ibm.com>
In-Reply-To: <20230704144121.3737032-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com, twinkler@linux.ibm.com, wenjia@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  4 Jul 2023 16:41:21 +0200 you wrote:
> From: Thorsten Winkler <twinkler@linux.ibm.com>
> 
> Change boolean parameter of function "qeth_l3_vipa_store" inside the
> "qeth_l3_dev_vipa_del4_store" function from "true" to "false" because
> "true" is used for adding a virtual ip address and "false" for deleting.
> 
> Fixes: 2390166a6b45 ("s390/qeth: clean up L3 sysfs code")
> 
> [...]

Here is the summary with links:
  - [net] s390/qeth: Fix vipa deletion
    https://git.kernel.org/netdev/net/c/80de809bd35e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



