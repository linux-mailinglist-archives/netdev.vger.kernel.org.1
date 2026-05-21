Return-Path: <netdev+bounces-290335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAXfClXaDmrmCgYAu9opvQ
	(envelope-from <netdev+bounces-290335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:11:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494B5A3039
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD6103048C39
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB6C3803EB;
	Thu, 21 May 2026 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob366cd/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993E37FF42;
	Thu, 21 May 2026 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358204; cv=none; b=iz5OO+lvqkbk2AnfDKbuzo+DnKmahyjATRAgE2GGYTmzIji5RVfnenNXhqGyJn0clo5aSsD6B+MZJBZhH5Lz9IasPzwo7ZYEyMk1m/mSPG279WAe6NnfFQdsQzF/jlQqbVmp/bbT4jgCsRHSt1GsgtyDLTeK2HOmY9QAIbOn2rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358204; c=relaxed/simple;
	bh=SzwV1N9i0PjFIrqoCR+q4IVbBy6lu894V2Z3v9XqPlE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BXg/ID+nJ8SPrkNgamx1ELH9IHT1d6/UXdNPAlXbwyR5kS9vGzQg4XEHtof+W0bBKKuXIirEzAPhnY6IKHdyL8qN0Izf6AZtY7NrOB5IQQ0FZ+P0ER5vh6ZHmCjUdL0nRwtM9WX/b6oci7bjJTbJMF2Belf2N0GY0pOkLlG1uDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob366cd/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89531F000E9;
	Thu, 21 May 2026 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779358202;
	bh=9R8ntL8OnsMLmlQawne1YSDG8cqsU2esjJuzaGlaegg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ob366cd/ws5M953MPJx81mAfB5ttBr/S7oma5nDXTGUIZh+9wF2Nx9Tn9Sq/Zx/Vi
	 3O0TXxK4Qqc4S49k9YhuthjpCrDa+JAeCC8p6Lh6D9UjHPVOOvzTjtw0mwp95+ug9A
	 NB0UxO5YXWAUV3b18v9HzLFg4zwFK4l9nCvlwZadTZeOOphmgkF4nF+/6OggMEfTUF
	 SX20DpLXHBoH8L5+egT6L2op0tyAzgZhhZwTPHlujMGqr0bmMljJg2GTyzcjQSTTTg
	 QSc9NenKbvMNEJNL12cf2j0a9/KIeuYO/AJpVWvlxb+q306wyUKDTpm1+9S/9wOp7d
	 xWHSjtdMR7DsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198143930D21;
	Thu, 21 May 2026 10:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/5] net: stmmac: eic7700: fix delay calculation
 and
 initialization ordering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177935821264.4013498.4647676520552839707.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 10:10:12 +0000
References: <20260518021919.404-1-lizhi2@eswincomputing.com>
In-Reply-To: <20260518021919.404-1-lizhi2@eswincomputing.com>
To: =?utf-8?b?5p2O5b+XIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPg==?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org,eswincomputing.com,einfochips.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20260515];
	NEURAL_SPAM(0.00)[0.819];
	TAGGED_FROM(0.00)[bounces-290335-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,XIDxsaXpoaTJAZXN3aW5jb21wdXRpbmcuY29tPg==?=,dt,kernel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9494B5A3039
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 May 2026 10:19:19 +0800 you wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> v1 -> v2:
>   - Update eswin,eic7700-eth.yaml:
>     - Limit the binding changes to adding optional TXD and RXD delay register
>       offsets in eswin,hsp-sp-csr.
>     - Restore the original enum-based definitions for rx-internal-delay-ps
>       and tx-internal-delay-ps.
>     - Keep rx-internal-delay-ps and tx-internal-delay-ps as required
>       properties.
>     - Restore the original example content, with only the additional optional
>       TXD and RXD delay register offsets.
>     - Restore Acked-by from Conor Dooley for the binding change, which was
>       temporarily omitted in v1 during series restructuring and has been
>       reinstated now that the change is stable and properly isolated.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/5] dt-bindings: ethernet: eswin: add optional TXD and RXD delay register offsets
    https://git.kernel.org/netdev/net/c/c36069c6f46c
  - [net,v2,2/5] net: stmmac: eswin: fix HSP CSR init ordering after clock enable
    https://git.kernel.org/netdev/net/c/23386defe949
  - [net,v2,3/5] net: stmmac: eswin: clear TXD and RXD delay registers during initialization
    https://git.kernel.org/netdev/net/c/6872fb088edc
  - [net,v2,4/5] net: stmmac: eswin: correct RGMII delay granularity to 20 ps
    https://git.kernel.org/netdev/net/c/6ffcef9bc1fc
  - [net,v2,5/5] net: stmmac: eswin: validate RGMII delay values
    https://git.kernel.org/netdev/net/c/c2e152f7ce32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



