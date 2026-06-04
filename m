Return-Path: <netdev+bounces-295221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tRgcEpFvIWqBGQEAu9opvQ
	(envelope-from <netdev+bounces-295221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:29:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3539963FDAE
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 14:29:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=balqjJvs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295221-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295221-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 93E85305BCC4
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 12:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D4343E4BF;
	Thu,  4 Jun 2026 12:15:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C4423156;
	Thu,  4 Jun 2026 12:15:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575344; cv=none; b=HGJVkFoVD1qvMxGsga5dTvf21OBuAwx/9r3+xgjAnptXW4fPNi0OBqYC1zdn9vb0MMbzt9lfxSjwvOp8jFLbvsGZmYQK4DBg1YpR90oLYY/Rc8lHmW3rwp71r7KOJv6invugN/rkyo2mnCCmvaDLq/58DQ9X+i8AE0A0c7hpWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575344; c=relaxed/simple;
	bh=uuWtqL2WolXYJNjqqDgxF84YSoqvRlyovyp6OYFfqbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCrFqYdlMeSj+9ab74J1W0tpmUL7U6uguytjP2kFO9RjCf5gbdXxJjfqPB2JRIn/3XZiyY2j42RFu/9akLRV09rDW7rkCZZdaE3d6gE9dQRUEpEbaIYfPJ/2EuKL1Pl0v0+5WagAwmPI2IUVVjMEjrnpgQxcUPonqhKM+lWE/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=balqjJvs; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rrTCBVw9fJyz5w/AnDGqMEZsVlg7Qh/n11cbzaFeMz4=; b=balqjJvs7WubRmKvrFq4m9hDKm
	hqK5AsFBvzyOP0kR3KEu/3C//N+u3/9s9Ym7wPEHVtDxaXie552IKIi8YPotEBZQadPiuya65E3Kv
	HeSMXiHdc4fs/9I2K71X+oHWvmHjfL9zc1b3p1oVgnX5NrgnFagRyR+aLtiIZIgy76E8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wV6yy-0062VK-VZ; Thu, 04 Jun 2026 14:15:32 +0200
Date: Thu, 4 Jun 2026 14:15:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paolo Abeni <pabeni@redhat.com>
Cc: lawson.fidelio@gmail.com, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	marex@denx.de, maxime.chevallier@bootlin.com, horms@kernel.org,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	Tristram.Ha@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, nb@tipi-net.de,
	fidelio.lawson@exotec.com, marex@nabladev.com
Subject: Re: [PATCH net-next v9 3/3] net: phy: micrel: expose KSZ87xx
 low-loss cable tunables
Message-ID: <bbb42bb7-7ea2-4a7d-a66b-dea02129a667@lunn.ch>
References: <20260601-ksz87xx_errata_low_loss_connections-v9-3-fdbbb15592cb@exotec.com>
 <20260604114133.170770-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604114133.170770-1-pabeni@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295221-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:lawson.fidelio@gmail.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:marex@denx.de,m:maxime.chevallier@bootlin.com,m:horms@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:Tristram.Ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:fidelio.lawson@exotec.com,m:marex@nabladev.com,m:lawsonfidelio@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,davemloft.net,google.com,kernel.org,denx.de,bootlin.com,armlinux.org.uk,vger.kernel.org,tipi-net.de,exotec.com,nabladev.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:from_mime,lunn.ch:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3539963FDAE

> Since the capability check looks at get_tunable but unconditionally calls
> set_tunable, could this lead to a NULL pointer dereference if a PHY driver
> were to implement only read-only tunables by providing just get_tunable?

It is in the name, tunable. A write only tunable might make sense, but
a read only does not. So an Opps is the right thing to do, it makes it
clear there is a bug, and you get a nice stack trace to help you find
it.

      Andrew

