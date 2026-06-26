Return-Path: <netdev+bounces-302118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NCj1HII2PmorBgkAu9opvQ
	(envelope-from <netdev+bounces-302118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:21:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D76716CB484
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:21:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=I1oZ5QOx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302118-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302118-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84AB530696F6
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1D3E024D;
	Fri, 26 Jun 2026 08:21:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE453E3D85;
	Fri, 26 Jun 2026 08:21:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462068; cv=none; b=aYiLHFCU/2cTL5wQrCCBQ6DXQJRdkerClhfkGisAl07sQ9Xcy1S8vqElKhpvBmg1gxAJOrNpOkFog7PJp7keyBcsypbNp7pLk7x/pLMCJzInD3+aT1kZBaUlzw2/eIChOsN6qIKOS1Nax3nDcGWpMNHMz88hmBESFCSuU2qQjgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462068; c=relaxed/simple;
	bh=5kE1pnCBJBCYjX/sSFOoER2e+HzmU0vSnDj2AOMYLpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sfz2cQmaSUlqDviPCwoCyI/4Yc7ZAdOQ5zcJ4rxZIa7FwpggMyXEtRkYbiUv5Mr6HhCktXYaPigIC4g+C4pK7weOuptzAEvaIPWCwoHtsNZbyKZuW1Luet7/KI2BnAFlrwhQCySNJVu28d+teELytovNzKhxulSv6ewQZYm/TEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1oZ5QOx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4D91F000E9;
	Fri, 26 Jun 2026 08:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462067;
	bh=SXTJhhnYDtJcOg85zn5GupW5/0aizb+m1OcvfM0R+A0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I1oZ5QOxY+g20S4Yu36z51IzJ7shOeblG7iY93YcqQHu9Fua8r3/JI0KBxagid9Et
	 R3xuHPhHE/xDxwdt8dvmCFGikmWLu6pB91YVQadFds1qoEcePA9k30fy5EJtgZ1GLC
	 tZDO24JzalmLwoz02KlLXOADOETzlai1kZQklOrpLHROu01alHzYskoLb/ZKFOYkvc
	 3VmZ3ye6SCmQ8BBKtodt9pWqt/a/RkpwgyOOpTIInGTAylbLJ2r2dT2i4AIVaVWYd8
	 MkfWWxutSp8me/PVjgWbGDpHdNz50PQ6tR5p8Wosacy69D7/O2ge6SXtuJXr39uNMZ
	 6klqQRKcF/qbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5688A39389E8;
	Fri, 26 Jun 2026 08:20:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/5] arch: select HAVE_ARCH_BITREVERSE conditionally on
 BITREVERSE
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246205401.3816447.633082126458104033.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:20:54 +0000
References: <20260506175207.110893-2-ynorov@nvidia.com>
In-Reply-To: <20260506175207.110893-2-ynorov@nvidia.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, arnd@arndb.de, ebiggers@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, akpm@linux-foundation.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, ruanjinjie@huawei.com,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,gmail.com,rasmusvillemoes.dk,arndb.de,lunn.ch,davemloft.net,google.com,redhat.com,linux-foundation.org,iogearbox.net,fomichev.me,huawei.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302118-lists,netdev=lfdr.de,linux-riscv];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ynorov@nvidia.com,m:linux-riscv@lists.infradead.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:arnd@arndb.de,m:ebiggers@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:akpm@linux-foundation.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ruanjinjie@huawei.com,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:yurynorov@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D76716CB484

Hello:

This series was applied to riscv/linux.git (fixes)
by Yury Norov <ynorov@nvidia.com>:

On Wed,  6 May 2026 13:52:02 -0400 you wrote:
> Architectures may have bit reversal instructions, but if the API not
> needed, the corresponding option should not be selected because it may
> lead to generating the unneeded code.
> 
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  arch/arm/Kconfig       | 2 +-
>  arch/arm64/Kconfig     | 2 +-
>  arch/loongarch/Kconfig | 2 +-
>  arch/mips/Kconfig      | 2 +-
>  lib/Kconfig            | 1 +
>  5 files changed, 5 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [v2,1/5] arch: select HAVE_ARCH_BITREVERSE conditionally on BITREVERSE
    https://git.kernel.org/riscv/c/42d9c75e8b9c
  - [v2,2/5] lib/bitrev: Introduce GENERIC_BITREVERSE
    https://git.kernel.org/riscv/c/00751d655ece
  - [v2,3/5] bitops: Define generic___bitrev8/16/32 for reuse
    https://git.kernel.org/riscv/c/83aede8131af
  - [v2,4/5] arch/riscv: Add bitrev.h file to support rev8 and brev8
    https://git.kernel.org/riscv/c/e8620bd7e5e0
  - [v2,5/5] MAINTAINERS: BITOPS: include bitrev.[ch]
    https://git.kernel.org/riscv/c/7b2c5b4e43aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



