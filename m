Return-Path: <netdev+bounces-264487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O46Fki1qWkZCwEAu9opvQ
	(envelope-from <netdev+bounces-264487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:54:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D22159A6
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 17:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47F40300E2AF
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 16:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AB53D902F;
	Thu,  5 Mar 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PiU4nRI6"
X-Original-To: netdev@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860A17BA6;
	Thu,  5 Mar 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729669; cv=none; b=WrmesAJVMRVNAtvYu/MTptjHQKXl8krbKTVDVEcwco34XC35QCWyp+9PmQ+mEOsZwUcUkzLamgsduvFOPHAnvX8VydWtIO8fQcy6u+uyzxJcQQ9+anDjyTk2VrNeJKLTvkGhNBQP75JOe12nK8J+1LOom8aLB2wsjxDF7fa+HVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729669; c=relaxed/simple;
	bh=Dgtug1RVmGjq0PjxN3ngd8VCVjKlhsQYpnOQzMycfg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ES+oT2FI+vWQbU1DGfJRO5juwoXZB/H4LT1uogjtSCqNDlzgOZfRbST5JkyHHpeioK4or3jOQyRtofUhbV0Uw3RiQxsJROPj2ZbLFzn7ATCUSWxs14ZcHIczWp3AlW28R7kRUnGI29Vu/L6Sp88UDmVs3976TtcvEiITTkoodvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=PiU4nRI6; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Jja7wrC40p+Bof4036cPfBSjAQs0EEkDw+xbTBRU3PE=; b=PiU4nRI6drEHSTaEEUXjfius5J
	IC/RKk2A+HcwU9fapSaG+Kyga6UtqcrmiP3zl4LQjin4XhtJ2R2uaa53nxa3AX4yZdZo8KA7vPBkZ
	6hucouVTs0MD+O1kWEpUbb9QFL6Fcz7U0MPaYocOI2AoNaLj6XYoixhGEzzz7vRC/avq+IGGwggSO
	ziws2F7+j5b2gDfLX2Df8Pbzs93w2EBiK37Qf2gF5LTPTBhQQfJGaAwT5CRq622yp4MbDHeIMXAGI
	/C3ytp7ox4wl0YxntIBoZxGw6lcQjoGauhjEhcA1v4l9gS8rf1+s/LP8fJAlbSPfOZFTIlTXgyT/Y
	1GkLnrzw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1vyBxt-000Jej-2V;
	Thu, 05 Mar 2026 17:54:21 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1vyBxt-0008R8-0T;
	Thu, 05 Mar 2026 17:54:21 +0100
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Woojung Huh <woojung.huh@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject:
 Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver for
 LAN9645X
Date: Thu, 05 Mar 2026 17:54:20 +0100
Message-ID: <7365618.GXAFRqVoOG@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
References:
 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
 <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27931/Thu Mar  5 08:24:23 2026)
X-Rspamd-Queue-Id: DC2D22159A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264487-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ew.tq-group.com:dkim,tq-group.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

Am Donnerstag, 5. M=E4rz 2026, 15:58:16 CET schrieb Andrew Lunn:
> > > > +     /* We configure delays on the MAC side. When the PHY is not r=
esponsible
> > > > +      * for delays, the MAC is, which is why RGMII_TXID results in
> > > > +      * rx_delay=3Dtrue.
> > > > +      */
> > > > +     if (mode =3D=3D PHY_INTERFACE_MODE_RGMII ||
> > > > +         mode =3D=3D PHY_INTERFACE_MODE_RGMII_TXID)
> > > > +             rx_delay =3D true;
> > > > +
> > > > +     if (mode =3D=3D PHY_INTERFACE_MODE_RGMII ||
> > > > +         mode =3D=3D PHY_INTERFACE_MODE_RGMII_RXID)
> > > > +             tx_delay =3D true;
> > >=20
> > > PHY_INTERFACE_MODE_RGMII means that the delays are provided by the
> > > board layout, so this seems wrong to me. Please review the phylib
> > > documentation concerning RGMII delays. I'd like Andrew to comment on
> > > this too.
> > >=20
> >=20
> > The idea with this was, if the PHY does not provide internal delay, then
> > we do it in the MAC.
>=20
> That is not really what we want. The default in Linux is that the PHY
> adds the delays. In general, MAC drivers read the phy-mode, and pass
> it directly to the PHY. The MAC does not add delays. There are a small
> number of boards which don't respect this. In the past, there was been
> claims that an RDK used a PHY which was not capable of adding the
> needed delays, so the MAC had to. In practice, all the PHY drivers in
> linux which supporting RGMII support all four configurations of
> delays.
>=20
> So, the best thing to do is hard code the delays in the MAC to 0, and
> pass phy-mode to the PHY.
>=20
> Now, this is a switch, so there is one complexity. Some switches make
> use of an RGMII port to connect to the host. You then have the host
> RGMII MAC connected to the switch RGMII MAC. Delays have to be added
> somewhere. Since the switch MAC is playing the role of the PHY, in the
> eyes of the host, we allow such a port to add delays.
>=20
> However, this is a multi-giga switch, with high speed SERDES ports. My
> guess is, a SERDES port is used to connect to the host, not RGMII. So
> i would not implement this, until somebody reports having a board with
> RGMII connecting to the host. KISS.

We intend to do exactly that with this switch, just because the host
doesn't support SGMII, just RMII/RGMII.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



