Return-Path: <netdev+bounces-54283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B92E28066DE
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02ABEB20E46
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E895910A1A;
	Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o57D61M+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8E10A17
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ACA6C433C8;
	Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701842426;
	bh=9oMotMl6cBHvoh0aoy720TZQixKh8EXqycLlXSSUncY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o57D61M+8H3t7mO0oXDMsezyaXwHMXWvqmcy1uZJQ91ALwvnPccv7o6D0+mF6kMGz
	 WvnjbigdDaNhuWNVzkgrcZ1gWaqxxADmg3OX/AaABMothOQ8X3scRBszkt1KGCmgtR
	 zHyJidZw5PGzagicwDO4eD798ZnaWOiLgsdndj6M/tKnVj7oaQLVecDBL3Dh4Pw++g
	 a0rPbLFBirHwy5xo542hYPRkYMGsWUkuVt3nXqmVFn9XS8msCTri/kYETIfQQAXBw/
	 vzaHL2lXF/zvlNAPLraaWN57AQ6wjToHAr5eCKndZEBSxk5L9gQvkpcV6RtFQVFFUi
	 xYGiUT5Oa+4Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E55FC395DC;
	Wed,  6 Dec 2023 06:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] packet: add a generic drop reason for receive
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170184242618.7312.12769597881622263947.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 06:00:26 +0000
References: <ZW4piNbx3IenYnuw@debian.debian>
In-Reply-To: <ZW4piNbx3IenYnuw@debian.debian>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
 jesper@cloudflare.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Dec 2023 11:33:28 -0800 you wrote:
> Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> from consume_skb to kfree_skb to improve error handling. However, this
> could bring a lot of noises when we monitor real packet drops in
> kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> can be freed, not actual packets.
> 
> Adding a generic drop reason to allow distinguish these "clone drops".
> 
> [...]

Here is the summary with links:
  - [v4,net-next] packet: add a generic drop reason for receive
    https://git.kernel.org/netdev/net-next/c/2f57dd94bdef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



