Return-Path: <netdev+bounces-286823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM7lHpQ9AmrmpAEAu9opvQ
	(envelope-from <netdev+bounces-286823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:35:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3100515EDF
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81283302A2E2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A5C38AC93;
	Mon, 11 May 2026 20:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ciUG2hih"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE638A722;
	Mon, 11 May 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531438; cv=none; b=r2kYod/UAioTFByEh+1fu5n0+P6gtD/0EA8t/C5eyXgtRHgfj42QzBCkzEBphT4V2Q1PgWQU/ETHP3196SidIUwDIEH37Tu5oprtVGXE4Msn7qli/dgtBN41aYC9VdZhNQ6/7qMblmRJS8i6eSWAG/5m+lHYrkJZsAmxuMmYKXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531438; c=relaxed/simple;
	bh=nfKJ0vzhXUnn7BfPiJJPzqO2RcwE2OpWohS5n4ibfOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiQ7UoJYVxbfXgU2lirGj6K5Uref3efbu+OhYOYnucDpxRb8k36A67HDfxEuTYaffqOl66LubRWq6JWMEkMH39kmnWbKymeLl0ab7oy9in6XKuYNoakEXkiKB6OsBgwJQ4Zv8tU3JoW1N1eB2vVRkjmaojszj2IRch4q2AeozTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ciUG2hih; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZTCRFOzf0DARAmyz4QqunhkiGwHKR59Rydj1SRY5VV4=; b=ciUG2hihcEyJu1iEO929MydgMJ
	bHy/QUtui7h6W25EUTvSPz1+ET9nxJHbQg7xGSnxS0eHJyurMaLgaRs5cZrU3rTHcvDcUX2gbZWZ/
	Eeenho2cfnkjI+gg5WKvbwZFtxfsDvIhykyLGMVxu6ttEMlFYM3SBes8vlLB6w0ng8MQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMXGf-002RB7-Az; Mon, 11 May 2026 22:30:21 +0200
Date: Mon, 11 May 2026 22:30:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 4/9] net: phy: ncn26000: Support for internal
 phy for S2500
Message-ID: <954b5b1e-2850-48ac-97f0-f9ac6e52d461@lunn.ch>
References: <CY8PR02MB9249195FE5BD6D7FA31F4D1B83382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <b6af67df-1217-411c-ad47-f9c3e556d345@lunn.ch>
 <CY8PR02MB92493D7EA2E83DA6FE73B10583382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB92493D7EA2E83DA6FE73B10583382@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: E3100515EDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286823-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 07:35:15PM +0000, Selvamani Rajagopal wrote:
> 
> 
> > 
> > 
> > This Message Is From an External Sender
> > This message came from outside your organization.
> > 
> > > @@ -163,7 +166,7 @@ static int ncn26000_config_intr(struct phy_device *phydev)
> > > }
> > >
> > > /* Directly accessing via Clause 45 read avoids the extra
> > > - * SPI accesses required by indirect access.
> > > + * SPI transactions required by indirect access.
> > > */
> > 
> > Please don't change things you added in the previous patch.
> 
> I thought v1 is abandoned once v2 is submitted. Didn't realized we diff v1 -> v2 too. Will be careful in avoiding it in future.

Wasn't this line added in a previous patch in this series? Patch 3/9 ?

       Andrew

