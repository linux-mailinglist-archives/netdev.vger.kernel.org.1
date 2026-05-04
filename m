Return-Path: <netdev+bounces-284021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ATrMrvz+Gke3gIAu9opvQ
	(envelope-from <netdev+bounces-284021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:30:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD324C33FC
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 21:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3F3A305583F
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D893F9F3C;
	Mon,  4 May 2026 19:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mo0p46+x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E03F7AB7;
	Mon,  4 May 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777922141; cv=none; b=Yfa7RNUyIvp1I3+xy3A2MbLNmnqn7KdvVRkrd96RTS4v6CCSN9h2zfNNCLURBMUCsGycVMuQUgs7hNCVhsP7l+YlR7me/oSBo4rMsO7UfniVto8pucJa896hxg3365RrvCUumJB1LDVkWsi5LYDGaQVk1W0XeDjj26wn4kQ4tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777922141; c=relaxed/simple;
	bh=6aQyozdpDSP8V5wc4NIMIWFYy3/DawNxjm0nfY04pQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU6BwH6KWca0TT36EQzlGs1TQlhsHnHQv+xX2pAATEFS9Iy0FWSTn+zhKQDW/8wkjwt2FI0e6Q7kbz3Pr+gOxSyUtWTvMArIflYRGQtsW1t1V+/IJE74sVC1acMCDJGv+6n57kD4detxjs9AffStu/xO7pcgSQkpxJaZvlouOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mo0p46+x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c/0+cBISxFi6eOhySRqyC11R5/JzvQU8vchLpesMcEA=; b=mo0p46+xklZoNkpxwGRDKGOvDb
	rsKeWEFEdQ6p9y0chyYU0wW4h+xxA9qYPe9V+HqVal9Bq8HMY/0xebfpqvMVe/d0veG/MTyycNVAU
	nhxzOLRrvzrRbT1fYyQKRKZaJIkIpbJpRyIu0A0ys+8mCE5DrpebrozGt6AP1QbrYhzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJylK-001Kbo-RA; Mon, 04 May 2026 21:15:26 +0200
Date: Mon, 4 May 2026 21:15:26 +0200
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
Subject: Re: [PATCH net-next 4/5] onsemi: ncn260xx: Add driver support for
 NCN26010 and TS2500 MAC-PHY
Message-ID: <5f07822d-6ea9-4beb-a222-58a94e4801d6@lunn.ch>
References: <CY8PR02MB92494A5A16B7AF4EA3A69F2483322@CY8PR02MB9249.namprd02.prod.outlook.com>
 <12245592-fb85-46d9-9f26-5ed37efacbfc@lunn.ch>
 <CY8PR02MB92499BF412C31A04BADE609183312@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92499BF412C31A04BADE609183312@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 3AD324C33FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284021-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> > So you seem to be compliant with the standard. I've not seen anything
> > use MDIO_MMD_POWER_UNIT so not having that should not be an
> > issue. MDIO_MMD_AN is used by a number of PHYs, but i assume yours
> > does not.
> > 
> > 802.3 C45 says that if a register does not exist, it should read
> > 0. What would happen if a read was made to
> > OA_TC6_PHY_C45_AUTO_NEG_MMS5, rather than returning EOPNOTSUPP?
> > 
> > Table 6 says nothing about MMD 30, which you map to 12. 10-15 are
> > defined as vendor specific, so that is O.K.
> > 
> > But can we simply this. Add something like
> > 
> > void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms)
> > {
> > tc6->vend1_mms = mms;
> > }
> > 
> > and make oa_tc6_get_phy_c45_mms() look at its value?
> 
> Sure. I can do that. 
> 
> Since we don't support PCS, and POWER_UNIT, may I suggest alternative solution?

I would prefer to rely on 802.3 defined C45 behaviour. A read to a
register which does not exists gives 0. That is what PHYs and phylib
expect.

You failed to answer my question about this. What happens with your
device if you access C45 registers which don't exist?

> This gives flexibility to vendors as mostly likely, all the vendors
> may not share the same set of MDIO_MMD_XXX support.

Well, all vendors should support what is defined in the standard. It
is only MDIO_MMD_VEND1 which is left undefined, and different vendors
could put that at different MMS in the 10-15 range, but i think the
rest is well defined.

      Andrew

