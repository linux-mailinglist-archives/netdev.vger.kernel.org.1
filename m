Return-Path: <netdev+bounces-263036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKLnDLRnpmljPQAAu9opvQ
	(envelope-from <netdev+bounces-263036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:46:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C111E9089
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 05:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1343D309BB6F
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 04:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3218733D6E1;
	Tue,  3 Mar 2026 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2sq5DjJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB739098E;
	Tue,  3 Mar 2026 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513153; cv=none; b=R4tr1JOuXnKX70/4yr24m7IxVhEIH0hpwkDeakWzNI3MluTkFrtCrYozy8Awgsvn1LGg4+6vdPLHrdLyGcqRUjbUwl4Zgna2XEF5ftRhw+2L84uwlOjK3IQR2Yh9dHGrILR1KXp6TC+S53kAaD3CPEE8A2GfRNc6Ngy+/M85cZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513153; c=relaxed/simple;
	bh=SXu6nQGTRy1sufxCv+/mtIMmegShMp6EXYataoEMJ0c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D5khfN/PXqZ4y+Q1Htesdd4MlMMBUaZdWjyfRlWcW2Z7mGjmlseiSs+uYXRrVA52pGrSk0CQqvW0R8L/RGMHlHY6GBwHVB2HA7Up7BxcQFx8QLYKzEbiV15zaLId091yeYsukB8+9Ozr0nfgzC2k8gJcTVh6/2V6zCZ4boJPrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2sq5DjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E021EC116C6;
	Tue,  3 Mar 2026 04:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772513152;
	bh=SXu6nQGTRy1sufxCv+/mtIMmegShMp6EXYataoEMJ0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r2sq5DjJxPdyCOl3nwaYXKxLCLArvLgO+i2PrlGU/Y211IxvNFyjxjswLuvhXgyT5
	 nc5kXuW5WQgd4swSFXFKPRCESFgzZxnKNmCadXbw6Da4dmGNeOW+JrjZzdwFJkl84m
	 qZ6odOns8IvQOsoLhZ1b78zZmD0o/7mXDln7Pt1cVvppcEgn1JSMXssvk5xzJrW30k
	 6AxUsspmGVK54KVzdRasvmY2P9D9Nob0C20caFevi8Fe5CuYuw3GCUjZBIDyVIjLaD
	 PDR4nB7kpmAoaFUsj+RDvzh5fVcjkH0l6q2YVmY5DbD0r0i7y5kPnl1K8bOWK5p5io
	 x7mktrkeTg6sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA07D3809A80;
	Tue,  3 Mar 2026 04:45:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: fix
 rtl8365mb_phy_ocp_write return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177251315330.625663.829890118129778951.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 04:45:53 +0000
References: <20260301-realtek_namiltd_fix1-v1-1-43a6bb707f9c@gmail.com>
In-Reply-To: <20260301-realtek_namiltd_fix1-v1-1-43a6bb707f9c@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 namiltd@yahoo.com
X-Rspamd-Queue-Id: 87C111E9089
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,yahoo.com];
	TAGGED_FROM(0.00)[bounces-263036-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 01 Mar 2026 18:13:14 -0300 you wrote:
> From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> 
> Function rtl8365mb_phy_ocp_write() always returns 0, even when an error
> occurs during register access. This patch fixes the return value to
> propagate the actual error code from regmap operations.
> 
> Link: https://lore.kernel.org/netdev/a2dfde3c-d46f-434b-9d16-1e251e449068@yahoo.com/
> Fixes: 2796728460b8 ("net: dsa: realtek: rtl8365mb: serialize indirect PHY register access")
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: realtek: rtl8365mb: fix rtl8365mb_phy_ocp_write return value
    https://git.kernel.org/netdev/net/c/7cbe98f7bef9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



