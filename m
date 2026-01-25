Return-Path: <netdev+bounces-253289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEGyDfmgdmmOTAEAu9opvQ
	(envelope-from <netdev+bounces-253289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:02:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A56FE830FE
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 00:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B67973010B9B
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1819630F95A;
	Sun, 25 Jan 2026 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhZvEa6m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B893002D7
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769382020; cv=none; b=uzN3aRLE82oyzHpymvu78pcvMEoc0mrRHp7/X+szq+8imepDIKFtDlRaxhxUJi59C0EHxpumr3sdyAo4vIHCdRM4tyL/2otGgIQQ4efBmljBVv4CW2moxmhW+ZocqaRIRbI63qnc6b+hWaIULpt0mccxzB2B8xmZyWpdd0DCW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769382020; c=relaxed/simple;
	bh=+pMTxU9PLeec8dePK+bSPagbWIqbm31Kr9bbPzDyD1k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cl5eqUnXQyPG66eVk2NRpUlDApxbQ8Dc+hE0tS/OvIeo2qKCVLSpyi8PWdnH9yMSTR59OyaQfamw9P0f3SG7XQCCE3RuH2wAe32Ww29iFCIbsVedealNM2lu0+P6M6UeGkGRuKCCq1E4MItANSFGr7f9L9VPB0PiqeoInTMlboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhZvEa6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84624C4CEF1;
	Sun, 25 Jan 2026 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769382019;
	bh=+pMTxU9PLeec8dePK+bSPagbWIqbm31Kr9bbPzDyD1k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mhZvEa6mECDhdfDgPOV6WZD2VNdxkjtf7JZAsA9eAo5JDq03vuEk6WCaiH7nJY/kF
	 p+xUWbI0a27ieywIY+P2BWknRzSZ16sDPkWGt5MiGeXUsKspgiZE4hDzALQIUSSEtf
	 oU3Vfx6bB4adMSmvieuUAgdF9bcAYSJcg2rNTQTWQdTv0+wznEdT7lCj3i4pVYA2f/
	 WSEGtxLEvz6f0ZXBsSDQ07+nbtd27jC3QzS1Z3LPKhTGXWNRyG2ms3NswOLzkfM/+/
	 sWFWkUkqQFjTbcr1SZjQKKkdwyc3WAk8P9j0kKz67B4Lji5OcFrS2JKudm1MnM3FyI
	 aPFVX9uPDWSrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBA83809A15;
	Sun, 25 Jan 2026 23:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: neighbour: Notify changes atomically
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938201436.4007016.15562827652330249798.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 23:00:14 +0000
References: <cover.1769012464.git.petrm@nvidia.com>
In-Reply-To: <cover.1769012464.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 idosch@nvidia.com, kuniyu@google.com, leitao@debian.org, aroulin@nvidia.com,
 fruggeri@arista.com, stephen@networkplumber.org, mlxsw@nvidia.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253289-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A56FE830FE
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 17:43:34 +0100 you wrote:
> Andy Roulin and Francesco Ruggeri have apparently independently both hit an
> issue with the current neighbor notification scheme. Francesco reported the
> issue in [1]. In a response[2] to that report, Andy said:
> 
>     neigh_update sends a rtnl notification if an update, e.g.,
>     nud_state change, was done but there is no guarantee of
>     ordering of the rtnl notifications. Consider the following
>     scenario:
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: core: neighbour: Add a neigh_fill_info() helper for when lock not held
    https://git.kernel.org/netdev/net-next/c/77fa50dcb987
  - [net-next,v2,2/8] net: core: neighbour: Call __neigh_notify() under a lock
    https://git.kernel.org/netdev/net-next/c/0ecdccb8a455
  - [net-next,v2,3/8] net: core: neighbour: Extract ARP queue processing to a helper function
    https://git.kernel.org/netdev/net-next/c/705ef89ac986
  - [net-next,v2,4/8] net: core: neighbour: Process ARP queue later
    https://git.kernel.org/netdev/net-next/c/89246ef82d79
  - [net-next,v2,5/8] net: core: neighbour: Inline neigh_update_notify() calls
    https://git.kernel.org/netdev/net-next/c/a228a7e681b8
  - [net-next,v2,6/8] net: core: neighbour: Reorder netlink & internal notification
    https://git.kernel.org/netdev/net-next/c/795258891c94
  - [net-next,v2,7/8] net: core: neighbour: Make one netlink notification atomically
    https://git.kernel.org/netdev/net-next/c/d0887dc8b2d0
  - [net-next,v2,8/8] net: core: neighbour: Make another netlink notification atomically
    https://git.kernel.org/netdev/net-next/c/a00266969c8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



