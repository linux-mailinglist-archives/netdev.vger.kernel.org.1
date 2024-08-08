Return-Path: <netdev+bounces-116674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0295694B57E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC931F2344A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D803084A36;
	Thu,  8 Aug 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsICr60b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7A433AD
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087836; cv=none; b=de1V9JujKcKMrNAJjbxymm49hHDAlURtML2JHr4ETcLGmUXnPJJHgztVKrsnpoBzxr0HKpEH8+VVHJezC4zlBrKhZ8GluVrCZjtyec6LbqjR9jjTBv2oXh6rGc/QKQrrM0hump28ggH3gBCl2sCeQ5tRSNphWhwpU9PLaecAh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087836; c=relaxed/simple;
	bh=w6b6zj96JTohOJTw5ySF/+yVNWjNk0paH8weAUoKDwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uasWyx5Emlk1h9rq4zw+TL79rUcTdroDhzeliYLcXmvyvouC1VtPC79KmeofQnhbtpsBk7p711J/xifQ8yt53h/j/fexApW+3hlpaAnbKEnV2JYtObsI1qa8lMW2oQfGk3JHDhbIQkWOfGNMp9dQUCQwc8DjlXTNdw8ntsK0RyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsICr60b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C08C4AF0E;
	Thu,  8 Aug 2024 03:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723087836;
	bh=w6b6zj96JTohOJTw5ySF/+yVNWjNk0paH8weAUoKDwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dsICr60bDtwXM4DewljjpcWCZGmqZoFqmzOT/HH86/QCOfeUE1FKnV0/33EPDZxC0
	 OOrQKYyyfc0OY9IrD5GKkYA9be+TFacdQfK1vdtgNrdGtEYjUaHpXbxC3Hbyf77Q4x
	 Leorr2rM8Ny3WMi3YDxStXAqYfo4V2Po2z9+lFpYR+U9Jc6lxt5dzVC1706X5tm6IQ
	 okERTAKpYwPn1khs/DLGDXqRSr26rKzGTXIcrNST5EDYF2W7A0zZq+egfoBdbeTS65
	 aLi/y18iFUGkORaa1kgU6Psj1x89kSJnjJ+t5W95YcXaaL4+eRgOJ1SnVOZ9RGW+bR
	 7Y24Ge/jTC/vw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7A3822D3B;
	Thu,  8 Aug 2024 03:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] idpf: fix 3 bugs revealed by the
 Chapter I
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172308783476.2759733.5507049121584040955.git-patchwork-notify@kernel.org>
Date: Thu, 08 Aug 2024 03:30:34 +0000
References: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240806220923.3359860-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Aug 2024 15:09:19 -0700 you wrote:
> Alexander Lobakin says:
> 
> The libeth conversion revealed 2 serious issues which lead to sporadic
> crashes or WARNs under certain configurations. Additional one was found
> while debugging these two with kmemleak.
> This one is targeted stable, the rest can be backported manually later
> if needed. They can be reproduced only after the conversion is applied
> anyway.
> 
> [...]

Here is the summary with links:
  - [net,1/3] idpf: fix memory leaks and crashes while performing a soft reset
    https://git.kernel.org/netdev/net/c/f01032a2ca09
  - [net,2/3] idpf: fix memleak in vport interrupt configuration
    https://git.kernel.org/netdev/net/c/3cc88e8405b8
  - [net,3/3] idpf: fix UAFs when destroying the queues
    https://git.kernel.org/netdev/net/c/290f1c033281

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



