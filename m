Return-Path: <netdev+bounces-36053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2A7ACBDB
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 22:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 19C0B28146A
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4EDF5A;
	Sun, 24 Sep 2023 20:47:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86137DF55
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 20:47:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F9FEE
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695588439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/HIpjVFNRXmYmV7yH7GioIrF9AAXyM2hiNW+k+5Bgk=;
	b=Z9Mdh6VQnvQr4GWWPwANXlXyzFckM9noufq0x9zBJRXXp4Fl8RLKcS8vamBYMzDwBnx/Oh
	jOhaSWrY/dt8i6LnB6zJ19WS0jXcwb4Yrxu0M8YHt6zuBaST5UKHckBqQwh2QOq+462arR
	3LYzneEVvagA+Ex2WtE2dPvBsXgXIAc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-8ddjn6qXOc27nSWnNnrBeQ-1; Sun, 24 Sep 2023 16:47:17 -0400
X-MC-Unique: 8ddjn6qXOc27nSWnNnrBeQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-533ddb3cb28so1174876a12.0
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 13:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695588436; x=1696193236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/HIpjVFNRXmYmV7yH7GioIrF9AAXyM2hiNW+k+5Bgk=;
        b=lTMH0CgfVEoJksbazIZYMJleBnvs/c6dYKP1fPME0+utZe8+8E9JpQGly8FBdjqJab
         kVtTAi7K6WRQzqCCZPtmOrcuxiXiui3dmfa6JRsnf+6uTmWkMEyhDuxsu+iFuWKG2jyU
         RTiDsqgPy54WOSjRQ76peD4AclZ5UxXxS2CX8SIx22CJPBjeOmuq4Ka0ZLC7ENFmLMod
         7kBL8D8sg4Cd1X0H7UyjlicsH/smIoyOoZaGIjUW6bkw4DUFpjZOqDP0GYP+2iuSWIPG
         4WQ8WJIds34zhxOyQF31++OLoV1wRACuiS4FmyAsCrpg8gjMRQuOjEOhIKMmYXNsXB8e
         Fdtw==
X-Gm-Message-State: AOJu0YxnZguR7aOZL7Nt2g5ok5LE9QHPEm2k//htx6rlxA6XqpoKEGht
	ohCxyDoPAAq/X8G7mEYD/DJyOHBLlHOI6bP3SZD3SEiaeqPwWm5U72ooxYHLja4mU98e/hrE6JS
	JN3ksrZ1OzCceucgZrzjmD3F0/PVK4eSD
X-Received: by 2002:a50:ee89:0:b0:522:27ea:58b with SMTP id f9-20020a50ee89000000b0052227ea058bmr4325739edr.39.1695588436475;
        Sun, 24 Sep 2023 13:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhn1ad6l/uGWMaFlCP7EaffXL4gtfKw2+dB8XbAD/gKtp0DTUTOMQmTk2SbCL53JF/MrAsZUV+GLBMqckxl1s=
X-Received: by 2002:a50:ee89:0:b0:522:27ea:58b with SMTP id
 f9-20020a50ee89000000b0052227ea058bmr4325730edr.39.1695588436213; Sun, 24 Sep
 2023 13:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com> <20230922155029.592018-3-miquel.raynal@bootlin.com>
In-Reply-To: <20230922155029.592018-3-miquel.raynal@bootlin.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 24 Sep 2023 16:47:05 -0400
Message-ID: <CAK-6q+h_03Gnb+kz3NgumcxS99TV=W_0de2TCLXAk4uPg5W7BA@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 02/11] ieee802154: Internal PAN management
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, David Girault <david.girault@qorvo.com>, 
	Romuald Despres <romuald.despres@qorvo.com>, Frederic Blain <frederic.blain@qorvo.com>, 
	Nicolas Schodet <nico@ni.fr.eu.org>, Guilhem Imberton <guilhem.imberton@qorvo.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, Sep 22, 2023 at 11:50=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Introduce structures to describe peer devices in a PAN as well as a few
