Return-Path: <netdev+bounces-283711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG9BOw9J+Gn+sAIAu9opvQ
	(envelope-from <netdev+bounces-283711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:21:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F92C4B9471
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D16F30107CD
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C62DEA90;
	Mon,  4 May 2026 07:21:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F228B2DC321
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879279; cv=none; b=Vdnt7RtFlvnZOAmjkR8r67VjFD+g+5EbpnIJjnTK6Pxl9NOvirqdhrmBTB8QV7FgWauoepde5xpfcKIopvKlq428lP4ULaWZwWUw4SwoRC2QeLRkh9zbYvUMVl/xmwk8PkHZHxWhSg6NqNY+J1pRtIojmqamkjMy1eKhfTnLwSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879279; c=relaxed/simple;
	bh=Q7I05WchKE/fXGbHEmNhvOymjgzLAabQER7PjYhbc/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir6wajKesEhsqQ9x0AlMkYq3+yii8uHorSy2el6po8IMZQ5vr2pg7apHxFiT6TbQuL8UREO1Ry4h109ukevfLZJXo+LbHqp4B16CD1SDqORMJrN5IZs7dDwU8FmUVFvQTR+tCtZoy5gBYhzd12bnEAkj4WGg0xFfKJ49K2ZEVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wJnbv-0000pr-Ne; Mon, 04 May 2026 09:20:59 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wJnbs-000N2y-2r;
	Mon, 04 May 2026 09:20:57 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wJnbt-0000000GYf2-0sZJ;
	Mon, 04 May 2026 09:20:57 +0200
Date: Mon, 4 May 2026 09:20:57 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Miaoqian Lin <linmq006@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: asix: ax88772: re-add usbnet_link_change()
 in phylink callbacks
Message-ID: <afhI2V94qRJdsYVi@pengutronix.de>
References: <20260501163941.107668-1-Markus.Baier@soslab.tu-darmstadt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501163941.107668-1-Markus.Baier@soslab.tu-darmstadt.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Queue-Id: 4F92C4B9471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283711-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.962];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]

Hi Markus,

On Fri, May 01, 2026 at 06:39:41PM +0200, Markus Baier wrote:
> Commit e0bffe3e6894 ("net: asix: ax88772: migrate to phylink") replaced
> the asix_adjust_link() PHY callback with phylink's mac_link_up() and
> mac_link_down() handlers, but did not carry over the usbnet_link_change()
> notification that commit 805206e66fab ("net: asix: fix "can't send until
> first packet is send" issue") had added.
> 
> As a result, the original symptom returns: when the link comes up,
> usbnet is never notified, so the RX URB submission stays dormant until
> some other event (e.g. a transmitted packet triggering the status
> endpoint interrupt) wakes it up.
> 
> This is reproducible with the Apple A1277 USB Ethernet Adapter
> (05ac:1402, AX88772A based) on a Banana Pro using a static IPv4
> configuration. After bringing the interface up, no incoming packets are
> received until the first outgoing frame triggers usbnet's RX path.
> 
> Restore the link change notification, gated on a carrier transition so
> the call remains idempotent if the status endpoint also reports the
> change later.
> 
> Fixes: e0bffe3e6894 ("net: asix: ax88772: migrate to phylink")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Markus Baier <Markus.Baier@soslab.tu-darmstadt.de>

I did some limited testing on AX88772C. Seems to work without
regressions:
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>

Sashiko suggests to update commit message:
https://sashiko.dev/#/patchset/20260501163941.107668-1-Markus.Baier%40soslab.tu-darmstadt.de

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

