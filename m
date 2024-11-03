Return-Path: <netdev+bounces-141324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E549BA799
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CC3281655
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40361632FE;
	Sun,  3 Nov 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As33VAfX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36C733FE;
	Sun,  3 Nov 2024 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730661620; cv=none; b=NMOzPmG7fDNlLKAT54lIwwKNXNESOT4K7JQrTx1Ami8ZyUA47HmvPhCdIzFPzeW2+I8ryHB/sWjr8F/tI29Vk603PQuCOC3QHrMJFxzqUb0R8IT5if8Wwp71elTSd42bGZMeQaEcvP0HsuhancTzvWI92P7vobSIwVSRRJa/KWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730661620; c=relaxed/simple;
	bh=waGx64vs+IAoidTWJTCUNIPtmaaPjQjBd7GLLQGKnpk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nSe9Eni5VoCJI7puph/dbX+xfAFTI3B9b/d5r3C0kj8DMXV4QcDeWYzrOqEPJL0JohiimtbnmN9994O4+cb8xvpyHlicRdaZZI/y4RIG4RrmF6pzTGMSBINQlJs4K237LW+L1y+vfRNfqINzdm04bXwPqL4EB04I0nUnaa26WxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As33VAfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448E6C4CECD;
	Sun,  3 Nov 2024 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730661620;
	bh=waGx64vs+IAoidTWJTCUNIPtmaaPjQjBd7GLLQGKnpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=As33VAfXIrunoRjxD40LuaoFVz1Rdo+v2W2xbC95QFl+3VHLx1OIvOGe20OQT7+Sr
	 EbVYNiwkHJjkKu8JfJoZPXTuBCXUGsoiXSQYs94ceR4GD8rD0ST8ZZO2I6l3tOkjq8
	 AiS+2EtHL5LvlbjD0a7023SY2yp+CjaZNkV4Jb01XCYXf8mYrPJjsZGSv6F1fk59YD
	 ZHa+xYRS3CywUoXuVOsTfyg9MHqfRD6PM3E/YPOmpokZvMqDRotaNKYe2PQhrM0nOt
	 xyNMqRVtmmC1AlUc/9Qlto3YJJlAbSG7syN9ZQ4G2G0jpgA+h61bLyy0Euvw4RqKqI
	 LboPsTnrOZWOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00F38363C3;
	Sun,  3 Nov 2024 19:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net-next] net: bnxt: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173066162877.3236514.8725965158427304237.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 19:20:28 +0000
References: <20241029233229.9385-1-rosenp@gmail.com>
In-Reply-To: <20241029233229.9385-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 16:32:29 -0700 you wrote:
> Avoids having to use manual pointer manipulation.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  v3: move str variable down to keep reverse chrismas tree ordering
>  v2: use extra variable to avoid line length issues
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 115 ++++++++----------
>  1 file changed, 54 insertions(+), 61 deletions(-)

Here is the summary with links:
  - [PATCHv3,net-next] net: bnxt: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/9b4b2e02c1e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



