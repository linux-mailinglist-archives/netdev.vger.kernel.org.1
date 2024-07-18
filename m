Return-Path: <netdev+bounces-112039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7840934AD1
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE3BB21698
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E647E56B;
	Thu, 18 Jul 2024 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc1ygnlx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9E78C8F
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294435; cv=none; b=kZyzINm46i41wnlX8t56blyN8eL3HP2gBTCmmwUTN3EvBU0NxAxAvyR4cCK3JhQ1kfU3lf/kk89Gig2Y7EMWVPwO38/yR3ezcDASZAmD/DmdJHrfSKiWQQODBVEBGqkGfm6lW6codzRiFd3P4JbWAm1KpvyzWBpahx6o/ndj06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294435; c=relaxed/simple;
	bh=NRQDKXnxAVH6nP7xAb2Kkf7D7Xa/zUbJbkJMQw8ZssY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VEMd5Zj0V+1MJImHrAWo0EUYNmwQ77JCpqu5sAVTgvmcGM0k/yOHRrgZ3ap/7oiD7VrVvOiwIxsmK+HB9+3EqF3iBlCr/+Zc+kRZvWSeqYI20fF+5EFF4bByQSL0grDHaC3VKARz0iWTRcpXFSQ23yQj/gDESxCXw5JFXgyWpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc1ygnlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEA69C4AF0B;
	Thu, 18 Jul 2024 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721294434;
	bh=NRQDKXnxAVH6nP7xAb2Kkf7D7Xa/zUbJbkJMQw8ZssY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fc1ygnlxmttEKxlH/tWZxs/gbNznzDs8jLDiyEwtr95T+U0bg7bqfur3FlVNr724f
	 8vIcYeENlxBsN61WMX2uJF7oGnmRe4dpKHxYqku4RwrqB1Cka2GvL0CJlmqMrdrLBp
	 2rpCZMWuRFglgLoNJjPPFeHozLyGG6cFfkm9SNsy1ghDJWOdTt1zTcqb+95NR8BwKT
	 yrGluxY0ZQ+Y8Ha/Yo1RdgftFkFW08UvAWQe68FYJP3JTwiadCEHo1f8YL1zGjD78b
	 aLKm5n2LCZKzFgCxH98X/KBcSbB31klmgRaxiT/KMztdS3DiY3Mm6Pl3QesBnJ4F9H
	 6FZI+vKZrPiCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB4CDC433E9;
	Thu, 18 Jul 2024 09:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ipv4: Fix incorrect TOS in route get reply
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172129443476.20206.3448518971869486839.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 09:20:34 +0000
References: <20240715142354.3697987-1-idosch@nvidia.com>
In-Reply-To: <20240715142354.3697987-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 gnault@redhat.com, roopa@cumulusnetworks.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 15 Jul 2024 17:23:52 +0300 you wrote:
> Two small fixes for incorrect TOS in route get reply. See more details
> in the commit messages.
> 
> No regressions in FIB tests:
> 
>  # ./fib_tests.sh
>  [...]
>  Tests passed: 218
>  Tests failed:   0
> 
> [...]

Here is the summary with links:
  - [net,1/2] ipv4: Fix incorrect TOS in route get reply
    https://git.kernel.org/netdev/net/c/338bb57e4c2a
  - [net,2/2] ipv4: Fix incorrect TOS in fibmatch route get reply
    https://git.kernel.org/netdev/net/c/f036e68212c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



