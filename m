Return-Path: <netdev+bounces-265503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBo7KNO2rmnMIAIAu9opvQ
	(envelope-from <netdev+bounces-265503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:02:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 109DC2385F4
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 13:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0651D30157C8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D54439B4A5;
	Mon,  9 Mar 2026 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eaXbyg3e"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67BE2D8760;
	Mon,  9 Mar 2026 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057742; cv=none; b=HJLZJQRIY0PGt3S9Qx2HysWZ4W3NrYxLP9f9DN9cYpf/gw5Tq8z1g0+12N9kNndYyJS/RoEtgxE408nP4U8445qjaIOArCbzzxT4dgbl5MsGq5cVLR+vJde4AsIN+alY6z/A/896sWCCdEgeNoNj5Q/O1K7q7KewsJMpyJPJnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057742; c=relaxed/simple;
	bh=wGTbkfjeanjsGHLlBnciuEAG03Lka3mLWvD+UVwQsPE=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CqnqJzJTZOy5Cx9BrFj0btis9y5wCxRCwpWppoZzRhOMupGjndDLztf9N16eWMfkpdP1jNIPMfBkbc4EoKaAl1mRJLbZKlWZptZmWNgDNc9tNaEbFUhIosZLb4HqN9AtEE6zYxU0l47zuCcfkKLK+CM680VPlK9fBoLG8ibTRdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eaXbyg3e; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773057740; x=1804593740;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wGTbkfjeanjsGHLlBnciuEAG03Lka3mLWvD+UVwQsPE=;
  b=eaXbyg3eRpWIm2BgkBnQcSGh1HlCiliAXMBbEerDvBWAZWBVWBEm6mj/
   xzfHDBdlX2Pfy0ERKMbx1/sJGgWF53QFOAti2H88EdxmwhUSVIdd0myhk
   zrV3ror1q1eLqWnWQWlkDpxlC7Gi5C1Vs4xz14trP1aVPxP1VnnQ+7YTw
   eL6CgBipIxqquYM/m5Ozw8lUarAxGB0u1pVoPGbNvUiNv8XgW+1EzEssE
   1xhlzJJ2p/bRM0YvWTX2Caw0vIT+cGpKOo5WsfKqQ3inDz/z5SW58cLCI
   o3945qO7ZMCPNzgLSwBG7ELvJmcJjbtWavIRHIo13ss7WeowmKc/md4YV
   A==;
X-CSE-ConnectionGUID: 8R/phQWZRI6fu2TD0sTFng==
X-CSE-MsgGUID: 6AT/zOu/RQyzargWDNfFQA==
X-IronPort-AV: E=Sophos;i="6.23,109,1770620400"; 
   d="scan'208";a="221669965"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Mar 2026 05:02:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 9 Mar 2026 05:01:49 -0700
Received: from [10.205.29.43] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 9 Mar 2026 05:01:45 -0700
Message-ID: <1f2635864103b5de974c95ea60c0e1fac1d07302.camel@microchip.com>
Subject: Re: [PATCH net-next 4/8] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexander Stein <alexander.stein@ew.tq-group.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>, Vladimir Oltean
	<olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Mon, 9 Mar 2026 13:01:34 +0100
In-Reply-To: <332bf6a6-ce9f-46d7-a2f9-10b5531598d2@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <32b7267f84b60a4632eb643fd0b999d03c630a1d.camel@microchip.com>
	 <052cf8c8-c60b-461a-86ce-aac8d7ebf4d9@lunn.ch>
	 <7365618.GXAFRqVoOG@steina-w>
	 <3de08c66-adc8-455d-b23c-b3464153b38c@lunn.ch>
	 <b61fd4b0b7b371e1113b2c16873799ff1f745722.camel@microchip.com>
	 <332bf6a6-ce9f-46d7-a2f9-10b5531598d2@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 109DC2385F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265503-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[ew.tq-group.com,armlinux.org.uk,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 2026-03-06 at 17:33 +0100, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Fri, Mar 06, 2026 at 04:03:36PM +0100, Jens Emil Schulz Ostergaard wro=
te:
> > On Thu, 2026-03-05 at 18:37 +0100, Andrew Lunn wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> > >=20
> > > > > However, this is a multi-giga switch, with high speed SERDES port=
s. My
> > > > > guess is, a SERDES port is used to connect to the host, not RGMII=
. So
> > > > > i would not implement this, until somebody reports having a board=
 with
> > > > > RGMII connecting to the host. KISS.
> > > >=20
> > > > We intend to do exactly that with this switch, just because the hos=
t
> > > > doesn't support SGMII, just RMII/RGMII.
> > >=20
> > > :-)
> > >=20
> > > Then i suggest using {rx|tx}-internal-delay-ps as Vladimir suggested.
> > >=20
> > >      Andrew
> >=20
> > OK, I will use {rx|tx}-internal-delay-ps instead. I can add that the
> > current EVB board for lan9645x also uses RGMI mac2mac to the host, so t=
here
> > are already users who would appreciate this. This is the LAN96459 EDS2
> > Daughter Card with part number EV14H52A.
>=20
> O.K. Do you plan to add a DT file for this? Since it is a daughter
> card, is it a DT overlay? I see there is an I2C EEPROM, used for board
> identification. So that tells you which overlay to load?
>=20
>         Andrew

Yes, we would like to add a DT, and it would be an as an overlay. I believe
the EEPROM was intended for the firmware in unmanaged mode. We do not use
it for managed mode at the moment.

Thanks,
Emil

