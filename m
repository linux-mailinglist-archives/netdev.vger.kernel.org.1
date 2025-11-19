Return-Path: <netdev+bounces-239818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0FFC6C9AC
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 04:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 2B7962CAEA
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB8A2E7623;
	Wed, 19 Nov 2025 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svodCVbz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566E25EFAE
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763523063; cv=none; b=jdp5Le3D1VPcjsUB42efQb2f9saXAPz+ULBOJqv9rh7ufkv15b+YtH2lPJpQOEYt79GwhRQ4Jgu0af31NIRG5Vj2+SacwWIUrvWvZzFmxxJOYxWrtm5995y+lED5xeqZuc+CjyrIM7ewaMFbiFLGf2WILfuH7XugI1PVpUz/zk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763523063; c=relaxed/simple;
	bh=NJUaQfn72+8kEXgoLDOx/LHAWntJ+il8E6nME+PV4Mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y1pNgX5xwcdLFHjxbDtYJHI23IKD2dMBnIEwDaxcMct+pyWsQmyR8GXteQn81wahWotE17anvWWfnfENexNoFm98wxLRx99fqwFnguTyIY2OPkb1guVnJ0omwRsizPCcdOC3TPKGUo0H3sG3b9jQDqcCtWEn7J8Zgtn/fxFbW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svodCVbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B58CC2BCB4;
	Wed, 19 Nov 2025 03:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763523061;
	bh=NJUaQfn72+8kEXgoLDOx/LHAWntJ+il8E6nME+PV4Mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=svodCVbzblLduMSC2SN3htiKapPIyzwRK3ESAh8O+a7jNaWyP1eXbale9gcRkwTjA
	 tj1b1GJqPhktg0ZQ/R7dbFKXfwyyu6JY0YdBd4KSz35CIBOSTStpkTCELSHSzrBSRf
	 sOwm1PU07a680BKfZW70OhChgEXvknVdplY3JiOWLJhWf2SFL1si9ROCbCZG8xA/sJ
	 X6rlhfnNohWYBvTslEsEfLEAeu+iBiMo4RKyaDDeGa76s9yDyTf8Xo1XgFAitaFVy/
	 GEN2w4O/FUMnvYEwe1eo2DfF2ceaPuTX+H5hhvQWR1WxWgs7PeWV1gKBLo9DeKXOrd
	 MeCeUQAeW6JSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0BF380A954;
	Wed, 19 Nov 2025 03:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2 net-next v2] ipv6: clear RA flags when adding a static
 route
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352302649.209489.15960953294481237254.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 03:30:26 +0000
References: <20251115095939.6967-1-fmancera@suse.de>
In-Reply-To: <20251115095939.6967-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 g.djavadyan@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Nov 2025 10:59:38 +0100 you wrote:
> When an IPv6 Router Advertisement (RA) is received for a prefix, the
> kernel creates the corresponding on-link route with flags RTF_ADDRCONF
> and RTF_PREFIX_RT configured and RTF_EXPIRES if lifetime is set.
> 
> If later a user configures a static IPv6 address on the same prefix the
> kernel clears the RTF_EXPIRES flag but it doesn't clear the RTF_ADDRCONF
> and RTF_PREFIX_RT. When the next RA for that prefix is received, the
> kernel sees the route as RA-learned and wrongly configures back the
> lifetime. This is problematic because if the route expires, the static
> address won't have the corresponding on-link route.
> 
> [...]

Here is the summary with links:
  - [1/2,net-next,v2] ipv6: clear RA flags when adding a static route
    https://git.kernel.org/netdev/net-next/c/f72514b3c569
  - [2/2,net-next,v2] selftests: fib_tests: add fib6 from ra to static test
    https://git.kernel.org/netdev/net-next/c/d7dbda878920

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



