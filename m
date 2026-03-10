Return-Path: <netdev+bounces-265872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOtNEHGJr2lvaAIAu9opvQ
	(envelope-from <netdev+bounces-265872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:01:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A922448BE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B663038F57
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B0207A32;
	Tue, 10 Mar 2026 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o77oV0ym"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E11917F1
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111634; cv=none; b=MFgaL+qNSyZoSaR9f1woLlhhx6oAZn1hqJ/LM8hMRWurGl2ENg63tveznykcC26KXx0p18U2RjwTZwcytEXhM/ipVVDQA99M6Tmx2sKDcik7N3hv7lDw1bb0Ugza6pYsysw/wFFq9EULVlRX2ycSVjIcxz4KRvnuEsoii8OodrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111634; c=relaxed/simple;
	bh=VSUwhH1hBaKFIVPCypOuL5S0XwPeD6ulUIg5BptrmTY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YtWKDNK4Lujoir8Qu3xUM4tk+5s6RLL4w/D1Pxg3umPKtntTFJefLPknNwxfODEAKjh4AmakeMJ0R0kC0eiZkpz2ABneon2iLw+6KyBo23ZyzlCJQmQ4slFSAEjZby1UQnnaFUjqwlggH1F1sRLnyyB/zjFoVO3iY4pSFlp4VRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o77oV0ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8ACC4CEF7;
	Tue, 10 Mar 2026 03:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111633;
	bh=VSUwhH1hBaKFIVPCypOuL5S0XwPeD6ulUIg5BptrmTY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o77oV0ymMg+21gSWAkR87WeRBhwiJ/7/X8c2th1iD+dFlZDLIxO/IdXrkH6lq9Hjd
	 iHpB5SbgYakQamGuuniPiWR/3JZlics7y5aSu0t1t1e7lKbRjQXWR6eZI4bPy04KbW
	 IMErCtQ5vFWEzPHQDIocgV4DuUD19dOyTEQWGopoMWeW3uSUqKcNP2j0J2IIl8n6OD
	 +0a9Fd9s9XuSKeggxClMesNq0YCaa40BhvtLBBsv3Av3WVDVudomod8PcOgvm5tB/A
	 CN9zRxf1aBTHmhcuTRs8ImerDRakiOJJlbHALTT2ZssXpc8xVwDpv7sBkb7Sx5T9gU
	 QeRe2eXIuXFlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D8E3808200;
	Tue, 10 Mar 2026 03:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: remove stmmac_dwmac4_get_mac_addr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311163054.2039470.4262235716273124396.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:30 +0000
References: <E1vypJM-0000000CSiJ-48yO@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vypJM-0000000CSiJ-48yO@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Queue-Id: 92A922448BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-265872-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 07 Mar 2026 10:55:08 +0000 you wrote:
> stmmac_dwmac4_get_mac_addr() is identical to stmmac_get_mac_addr().
> Remove stmmac_dwmac4_get_mac_addr() to avoid this code duplication.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c  |  4 ++--
>  .../net/ethernet/stmicro/stmmac/dwmac4_lib.c   | 18 ------------------
>  2 files changed, 2 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [net-next] net: stmmac: remove stmmac_dwmac4_get_mac_addr()
    https://git.kernel.org/netdev/net-next/c/c127d4087930

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



