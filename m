Return-Path: <netdev+bounces-256295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNKgMDD5gWk7NQMAu9opvQ
	(envelope-from <netdev+bounces-256295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:33:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E6D9E99
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 14:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22D4B3059818
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE5338E5C5;
	Tue,  3 Feb 2026 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hn35khLI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDF17A31E;
	Tue,  3 Feb 2026 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125573; cv=none; b=oCes1obbPCZcU4U1BhSfBq873P/fNBX3cAgallmjCOrILqQ9X/lcqGNpaJ0Efqzkqt6MbNxcVOp/rhjvNlOcsWOWiC23R3c3y/nn9rijLmtSQ/xA52BTKAnq35VoNPI/HN89UkGyG20tGD0a7+clrssQ5lvaUqRFH2QEj/+srTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125573; c=relaxed/simple;
	bh=qm4YUTuDw+jWrgfNNkyliipxvN94JoXrfQZAS3LoZec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOU3knruEz1MfCpQpiR/W0uFv4+f9LIWkdUpVzlk9pzguBX21PAqBDuR/LmE0GvMRCO6bhx60cNt3WgOpBZYep3e4V5zZneBJ0Yc56WTy0bl+I0S+dzdg5ZTJk4gl1QrcVKJnMiCtTpkZDmSjuhc4ORbPR8eebBPoDwaNAQn4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hn35khLI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SWGKlBRXsvslJKCJ791DxTaky6mRbtocoIFvmRiqDpg=; b=hn35khLI9F+pQXZndNVLk9eWGu
	e5pdDrsNjn9640vLGnMmqtEN7pXRuPz7UuKOZVZ5F50nJ6Vfu/ONU0pb1BLR52+DJDct1m9VTZC3p
	AO4CTi/+XgjtGceZY6FNAS8lBwAdPdeRQ3iaDfeziTQUN4Le+n+LTZDHrkTNyomjqNus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vnGW2-005wva-Bx; Tue, 03 Feb 2026 14:32:26 +0100
Date: Tue, 3 Feb 2026 14:32:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukasz.majewski@mailbox.org>
Cc: Jakub Kicinski <kuba@kernel.org>, shawnguo@kernel.org,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	edumazet@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, conor+dt@kernel.org,
	horms@kernel.org, richardcochran@gmail.com, robh@kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, wahrenst@gmx.net,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: Re: [net-next,v22,4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <3632215c-24cc-42a3-b565-c2e48be5bdf7@lunn.ch>
References: <20260131233459.1625279-5-lukasz.majewski@mailbox.org>
 <20260203014247.824561-2-kuba@kernel.org>
 <20260203110341.1ce21455@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203110341.1ce21455@wsk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256295-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lists.linux.dev,lists.infradead.org,gmx.net,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: 2A9E6D9E99
X-Rspamd-Action: no action

> > jakub: maybe add a TODO comment transiently here, since later patch
> > implements the cleanup?
> 
> The mtip_switch_tx() is empty as we have agreed, that I will divide
> this driver to several patches to ease the review.
> 
> Adding TODO seems to only make AI review happy, as:
> 
> - The patch which adds support for FEC_MTIP_L2SW in Kconfig will be
>   sent after the driver is accepted to net-next
> 
> - Those commits are even now bisectable when FEC_MTIP_L2SW is
>   enabled (when I test the setup).
> 
> Anyway, if you still would like to have the TODO comment, then please
> give me a hint how it shall be written to make the AI happy...

I would not make too much effort in keeping the AI happy, for
something we understand is transient. It is currently not a gate for
acceptance.

> And maybe a few my thoughts:
> 
> 1. AI review seems to bring each time different issues - even the
> "grammatic" ones were not provided with the first AI generated review.

The rules are being tweaked as we gain experience with it, so i would
not expect it to produce the same output every time. Even if it was
stable, it is not clear to me if it is reproducible.
 
> 2. I have tried to setup claudie> to run the patch set through it -
> however, it requires a paid account on a cloud/AI vendor (and I guess
> that different vendors' AI engines produce different output for the same
> "AI prompt")?

I expect so. It is clearly not checkpatch.pl and the like were you can
run it 100 times and get the same answer every time. But i think that
is understood. So long as there has been a discussion about its
output, patches should get merged even if there are still AI
comments. It is just another tool used in the review conversations.

	Andrew

