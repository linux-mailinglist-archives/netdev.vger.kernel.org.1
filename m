Return-Path: <netdev+bounces-85927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237EF89CE4D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 00:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8508FB212AB
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 22:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ABD149007;
	Mon,  8 Apr 2024 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbJfojfz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29012148854;
	Mon,  8 Apr 2024 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712614283; cv=none; b=WtxAAkq299LvakwtkWicOJbhMLQD86H32aMimrkQpbsO5dSQTQHKhusjI5fnVSuHiCfBcAV5mTZky/FNV4TjHwOHsPdti9iRzrDa+LAhSsM4cXaHXOzKjOS8va69fRGLUqbzIX0JNSDjVkEiSGdVNFRaCqfPg+lxlVyClcMjqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712614283; c=relaxed/simple;
	bh=M+7+KQVwhiqPNuvfHKPLnOm/SA4WqubKPW0axuhY5A0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V3FBMjypX4ZGA+k4vktV/mQo/pHtGwQ6sJJ9o06NR2wSen+ZJXdC99xpAX25ocQm7nusRsjclnfLv22J9z5t2K8OIIYcivzH6m3E/TlmjoiHx84ZwX4Uyb/qJrorX2UNvfKxdn6AWf6mddrsvdQDHkOso2kjBDr2hFEfu35Jc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbJfojfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD6CCC43394;
	Mon,  8 Apr 2024 22:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712614282;
	bh=M+7+KQVwhiqPNuvfHKPLnOm/SA4WqubKPW0axuhY5A0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PbJfojfzWlk/Qtq8DAhlSZtkTOIllt7oq5At11ltkRYvulTkWCu/r80zXL1y+8vRZ
	 tpMCTj1XNg8aDAWyFmrg6T8GTKvKB0SmEQ8kTRSD6rbi/K7QXIpz6zMGZC9jeTgmsX
	 qdhSup3dW5T0aTqAPClq/VkDCP7dd78cbPXuf+etbmLQqIRqYQaxwR+xq+nl9XediL
	 awznD7snyhkOh4Gll9Um7Fq3KFwW/V+eXvKiJy+ifww3Ll94/qvfFZtCDTWeWV6hzr
	 xkM3zaohpkyYT+rSVwmyUbVJeKm9IB/9inxPoA8kgmxF43isMH6+yrrJr5GLceeyFQ
	 2scbkglCqkHtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE566C54BD3;
	Mon,  8 Apr 2024 22:11:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-03-29
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171261428277.29448.7091180261233651072.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 22:11:22 +0000
References: <20240329140453.2016486-1-luiz.dentz@gmail.com>
In-Reply-To: <20240329140453.2016486-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 10:04:53 -0400 you wrote:
> The following changes since commit 0ba80d96585662299d4ea4624043759ce9015421:
> 
>   octeontx2-af: Fix issue with loading coalesced KPU profiles (2024-03-29 11:45:42 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-03-29
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-03-29
    https://git.kernel.org/bluetooth/bluetooth-next/c/365af7ace014

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



