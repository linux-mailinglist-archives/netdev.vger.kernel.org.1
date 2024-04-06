Return-Path: <netdev+bounces-85439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD289AC12
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 18:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8761C209B4
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312973C470;
	Sat,  6 Apr 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQReiQui"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B76C1A716
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421627; cv=none; b=XRw+Dt4CcWFkaMp2VY2JH7DtX/U7CAERCU+AMLYB3qhRYIWkRotmpvdu5IpZhd3O/wVreYJuSgsAwOU+Byc5jDA1DJaGKfki/eKW9GbQgaLG2Nn3Hs/lum7LLR+RfZmnOIcbMUMdGrYX3nYhqjcA6hnHWXEMw67O6DPOfmgN0Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421627; c=relaxed/simple;
	bh=ZsisEtLSo5Cn64iP/+Ruz4EKL9M5Iqm4Jw1zCwgRdJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nmS1rxvay9jCiqyZwqHNbUf3Eh1AlAhZf/z5GlyTnCLCe/98882ru///vY9Rj1FYw3nDVDHAx8TXSbQrL5IinKsQy9wWkvnN5xrNo9RCj3x4caQFg6oz8a7Hlq+MIMz2WFu+OjmgvCVRoSilMkkKrqtMsNNqKr7p96WdSX3YYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQReiQui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77079C43390;
	Sat,  6 Apr 2024 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712421626;
	bh=ZsisEtLSo5Cn64iP/+Ruz4EKL9M5Iqm4Jw1zCwgRdJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KQReiQui9lJ/NxEeTsE2xdxgVg+f1xvqiwvirQMd+wFqgPZYf0k9Lo7Ym20B16sOx
	 NbC+EZAaHh5CiHSj//pDjpK8+e4Aa83CVHXj3L5gKOFMJ5Zn6K8Xsv7iX1hbQnUV4o
	 oklhr9oVgAhSEABOMvj6BbPTBJ5Rx2BDyK8/JmV4efo8dWUlU7pRfjIhUoY743p+Jw
	 K+H6BS30dpSRFQo4YfLjazL7hY1V0Vs4WU6lBNFzy9DDlorBx2sVv1OjGiMl79D32Y
	 jzrW6hNLEs6lu0PmcrItSeUPb5h8bPnHyqfuKd2retiirRICpyCMVsaaCqFQJ2Jss9
	 yAmLCRfAM7cUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67052D8A104;
	Sat,  6 Apr 2024 16:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: skbuff: generalize the skb->decrypted bit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171242162641.12553.9789629674269759591.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 16:40:26 +0000
References: <20240403202139.1978143-1-kuba@kernel.org>
In-Reply-To: <20240403202139.1978143-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Apr 2024 13:21:39 -0700 you wrote:
> The ->decrypted bit can be reused for other crypto protocols.
> Remove the direct dependency on TLS, add helpers to clean up
> the ifdefs leaking out everywhere.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> I'm going to post PSP support.. as soon as the test groundwork
> is in place. I think this stands on its own as a cleanup.
> 
> [...]

Here is the summary with links:
  - [net-next] net: skbuff: generalize the skb->decrypted bit
    https://git.kernel.org/netdev/net-next/c/9f06f87fef68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



