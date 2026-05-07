Return-Path: <netdev+bounces-285307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJIuKTKE/GmOQwAAu9opvQ
	(envelope-from <netdev+bounces-285307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:23:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CE94E824A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D8E30048C9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1F3B19BC;
	Thu,  7 May 2026 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GBlkYDUT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD672E7F25
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156591; cv=none; b=TSKZ9+EhxmMtL5ylubRvSt+i3JhlDGxmzIiONDa+Ayjqr4fTZ3/n9bJYcByFqtlvGIU4UXQsZuJ0BUNOB6tRUBVeyyWUCkiw5c3WTBxTOkn9J1pEKPRNivphoRPj5IJcsnYto0CGmazHkCFLBIUc08Ouxhn/ATcZXvVdVu0s8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156591; c=relaxed/simple;
	bh=pS5zpsOPuov7uxKZpy7pVBccqd6j6SlEJU/WTiBdiio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai5bfD0RCd4xIbNX4pn46D7EEGQAbsOfk4F+M4ptZ4MdeC9BIRSjyBiShQgw1rgGZMejfBaVI4kdBg3xYohZsDxtvLXwgwptzTKDLMx7JWu3I8ofTuhtbQrJGz4VYZorQBqaFTfk8znccGMb1pFgohx4a8NRhEAovg8DTIr1Mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GBlkYDUT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=33qxqNzgZGHZpStVX0X5eMtbopKkkIOyjYXbT7yHZdE=; b=GBlkYDUTB+Sc6dhtPzHDLvIdGr
	H4WNmdMAcmDLETSgivuZPyjM77g09SaEaiH3bZWQySTpdJzRZcbNru/aF5x0sNwSdOELE+OuZirEM
	KjapJwEp6l8eF9RPgxC+DYWyBAnpqm0Qxn8viz2iarxlslfzB5ewXbzePr3dkC+a+muo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKxky-001oEG-Ce; Thu, 07 May 2026 14:23:08 +0200
Date: Thu, 7 May 2026 14:23:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz, idosch@nvidia.com,
	petrm@nvidia.com
Subject: Re: [PATCH ethtool-next 0/5] ethtool: Add 'pages on|off' option for
 module EEROM hex dump
Message-ID: <5114542a-7c7f-4759-b13d-6873494944c6@lunn.ch>
References: <20260507114721.3409128-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507114721.3409128-1-danieller@nvidia.com>
X-Rspamd-Queue-Id: 00CE94E824A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285307-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> In practice, both outputs are often needed together for offline debugging:

> Output example (values zeroed to omit vendor-specific identifiers):
> 
> $ ethtool -m swp61 hex on pages on
> Page: 0x0
> 
> Offset          Values
> ------          ------
> 0x0000:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0010:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0030:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0040:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0050:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0070:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> Page: 0x0

Maybe also add JSON? That would make machine parsing of this easier.

	Andrew

