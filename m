Return-Path: <netdev+bounces-304465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tWiGECSAR2qdZgAAu9opvQ
	(envelope-from <netdev+bounces-304465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:25:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C647009CF
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 11:25:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infineon.com header.s=IFXMAIL header.b=f22ast0h;
	dmarc=pass (policy=quarantine) header.from=infineon.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304465-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304465-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 217A630A5B7E
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2C3B27FB;
	Fri,  3 Jul 2026 09:21:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408943B1EFD;
	Fri,  3 Jul 2026 09:21:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070499; cv=none; b=W0k164qS1042XNKVOiISXy22x38cf5opSmy48eDgoVPd95LLYdRjYB63CQBu76X9LHZ+e7FAgvBSY7+qbwul44MHHUrT7vp+WTYeuYeGsl+vmFkQMQa93z9lMr5E55hMnUOxrEO+SmRAgiUoOrYZqDRcUKg0g1EtZQHj4R0mQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070499; c=relaxed/simple;
	bh=Ybh09U61n8vr7U6hIUEp2ScYPAHtOMLi9dOZJ/aT9j8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uRxMDMDeb6upN4f+s6BWjQertkLFVwwb9vlAtoEGK+znWEFryd3tm1UcbSaXGmr9IW0rEVAkNzU4G8y+TDGj/giSvqLpTdRH7m7ins4pYXyyW1I5YeImtNypo8CNS8uJZpIngazbBZK+6Z5RsZKOgFffm3wB+0hdVH8mn3kAxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=f22ast0h; arc=none smtp.client-ip=217.10.52.204
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1783070497; x=1814606497;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Ybh09U61n8vr7U6hIUEp2ScYPAHtOMLi9dOZJ/aT9j8=;
  b=f22ast0haFXdOLGqa+qXeZQLSJDEB/F8/i3vA4qiaPvn5P9evEy09C4c
   Y2UPHeB1Meqd0dYoVKfbzoSpmv7FMFsGgVaecFQgn/lEbXqLDtiMpdEXr
   GD9ntYuCHcTDH90yY6RebjOVtdZXAiCmcCRBA7bUq5xRttiOet0AQeLDs
   8=;
X-CSE-ConnectionGUID: z8Qc26ctTJuCzOFVy9AyBw==
X-CSE-MsgGUID: sKhdcObXRGidQmNxVFF2yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="99599774"
X-IronPort-AV: E=Sophos;i="6.25,145,1779141600"; 
   d="scan'208";a="99599774"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 11:21:35 +0200
Received: from MUCSE816.infineon.com (172.23.29.42) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 3 Jul
 2026 11:21:34 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE816.infineon.com
 (172.23.29.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 3 Jul
 2026 11:21:33 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.043; Fri, 3 Jul 2026 11:21:33 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <manikandan.m@microchip.com>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<srini@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: RE: [PATCH v4 3/7] mtd: spi-nor: sfdp: expose the SFDP as a read-only
 NVMEM device
Thread-Topic: [PATCH v4 3/7] mtd: spi-nor: sfdp: expose the SFDP as a
 read-only NVMEM device
Thread-Index: AQHdCHJjppL/9AvAjUSdTTDRPCeZfLZbR6AwgABBQ+A=
Date: Fri, 3 Jul 2026 09:21:33 +0000
Message-ID: <d0823b0801bc4339a2653e4a51c488f4@infineon.com>
References: <20260630092406.150587-1-manikandan.m@microchip.com>
 <20260630092406.150587-4-manikandan.m@microchip.com>
 <8f3b422e0b7749b2a47b14a585dd0a0c@infineon.com>
In-Reply-To: <8f3b422e0b7749b2a47b14a585dd0a0c@infineon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,quarantine];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304465-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infineon.com:from_mime,infineon.com:dkim,infineon.com:mid,microchip.com:email,vger.kernel.org:from_smtp];
	FREEMAIL_TO(0.00)[microchip.com,kernel.org,bootlin.com,nod.at,ti.com,tuxon.dev,armlinux.org.uk,gmail.com,arndb.de,walle.cc,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:manikandan.m@microchip.com,m:pratyush@kernel.org,m:mwalle@kernel.org,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:srini@kernel.org,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:linux@armlinux.org.uk,m:richardcochran@gmail.com,m:linusw@kernel.org,m:arnd@arndb.de,m:michael@walle.cc,m:linux-mtd@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[Takahiro.Kuwano@infineon.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infineon.com:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Takahiro.Kuwano@infineon.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1C647009CF

> Hi,
>=20
> > Register the cached SFDP as a read-only NVMEM device rooted at the
> > flash's "sfdp" child node, exposing it in on-flash byte order. This let=
s
> > NVMEM cells reference any SFDP data: a fixed-layout for parameters at a
> > known offset, or an nvmem-layout parser for vendor data whose location
> > must be discovered at runtime. The device is only registered when an
> > "sfdp" node is present in the device tree.
> >
> > Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
>=20
> SFDP is exposed in sysfs (e.g., /sys/bus/spi/devices/spi0.0/spi-nor/sfdp)=
.
> Why don't you just use this existing entry?

Sorry, sysfs is for userspace.
Please just disregard my previous comment.
=20
Thanks,
Takahiro


