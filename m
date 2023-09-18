Return-Path: <netdev+bounces-34473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4DB7A4554
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CB51C20446
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DAE14AA4;
	Mon, 18 Sep 2023 09:01:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F5566A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:01:14 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0212101;
	Mon, 18 Sep 2023 02:01:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F88AE0012;
	Mon, 18 Sep 2023 09:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1695027666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVyUScz+am7yevZPaXmq4vV+zCJQU8oqBRXmSLKdjIU=;
	b=GVvk8UoD27cPJoc5yX/HfL7fE2236154OARwSMovP1+3d8jfTszk5kbQYLQO9b8MpPcsUq
	mv298Mjz+fTreL2Se6Y5bavxJC2Cqmj3DiaenaGAyR232vHPysdlsogOj+8l5GvPmu+Q7g
	eQkz/pR9PaxfSXrmE1pUsDBJ2qvbrvCIrRN15uOI321URD321WkLofnsz3D+qVVQm84pyb
	vDC97sMmXoas7QVBGK2ijmoZDiVs/fRKO0gdOZlSDBVZFPi5rjY/zOqehKDUqydwQAIS7+
	SM7vTfpCxzdZ1f87bIXvff27G8/3J/p1A8K1cl+Saf/ACguJZNjsRoLvrx8d7Q==
Date: Mon, 18 Sep 2023 11:01:02 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>, Alexander Aring
 <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, Romuald
 Despres <romuald.despres@qorvo.com>, Frederic Blain
 <frederic.blain@qorvo.com>, Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem
 Imberton <guilhem.imberton@qorvo.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH wpan-next v2 02/11] ieee802154: Internal PAN management
Message-ID: <20230918110102.19a43db1@xps-13>
In-Reply-To: <CAK-6q+h1rbG+6=M+ZZfUznHq9GxOwtA1i0c=C9dgQH1qC7sQ=A@mail.gmail.com>
References: <20230901170501.1066321-1-miquel.raynal@bootlin.com>
	<20230901170501.1066321-3-miquel.raynal@bootlin.com>
	<32cfbf0f-7ac8-5a4c-d9cd-9650a64fc0ea@datenfreihafen.org>
	<CAK-6q+h1rbG+6=M+ZZfUznHq9GxOwtA1i0c=C9dgQH1qC7sQ=A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

aahringo@redhat.com wrote on Sun, 17 Sep 2023 07:50:55 -0400:

