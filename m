Return-Path: <netdev+bounces-171743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A7A4E685
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13361460F94
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691232D1F49;
	Tue,  4 Mar 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o9OpQSWC"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA82259C87;
	Tue,  4 Mar 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104925; cv=none; b=Wl94H1/bjM/1z+ymiclZZvOyt7VxqQ/gQRTOFBkf2SDNGbC6HMDvBeDqLED93MGsF266DT+/xEmRNdco31kKX9+6xZeeCSioRYKfX2iUyww59qRg1ekklGb6TV2OcPC29mQyPC7TWzu8KsQuDtqNLtOSUY9zK9GwZTxaQVax4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104925; c=relaxed/simple;
	bh=FaitQFZZEqjD/jJ9v92zye6uteHEsM/IP3Sgot+eYM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nozAVSKnczdqDsGJGVLHChw8ykn9QcI7018pxhwtYo2Coa25XngQ87y2IWAxcdpsynCf1J5n6SpD8WvewaDuj8QyqAMj4oJAArRsn7yX8BqXMAjF4OR08EDjdjzDrtP4UL1ns/Jq18i3EK6dAseAaukq4jfmViWgHiQSSVvCgkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o9OpQSWC; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C0A8720479;
	Tue,  4 Mar 2025 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741104921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqAT5+Gi1O68uLcYreVHzC9MDAGC4lcpXT9gC3flVdI=;
	b=o9OpQSWCPcLhU75kNX2KB5/lnvHNChPaWtHihmyulicnkYRnOi0iBSibqDPh1HIurd5oXa
	I8YiOwkICGHH3ijfJHOspj/VJLvjtz2DlSh+Bm5gAyC7rHHtSLhXp143kVLyZS0xblCbxy
	GnHWOPVcYD+nAQ+wn2K1khX2vrkj+D8MMHwmxxkUTTFCFshXEbkYNMnhpxi7X2Lc7pqTfa
	cNNZwJoEJqtLXnVLoXIKDuvzE+ZQybJEVzqdOfexBoUSMDrrWx0uFTJd3uDtXqx/sUU5je
	uSScUY8lwpYIcZOGgvyNhh4fd3+xdXA3FGhygoOH6J5hzvElm5v03SYg1D1rww==
Date: Tue, 4 Mar 2025 17:15:15 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net] net: ethtool: Set the req_info->dev on DUMP
 requests for each dev
Message-ID: <20250304171515.297d15df@fedora.home>
In-Reply-To: <20250304170051.607097e9@kmaincent-XPS-13-7390>
References: <20250302162137.698092-1-maxime.chevallier@bootlin.com>
	<20250304170051.607097e9@kmaincent-XPS-13-7390>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuefhfefggfdthffghfdvhffhhfetuedtkeetgffhteevheehjeejgfduieduhedunecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrt
 ghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi K=C3=B6ry,

On Tue, 4 Mar 2025 17:00:51 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Sun,  2 Mar 2025 17:21:36 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
>=20
> > There are a few netlink commands that rely on the req_info->dev field
> > being populated by ethnl in their ->prepare_data() and ->fill_reply().
> >=20
> > For a regular GET request, this will be set by ethnl_default_parse(),
> > which calls ethnl_parse_header_dev_get().
> >=20
> > In the case of a DUMP request, the ->prepare_data() and ->fill_reply()
> > callbacks will be called with the req_info->dev being NULL, which can
> > cause discrepancies in the behaviour between GET and DUMP results.
> >=20
> > The main impact is that ethnl_req_get_phydev() will not find any
> > phy_device, impacting :
> >  - plca
> >  - pse-pd
> >  - stats
> >=20
> > Some other commands rely on req_info->dev, namely :
> >  - coalesce in ->fill_reply to look for an irq_moder
> >=20
> > Although cable_test and tunnels also rely on req_info->dev being set,
> > that's not a problem for these commands as :
> >  - cable_test doesn't support DUMP
> >  - tunnels rolls its own ->dumpit (and sets dev in the req_info).
> >  - phy also has its own ->dumpit
> >=20
> > All other commands use reply_data->dev (probably the correct way of
> > doing things) and aren't facing this issue.
> >=20
> > Simply set the dev in the req_info context when iterating to dump each
> > dev.
> >=20
> > Fixes: c15e065b46dc ("net: ethtool: Allow passing a phy index for some
> > commands") Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.=
com>
> > ---
> >=20
> > Fixes tag targets the phy-index commit, as it introduced a change in
> > behaviour for PLCA. From what I can tell, coalesce never correctly
> > detected irq_moder in DUMP requests.
> >=20
> > We could also consider fixing all individual commands that use
> > req_info->dev, however I'm not actually sure it's incorrect to do so,
> > feel free to correct me though.
> >=20
> > Maxime
> >=20
> >  net/ethtool/netlink.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> > index b4c45207fa32..de967961d8fe 100644
> > --- a/net/ethtool/netlink.c
> > +++ b/net/ethtool/netlink.c
> > @@ -582,6 +582,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
> >  		dev_hold(dev);
> >  		rcu_read_unlock();
> > =20
> > +		ctx->req_info->dev =3D dev; =20
>=20
> I would rather put it in ethnl_default_dump_one() before
> ethnl_init_reply_data() call.

Ah yes true, that'll be more consistent with the other callpaths.

> With this change:
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> Tested-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you for testing, I'll respin.

Maxime

>=20


