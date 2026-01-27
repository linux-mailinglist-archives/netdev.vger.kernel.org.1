Return-Path: <netdev+bounces-253877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IeUBE/AeGn6sgEAu9opvQ
	(envelope-from <netdev+bounces-253877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:40:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D695025
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61D833004D99
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6F359F82;
	Tue, 27 Jan 2026 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cnGsOS2y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3FA3596FB;
	Tue, 27 Jan 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521224; cv=none; b=MhDzpDTbA3i2i39kPf9VucOj8HSIPXrKgTW3kYpBeJ2NWMG+NACOI8wxC2S9ic/API9T47hsJNddSpCYdtGOZ0gVolZ5xcDjJ7XGChGXmTU9HK9cTVmI1Uz/49rgQSnoqwia1u+cx+IKK+tTF/1qP/XexSlr5uik3JbHZtPYslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521224; c=relaxed/simple;
	bh=q/t8q6cIDKN4tGqUOXEyEpqfjwEaUcXWcc9726MeDqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuowjA9OGVONWk0hw/GTxnmZLnVDPksu4wbRzZP0Pf+zkwSq8kauU1aFhm2nclXNjCLkk+xc5NCWlb4eYZNg/h42WaIiOdoLW/LOMtswt+uln4ua/MbDyPi95yQwU5yZS3U4xd/DAlqmvtjmMnk9jykT3T5ClD0uyOUxI5TvBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cnGsOS2y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=PJdRV52Sg2t3bV7DwpZwSOiK3NFQ9DZEEcrZUnrZodU=; b=cn
	GsOS2yQvDZsBDp5Wz+Jbu1jU+YHTDmHBhdXeEIzuGNWN40Nd+DG9Tjfc2btNHdwqq56odmbX3jNhY
	VO1ybpvEP03QAAvSkm3RVj6TNE/GutH3KUIEKDhspKWLofy3XS5x8xcwTnRD7rakGj/hKKScIR44p
	i6M87pQKKGEDGAc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkjIc-004xPn-HT; Tue, 27 Jan 2026 14:40:06 +0100
Date: Tue, 27 Jan 2026 14:40:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Min Lin <linmin@eswincomputing.com>
Cc: =?utf-8?B?5p2O5b+X?= <lizhi2@eswincomputing.com>,
	Bo Gan <ganboing@gmail.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	weishangjuan@eswincomputing.com
Subject: Re: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock
 sampling control
Message-ID: <e7183ae1-8b8b-4e77-9f4e-3bc1b4b63556@lunn.ch>
References: <20260109080601.1262-1-lizhi2@eswincomputing.com>
 <20260109080859.1285-1-lizhi2@eswincomputing.com>
 <00b7b42f-2f9d-402a-82f0-21641ea894a1@lunn.ch>
 <aWKZvEW7rKFFwZLG@shell.armlinux.org.uk>
 <0d54ddca-9270-40a5-aa82-d8a7b65027ff@gmail.com>
 <1a622916.2d28.19bb105feab.Coremail.lizhi2@eswincomputing.com>
 <d010a6b8-5bf0-40ff-8e76-18362a238d50@lunn.ch>
 <203bb660.2c91.19bfe45d677.Coremail.linmin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <203bb660.2c91.19bfe45d677.Coremail.linmin@eswincomputing.com>
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
	TAGGED_FROM(0.00)[bounces-253877-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[eswincomputing.com,gmail.com,armlinux.org.uk,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,einfochips.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,stormreply.com:email,st.com:email,armlinux.org.uk:email,infradead.org:email,einfochips.com:email,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,eswincomputing.com:email]
X-Rspamd-Queue-Id: 201D695025
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:05:48PM +0800, Min Lin wrote:
> Hi Andrew,
> 
> Thank you for taking the time to review the patch.
> 
> > -----Original Messages-----
> > From: "Andrew Lunn" <andrew@lunn.ch>
> > Send time:Thursday, 22/01/2026 21:27:34
> > To: 李志 <lizhi2@eswincomputing.com>
> > Cc: "Bo Gan" <ganboing@gmail.com>, "Russell King (Oracle)" <linux@armlinux.org.uk>, devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
> > Subject: Re: Re: [PATCH v1 1/2] dt-bindings: ethernet: eswin: add clock sampling control
> > 
> > > We also intend
> > > to upstream complete DTS files for EIC7700 so the bindings can be validated
> > > against real hardware.
> > 
> > I suggest you prioritise this. ARM-SOC is pretty flexible for
> > accepting work in progress support for new SoCs. All you really need
> > is for the board to boot to a login prompt on a serial port using an
> > initramsfs. So the .dtsi and .dts file can be very slim, CPUs, memory
> > and UARTs.
> > 
> > Once you have that merged you can work on the other drivers, their
> > bindings, etc.
> > 
> The eic7700.dtsi and eic7700-hifive-premier-p550.dts are already in
> v6.19-rc6.

Great.

> Because the device drivers such as Ethernet rely on the clock driver,
> our plan is that once the clock driver is applied, we will add other
> device nodes such as Ethernet and eMMC in the next upstream patch
> of the DTS. Is this reasonable?

Yes, this is reasonable. When you submit Ethernet support, please
include the DT patches as part of the series, so we can see the full
picture. When it comes to actually merging it could be the DT patches
get separated out and go a different path, but we can decide that when
we get to that stage.

Given the new information, it becomes clear that backwards
compatibility is not an issue. Since mainline does not have any users
of the Ethernet driver, you should make non-backwards compatible
changes in order to keep things clean. Just ensure the commit messages
point out there are no users, so the changes are safe.

	Andrew

