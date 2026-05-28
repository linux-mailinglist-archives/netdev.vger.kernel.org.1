Return-Path: <netdev+bounces-292762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rZlgLFFtGGoSkAgAu9opvQ
	(envelope-from <netdev+bounces-292762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:29:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F85F4FD9
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 387D73093A86
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF43352023;
	Thu, 28 May 2026 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bvuYjXjY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0430FF1E
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985017; cv=none; b=BVURtHJ5Vkd6WOKMxd7xtb+o60an4Oo70KUd6w5J8gmWnFjBA6Ue11KnLLcc8u0KlDybIL39yoiaNlRO+KiE0RXTkixXN2YZUxQcS1r6AxoYyBOl/3ZUh8xZhiUUPqoxAxcZi5JfgA1UvP6zrNFW0gH9Er3KRNGI6VYSBB15Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985017; c=relaxed/simple;
	bh=6G0LjKKwhjUZtoHv9YvauGYolfOeJ8y9VbVt0MgtrG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfJJPx7WcR089NRk+6AUmRyLn7jcYKFzIfAmgs06si0/9saez1fHvFKvMLG5UDfrBVZORTuz7ZoMCw7fXHMCtxI8RrA+5bJDY6U1pp3zPujPj8LmkpcFYtJzaxj+hYNupz50fmkgR/e4rwysmvEZg5y32wMQ9tHTkUPWR7UXwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bvuYjXjY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H5tUY8U5PV0fBWFi2GhCyQLhjYvlJikmN9of/I+Ir/k=; b=bvuYjXjYDSOmxiVQheRdIGOzAR
	+2nK8tKOIWKhXRcKcXEM/SJfJMokBcAykT9QRaGktwKTg2XDQvVbSo/ksE/SIFdMNxcvTXhkXiPwB
	lVlYQL2u5/W/74yHGfGqeTkoYpFaPrzSi/RvKM/91GIc7qkk5IxG3epJZsGGZHMZyIcQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSdPh-004vV9-2Q; Thu, 28 May 2026 18:16:53 +0200
Date: Thu, 28 May 2026 18:16:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wade Sparks <wsparks@vulncheck.com>
Cc: netdev@vger.kernel.org, security@kernel.org,
	Disclosures <disclosure@vulncheck.com>
Subject: Re: Unidentified Fragnesia Variant with Public PoC
Message-ID: <73b5b45c-08df-47db-b749-b4b7cd625b3f@lunn.ch>
References: <CAA1v+Sj=THjpUA6m0wX26DVQWMe8=YMZ5HwMo8K8ArjZopCKxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA1v+Sj=THjpUA6m0wX26DVQWMe8=YMZ5HwMo8K8ArjZopCKxg@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-292762-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 014F85F4FD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 11:12:32AM -0400, Wade Sparks wrote:
> Hello netdev team,
> (cc: security@kernel.org)

security@kernel.org is for embargoed reports. You posted this
publicly, so it cannot be embargoed. Please don't waste the time of
the people on security@kernel.org.

> The original Fragnesia patch only addressed the coalesce path, leaving the
> segmentation path independently exploitable. We confirmed the PoC works on the
> latest Ubuntu kernel release as of 2026-05-27 (we are in the process of
> re-testing against v7.0.10 of the kernel.org release). The variant is distinct
> enough to warrant its own patch, as it operates in a different function with a
> different trigger path that survives the existing fix.
> 
> If there is an existing patch that apparently has not made it's way to Ubuntu
> distributions, we'd greatly appreciate if you could flag so that we may
> initiate the CVE assignment process with kernel.org CNA.

netdev does not really care about downstream kernels. Please report
any networking issues against Mainline, ideally net or net-next.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

   Andrew

