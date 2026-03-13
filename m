Return-Path: <netdev+bounces-267284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOY/JrJ7s2lmXAAAu9opvQ
	(envelope-from <netdev+bounces-267284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:51:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F8127CED2
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11A78307244C
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C393034BA42;
	Fri, 13 Mar 2026 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qld7BDRS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070E21254B;
	Fri, 13 Mar 2026 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370225; cv=none; b=Vl0y2JVYrOeE8O5FhVllhqrFT78SaLIlJr/bJuPgKfZ1iu4/Yq5J8zuWfLaBRTQcYfPUkLkCwVP6we37Y4tcDqwDrfxSSjxa7sdw6x9HG1uvDu8MII5suJtNqCkLh685BvyY73BeV29kwmWjJlsJpZjyLdGdoy7q2yOzI9JUHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370225; c=relaxed/simple;
	bh=eBN2fd5z+SrDyxD6ZmgipCz6OhwpvZdJvnqSSEdrHRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZTH8xau9KN3g3vhcWsaL14LdbxwLmV1jr1ZHPZ64QngP0ANfEkfcssN7oO2zc3sR4I+6e9qL598xM8VYPIE5Yi2lYwhl+/dRHtrPpOSsSSJVOEAxYe6H0jK/4dkXrfRu3JyOGbWgMafTqBOaKMwX4vWnHlasAjQnYidQ5RJBRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qld7BDRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EE4C4CEF7;
	Fri, 13 Mar 2026 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773370225;
	bh=eBN2fd5z+SrDyxD6ZmgipCz6OhwpvZdJvnqSSEdrHRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qld7BDRS+UVo3+co9wYTDjHEKaLhfPonTt2EoKlQ5ygA8Rh/bLc6wUlBXmrr3AyrI
	 jeX9UPPUq7VlI0PXYwwrLkjMVYXuix5FhxCX7YFrP9OTcEpXTVksPjivKQq4+AELPD
	 LeHSnKeRSIhRyOZ7sPo/ZILJCdmDXCnMZUnfsUjDYZDImVeN+C6Pls8adDArly1/Y0
	 5CwZrSb8P3pBoCJdog6CK11BMLOh4pEqG4YnLID9KM70wuqatARmELdVDjeE9D7ltc
	 p8cqWLxlBbXG2dLsbMmXxbf1Zm02VtePQaCdFQB4+D+JmPHMdIloETLERn41pxt/w9
	 5DP+1Ip0HH4pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF03808200;
	Fri, 13 Mar 2026 02:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netlink: update outdated comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177337022029.648356.4175577567516214916.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 02:50:20 +0000
References: <20260311133519.688-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260311133519.688-1-kexinsun@smail.nju.edu.cn>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 kuniyu@google.com, linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
 xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267284-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 11F8127CED2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 21:35:19 +0800 you wrote:
> The function netlink_clear_multicast_users() was removed as unused
> in commit 2173f8d953e7 ("netlink: cleanup tap related functions").
> Update the comment in netlink_change_ngroups() to remove the stale
> reference, replacing it with a general description of the behavior
> while preserving the warning.
> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> 
> [...]

Here is the summary with links:
  - netlink: update outdated comment
    https://git.kernel.org/netdev/net-next/c/8f921f610054

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



