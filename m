Return-Path: <netdev+bounces-267286-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL+JGst7s2lmXAAAu9opvQ
	(envelope-from <netdev+bounces-267286-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:51:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2A927CEE8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6AF93044DDA
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD8C34D90F;
	Fri, 13 Mar 2026 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNYJwT7Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CC34C989;
	Fri, 13 Mar 2026 02:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370228; cv=none; b=rb4ban1I4uMWHS09SMNLK74xvU+6IocDHk2hna6kc4CPztc7kjOFj2rI21wKwQm2WrW+Ru5mOY3o96bABXH0KxQS34HOpVTyNiQEWMxZWO3sHGxvztZosEeamcBD9sRuh9zytZiFzFVmlP5OT0pLMP9b/TXShp1+LwlXyPpipuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370228; c=relaxed/simple;
	bh=3etnwP+P9OA+vYCo+MXEVJWERSIkqq39Vhbz8gzvifI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q+DTQPhufTeiogv4svU6YgTU9srgLR26Vkjooi/7ovUxdnX3krkeg8IjRFi9dMs9HxMA6xF0jB0AQLQck0ALUnS+8HryafMUgac1cWRR7XXT76WmezZg9CqPxFe0ezjgppRSYy+W4gN0whHYi6mODnrpILmPFW7at38Q0cJqi6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNYJwT7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D387AC4CEF7;
	Fri, 13 Mar 2026 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773370227;
	bh=3etnwP+P9OA+vYCo+MXEVJWERSIkqq39Vhbz8gzvifI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SNYJwT7YabrwmLI4Q+PQtxLb852l2fx0u8WXKUjucZlAA9a67oI2GSQp+hPiJifaG
	 Gdxtc+o/v0vnKSZ/KMdbVPRO64qDbiksutMXVa9bCNttCPDhUtlZFysWNBnuKJaCY1
	 fY/R3caGhyw7LayYn1VjXy2Nq7CwqYajIa2IRNTxzUN3Is449zvmjzbF+dJqu01brI
	 qMwA2WgmgN8jxH/Ud/P9dFALyqnjyzH5uDaB/u/J5yvb+4dIH+XKbNb//yqRkF8iPT
	 mCY0E48WnkujtQT+T1h47fqNUqOHUXXuaUsr1a1Gd57BHjTKVWlVMOFbZYGIZLKXQD
	 qzd9QST7+LTHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD0A3808200;
	Fri, 13 Mar 2026 02:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: page_pool: scale alloc cache with PAGE_SIZE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177337022304.648356.2556762129398077891.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 02:50:23 +0000
References: <20260309081301.103152-1-noren@nvidia.com>
In-Reply-To: <20260309081301.103152-1-noren@nvidia.com>
To: Nimrod Oren <noren@nvidia.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, tariqt@nvidia.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267286-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C2A927CEE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Mar 2026 10:13:01 +0200 you wrote:
> The current page_pool alloc-cache size and refill values were chosen to
> match the NAPI budget and to leave headroom for XDP_DROP recycling.
> These fixed values do not scale well with large pages,
> as they significantly increase a given page_pool's memory footprint.
> 
> Scale these values to better balance memory footprint across page sizes,
> while keeping behavior on 4KB-page systems unchanged.
> 
> [...]

Here is the summary with links:
  - [net-next] net: page_pool: scale alloc cache with PAGE_SIZE
    https://git.kernel.org/netdev/net-next/c/15abbe7c8266

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



