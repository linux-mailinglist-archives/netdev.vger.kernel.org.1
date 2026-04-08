Return-Path: <netdev+bounces-276263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONNRB/jL1Wl9+AcAu9opvQ
	(envelope-from <netdev+bounces-276263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8AD3B696B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE53330414A1
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E903451C1;
	Wed,  8 Apr 2026 03:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFNpSNYJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D783451A6;
	Wed,  8 Apr 2026 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775619034; cv=none; b=bytijNJBgL9sjlFxfJIark3fIV2UPc3lrcns9fGItsL+8/975aKX3zrPh/tVyLVNhr5vQlIThakS7MClZaKVudgpuCSDzIABtVglvzUg6oaNKjUZPybWt1Pn00CEECvDmEIEULxJbCz0akM5J5DYZOCjoacHgvkWqDRIuSlu+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775619034; c=relaxed/simple;
	bh=EfbWhKyj39ugZgWeF5Iy4d02+QbPOZ5X1hUh+gRlYOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y3fSHsbdnURD7WEmyegZAEc2DIDJv5Yi6AcOnkUG4YWbF7ln+7Si8Rx3ok+qyyTSBZsltgm9B2WxliMIbUu7T5eCKlWcDH4PmbKYHQr/KxA/skyb7CgP+KbP4ADTtN/iUBLrToco/GqrUI/f/ZShBfI3UkykYgRwvyelnxap0r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFNpSNYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F13C19424;
	Wed,  8 Apr 2026 03:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775619033;
	bh=EfbWhKyj39ugZgWeF5Iy4d02+QbPOZ5X1hUh+gRlYOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JFNpSNYJ2Hos2w1luuQSlFW4NOm/jpOHU7yR4Hko/YCzbpaICLS6tgk8xSIy0A4Yj
	 1GI2Gn+Qizojx6NrrMkpjPLEc6VnoZJWGbFjZcOOzPWn64xHHYRKsnZv3lqtNEV1bi
	 6FQfn3aDMPN+nk4LhueRu52j39aTjxDqkM7At3QB7+PHOMHX/z6nv2/pxjVEWCHNUD
	 AibGxjY28rirMAVur1LQhrTAeRc+fKxhzcXSrQBDHsbY5Wk5Far+jhKoKwrA/++Jtq
	 ks+xo9VOBsDxN+ajIbo5MjVyDGslPmtyltZXMOS3e/b2UUqbnWvrh/m6HnZWKXEQd0
	 O2MnJWNpa+l2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDD83809A29;
	Wed,  8 Apr 2026 03:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: bridge_vlan_mcast: wait for h1 before
 querier check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561901079.56280.10564875913231407708.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 03:30:10 +0000
References: 
 <c830f130860fd2efae08bfb9e5b25fd028e58ce5.1775424423.git.daniel@makrotopia.org>
In-Reply-To: 
 <c830f130860fd2efae08bfb9e5b25fd028e58ce5.1775424423.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, razor@blackwall.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, john@phrozen.org,
 alexander.sverdlin@siemens.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276263-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9A8AD3B696B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 5 Apr 2026 22:29:19 +0100 you wrote:
> The querier-interval test adds h1 (currently a slave of the VRF created
> by simple_if_init) to a temporary bridge br1 acting as an outside IGMP
> querier. The kernel VRF driver (drivers/net/vrf.c) calls cycle_netdev()
> on every slave add and remove, toggling the interface admin-down then up.
> Phylink takes the PHY down during the admin-down half of that cycle.
> Since h1 and swp1 are cable-connected, swp1 also loses its link may need
> several seconds to re-negotiate.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: bridge_vlan_mcast: wait for h1 before querier check
    https://git.kernel.org/netdev/net/c/efaa71faf212

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



