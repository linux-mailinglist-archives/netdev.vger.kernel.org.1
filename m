Return-Path: <netdev+bounces-252948-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFWpMYjPc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252948-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:44:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D57757A3F9
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 896673006014
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E929D28F;
	Fri, 23 Jan 2026 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Vi+KKTJL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153728D8FD;
	Fri, 23 Jan 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197440; cv=none; b=cvGgM3Kr94ldvuSgPes5w49pTcbioJB5BXtACLp6h/QpN1WzYO52kA0R7V2vjzMk3qot7cgo0NlkVhW+PeLhaVjAqkKEXIJ4kIzTjJz+WOzGQAZ1qYMOyz74X9q/AK3EXaQjS8Yqy70ElmzJ+lKr8YjuDzNqH6flyudHA56uYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197440; c=relaxed/simple;
	bh=Pk4CItueZkQ6DId3TXP1Jz5jqPwVq6auclajXrFDIfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zxqne05re6yXPU2temAAT7mLCdsPy5TSI0h89U6sBCn+LG2VRV6xEPtidbOXzaQT+kNzHXCAkitvLnKNUcA9Whr/7Tl6YF33tJHU/stye4xKeKbSo7FKQzK+yjPOkDmy14xhaX88LkcFnCgiDiPtH8ieQHdgi+7Bn6Os5RWmTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Vi+KKTJL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F8X2Qe2GBeiLawBUjaVg5sWcX14l13OwMuQdvbXbuto=; b=Vi+KKTJLvBDJ5gb1XmjMzrFfkX
	OepU/znm3KgM9lIw1eqmtwwZaaIIc04+Kb5MXIY8ibH0se3h5pJYgGgOoehALiJkRZRsIouKr4gb7
	sQrYHEdDO4+llUaEt7gA4Xx4tPCXIMjC3PEVTfgD5gpy5lbkCp9fO4+EWuDZXPkY3TlU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjN4M-004JUt-2V; Fri, 23 Jan 2026 20:43:46 +0100
Date: Fri, 23 Jan 2026 20:43:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Bo Gan <ganboing@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	=?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling
 control
Message-ID: <bd202cfa-d6eb-4d0e-982d-b49795dd25f7@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <308b676.2d03.19bb0caebed.Coremail.lizhi2@eswincomputing.com>
 <59cec617-0189-4dc3-bc3f-6346155a62ae@lunn.ch>
 <4e2a55e7.3662.19be8cb9c3c.Coremail.lizhi2@eswincomputing.com>
 <c5c0bfdb-316d-4796-afa0-f6f018ceb414@lunn.ch>
 <abf12a3f-9cdd-472d-a02e-af4da594b84f@gmail.com>
 <e6f7da45-3dec-4af6-a5b1-a72210bf24f4@kernel.org>
 <43923bf9-6202-4147-8eac-5bd7bb653fd4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43923bf9-6202-4147-8eac-5bd7bb653fd4@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252948-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org,einfochips.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D57757A3F9
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:47:18AM -0800, Bo Gan wrote:
> Hi Krzysztof,
> 
> On 1/23/26 02:07, Krzysztof Kozlowski wrote:
> > On 23/01/2026 08:39, Bo Gan wrote:
> > > > I assume the address of the interface is fixed. So you can just key
> > > > off that to distinguish the two instances.
> > > > 
> > > > Since this is an internal property, not a board property, it is not
> > > > clear it actually belongs on DT.
> > > > 
> > > >       Andrew
> > > 
> > > IMO, they should be in DT to provide maximum flexibility. The SoC .dtsi
> > 
> > This is not the purpose of DT. Please rather use arguments in terms of
> > DT rules (see docs, presentations).
> > 
> Any examples? links? Thank you for your patience.
> 
> I'd say if the board .dts never overrides the eswin,rx-clk-invert, (E.g.,
> the SoC .dtsi has rx-clk-invert, later the board /delete-property/'s it)
> then yes, it can be treated as something inherent to the mac, and then
> "use arguments in terms of DT rules". I was thinking about use cases like:
> https://lore.kernel.org/all/20230714104521.18751-3-samin.guo@starfivetech.com/

Your device should be compliant with the RGMII standard by
default. There should not be a DT property to ask it nicely to follow
the standard.

Properties like

motorcomm,tx-clk-adj-enabled;
motorcomm,tx-clk-100-inverted;
motorcomm,tx-clk-1000-inverted;

are for broken boards which break the standard and require the MAC do
also break the standard so that everything works. We should not start
out with the assumption you need to support broken boards which ignore
the standard.

       Andrew


