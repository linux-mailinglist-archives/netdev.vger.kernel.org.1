Return-Path: <netdev+bounces-103754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE590955D
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 03:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B6B0B21633
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 01:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19F1870;
	Sat, 15 Jun 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6bMh3/K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB3173
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416231; cv=none; b=NYaJ1TNj97yigLAQNKh+uPj8zYAPIqd0V/0Ko9qtNsbHxu8p6d77BekcNO3E2ivUzxq/1b0Aka/JgU2z1GPUPGbh/wePL3B9dcbyV+SFNRI4YNa5AACC1PlMdbAgTHtsqI0KOzI3geWufv4GrBTucBavJdhXve6J2HT2rKja/ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416231; c=relaxed/simple;
	bh=c9J+cDBZTacouJeC8CbfnkBG4Kv+RpgFW6i2DANS140=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lqdgSsKIuBvF/V/qu8NxI1UrIoU6UT6972/j51VMJwRzxz6wOgd9UDieYpd19FSTmgOW+Y6Z02FKs54PCWVoTuzrV1IbJJaTGcYpJM8Tpe1f3fdMZk5FgAJGaz0M4W1gNk/kWzpD4XFSTA5lUgRkYRST/1cTqYXm8sLOUh0PSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6bMh3/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B7A8C4AF1C;
	Sat, 15 Jun 2024 01:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718416231;
	bh=c9J+cDBZTacouJeC8CbfnkBG4Kv+RpgFW6i2DANS140=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u6bMh3/KoYlT/JXo5tjEcC1jFF3WPUvjN7Xw1cFEXD4AF1J6LVHH9grMT2IypfAkW
	 Z38AOVyd4CdHe+PJZVyqrwNlJ8j9Il+39Qxyyf7zBillY6eM1LeYaivvjNrWaBsVF5
	 L2yxIUCBzbd64RDrGCErEAytUX3HZi1E6/HM/nfMzZw4lp8DLSnLs6/Ct8NAQuHeuD
	 LSKIJX+AkoI+FmMKGwozgeIrIU3zh/Wc2jHsyHZ7TAka5DaCiyba9zS9qYX6S625p7
	 vtOihaLjT4BHDXJVRlYFc9EdHuAm2AcviKXvmjZICn6Vhsgq6z4PHp/Pn2m2Jf+wZH
	 UneKvPfkSSiXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 626C4C43612;
	Sat, 15 Jun 2024 01:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdev-genl: fix error codes when outputting XDP features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171841623139.3120.6737242474826552980.git-patchwork-notify@kernel.org>
Date: Sat, 15 Jun 2024 01:50:31 +0000
References: <20240613213044.3675745-1-kuba@kernel.org>
In-Reply-To: <20240613213044.3675745-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, hawk@kernel.org, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, alardam@gmail.com, lorenzo@kernel.org,
 memxor@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Jun 2024 14:30:44 -0700 you wrote:
> -EINVAL will interrupt the dump. The correct error to return
> if we have more data to dump is -EMSGSIZE.
> 
> Discovered by doing:
> 
>   for i in `seq 80`; do ip link add type veth; done
>   ./cli.py --dbg-small-recv 5300 --spec netdev.yaml --dump dev-get >> /dev/null
>   [...]
>      nl_len = 64 (48) nl_flags = 0x0 nl_type = 19
>      nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
>   	error: -22
> 
> [...]

Here is the summary with links:
  - [net] netdev-genl: fix error codes when outputting XDP features
    https://git.kernel.org/netdev/net/c/7ed352d34f1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



