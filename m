Return-Path: <netdev+bounces-264836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB0cB+jsqmmOYAEAu9opvQ
	(envelope-from <netdev+bounces-264836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:04:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBD92235E2
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BD4C30185D7
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB33AE706;
	Fri,  6 Mar 2026 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Oq3Gq5UA"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA234CFAC;
	Fri,  6 Mar 2026 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809445; cv=none; b=pJ+w+EnJpZTN/Ca+W3I6adyq6FH92rkIa+GqkyCrbiNVy78BLS0bqlZsnhoIkBZ0UiKGA7CfGTkDAqPOThgk/MDAwT1h0OPFucWFurG6zYbil7+sJsxPrsoxY05PzlGKwGiBTwc3mPnn6CdVxjGDgR0TMt6vpbjabSsIDf11U2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809445; c=relaxed/simple;
	bh=+GSPKsX+wiZt0TDUlAbsZ6opCaFV0CJfbkG8Q8nCa00=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCKY8pmJo8hw9Whvezadw8/g0YKPiTh+jlp2dg8fXZ+wdtzK5gOBxSI5VE/aoyWvEfigea1rI3XO/Fk+GyII1p3dCseOfD4pzq5FHFryHd8IPxqllVNLM/Mq7dtuqLjerzoABb+NWwQyLFZ2//iz0AQXLI4Q493AQ0RY1yPsrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Oq3Gq5UA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772809442; x=1804345442;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+GSPKsX+wiZt0TDUlAbsZ6opCaFV0CJfbkG8Q8nCa00=;
  b=Oq3Gq5UAcHIt+j2zjVNhaAy8c//6gtmmFsbdgt4FxIuY9mExzwNQL8dA
   cKZrbKXxb+J9YGISXouX0gjlJ2Y2It383axdI6/xLuj5BDdvWdbB4DgVg
   N13yFXW7B10A1Vr+mm71VXLYMhIL8Ivd0jZJW0bVv4GCjA8svgIPX+rQG
   TJKhyK1h+s2+HL7RtEx+VzbHza9s8opNfzBj0R4ef5eapXeuDZ8YWbAfn
   cIPBMFv1oJTYonZSCBCSlR7dgYf+ahzI1Dz9sFgl9RfMFZ05EP/99y7AZ
   2OCJNdKj7cJCljIzKj1+E0DD8Mq7HpxDTIpZO1UoNLSUf+0T8AlL1+p9v
   Q==;
X-CSE-ConnectionGUID: yLYBE7KDSpW0bGTGyPDRgQ==
X-CSE-MsgGUID: IZo8rPJtTGKLzpnGaenkgw==
X-IronPort-AV: E=Sophos;i="6.23,105,1770620400"; 
   d="scan'208";a="54322423"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2026 08:04:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 6 Mar 2026 08:03:39 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 6 Mar 2026 08:03:36 -0700
Message-ID: <b61fd4b0b7b371e1113b2c16873799ff1f745722.camel@microchip.com>
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>, Alexander Stein
	<alexander.stein@ew.tq-group.com>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Fri, 6 Mar 2026 16:03:36 +0100
In-Reply-To: <3de08c66-adc8-455d-b23c-b3464153b38c@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
	 <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
	 <7365618.GXAFRqVoOG@steina-w>
	 <3de08c66-adc8-455d-b23c-b3464153b38c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: AEBD92235E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264836-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 2026-03-05 at 18:37 +0100, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > > However, this is a multi-giga switch, with high speed SERDES ports. M=
y
> > > guess is, a SERDES port is used to connect to the host, not RGMII. So
> > > i would not implement this, until somebody reports having a board wit=
h
> > > RGMII connecting to the host. KISS.
> >=20
> > We intend to do exactly that with this switch, just because the host
> > doesn't support SGMII, just RMII/RGMII.
>=20
> :-)
>=20
> Then i suggest using {rx|tx}-internal-delay-ps as Vladimir suggested.
>=20
>      Andrew

OK, I will use {rx|tx}-internal-delay-ps instead. I can add that the=C2=A0
current EVB board for lan9645x also uses RGMI mac2mac to the host, so there
are already users who would appreciate this. This is the LAN96459 EDS2=C2=
=A0
Daughter Card with part number EV14H52A.


Thanks,
Emil

