Return-Path: <netdev+bounces-295904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fmGNCUgAI2o2gQEAu9opvQ
	(envelope-from <netdev+bounces-295904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:58:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AD6649F99
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 18:58:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=c7oUPlbj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295904-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295904-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8DF2309B0B7
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF76738886D;
	Fri,  5 Jun 2026 16:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCEA3B42F8
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 16:51:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780678321; cv=none; b=l/w31e0WdHY+13zEHKaT0cYB76WiuFR1pnQZTtMFra1rzHVJWuxaGsPspkHH3NmE72XxfnVsSjuWZCuWBdhgrDKto0FCSTOq0hkv+mqW9dn6eGql6TfBoGQN07C7M2u8soYtfcBhA0KNG+29axMOWL1M+a2lYmDqmtjo+AkXi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780678321; c=relaxed/simple;
	bh=GD1Ehe2mcn7BlgIafMHzQrly0XKLf3VuxPyyLW5Crh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPx2Vffl9PmhOoJYdjPygFCILBM5tGCM9H/Bcv3RChkL0hC4I/mUTM3D49L0U3osUFQHEW7yDBiX95Dwm3tDwYvpVlipDui5DbpX16WQWKrbUKMnB+h6G5mWUJhGPHFMqYVIX+maUVD+znyURlxqAFjGUtcgu2JrnhPGYEZmfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c7oUPlbj; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CbQtzRWvKXJOCWQsUfICHgTZdywfXO21AYToLnLLTfc=; b=c7oUPlbjcuYt/kOHmTfI3EZ1ha
	dmx8lnFFmo8WUlbXwVjBzm8Cl/sckQWMAoPg7SMZpH3gleG7Bkwv8s4/rD0KmHWmTu9+StVo4TVAO
	h5XGBasa76UEnbnIGr1o+LTI9MKuQSqGmWGkyj4QDcdgYagtn1OFN9+jK8TcV1TDiGyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVXm0-006GU3-Em; Fri, 05 Jun 2026 18:51:56 +0200
Date: Fri, 5 Jun 2026 18:51:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: netdev@vger.kernel.org
Subject: Re: SFP/MDIO/I2C: help requested unlocking a SFP+ MCU to expose PHY
Message-ID: <903daf32-aecd-4160-8f69-4fc329fdad3f@lunn.ch>
References: <ec5bd768-3f54-4c30-b5a2-1e0b43f789e3@kabelmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5bd768-3f54-4c30-b5a2-1e0b43f789e3@kabelmail.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:janpieter.sollie@kabelmail.de,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295904-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85AD6649F99

On Fri, Jun 05, 2026 at 10:09:46AM +0200, Janpieter Sollie wrote:
> Hi,
> 
> This message is a follow-up on a previous request,
> I reverse-engineered a lot of stuff,
> and the question has become fundamentally different.
> 
> I am trying to access the bcm84891 phy on a 10Gtek ASF-10G-T80 sfp+ transceiver.
> According to 10Gtek, these modules contain a bcm84891 phy.
> The MDIO commands seem te be sent to a MCU, not the phy itself.

Do you know what MCU is in the SFP? Is there a data sheet for it? Can
you read out the EEPROM holding its code over the I2C bus? You can
then disassemble/decompile the code and see what it is actually doing.

	Andrew

