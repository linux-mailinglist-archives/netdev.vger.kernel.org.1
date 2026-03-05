Return-Path: <netdev+bounces-264394-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPwvE5iDqWkd9gAAu9opvQ
	(envelope-from <netdev+bounces-264394-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:22:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A21AA2128F1
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8ACD301F9A5
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 13:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379A231827;
	Thu,  5 Mar 2026 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pOhzD+7T"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8E225775;
	Thu,  5 Mar 2026 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772716683; cv=none; b=VtT289eEdRMTyHt2nhwFTDYRvQN1TYWv0Wo2du3IUQGPBT8AB3iP3yF2LfbVnmAjm0hNjM7vx48jDOTsXhmrZuV8H0E3+dwbzD8sulq4vsHoqlyus6SjUGEVjzPbuBS+w/jzdtoiXg19v+1jegu51wVmOgS2S0SbXWHz1B3Gc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772716683; c=relaxed/simple;
	bh=pRlHYaIuWKOt/AY7PrVqRWrifQrg94NcWB6EgwXGMeM=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qSjSwOe/MQ5dxX3sZ/YoO8aIICLBS+nr1BCFo5i301FYrqEcAWf5fZVh8tfD2nby5snjC1sWPrRwAiDTVb3XsIZdNNffGRgTXpn8JhXNaR4F9L7NpPQXVgQoI/pquYylrlMx9a9P82rffTRoJt01E2UlZXitetJViAiwR5LIcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pOhzD+7T; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772716682; x=1804252682;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pRlHYaIuWKOt/AY7PrVqRWrifQrg94NcWB6EgwXGMeM=;
  b=pOhzD+7T1GX/AuzjSK1YFVxach3pIh4JlMzEkJcSmTIaNpqPGl+5Mr8a
   KEelMp4x1NhMIzPJbShBit6WesyL1Y6GMkDsbe6AqXb0kMvkDPaCctMI3
   pNEZeUMi5qJZrdyOkJsqav8CIdgiWHm4UHhpONgA+7/H+uZ3mVWrXBgE0
   ea61xGDFxIXQeRdAZSXiIBMt8g8qEBsZEO3qfhI1YQm3hjxKosyIbKlrb
   eLASvGk8rsjhXBbEyYhOBMuoJKadO+86mmfvJsOA01UzYatykkm19rDXr
   R1hEO6nATDl84Rd9xcSPAjpY6R/9qVMPAcd3XRHLOXeCOsBVtAsdbFHqU
   w==;
X-CSE-ConnectionGUID: qvYQB2/bTLWgzctEAuslXg==
X-CSE-MsgGUID: ASJayziXQkmbRE54OTJYBg==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="285649053"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2026 06:18:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 5 Mar 2026 06:17:40 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 06:17:37 -0700
Message-ID: <acb32c15be9625716a899c2b955ed0c8a59a4eed.camel@microchip.com>
Subject: Re: [PATCH net-next 7/8] net: dsa: lan9645x: add mac table
 integration
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Vladimir Oltean <olteanv@gmail.com>, <UNGLinuxDriver@microchip.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung
 Huh <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Thu, 5 Mar 2026 14:17:36 +0100
In-Reply-To: <8a08bb19-f565-4363-9617-a752c83a762e@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-7-bff8ca1396f5@microchip.com>
	 <20260303152709.nospd2qq3dju2tev@skbuf>
	 <67a34d22b8f59964fd3bfaee99c8418a21526f3e.camel@microchip.com>
	 <8a08bb19-f565-4363-9617-a752c83a762e@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A21AA2128F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264394-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,microchip.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Action: no action

On Wed, 2026-03-04 at 16:34 +0100, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > > > @@ -6,3 +6,4 @@ mchp-lan9645x-objs :=3D lan9645x_main.o \
> > > >       lan9645x_port.o \
> > > >       lan9645x_phylink.o \
> > > >       lan9645x_vlan.o \
> > > > +     lan9645x_mac.o \
> > >=20
> > > Is there some particular ordering here? Because it's surely not
> > > alphabetical.
> > >=20
> >=20
> > I just add new files at the end, I thought that made the most sense. Sh=
ould they be
> > sorted by name?
>=20
> This is part of the whole 'sorted' story of lists in Linux. By keeping
> lists sorted, insertions are spread out across the list. That reduced
> merge conflicts. Within one driver, conflicts are less likely, but
> always adding to the end of Makefile, Kconfig, core code, etc will see
> merge conflicts if we have two developers adding drivers at the same
> time.
>=20
> So if you have any sort of list of items, please try to keep it
> sorted.
>=20
>         Andrew

Ok that makes a lot of sense. I will make sure my lists are sorted.

Thanks,
Emil