> related helpers. We basically care about:
> - Our unique parent after associating with a coordinator.
> - Peer devices, children, which successfully associated with us.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/net/cfg802154.h | 47 ++++++++++++++++++++++++++
>  net/ieee802154/Makefile |  2 +-
>  net/ieee802154/core.c   |  2 ++
>  net/ieee802154/pan.c    | 73 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 123 insertions(+), 1 deletion(-)
>  create mode 100644 net/ieee802154/pan.c
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index f79ce133e51a..a89f1c9cea3f 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -303,6 +303,22 @@ struct ieee802154_coord_desc {
>         bool gts_permit;
>  };
>
> +/**
> + * struct ieee802154_pan_device - PAN device information
> + * @pan_id: the PAN ID of this device
> + * @mode: the preferred mode to reach the device
> + * @short_addr: the short address of this device
> + * @extended_addr: the extended address of this device
> + * @node: the list node
> + */
> +struct ieee802154_pan_device {
> +       __le16 pan_id;
> +       u8 mode;
> +       __le16 short_addr;
> +       __le64 extended_addr;
> +       struct list_head node;
> +};
> +
>  /**
>   * struct cfg802154_scan_request - Scan request
>   *
> @@ -478,6 +494,11 @@ struct wpan_dev {
>
>         /* fallback for acknowledgment bit setting */
>         bool ackreq;
> +
> +       /* Associations */
> +       struct mutex association_lock;
> +       struct ieee802154_pan_device *parent;
> +       struct list_head children;
>  };
>
>  #define to_phy(_dev)   container_of(_dev, struct wpan_phy, dev)
> @@ -529,4 +550,30 @@ static inline const char *wpan_phy_name(struct wpan_=
phy *phy)
>  void ieee802154_configure_durations(struct wpan_phy *phy,
>                                     unsigned int page, unsigned int chann=
el);
>
> +/**
> + * cfg802154_device_is_associated - Checks whether we are associated to =
any device
> + * @wpan_dev: the wpan device
> + * @return: true if we are associated
> + */
> +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev);
> +
> +/**
> + * cfg802154_device_is_parent - Checks if a device is our coordinator
> + * @wpan_dev: the wpan device
> + * @target: the expected parent
> + * @return: true if @target is our coordinator
> + */
> +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> +                               struct ieee802154_addr *target);
> +
> +/**
> + * cfg802154_device_is_child - Checks whether a device is associated to =
us
> + * @wpan_dev: the wpan device
> + * @target: the expected child
> + * @return: the PAN device
> + */
> +struct ieee802154_pan_device *
> +cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> +                         struct ieee802154_addr *target);
> +
>  #endif /* __NET_CFG802154_H */
> diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
> index f05b7bdae2aa..7bce67673e83 100644
> --- a/net/ieee802154/Makefile
> +++ b/net/ieee802154/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_IEEE802154_SOCKET) +=3D ieee802154_socket.o
>  obj-y +=3D 6lowpan/
>
>  ieee802154-y :=3D netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
> -                header_ops.o sysfs.o nl802154.o trace.o
> +                header_ops.o sysfs.o nl802154.o trace.o pan.o
>  ieee802154_socket-y :=3D socket.o
>
>  CFLAGS_trace.o :=3D -I$(src)
> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index 57546e07e06a..cd69bdbfd59f 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -276,6 +276,8 @@ static int cfg802154_netdev_notifier_call(struct noti=
fier_block *nb,
>                 wpan_dev->identifier =3D ++rdev->wpan_dev_id;
>                 list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
>                 rdev->devlist_generation++;
> +               mutex_init(&wpan_dev->association_lock);
> +               INIT_LIST_HEAD(&wpan_dev->children);
>
>                 wpan_dev->netdev =3D dev;
>                 break;
> diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> new file mode 100644
> index 000000000000..1677bb89c5ff
> --- /dev/null
> +++ b/net/ieee802154/pan.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IEEE 802.15.4 PAN management
> + *
> + * Copyright (C) 2023 Qorvo US, Inc
> + * Authors:
> + *   - David Girault <david.girault@qorvo.com>
> + *   - Miquel Raynal <miquel.raynal@bootlin.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <net/cfg802154.h>
> +#include <net/af_ieee802154.h>
> +
> +/* Checks whether a device address matches one from the PAN list.
> + * This helper is meant to be used only during PAN management, when we e=
xpect
> + * extended addresses to be used.
> + */
> +static bool cfg802154_device_in_pan(struct ieee802154_pan_device *pan_de=
v,
> +                                   struct ieee802154_addr *ext_dev)
> +{
> +       if (!pan_dev || !ext_dev)
> +               return false;
> +
> +       if (ext_dev->mode =3D=3D IEEE802154_ADDR_SHORT)
> +               return false;
> +
> +       switch (ext_dev->mode) {
> +       case IEEE802154_ADDR_SHORT:
> +               return pan_dev->short_addr =3D=3D ext_dev->short_addr;

This is dead code now, it will never be reached, it's checked above
(Or I don't see it)? I want to help you here. What exactly do you try
to reach here again?

> +       case IEEE802154_ADDR_LONG:
> +               return pan_dev->extended_addr =3D=3D ext_dev->extended_ad=
dr;
> +       default:
> +               return false;
> +       }
> +}
> +
> +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev)
> +{
> +       bool is_assoc;
> +
> +       mutex_lock(&wpan_dev->association_lock);
> +       is_assoc =3D !list_empty(&wpan_dev->children) || wpan_dev->parent=
;
> +       mutex_unlock(&wpan_dev->association_lock);
> +
> +       return is_assoc;
> +}
> +
> +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> +                               struct ieee802154_addr *target)
> +{
> +       lockdep_assert_held(&wpan_dev->association_lock);
> +
> +       if (cfg802154_device_in_pan(wpan_dev->parent, target))
> +               return true;
> +
> +       return false;

return cfg802154_device_in_pan(...); Why isn't checkpatch warning about tha=
t?

- Alex


