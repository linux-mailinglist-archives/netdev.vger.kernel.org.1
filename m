Return-Path: <netdev+bounces-263833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDp8I21IqGlOrwAAu9opvQ
	(envelope-from <netdev+bounces-263833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:57:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9902020FE
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 15:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE9113046042
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64323AE6E8;
	Wed,  4 Mar 2026 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t88Asfbs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651443AE18B;
	Wed,  4 Mar 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772635258; cv=none; b=ddEYZR/9zWk0B07H2aupOCUxDryuq7vIc3P16VV/HdPjBqeMloSN/iCB1QrlrZBM2gH9giQoFpMUOSYZfBhzROafCpImwa56bWXXR1yYorVejiIgVObQ7NbzWw22ms0SGeU8q/D2RSwq8brg/7Ls3WtEIutyyMSvqwH+2zuDBd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772635258; c=relaxed/simple;
	bh=zE5akdRkGI+Oez5hvCF2Bt+atO8UWOYke42Nn1s5HSE=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKZ9LLz6SCTTmEIKnuqlKt7C3mJ4u1I0dYfuNFxd3YrNwJ2Y/v2QgpLYlukD5IAHPbtvSpz5b2Zz4PAGYE2e/0vssYe3jZLvBWu5ZrAGKitvRzGa0YIDK1Moh4Rmei3FMegEVwVCvjDr3D2TpBPPQbylKemZRGE8un8/aw9i5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t88Asfbs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772635258; x=1804171258;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=zE5akdRkGI+Oez5hvCF2Bt+atO8UWOYke42Nn1s5HSE=;
  b=t88AsfbsGc8JKeeP6U/VFh4C6aVB2lCOS7vMg0oqdIK4YeWImQnEIOLw
   HPxUTjtBbuFHkjEzI5GGesMvEi0gq8pCW/75nvd1Pi3Tc4gst4lC2fbIU
   Xvar6+zOUJcTSRYc224MKoc9KGq+uuR/wFL7PaoNnYKw3u+DlvtupFGJS
   ngYynYo1+jAzKonZ9+Exo24Xl80ScJU+2fbhl07yqMg/OdI68YznGi6/i
   WMIC1zQLWZh6e0UtztGgjXSKsUZxhDZCkOVvsHrEB0bvlIsl4Aa+YB+Zw
   aOD+yYU81BdJ/hb4iu9X0xNepEqrNMPi9Px9vCpJRXxvUDLSzKsCjcKny
   g==;
X-CSE-ConnectionGUID: P+r2BjupSrSyAHIBOkUucQ==
X-CSE-MsgGUID: 4MrXjXcCSROnFtCXbwMBcA==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="285594279"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 07:40:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 07:40:34 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 07:40:30 -0700
Message-ID: <e30d9e84ac37142c26af35b6e589fdd23157aa35.camel@microchip.com>
Subject: Re: [PATCH net-next 6/8] net: dsa: lan9645x: add vlan support
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Woojung Huh
	<woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>, "Steen
 Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Wed, 4 Mar 2026 15:40:30 +0100
In-Reply-To: <20260303145955.s4kjiwjv6ahn6zph@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-6-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-6-bff8ca1396f5@microchip.com>
	 <20260303145955.s4kjiwjv6ahn6zph@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2B9902020FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263833-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bridge_vlan_mcast.sh:url,bridge_vlan_aware.sh:url,bridge_vlan_unaware.sh:url,bridge_vlan_change_awareness.sh:url]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 16:59 +0200, Vladimir Oltean wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, Mar 03, 2026 at 01:22:32PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > Add support for vlanaware bridge. We reserve vid 4095 for standalone
> > mode, to implement fdb-isolation. An vlan-unaware bridge uses vid 0.
> >=20
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
> > ---
>=20
> Have you run these from tools/testing/selftests/net/forwarding/? It
> would help to know where to look closer for potential problems.
>=20
> bridge_vlan_aware.sh
> bridge_vlan_change_awareness.sh
> bridge_vlan_mcast.sh
> bridge_vlan_unaware.sh

No I have not run the selftests, only our own test setup. I will get these
up and running.

Thanks,
Emil

