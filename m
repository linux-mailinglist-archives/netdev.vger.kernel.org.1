Return-Path: <netdev+bounces-264385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dbeoMSp/qWnA9QAAu9opvQ
	(envelope-from <netdev+bounces-264385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:03:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2450921255D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4A913148E37
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252BF3A0E95;
	Thu,  5 Mar 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1WZnTp+N"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C58378D8E;
	Thu,  5 Mar 2026 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715593; cv=none; b=lQznCMc9pYioIqJauLgTMOQXCIvbWTUPVEEsHSoIc2Lodr2dmkR8c+Q1TlBGE/WfQzmufOWNk5F4LGNjE48oG1DTpkJD6bcq8kCMsjHet608JeUCKxXOyi8Qje9BQcTYLX/pl92PXfyyysur3jiokT7Wn6IsNr7vFkX4+5N2yNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715593; c=relaxed/simple;
	bh=bOcAwKTNzkTznQVg72/ZDsD5vBxH2i0CoWWm5WnJStU=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AdauWe4sXNH0FL7F4ODqAa8xrlmkZXDX4YWJWFkdGjQDLdX74PFEDNqiJ2gVYRGSoYspbJFz4nCIBj4MvZJNV/an8iQ3bgqrQSrXpalLUk/VWfQuDgKd+ve6KFnsKh+gCXtqy4p9aec81bXSXSojzw7cb5MzcGbx5SViJd0psBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1WZnTp+N; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772715592; x=1804251592;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bOcAwKTNzkTznQVg72/ZDsD5vBxH2i0CoWWm5WnJStU=;
  b=1WZnTp+NeRwgQSwbxnrLGdsiF/wQrmzel7tU9QiNAofQU8UoGuSLogWh
   964m+KxnoagXoBsGvDbBiLRLrz+wRZEc6IZq4lx2yKvx66MFBtg3jBZVu
   20Hmpj8ds70o1L2+/Hygo3toBhw1mEgWqwTHlGmkMg3pZC8zcOedqRkXd
   Sq0HqUeNcwaGB38GUVsivB0CqSTFTpxHulpYNvUDLd9Dk3UMdnRzj8Yq1
   NZI2t+vMdC4rJ2SRj7NrQYaJpnwqSPSA4PJ4UXGWUazXMzYhPg3CCE/ji
   jm7rnokZx5AdHsNbk35DiVAPQRS/TUzW40Rh9GNkCe+l6j9ISkiXvsM9m
   g==;
X-CSE-ConnectionGUID: Sf8rCq1BRVywokuql48qeQ==
X-CSE-MsgGUID: y2T0iinuQUqoYmzJDoHe9A==
X-IronPort-AV: E=Sophos;i="6.23,103,1770620400"; 
   d="scan'208";a="221534946"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2026 05:59:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 5 Mar 2026 05:59:30 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 05:59:27 -0700
Message-ID: <5a24fedf4d65cfa467490951b3323e0b2507be86.camel@microchip.com>
Subject: Re: [PATCH net-next 1/8] net: dsa: add tag driver for LAN9645X
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
Date: Thu, 5 Mar 2026 13:59:26 +0100
In-Reply-To: <8ce78efd-2304-43d2-a755-4189fcbffb25@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
	 <c0213890-ef36-435c-aa73-869ee5e849d5@lunn.ch>
	 <1ceeb7fb0abc89f4b384c9d73b7d29c73bb8d53b.camel@microchip.com>
	 <8ce78efd-2304-43d2-a755-4189fcbffb25@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2450921255D
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
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264385-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On Wed, 2026-03-04 at 16:14 +0100, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > > These functions are big enough i would place them into the .c file.
> > > Then, normally, i would say, please don't use inline in a C file. But
> > > here we are in the fast path. Have you tried this with and without th=
e
> > > inline? How does it change the object size and performance?
> > >=20
> >=20
> > I did test performance back when I first implemented this. I had some i=
ssues
> > getting gcc to inline the functions, and that hurt performance quite a =
bit.
> > But I did not look at object size though. I moved them to the header so=
 I could
> > add the inline. I can move them to the .c file in the next version.
>=20
> Developers often get inline wrong:
>=20
> It is used on the slow path, so all it achieves is bloating the object
> size.
>=20
> It is used on tiny functions, which the compiler is likely to inline
> anyway.
>=20
> Your use case is different. This is fast path, and it is not a small
> function. You also have a good justification, you know not using
> inline really does hurt performance.
>=20
> So, please move this into the .c file, and use inline. And add a
> comment to the commit message adding your justification for inline.
> If something is justified, we will accept it.
>=20
>         Andrew

I will do this in the next version.

Thanks,
Emil

