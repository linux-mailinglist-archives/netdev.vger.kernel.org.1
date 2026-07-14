Return-Path: <netdev+bounces-307609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JyExFMe7VmqfAgEAu9opvQ
	(envelope-from <netdev+bounces-307609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DCF759424
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:44:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307609-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307609-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 305D03066273
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B42C41E6A3;
	Tue, 14 Jul 2026 22:44:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8110441DDEF;
	Tue, 14 Jul 2026 22:44:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069046; cv=none; b=qEGKg3eyHMWQxdcOd/8Odw4Pvv52SxnaIbWI6+WKjuLngWowP97L9slULW3LSCUGiM5XjcXEky+srL7K1n+5ckB+jDgEr8/VCe+q+sH2Y5phlLmHrpBO3j04ZEdbNxF+ve/Ufu1nmBxF25zjlrIC/qUtNvFqpNyIoOkgwDCTsEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069046; c=relaxed/simple;
	bh=wfCMcQNi07TVlzjXUfxa3WKiIEmLUGRu5qmynwqHYrc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=soMOrB2vInmCuy1vpmwVi3hq+FTnT7ygwPUxkd3nnxXr5IuJzgpDUezWIwqTRjr56gAGzZM/1AJBY5SwaysFTFsdliCKClCc7kqe559Rp/jFiNveY4Ffl6CZXc3z0pwOLwbdbOegTuhvjxE6TA7YkyItvjam0ycDat6ekGp1ssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id F138E444;
	Wed, 15 Jul 2026 00:43:50 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 00:43:50 +0200
Message-Id: <DJYNOU41CMDC.1QU8SOPTLUNB5@kernel.org>
Subject: Re: [PATCH RFC net-next] net: phy: sfp: drop 1000Base-T support for
 FCLF8521P2BTL
Cc: "Russell King" <linux@armlinux.org.uk>, "Heiner Kallweit"
 <hkallweit1@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Andrew Lunn" <andrew@lunn.ch>
X-Mailer: aerc 0.20.0
References: <20260714125008.2466023-1-mwalle@kernel.org>
 <c62c33be-0082-4e4a-8f13-2e14e851e975@lunn.ch>
In-Reply-To: <c62c33be-0082-4e4a-8f13-2e14e851e975@lunn.ch>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307609-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,coherent.com:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7DCF759424

Hi Andrew,

On Wed Jul 15, 2026 at 12:04 AM CEST, Andrew Lunn wrote:
> On Tue, Jul 14, 2026 at 02:49:34PM +0200, Michael Walle wrote:
>> The FCLF8521P2BTL is marketed as a drop in replacement for fiber
>> modules using 1000Base-X autoneg towards the host as default. See the
>> referenced application note, esp. question #11. Drop the 1000baseT
>> capability, so 1000Base-X will eventually be used.
>>=20
>> This is esp. important if the TX_DISABLE pin is not connected on a
>> board. Usually, pin is used as a reset line to the PHY on the copper
>> SFP. If a bootloader expects the default mode and doesn't do any
>> reconfiguration of the SFP module, a link might not be established.
>>=20
>> Link: https://www.coherent.com/resources/application-note/networking/100=
0base-t-sfp-faq-an-2036.pdf
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>> I'm not sure, this is the correct place for the fix, nor if it goes in
>> the right direction. There is a comment in
>>=20
>> /*
>>  * Clause 22 copper SFP modules normally operate in Cisco SGMII mode wit=
h
>>  * negotiation enabled, but some may be in 1000base-X - which is for the
>>  * PHY driver to determine.
>>  */
>
> The reason Cisco SGMII is used is so you can support 10Mbps and
> 100Mbps, as well as 1G. If all you can do ix 1000BaseX, supporting
> 10/100 becomes harder. If the PHY is clever enough, it can send pause
> frames to slow down the MAC. But that requires the PHY actually
> converting the bitstream from the MAC back into packets, performing
> packet buffering, and then creating the new bitstream at a lower
> rate. Some multi-gigi PHYs do this, especially if they implement
> MACSEC, but few 1G PHYs do.
>
> Normally, if the PHY is in 1000BaseX, the PHY driver will try to
> reconfigure it to SGMII. However, There are some SFPs which are stuck
> in 1000BaseX, and there is no access to the PHY registers, so there is
> nothing we can do.
>
> Looking at the link you provided, this SFP has a Marvell 88E1111, and
> its registers are available. So the Marvell PHY driver should
> reconfigure it into SGMII mode.

I figured that, but have a look at the commit message, the problem
is the non-existent TX_DISABLE line. So if linux would reconfigure
the PHY, the bootloader won't be able to use it anymore if it's not
doing a hardware reset (or reconfigure it on it's own).

I don't know what's the netdev position on that issue. You could
blame it on bad hardware. Or we could just reconfigure it if the
DT has a gpio phandle for the TX_DISABLE line, though that doesn't
mean that it is actually used to reset the module on a board reset,
or that the bootloader will do a reset.

-michael

>
> Maybe look at the marvell PHY driver, and snoop what it does when it
> configures the PHY.
>
> 	    Andrew


