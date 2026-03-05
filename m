Return-Path: <netdev+bounces-264384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDd8MOl9qWkg8gAAu9opvQ
	(envelope-from <netdev+bounces-264384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:58:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC565212368
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 652B93006038
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6539FCD4;
	Thu,  5 Mar 2026 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xJAILD6E"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048A27A133;
	Thu,  5 Mar 2026 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715492; cv=none; b=FKPlp27xI+Fdm/8MxIXu7SdKDpVVaMKGwdLIzACCcqVqo3pIUA56UfF6XOKYMj9kpCd0BSuw8pO+yrOAe0mws20Trja7n5UeIpjLHoz88zrhJ2S6VRG2MTVMaFRVIT6z1mze6AGVPt4T3OQV7aeYgE8/s1w+LS6YjMRfeRXyPh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715492; c=relaxed/simple;
	bh=gUMw0bsomQGguuQoy5ja6PU2K1ToYQQzpr6OG5I1jD4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZvxhWT3L1piZb/Ase8ZaNnyLPq3/1zimKikR7749R8PiFcVGiPE7UXU+UepmKFawgwCE+DAQiaYWtOm2L7iXnLW2iYFOcl602iXyEraYlsxS8WhQZpT8wYPJbIFFtqYAiVTrUrHRL05SKw7pz59x9gAsQYowv03hAdTEHfsCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xJAILD6E; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772715491; x=1804251491;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gUMw0bsomQGguuQoy5ja6PU2K1ToYQQzpr6OG5I1jD4=;
  b=xJAILD6EFSBnqRP1mFB7rJhITjV0i19hLtuDJKIJWtuIC5Ya8sggnJZq
   4UzjdhVlJDnlTMRXMaKBSjNKN1hbLe/ZMkSSBEzQpinp37buTN0t7/O4+
   zBQIJQ8UmuRPEtMdf9RW+lDkDDnRWWNG3Q3up6bQOfUGyjqr9Wou5vRPd
   Jjio4hUToYWN8dlGPk1JhGCbsIn3r8qgls2Fj3SSc8ykgQzm9sTWkYZ0z
   2A4LgboF44tKAex1VbHu6F/6d5Cbh7nNWf1QdmrATbSb2Jo7DSCGOMX+L
   TzgAYvRVRsmFpz2TEZwKVje/LENxQ0zP7fvadb2MzaHxFLazwHhv9+wro
   w==;
X-CSE-ConnectionGUID: 4Xb2lvBgRsyARSuCBKYbiw==
X-CSE-MsgGUID: F+cfBPhfTZGO4+LwlI77sg==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="285647998"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 05:58:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Mar 2026 05:57:41 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 05:57:38 -0700
Message-ID: <1db45715a3a12b76b838d20c0e5904c3222053e7.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: <UNGLinuxDriver@microchip.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Thu, 5 Mar 2026 13:57:37 +0100
In-Reply-To: <20260303-mosaic-debate-90cf8c8bbb33@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
	 <20260303-mosaic-debate-90cf8c8bbb33@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: BC565212368
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264384-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 19:04 +0000, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wrote:
> > > +        properties:
> > > +          microchip,led-drive-mode:
> > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > +            description: |
> > > +              Set the LED drive mode for the copper PHY associated w=
ith
> > > +              this port.
> > > +
> > > +                0 - LED1 and LED2 in open-drain mode
> > > +                1 - LED1 in active drive mode (can be used for singl=
e-LED
> > > +                    configurations requiring active drive)
> > > +                2 - Reserved
> > > +                3 - LED1 and LED2 in active drive mode
> > > +            minimum: 0
> > > +            maximum: 3
> >=20
> > I doubt the DT Maintainers will accept that. This looks a lot like a
> > value you write into a register. How are active drive and open-drain
> > described in other DT bindings? Is there something you can reuse?
>=20
> I had a quick look and I didn't see anything really that stood out to me
> that would be a drop-in replacement.
> I also tried looking in the datasheet for more information on these
> modes, but I couldn't see anything obvious. For example, there were zero
> hits for "drain" in either LAN9645xS or LAN9645xF datasheets.
>=20
> That said, yea you're right about DT maintainer feelings about it.
> There's a couple things I could suggest, but I'd like to know about what
> mode 1 means for LED2 first. If there's actually nothing similar, what
> about representing each led with a child node and having open-drain be
> the default with a property in the child for active-drive?
>=20
> >=20
> > For 1, what happens to LED2? Not used at all?
> >=20
> >     Andrew

In mode 1 LED2 will be open-drain. This mode only makes sense if you have
just 1 LED. With two LEDs mode 0 or mode 3 should be used.

Thanks,
Emil

