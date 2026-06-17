Return-Path: <netdev+bounces-300203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rn0fAWnGMmpx5QUAu9opvQ
	(envelope-from <netdev+bounces-300203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:08:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0162A69B429
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 18:08:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=LparjHAg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300203-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300203-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F43E300184D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E5492525;
	Wed, 17 Jun 2026 16:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F624A138C
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 16:07:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712483; cv=none; b=g+Xtoy+uVbfSRzf/iRuO+uaHEIXvjN5OTCCN0VpifxUlT/L/CJEh+qz2kHD6SgY7YexD81S1Vb6uSSIdovZhs/FQ74NlJDugXnAWKtrb3hQJFr7KHhE7rsKewdIRM91T18e8CkAwai/gKxCXMrQAmuK1MbhPZyKHV4yPS2X94T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712483; c=relaxed/simple;
	bh=pcSQONoJCefLR2JfLRU9Ejgi3OjJSqeKPvd1KYONz5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbsQfxzx0h6ndmrUotO3NQJeY1pcimlWWg8KM3KBn6V6zZc6izK0JUVRX2IJaubhCpYV03Yeb01BgbNn4Rlo2hXsPZ8O+YxgL6MuSuddBEPcNWEPiG74RW8pKQls+Xg+HKm72rlnpFLsKvYiaPb2mqX7c7FEntZxRM4HNzXvFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LparjHAg; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/SVU/LsPQtoUpYw+7he5RYWA1Xjwu4EmSHrRJFuBjgQ=; b=LparjHAgFfh6dBtPwbAhcH3TK7
	4leA9XYzwKmnC5EMFXN7XigcmTu/MFEywiCkwF41qw482doh4CoT2hGsMZYKHstAE1zDngOPQHoCN
	VLt3bUzlJORIAzhdPFOQxIeas/aWpOwKU4JPL96ymyBU1nmqjhC+APV2T+nSksHDjfh8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZsnt-008ChH-Eo; Wed, 17 Jun 2026 18:07:49 +0200
Date: Wed, 17 Jun 2026 18:07:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Philippe Andersson <pan@iba-group.com>
Cc: netdev@vger.kernel.org, Ludovic Calmant <Ludovic.Calmant@iba-group.com>,
	Fabian =?iso-8859-1?Q?No=EBl?= <Fabian.Noel@iba-group.com>
Subject: Re: [Bug] incompatibility between 'e1000e' and Aruba AOS-CX switches
 (too small inter-packet gap)
Message-ID: <ee384978-4eca-4a49-b1e7-55be7698970f@lunn.ch>
References: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>
 <bdf0a4b8-e414-4df7-833c-3051987c3f2b@lunn.ch>
 <3b073409-9096-4467-9baf-11196a70c014@iba-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b073409-9096-4467-9baf-11196a70c014@iba-group.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300203-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pan@iba-group.com,m:netdev@vger.kernel.org,m:Ludovic.Calmant@iba-group.com,m:Fabian.Noel@iba-group.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0162A69B429

> > Can you run a git bisect from the last
> > known good kernel version to the first known bad version?
> Not really, as there is no "known good kernel". All kernels are good ones,
> as long as older ProCurve switches are used (e.g. HPE/Aruba ProCurve 5406R
> or HPE/Aruba ProCurve 2930M-48G-PoE+). The problem only shows when AOS-CX
> switches are used, and we only started deploying those in production a
> couple of months ago.

I was hoping you could narrow it down to one patch which caused the
issue. But if it never worked...

Then i really think you need to be talking to both vendors and try to
get them to work together to identify the problem. Maybe send a NIC to
the switch vendor, so they have all the hardware, etc.

    Andrew

