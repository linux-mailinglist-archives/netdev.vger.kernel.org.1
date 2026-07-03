Return-Path: <netdev+bounces-304602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QMlIAdDjR2qBhAAAu9opvQ
	(envelope-from <netdev+bounces-304602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:31:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF6C7043FF
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 18:31:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=JBS1jnIS;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304602-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304602-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 356A1300A24C
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B32BF3D7;
	Fri,  3 Jul 2026 16:31:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DC2D5937;
	Fri,  3 Jul 2026 16:31:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096265; cv=none; b=rdW+M9RxCKPZEXSMbswtVELTPaa4SZtG2A8rAlECxrTeuLhBEritlnJgqBtP9xN7FeXoHMGuHypp560Dy6legrdKQFgJI+hVvxC2OythsllVsdsa1djnwprrEnICON94Iea8ftdXk1/J5jZCkGyyQoDkixf61Ds8ZN87g9mXeDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096265; c=relaxed/simple;
	bh=15WN/V86a7VYxUbV+qagA+LK0E9ugBgtu+O30/NFkKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz24zKacroinWbrGiwyoxw8dkhPNqLh599qOIOpaASLFX9O82R+iBFbx+6frFF7F5IrwK601JqX79O/PtqLnIM6UA7uEeNqY2IrqfVygtzwxcQvIDKFnNj3Oz5HzWSjc8r7CM7cpV0rwhykaHiDd2tksSMjQ9JDYzCOKexVI734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JBS1jnIS; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=etnKuiaGnlG3JOwXFfNRNf+6mlZGHxP3FTCIlaWThvA=; b=JBS1jnISTaaR5l/KtgR6bAxO2o
	H1OcbjFCXm09oKSeKUzlYKj5WlR6rkapsEadgCuFuKbPcYMn83FohkUT4de5A1NS3DomNjJ0ZBZEE
	pasaFJvhydT75vnIBpjLqB9zH/iIS5G4yWALABHn55nhXjwtRs9HzkK/I6vKmFln6eTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfgms-00AZjH-MB; Fri, 03 Jul 2026 18:30:46 +0200
Date: Fri, 3 Jul 2026 18:30:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v9 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Message-ID: <2aa4ad89-c906-4b06-b449-15d08196de26@lunn.ch>
References: <20260703071330.1707-1-javen_xu@realsil.com.cn>
 <20260703071330.1707-5-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703071330.1707-5-javen_xu@realsil.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304602-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de,bootlin.com,vger.kernel.org,makrotopia.org,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFF6C7043FF

On Fri, Jul 03, 2026 at 03:13:30PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for loading firmware. Download some parameters
> for RTL8261C_CG.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

