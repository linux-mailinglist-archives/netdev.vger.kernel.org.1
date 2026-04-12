Return-Path: <netdev+bounces-277831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFPJEo/G22lHGgkAu9opvQ
	(envelope-from <netdev+bounces-277831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:21:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E622D3E4BD5
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 978AF3008C08
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C309B2F5468;
	Sun, 12 Apr 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d28+mx/i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD71285050;
	Sun, 12 Apr 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776010849; cv=none; b=WtNooH6i/EH2hYV68n8ml1Wp1qp8xREe1m07zcNdFkVKi5mjYinn/QhpcOtebIN1hDDHacZcQe/vpsrSQN1EdBEEZ48f3Gci2DpluvIUc/ieo1R9mb4NIWzzdCwCZPfBfCNmeeXX5AacJdcjoQgr5f3bl+GJvx49wOHR2QJ+2FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776010849; c=relaxed/simple;
	bh=o3yX3doUbqTr19OP49qK7kPb2+WHlGSahr3HV0Cp24k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pxppyrWvTVGWD8694/V5o0ukYslBbfUrE+zZmYLNgg4JXGGgQisJ4aeYHqd+c9T1mvEsJInIbATuMnO9FsZ71DrUR2gL98bofjGurwpeDEdQUVtRo0+rlyBPekWuLahjUowHMuU5u8P6SQ0s4HMPqqJmcSMiBl88mJkh9MwxPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d28+mx/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BFFC19425;
	Sun, 12 Apr 2026 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776010849;
	bh=o3yX3doUbqTr19OP49qK7kPb2+WHlGSahr3HV0Cp24k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d28+mx/is3jy5NgGbNG4VRxDlX5iXgnwTjg/ObjhlRUi0KAWxusu+F3ZI5wgJgMYq
	 cZ3BYLsZX/kB3mP9hpUGZxSCYvAQXwmCpgAcl62bX0En/Pu5wEQbgm5VhSqJdapv/P
	 dfgVYF59Qp8cNvLh+Dth346UcUCUwmFdQg55JdLY6E5tew/5eataM1EJBYRQn3DSIc
	 RX4lbPYUh+p/I1nlqffqbqzhjcfu9mmS8rNiFKuxlcGagtHRbO3X5pL280uTLopzAK
	 L57tazxz6HmUXl7ywcD2njL20ktl76FMydRqMohvsWw+qD0KFR3ovL5wzpXBLTkGxT
	 bOBTjhNEgcscg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CDE3809A8B;
	Sun, 12 Apr 2026 16:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: Add net_cookie to Dead loop messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601082154.3330556.7800864161685115961.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:20:21 +0000
References: <20260408191056.1036330-1-carges@cloudflare.com>
In-Reply-To: <20260408191056.1036330-1-carges@cloudflare.com>
To: Chris J Arges <carges@cloudflare.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 kernel-team@cloudflare.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-277831-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E622D3E4BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 14:10:47 -0500 you wrote:
> Network devices can have the same name within different network namespaces.
> To help distinguish these devices, add the net_cookie value which can be
> used to identify the netns.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
> v2: rebased on net-next
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: Add net_cookie to Dead loop messages
    https://git.kernel.org/netdev/net-next/c/b258cba1e05d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



