Return-Path: <netdev+bounces-134329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1406D998CE9
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABADCB2990B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3C61CDFC3;
	Thu, 10 Oct 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adH927+b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106DB1CDFC2;
	Thu, 10 Oct 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576632; cv=none; b=ZlRrFtJvTgRwgqeY4TeTRE13Y7AMeOJmVq6+x8HgFgFRX+0N56HFhxYvK3IF8HPssE/oRbN0Hhlzl6F/1ykNOuaqZCHzaxjeD+PG+AKJvJewmpsZ1dUxBognMlQ27MWpVAd+cEwLlBoR39NFOIWcERGFvC7OlM7ksm1RG4sGsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576632; c=relaxed/simple;
	bh=uQm+WZq0kH+rlnxfvHfkn4jKpR8cUV7xWscv3PVh85I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oLXq+seb8g1mIm20FotI0TAzHb9RGJWhfCCGkvLwI+4+7R68NavK4hzosV2ew3LwL5sshs4s0bbU4mEGerDhwlrOQJAnWEsWG1i2OjctOdTEOO9LsX00x9kugJM/rPmqG8j86oAT3x9STFxo/2JuV0VHjCh/JUsb4zIT5f4lEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adH927+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ADAC4CECE;
	Thu, 10 Oct 2024 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576631;
	bh=uQm+WZq0kH+rlnxfvHfkn4jKpR8cUV7xWscv3PVh85I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=adH927+blgDzPzV/zy0fvtrNkUMCXocTbr29w2q4bFnwPdaxWuoazUXR3PClvYpWh
	 3zHwkwU1NcN6HBF45fwvZeVfZWPRFbc6Eq5ozARN9oaYJsrDoSHfGnH74EPla1Xg6A
	 6VE4kAEPV+dInQOg5ADHbDS/JgNTOP2DfNiMNXFLsF1lFHZwvPX2FxDCijTVt24Puz
	 Ahj1VGIN7XsqaE89/g3u0QAN3wlXFIG7e4Ciz3wD0/cifRhiUgVpuFk4ELcK0V8vhz
	 AGkfn4v0zjjIPhDNbP3XzAQqr9Q0VRnmTnDIrqwHAlX24gBXx67uMme4IxZ0KfG4T3
	 O2tKQXuQRCh8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3482E3803263;
	Thu, 10 Oct 2024 16:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] docs: netdev: document guidance on cleanup patches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172857663575.2081951.7702587935908581266.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 16:10:35 +0000
References: <20241009-doc-mc-clean-v2-1-e637b665fa81@kernel.org>
In-Reply-To: <20241009-doc-mc-clean-v2-1-e637b665fa81@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 09 Oct 2024 10:12:19 +0100 you wrote:
> The purpose of this section is to document what is the current practice
> regarding clean-up patches which address checkpatch warnings and similar
> problems. I feel there is a value in having this documented so others
> can easily refer to it.
> 
> Clearly this topic is subjective. And to some extent the current
> practice discourages a wider range of patches than is described here.
> But I feel it is best to start somewhere, with the most well established
> part of the current practice.
> 
> [...]

Here is the summary with links:
  - [net,v2] docs: netdev: document guidance on cleanup patches
    https://git.kernel.org/netdev/net/c/aeb218d900e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



