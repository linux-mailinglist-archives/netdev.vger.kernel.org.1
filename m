Return-Path: <netdev+bounces-273565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGbnCRily2mhJwYAu9opvQ
	(envelope-from <netdev+bounces-273565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:42:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D6368329
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23D27300BB89
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F543A7838;
	Tue, 31 Mar 2026 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZgAnieGl"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995437F00F;
	Tue, 31 Mar 2026 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953345; cv=none; b=OWR7/gL0KpDmma1gKlYkKKgAXcDcZWb0bEhTXfySAgxgRbUl8egF/DrrDv+hS72XWxORbXxe/hsRTkBuirQHdrHdLNMxpsS1pVV0s3DNjzTJDp6XfY3AlZs6cfjR4YzHinX7BzAWlGkvTjt7hId2MH3+DijDEZO0F9BSjLDgoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953345; c=relaxed/simple;
	bh=WRDi4ZoZCQrKyhbXtpmsIvhL4UK0NUKPu6XCjC501uI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nHWRSkYKc0qcecrM8eLxIOnywjjOlg2UkNPIz2y391FLZk50W9rND4n65xl7dUBpG6d4lhBF6d//a8viNVAU9ggteNXXER0UuZycEGDxj1WPJJKjwomSKjHKfUlJQCw1X86CZz6t+VzkPQdoLQFuP1nyMC+6WUdKcslkA9k6mrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZgAnieGl; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=P+IgeM0E/Q07Sn3hriePPAxBXX3SXluGXODr4AiAiTw=; b=ZgAnieGle6zDl3EZKJg0za741y
	zLirxy2bugV/zO27BFhx+ku4dR6GFfFWtuYzQjuImkfCYLhPK9uMkKfoQEdvi29mCImnUcwR7RtIg
	d7SsfWichOIrd13aI4eXlX4npgSaqznv0AJ80EmsJCikOi05MrDOXJr8dh4ImuXnmpun9fXwcHDuU
	36cqMsfJacfr+oTkytel6paurOlzmPkKklJWqoHRektriOdfEDxeC5SXGzy1r6iQxvRM6Dj12rPS0
	8WFzww8a7xSQnM0YilT0Oc2yQpaXRa8rL68N0NdvnfGA7YGPO+1wtVTZ5a9TeMnM4G7TzKHEHPmyX
	BCdbp99A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7WRe-000A6b-2s;
	Tue, 31 Mar 2026 12:35:38 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7WRd-0004TE-2w;
	Tue, 31 Mar 2026 12:35:38 +0200
Message-ID: <b93cbe578c3a4dec6b3b07780e57d50702a37d3d.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 5/7] phy: ti: gmii-sel: add support for J722S SoC
 family
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
 <kristo@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com
Date: Tue, 31 Mar 2026 12:35:37 +0200
In-Reply-To: <20260330223741.pmrx25cslrlpbcea@skbuf>
References: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
	 <5d00697f133cd33a1df62ac7ebf73e507e49ed2f.1774354734.git.nora.schiffer@ew.tq-group.com>
	 <20260330223741.pmrx25cslrlpbcea@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: Clear (ClamAV 1.4.3/27957/Tue Mar 31 08:24:30 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273565-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nora.schiffer@ew.tq-group.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-0.820];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A19D6368329
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-31 at 01:37 +0300, Vladimir Oltean wrote:
> Hi Nora,
>=20
> On Tue, Mar 24, 2026 at 01:29:41PM +0100, Nora Schiffer wrote:
> > The J722S gmii-sel is mostly identical to the AM64's, but additionally
> > supports SGMII.
> >=20
> > Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
> > ---
> >  drivers/phy/ti/phy-gmii-sel.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-se=
l.c
> > index 6213c2b6005a5..4e242b1892334 100644
> > --- a/drivers/phy/ti/phy-gmii-sel.c
> > +++ b/drivers/phy/ti/phy-gmii-sel.c
> > @@ -251,6 +251,13 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am65=
4 =3D {
> >  	.regfields =3D phy_gmii_sel_fields_am654,
> >  };
> > =20
> > +static const
> > +struct phy_gmii_sel_soc_data phy_gmii_sel_soc_j722s =3D {
> > +	.use_of_data =3D true,
> > +	.regfields =3D phy_gmii_sel_fields_am654,
> > +	.extra_modes =3D BIT(PHY_INTERFACE_MODE_SGMII),
>=20
> I'm not familiar with the hardware, but "mostly identical to AM64, but
> additionally supports SGMII" does not explain why j722s does not inherit
> the features that am654 has (PHY_GMII_SEL_RGMII_ID_MODE and
> BIT(PHY_GMII_SEL_FIXED_TX_DELAY).
>=20
> The phy-gmii-sel from j722s does support RGMII, right? Because in lack
> of the PHY_GMII_SEL_RGMII_ID_MODE feature, phy_gmii_sel_mode() will just
> silently skip the regmap_field_write(regfield, rgmii_id) call, and
> return successfully despite an incomplete configuration.
>=20
> We have the phy_validate() call and phy_ops::validate() through which
> the PHY can report to the Ethernet controller which phy_interface_t it
> supports and which it doesn't. If the j722s doesn't support RGMII, maybe
> it should implement this method.

Thanks for noticing this, PHY_GMII_SEL_RGMII_ID_MODE and
PHY_GMII_SEL_FIXED_TX_DELAY are missing indeed - will fix in v3. I made the
mistake to rebase from an older kernel version where these flags didn't exi=
st
yet and neglected to double check when the rebase went through without
conflicts. I assume I didn't notice any issues because our bootloader left =
the
controller in the correct state.

Best,
Nora


>=20
> > +};
> > +

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

