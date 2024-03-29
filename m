Return-Path: <netdev+bounces-83241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D452891711
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1501F217E9
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4244669DF4;
	Fri, 29 Mar 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMD7mR8f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBFA17F0
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709429; cv=none; b=SVL5Fn1wqHwjR1jfS5t14d5RLCRjanvQFztqbsmBngVdfJv8hmKa6gSDBQVDuiCYms2SIgc4FTH85a4/TcT19Qz1a9FlMRlDcJtjDlU4nv+BT71Hvd2HRzTTyAI++4ensZPkQBeI5HRMP3STZP8GKVXh/BwRbgG7BBEGXdcFdR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709429; c=relaxed/simple;
	bh=Bo7qXjGBRmsZ5ynDqEqpzK0dVcJE2886eAKZ+Lb7BNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RdtrHlFOvjxTc0D5ptLr53WEq3M4sFC3YSBjK48my9dCS4ESZAKXOIGuFo+q8QE2kheBkUUMdojcWuUahC774MTQjBN6h44/OmxtmCjdw3CLfC8Dvops/vzD9H1xpW4tASDgElgf0LHoi/yDNvGM6I/bjWej0xxg+VwCwD7l6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMD7mR8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C290FC43330;
	Fri, 29 Mar 2024 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711709428;
	bh=Bo7qXjGBRmsZ5ynDqEqpzK0dVcJE2886eAKZ+Lb7BNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OMD7mR8fvfzR807A7i4Q5JLGpatjrHMhiwvBzVzf7ggnQnjwRYU38bQ0GSVQ8FPZf
	 q5NheOfddos2b+L6yblid0W7dCUwccI6H6gQ4e6AwNxHxBAD166gLX0g7xqFXdb+oB
	 BtvP+iUKq8VbuImiwfsTerVBtqY2/tWrVhIUfvS4ht9ACdPuIlaae+CyZ2Le6Zp1dt
	 pjlmRn9Y9bVLzhuyMLkapcRYA5xIOkxryFWuFvj3ELxRuADf5J1wE8bIONocMe6+Ys
	 Pswapwu1temVyUGsIkLIZUyW+BekuJMVqHUZrTL65ZDFq/NECouLxA6WkagM2BjIsN
	 SG16ISZzNOYdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8C23D84BBA;
	Fri, 29 Mar 2024 10:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: hellcreek: Convert to gettimex64()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171170942875.27059.4296607347854552454.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 10:50:28 +0000
References: <20240326-hellcreek_gettimex64-v1-1-66e26744e50c@linutronix.de>
In-Reply-To: <20240326-hellcreek_gettimex64-v1-1-66e26744e50c@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org, tglx@linutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 26 Mar 2024 12:16:36 +0100 you wrote:
> As of commit 916444df305e ("ptp: deprecate gettime64() in favor of
> gettimex64()") (new) PTP drivers should rather implement gettimex64().
> 
> In addition, this variant provides timestamps from the system clock. The
> readings have to be recorded right before and after reading the lowest bits
> of the PHC timestamp.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: hellcreek: Convert to gettimex64()
    https://git.kernel.org/netdev/net-next/c/385edf325efa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



