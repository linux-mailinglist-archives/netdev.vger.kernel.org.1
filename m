Return-Path: <netdev+bounces-296411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 01S+BqZ9Jmp5XQIAu9opvQ
	(envelope-from <netdev+bounces-296411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319536540FA
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 10:30:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microchip.com header.s=mchp header.b=RxsRLJnF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296411-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296411-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microchip.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A872300C7DF
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8E3A9DB1;
	Mon,  8 Jun 2026 08:20:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA143A963B;
	Mon,  8 Jun 2026 08:20:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906818; cv=none; b=rkDXgtnomAXoEIEowzaYeOGD4rvLWMFOGn1IovOOrkk5h+OEQrTfK6C2McTN/DlGMZHZP//auJxEpgCn8+DAbGuhIiyEupvXiDnbdHM8jUWAnFMky2HkkmuRg0pqrZZfjmVP2xjvNWvhIewlUnFobIDkgTuB4YiS5VRjfH7N0v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906818; c=relaxed/simple;
	bh=2P0JCCFHe8qJo3+Agjk85/B2qu7PC9Alor8D2YtYYq0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OxOmnT6QB193ox7j2sEWDdPhgUrBEa9ogNsNWxfr58GVZ2BvX3sIWlRBgQHVz0tjwpyF3CWq1XytBu4ql4zld/dmKrJrgYPnE3sBVU/E1z3LiD0YKQTjNEwzU6wjk4GR1RxHE3FLcJhP5m6fUuqNXDXp8vCRzdBS4hakNVHSEnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RxsRLJnF; arc=none smtp.client-ip=68.232.154.123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780906811; x=1812442811;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2P0JCCFHe8qJo3+Agjk85/B2qu7PC9Alor8D2YtYYq0=;
  b=RxsRLJnFU3pSAlPEMNH2JJpLZhBVc+9fJJmkYIsvvdp0U60zPcJDbk01
   aSSnUcYwM8N6NuWfIc+rHz6YTQSdWoeLDoQ1bX3FkbjWGUBWxh3caDViY
   gMM0pP92+BDzdSfAKjyBg1lATLTUmC/WEKKqj22PGOKIiLTxaiWT+xNKH
   mnGVf3u0fFMP48UPElY8dTfuAhloFbeFXeoHNl7uRl1s6PPNuQ6i9zFTW
   wyDJ2petL6XjwET+GLkb2N4qB4MwIW0QIrnXMwDogw3kOmfH/+RUceiV9
   URXrVn/rnJvn939/ctD36LgIyCItr3jIJzFecabY06GLYgBbIRJiBIc5e
   g==;
X-CSE-ConnectionGUID: f/iUYFAzRKi7koY8Uf2ahg==
X-CSE-MsgGUID: lKbGWTyKQjO2OQ9NHHjT2w==
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="59143377"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 01:20:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 8 Jun 2026 01:20:03 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Jun 2026 01:20:00 -0700
Message-ID: <b785fa848435bba0d94a54066a05956aeeb81257.camel@microchip.com>
Subject: Re: [PATCH net-next v7 4/9] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Mon, 8 Jun 2026 10:20:00 +0200
In-Reply-To: <d4fa4e93-9373-47a9-aaa9-e3d687c58d82@lunn.ch>
References: <20260603-dsa_lan9645x_switch_driver_base-v7-0-b2f90e676707@microchip.com>
	 <20260603-dsa_lan9645x_switch_driver_base-v7-4-b2f90e676707@microchip.com>
	 <d4fa4e93-9373-47a9-aaa9-e3d687c58d82@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296411-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:UNGLinuxDriver@microchip.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:woojung.huh@microchip.com,m:linux@armlinux.org.uk,m:Steen.Hegelund@microchip.com,m:daniel.machon@microchip.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 319536540FA

On Wed, 2026-06-03 at 14:37 +0200, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Wed, Jun 03, 2026 at 09:25:23AM +0200, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > Add the LAN9645X basic DSA driver with initialization, parent regmap
> > requests, port module initialization for NPI, CPU ports and front ports=
,
> > and phylink integration for MAC side configuration.
>=20
> A terminology question. How does a NPI port differ from the CPU port?
> The datasheet defines NPI as "Node Processor Interface", which sounds
> a lot like the CPU port.
>=20
>   4.18 CPU Port Module
>=20
>   The CPU port module (DEVCPU) contains eight CPU extraction queues
>   and two CPU injection queues. These queues provide an interface for
>   exchanging frames between an external CPU system and the switch. In
>   addition, any Ethernet interface on the device can be used for
>   extracting and injecting frames. The Ethernet interface used in this
>   way is called a node processor interface (NPI).
>=20
>         Andrew

With the way this driver works they are basically the same. In the datashee=
t
they are seperate because it is possible to extract frames from the CPU por=
t to the
CPU using different methods, such as raw register IO, Ethernet interface or=
 FDMA for
chips which has an internal cpu subsystem.

If you use an Ethernet port that is called an NPI port in the datasheet. As=
 the
snippet says it is the physical port used for injection/extraction from a C=
PU port.

Since lan9645x does not have an internal cpu subsytem, this particular feat=
ure fits
nicely. There are actually two CPU ports at index 9 and 10. But we only use=
 9 now. It
would be possible to configure 9 for NPI injection/extraction and 10 for re=
gister
based injection/extraction say.


Emil

