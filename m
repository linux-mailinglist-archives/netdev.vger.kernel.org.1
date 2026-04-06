Return-Path: <netdev+bounces-275548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GxqJc1202nPiQcAu9opvQ
	(envelope-from <netdev+bounces-275548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 11:03:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E364C3A2680
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166AF300FEE8
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0270024503B;
	Mon,  6 Apr 2026 09:03:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C601A0BE0
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466183; cv=none; b=QW2pJuJfPiqPQCCip5kJWF2ZkKq3saN0NBU850aY4h63LDkvHOfXsSJK8U2hY/LMRNHpAAoowc5giaQmvrBVI2duNjk329GUQ8NptiuMng7gMbQCmW0cwjBYqaphyceZLng4oh9Xaxx+9tHEZB2NcdaSiLENyTYErR7w8B58zXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466183; c=relaxed/simple;
	bh=JManHJFhk2e6nq/kPT+MB+sA+3+bWZrMdrr3hCEWNso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKwklAyRh2WQq44w8YyDYrEwZHra+p+ftj8jrGEydMK1AtIzWkdau/hjM40Yk2u7hZl7ZYdAE49/6sY7+O/aFQ4UfA1WGpZSCWzKz3yj2GOiWPvBKTMQP4VoyQET88sh+2jci699BKQkGk6vhC9rFiBd9jpJ+qq2V9dWBnCWR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w9fXV-00053S-4t; Mon, 06 Apr 2026 10:42:33 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w9fXT-003zEV-29;
	Mon, 06 Apr 2026 10:42:31 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w9fXT-0000000Aysq-2JFh;
	Mon, 06 Apr 2026 10:42:31 +0200
Date: Mon, 6 Apr 2026 10:42:31 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Carlo Szelinsky <github@szelinsky.de>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <adNx9z-AYxwpL2yH@pengutronix.de>
References: <61561526-1e8c-4d0c-a0ff-56da25ee6531@lunn.ch>
 <20260403133111.3304497-1-github@szelinsky.de>
 <20260403153849.2ed7d342@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403153849.2ed7d342@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[szelinsky.de,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.726];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szelinsky.de:email]
X-Rspamd-Queue-Id: E364C3A2680
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Fri, Apr 03, 2026 at 03:38:49PM +0200, Kory Maincent wrote:
> On Fri,  3 Apr 2026 15:31:11 +0200
> Carlo Szelinsky <github@szelinsky.de> wrote:
> 
> > Hi Andrew,
> > 
> > Thx for helping me! 
> > I thought of keeping the eager path so we still catch broken DT bindings
> > early at boot instead of silently failing later on first ethtool access.
> > But you're right, dropping it would simplify things quite a bit. Do you
> > think that trade-off is worth it? I will follow your lead. 
> 
> On my side I thinks that's a good idea, and I don't see any issue with that for
> now. Oleksij you introduced it here in the first place, is it ok for you?

If I see it correctly - this patch kills all notifications originated
from the PSE core to the users space, until some one calls get/set path
from user space. Means, kernel update may break UAPI behavior of
existing devices.

On other hand, I agree that PSE is not a strickt requirement for PHY
functionality in most cases. At the early stage, as initial PSE support
was introduced, PHYs was kind of representation of the port and related
ethernet interface (needed for LLDP). Are there better methods to solve
it now?

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

