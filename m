Return-Path: <netdev+bounces-48508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD6E7EEA54
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6371C2085B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 00:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1437E;
	Fri, 17 Nov 2023 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6Mxve89"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2E79C5
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 00:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F4BCC433C9;
	Fri, 17 Nov 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700181023;
	bh=Yqv09rGhaUaYgK5vZCOHhlvSmzXMImOrHdpooNV5yc0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H6Mxve89lopGJIXFMO1graP547/bH5woC6qn+PNOg2sha6QtOgEszdFiXnfN4Qap0
	 ItwbHhT9DQc8dKX+7DfHzM3uBibv5eqOrS9mUbsV1tbjaxr2Zbx8OkfVIKHuW0z7GJ
	 JKJH6bIF+ERZ5HKafurPRrN34K53BDz1JBAAUk7+ymZyfqN25P9WuzPmKpMuxv2VM9
	 BaPy5/wkX4D0AUIpHM9OOjmFBjEQGfuoGNvpsyGTN8ePcHRIVNFSwAZUj0S4oAp15T
	 k1u8/zDxL8Iwen6B/Pfe1/tMPLc9ZTgq/f/Zrh5XfaFRrrJeEMtU4cZCiTc8om9Fvd
	 wSr0V1HVYoDUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC19AE00090;
	Fri, 17 Nov 2023 00:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rxrpc: Fix some minor issues with bundle tracing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170018102296.11691.4713872724696133068.git-patchwork-notify@kernel.org>
Date: Fri, 17 Nov 2023 00:30:22 +0000
References: <3939793.1700068540@warthog.procyon.org.uk>
In-Reply-To: <3939793.1700068540@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 17:15:40 +0000 you wrote:
> Fix some superficial issues with the tracing of rxrpc_bundle structs,
> including:
> 
>  (1) Set the debug_id when the bundle is allocated rather than when it is
>      set up so that the "NEW" trace line displays the correct bundle ID.
> 
>  (2) Show the refcount when emitting the "FREE" traceline.
> 
> [...]

Here is the summary with links:
  - [net] rxrpc: Fix some minor issues with bundle tracing
    https://git.kernel.org/netdev/net/c/0c3bd086d12d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



