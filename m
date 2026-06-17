Return-Path: <netdev+bounces-300155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B5T0NymOMmoi2AUAu9opvQ
	(envelope-from <netdev+bounces-300155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:08:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4C4699821
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:08:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MMQQMtNr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300155-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300155-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89A5530CD04F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088BB3EC2E3;
	Wed, 17 Jun 2026 11:58:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A4368D42
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 11:58:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697520; cv=none; b=WPD3U4WXEY5jNdDZdUpCe7cs4tWR5JyoIyRfe2JjB1l8O+RjiuKdZU+aL0OC69ja0+dU/ec4aa2y/ruf+PhgNasSahwMplbkjA4V+q4wAlZpSNRgRkiCzTsaad6TgreOU8iBFL+wCoyqLYCQcjAmwoxVc5Xw8Bf8ep/LEMp9ciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697520; c=relaxed/simple;
	bh=KIgOs6UkCN406q5DVhqVal/lzCFztBm66NCLYkc8O3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtB7O8MKpdNAEXZyJ1t3xzTxiagZlOOeSBqjGe0gb201NcE8XvWM73hbbDp2zpLCu7T3Ny/+z/Slw8s1M8EvbeH0O3CYU8xW/tW5ty/ik6dqinS5tGzgw1Y2Cdn7AgdSdZLUlg8ua7QlQlFNELBk81oE3vu8PTfujtNbhKfRtMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMQQMtNr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988E01F00A3A;
	Wed, 17 Jun 2026 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781697519;
	bh=Ue1W0Tug6wA7pToRtgxP1pmUK47ZJOig2n9QSFPHO2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MMQQMtNrtCsVmvZLdUNb60STpwfD6xl254UWzJS5WS+xVTb/YigQYySUGLxgseWx8
	 4UIhreRrJBJb+hqaNYds92o6D7edwWugeM7T5rRCraoJ9LU5VwvvNroDpQvdLetoS8
	 BF7skDtroIUymKM5W7ifEQxX2+Sdt7TDkOTyn8TTq7nB1Agos28k5NIdliF4kGbw6H
	 6SiJdvFyRnWobyx3enAU3eUBNTDJlRHAxCenXYb4gfML+Bmq0WrYMzEC20O6hzf2RY
	 5/fTLPsHeuxEoF0TV/0nb+ASNWnVnTso7RSdGFHrNvkHrfdnxz9qvN6cyR97BMwXpA
	 +qwwV82IRjbIA==
Date: Wed, 17 Jun 2026 14:58:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wayen Yan <win847@gmail.com>, netdev@vger.kernel.org,
	lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: airoha: Fix MODULE_LICENSE to match SPDX
 GPL-2.0-only identifier
Message-ID: <20260617115834.GX327369@unreal>
References: <6a2ded59.63d39acb.391892.7632@mx.google.com>
 <178156440888.329386.11011872053824456703.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178156440888.329386.11011872053824456703.git-patchwork-notify@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:win847@gmail.com,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300155-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,redhat.com,google.com,lunn.ch,collabora.com,lists.infradead.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B4C4699821

On Mon, Jun 15, 2026 at 11:00:08PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
> 
> On Sun, 14 Jun 2026 07:52:39 +0800 you wrote:
> > Both airoha_eth.c and airoha_npu.c declare SPDX-License-Identifier:
> > GPL-2.0-only but use MODULE_LICENSE("GPL"), which the kernel module
> > loader interprets as GPL-2.0+ (any GPL version). This mismatch causes
> > license compliance tools (FOSSology, ScanCode, etc.) to misidentify
> > the effective license as more permissive than intended.
> > 
> > Replace MODULE_LICENSE("GPL") with MODULE_LICENSE("GPL v2") to
> > align with the GPL-2.0-only SPDX identifier. Per include/linux/module.h,
> > "GPL v2" maps to GPL-2.0-only, matching the source files' declared
> > license.
> > 
> > [...]
> 
> Here is the summary with links:
>   - net: airoha: Fix MODULE_LICENSE to match SPDX GPL-2.0-only identifier
>     https://git.kernel.org/netdev/net-next/c/b0d62ed16424

Jakub,

This patch doesn't fix anything. License rules are pretty clear.

Documentation/process/license-rules.rst
  444     "GPL"                         Module is licensed under GPL version 2. This
  445                                   does not express any distinction between
  446                                   GPL-2.0-only or GPL-2.0-or-later. The exact
  447                                   license information can only be determined
  448                                   via the license information in the
  449                                   corresponding source files.
  450
  451     "GPL v2"                      Same as "GPL". It exists for historic
  452                                   reasons.

> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
> 
> 

