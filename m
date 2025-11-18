Return-Path: <netdev+bounces-239355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38771C672CA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9549B4E31D7
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99430217D;
	Tue, 18 Nov 2025 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSS/Tliw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369902FB0A1
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437244; cv=none; b=GrBJDtw6FhB+zfnrCOOyAs5y0me/CEFW5Ai5zlnQap4sJyUnynUldLqpNp2+X6tVa2IHDgnZOtld95Rfh65Zk7oSTgWrROktxM4hs5o0ZI/x3bS9RxBDBH/zftlnSpueOsnmvIoGlb980r1yPjYWNm4/zxpmoNeEILoWIne9qj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437244; c=relaxed/simple;
	bh=mfCcAqrGYlHJKVi7oUzOule3svWnNpqlOMZPW/3WFcA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o34Zk8TZSLkRsyYQ95RPdrsjul2/29kl7hhp5S+jyBI+pYFLn18XH2LNg2fesbvxaaz4VSeaoAIDCw2llM6PM058sLeLsznZmWJHetYUzQNTTvBkeRGHhUVJr+jsM7M+ELO7fZ/3vCueRVPYleMnIGnSvXe/Ps3rt7Rx3oNTnHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSS/Tliw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF792C19424;
	Tue, 18 Nov 2025 03:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763437243;
	bh=mfCcAqrGYlHJKVi7oUzOule3svWnNpqlOMZPW/3WFcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fSS/Tliwra5BSNyh9j/P5A+bwk9U0H9Oskpb5VLuZIEwFdV7xPUv0fWoID/gtKjn5
	 fNNNTSLEf2xCuGf81j2D1Olw3nNxskpyl6u8x7Ol9TnxaiGISdS9gYqvOFCFl/gYpN
	 miyhv8Y4rxhirObhMHXckiRCTmkSN6oYCbj6pwATjJYsdDQ17KaZHzWE541zOXq7RD
	 VRDZPqdIpe3nl2Z6HGOdC41tL3Nn8hF0anM83cRdIHV7KB026NnAXHUwY4V2BBn93j
	 J86NW7Wq+s1Wn3pJyWL4tHNcMznUOwg6ncA11x7o0nLftvXHoPEhEKADAwvEeq9TiH
	 rRj+dkbsf9nwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1F3809A1C;
	Tue, 18 Nov 2025 03:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] convert drivers to use ndo_hwtstamp
 callbacks
 part 4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176343720900.3573692.9310790169576673204.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 03:40:09 +0000
References: <20251116094610.3932005-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251116094610.3932005-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, horms@kernel.org, jacob.e.keller@intel.com,
 kory.maincent@bootlin.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Nov 2025 09:46:08 +0000 you wrote:
> This patchset is a subset of part 3 patchset to convert bnx2x and qede
> drviers to use ndo callbacks instead ioctl to configure and report time
> stamping. These drivers implemented only SIOCSHWTSTAMP command, but
> converted to also provide configuration back to users. Some logic is
> changed to avoid reporting configuration which is not in sync with the
> HW in case of error happened.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] bnx2x: convert to use ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/889e6af87734
  - [net-next,v5,2/2] qede: convert to use ndo_hwtstamp callbacks
    https://git.kernel.org/netdev/net-next/c/89ae72f21be3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



