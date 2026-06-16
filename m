Return-Path: <netdev+bounces-299943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LpXgHGWlMWobowUAu9opvQ
	(envelope-from <netdev+bounces-299943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:35:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AEC694F9A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 21:35:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=duRsJWxR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299943-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299943-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3795D302ABA0
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF0C3DDDD5;
	Tue, 16 Jun 2026 19:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959A3DA7C2
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 19:34:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638497; cv=none; b=RlNVA9/gEZQKHC1Xe8v471X6LYIIe6eNqXSuHzhwdMn9WIY5TEXqSboKfiyQ/M65Gu/5tQeZgKLjjQD9R5VMO9nAFMpEnAkU/DzEWJdwfJI3GCZGIBEbsz2++m41nLLXBTKJEyD1p40YKltprkAvSoId4W7r2N88h+W21LoTMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638497; c=relaxed/simple;
	bh=juXgpAOjxlBKw2vqqUR+X+FlI4/LmoyIW5dMLQuggnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAWzPih9hdGDNTbDH9DN1hiN9TjLmtilXrmlIzaeU0kaZTcyRQNdgO0V5MHXRk80d+HUsTfhjNArV2HyKPjm8VFsbemrEHs4IRjVf1zLz67xA2ikHQQeQDTUay2fSigHhw0ZuiAaN2TJ5UYKav8uFkibbcMDkMRCNOaJX/9XNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=duRsJWxR; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ipZ2eOXmI7/ITECTv5m2nJGPjex1DXsJQzCrxYhD0tQ=; b=duRsJWxRLHM/2gfsJYBVRgd+Sf
	TfZI86xxUAF68kaNC6k3csMBHTfWgALdr0sgHTKJMsNEdEhAUnIR+/ZWTa/bf2WInoHay6SPAI/YT
	Dt9VAHEgP7OgSWZcZSr7UvlBSCNGEssYIP8ltTvZZKOuFF/gfGPa3VEpQW0K4Ng9+IoQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZZYd-0081W0-Qa; Tue, 16 Jun 2026 21:34:47 +0200
Date: Tue, 16 Jun 2026 21:34:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Philippe Andersson <pan@iba-group.com>
Cc: netdev@vger.kernel.org, Ludovic Calmant <Ludovic.Calmant@iba-group.com>,
	Fabian =?iso-8859-1?Q?No=EBl?= <Fabian.Noel@iba-group.com>
Subject: Re: [Bug] incompatibility between 'e1000e' and Aruba AOS-CX switches
 (too small inter-packet gap)
Message-ID: <bdf0a4b8-e414-4df7-833c-3051987c3f2b@lunn.ch>
References: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457d1617-bd7f-44c5-a9af-7ba8aa9250f4@iba-group.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299943-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 96AEC694F9A

> A support ticket has already been opened with Aruba, but it's unclear at
> this stage that the problem is on their side.

How easy is it to reproduce? Can you run a git bisect from the last
known good kernel version to the first known bad version?

      Andrew