> Hi,
>=20
> On Sat, Sep 16, 2023 at 11:39=E2=80=AFAM Stefan Schmidt
> <stefan@datenfreihafen.org> wrote:
> >
> > Hello Miquel.
> >
> > On 01.09.23 19:04, Miquel Raynal wrote: =20
> > > Introduce structures to describe peer devices in a PAN as well as a f=
ew
> > > related helpers. We basically care about:
> > > - Our unique parent after associating with a coordinator.
> > > - Peer devices, children, which successfully associated with us.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >   include/net/cfg802154.h | 46 ++++++++++++++++++++++++++++
> > >   net/ieee802154/Makefile |  2 +-
> > >   net/ieee802154/core.c   |  2 ++
> > >   net/ieee802154/pan.c    | 66 ++++++++++++++++++++++++++++++++++++++=
+++
> > >   4 files changed, 115 insertions(+), 1 deletion(-)
> > >   create mode 100644 net/ieee802154/pan.c
> > >
> > > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > > index f79ce133e51a..6c7193b4873c 100644
> > > --- a/include/net/cfg802154.h
> > > +++ b/include/net/cfg802154.h
> > > @@ -303,6 +303,22 @@ struct ieee802154_coord_desc {
> > >       bool gts_permit;
> > >   };
> > >
> > > +/**
> > > + * struct ieee802154_pan_device - PAN device information
> > > + * @pan_id: the PAN ID of this device
> > > + * @mode: the preferred mode to reach the device
> > > + * @short_addr: the short address of this device
> > > + * @extended_addr: the extended address of this device
> > > + * @node: the list node
> > > + */
> > > +struct ieee802154_pan_device {
> > > +     __le16 pan_id;
> > > +     u8 mode;
> > > +     __le16 short_addr;
> > > +     __le64 extended_addr;
> > > +     struct list_head node;
> > > +};
> > > +
> > >   /**
> > >    * struct cfg802154_scan_request - Scan request
> > >    *
> > > @@ -478,6 +494,11 @@ struct wpan_dev {
> > >
> > >       /* fallback for acknowledgment bit setting */
> > >       bool ackreq;
> > > +
> > > +     /* Associations */
> > > +     struct mutex association_lock;
> > > +     struct ieee802154_pan_device *parent;
> > > +     struct list_head children;
> > >   };
> > >
> > >   #define to_phy(_dev)        container_of(_dev, struct wpan_phy, dev)
> > > @@ -529,4 +550,29 @@ static inline const char *wpan_phy_name(struct w=
pan_phy *phy)
> > >   void ieee802154_configure_durations(struct wpan_phy *phy,
> > >                                   unsigned int page, unsigned int cha=
nnel);
> > >
> > > +/**
> > > + * cfg802154_device_is_associated - Checks whether we are associated=
 to any device
> > > + * @wpan_dev: the wpan device =20
> >
> > Missing return value documentation.
> > =20
> > > + */
> > > +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev);
> > > +
> > > +/**
> > > + * cfg802154_device_is_parent - Checks if a device is our coordinator
> > > + * @wpan_dev: the wpan device
> > > + * @target: the expected parent
> > > + * @return: true if @target is our coordinator
> > > + */
> > > +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> > > +                             struct ieee802154_addr *target);
> > > +
> > > +/**
> > > + * cfg802154_device_is_child - Checks whether a device is associated=
 to us
> > > + * @wpan_dev: the wpan device
> > > + * @target: the expected child
> > > + * @return: the PAN device
> > > + */
> > > +struct ieee802154_pan_device *
> > > +cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> > > +                       struct ieee802154_addr *target);
> > > +
> > >   #endif /* __NET_CFG802154_H */
> > > diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
> > > index f05b7bdae2aa..7bce67673e83 100644
> > > --- a/net/ieee802154/Makefile
> > > +++ b/net/ieee802154/Makefile
> > > @@ -4,7 +4,7 @@ obj-$(CONFIG_IEEE802154_SOCKET) +=3D ieee802154_socke=
t.o
> > >   obj-y +=3D 6lowpan/
> > >
> > >   ieee802154-y :=3D netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
> > > -                header_ops.o sysfs.o nl802154.o trace.o
> > > +                header_ops.o sysfs.o nl802154.o trace.o pan.o
> > >   ieee802154_socket-y :=3D socket.o
> > >
> > >   CFLAGS_trace.o :=3D -I$(src)
> > > diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> > > index 57546e07e06a..cd69bdbfd59f 100644
> > > --- a/net/ieee802154/core.c
> > > +++ b/net/ieee802154/core.c
> > > @@ -276,6 +276,8 @@ static int cfg802154_netdev_notifier_call(struct =
notifier_block *nb,
> > >               wpan_dev->identifier =3D ++rdev->wpan_dev_id;
> > >               list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
> > >               rdev->devlist_generation++;
> > > +             mutex_init(&wpan_dev->association_lock);
> > > +             INIT_LIST_HEAD(&wpan_dev->children);
> > >
> > >               wpan_dev->netdev =3D dev;
> > >               break;
> > > diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> > > new file mode 100644
> > > index 000000000000..e2a12a42ba2b
> > > --- /dev/null
> > > +++ b/net/ieee802154/pan.c
> > > @@ -0,0 +1,66 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * IEEE 802.15.4 PAN management
> > > + *
> > > + * Copyright (C) 2021 Qorvo US, Inc
> > > + * Authors:
> > > + *   - David Girault <david.girault@qorvo.com>
> > > + *   - Miquel Raynal <miquel.raynal@bootlin.com>
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <net/cfg802154.h>
> > > +#include <net/af_ieee802154.h>
> > > +
> > > +static bool cfg802154_same_addr(struct ieee802154_pan_device *a,
> > > +                             struct ieee802154_addr *b)
> > > +{
> > > +     if (!a || !b)
> > > +             return false;
> > > +
> > > +     switch (b->mode) {
> > > +     case IEEE802154_ADDR_SHORT:
> > > +             return a->short_addr =3D=3D b->short_addr;
> > > +     case IEEE802154_ADDR_LONG:
> > > +             return a->extended_addr =3D=3D b->extended_addr;
> > > +     default:
> > > +             return false;
> > > +     }
> > > +} =20
> >
> > Don't we already have such a helper already? =20
>=20
> There must also be a check on (a->mode !=3D b->mode) because short_addr
> and extended_addr share memory in this struct.

True.

Actually the ieee802154_addr structure uses an enum to store either
the short address or the extended addres, while at the MAC level I'd
like to compare with what I call a ieee802154_pan_device: the PAN
device is part of a list defining the associated neighbors and contains
both an extended address and a short address once associated.

I do not want to compare the PAN ID here and I do not need to compare
if the modes are different because the device the code is running on
is known to have both an extended address and a short address field
which have been initialized.

With all these constraints, I think it would require more code to
re-use that small function than just writing a slightly different one
here which fully covers the "under association/disassociation" case, no?

> We have something "similar" [0] to this with also checks on panid,
> however it depends what Miquel tries to do here. I can imagine that we
> extend the helper with an enum opt about what to compare.
>=20
> - Alex
>=20
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/i=
nclude/net/ieee802154_netdev.h?h=3Dv6.6-rc1#n232

Thanks for the link!

Thanks,
Miqu=C3=A8l

