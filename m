Return-Path: <netdev+bounces-254993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJtGJL0cfGmAKgIAu9opvQ
	(envelope-from <netdev+bounces-254993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:51:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F30B695A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD3BA3036EA3
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E4E338F45;
	Fri, 30 Jan 2026 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e69iaom0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB72E6CBF
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741443; cv=none; b=WcjuqqwAv5O1DT7M6mujjaeGCieqaiwHNJIi8N6Rz6HBFroTtU7leiqdz89xTtOrMFkPeRy1NFNMOcTqaXGqppHRjpPcPH6/GQtZXIuqe88ngmwgXQKadfZahA9F70u7b5wg1CE4jn6HG0ikb3Pmsrn3mAudQF/2lCrcD/SDbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741443; c=relaxed/simple;
	bh=DDD2HhaWU8hgGNcvsxgeR8SKHG9Tsx5ygB6TGhAYZ04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SZK90IbbhdJyciVVrsRDYgwqU/VLsjK312pYgsmVPLTF3oeJaFZgC+DAAW+P/tNGbBN2K18XtJ10Lfjy15RLEkB3uNLYZVCo4PDnqnzAsHdNq6qRLwHSdkww88ILZ0Z+cE88p0ef3kwRBhJfOm4dZIy8kp+h+Gyze7chJOXlcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e69iaom0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD91C19421;
	Fri, 30 Jan 2026 02:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741442;
	bh=DDD2HhaWU8hgGNcvsxgeR8SKHG9Tsx5ygB6TGhAYZ04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e69iaom0KVVwNSrLlbLpYVy3WJJtrfzlkmiBdfoFdUpZCoO4RgyJ1CkGIaJ/Ik1CY
	 b0Q129iqFKEDsJANqfrCLO1TS5owegvwSOQbLrEjpl8P6lpUpUQlSX0/8nY76rctyO
	 2wOH8tTmpiilNk3ZvG6GtOTo7VMPqGUXf+xaItER3DuzLXhfu7xi0LFce0PCDT9lCu
	 I9zVRAn6eMazlpssdqX66pNZq82Ks1jPd5r0QkNMzUQOeAlqOA2eX/Sq9YkcAxcL6Z
	 5pSpPpwf+4IwzZr2nT+VcBVx5KIYPf982ywliNkwJ6SssAP18bCFtmfhfGlG50hRCr
	 Ut+9fOZNRNCkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D1E380CEE0;
	Fri, 30 Jan 2026 02:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: stmmac: report active phy interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974143534.3149010.10116225722696356568.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:35 +0000
References: <aXnpTy6XckPGcmg0@shell.armlinux.org.uk>
In-Reply-To: <aXnpTy6XckPGcmg0@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, fustini@kernel.org, edumazet@google.com,
 wefu@redhat.com, guoren@kernel.org, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254993-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12F30B695A
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 10:47:43 +0000 you wrote:
> The original patch needs dwmac-thead fixed so the PHY_INTF* definitions
> do not clash.
> 
>  drivers/net/ethernet/stmicro/stmmac/common.h       |  6 +++
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 10 ++---
>  .../net/ethernet/stmicro/stmmac/dwmac1000_dma.c    |  2 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c   |  2 +
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  1 +
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 52 ++++++++++++++++++++++
>  7 files changed, 69 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next,1/2] net: stmmac: thead: avoid conflicts with PHY_INTF_* definitions
    https://git.kernel.org/netdev/net-next/c/88afa0dd655c
  - [net-next,2/2] net: stmmac: report active PHY interface
    https://git.kernel.org/netdev/net-next/c/d9009f72ed88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



