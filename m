Return-Path: <netdev+bounces-213605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA3B25D24
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BED881AF0
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85123A9BE;
	Thu, 14 Aug 2025 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="BlZcLfM7"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568972594B4;
	Thu, 14 Aug 2025 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156203; cv=none; b=YRfNrq7ilqqnLTFQdBowZeze+dmAIZcy+Qo3NBfqLF0cMS9yyMl5boqyXuaL5b+FRBz9I17pTFvkux29BM8gDpGcySBJ/ZI24dtOuI7Hp2+E7UvR7wlUHHHcT3InSdrnf2b419Fh8hYuaGmeFSxfxbs7vz8mklFCF7BKBWqazAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156203; c=relaxed/simple;
	bh=SIf1CgqSi/4snwC2FPmH2Jt+toAqVhJjRGjlhnKAKXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYuJEDoXf/ehKqWwMpmWEZG75k0/VVvgAe7S/45zpvKao4qMBpuZdEtGSy/5dcwOSNos4uEnLKYPoHA+LzDzLb7WvVe980tjGUM4aM4z8Jkj/zf9AVBlh8Cs0mi+77IO3PIwryMS/WkxMGT6VQ4M31yVtjOVkWNUj8Uw4epdhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=BlZcLfM7; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FCD5100C39;
	Thu, 14 Aug 2025 09:23:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1755156197;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ILUQ+Zz6T9JcFtvvS2OcMHRLaXdHMtwPMmr1SraYPXg=;
	b=BlZcLfM7Hf5Ri6Cxa2izA2iK39jcEQAPJUcx97QKpuuAw5Z3DsVv0SWJ/zj8fPJhSBWMH9
	l0lob7QBAgYkZxnAo5MYluDURYIS6R5Qc3b+4Y3Ku0maPGPdLzeelhii5LnjYxw4aJM0HN
	3ynZ+prOWF7w0FWDVOyu2CWV2UInsUiOpcOO9sbc/94EyERD+BTe/evhu0mdnfXec8Etlc
	cqZaPiMG2TIYy6jpivuW/n8blf9AgMKdtLAUcqWJET3ORCW+ISqSrP8KdGp+pYSKYxCvTx
	VLu2kqexTsXT94FfDfeyrVhHC01HP72xnq4tu9TQ5JScGouVxti8gZSwp6BO1A==
Date: Thu, 14 Aug 2025 09:23:09 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>, Woojung
 Huh <woojung.huh@microchip.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Jesse Van Gavere <jesseevg@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Pieter Van Trappen
 <pieter.van.trappen@cern.ch>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Simon Horman <horms@kernel.org>, Tristram Ha
 <tristram.ha@microchip.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [RFC PATCH] net: dsa: microchip: Prevent overriding of HSR port
 forwarding
Message-ID: <20250814092309.1534e1b4@wsk>
In-Reply-To: <a838b848-8633-4312-b246-17af9175535c@kontron.de>
References: <20250813152615.856532-1-frieder@fris.de>
	<20250813174553.5c2cdeb3@wsk>
	<a838b848-8633-4312-b246-17af9175535c@kontron.de>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 13 Aug 2025 17:57:02 +0200
Frieder Schrempf <frieder.schrempf@kontron.de> wrote:

> Am 13.08.25 um 17:45 schrieb =C5=81ukasz Majewski:
> > [Sie erhalten nicht h?ufig E-Mails von lukma@nabladev.com. Weitere
> > Informationen, warum dies wichtig ist, finden Sie unter
> > https://aka.ms/LearnAboutSenderIdentification ]
> >=20
> > Hi Frieder,
> >  =20
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> The KSZ9477 supports NETIF_F_HW_HSR_FWD to forward packets between
> >> HSR ports. This is set up when creating the HSR interface via
> >> ksz9477_hsr_join() and ksz9477_cfg_port_member().
> >>
> >> At the same time ksz_update_port_member() is called on every
> >> state change of a port and reconfiguring the forwarding to the
> >> default state which means packets get only forwarded to the CPU
> >> port.
> >>
> >> If the ports are brought up before setting up the HSR interface
> >> and then the port state is not changed afterwards, everything works
> >> as intended:
> >>
> >>   ip link set lan1 up
> >>   ip link set lan2 up
> >>   ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision
> >> 45 version 1 ip addr add dev hsr 10.0.0.10/24
> >>   ip link set hsr up
> >>
> >> If the port state is changed after creating the HSR interface, this
> >> results in a non-working HSR setup:
> >>
> >>   ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision
> >> 45 version 1 ip addr add dev hsr 10.0.0.10/24
> >>   ip link set lan1 up
> >>   ip link set lan2 up
> >>   ip link set hsr up
> >>
> >> In this state, packets will not get forwarded between the HSR ports
> >> and communication between HSR nodes that are not direct neighbours
> >> in the topology fails.
> >>
> >> To avoid this, we prevent all forwarding reconfiguration requests
> >> for ports that are part of a HSR setup with NETIF_F_HW_HSR_FWD
> >> enabled.
> >>
> >> Fixes: 2d61298fdd7b ("net: dsa: microchip: Enable HSR offloading
> >> for KSZ9477") Signed-off-by: Frieder Schrempf
> >> <frieder.schrempf@kontron.de> ---
> >> I'm posting this as RFC as my knowledge of the driver and the
> >> stack in general is very limited. Please review thoroughly and
> >> provide feedback. Thanks! =20
> >=20
> > I don't have the HW at hand at the moment (temporary).
> >=20
> > Could you check if this patch works when you create two hsr
> > interfaces
> > - i.e. hsr1 would use HW offloading from KSZ9744 and hsr2 is just
> > the one supporting HSR in software. =20
>=20
> My hardware only has three user ports. So that might get a bit
> difficult to test. I will try to configure one unconnected port to
> set up two HSR links, but I won't be able to fully test this due to
> the lack of the fourth physical link.
>=20

Ok, I see...

I was using the Atmel's/Microchip Devel board with 5 ports...

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic

