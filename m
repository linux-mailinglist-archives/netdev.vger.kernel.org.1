Return-Path: <netdev+bounces-92137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D478B58C0
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923B4288AEF
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C899200D9;
	Mon, 29 Apr 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCZ13xMk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955E175B6
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394430; cv=none; b=tOLxBQXyOmd6isy+mhmtaAHRD2Y5TZJ5pE7ZpGKxK994zB5ZevkCFRKPeMIDKF35/qIu7xA6EpDSEp6CVB+KcTGYOYA/P47Qjygy22UVtvwt3F+ohinFX8CNVPdBdt7FG6o5yyKtlzCpMluNmGEXncv2eVecTMLqFDZdbyb9YkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394430; c=relaxed/simple;
	bh=aPXcXm8lNUgDVR5yJKV+/jTjVeJnOj8t4jQCWbbXBtY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AG9HgVJbjQin3G45TM7f7yrx7jg24MPhZBlPZy6eFkpP6Vo9UWQtj+fFHrHQNYin0sGxJjvAbacJ2wUHMhgQqeRlwd5Rvao0lhauFuxYL5iCI0jVKWz05pmByLR8F1xVyPmouKJ9i3cvjYc+ifZ9zKHkRRRmJ/VThQUp2tVcouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCZ13xMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9F87C4AF1B;
	Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714394429;
	bh=aPXcXm8lNUgDVR5yJKV+/jTjVeJnOj8t4jQCWbbXBtY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rCZ13xMkNtew0no7TcKVvdUzEc1wV/fT38aiMFtdI7rrWuYOXWrTioiJ/zsWjqzsK
	 3Eu0g2uX9yvEHSBAhyLr5hkdA9XOkq/ZDoP2S3+284vvBRserKhYRhhDYk8b8/3LZT
	 UV8IpE51CKQuT5+LcSaSglmTs0ZI+cGrXNnKzyJBqHPXWhr7GoA29sULw3JuCezm0p
	 wIpVu11sTO8sdHiig0EXYr6t3STqfOfi8plbF7jhlQ2o0S3HgeDXvtUlVBTFuCgon8
	 WVWAIt5w3xAIH9QoSmxs15cSNO5trRpmxq2zq7liUTeCZgU0FCqvzLpV5biSUu/ZuL
	 ZypLIkOXz2iyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A45FFC54BA9;
	Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv6: introduce dst_rt6_info() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171439442966.25762.17052200740789522016.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 12:40:29 +0000
References: <20240426151952.1995663-1-edumazet@google.com>
In-Reply-To: <20240426151952.1995663-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Apr 2024 15:19:52 +0000 you wrote:
> Instead of (struct rt6_info *)dst casts, we can use :
> 
>  #define dst_rt6_info(_ptr) \
>          container_of_const(_ptr, struct rt6_info, dst)
> 
> Some places needed missing const qualifiers :
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv6: introduce dst_rt6_info() helper
    https://git.kernel.org/netdev/net-next/c/e8dfd42c17fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



