Return-Path: <netdev+bounces-26543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7E67780C2
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F51281262
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F75F22EFA;
	Thu, 10 Aug 2023 18:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76D1F95D
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12CF7C433C9;
	Thu, 10 Aug 2023 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691693422;
	bh=SgbQKPSrQjPetGpVTNEWgg6M+ml5nVmTAAna2QG1xJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UuDvc8Eqq81qBrEZvyjPXtQV6SMIoWgTeluevRIBFhcBHJgp+UD8oECxjoPW3SJ0e
	 iH23r/0UZSN7G1f8SNTThm6g6Ao7m2bPUc9j2GNG4WJhujvUBAd8Jn5J2MTfGkrxRL
	 mqHMUNrA8nFzzRdL/aNQXUo2d0l9oRYXi5bPHBgUfrVfCHgKyyQ+AAHiBAfpqzhTKL
	 OkSpg6LkU6vWXWh4huYMIq06aQCCmhy7Zc51e/AePXutL9mBOfFRTB+5oPpJCRijVi
	 nDegtxtc3mv7+Nj2j13hbLceXZ5GN42G/YhF/ahIfJsw3krhyZRwqzBM3+nrG6irC3
	 bDty2LABgdxqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB099C595C2;
	Thu, 10 Aug 2023 18:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: tls: set MSG_SPLICE_PAGES consistently
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169169342195.7825.6502924229390560914.git-patchwork-notify@kernel.org>
Date: Thu, 10 Aug 2023 18:50:21 +0000
References: <20230808180917.1243540-1-kuba@kernel.org>
In-Reply-To: <20230808180917.1243540-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, tariqt@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, dhowells@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Aug 2023 11:09:17 -0700 you wrote:
> We used to change the flags for the last segment, because
> non-last segments had the MSG_SENDPAGE_NOTLAST flag set.
> That flag is no longer a thing so remove the setting.
> 
> Since flags most likely don't have MSG_SPLICE_PAGES set
> this avoids passing parts of the sg as splice and parts
> as non-splice. Before commit under Fixes we'd have called
> tcp_sendpage() which would add the MSG_SPLICE_PAGES.
> 
> [...]

Here is the summary with links:
  - [net] net: tls: set MSG_SPLICE_PAGES consistently
    https://git.kernel.org/netdev/net/c/6b486676b41c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



