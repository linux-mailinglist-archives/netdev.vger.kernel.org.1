Return-Path: <netdev+bounces-68144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E5845E83
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FBD1C23F1B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F2263CB6;
	Thu,  1 Feb 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c43yjBkt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6270963CB2
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808626; cv=none; b=WDGDCEwm6vXAOWUVpU0COz253MDZWmV4H3DH9xnEgTFxYmhJrQoCgDtycDbjHL+t1YNduy4ISQDi7brEPBqQeaS2ofM2k0vp7pE/NujsjfA9vYx3AqC8JvhmZFO88v/bx7ASVHZljtGETUCKd0cJu7CKFdFl/pDoF/fYipjwgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808626; c=relaxed/simple;
	bh=1i6WAhkDxKGuNFhsGfpm2wndjgKWAFSt2MEJvtJ1QQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j+vvpcCEtWMvcxbNcrRTQriIQ7nN5ha27kbA39X5utgxpom/Mn2OVcE/+oZBpEkdHfv5bhvMvrUv2L7IvAPBtx3H9yf2A5RNXABqex/gwHtYoTPy2Sm9tP3BFWX3riyZ3FVhazCLjGMFv8nMkGu/SqknHXYU8P6p03xeLunaZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c43yjBkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8F86C433C7;
	Thu,  1 Feb 2024 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808625;
	bh=1i6WAhkDxKGuNFhsGfpm2wndjgKWAFSt2MEJvtJ1QQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c43yjBktMDubV74Kda6FDWc/eKTboXFtGk00zNxblRoVOP+E4fXDtuvp4G2zXSvxy
	 e0UTvYwNhwf5MnElSwK9sNIWMZkkVpvVdXjBciiOWxySbT7Zcr480JlTG3IPTCk4Nk
	 BqFHXbuZ2qfPQtiSV3YCWeN6pGiqZ2LzWf//qVy0I8ttcGNPFi9LElP1v77wpDQQc+
	 w4QHlhcrsOTS3qbrEolM9EV6912S5ZYZ3GWDRY4IJ6oYIGBCNPzfntPXrw2UUwewvh
	 v9pLP3gxtQ4uoQVfFXQ7g0wbknyYvVgvtiM4MtC5pTbWXB8bduPnKBdZDEyElvNVWm
	 IUIIKWfrPfCaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB384D8C97B;
	Thu,  1 Feb 2024 17:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] doc/netlink/specs: Add missing attr in rt_link spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170680862576.30194.5588496519529828611.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 17:30:25 +0000
References: <20240201113853.37432-1-donald.hunter@gmail.com>
In-Reply-To: <20240201113853.37432-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Feb 2024 11:38:53 +0000 you wrote:
> IFLA_DPLL_PIN was added to rt_link messages but not to the spec, which
> breaks ynl. Add the missing definitions to the rt_link ynl spec.
> 
> Fixes: 5f1842692880 ("netdev: expose DPLL pin handle for netdevice")
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/netlink/specs/rt_link.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Here is the summary with links:
  - [net,v1] doc/netlink/specs: Add missing attr in rt_link spec
    https://git.kernel.org/netdev/net/c/069a6ed2992d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



