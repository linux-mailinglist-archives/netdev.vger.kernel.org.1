Return-Path: <netdev+bounces-263894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHTQJH1cqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:23:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E98C6204262
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910243147CF0
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE8035B136;
	Wed,  4 Mar 2026 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IZHEkekX"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA634EEF4;
	Wed,  4 Mar 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639924; cv=none; b=Prsx1uUXErCL5tYlm1C4T356HvOiss7cKsPBieV+Q8r+jOSs9Z4hb47T+PhKLZBUYDvP5bVzabhupwrEu73B8I64k0v/nZ/1NG5HpoN+F69Uu56t7MUrpu2vKDB0RWjl2/m3w/InKcnMAGqFZJrZmxMWZxN8vZyKZfNkgKujk28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639924; c=relaxed/simple;
	bh=OReQdevZW0+66mL11uL5/T5jSGGlHsYXYSznL81V7eE=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MA4qkomlt8rLYywMOepPkCkMWdLdlsYE47QwsdaglyvxiUzFVlEl6bXzTvnoBOpOXtn4e4ei3dUFKG7LzZizIMcJdeyvyoxjnL/eEfTGdXBO3DFuPE5XGIwqYFuTt8A7jJAHUwkc5Ciyx48kh+atHUSYt9cjbLK1V6W+xra/Ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IZHEkekX; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772639921; x=1804175921;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=OReQdevZW0+66mL11uL5/T5jSGGlHsYXYSznL81V7eE=;
  b=IZHEkekXVslHKZAult/IzdYO54bATyuwmZh28I3j/jfBCpjFDFL7bALi
   tH9jM9DiFr0Si8TD8s/nZs+eYALZDJfXESYstF1bQpohJYBUHe0qE1Bex
   /E6DGSk3MrhW3tAuk7Pn0upP4W2tVdi2Zz2N5PJF+OCjiTKes+rYKHDai
   pM4bILmmILDuO8qMrk6K/YZ5RTBGJAOrdW9+C94PoNTMzrfXE+dpnW7BV
   dmrhwxWpZA7If1BRqC731NRHFmHKKqU9VNgCosZNzapwBJ91Q57lcvrBJ
   gyztQvl/9ISfCkom+sDY/xjhpTeXtf0cNTUUgQZwK0u0RN8+jrp/g/e4Q
   A==;
X-CSE-ConnectionGUID: 6X3IyqiXQJCxBHDWfrEssg==
X-CSE-MsgGUID: +r8pux/5TW+qiPscTMD+XQ==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="221486147"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:58:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 08:58:32 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 08:58:29 -0700
Message-ID: <140d61db66568f043818e6a432e412e8ae225c4e.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Wed, 4 Mar 2026 16:58:28 +0100
In-Reply-To: <20260303-iron-swarm-53248ddd25df@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <20260303-iron-swarm-53248ddd25df@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E98C6204262
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263894-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 18:49 +0000, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 01:22:28PM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > Add bindings for LAN9645X switch. We use a fallback compatible for the
> > smallest SKU microchip,lan96455s-switch.
> >=20
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
> > ---
> >  .../net/dsa/microchip,lan9645x-switch.yaml         | 137 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 138 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan964=
5x-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan964=
5x-switch.yaml
> > new file mode 100644
> > index 000000000000..4a19dfa7e9d5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan9645x-swit=
ch.yaml
> > @@ -0,0 +1,137 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/microchip,lan9645x-switch.y=
aml#
>=20
> Just name the binding microchip,lan96455s-switch please, to match the
> standalone compatible.

I will rename the binding.

Thanks,
Emil

