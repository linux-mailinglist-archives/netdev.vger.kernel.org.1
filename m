Return-Path: <netdev+bounces-301350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hp3cBHNsOmrk8gcAu9opvQ
	(envelope-from <netdev+bounces-301350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:22:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CF36B6A8D
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:22:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="UZ LnO+m";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301350-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301350-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43C25303BB85
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CADC3BE156;
	Tue, 23 Jun 2026 11:22:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55D35201B;
	Tue, 23 Jun 2026 11:22:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213742; cv=none; b=NSnCwXdCH27yB2KPp3fZb6udKNzRzttofxjXSV2XK1wDJxh+qLEbcG5TMTYneNAYnRzXNwONOEyLRyuCTMzroLAeBf2sowR/8qrBAKuVeNV5T3e7XfN171ZkM+Pw4rXJul4W3J/pn2ucD93eAfQhHNbNxWIYyGGQvsykp+Hmv/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213742; c=relaxed/simple;
	bh=Ac0PCETedxkC44FI7n46efIbI3KVwGVQr5l+d/rR0tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otghejjaBK+iHemlPfytFpdodBLfs0q5fxhY+jkGnZHGu0XMFKHFvKljbPJr3dtFVAvDyBVcJI7kwj/q/+aJDSjaw3ioh0RxMl98RhRhF90cOI5axA+2/bHYzcGcq2T97rKxUvsmE34fbZfeeK4y+XQksKHgzgUlxzzEouQviPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UZLnO+mW; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/Vj+0Lwkf/zlKrbtC5fB9KE6Lv4N7rFR6YHiUjsKwLw=; b=UZ
	LnO+mWceivMlB1WzCEMpPFlRnUTntCzhikWATdpVSn203GxNaaWF1gpafHeORw2bfxnnIq6ysywcW
	VAeheLXNM+UK79rtFOaa5Q9OGQbUYgTx2KjiCj+ET+PL2GfisVm+eBwCyBX2Hrd/NFOFP8Nchcwq5
	s5I5PKAljwbRS1k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbzCk-008wag-MA; Tue, 23 Jun 2026 13:22:10 +0200
Date: Tue, 23 Jun 2026 13:22:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?6LW16YeR5piO?= <zhaojinming@uniontech.com>
Cc: horms <horms@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>,
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
	kuba <kuba@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	"madalin.bucur" <madalin.bucur@nxp.com>,
	netdev <netdev@vger.kernel.org>, pabeni <pabeni@redhat.com>,
	"sean.anderson" <sean.anderson@linux.dev>
Subject: Re: [PATCH v2 2/2] net: fman: use devm_kzalloc() for fman and rely
 on devres
Message-ID: <f0a6fd09-2fab-4bb4-85ae-82f8d383452c@lunn.ch>
References: <20260619121328.922138-3-horms@kernel.org>
 <20260622090505.2418478-1-zhaojinming@uniontech.com>
 <20260622090505.2418478-2-zhaojinming@uniontech.com>
 <4692dda4-657a-4c00-9e65-cff4b79d19be@lunn.ch>
 <823580887DE24145+2026062314162397367012@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <823580887DE24145+2026062314162397367012@uniontech.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-301350-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:zhaojinming@uniontech.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:madalin.bucur@nxp.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sean.anderson@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61CF36B6A8D

On Tue, Jun 23, 2026 at 02:16:25PM +0800, 赵金明 wrote:
> Hi Andrew,
> 
> Thank you for pointing me to the netdev maintainer documentation. I have
> read section 1.7.4 and I understand the concern about standalone
> cleanup conversions.
> 
> I would like to clarify the actual motivation behind the
> devm_kzalloc() change. While it may appear to be a simple devm_
> conversion on the surface, it is in fact fixing a use-after-free race
> condition in the IRQF_SHARED error paths. Let me explain the problem
> in detail.

Please make the commit message explain what the fix is, rather then
saying converting to devm_.

But i also hope you also see why we don't like devm_ conversions,
because developers get them wrong like this. And all too often, they
do the conversion without actual hardware to test it with. So it
results in more bugs, not less.

	   Andrew

