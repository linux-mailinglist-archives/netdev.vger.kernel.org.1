Return-Path: <netdev+bounces-94692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C679C8C039B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8244628183C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03012CD8E;
	Wed,  8 May 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="ZzdB3Jth"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374712FF65
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190379; cv=none; b=kZKzujkOwibRoo0LmpNg9Df9BYB8AGtgmaNhwI7dTuiZh3esxTAF8xGWdHX/4clcB27yJSjPTmX8gDAKoVZBDZ5S2bPNY+9QYlRRIiiiA4Fnq91mb9arvtCERHXn0xzRdwAd9rXoz2gBHj9u4EB49xSuMj/+G/8gJHfA9P3rwQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190379; c=relaxed/simple;
	bh=slbEVuIv2JdVCq4rv5/u/gs9BnJNjVm0YjN9IYaxYBw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=IsBrPFECaQVa/g2FkGLd99Vl/WexaL1dgqZu4+nsFrDc1djCw9I+BqR3qH0gSCuAkFvJ6J2Bve6CXvVW5gHygRWyPKzVNm/VBJRNULIx6LPHQsIOallGvJK6xG23OVS5VMahdFTc4+6t9OjKzJ2/nRZx+GbEYPI1y3gYl6CYofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=ZzdB3Jth; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715190367; x=1715795167; i=hfdevel@gmx.net;
	bh=slbEVuIv2JdVCq4rv5/u/gs9BnJNjVm0YjN9IYaxYBw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZzdB3JthORQ1LYXORNXt91lAzhP/l87M7vw85iVsp6gtAhmP95rq4BoDUrImW9kB
	 3ISYrXlJHnY322JYzarntaE74QGxj9jqTbfUT7O7X+AMAi1p1drEg7xw5IXhRWooy
	 +n3ImSeB5OPaDBFa439+lEJxQAea1fVoWmYpFuY+D7mI8Gtg9kR8s5vs5PrLIbyco
	 1IxUQ3NfJIIceZ7d7aVSpYA5gKSQj3qpRkXbnNvALQe/PEYWytWweAWSz4PiHb5Sc
	 lTtVdUgbuT9YaQYctUnS4PV+T3/4e0Pu8OU4YngUy8rjXYvzVrBDcuFBHwwUcP+N/
	 oFjuXSB3bSkF77t+2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1sFnxn1xUm-00N6Tr; Wed, 08
 May 2024 19:46:07 +0200
Message-ID: <bde062c3-a487-4c57-b864-dc7835573553@gmx.net>
Date: Wed, 8 May 2024 19:46:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: Re: [PATCH net-next v5 3/6] net: tn40xx: add basic Tx handling
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7+cC00REFgetfhYXp/ZqPtffm/BO0rD1su4aj67huc8omgZ7Trz
 8M2uIhwWK6M0fMNb1sRSo9iK1oPw5P2PZadaqXk3NRWrEZ7VldJRvKGxwyKy49g3GhrDXM5
 d+9Cv1s4BIyKTLbHx+Ih8nVb82I1V1fRfe4mfs+LpkbZCd6MUJT/JBUEVmPxUoQyjqQvyky
 51JvsvVBHpgE1qAdrfPug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XzYwm1980u8=;KOC3B5P74gQU+ldCTQAQPBW9gCa
 G/Homey4k58O1MAETmVX73UQo/DVkCwcJVdfa6lXXkHAJtHf34e8ZisDwDJCdzdbays2kjVQ2
 QxE9IPo8+yyScP5t/YiyEPdLNUg5/pokm2EranLvNBaF7RUkQBaF8Jr7YEfAeqhM13tNs6OHv
 upPGf5fCmVR3FM5CsCdPOVQm6uLWP+pU0PuVKwd+ej1oaggB8ZrwXyBtXaB6eJHqPXVjvzyvo
 39nGCJ7fKCu4/iSFOI1jdInwVBMBtBFbMbrQHOATZD6f+cqCtPL6oQYOTXc5cetNHfhCrnA82
 L2qIc6h0iulNTrwiWIlaHWdaMmxYUtWytVjxeVBz1Tv999omA+xHS+80OAb7c6/B0nrSFi/sd
 40XGD8yagjBpQwxni0upbkUYafwA1R6Zxn9Q7WfetkpnY+649+COB9GrdVwFylhPhXA2f8s9b
 SdoLDdiQD8wK+uqnTFrJMkVGIS7UKqfGG/huztuoUTbSFrW9AKhqWy4jKRsmQzJG5ir6jTIPd
 vo4LIttBQJ2eUerEudhkBsp9pgVeSu/+KckN4GkWclwgRLVN0nIRKN9RihXomu0WxgKy+9CIu
 0fXgDnH8J04zEBTXayMiFJTpNBRZHgg4TwnBrxiUrpWvV7HMoP8X7NYnOjV6l5TzAm/pkaYOG
 S4rP0RtZEmjThy+EXRyexPO83AzfX43tR5SUJbByGXplGZk8Gmz53Dur0BcaWc9YlYUmn8WU9
 L46a9g03O+gEtU875CDadLs6lv4bUPcB0u7xI9Tn+JbbVythADo7vFdaKqaUsBXsU+SfN7Qh+
 3SSUeKD50PNgEWmRx+1lTTIDUQ97RdL4hYYhKwXcO/XIs=

 > This patch adds device specific structures to initialize the hardware
 > with basic Tx handling. The original driver loads the embedded
 > firmware in the header file. This driver is implemented to use the
 > firmware APIs.
 >
 > The Tx logic uses three major data structures; two ring buffers with
 > NIC and one database. One ring buffer is used to send information
 > about packets to be sent for NIC. The other is used to get information
 > from NIC about packet that are sent. The database is used to keep the
 > information about DMA mapping. After a packet is sent, the db is used
 > to free the resource used for the packet.
 >
 > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
 > ---
 >=C2=A0 drivers/net/ethernet/tehuti/Kconfig |=C2=A0=C2=A0=C2=A0 1 +
 >=C2=A0 drivers/net/ethernet/tehuti/tn40.c=C2=A0 | 1260 +++++++++++++++++=
