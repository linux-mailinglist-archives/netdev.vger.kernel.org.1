Return-Path: <netdev+bounces-289561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKd8CB6lDGq8jwUAu9opvQ
	(envelope-from <netdev+bounces-289561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:59:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC0583615
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32C17300E27F
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44283DB32A;
	Tue, 19 May 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sO2+KuYs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC93438B8
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213594; cv=none; b=Ur1INThXC3r40dH3PClpM/HsefG5jboLVNBMxjHkXY3dcYZnmDknPAdsp3c+4WpyQozCmMztAhQ4IozDRfoAxk+8d9zIEWKOQ3naNrVYxa9kTVOhCOEd4sZFGMjhYj9RNaTXeKkgeqNOVW5IcEtZS92/r81mo1pXieZ0nPwfBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213594; c=relaxed/simple;
	bh=G+ikI/M8C/DsyAdfE+9b1G6a5vJMt9NQIRt9DXDOQ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paET1uXOnQk/eE1Vp/uLhGMEWBrhx/wUUTDWYmMNpVOSXMwbMR3nosYQRw7JaxslxpaNbPbinycNJYIHJ7OWwFGC6fxvUOLJkFpVlxwlvJdMqyDdD3dweuwbd6e8khcdV3SSqC5gTEgg2Gb9g3XKx4RYCRAbrsBNZoxpKq+3hvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sO2+KuYs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6hofCwfWkrYTrxr1rDDsU6ulx04KaKIfFQOGi0fXbWc=; b=sO2+KuYs9GbUiw7T3JrukWUib/
	ATZc8J3B2cxmqCCKf7auW8jSn0rorFiJWOAHY1RF+HoUYhpiDRwUJvQlJf1tDCd6buc3OhScXNvOT
	t9bPnadsv1GfzlSn+guFttjL/BOj4nM4ja7ctmhDvcVUcJkxOqE5TMer5iDKxka0tkO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPOjB-003i6j-IG; Tue, 19 May 2026 19:59:37 +0200
Date: Tue, 19 May 2026 19:59:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
 structure
Message-ID: <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-4-markus.stockhausen@gmx.de>
 <agydm8V25M-jy5o6@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agydm8V25M-jy5o6@makrotopia.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	TAGGED_FROM(0.00)[bounces-289561-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 68EC0583615
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 06:27:55PM +0100, Daniel Golle wrote:
> On Tue, May 19, 2026 at 06:57:41PM +0200, Markus Stockhausen wrote:
> > Each Realtek SOC series has different number of MDIO ports.
> 
> I don't think the term "MDIO ports" describes it well.
> 
> I'd say "switch ports", also because RTL9300_NUM_PORTS includes ports
> used for SFP+ cages which aren't going to be (directly) associated
> with any MDIO-connected PHY at all.

Hi Markus

It would be good to take a step back and explain the concepts here in
the commit message. An MDIO bus as 32 addresses, as defined by
802.3. Why do we need the concept of a port when we have addresses?

Once you explain the concept, we can maybe suggest a better name. Or
throw the whole concept out because it is not needed.

       Andrew

