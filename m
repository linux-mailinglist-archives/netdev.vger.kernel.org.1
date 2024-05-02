Return-Path: <netdev+bounces-92878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAEE8B9356
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371421F2319D
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13D617588;
	Thu,  2 May 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGBjl4ye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0714F98
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616430; cv=none; b=GmcWdQOKFER7TDNk4hIYL6yjoFkqwL7hkUVljJHZdJta1SWyzRIaUM+BouoLw6/y2t2CYmVr1sCyIo2VYcF/K1mL6qHpAO47+An9yL2dvTpZRCBmU5yCwTFW1z+Fv3rMzHFHfhVc8JjFFadxTKHEJcxPFDO+ftLfR6KwkT6NelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616430; c=relaxed/simple;
	bh=bQsNib7b1il8Uvh6T8kDnibvNmiO8v5h1bwhYgixQe0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dOx1fglSRYNr6LQAu34ItMB7gdDxaBfDhLOCM7IO7Oxsi98TPFimlZYNMkCOZY6kRLLU/AmAr79hbtbeH0jWeyvJURvtUE1+M3CpfrguH1P0ereY2JqTIDocEYLae5XDn6ueNxbaGuY+TCNfDNeAGWlMXgAB8h0ygFEk1meEVY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGBjl4ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DE25C4AF14;
	Thu,  2 May 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714616430;
	bh=bQsNib7b1il8Uvh6T8kDnibvNmiO8v5h1bwhYgixQe0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SGBjl4ye2y0qbsKHeha5SGo1xu8Rm6TIr6mNxOA9RXY239l9M0+3eH3KNGU4MxWsl
	 si/K9gcqr1w6Ca4JBXx7fZP+aq1xYalKTOnutHaQ5UlXbRKmF7RBnH3khwDys+OYTu
	 jgbpUH5Vy0+V3bkzgk9z+bYoQdqfVG8eNkGBwIY3Spnj53dMOc42tBt4XEyXs1iZzm
	 b2XwBWucrvNB2Gq/PMS1qm+RE5562zkW6z4E/QebakCHu8yIVZw2VDlZGehZAm/xQ+
	 +KtMN/0uvQZ6GO/E3FjGkfIvwpZaWEB4sZOrpQvEipqnBeHLuv26w9QQfQjVSn+4gH
	 ceSXkL11XeOtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37511C43440;
	Thu,  2 May 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: Pull inner IP header in vxlan_rcv().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171461643022.4262.5806307113681628833.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 02:20:30 +0000
References: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
In-Reply-To: <1239c8db54efec341dd6455c77e0380f58923a3c.1714495737.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, petrm@nvidia.com, razor@blackwall.org, jbenc@redhat.com,
 leitao@debian.org, stephen@networkplumber.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 18:50:13 +0200 you wrote:
> Ensure the inner IP header is part of skb's linear data before reading
> its ECN bits. Otherwise we might read garbage.
> One symptom is the system erroneously logging errors like
> "vxlan: non-ECT from xxx.xxx.xxx.xxx with TOS=xxxx".
> 
> Similar bugs have been fixed in geneve, ip_tunnel and ip6_tunnel (see
> commit 1ca1ba465e55 ("geneve: make sure to pull inner header in
> geneve_rx()") for example). So let's reuse the same code structure for
> consistency. Maybe we'll can add a common helper in the future.
> 
> [...]

Here is the summary with links:
  - [net] vxlan: Pull inner IP header in vxlan_rcv().
    https://git.kernel.org/netdev/net/c/f7789419137b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



