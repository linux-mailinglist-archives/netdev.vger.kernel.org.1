Return-Path: <netdev+bounces-292183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOGpCGisFmpHoQcAu9opvQ
	(envelope-from <netdev+bounces-292183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC8B5E12A0
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 634273008FCF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616003D16E8;
	Wed, 27 May 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TWKROYsT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA993D6674;
	Wed, 27 May 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870677; cv=none; b=C6YrBUN3sq5I0GYBuhlL38pd1Pc1W7VKzXyD53+c0kcz+J6hmlVGaG7a7it4Z3IylZ0kRxnn4bE3A7a1HCEJdS3cU72mgHjp/ge1OkSeLE30XqA/9RZn01e27hcpJunqc5tdQPqqYcDx+atUxeXcZkY6ayv9ocUhMl+MVRCzQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870677; c=relaxed/simple;
	bh=09TXuC5fKbZdFp+f9xtXwp5BwX+bYf+Ug39FqgbJPnc=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GoxOqYeJJ9pSI0UdsWzRJ4v0JU+CAMX7w4TLnH+YX7Rn+8QjRqI/pOV4y+6dkVVs8EC9wYwVfKAcGCP9bl9OG3wXNfU+Vobrhi4z7xLArKzSzqKeZqIBFBdYGnaDVGLA1rp4knIn3xk61fHhs/AumeMdrKWjmQyY6ZF9Iyd1w0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TWKROYsT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779870676; x=1811406676;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=09TXuC5fKbZdFp+f9xtXwp5BwX+bYf+Ug39FqgbJPnc=;
  b=TWKROYsTFp4TiG9p8oFlZ8/bJz7W/cVYsPxKmli/DLSNVBmClIDplKMW
   dEnQKuhW1fBmxSpE5NZcrPYNEfnEaADQpO0Rx2317gteR99lD3Frhj9ou
   FwIR0ThAPxVkRTGXulyQmazZ6eeHowX9paAT7hn0qlAXwq4XHTcq7rFTh
   9lbkWuiMAxf6NOOMo1B42JNrb9Y3TGZMPCuo0zaDO7gkd3bONy+jQXbWX
   FqmmuVN4oErW8Il2DIMnB+rw/0+pFsqr0I/QWAIjoschthozHnm+9upYT
   IYCT/zDKATY9L8rCNpqSgDxETP4ewmrallH0WPZxvAuYW4inSU7MObT0+
   g==;
X-CSE-ConnectionGUID: KfDAldWzTjKG4xEpgldQ/g==
X-CSE-MsgGUID: B6JMc4m3Re2W/jD1ei5olg==
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="57323780"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 01:31:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 27 May 2026 01:31:14 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 27 May 2026 01:31:11 -0700
Message-ID: <9966d2140f0bd8b73d771da89b8b64cda925e4a3.camel@microchip.com>
Subject: Re: [PATCH net-next v5 0/9] net: dsa: add DSA support for the
 LAN9645x switch chip family
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Woojung
 Huh" <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>,
	"Steen Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Wed, 27 May 2026 10:31:10 +0200
In-Reply-To: <20260522190417.53ab9cc4@kernel.org>
References: <20260518-dsa_lan9645x_switch_driver_base-v5-0-968fbf34ffa3@microchip.com>
	 <20260522190417.53ab9cc4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292183-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Queue-Id: 1FC8B5E12A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-22 at 19:04 -0700, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Mon, 18 May 2026 14:24:55 +0200 Jens Emil Schulz =C3=98stergaard wrote=
:
> > This series provides the Microchip LAN9645X Switch driver.
>=20
> Looks like this needs a rebase.

I will rebase, and post v6.

Thanks,
Emil

