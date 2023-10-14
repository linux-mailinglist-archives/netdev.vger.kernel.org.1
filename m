Return-Path: <netdev+bounces-40920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7BB7C91CA
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD0E282E9D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71BEA9;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE+TyKGg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8D111B
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E119C433CB;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697243427;
	bh=kka4h5H6MNoNDRLvZIC1Gs2lNLdFOAwO3RtrAL3a8lg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WE+TyKGgGB1r8et4pkPqs+rM1gLWU+f8C9sGVBtexXaRWyrJOF4WVwjzXmYxqVoV/
	 dEY7OzCAoxG2G7r0tyY+0farWRBSQw4rr7SGEP1kSnm3e+rq94UgeH754afyPV861Z
	 XlnBSYIODE3Bg0nvuOl7brRg7HGP39+fZ1jghE3iuSB666iMkM8jR2jvPuIrPGJcrq
	 7p1Iqo/rb76dDMy4/1RPjQmXiBRhNXWEVJQE3s+tuMR8aov6rIxL6HnKK0KUZ42Siq
	 3XEMRPQ1n64hLaQagH/M9dA1nVqwEK+9uiMqzeZb0Xj7T67WsiFYfy7BjjmMWLwFTd
	 XHFMU7Dtz1igw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04A02E1F66C;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/4] net: netconsole: configfs entries for boot
 target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724342701.24435.1025905471461735213.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:30:27 +0000
References: <20231012111401.333798-1-leitao@debian.org>
In-Reply-To: <20231012111401.333798-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: jlbec@evilplan.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, hch@lst.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 04:13:57 -0700 you wrote:
> There is a limitation in netconsole, where it is impossible to
> disable or modify the target created from the command line parameter.
> (netconsole=...).
> 
> "netconsole" cmdline parameter sets the remote IP, and if the remote IP
> changes, the machine needs to be rebooted (with the new remote IP set in
> the command line parameter).
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] netconsole: move init/cleanup functions lower
    https://git.kernel.org/netdev/net-next/c/28856ab2c0b5
  - [net-next,v4,2/4] netconsole: Initialize configfs_item for default targets
    https://git.kernel.org/netdev/net-next/c/131eeb45b961
  - [net-next,v4,3/4] netconsole: Attach cmdline target to dynamic target
    https://git.kernel.org/netdev/net-next/c/5fbd6cdbe304
  - [net-next,v4,4/4] Documentation: netconsole: add support for cmdline targets
    https://git.kernel.org/netdev/net-next/c/7eeb84d89f2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



