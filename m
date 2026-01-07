Return-Path: <netdev+bounces-247555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F298ACFB9E9
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 344B8304AE5C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4B1225408;
	Wed,  7 Jan 2026 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw6B1qaU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC45224AF7
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750216; cv=none; b=mZEIebB3h2fW/H46CxMhEwDBMBhf+4ICd91dzAZPTylhqPDEI+RTece0xiAGjyIerXkm6xwZKThgWxAY3k7tX/q2YUgkIGUtKCBgfKHpGaTb0iKM/4F8ZUd+m12kF1u55SqgIMAF9dWEyBz8emG/FjpRgJX0hJDKfBOlQ9ioHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750216; c=relaxed/simple;
	bh=l69uPmhRnaxYY0DAkUZCeMjtW/s86vt5BeT+e1GMNRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=csMYMySsVe2eDHDtR2OnKvWIGKFYdewG0gv4lXRsrTVMTK6qN5fBYHq6o8RqyhLvIDve9I0vqbDa3vwrNupmADoNkCkSGhhdiCzQNDjocRbdPOxe7ees40JxVJOmruFvWAoThLXNyjLEosRw+mP8XabY2gZH1sAC/I2lgP8ONc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw6B1qaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1F5C16AAE;
	Wed,  7 Jan 2026 01:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767750215;
	bh=l69uPmhRnaxYY0DAkUZCeMjtW/s86vt5BeT+e1GMNRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cw6B1qaU8I+EsuVzCAX/Y/gjXzRIo/AiTYClH8n/QoCzT2lWweSZUK6fQMhhOxR1B
	 6Lv2OyJO/ltUJa1ahn68Ohrc7/hOwZjlI80WaQ0ZLKr5dBkFgr6fTSHSu7YmP5OEFW
	 JDdsLAYpZQWmSP5zSmOinWvy9bddA1m/8HNwAopZZNVv3ETMkOEIA7BHEsZDxcfsWW
	 TjKyirutIu6+1SaaldjPmWE5nRnB4SQxiRyfEPjZfB7c1d9ce3DWUAStTO1UG+ryZ1
	 zhDs7zePGaKEWI9Ab5VABThmbkSvKNvSCwEqia8MqGZZWiP04Ns50wda1Dq1kp/qq+
	 +9xQNYfVUhFww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786EB380CEF5;
	Wed,  7 Jan 2026 01:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tcp: clarify tcp_congestion_ops functions
 comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176775001302.2194089.4168880876984104559.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:40:13 +0000
References: <20260105115533.1151442-1-daniel.sedlak@cdn77.com>
In-Reply-To: <20260105115533.1151442-1-daniel.sedlak@cdn77.com>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 12:55:33 +0100 you wrote:
> The optional and required hints in the tcp_congestion_ops are information
> for the user of this interface to signalize its importance when
> implementing these functions.
> 
> However, cong_avoid comment incorrectly tells that it is required,
> in reality congestion control must provide one of either cong_avoid or
> cong_control.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tcp: clarify tcp_congestion_ops functions comments
    https://git.kernel.org/netdev/net-next/c/55ffb0b14a4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



