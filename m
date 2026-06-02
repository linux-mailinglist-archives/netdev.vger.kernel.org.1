Return-Path: <netdev+bounces-294215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id llLoLN7VHmqdVgAAu9opvQ
	(envelope-from <netdev+bounces-294215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:08:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 180CE62E4DA
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:08:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=ViX3CdC1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294215-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294215-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F1C3073402
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8E33DB62A;
	Tue,  2 Jun 2026 13:03:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134B03126DA;
	Tue,  2 Jun 2026 13:02:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405381; cv=none; b=J2luix6KXbjePqSiUKSSoi1FOnCy3lY6a+Hbi0DfgUvGznD2gwtvkuBQ5iru0QwvO80Nh4Qpw/CU35C7uk3G2nroncqb+SG9m5ugkH86KTgTFw/3di4dQ+mfG2heuIj5Eh0WXPxVQNCLxvPK/N/4Olk2Ei/36CUotPgoFVHiFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405381; c=relaxed/simple;
	bh=K8gZMyX58NO1IoitPIodZiSwnQ9rSGwqgieXlOVcDkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my0/Q94/XEi8Ux707eTKefFquenxh5Y9c2wM/k5eiGPtHMqeLvnueXQDVzvyoLDRWmbch4R/BPQ/bXcOJ/9XmxMaWQtAcKCW2+YztFpzVT5njznHlbX43kDDLzAabONaBvcUm6sy+cb0p02ga0LpBJSDZk98SBb8cV/63fg3Oe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ViX3CdC1; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6QzuOiqqaU8ImmmaoAkaSFhjXBK7kZ0ksHzE+A3Y+4o=; b=ViX3CdC1to93eadUVyOZn8aZcQ
	sVR6LsTI3HtkovxFIo8W+gHQRNQzw13EsiijepRw0wr+1dnbtTLorPV8ys70sD2cvnO11G6/zpmH0
	NXAXQWl3Twx+9Sov1jJvuKJ8vut4Fp7fu6Sm56FBafKHmDf+hawo48xBk5JPTdd5rmwU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOle-005gt4-0E; Tue, 02 Jun 2026 15:02:50 +0200
Date: Tue, 2 Jun 2026 15:02:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 12/14] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <7fe02d9d-3409-43c3-884b-4a0107400a7a@lunn.ch>
References: <CY8PR02MB92499D69207F6CFA01C196BB83162@CY8PR02MB9249.namprd02.prod.outlook.com>
 <8331c347-4d40-43ac-aa73-a22398ac76a6@lunn.ch>
 <CY8PR02MB92498165068F7C2FAF9635C883122@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92498165068F7C2FAF9635C883122@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-294215-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:Pier.Beruto@onsemi.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 180CE62E4DA

On Tue, Jun 02, 2026 at 02:30:02AM +0000, Selvamani Rajagopal wrote:
> > 
> > > +#define S2500_MMS_MII (S2500_OA_TC6_MACPHY_MMS0 << 16)
> > > +#define S2500_MMS_MAC (S2500_OA_TC6_MAC_MMS1 << 16)
> > > +#define S2500_MMS_PCS (OA_TC6_PHY_C45_PCS_MMS2 << 16)
> > > +#define S2500_MMS_PMDPMA (OA_TC6_PHY_C45_PMA_PMD_MMS3 << 16)
> > > +#define S2500_MMS_VS1 (S2500_OA_TC6_VS1_MMS12 << 16)
> > > +#define S2500_MMS_VS2 (OA_TC6_PHY_C45_VS_PLCA_MMS4 << 16)
> > 
> > This kind of suggests we should rethink the API for reading/writing
> > registers. It should be possible to pass MMS and register as seperate
> > values, and let the core combine them.
> 
> 
> I agree. In fact, onsemi's original implementation had MMS and address as separate parameter. 
> It is going to touch all the files. Let me know whether you want to do, If so, when.

I already suggested adding _mms() versions for register read/write. We
can leave any using MMS 0 alone, and only use these wrappers for !
0. That should make the patch smaller.

> > > + /* Convert the OID in host byte order */
> > > + for (i = 2; i >= 0; --i) {
> > > + addr[i] = 0;
> > > + for (j = 0; j < 8; ++j) {
> > > + addr[i] |= (val & 1) << (7 - j);
> > > + val >>= 1;
> > > + }
> > > + }
> > 
> > That seems pretty complex. What exactly is it doing?
> 
> Could have been well commented. According to datesheet, phy-id-reg[16:31] mapped to OUI[2:17] and 
> phy-id-reg[8:15] mapped to OUI[18:23]. I will add this to the comment.

What you might want to use FIELD_PREP, etc. See if that makes the code
more readable.

	Andrew

