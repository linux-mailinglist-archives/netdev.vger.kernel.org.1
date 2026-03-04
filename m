Return-Path: <netdev+bounces-263888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEp0G5hdqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:28:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E40C6204405
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 605743360DD3
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B2934F251;
	Wed,  4 Mar 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gYtAH7jQ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0717334DCC7;
	Wed,  4 Mar 2026 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639514; cv=none; b=VDTZQbTF2o+e7PMMsJEUYPNCJPU61+bTzpBXfMeqRs9G+c1EsD74fL+VqeJW15nZkRpDoPCuUEiv3BNYUj4tjp0muiCZ9Fy16XcK7MloPH3Bsc1zo0sf7T3U0HuQSDr76VoMgr7aVncU02XG/Njdq/QiR7rxvYPcwxSuRwbqmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639514; c=relaxed/simple;
	bh=wCvFJq9Lq2vO2torbTJLZMXCQnEtJhovSJOdtjbZSKg=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N98MhAd3GOUm2fHDSnd70GaULysNX/lwjEWDnHrHAZ4cEiWWVzuTcEXgOxGGiJKXONkht9fTaSfKM+BcoUUVujc/Zhph1ediDNn3o9IxbR7n1e/xkiAfYp3dv6b36k1hhZryz0qTyN+2Rmehs7cOCE8NnlrMREZ30y6m7eDZSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gYtAH7jQ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772639513; x=1804175513;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wCvFJq9Lq2vO2torbTJLZMXCQnEtJhovSJOdtjbZSKg=;
  b=gYtAH7jQAVLxMzOSO594YlgyA72vsNZ8AQxMrvZM/5O70W7DsPvAsaQF
   qt0CtmwDQBo/p/Rs/xVNImiwgGHXPecQbynLrIRegFB7GCEHipLoiMHLJ
   22lnHdwaIRXXw2kI9WnK0E80T+e0Ff/kB67rQVQZ75pTBlnA1m9ZUh87m
   Kxjc1G52rzU/IC8NXGQbssU2X1K/aeyxXmJK1VI2xaWIAKnTbL0m7q1tX
   1/6MMkimk7q20a6agbfVvD7GY1GNBfSs6S+Zj1LiSvxubsYMTIPu3W1yM
   A0OhyToYQgCKosi6DFLgsLKBoWG+cHO8b3Ze63nJ9MOVvB74CYAJTPrhd
   g==;
X-CSE-ConnectionGUID: wxutpbsLTX+yxXic6b+o+A==
X-CSE-MsgGUID: DIr10+/gQTWgcWiYnOCNgw==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="285599112"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:51:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 08:51:21 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 08:51:18 -0700
Message-ID: <ec77ccb286cfd4227da52a11a5720bfd51404a96.camel@microchip.com>
Subject: Re: [PATCH net-next 8/8] net: dsa: lan9645x: add port statistics
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
CC: <UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Wed, 4 Mar 2026 16:51:18 +0100
In-Reply-To: <c327cdb9-ce0c-41dd-917a-429b2b52bc26@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-8-bff8ca1396f5@microchip.com>
	 <20260303160159.efjtqzpa2w4awxht@skbuf>
	 <c327cdb9-ce0c-41dd-917a-429b2b52bc26@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E40C6204405
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263888-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 21:21 +0100, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > > +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> > > +                           struct rtnl_link_stats64 *stats)
> > > +{
> > > +   u64 *port_cnt;
> > > +
> > > +   /* Avoid stats update, as this is called very often by DSA. */
> > > +   mutex_lock(&lan9645x->stats->hw_lock);
> >=20
> > This is atomic context, you can't acquire a mutex which may be held by =
a
> > process which sleeps, which also puts you to sleep for it.
>=20
> Which suggests no testing has been done with kernel configuration
> options enabled which does checks for this, deadlock detection, etc.
>=20
> I would suggest PROVE_LOCKING, DEBUG_SPINLOCK, DEBUG_MUTEXES,
> DEBUG_ATOMIC_SLEEP.
>=20
>         Andrew

I will run our testsuite with those options enabled.

Thanks,
Emil

