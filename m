Return-Path: <netdev+bounces-132201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120E5990F6F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446FC1C230AD
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9405C1F706E;
	Fri,  4 Oct 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmM1uMf3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7331DACA0;
	Fri,  4 Oct 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068429; cv=none; b=bsQnZvDRds18wlQRPbFQN2oG8ZhFysxCNeWPhQSoUU3JIhkK6xQ5Fyq9+nmBZCazTcqyapgpGbKegtccp9BLVQvjrk+CN1wASHoKDHCNAQ/MyN7juydl0Vbin6sT2UCIXkcaP0Uh8fN4kStWhn8JdgGQzav06RW4aZFaKJRS+zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068429; c=relaxed/simple;
	bh=N/ZatbjZOH0Y9cs2ghz2vcC4f5g1kAKnYaJxLjbL1dQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p8giTpt8AIikzL+ic7wwEA9OFnYLAtMCVfQo+1GIgiC+UKPXpjniHtZQupqR74Sr+rJgGrD9Xw39sqJ8xgZo4nz7OojSIAhV/Mlq+2bZAz2mVlt7cWbG5mKNcS8BD5PwMjgmfYw3G/XhlBHdoq2D+OZ3tYEODm/DsmtpcBjosYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmM1uMf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7CAC4CECC;
	Fri,  4 Oct 2024 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728068428;
	bh=N/ZatbjZOH0Y9cs2ghz2vcC4f5g1kAKnYaJxLjbL1dQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gmM1uMf3YYQT8wg8OjqI3NwDPQvCzSVkaRka9B8pZvqAf6XsEuBqDvtdVH9MV2x/l
	 Q8ymqOQh4uqQFtdFjNhArZtOR6TwkzpqI8AcUdDIBSga0klNDk48UY5NtZF/xJELMp
	 a4ZH4S8ARgZAJRPbryk0uUjyUgXGniyYNRCXhToTe8xOXj2ZlSmsFqrtowbIW5odoY
	 FlKSBwYfdQEejHK/MJZY9jYzrLNcMjAMk7ObC2188JqoF3BvuEHfSBjr27N9gYOyNE
	 3aXI4Ux7h+K6vx1M46aAnCTkto9X70d4YviYGK46/PgcT9uMtzylyyOBrSzResHLoA
	 lxyKIuuLfnwKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE35F39F76FF;
	Fri,  4 Oct 2024 19:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: sja1105: fix reception from VLAN-unaware
 bridges
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172806843252.2704625.9394573592680839438.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 19:00:32 +0000
References: <20241001140206.50933-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241001140206.50933-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Oct 2024 17:02:06 +0300 you wrote:
> The blamed commit introduced an unexpected regression in the sja1105
> driver. Packets from VLAN-unaware bridge ports get received correctly,
> but the protocol stack can't seem to decode them properly.
> 
> For ds->untag_bridge_pvid users (thus also sja1105), the blamed commit
> did introduce a functional change: dsa_switch_rcv() used to call
> dsa_untag_bridge_pvid(), which looked like this:
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: sja1105: fix reception from VLAN-unaware bridges
    https://git.kernel.org/netdev/net/c/1f9fc48fd302

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



