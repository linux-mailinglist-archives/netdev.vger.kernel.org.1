Return-Path: <netdev+bounces-275923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLMrLnjP1GksxwcAu9opvQ
	(envelope-from <netdev+bounces-275923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1546C3AC113
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5803033F89
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4D3A3E9A;
	Tue,  7 Apr 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sw2RAVIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F547378815
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554287; cv=none; b=u8g1QZyiXwmKH7INm2uIQ2YN7whIcnBgXXUwu9/tdOAOZPbdTQi+nCmE3JMZEtWu+0zCruUM6vRZi7G51AR0Fmczz26ZM82DumSKokD9rH0kzjcVa577SnpUBTg9b82gl7ECL55cLzHT+H7ta/gA568sACktRSS3u+uaX3OgGpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554287; c=relaxed/simple;
	bh=Vi00lAk+1qgnzJJANLEHB44d1aaFtwLMLqStUns0kJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqILV8ewKvsLTSP3pwyk5pIvaaloyKlhbv7/jFE6KUSkT7Ay0SHNmlWjDs46o1SBMQMtYJItwp7k4Q0UZI5RNj8zag+L+NyLSx3KSybXesM/M1Q7LamiEs6xhyWu74AuiF83utBnJyKvSLBV+h9Gax3Cwj6mPDVtV0YYFvdLPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sw2RAVIZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F2CDB4E42933;
	Tue,  7 Apr 2026 09:31:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BD4D8603C7;
	Tue,  7 Apr 2026 09:31:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E92F10450232;
	Tue,  7 Apr 2026 11:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775554282; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=D8dmyXYapOZa14wipGKKif+mx1O0Tdg9YW3oB9zwcqA=;
	b=sw2RAVIZyHa0cXzOYQgvWIfFBAnsUo0GhCmgX5HzVjbkJSPkLElOMeTAE0pWGX3yvouB6E
	/DqEum1njmQ8DJpukdA2d9l94Q9aLrbeogj6sctzeHPFlMIaPUC+IDd0uAq/3B6tUseVU+
	K5Xspa7PFdT9AEMzSyK2bhWeNznJqsmvQ798aG1CuJFYxBSPmLuSXsceP0orMOj/bwknjW
	zWEoMCsk2rxbNtO0SMxstKkcgiWcuRns8YclEaAEH2d8IIPF2L0uX7r51xdLMnTqyQLFp5
	nmWCBfoN6lcyc2CSbpBP8VDDuL+YuZgb/zTo8AZ+aZBPye7iUkdG0giQj4H6Sg==
Date: Tue, 7 Apr 2026 11:31:16 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Carlo Szelinsky <github@szelinsky.de>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Jakub
 Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <20260407113116.59cd563c@kmaincent-XPS-13-7390>
In-Reply-To: <adNx9z-AYxwpL2yH@pengutronix.de>
References: <61561526-1e8c-4d0c-a0ff-56da25ee6531@lunn.ch>
	<20260403133111.3304497-1-github@szelinsky.de>
	<20260403153849.2ed7d342@kmaincent-XPS-13-7390>
	<adNx9z-AYxwpL2yH@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275923-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[szelinsky.de,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:url,pengutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1546C3AC113
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 10:42:31 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi,
>=20
> On Fri, Apr 03, 2026 at 03:38:49PM +0200, Kory Maincent wrote:
> > On Fri,  3 Apr 2026 15:31:11 +0200
> > Carlo Szelinsky <github@szelinsky.de> wrote:
> >  =20
> > > Hi Andrew,
> > >=20
> > > Thx for helping me!=20
> > > I thought of keeping the eager path so we still catch broken DT bindi=
ngs
> > > early at boot instead of silently failing later on first ethtool acce=
ss.
> > > But you're right, dropping it would simplify things quite a bit. Do y=
ou
> > > think that trade-off is worth it? I will follow your lead.  =20
> >=20
> > On my side I thinks that's a good idea, and I don't see any issue with =
that
> > for now. Oleksij you introduced it here in the first place, is it ok for
> > you? =20
>=20
> If I see it correctly - this patch kills all notifications originated
> from the PSE core to the users space, until some one calls get/set path
> from user space. Means, kernel update may break UAPI behavior of
> existing devices.

Indeed you are right, I have missed this point.

> On other hand, I agree that PSE is not a strickt requirement for PHY
> functionality in most cases. At the early stage, as initial PSE support
> was introduced, PHYs was kind of representation of the port and related
> ethernet interface (needed for LLDP). Are there better methods to solve
> it now?

Now that Maxime has merged the phy port representation (mdi) it could be bi=
nding
to it. But we should not break the current uAPI of having it bind directly
to the PHY. Thing is, the issue will be still present as PHY ports are only
created and initialized at probe time.

We should be able to get the PSE control either at PSE register time or at =
PHY
(or PHY port) probe time.

I just see there is more discussion about it in the thread.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

