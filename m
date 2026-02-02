Return-Path: <netdev+bounces-255863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKYVCviggGni/wIAu9opvQ
	(envelope-from <netdev+bounces-255863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:04:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7657DCC924
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 14:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A433302529B
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5B335BDBF;
	Mon,  2 Feb 2026 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB1kApKs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111E2D321B
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037465; cv=none; b=KBaG7KukklIQZw2mG56OiF88xahTV3JG+Y5zoA3PxNF6RTj8yBkYR6kPmBEwLZJCzYcoUV5LEvt7JItRyDbaSx53e61EaHbmJQzXfJ1M63LSbeJJtCZnGMzQE+MCOwLFPhFj23TqxHmmBlHBJvvNFuLL+4NkvYr7ow1UggTyAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037465; c=relaxed/simple;
	bh=Oz7cSlpWv2rTvsEtR1ob+H0tSzf3EinZBNAWl+72ZnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW9SM6LNFRR7fTpedUln7t1kslPmkQZTyqV/soFjXAO79t6pw4E+qYyGQGFk/8mspjs9ZhTwi2N3bbwQmuJJGYVqEHsGBDcuNAQ4DX8BXuLLvkxSMOxb4MQVoe9xN0FvTj2yB3MhdOytBBPvBC00bCd2UsaIO1QCOtiF3BRnsCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB1kApKs; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59de306cec1so345726e87.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 05:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770037462; x=1770642262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qwYyMOQT9qf7oY7jtB+Qe9HHFdlKNBAoMbngEsefKQ=;
        b=OB1kApKsVQRXMGVeD90+T//u+xU+T0TofqzmuSKJtfRYdwVHDiCjoZN3NxraXebZU4
         XYfL39dH247Ww5pLDPXlXUlGi/q3NJsJBuTG1XaE0lk5kiz6dtdFvmfle8wNhRD55pSN
         56LLLKLncbsqSyUH1b8uAhYYHrNA7nBP/iHCHYM7bfOwsVHklexZYQodh939OHARMyTO
         D15qrQFE6ecv1Qyd0nIukDePlneLHc0HHYFTgUPWbCEmpTQ0cqLyoxJx/mJq1PS6mFEZ
         XT0ryEeEI2QnbhWyNDjajDrTtQOL1p/4ZqzIUSXsxMYrXU+m6q6Lny6Sa0De4gzwuXYr
         cy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770037462; x=1770642262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qwYyMOQT9qf7oY7jtB+Qe9HHFdlKNBAoMbngEsefKQ=;
        b=Aqah2faoOyaZhlN9B/JM7KlFPH1Hr6gnerojHeZEx6WnLZXls4VR8U6wfAYgupmhyY
         kospHvYlZSbfWAaVJwxsnFxp36SsJQk/hCSe02Q8NAenkL0fh3kyy1lwtH/SP1x7TvbS
         LfSrJeplQmvRwvORyUWWdJnciVwI+i7jZwUF4cI63ATTP/TkcM6ZKU8BWc2qBrademG1
         mpl4HZtjQQxpAhS22s2uvF+Rfqwey/ogLS0yPYjAnAFyyzG1EYCw9+xnBo8yJvoNpL5b
         a+OI2epdAvb+g9vFOWtBgteIgFozoVzI4ffSgB12BCjLaGvPDCn37IoJuJjPxftImLja
         mJFw==
X-Forwarded-Encrypted: i=1; AJvYcCVXkWrNuOSqPmwe5l7Fo6ajT3fIcCzA5sqWyN5U8VbqTaUTPgBLj/A9RdPT5U0rhAJDolVNFQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNM71uiVBnvVr2v8VWrYMAWYMG/PX1brG9nbJWrFYzCbxvzHz
	Hpw885Q745ToZU0Sw8RFCcZz0YSB1HXDk6lK0oBhtUXdAuJP4+jQMbsLfDEKDd1u
X-Gm-Gg: AZuq6aJz1cWM+I39N7RaQLXCIe7/OSLYyQ0S3rEK14AgI2qK3vFWBylm+vc2fJBOQsM
	t+kpzNzzQ4stYckI0oje1LDKMCZa8Y2biQKEm9DhMwHpZUy2jcdjYEUToJO+mL7lsfYokzzgqrD
	u9mpKWlTa37v4Rntep6r34gZjXzVzUxRY3ddzILEbPIRLJlYahM4eyo/TSkEML9qL5OdPV1MBD4
	tlrnwFlwpCUKblH5PHsqX5z3VITir1d0zbKg+gJpekH9RHPmDTmRJBg9GtEfkgcgWvNqpjBkNx9
	XfF9wcXhmbEq3lkGislcqmXqEb93SGVIvHNIfVW0rs4HwKQ7fGtCVTGgEb9mTYIhgrm86Rse6+1
	KaLgp4npeNA0UdgNXvTbH+xgIdxojqUKhyKrVNcKtfoBGwnjNFhAgTVG3a/uRFZBw4UzK0MB5Ae
	iLLh8=
X-Received: by 2002:a05:600c:3541:b0:47d:4fbe:e6de with SMTP id 5b1f17b1804b1-482db4ac12dmr88549885e9.6.1770030948249;
        Mon, 02 Feb 2026 03:15:48 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:74c4:3a65:f9a9:6c29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354114sm45572421f8f.42.2026.02.02.03.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 03:15:47 -0800 (PST)
Date: Mon, 2 Feb 2026 13:15:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jakub Kicinski <kuba@kernel.org>, lxu@maxlinear.com,
	hkallweit1@gmail.com, yweng@maxlinear.com, ajayaraman@maxlinear.com,
	andrew@lunn.ch, netdev@vger.kernel.org, bxu@maxlinear.com,
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com, chad@monroe.io, conor+dt@kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, edumazet@google.com,
	pabeni@redhat.com, cezary.wilmanski@adtran.com, davem@davemloft.net,
	john@phrozen.org, frankwu@gmx.de, jpovazanec@maxlinear.com,
	linux@armlinux.org.uk, fchan@maxlinear.com, horms@kernel.org
Subject: Re: [net-next,v11,4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <20260202111544.r2mlklwdvviqq7q3@skbuf>
References: <46226b74030f76bd04149ed5c92b3e263abbe6c2.1769817939.git.daniel@makrotopia.org>
 <20260131175243.1122906-2-kuba@kernel.org>
 <20260202094405.rsojaz5xmorubjfz@skbuf>
 <aYCBS40IO_GwAEBy@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYCBS40IO_GwAEBy@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255863-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[kernel.org,maxlinear.com,gmail.com,lunn.ch,vger.kernel.org,monroe.io,google.com,redhat.com,adtran.com,davemloft.net,phrozen.org,gmx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7657DCC924
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 10:49:47AM +0000, Daniel Golle wrote:
> > > The dsa_to_port() function can return NULL if the port is not found in
> > > the switch tree. The code stores the result in dp but doesn't check if
> > > dp is NULL before dereferencing dp->cpu_dp->index.
> > > 
> > > Looking at include/net/dsa.h, dsa_to_port() returns NULL when the port
> > > is not found:
> > > 
> > >     static inline struct dsa_port *dsa_to_port(struct dsa_switch *ds, int p)
> > >     {
> > >         struct dsa_switch_tree *dst = ds->dst;
> > >         struct dsa_port *dp;
> > > 
> > >         list_for_each_entry(dp, &dst->ports, list)
> > >             if (dp->ds == ds && dp->index == p)
> > >                 return dp;
> > > 
> > >         return NULL;
> > >     }
> > > 
> > > Additionally, even if dp is non-NULL, dp->cpu_dp could also be NULL if
> > > the CPU port hasn't been properly assigned during initialization.
> > 
> > mxl862xx_add_single_port_bridge() has been called when all other port
> > types except user ports have been excluded. All user and DSA ports have
> > a non-NULL dp->cpu_dp pointer after dsa_tree_setup_cpu_ports() runs,
> > i.e. also at the time of ds->ops->port_setup().
> 
> here, as well as in mxl862xx_setup_cpu_bridge(), right?

Yeah. If you think adding a comment helps keep spirits calm, you can also do that.

> > Technically ds->ops->setup() runs under dsa2_mutex, but the "static int idx"
> > is still not ideal due to the ever-increasing index upon unbinding and
> > rebinding.
> 
> As mentioned in my reply to Jakub[1] many drivers follow this pattern and it would
> imho be a good idea to agree on a convention or even provide a helper function
> which names the MII bus for DSA drivers. What do you think?
> 
> [1]: https://patchwork.kernel.org/comment/26768088/

I don't really have an opinion, the internal MDIO bus is part of each
driver's housekeeping, and DSA tries to stay out of that as much as possible.

Maybe PHY maintainers may know more what user space tooling may break if
the mii_bus->id gets changed, or may prefer a naming convention irrespective
of the bus being part of a DSA switch or not.

