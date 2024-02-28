Return-Path: <netdev+bounces-75661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 791EA86AD9F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1607DB23AD9
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D69149E0B;
	Wed, 28 Feb 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwZVp9qP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55102149DFE
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119832; cv=none; b=asyw7jN0nj6pfeyG3lniOvyw6PSjYljHipIqLwpQPtcN1jRiyD/5fictNLqvI2ZC6GBbLgJjcOlrWpWo43eRjEIPw1tPGOEe8QZIasrWRh1umUBHzN4tl2smvHE9yon8jcCWSL5+0jwjjxy1W5CoW/nzDvC6F17L+IMzwdqHVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119832; c=relaxed/simple;
	bh=OpF8UmWKULJoSZ333ynG3cpb9bkH/1tztxiw9gsdrdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Eh9KMwcHAGeKBF3FNR+g1AVEbEoQDRIGfGKKpOR1SFN1WAmAbqzSQX/GX1XyEQRYsE/puN/l6dzQdihkiJvSuDN+3yCrI8eIkkjPcd5hzYslZ1GbXuBZ4oDMhl104Jod0EpIMtgKoadaKnrROxoLiAaVTCa7yNBKZkqwD27cO8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwZVp9qP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08D43C43394;
	Wed, 28 Feb 2024 11:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709119832;
	bh=OpF8UmWKULJoSZ333ynG3cpb9bkH/1tztxiw9gsdrdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RwZVp9qPwuzPUvZPpu9nuOWkNkWUpMhh2L/vs4ZRIrl4DJ3QgjTBmXfj99C10UTt2
	 kYZpahtZTgTFIBOYoQ+9MK4VfJAy1w5MJAKV+wEDI8Qt+6cgKg6gQ//OWIxFZXHHXW
	 hxyAVVQaSqTZUgpoJMrk91w9jgEd+5CAsisHL0ZqG2uo2LGXMM6etO0ZcnTaId7VfA
	 O0ajBb5TSdIwkUYV96pAZzkT/Jq403d/RYxPHK5avC/dar/GnLRHWrMPNzfU8JIpfV
	 8jT6gbeAUmCEIeZidHLC7am4uud0ylyLKum4XVBcrxYVXd71MAGPhcaauUPV7mi/Sm
	 /uqnbWFDn+HFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5505D990A7;
	Wed, 28 Feb 2024 11:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: hsr: Fix typo in the hsr_forward_do() function comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170911983193.5841.2530266350285900479.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 11:30:31 +0000
References: <20240226150954.3438229-1-lukma@denx.de>
In-Reply-To: <20240226150954.3438229-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: edumazet@google.com, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dan.carpenter@linaro.org, william.xuanziyang@huawei.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 26 Feb 2024 16:09:54 +0100 you wrote:
> Correct type in the hsr_forward_do() comment.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  net/hsr/hsr_forward.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: hsr: Fix typo in the hsr_forward_do() function comment
    https://git.kernel.org/netdev/net/c/995161edfdb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



