Return-Path: <netdev+bounces-294357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5Nj2CycpH2ooiQAAu9opvQ
	(envelope-from <netdev+bounces-294357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:04:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8286C63146C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:04:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.de header.s=s31663417 header.b=CBeEiUSI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294357-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294357-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54BDE305A8B8
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9815E397350;
	Tue,  2 Jun 2026 18:58:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55D2F39B9
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:58:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426723; cv=none; b=mOqe2XSHMtbIj+MX+Z0qMCCKebYMgeUiC7ki3acJuWy5/xyYzwzMB5h9p7PVW9Md7TBP+v/Cc/Gedzj0mV3hCBAOvT3pU6UKCVBHUQTu6PNOGBUnHx+0ZPfRAaeS0O8KhhnZ5lwY3Rj5+1JCkSdhM1UqmDcPu/ABPNqI4ynmsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426723; c=relaxed/simple;
	bh=7UQTuy6y7o/GlDsJLR4VTjGu5z3VE8SNP9nj8ghmo84=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nbw6feiW3f/j7dlAV4Rn6BJsdn2+oQ4ldteL/XJrgrVoQStx1HOIm7LawWXN266yNxxry+0eCAeaUt/QtI3iR7VLi7X54L841lBtjsKTEERQ6oAiQExGRDmy7+Lt51qYH/nZ+D3IVZN7wMs+MCUaN/uSyTu+BI7QHQb4Nq1Qg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=CBeEiUSI; arc=none smtp.client-ip=212.227.17.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780426720; x=1781031520;
	i=markus.stockhausen@gmx.de;
	bh=mr+iYDrPUPybXxqrqQWqarTau7OQnnbCWXiK/t9ImvY=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CBeEiUSIiZAmiKbQgDR9rBrvWkr0aWHDj60oLlU7B235/1CtllhO5vwrYs9met1I
	 Rb2sIvZtH5mzYCmodmQhhmWlYlz13fhOs9K9+BesK1yCX3ZiMKBiBhFY1LjzuWHCT
	 n2GfY+M11W4yKQUVAcpxGh4fnplMvN/XKBY0U9r94672wFwVBBFTwPtWaj0L/ZmhE
	 C6r0rqT+flLp5BW6IQedD2Uq9YKJeqwngZtgu5PoGGdp2iqsmnVg56GkuBIyNap3s
	 pNT/Tqwfuid1wAuEpiGGDrz8DrR5cS8RAi+H7wG2eAk/C4yhY+UFWx3lj2rPEbLa2
	 D17P8Rpw6ovLu6Iy8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1wtGRd2omE-00PgoZ; Tue, 02
 Jun 2026 20:58:40 +0200
From: "Markus Stockhausen" <markus.stockhausen@gmx.de>
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<netdev@vger.kernel.org>,
	<chris.packham@alliedtelesis.co.nz>,
	<daniel@makrotopia.org>,
	<mensi@mensi.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>	<20260602052640.93083-2-markus.stockhausen@gmx.de> <20260602110535.13ed4664@kernel.org>
In-Reply-To: <20260602110535.13ed4664@kernel.org>
Subject: AW: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to fwnode API
Date: Tue, 2 Jun 2026 20:58:38 +0200
Message-ID: <00b701dcf2c1$d38215c0$7a864140$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQCd5JwkUMOmloq9EQ3T8rs5/ndXAgDFqLYVAfOlOPe4k+3aUA==
Content-Language: de
X-Provags-ID: V03:K1:W/Q+ShpobolkvHmyLEeHEHeqn96ZA24OKBa5sQBIIJGDn3APm5X
 AN9EfHsRQ+q9aP75BXNlDumTxxqb1UrQVSUZWaeKCE+gM59t1TIR700HgZJnUrG1Q/iZIxX
 GgMYdQGebvh5enNKh4a/rYVivuJgQV5OxO5yiEjey5HFpNi+1457O8NY9xeQ8KJT5XrQrET
 A/YLwU6by8+FbaoNKcAEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tYqPtNF71QQ=;NkmAp0Gcj5hKdC7ELYWJLHDWIOL
 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
 Mc62pYtWyxuV989gg8nVGZ+rX4I=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294357-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:mid,gmx.de:dkim,gmx.de:from_mime,gmx.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8286C63146C

> Von: Jakub Kicinski <kuba@kernel.org>=20
> Gesendet: Dienstag, 2. Juni 2026 20:06
> An: Markus Stockhausen <markus.stockhausen@gmx.de>
> Betreff: Re: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to
fwnode API
>=20
> On Tue,  2 Jun 2026 07:26:33 +0200 Markus Stockhausen wrote:
> > -		struct device_node *phy_dn __free(device_node) =3D
> > -			of_parse_phandle(to_of_node(port), "phy-handle", 0);
> > +		struct fwnode_handle *phy_fwnode __free(fwnode_handle) =3D
> > +			fwnode_find_reference(port, "phy-handle", 0);
> >  		/* skip ports without phys */
> > -		if (!phy_dn)
> > +		if (IS_ERR(phy_fwnode))
> >  			continue;
> > =20
> > -		mdio_dn =3D phy_dn->parent;
> > +		struct fwnode_handle *bus_fwnode __free(fwnode_handle) =3D
> > +			fwnode_get_parent(phy_fwnode);
> > +		if (!bus_fwnode)
> > +			continue;
>
> Variable declarations mid functions are a no-go for netdev.
>
> If you could please move away from using the __free() crap I'd
> appreciate. Clearly missed it yesterday when applying these patches

Thanks for the reminder.

Yesterdays patches should contain neither of those. For the
new series I stupidly assumed that the existing __free usage
is accepted. Will take care about this for v2 and future patches.

Markus


