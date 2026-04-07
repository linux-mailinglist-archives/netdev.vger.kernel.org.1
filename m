Return-Path: <netdev+bounces-275822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPRfIz9j1GlAtgcAu9opvQ
	(envelope-from <netdev+bounces-275822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:51:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB13A8D2B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 127723048EEB
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F29F2309B2;
	Tue,  7 Apr 2026 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1QAfGHg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBDE22DFA4;
	Tue,  7 Apr 2026 01:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526647; cv=none; b=qiAHYEXiOwLeojbMi8vJxZVbLtZQd6HFtxFiyQaxV2DHCR6y2ceZ2Eu6pw6BAPofjVvoXTD7h1/mpHCveogRP8bg5vlMOwLZWFwmqm0/DlAL7IYYW6qN2/bz6k0vQrOcRuQTcswez+s/kK5g1E9Jv1O/Sp6DvASiPcEeC8IjJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526647; c=relaxed/simple;
	bh=I1894Tqr1GIikOXl1eglFgSX/8ktbiaMFBzaS7PcAIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HGUB2PBG5n3jD+zK/H7VKi8vY4hh0Vz0lmWTAVY8WRJ0ulQqxqRBnTPEgsg9yXxwvxshbZLA6QvACR/XxKT8d8AcUi2SI3m0g6vczNFBsEUo+MbbHS0jJbwE3n5HwkghPg5cxjfe8KjE816e7t8o74soWt3nXRFPx3neTBpVPMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1QAfGHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2930FC4CEF7;
	Tue,  7 Apr 2026 01:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526647;
	bh=I1894Tqr1GIikOXl1eglFgSX/8ktbiaMFBzaS7PcAIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p1QAfGHg9snnQFWry63xRpdpsiikxA1ldAWgipReUXxizZT1qarfKyYRyabvgRlHm
	 qbJyngtDi8LuYp0EoyyWHglvZR8SJ31H/n5E68oaqwmhFw0wtxNckvo1ACi64rlV+g
	 vE0xfWNFMOkfyhOsKqHnyW7NjlmUe6Y6OSA6vi/iB/VUlQXWMoqYWDk2I0IfvWkKva
	 ngP++fMXTxH5Vqrwf0Md4xf37cop+M6+0FSOoE2hfyzNEXrzVLaXiQ1jz8cfltP4Mx
	 /ex54vM2qUee0XrqEw/x8seKRdbiKaXyV/rJMSzokj7/LTWvmlMBzJoQW43GvIKG3y
	 nHdN/uj5GTogw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D433809A28;
	Tue,  7 Apr 2026 01:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ip6_tunnel: use generic for_each_ip_tunnel_rcu
 macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552662529.3337768.15440650984728375871.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:50:25 +0000
References: <20260403084619.4107978-1-yuehaibing@huawei.com>
In-Reply-To: <20260403084619.4107978-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-275822-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 36EB13A8D2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 3 Apr 2026 16:46:19 +0800 you wrote:
> Remove the locally defined for_each_ip6_tunnel_rcu macro and use
> the generic for_each_ip_tunnel_rcu from linux/if_tunnel.h instead.
> 
> This eliminates code duplication and ensures consistency across
> the kernel tunnel implementations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] ip6_tunnel: use generic for_each_ip_tunnel_rcu macro
    https://git.kernel.org/netdev/net-next/c/2f60df9e61aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



