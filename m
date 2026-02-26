Return-Path: <netdev+bounces-261161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ILBHG28n2ktdgQAu9opvQ
	(envelope-from <netdev+bounces-261161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:22:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D65D31A0792
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D79E3305F644
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4126C3A2;
	Thu, 26 Feb 2026 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR7dRM2l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755E19AD8B
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076017; cv=none; b=njglZOGCePAOHszR1dFRl73awu7Z8Gp6wd5C+sDRaNchboeJrQmZS0OJ7swW1dvMyiJPXFcg0bGxyz5GCIJKowqhZk3Yr9YLj9R+AXGlHD0WNavi2ExMr+ocj+PhOxg0sawyEc5YEbtgmuXXRUduXgIpDgmILzTbxjOG/24m1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076017; c=relaxed/simple;
	bh=2zmgXg8tJ0GzwYGuMnLjz1ZeoPrFhYj5IT1BMlHijNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pwpXLDfx1UUtyJlzdozKzmIW3+7kusCTHBsLswWLnz6fSiNIuzXjeYuh1okCcv1fII+o6H7K8lClx/7dYLw4PMCZIFF6+vU8t/L5AOWCGQVrQ4tt9k+jDusJMNf3+Jx5jslWypUgtRbjG2rc5uAVG8wkfqhXKu+nA3bOrw9hr7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR7dRM2l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B979C116D0;
	Thu, 26 Feb 2026 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772076017;
	bh=2zmgXg8tJ0GzwYGuMnLjz1ZeoPrFhYj5IT1BMlHijNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mR7dRM2laJxdyx6iZmCw4IkMUwjaMrUDPl1CCXLdLrm8zC2sion63uMHd5bIfr1lk
	 iiqyl/oRlv1UXoa1FPMww9Dm+MktLVle0I2Lw1WPR7MgbbDR1QgPzbx1k1ED0PA4h8
	 rmAOVB+0agDoHHyUFRZzMCw06EB+gatJXGKAaNCbyXIIVe93RvtqgOrYZcNcQWoKDL
	 leMoE/3yIecGQ79VBg071sVO3NPmiwdzWkvK9v60kMVinl2WqE1GQEXQNsqMpmaNAB
	 MDjFEHwNuIJHwF6JzNEj6GqLja9aCrQoVuxa08wYZ68Iab0mkAyAvxaZtowR5IUfOj
	 +dYKsaD1J2Ivg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C44380A94B;
	Thu, 26 Feb 2026 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: fix interrupt coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207602178.1018003.6114992445042344713.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:20:21 +0000
References: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
In-Reply-To: <aZ1o2dmfpeiubCik@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261161-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D65D31A0792
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 09:01:13 +0000 you wrote:
> Hi,
> 
> While cleaning up the descriptor handling, I noticed that the accounting
> of transmit "packets" for interrupt coalescing was buggy in that it
> takes the difference of the two indexes into the circular list of
> transmit discriptors and merely subtracts one from the other without
> regard for the indexes wrapping.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: stmmac: use circ_buf helpers for descriptors
    https://git.kernel.org/netdev/net-next/c/819101c3c158
  - [net-next,v2,2/2] net: stmmac: fix transmit interrupt coalescing
    https://git.kernel.org/netdev/net-next/c/dd53a0e85969

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



