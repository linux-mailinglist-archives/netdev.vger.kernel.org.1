Return-Path: <netdev+bounces-38161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DA07B9951
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 247C5281BF8
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27076374;
	Thu,  5 Oct 2023 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uizppYc/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7315B3
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F79AC433BB;
	Thu,  5 Oct 2023 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696466429;
	bh=NXj0/Ij5mpIkBtaK6qBmSU6/DoYCDC5cAiBsbcOXbjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uizppYc/KkxSBC0ahaZ54ngGJUCaAGNB8gFlG1d5smmApEZDzsmAwVDRZ2ML6mjre
	 LM0tupaug+BuW78FLoZfxc+WfaTw/a1PKyQCQe4gbFQSoAW3uhS7GiStSuFU88ByeW
	 mRTl2RGlUTSxs7L3z02K0AjQWNassiDeR3twJOHdrzl/dl1pHkrGasliFJO8M4g/0+
	 ZsAlAqB9ULcqrbldtNYLCSLntZnAgaO4z5YAVH4baFsqV+5itpFLJPsy4huvTVmOyz
	 Qy8m4i2gzvQxANalAnCQ5jCvzpg3Q8MCbRYiRdwaqdmir0qbccQrDa/gf8QT9ZJG6J
	 4G1w4UEvzn4Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AB3CC595D2;
	Thu,  5 Oct 2023 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: skb_queue_purge_reason() optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169646642949.7507.4267028951269859935.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 00:40:29 +0000
References: <20231003181920.3280453-1-edumazet@google.com>
In-Reply-To: <20231003181920.3280453-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Oct 2023 18:19:20 +0000 you wrote:
> 1) Exit early if the list is empty.
> 
> 2) splice the list into a local list,
>    so that we block hard irqs only once.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: skb_queue_purge_reason() optimizations
    https://git.kernel.org/netdev/net-next/c/d86e5fbd4c96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



