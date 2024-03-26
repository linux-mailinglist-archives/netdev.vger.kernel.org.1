Return-Path: <netdev+bounces-82212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233BC88CA98
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DC032167F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CA21CAA0;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5vcnlwH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD71C69C
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473631; cv=none; b=bQ4632su/cxvLZJJtIuLEoCCyb76o/ADKVzp6quXFdp+AIw0h+TMPipVKLfv7tXHnmr8txY4hS9sGyx/7SuEgl0QuX2/ICfexd+VINa9CCk2Ck9y3fXsXLLd8KQMgQrHYg0p+yoAC5aoawR/vNupnYQo232d0kmEdRtaM0yIGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473631; c=relaxed/simple;
	bh=Y1zyvG4k5gdIwGVGPtgZesUY+MghHSuoXSfeukvLL7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fe237T78zgkC6TPbJR3DuyEXKEQwUf12XUIEWo59S/+UMfBzrY4C265V78vpmkfIVH3IIrQPtf/PeM2+q7bPEbP76pyKZmK7n5DwVfiqIlm0UVQL15SaZa2yKpB34UknoIZlUqDJgNZSAT4ycvmiJ60Y0qDLMiMBgk697xUw5GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5vcnlwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AF01C433C7;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473631;
	bh=Y1zyvG4k5gdIwGVGPtgZesUY+MghHSuoXSfeukvLL7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l5vcnlwHjhUMluWCQtqv2MBFU4CLdW8n9z8Zm489RiouzpGcueOI/VIWdAYmqkMcf
	 j0CHflVbNedXJHzZh36ADynBgJhq9QRRrS3uwo7OrgI4UyCYOsHLhvj2MqCXHNt367
	 RseF6jLrosQwBGM9dqMDy5jcrWK29331ZdnzAxnf4+fdKd5v1rDo5W54ZSTKO5yMwk
	 acnCCounCtUsrUFUQt+yMjKOelK4MaJKUla1AKqIhOfALTmrjoK7g+n+7MlD/7kren
	 FOAGMEzEhx1Qkew/Gf+tutDX+vrI9mzF+rKZfX6Y45UOJgThWEhNq3wtXIifDZJUiM
	 jGUGf1H5a74Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28AEFD2D0EC;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/2] bridge: vlan: add compressvlans manpage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171147363116.25319.1656578476839776586.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 17:20:31 +0000
References: <MAZP287MB05039AA2ECF8022DD501D4BCE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MAZP287MB05039AA2ECF8022DD501D4BCE4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, jiri@resnulli.us,
 netdev@vger.kernel.org, bridge@lists.linux-foundation.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 22 Mar 2024 20:39:21 +0800 you wrote:
> Hi maintainers
> 
> I followed Nikolay and Jiri's comment and updated the patch to v2.
> Please check it.
> 
> Date Huang (2):
>   bridge: vlan: fix compressvlans usage
>   bridge: vlan: add compressvlans manpage
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/2] bridge: vlan: fix compressvlans usage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=43b53968634e
  - [iproute2-next,v2,2/2] bridge: vlan: fix compressvlans usage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=9ccf8fa8d4d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



