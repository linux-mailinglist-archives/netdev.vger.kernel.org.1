Return-Path: <netdev+bounces-295982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id he2IAaJCI2o8mgEAu9opvQ
	(envelope-from <netdev+bounces-295982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:41:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4264B765
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:41:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=j0rez7Up;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295982-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295982-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8E553023F8A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 21:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4893CB91C;
	Fri,  5 Jun 2026 21:35:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8802D3C3C02
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 21:34:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695301; cv=none; b=IzqvyhPJ7hzq7jl5eoUzOm9qvblyYzeFC50tjOCBSuAMc4cG3eAoTUakg5FnoafO67902LEfkadYAlaA1hJhRuj1cfoedFwtX/pJxOerV8cQDIQl6n1Az+H9U+cr6Ar8ZIeH/Fc4cKbv2QCK9qqy5KFgoqVhxyT8+LeklXKuK7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695301; c=relaxed/simple;
	bh=v411BEioOSbdhB8wbPj1xLWLAoRmaYnLFMD7prb3wfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEmtr96TKKQzK5uucdTpjloLhmV+uN72hrhjRKjZE3kIhe1mvpxsLnkxLLM5FrCFs22ynHYWT/ua9DAYSXrdwhNnEuphuXLwQeoGQh2/yBoBNv5zp9uJzo5XbHDa1CicYhR9ST/w/aMGyjQDFbj4fwOLwScaSgw5xOzG5UJeiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=j0rez7Up; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AtofwzCo5uPvLJEvYg7I9k+VFHFEZkM8gtbo65Tun2k=; b=j0rez7Upx27U1lPXwh/O2qV9z1
	DXPstTOLhpCbOwsMHXDMFsYNerb9NdGS7Lmr8FcZ0JS92rpKrEOBrJmaWyNcnvZdU/EsgDOoRBqth
	NlyrR1PZhcO9bRmrP1hG3QvKsuSlxfudIVttXz43i7RG1XyBwbqGFDkd8wGLvCvWyNaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVcBn-006I6g-PG; Fri, 05 Jun 2026 23:34:51 +0200
Date: Fri, 5 Jun 2026 23:34:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Janpieter Sollie <janpieter.sollie@kabelmail.de>,
	netdev@vger.kernel.org
Subject: Re: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
Message-ID: <dc641872-9ac5-407b-b1c4-04cac5f0ef8a@lunn.ch>
References: <ec5bd768-3f54-4c30-b5a2-1e0b43f789e3@kabelmail.de>
 <903daf32-aecd-4160-8f69-4fc329fdad3f@lunn.ch>
 <49CA4531-3BDC-4054-8830-BA80775C2B68@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49CA4531-3BDC-4054-8830-BA80775C2B68@tipi-net.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295982-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:janpieter.sollie@kabelmail.de,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,10gtek.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49C4264B765

> >Do you know what MCU is in the SFP? Is there a data sheet for it? Can
> >you read out the EEPROM holding its code over the I2C bus? You can
> >then disassemble/decompile the code and see what it is actually doing.
> 
> https://doc.10gtek.com/file/file/20240806/d6fa28f954989f74cde42c75353b5fe6.pdf
> 
> I2c address should be A0h

That is the usual address for an SFP. However, MCUs sometime have ways
to program them, etc. That is why i asked if you know what the MCU
is. I guess you have not taken one apart to see what is actually in
it.

	Andrew

