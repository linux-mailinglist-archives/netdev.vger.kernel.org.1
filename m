Return-Path: <netdev+bounces-20314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2534875F0AF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D95280E3B
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995368BEC;
	Mon, 24 Jul 2023 09:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D50746E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67029C433CD;
	Mon, 24 Jul 2023 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690192220;
	bh=2eYb55SINsVrnLxw6/CuBLqAH6+dSmdA1YWLXAoexJw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bmMgI0V/y8+DuT8UFcI9JX4qrgTi1mHK7pTgincfPy5bYWikHkOJJ8ipVU77BXxX5
	 xpR1ESFKPht0r/ezJD9egXgonYQ+q0AhlEri9iSlBnhzvTr/W3od/cAzZgaknb8OSY
	 zZB29ZIJgWRU8rHik+dMWwGgnwUVBin9QD78E00EArlNoVgcIZXfPeUp0zJMgM4+cB
	 dLQRXRgJ+dDa2mFtzFLktgkG4QG6p7FoWkTwe6qTlGorZz29iwjhjLYrQ8owGLAeMN
	 1/678TDZCupx9sg+qzVcTQXTXp8TEMdLPa54naZXb7E1u3GVSWOTT/8/ltLYHfQMrr
	 6NFwXWH3F0o2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27CDEC595D7;
	Mon, 24 Jul 2023 09:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] vxlan: fix GRO with VXLAN-GPE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169019222015.26830.6469695404489924789.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 09:50:20 +0000
References: <cover.1689949686.git.jbenc@redhat.com>
In-Reply-To: <cover.1689949686.git.jbenc@redhat.com>
To: Jiri Benc <jbenc@redhat.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, simon.horman@corigine.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 21 Jul 2023 16:30:45 +0200 you wrote:
> The first patch generalizes code for the second patch, which is a fix for
> broken VXLAN-GPE GRO. Thanks to Paolo for noticing the bug.
> 
> Jiri Benc (2):
>   vxlan: generalize vxlan_parse_gpe_hdr and remove unused args
>   vxlan: fix GRO with VXLAN-GPE
> 
> [...]

Here is the summary with links:
  - [net,1/2] vxlan: generalize vxlan_parse_gpe_hdr and remove unused args
    https://git.kernel.org/netdev/net/c/17a0a64448b5
  - [net,2/2] vxlan: fix GRO with VXLAN-GPE
    https://git.kernel.org/netdev/net/c/b0b672c4d095

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



