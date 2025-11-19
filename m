Return-Path: <netdev+bounces-239792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B3C6C722
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2B11E362FB8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74B82D73A9;
	Wed, 19 Nov 2025 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zps2eq4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2C2D663D
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520645; cv=none; b=bCEnrgkJs0YScWQEt0ABSNMqyreG9Rj81wEOmWmAYi4qTxbzpymOpTNfxYC27rfKID+C0Cd6BiwY70iB+vzb2OMBe9tlP/4NnPtL5oC5yiRqiXNoTi4IQK9iFNVIT1Ls9TJbqusJ4kfnkD4UIORUMN4f2FsGF0n0HV7NHXEQZa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520645; c=relaxed/simple;
	bh=G5j+iK5jH7Xc4CNk/6FojOkLw/8JhC5UTWsfxSYt5BM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iWEVGaZ2p5ZKvy3ZMPfLNxrVO5NMkaqSxwVBJGyHNPKehclsOIohz3VgJrS2/h1PgdnaUVZlxCH77LwL9035gHdQQNEk4nlg2t/bO54qqOblz0FjKClafMBIwalEkDklyw8L9GuFa3m9hjw9wmlZNnoE674OCr4TgM54ngrDEP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zps2eq4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C85C2BCC4;
	Wed, 19 Nov 2025 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763520643;
	bh=G5j+iK5jH7Xc4CNk/6FojOkLw/8JhC5UTWsfxSYt5BM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zps2eq4zhw+FN/58nMjODPCTcDwRdKfxPPMjOaup5JZsDnVHgzZX+j6xzRf6awzwb
	 vN3JEtcfo6CgQW3xcf1LQvvXhPB7Xu88chmFgt4jt2NWWXBYsc5cYZbEANk/qVnqZ9
	 EHvtug5FM3lgZb9yEV1lykqwu13Xzz66jaA0XPiO/VSJb/G8crBv+yacg0kbV8gaBv
	 k+IHOk65di5hOrZ70dwZ/zGLsd4Jfy5Z7sPYaZjv5KDfb6VAh/6Km1OcsnvYDIRVqz
	 VtRK3xRRZrp1OIaMUagGTfF8rvrVp643sfRo+nkF9F6N60XQr1jy/ftGpBPzy9Mpfz
	 uGIfUVMKOWZqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0EF380A94B;
	Wed, 19 Nov 2025 02:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv5 net-next 0/3] Add YNL test framework and library
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352060851.193817.18444008941444790933.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 02:50:08 +0000
References: <20251117024457.3034-1-liuhangbin@gmail.com>
In-Reply-To: <20251117024457.3034-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jstancek@redhat.com, matttbe@kernel.org, ast@fiberby.net,
 sdf@fomichev.me, idosch@nvidia.com, gnault@redhat.com, sd@queasysnail.net,
 petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 02:44:54 +0000 you wrote:
> This series enhances YNL tools with some functionalities and adds
> YNL test framework.
> 
> Changes include:
> - Add MAC address parsing support in YNL library
> - Support ipv4-or-v6 display hint for dual-stack fields
> - Add tests covering CLI and ethtool functionality
> 
> [...]

Here is the summary with links:
  - [PATCHv5,net-next,1/3] tools: ynl: Add MAC address parsing support
    https://git.kernel.org/netdev/net-next/c/4abe51dba69f
  - [PATCHv5,net-next,2/3] netlink: specs: support ipv4-or-v6 for dual-stack fields
    https://git.kernel.org/netdev/net-next/c/1064d521d177
  - [PATCHv5,net-next,3/3] tools: ynl: add YNL test framework
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



