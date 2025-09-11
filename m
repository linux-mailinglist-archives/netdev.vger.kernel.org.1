Return-Path: <netdev+bounces-222019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63901B52BA6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111813ABE59
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF882E1C61;
	Thu, 11 Sep 2025 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="yg9H/dvZ"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53022E0922;
	Thu, 11 Sep 2025 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579407; cv=none; b=fmvYAWFZEi0eOfIh09X7pj/1MXHqXuq0O+0w0sL/a2D2ZWNvGCaPebhBCIRLx+4BmIcrbjQh9VSdhC8vytT2e+rmL6zp/NoSVetVfGS4Qwsfk6j+1ztrrgqB72tbIgDzsiYMMTgTsgw4IfDEDH7hVdMn7hvwFPAt7yKQEjYUP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579407; c=relaxed/simple;
	bh=6yQW0ml2hneuegSu/DND2ZHAHnDbMIQgiFkYLrD8ZzY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TFWbiZM69Y1ag4E2gPINE18MvypTyblSBbiiootDadJFP8l4i6HyX/fZYdQ0BpR16GBKXw918fK9vVdlwqRtQn+pb7frYmlNxRagAOKt2rBf6pXKoqWD0e62azrMSf81pln4lOV3UEwPXWcL+n3FNur3JqiDrCwTyOdpYMgxLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=yg9H/dvZ; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3X9+A0P0F92W8xd1mm/wdAzjQD7bN49SA+/OJzzCmm4=; b=yg9H/dvZuy+suCTZ203CdRADS7
	nNXV+ibyvDbulq170sSwsMU8++kmF/wux1Q5JpPvos3Ant6WGGswNDj9aslDfRfJsKO0B8TM6gWTE
	PaYSbEw+R25eXbHqUitRQ6mUsmfsl89NaJkf9F0sKnxM9SCGsbS6ftGp8nwgUJZTnDla4+wI/iXUk
	pQWFiiUN9RyvXuHp3a5XKYhPdUuJ5qZTmlKihwZMU9tpPbe46RvjKzr/rDlPYGXTHxJ0mupfiyKoV
	etE7LkMzSBDcA3tzaSX4pJ19FmYyT7sboWO0MrXhD474LW4O7edyl0xL+xNej0n0gLMKJxTazG2Y9
	6+nZE4Kw==;
Received: from [122.175.9.182] (port=33004 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uwcPk-000000015ts-2XgD;
	Thu, 11 Sep 2025 04:12:21 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 526AB1781F05;
	Thu, 11 Sep 2025 13:42:14 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 2754D17840BC;
	Thu, 11 Sep 2025 13:42:14 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id N5Rg2jz0nb_G; Thu, 11 Sep 2025 13:42:14 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id C74831781F05;
	Thu, 11 Sep 2025 13:42:13 +0530 (IST)
Date: Thu, 11 Sep 2025 13:42:13 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	m-malladi <m-malladi@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	afd <afd@ti.com>, 
	michal swiatkowski <michal.swiatkowski@linux.intel.com>, 
	jacob e keller <jacob.e.keller@intel.com>, horms <horms@kernel.org>, 
	johan <johan@kernel.org>, ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s-anna <s-anna@ti.com>, 
	glaroque <glaroque@baylibre.com>, 
	saikrishnag <saikrishnag@marvell.com>, 
	kory maincent <kory.maincent@bootlin.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1472700459.335961.1757578333581.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250908133019.44602174@kernel.org>
References: <20250904101729.693330-1-parvathi@couthit.com> <20250905183151.6a0d832a@kernel.org> <974157264.314549.1757343020136.JavaMail.zimbra@couthit.local> <20250908133019.44602174@kernel.org>
Subject: Re: [PATCH net-next v15 0/5] PRU-ICSSM Ethernet Driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: PRU-ICSSM Ethernet Driver
Thread-Index: /Xec1/3639+TyIC3wc37Kq4oOeNPjg==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On Mon, 8 Sep 2025 20:20:20 +0530 (IST) Parvathi Pudi wrote:
>> > On Thu,  4 Sep 2025 15:45:37 +0530 Parvathi Pudi wrote:
>> >> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
>> >> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
>> >> Megabit ICSS (ICSSM).
>> > 
>> > Looks like the new code is not covered by the existing MAINTAINERS
>> > entries. Who is expected to be maintaining the new driver?
>> > Please consult:
>> > https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html
>> 
>> We will update the MAINTAINERS information in a separate patch to
>> this series and share the next version soon.
> 
> I wasn't asking if you can update the MAINTAINERS, I was asking what
> you will update it with. Since that's still not clear I'm dropping
> the series from pw, please repost with the MAINTAINERS entry included.

The new entry for the ICSSM Ethernet driver will be added immediately
after the existing ICSSG driver section.

We will update the MAINTAINERS file with the change shown below.

diff --git a/MAINTAINERS b/MAINTAINERS
index b81595e9ea95..c7f04ff96cf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25320,6 +25320,18 @@ S:     Maintained
 F:     Documentation/devicetree/bindings/net/ti,icss*.yaml
 F:     drivers/net/ethernet/ti/icssg/*

+TI ICSSM ETHERNET DRIVER (ICSSM)
+M:     MD Danish Anwar <danishanwar@ti.com>
+M:     Parvathi Pudi <parvathi@couthit.com>
+R:     Roger Quadros <rogerq@kernel.org>
+R:     Mohan Reddy Putluru <pmohan@couthit.com>
+L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:     netdev@vger.kernel.org
+S:     Maintained
+F:     Documentation/devicetree/bindings/net/ti,icssm*.yaml
+F:     Documentation/devicetree/bindings/net/ti,pruss-ecap.yaml
+F:     drivers/net/ethernet/ti/icssm/*
+
 TI J721E CSI2RX DRIVER
 M:     Jai Luthra <jai.luthra@linux.dev>
 L:     linux-media@vger.kernel.org
--


Thanks and Regards,
Parvathi.

