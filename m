Return-Path: <netdev+bounces-264138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJYPGanoqGmfygAAu9opvQ
	(envelope-from <netdev+bounces-264138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:21:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9020A28F
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 03:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7E6A3081079
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5AA258EF3;
	Thu,  5 Mar 2026 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4p57Brw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FF2586C2;
	Thu,  5 Mar 2026 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677208; cv=none; b=evTigtWFVylPYTTZLLzNszQTI6wGTi9D1sppxPARob5/CCMVPkjkmlBiZx6K7xxWWtIa7gEYo3R0g0BfuuttBiW7HnQGlr+l1uJgWppMK0Q4NRH5mxfjUDvWrQQ68cfWm3nVW+5Q3Yez0E+mfHG3+fpTPaz2DXxe/QE7PXKvLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677208; c=relaxed/simple;
	bh=BzoKdMVCbDdDqXoyDrBTGCacS947I3PSFMkElorbNXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q0oMCT7v5vgl3fqnBkgptXGsMMZ9q41iopHEFYEuzrdCyyV056dNjTBA3/wHiOjgP1FYHgJsqwpnqFXarvE1Y5sTN0nkJfkIyb+3yPe9o3B1Uwb3o5eWvKbYuaO7PegXUp02Ug8v7XYzjusb9QrU/qL/dclwUWVBN9PrO36TKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4p57Brw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4601C4CEF7;
	Thu,  5 Mar 2026 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772677207;
	bh=BzoKdMVCbDdDqXoyDrBTGCacS947I3PSFMkElorbNXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N4p57Brwf1nuUde/4PL3cJS/43POze9mEIv+MOTEB2wGzirf7+mPeVJj9uE/L9N8j
	 06u/jyt9xKaiVEV23dhc3eExKnxJt0ret85hw2riDvEYw9SF7GS1rLl7SDPpmClqlK
	 BvPeQsqZrrImpPgsGpVrJiSve7WeDHiAztoXMdUyR9fkkGTvXCSf0xso+6zTqIZpNF
	 iqbu43600nqz+VoAAPqlntO/Fef0mJiamKkPDgaf3YKOGAZ7K2UP/3/xMGdCdQvS3J
	 b9r6Np3zGaBId202E3e1QAokGqxAOGbNH702VbbmxTbuSPFuf3WZ52gWYyslqem9Cm
	 w0LUa/l3SxFqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD5B3808200;
	Thu,  5 Mar 2026 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: devmem: use READ_ONCE/WRITE_ONCE on
 binding->dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267720804.2482446.3695748884408177955.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:20:08 +0000
References: <20260302-devmem-membar-fix-v2-1-5b33c9cbc28b@meta.com>
In-Reply-To: <20260302-devmem-membar-fix-v2-1-5b33c9cbc28b@meta.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, almasrymina@google.com,
 kaiyuanz@google.com, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bobbyeshleman@meta.com
X-Rspamd-Queue-Id: B9D9020A28F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264138-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 02 Mar 2026 16:32:56 -0800 you wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> binding->dev is protected on the write-side in
> mp_dmabuf_devmem_uninstall() against concurrent writes, but due to the
> concurrent bare reads in net_devmem_get_binding() and
> validate_xmit_unreadable_skb() it should be wrapped in a
> READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations play
> with the underlying register in unforeseen ways.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
    https://git.kernel.org/netdev/net/c/40bf00ec2ee2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



