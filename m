Return-Path: <netdev+bounces-278246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDwLCFWI3Wk8fQkAu9opvQ
	(envelope-from <netdev+bounces-278246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:20:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA4D3F4671
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9A93032981
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988A12B93;
	Tue, 14 Apr 2026 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLpdZ4F8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F828460
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126034; cv=none; b=Sh4ImmIOjQ6+joEx75TfjfkgA+nEsyHzYJUco5pnC3dEffYrvsc17PQsQmlEwfgJErc2Vn1WyEEnfUXAhsbv9pMVq5jgGZIOc1HcaSloNiPxvcjkqDUw9ZbDpMUi2ADoYJWPJtOckYPL8GgfKpQQ10ji3X/cNKWuEAWH0dNuWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126034; c=relaxed/simple;
	bh=Onxb3IkXi1CkXKJYdmvYXkDz88SpNuG9G8aW4lomnb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W6bnZEqSHjqS36B2t0UUZwWbx5zU9+hopiNyeQ4GQBUkgl2jA4MakADndeWex0p6uZMpFzpe7x4gKVJ8ntQQ+WQao9YFmyg+Bco98hT+cBvLlDmOS/ygwttM2w3rO6mRFYln2jJpVstAa1Kry/qH/BSOq8caO+F0SK0r79M5OgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLpdZ4F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C69C2BCAF;
	Tue, 14 Apr 2026 00:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776126033;
	bh=Onxb3IkXi1CkXKJYdmvYXkDz88SpNuG9G8aW4lomnb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mLpdZ4F8MA8miCjtRlpTD2DspdpdcNAYpOyg9hV4h4LsxZuLRwtXFe0MnhmA5n9Ro
	 btkMtW/2gl4gvOslcKHeIryiylMT0QTo/LaiNTb4jX03OdaqPdg4oRpniTyW0x8I51
	 JjDQnjGUxCNNyyHiEZgnO//lIzIno1z8AI/SthCOQCe/BaEvEvJFEgvVQOajL1y51n
	 hSnyBKZXFsXczsMvmdd3E04Qpvra28rKoyHwb9589/yEnBMzluQxnwfaek7PVQjxHe
	 ebv3rEqj09Oqu1+Z0SSmwbQnDxAc4eGqCTqYbK2xwwp67HSewJZr2v1+1smvneNJNW
	 O4f0ZzLTtNqWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF23809A0B;
	Tue, 14 Apr 2026 00:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Remove PCE_MC_EN_MASK bit in
 REG_FE_PCE_CFG configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177612600505.611791.831863790646439804.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 00:20:05 +0000
References: 
 <20260412-airoha_fe_init_remove_mc_en_bit-v1-1-7b6a5a25a74d@kernel.org>
In-Reply-To: 
 <20260412-airoha_fe_init_remove_mc_en_bit-v1-1-7b6a5a25a74d@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278246-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AA4D3F4671
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Apr 2026 11:56:25 +0200 you wrote:
> PCE_MC_EN_MASK bit in REG_FE_PCE_CFG configuration performed in
> airoha_fe_init() is used to duplicate multicast packets and send a copy
> to the CPU when the traffic is offloaded. This is necessary just if
> it is requested by the user. Disable multicast packets duplication by
> default.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Remove PCE_MC_EN_MASK bit in REG_FE_PCE_CFG configuration
    https://git.kernel.org/netdev/net-next/c/34e1a98ff2a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



