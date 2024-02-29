Return-Path: <netdev+bounces-76007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AABD86BF99
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FBF1C21326
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 03:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D66381D1;
	Thu, 29 Feb 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf8q6VyX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44187381B9
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178630; cv=none; b=I9DtAHVpgfDCkKVKyO7uOPzJgiRR1a9Up/Qxtl5pr07KPt1vVA/mpSczMXmy712s+aONkFm0mAmWDZONBoLviE+0tcuvC3AOmXpRwmytIMYWpd0Otmo9GQARJ52hvmSwLP127i5/J4bFTHv7wEDaAs/XeS0KDjYiUToF0if55Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178630; c=relaxed/simple;
	bh=S9+5/yaoxGgNgXM9ZTKK5dP9AWAqFcj/LnGhZjCykvU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SDw5nbGrl7qlNFAJm0lON1CAErWNd9w93Fl44nUYQ9Bid/v71UCZEOgLAwnhac2toDixfRO1UDyv8/p8vHsJ+I6APjuUBooP8PDd+Xm4XjDe0QqWNy/11ftn9DFwcnsCb09ymNXz2EyyTP7z/jOs6kzAOMl9XRXfkwSyoXu9XTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf8q6VyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B491AC43390;
	Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709178629;
	bh=S9+5/yaoxGgNgXM9ZTKK5dP9AWAqFcj/LnGhZjCykvU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jf8q6VyXhAiDEAew0f5Zh6k642MFhedQawVDFpkhzRa8MguTZTCU6t6YaKBaQg+op
	 yDWu5Our4Fya/1EB8zeHMqTQZkSms8ENhvp5z5ICmsKMoutQHAi/wiWYuFvvSfsWC8
	 VdBwTUiXd8cuHhsi2ijZQ+y3pD4m4qlRW9De9iWnubN54R7XEDA9ZO2m0Bb1yv1s0g
	 V+KQP0/YDR60x52rOj0ivEZ24vcQ3pkv+X6B2k96e+oxueciWPJhF5gu85bsm0A8NE
	 EJKZ/9e2fE7N6k7yeNURjmCWj72+3zFjJ0OEEHaqrox3DdmnqfWWwuV4EqkVFV+SZv
	 VQ5Dv961znTcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B09CD990A7;
	Thu, 29 Feb 2024 03:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: remove SLAB_MEM_SPREAD flag usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170917862963.28712.8604356549822328231.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 03:50:29 +0000
References: <20240228030658.3512782-1-chengming.zhou@linux.dev>
In-Reply-To: <20240228030658.3512782-1-chengming.zhou@linux.dev>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, zhouchengming@bytedance.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Feb 2024 03:06:58 +0000 you wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed as of v6.8-rc1, so it became a dead flag since the commit
> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
> series[1] went on to mark it obsolete to avoid confusion for users.
> Here we can just remove all its users, which has no functional change.
> 
> [...]

Here is the summary with links:
  - [v2] net: remove SLAB_MEM_SPREAD flag usage
    https://git.kernel.org/netdev/net-next/c/d4f01c5e477a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