++++++++++
 >=C2=A0 drivers/net/ethernet/tehuti/tn40.h=C2=A0 |=C2=A0 167 ++++
 >=C2=A0 3 files changed, 1428 insertions(+)
 >
 > diff --git a/drivers/net/ethernet/tehuti/Kconfig
b/drivers/net/ethernet/tehuti/Kconfig
 > index 849e3b4a71c1..4198fd59e42e 100644
 > --- a/drivers/net/ethernet/tehuti/Kconfig
 > +++ b/drivers/net/ethernet/tehuti/Kconfig
 > @@ -26,6 +26,7 @@ config TEHUTI
 >=C2=A0 config TEHUTI_TN40
 > =C2=A0=C2=A0=C2=A0=C2=A0 tristate "Tehuti Networks TN40xx 10G Ethernet =
adapters"
 > =C2=A0=C2=A0=C2=A0=C2=A0 depends on PCI
 > +=C2=A0=C2=A0=C2=A0 select FW_LOADER
 > =C2=A0=C2=A0=C2=A0=C2=A0 help
 > =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 This driver supports 10G Ethernet adapt=
ers using Tehuti Networks
 > =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 TN40xx chips. Currently, adapters with =
Applied Micro Circuits
 > diff --git a/drivers/net/ethernet/tehuti/tn40.c
b/drivers/net/ethernet/tehuti/tn40.c
 > index 6ec436120d18..6c6163bad2c2 100644
 > --- a/drivers/net/ethernet/tehuti/tn40.c
 > +++ b/drivers/net/ethernet/tehuti/tn40.c
 > @@ -1,14 +1,1186 @@
 >=C2=A0 // SPDX-License-Identifier: GPL-2.0+
 >=C2=A0 /* Copyright (c) Tehuti Networks Ltd. */
 >
 > +#include <linux/bitfield.h>
 > +#include <linux/ethtool.h>
 > +#include <linux/firmware.h>
 > +#include <linux/if_vlan.h>
 > +#include <linux/netdevice.h>
 >=C2=A0 #include <linux/pci.h>
 >
 >=C2=A0 #include "tn40.h"
 >
 > +#define TN40_SHORT_PACKET_SIZE 60
 > +#define TN40_FIRMWARE_NAME "tn40xx-14.fw"

why is here a new firmware name defined?
The TN4010 uses the identical firmware as the tehuti ethernet driver. I
suggest therefore to define instead, in order to avoid storing the same
firmware twice:

#define TN40_FIRMWARE_NAME "tehuti/bdx.bin"

=2D-
Best regards,

Hans

