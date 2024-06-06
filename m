Return-Path: <netdev+bounces-101414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B922B8FE799
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586AC286E57
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B136195B2E;
	Thu,  6 Jun 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTbQkU0J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7FB1607B2;
	Thu,  6 Jun 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680029; cv=none; b=EMcmSIPoFhHKp7NygC9axyP+kzW04RdNdAYkzU+dWxDUfM43BOCrh2xA2Q8Y7Kf/WW86SbmW/lSUrsyGQZcZPhf88YK/hI20Wn4TJRe4cCrGGjqrHYDN7QtHafblkdI1ZXQ64T19UeCwI25HiFp29JdxmmsHVxkGWpPJg+aCTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680029; c=relaxed/simple;
	bh=5iz8CAc0Z176SxxNcjKNqcapz4skKcl/itNcGZhmJyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mK/5HI3uWoUI7gAJXaPAWsWNl7Oft3ZqWuperqYoY+sjVqTefRpF+S8SradXKYL5fkk2KwIn6pfCjE0N/JH+gbRtRXHK//M/0H1SsSqZd/WCdbq7NoiIuR6OgOFJL02KxOtODRMjda1zqE5zA4EG4qas9BKrE2+ewUW/j0GaLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTbQkU0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B163BC32786;
	Thu,  6 Jun 2024 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717680028;
	bh=5iz8CAc0Z176SxxNcjKNqcapz4skKcl/itNcGZhmJyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZTbQkU0JLdPBo0etm50uh6QTFTugMAATXS4YtUgJotLrvfLRoGN0pkPqn0SQ3TTbg
	 ye2vaHvHp/ZvAK6rjZ5olAK3z48prPoJr5GpcZquF5xec7JQJasmMK64GucQsv9+Kv
	 GsNcmz6qdCu6BrK9Ym2ddXS2sRc8tVZh11pMocFaph2CDNjjMatckYGYs3xsJ22Xuk
	 m5NApJ7zNHp+Uw34uShaDE/DwFiZ3znzy4BnNq1IdrDC1czKFGCx0rOobqMDV4NnpP
	 3KmI0CA0JzvZXyFmoFwll6NQ2doYKhdKlBHxxGb6ER8doT3PGJ7yNsJMLMYHgzGl0g
	 XfnpEjZ2JXy/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94650D20380;
	Thu,  6 Jun 2024 13:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mptcp: misc. cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171768002860.7454.11835229356797799300.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 13:20:28 +0000
References: <20240605-upstream-net-next-20240604-misc-cleanup-v1-0-ae2e35c3ecc5@kernel.org>
In-Reply-To: <20240605-upstream-net-next-20240604-misc-cleanup-v1-0-ae2e35c3ecc5@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tanggeliang@kylinos.cn,
 dcaratti@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 05 Jun 2024 09:15:39 +0200 you wrote:
> Here is a small collection of miscellaneous cleanups:
> 
> - Patch 1 uses an MPTCP helper, instead of a TCP one, to do the same
>   thing.
> 
> - Patch 2 adds a similar MPTCP helper, instead of using a TCP one
>   directly.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] mptcp: use mptcp_win_from_space helper
    https://git.kernel.org/netdev/net-next/c/5f0d0649c83f
  - [net-next,2/3] mptcp: add mptcp_space_from_win helper
    https://git.kernel.org/netdev/net-next/c/5cdedad62eab
  - [net-next,3/3] mptcp: refer to 'MPTCP' socket in comments
    https://git.kernel.org/netdev/net-next/c/92f74c1e05b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



