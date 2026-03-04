Return-Path: <netdev+bounces-263890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGAUDIJXqGkYtgAAu9opvQ
	(envelope-from <netdev+bounces-263890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:02:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7429203955
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00D6A307ED38
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60284358385;
	Wed,  4 Mar 2026 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AjdyhL1H"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312933469E6;
	Wed,  4 Mar 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639737; cv=none; b=Hs3M9MS8Qoc/ZP/QyN9NdYnQs9zWZxsXqNrjb18joK+KA2YguoyoPlFvwBWsdbCLqOcQzSlB/4CHRC2pJvuxhriVzZLklm2JVyJlChTk2I8vkeLEJoL8hgBIdkCAc75jfT52SDmjBBD9nt5/BehRFli8D5Xtzg3V3y1NFwlh0Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639737; c=relaxed/simple;
	bh=Zka+7OBqpLBEBIgn7mVyzYh1jfTmWqJKCS82aFkXlJ0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DxhycVG/jR03w9v0WhgkRmO4iEdAIYSS8WwYIwfAQhK5ki3JGTJgllVtACEwpCbmF/dQ2b4WY5QE4DYrU8mZHGXfN+cIKkoH7fZaG+MhvaVWNdHax4obBR5dcWIXfriUmyqVgJyEHn26hYVFh7SVZYmRSXg5owHB4x2iaE0xsnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AjdyhL1H; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772639734; x=1804175734;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Zka+7OBqpLBEBIgn7mVyzYh1jfTmWqJKCS82aFkXlJ0=;
  b=AjdyhL1HFhn/Yl4NPAPMW9vexhlgiWUvTZif7wD37jkYAgnLyBJs5J9x
   zpQd3omL55oC8+XOTv95tX9UbSAua7BX6kRu7vg+QTjSSI0RKLLR7Iwkx
   JKITCva7trGHmNRu8qvzIYpVwowD6afVH3RHdxm6ljTVOZCvIxEAcrhkC
   lkypSbgh14YyEoVmOoV+h6/XZItojM7veGjdUHFu3fFsHACo9+kfJltlP
   Nfc5ZSaDl1CSuxYDb8cbqbTeRb1bEyvSaxGc/5PlWSVg/1PKKDl5M7Dqu
   XtCYbpHKDCepmUfpUt/P8VV8yUoOnMtQy6dq9b0TtghYohiKMjpHGOTHt
   Q==;
X-CSE-ConnectionGUID: mbILFHeVTQeYqT6nr1q4aw==
X-CSE-MsgGUID: KbDH0hd+QUiLm4eJAdiHRA==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="54216349"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:55:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 08:55:25 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 08:55:22 -0700
Message-ID: <82138ba65f126f6aecc374d1eb41a33e9b27f521.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
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
Date: Wed, 4 Mar 2026 16:55:22 +0100
In-Reply-To: <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A7429203955
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263890-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 15:18 +0100, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > +        properties:
> > +          microchip,led-drive-mode:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            description: |
> > +              Set the LED drive mode for the copper PHY associated wit=
h
> > +              this port.
> > +
> > +                0 - LED1 and LED2 in open-drain mode
> > +                1 - LED1 in active drive mode (can be used for single-=
LED
> > +                    configurations requiring active drive)
> > +                2 - Reserved
> > +                3 - LED1 and LED2 in active drive mode
> > +            minimum: 0
> > +            maximum: 3
>=20
> I doubt the DT Maintainers will accept that. This looks a lot like a
> value you write into a register. How are active drive and open-drain
> described in other DT bindings? Is there something you can reuse?
>=20
> For 1, what happens to LED2? Not used at all?
>=20
>     Andrew

Yes, this is written to a register. I did not know that was a no-no.
I believe LED2 is not used, but I will ask design about 1 and LED2 to
be sure. The register model does not mention LED2 here.

Thanks,
Emil

