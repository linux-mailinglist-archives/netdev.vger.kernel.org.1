Return-Path: <netdev+bounces-50609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB17F649F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 18:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D904B20F64
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6643FB3C;
	Thu, 23 Nov 2023 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ//dAo6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30F3FB34
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1B6DC433AB;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700758826;
	bh=+z6/eVRwuP0i1C6Vym1xVA4ih4xKRmmNUGp6cW2wKx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lQ//dAo6RKbjO5Gq2cJmLVHyi1FB5gGVH+08lzogFghPdavzHiCWnX/e55hMqD8ZZ
	 4esvgT9XvlVZDiTVchljY8eV8+Wkrvrf1NyY47qjgn504iqqzeneOuClecmNPjIgSQ
	 UF/toLW3HafhhJCD7jDQy78e1aO47/UXta8D3yz3N0c5ilv7rrpn7oxFjLYa7OPScR
	 FC7kfvZ7xqwt7SfhohLxaKaGSzKpPJjOO+DQ3UwpoovpO5gXo8ZjktLNdLzrL73+/K
	 /9qZAk1F5pisGdW/wuDw5vAOH4dzefnfE5qEjX3jLJAFtqJ5CyMXnCQgKmgAAqEIlF
	 kh7tjSwyIbrBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A232E270D6;
	Thu, 23 Nov 2023 17:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: fix duplicate op name in devlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170075882656.541.1010663520254747201.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 17:00:26 +0000
References: <20231123030558.1611831-1-kuba@kernel.org>
In-Reply-To: <20231123030558.1611831-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Nov 2023 19:05:58 -0800 you wrote:
> We don't support CRUD-inspired message types in YNL too well.
> One aspect that currently trips us up is the fact that single
> message ID can be used in multiple commands (as the response).
> This leads to duplicate entries in the id-to-string tables:
> 
> devlink-user.c:19:34: warning: initialized field overwritten [-Woverride-init]
>    19 |         [DEVLINK_CMD_PORT_NEW] = "port-new",
>       |                                  ^~~~~~~~~~
> devlink-user.c:19:34: note: (near initialization for ‘devlink_op_strmap[7]’)
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: fix duplicate op name in devlink
    https://git.kernel.org/netdev/net/c/39f04b1406b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



