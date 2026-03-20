Return-Path: <netdev+bounces-269731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHrhBTSVvGmE0wIAu9opvQ
	(envelope-from <netdev+bounces-269731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:30:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2F2D4743
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E40D306A524
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A519C20010A;
	Fri, 20 Mar 2026 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddiSyLJn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827EC1F30A9
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773966627; cv=none; b=LU6EJPXlIYi4SH55JSd/f0Hc60O13pgjzKhZ2RDVjmG3EFIhvPGs1iNQjDd6FuUWd0ULpDScSzDNq6wAb22L4PcwqUX6dqjDNv0CALCtIK8yfVbV6ApB8qo6iRJOK3TepYu5NTvjVVkAhdqSqkW8CGvadQSxsaKtmZHj2pAtfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773966627; c=relaxed/simple;
	bh=e00VxEjfVLHb2cCGEacgmrXQHfHXzKuxaGfyE9rbWAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XoT52/4As9IUL8t1973U313Yt1pz2Wg6VIH84A4r6g+7i/GJPZPNLNADmd7tqSOUSNiygpyHs808mIf3GkHFuP745J/QBiOs8lyYyKvug/7F+RbIMHm4ohM6jnCTTbFOetOuQbntxPqV+iRfhPLBt7IFWu3GIMu+4YuH20PmJvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddiSyLJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176A8C19424;
	Fri, 20 Mar 2026 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773966627;
	bh=e00VxEjfVLHb2cCGEacgmrXQHfHXzKuxaGfyE9rbWAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ddiSyLJn/161inpllbDVZpBtaV3o7frFGCIuu8taIPumvJfxkZQMTuAv62oRuAywm
	 DebB73JLuYuB5TumObxCIOcfSy8yD0kVCzgrRFqYBwz9o4xhHNDIqTGQPkvg51++Ht
	 ieXj3bT8VoNTwwLJ/wA/hVes/F/kbUYheRDKKkbaUkGbxFnvDcyyYDIfufoTeh3g+R
	 Mgwf2Eta3Brk6/F972blvl4qZv1z5O/AFfnLjZqKuJ9tNn8H0+eVNqug2fdgGpySyP
	 vi/ZOpa7gEdGdtFjzLQgw4g1ErwTOf0a2R0L7v07VRK5wnsgdbL6ynmY0j0eAEXunE
	 Vml8NhhcvmCUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E8A39302F6;
	Fri, 20 Mar 2026 00:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: stmmac: descriptor cleanups part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396661753.1861152.5017426942573909830.git-patchwork-notify@kernel.org>
Date: Fri, 20 Mar 2026 00:30:17 +0000
References: <abruRQpjLyMkoUEP@shell.armlinux.org.uk>
In-Reply-To: <abruRQpjLyMkoUEP@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
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
	TAGGED_FROM(0.00)[bounces-269731-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64A2F2D4743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 18:26:13 +0000 you wrote:
> Part 2 of the stmmac descriptor cleanups.
> 
> - rename "priv->mode" to be more descriptive, and do the same in
>   function arguments.
> - simplify descriptor allocation/initialisation/freeing
> - use more descriptive local variable names in stmmac_xmit()
> - STMMAC_GET_ENTRY() doesn't get an entry, it moves to the next one.
>   Describe this in the macro name.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: stmmac: rename "mode" to "descriptor_mode"
    https://git.kernel.org/netdev/net-next/c/1939749ce92d
  - [net-next,2/5] net: stmmac: more mode -> descriptor_mode renames
    https://git.kernel.org/netdev/net-next/c/33be7846e4be
  - [net-next,3/5] net: stmmac: simplify DMA descriptor allocation/init/freeing
    https://git.kernel.org/netdev/net-next/c/e73b19baa3b1
  - [net-next,4/5] net: stmmac: use more descriptive names in stmmac_xmit()
    https://git.kernel.org/netdev/net-next/c/b4df951549dd
  - [net-next,5/5] net: stmmac: rename STMMAC_GET_ENTRY() -> STMMAC_NEXT_ENTRY()
    https://git.kernel.org/netdev/net-next/c/6b4286e05508

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



