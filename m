Return-Path: <netdev+bounces-137001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E21289A3E93
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8844C1F23E64
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B861DA5F;
	Fri, 18 Oct 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0inOsjQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD48F6B;
	Fri, 18 Oct 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255223; cv=none; b=t5sBwGoEYVirkSPBaz15Xuhmp4q/OTzSbWSMenEyh9VpgU/aq4cjOK47UXvpaJmSDyfkQVq4YWgjZBKHyGDsfbw0Ss60R0Rew3GdEVlfCd/SgShTwGXXOAKnZKoH5hLQMjoWaIx2sU4HfOX8B7gXpu9RKOJXl0oHYI/06ihFuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255223; c=relaxed/simple;
	bh=XEtHxWtfVx3+c9ocdCmjPvz4RrKrjsucU558+MpnOmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r1rAb8YOK9Pza3xTYL14BRBaboZwfb0yWjE2F+MBakwUYEE7MYBUO8UPQ9Vu7ETeXc6rkpAwrW97inUUWAhb5kFdVQ2s1K+0EaLGOScLpKIc3EkSocrOMpqJt86jmD8tc2ZVMipc9ruOA7ugbiPE/JRKdia249pp9quGjFUcs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0inOsjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8626C4CEC3;
	Fri, 18 Oct 2024 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729255222;
	bh=XEtHxWtfVx3+c9ocdCmjPvz4RrKrjsucU558+MpnOmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p0inOsjQynB4xOZ9L6YdybP3T2oF4aml/DyTn9P9Vbu1Ocy17Q+hglClKPgLEXxmD
	 TrEYBITsfeui83IDK6p8lSIWfgilrbPPCGbb1+pXbDWOjPomAegR7EXhXtsS1+tOgU
	 ALsT96STamIH1ghxMC5vWMQxNTxGVpKLPP9hCKOXZ24KbqI3Psmz/HKRiUq5j2FXp9
	 u2dAJ4zWWTdZyUO1gKB9VWG/Aq4KVcn0QKf1G7CQKT49mPTufYoUUPZ5Pe5jTdCUOJ
	 OmSw2lATee4WnKujJxR+WO/hjF9MtDOuEcMRHuzqSCbHsgAORZsg+Z7udaTCsinYTc
	 rxl+kIG2+aSog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1A3805CC0;
	Fri, 18 Oct 2024 12:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: vxlan: update the document for vxlan_snoop()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172925522851.3104765.18098378497865018106.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 12:40:28 +0000
References: <20241015090244.36697-1-dongml2@chinatelecom.cn>
In-Reply-To: <20241015090244.36697-1-dongml2@chinatelecom.cn>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dongml2@chinatelecom.cn, gnault@redhat.com, aleksander.lobakin@intel.com,
 b.galvani@gmail.com, alce@lafranque.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Oct 2024 17:02:44 +0800 you wrote:
> The function vxlan_snoop() returns drop reasons now, so update the
> document of it too.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  drivers/net/vxlan/vxlan_core.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: vxlan: update the document for vxlan_snoop()
    https://git.kernel.org/netdev/net-next/c/160a810b2a85

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



