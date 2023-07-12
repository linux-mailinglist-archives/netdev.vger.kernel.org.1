Return-Path: <netdev+bounces-17142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687BE7508F9
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F7428164F
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2596227727;
	Wed, 12 Jul 2023 13:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465E1F942
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:01:23 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E11736;
	Wed, 12 Jul 2023 06:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7Mwy7Es+QCyPK8S0J7Ou3RSKVlLA8cMmzE6C5fqkOHA=;
	t=1689166881; x=1690376481; b=lTJQKVJQ0RPkEhlLeGsUvjhJ8cZTUvPvlbyrvRA0ca2shVP
	4qzyOZsbdOT9RQqGOduZI6pNscXb4ICTxR3URWwCGE3B0oKUDI//r1Zx4jgw2rsQley5ejlfZ6ZDH
	Dm6kQEuXVK4xv3px1jMCbPi14z5EmyCyHHQguVbRj9kFh4FTns7MON+UZeG2VK8/ATQyS7RAYlWp3
	0jthUan8usKKksdYCPnJjjSmmzMgmbxvo1NmjFGmIl9wPl9fZ9nJour2V6Lf/4Jypzx4Qu+7WPdT1
	qafw8pHYLW1dWz5l+hDGgijp2miEyceMK6mogTvKFGak0joMLqZ62vX/QvVnfIWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qJZSk-00GfuA-1M;
	Wed, 12 Jul 2023 15:00:58 +0200
Message-ID: <6a4a8980912380085ea628049b5e19e38bcd8e1d.camel@sipsolutions.net>
Subject: Re: [PATCH] USB: disable all RNDIS protocol drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Oliver Neukum <oneukum@suse.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, Enrico Mioso <mrkiko.rs@gmail.com>
Cc: Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Kalle Valo
 <kvalo@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>,  Maciej
 =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>, Jacopo Mondi
 <jacopo@jmondi.org>, =?UTF-8?Q?=C5=81ukasz?= Stelmach
 <l.stelmach@samsung.com>,  Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org,  linux-wireless@vger.kernel.org, Ilja Van Sprundel
 <ivansprundel@ioactive.com>,  Joseph Tartaro <joseph.tartaro@ioactive.com>
Date: Wed, 12 Jul 2023 15:00:55 +0200
In-Reply-To: <e5a92f9c-2d56-00fc-5e01-56e7df8dc1c1@suse.com>
References: <20221123124620.1387499-1-gregkh@linuxfoundation.org>
	 <n9108s34-9rn0-3n8q-r3s5-51r9647331ns@vanv.qr> <ZKM5nbDnKnFZLOlY@rivendell>
	 <2023070430-fragment-remember-2fdd@gregkh>
	 <e5a92f9c-2d56-00fc-5e01-56e7df8dc1c1@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-12 at 11:22 +0200, Oliver Neukum wrote:
>=20
> On 04.07.23 08:47, Greg Kroah-Hartman wrote:
> > On Mon, Jul 03, 2023 at 11:11:57PM +0200, Enrico Mioso wrote:
> > > Hi all!!
> > >=20
> > > I think the rndis_host USB driver might emit a warning in the dmesg, =
but disabling the driver wouldn't be a good idea.
> > > The TP-Link MR6400 V1 LTE modem and also some ZTE modems integrated i=
n routers do use this protocol.
> > >=20
> > > We may also distinguish between these cases and devices you might plu=
g in - as they pose different risk levels.
> >=20
> > Again, you have to fully trust the other side of an RNDIS connection,
> > any hints on how to have the kernel determine that?

> it is a network protocol. So this statement is kind of odd.
> Are you saying that there are RNDIS messages that cannot be verified
> for some reason, that still cannot be disclosed?

Agree, it's also just a USB device, so no special trickery with DMA,
shared buffers, etc.

I mean, yeah, the RNDIS code is really old and almost certainly has a
severe lack of input validation, but that still doesn't mean it's
fundamentally impossible.

johannes

