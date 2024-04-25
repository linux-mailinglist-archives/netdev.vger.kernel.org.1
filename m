Return-Path: <netdev+bounces-91381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8128B2643
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78315B22B22
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12314BF9B;
	Thu, 25 Apr 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6ndcdWM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C444714BF8D;
	Thu, 25 Apr 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062129; cv=none; b=kHNS09lien1WFYrEexYO9EChZCiQadf6rXODu9pHjw0upKX9Hr21tuRTx07aFCSc1jt9/PlQoaxt6dLKFAOX0OZOnVxePRf6CSMZ8XOHlbkgpdGIcOQZwlJwyvrH8Z5bgG8yKinEUGdwTkKr/vWD+r27TzvyXsSsKE6NlyAENx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062129; c=relaxed/simple;
	bh=X4cjljSj2oP4HKzuQcIM+oLzC0lzyqL4NgM6FzS7d0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UkqK2n43GqqmP3M8SdNeyJ/XzIihyWU6tAGS9NawqzBoPBIt95/+g9Z9yfKwe4RAvpnsMbUnIQT+1tZPN7LChqNV/2wAMM/IZuSopjHijtjsqLBw1FswUg5xDb7Fx98RkhjIMe14eJhq2pogsPtgNfxz6d7e5zDZrF6ciHod1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6ndcdWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44789C113CC;
	Thu, 25 Apr 2024 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714062129;
	bh=X4cjljSj2oP4HKzuQcIM+oLzC0lzyqL4NgM6FzS7d0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A6ndcdWMb7lmg7yJQmeFcZxgAWQBBKKp0nP5RMaGW2zofQXvekurrF6AXb4KAs0+m
	 eb0Zh8iGVAkJwFtf3/rb12X8ysbqfDu4DTIR2rMsu40ZRAKxYbtBbdpGv+fqZccCC+
	 6VFLziO4GFsuA7qle4IF0Dh6X/IVqbvThBH5S6VGwUPelXisJtPnyOxk4h8WJ9ovSS
	 z7hvC4/9xh3c+UGTBixEV5Ry6Pa/4j48ST+IGYjPjwOI32FzkS+AT6G80f+rA7hqWU
	 mC4O9PzFXe0e42s3pyCkp9E007ESTrbgkVxoAbzqwtRgFu1oPA/bEw8HVdFydev22i
	 AKyQBveSJifyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AFD4C43140;
	Thu, 25 Apr 2024 16:22:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-04-10
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171406212923.4535.14406498714713066534.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 16:22:09 +0000
References: <20240410191610.4156653-1-luiz.dentz@gmail.com>
In-Reply-To: <20240410191610.4156653-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 10 Apr 2024 15:16:10 -0400 you wrote:
> The following changes since commit 19fa4f2a85d777a8052e869c1b892a2f7556569d:
> 
>   r8169: fix LED-related deadlock on module removal (2024-04-10 10:44:29 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-04-10
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-04-10
    https://git.kernel.org/bluetooth/bluetooth-next/c/fe3eb406723c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



