Return-Path: <netdev+bounces-294402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LMt1MfU+H2pljAAAu9opvQ
	(envelope-from <netdev+bounces-294402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:37:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21620631C96
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:37:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=GP4gpPxD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294402-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294402-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9A7A3032810
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 20:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6E3750DC;
	Tue,  2 Jun 2026 20:29:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C218AE2
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 20:29:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432198; cv=none; b=Yj89wMfA6ERKtaC5jkQi9Lfm7Feb9t1zRdd5J11MAF79jZ/hESztYfz3pAPjNWnsrjxuHNi1ZM4+QAWS+Kx9ev4/kXDS3Nl1vQHuGOLHiokF7sDifMYw6Wdh6xycBN3PBd1l26bHQgy3xfZUq40jlI17ZAkBamVT5iKpz8vYk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432198; c=relaxed/simple;
	bh=gT6JJSFXPntSgSJXnmFexTLz4ByekJ1Wxaa2ubgue4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ6IBdsMx+VPjGKjV2TZ+UQtthp8jqeMnPc7IDi30TVXd+b0fcEsrMsF/alkGXhwN8PowHUVTYk0DNtmAgQhdr1d6kZs/VazAV6uAsVM9hw0EeTns4DXNkFnlVcFgpovEbVt9ntOXsC2Th5ZzC56rtD/t2P8D8rcCRTO7LDRaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GP4gpPxD; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oYKgn0Ouv7gB691cAUCksoaQk2dpNxcVBdGF+YONLdY=; b=GP4gpPxD7qFWz8lBrZ9taVqTfQ
	tk1xxKuyAuQ30UBD3B6Jo69p7oYMVv1SFJ54SdenQQSDglJdt0oWOP8mDePZSKPL8nJtn55GVCXMF
	QdYr1T5v7iBD2PvWDUgHYu4OaLZp2UsQKqlsvaRAQkgn7sKC/UTvk89Q5zUPAsG+dZtc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUVk4-005kep-Nf; Tue, 02 Jun 2026 22:29:40 +0200
Date: Tue, 2 Jun 2026 22:29:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 6/8] net: mdio: realtek-rtl9300: relocate
 topology setup
Message-ID: <1843116c-e84c-47f6-a565-e41bd6918ced@lunn.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-7-markus.stockhausen@gmx.de>
 <d56efb0d-c288-43d5-b3c4-922a164fd29e@lunn.ch>
 <02b201dcf28f$e4794470$ad6bcd50$@gmx.de>
 <6ebe2342-fd11-4588-a17a-fdb057335915@lunn.ch>
 <00b401dcf2c0$6e2826c0$4a787440$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b401dcf2c0$6e2826c0$4a787440$@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21620631C96

> The hardware polling in these devices is very important for the DSA
> driver. Especially as a port can be either PHY or SerDes driven. Some
> MAC operations simply do not work if a wrong state is reported.

And you will get the wrong state if the timing of the poll is in the
middle of the PHY driver swapping the page to read/write something.

I've not looked at what PHYs you plan to support, but code like

https://elixir.bootlin.com/linux/v7.0.10/source/drivers/net/phy/realtek/realtek_main.c#L907

could be called every 50ms to blink the LEDs. That changes the page,
writes a register, and then changes back to the original page. If the
HW polling happens in the middle of that, it will read from the wrong
place. If that HW poll actually changes the page, without restoring
it, the write made in that function could go to the wrong page.

So, in order to be able to use the Linux PHY drivers, you need to
ensure the Linux PHY drivers has exclusive access to the bus when it
needs it.

All the phy_*_paged() methods call phy_lock_mdio_bus(), do what they
need to do, and then call phy_unlock_mdio_bus(). You will need to
extend those calls to disable the HW polling while the bus is locked,
and re-enable it when the bus is unlocked.

> There is no evidence about any issues in the OpenWrt ecosystem 

Try blinking the LEDs as fast as you can, and see if anything
breaks. Some PHYs also have hwmon sensors, and statistics. Read them
as well, as fast as you can, so you create contention on the bus. You
are then more likely to hit the race conditions.

	Andrew

