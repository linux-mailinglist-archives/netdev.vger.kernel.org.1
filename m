Return-Path: <netdev+bounces-285405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL2MEBC1/Gm0SwAAu9opvQ
	(envelope-from <netdev+bounces-285405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:51:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF66A4EB697
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 17:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F5693015859
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D344CAD4;
	Thu,  7 May 2026 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWFLloY1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ACB3DCD88;
	Thu,  7 May 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169067; cv=none; b=rAD3H7oP9jO1nEOQq5Y0OXa+CkP3rCEl7+MrVllz6KxoOEn1oNYW2IZgyqAU4hvtQ1xe7bsmlviUP7ZMIMAHeLVpsNaViSK67+q1zqooC1o47eH7WtpBV/1pJr2DuMkJ8Tn20hrSNFZVR9ZBW8SoyHR9Xx7LhZu8YUYjnGnGDwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169067; c=relaxed/simple;
	bh=uhsrqHOzky90E/GDDipH5Wy+SbXWe48XToRSzO5ocXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a/Riz7bbTGTnd/TVC8A6tg0rgnx+UEKpI+GwIR6MrYK4Dg/g7S4KBrH2jG06Yr3lWbm/jk/OEK8fbgEL/ts7KKkgoLVTYb04TyYrx6lp+vkCfXiF1RCSl3kkKhH3Emc5Y5mv7htIuhn1Hh5B2iTGtwXF+d1JZSQIRhpARcMbooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWFLloY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EC8C2BCB2;
	Thu,  7 May 2026 15:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169066;
	bh=uhsrqHOzky90E/GDDipH5Wy+SbXWe48XToRSzO5ocXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SWFLloY1hDgLvsbtrLAkKZUk0AANEkyO1ZfSAaYQl8uewJBobEtm/GWWIqnCvuqmX
	 ho2jhhdIpSKU7Gc7gtbNTEfGepPaXtgnanA6rlc53jkLcx+VJwUCtufuFJZzxS0KuF
	 Pf44SrBMwI5cBhRcR+xkihNFpGMoSBkfeNMvaSqaCMESCR6sWjIZkfUMHgvThfe5SF
	 SaLzSEhHXWWjWbRtBloFRr0/OFHB3/mHuv7CNKyyIt36Yoegl5mzC3gxitJn5Zh9Cf
	 kA59oqbNGxfPy2pMWks5lQF+u526+Bv7qgfMAwmfyAeROe6kMksk/VK+wMsiPsRxMQ
	 HsZzvO/s1/CwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CC33930909;
	Thu,  7 May 2026 15:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] net: stmmac: dwmac-nuvoton: fix NULL pointer
 dereference in nvt_set_phy_intf_sel()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177816901553.4048611.3374770303118328705.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 15:50:15 +0000
References: <20260506084614.192894-1-a0987203069@gmail.com>
In-Reply-To: <20260506084614.192894-1-a0987203069@gmail.com>
To: Joey Lu <a0987203069@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: DF66A4EB697
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285405-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 16:46:12 +0800 you wrote:
> This series fixes a NULL pointer dereference bug introduced in the
> initial dwmac-nuvoton glue driver. The struct nvt_priv_data::dev field
> was never initialized after devm_kzalloc(), leaving it NULL. When
> phylink later calls nvt_set_phy_intf_sel() for interface selection,
> the callback dereferences priv->dev via nvt_gmac_get_delay(), triggering
> a NULL pointer dereference.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: stmmac: dwmac-nuvoton: fix NULL pointer dereference in nvt_set_phy_intf_sel()
    https://git.kernel.org/netdev/net/c/dedf6c90386d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



