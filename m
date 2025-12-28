Return-Path: <netdev+bounces-246174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF1CE4A86
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE6C6300D4A4
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 09:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D177C2BE630;
	Sun, 28 Dec 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS7/qPIV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981ED145B27;
	Sun, 28 Dec 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766914464; cv=none; b=Uxky6M6gDlg+rEO4/YircYtCvU0na50LJnZ3WHYsNhFgF/bGMmrJ6lQaxc8k95hwb7qEv78MoqinBzeReDSXF1hO6R1zEUhcDbYi5lzE/Ggj/b2KMw4Em9osWPDe9ukAxiDxJeD1yO38Vv4J9n1MsNHAWw3uiRCAPxobd7B04nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766914464; c=relaxed/simple;
	bh=iRuKF543WzRf/d8F+ViynWH9gDwYuLVykWk19SzgOZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBfAG4Tqp89EE/s8015wiO5jtDpnrkum1fI8QoMHWQxNR8xfm90x8ZzKZD4GEcyGn/eH4iUmn+V7RCuYyo6m4dX4JFqqtwQBDu8lVq0EJen0Cv6flP5RSV+WB2SzZyKdo5eiCqeKd34hD10ce72DNqfz7zJO398oRVjiFfzjxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS7/qPIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E6C4CEFB;
	Sun, 28 Dec 2025 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766914464;
	bh=iRuKF543WzRf/d8F+ViynWH9gDwYuLVykWk19SzgOZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DS7/qPIVzqMwBCdraQKVNznuMd6Bw55RUphI6N49eD2l2GW9U8kV43MA8Mnzh/ssv
	 Bm0TVWk933/ZjdrmgjvzC1MTDlc4mdaB71BZ51HpjdKnv1xqu8pciqpJF16krU2jS+
	 Nytuyb1So6ejqlqsTaCIDpWM0v6wLfZ4FUNa0ke2Tm7cEy6ak6R0kA0df5bItvQfe8
	 W3/eCQK+/6S+1bSAjroCj0FFFPlIACfeqmjXGDafKICNHtqf6LqnnUYd3snNeUwplI
	 cglFMeUfh5xKMBkQGG+5jZGXzQMMFDUU5iJwiDmgoL/omnEI7Q3IU7d+tHCLGC7XQU
	 CD+4xOSLz5L4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B587A3AB0926;
	Sun, 28 Dec 2025 09:31:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bridge: Describe @tunnel_hash member in
 net_bridge_vlan_group struct
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176691426757.2294622.16719813097186880142.git-patchwork-notify@kernel.org>
Date: Sun, 28 Dec 2025 09:31:07 +0000
References: <20251218042936.24175-2-bagasdotme@gmail.com>
In-Reply-To: <20251218042936.24175-2-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bridge@lists.linux.dev, razor@blackwall.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, roopa@cumulusnetworks.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 18 Dec 2025 11:29:37 +0700 you wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./net/bridge/br_private.h:267 struct member 'tunnel_hash' not described in 'net_bridge_vlan_group'
> 
> Fix it by describing @tunnel_hash member.
> 
> Fixes: efa5356b0d9753 ("bridge: per vlan dst_metadata netlink support")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bridge: Describe @tunnel_hash member in net_bridge_vlan_group struct
    https://git.kernel.org/netdev/net/c/f79f9b7ace17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



