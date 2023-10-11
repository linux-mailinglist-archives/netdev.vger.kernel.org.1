Return-Path: <netdev+bounces-39945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C311A7C4F46
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6A71C20C72
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C761D6B8;
	Wed, 11 Oct 2023 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqR2rWc/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5BF1D68B
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D16D9C433C8;
	Wed, 11 Oct 2023 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697017227;
	bh=MPRn4REfCnP6OBo8bH+vknRtSjj7HNl2ZtErW6tgtY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kqR2rWc/8e+nggQjp6Ar3eoRLVDjjjUYZc6UGUVgRrDNN9ii4Th6BpOit95afTWfv
	 LSmCAb2YcBAsB3NWmYQyi5G3gf77SnCub8A0RHAVz3lHxFpmb6WWHntXbiSYvwbOm+
	 q0A3vZ3GugahcIKO9WDtHkqMefD/dnXS7bM0gdU0xfaH3OdqoDTJR0nwaIVExeP3uk
	 jv7LhYF6GasJgND241a8AWad5hgaA8CrhTveQ7b7Dr5ojYnpHu1l1orrIn4vqroco3
	 FyE50WWwysM06IPjGKB8/MK8gUmStcJKZnuHSPTIqC0xuKXvJUdtLbuLVja1iIuye2
	 eAgY4K7WpD+5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B91C8C595C4;
	Wed, 11 Oct 2023 09:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] add skb_segment kunit coverage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169701722775.1947.6980237139794467834.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 09:40:27 +0000
References: <20231009144205.269931-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20231009144205.269931-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, alexander.duyck@gmail.com,
 fw@strlen.de, willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 10:41:50 -0400 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> As discussed at netconf last week. Some kernel code is exercised in
> many different ways. skb_segment is a prime example. This ~350 line
> function has 49 different patches in git blame with 28 different
> authors.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: add skb_segment kunit test
    https://git.kernel.org/netdev/net-next/c/b3098d32ed6e
  - [net-next,v3,2/3] net: parametrize skb_segment unit test to expand coverage
    https://git.kernel.org/netdev/net-next/c/1b4fa28a8b07
  - [net-next,v3,3/3] net: expand skb_segment unit test with frag_list coverage
    https://git.kernel.org/netdev/net-next/c/4688ecb1385f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



