Return-Path: <netdev+bounces-264837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI+NO1zuqmnNYwEAu9opvQ
	(envelope-from <netdev+bounces-264837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:10:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F24722384A
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 787BD30A3E82
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67413B5843;
	Fri,  6 Mar 2026 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yxwmALe9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4F386C01;
	Fri,  6 Mar 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809731; cv=none; b=OQTDGFm6WKg2nUo6T205cFPR9eTznKgsbaTraHvSCM+uBET8JMv7g7+gaAj5lLGcYdkyFvYYTCZt3GeYTOEdsWiDelWdx1tV/XQsRYrGT3kdQrrD126WfDc1iEbA0gTQRtOYTi8uglg+9k0FpDTz49u6zXKL3YdQYPz21L+daj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809731; c=relaxed/simple;
	bh=yJ8sU+TlFrKAlG4A6/aiSfMrlmTqlIQlugJhyc4OtBU=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dy46yTSdxeoyXJY8sTCHLVJJ1M6GP0cYQPFqwk9LoSZmUbfg1xUwK9/bMMDqh0pC9ZAMCcabUQYx5SFML7hwe+y3dtvWyfm8GwvCIbZP8OIpGuhGMgEPCAyslQhNZXh5pqmU835odI4VX02DPkwVo+47EMIpRfO2ePqZO9f6B2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yxwmALe9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772809728; x=1804345728;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=yJ8sU+TlFrKAlG4A6/aiSfMrlmTqlIQlugJhyc4OtBU=;
  b=yxwmALe9whHctm/YxT4sNSWxbQYjhxCEKY5H3BfLSZJ6yTQ78dv/niL1
   xSbAb69C1Pkrk+bO9BgwQbsq10Fb73sBrYHDLipWhawQb6JeDG1RlCnkG
   M3+OdUW1npyh++dp6vEookqvF/Id7vB7Z2HU5tJ5lvYpKqk7nrK7pEZLz
   zjbIJHa+i/vARvE7m4+JAYeieYG+tkoBmm0PAYVn+jJlZL7/FJhufDvfg
   JHP8mwppAsn0Ckptwi3Be9xVVHXFU5aR93p6wbPyu+c9NQYBHfwX2dmGg
   qXkLOZjVYe+nvl/syiKOwCo71U1+WK+K6a25+7SmLP2tuV7e+RVgSw2e3
   w==;
X-CSE-ConnectionGUID: WXv/RLoQTAqlOa+UztsPjQ==
X-CSE-MsgGUID: t/zBgwaJRIiPQp71I3wxzA==
X-IronPort-AV: E=Sophos;i="6.23,105,1770620400"; 
   d="scan'208";a="285701041"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2026 08:08:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 6 Mar 2026 08:08:04 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 6 Mar 2026 08:08:01 -0700
Message-ID: <7b62ace495084794336b19a9685d6b14ea3981a0.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, <UNGLinuxDriver@microchip.com>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Fri, 6 Mar 2026 16:08:01 +0100
In-Reply-To: <20260305-reliant-parchment-0ff685a9c78e@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
	 <20260303-mosaic-debate-90cf8c8bbb33@spud>
	 <1db45715a3a12b76b838d20c0e5904c3222053e7.camel@microchip.com>
	 <20260305-reliant-parchment-0ff685a9c78e@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4F24722384A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264837-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Action: no action

On Thu, 2026-03-05 at 18:31 +0000, Conor Dooley wrote:
> On Thu, Mar 05, 2026 at 01:57:37PM +0100, Jens Emil Schulz Ostergaard wro=
te:
> > On Tue, 2026-03-03 at 19:04 +0000, Conor Dooley wrote:
> > > On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wrote:
> > > > > +        properties:
> > > > > +          microchip,led-drive-mode:
> > > > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +            description: |
> > > > > +              Set the LED drive mode for the copper PHY associat=
ed with
> > > > > +              this port.
> > > > > +
> > > > > +                0 - LED1 and LED2 in open-drain mode
> > > > > +                1 - LED1 in active drive mode (can be used for s=
ingle-LED
> > > > > +                    configurations requiring active drive)
> > > > > +                2 - Reserved
> > > > > +                3 - LED1 and LED2 in active drive mode
> > > > > +            minimum: 0
> > > > > +            maximum: 3
> > > >=20
> > > > I doubt the DT Maintainers will accept that. This looks a lot like =
a
> > > > value you write into a register. How are active drive and open-drai=
n
> > > > described in other DT bindings? Is there something you can reuse?
> > >=20
> > > I had a quick look and I didn't see anything really that stood out to=
 me
> > > that would be a drop-in replacement.
> > > I also tried looking in the datasheet for more information on these
> > > modes, but I couldn't see anything obvious. For example, there were z=
ero
> > > hits for "drain" in either LAN9645xS or LAN9645xF datasheets.
> > >=20
> > > That said, yea you're right about DT maintainer feelings about it.
> > > There's a couple things I could suggest, but I'd like to know about w=
hat
> > > mode 1 means for LED2 first. If there's actually nothing similar, wha=
t
> > > about representing each led with a child node and having open-drain b=
e
> > > the default with a property in the child for active-drive?
> > >=20
> > > >=20
> > > > For 1, what happens to LED2? Not used at all?
> >=20
> > In mode 1 LED2 will be open-drain. This mode only makes sense if you ha=
ve
> > just 1 LED. With two LEDs mode 0 or mode 3 should be used.
>=20
> Could we then have child nodes for each led, and have a property in each
> that sets the mode to either open-drain or active-drive? Or am I just
> inserting complexity by asking for that?

I think it sounds sensible, I will add this.

Thanks,
Emil

