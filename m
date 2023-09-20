Return-Path: <netdev+bounces-35308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B17A8B5F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66071B20A93
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0B23CCF9;
	Wed, 20 Sep 2023 18:12:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44A3CCE0
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 18:12:08 +0000 (UTC)
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E709AC6;
	Wed, 20 Sep 2023 11:12:02 -0700 (PDT)
Received: from [192.168.2.51] (p4fe71b42.dip0.t-ipconnect.de [79.231.27.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 4ED51C0280;
	Wed, 20 Sep 2023 20:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1695233514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwghPXzQ3XmNddMzYScKvEodALXJyaKA0btd9YqJ2WM=;
	b=cuRDUUvu/ndfDuW8CCOnpuSEh9YBxXvrSvg+qG0oV5a1X+pQPXON21snwdxHV/uE0LnY47
	Z5AIxSCQOn2kSG2OuEOa2wIFqbLaJA7BW7p9X3P843/LhST3ZppXxSS0y2hAh98Tnt+LIm
	tAoCobFqhdbY18lcBa+8Ma+FgKlznbisZgp7NlJRRfdG9AknlME5DT2HPPTwL4jNre3dCQ
	y2rfxak53kn5ptkcNYHr2d9BR6JBSmh/7S7b1a9ZzSHcCT9U5zrnZ/PHMhBt6KLA8wFXg/
	CeuVnPFUcMYKWXHu13r4Yhjj16FwnMtEm17SUEMSeliivZqfksachDJzXogm0w==
Message-ID: <d6ac4dbc-a5c1-fbd0-41d5-d8d87ce8e2f9@datenfreihafen.org>
Date: Wed, 20 Sep 2023 20:08:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH wpan-next v3 02/11] ieee802154: Internal PAN management
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 David Girault <david.girault@qorvo.com>,
 Romuald Despres <romuald.despres@qorvo.com>,
 Frederic Blain <frederic.blain@qorvo.com>,
 Nicolas Schodet <nico@ni.fr.eu.org>,
 Guilhem Imberton <guilhem.imberton@qorvo.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230918150809.275058-1-miquel.raynal@bootlin.com>
 <20230918150809.275058-3-miquel.raynal@bootlin.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20230918150809.275058-3-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello.

On 18.09.23 17:08, Miquel Raynal wrote:
> Introduce structures to describe peer devices in a PAN as well as a few
> related helpers. We basically care about:
> - Our unique parent after associating with a coordinator.
> - Peer devices, children, which successfully associated with us.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   include/net/cfg802154.h | 46 +++++++++++++++++++++++++
>   net/ieee802154/Makefile |  2 +-
>   net/ieee802154/core.c   |  2 ++
>   net/ieee802154/pan.c    | 75 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 124 insertions(+), 1 deletion(-)
>   create mode 100644 net/ieee802154/pan.c
> 
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index f79ce133e51a..6c7193b4873c 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -303,6 +303,22 @@ struct ieee802154_coord_desc {
>   	bool gts_permit;
>   };
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
> +	__le16 pan_id;
> +	u8 mode;
> +	__le16 short_addr;
> +	__le64 extended_addr;
> +	struct list_head node;
> +};
> +
>   /**
>    * struct cfg802154_scan_request - Scan request
>    *
> @@ -478,6 +494,11 @@ struct wpan_dev {
>   
>   	/* fallback for acknowledgment bit setting */
>   	bool ackreq;
> +
> +	/* Associations */
> +	struct mutex association_lock;
> +	struct ieee802154_pan_device *parent;
> +	struct list_head children;
>   };
>   
>   #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
> @@ -529,4 +550,29 @@ static inline const char *wpan_phy_name(struct wpan_phy *phy)
>   void ieee802154_configure_durations(struct wpan_phy *phy,
>   				    unsigned int page, unsigned int channel);
>   
> +/**
> + * cfg802154_device_is_associated - Checks whether we are associated to any device
> + * @wpan_dev: the wpan device
> + */
> +bool cfg802154_device_is_associated(struct wpan_dev *wpan_dev);

The return value still missing in kdoc. Seems you missed this from my 
last review. :-)

> +/**
> + * cfg802154_device_is_parent - Checks if a device is our coordinator
> + * @wpan_dev: the wpan device
> + * @target: the expected parent
> + * @return: true if @target is our coordinator
> + */
> +bool cfg802154_device_is_parent(struct wpan_dev *wpan_dev,
> +				struct ieee802154_addr *target);
> +
> +/**
> + * cfg802154_device_is_child - Checks whether a device is associated to us
> + * @wpan_dev: the wpan device
> + * @target: the expected child
> + * @return: the PAN device
> + */
> +struct ieee802154_pan_device *
> +cfg802154_device_is_child(struct wpan_dev *wpan_dev,
> +			  struct ieee802154_addr *target);
> +
>   #endif /* __NET_CFG802154_H */
> diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
> index f05b7bdae2aa..7bce67673e83 100644
> --- a/net/ieee802154/Makefile
> +++ b/net/ieee802154/Makefile
> @@ -4,7 +4,7 @@ obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
>   obj-y += 6lowpan/
>   
>   ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
> -                header_ops.o sysfs.o nl802154.o trace.o
> +                header_ops.o sysfs.o nl802154.o trace.o pan.o
>   ieee802154_socket-y := socket.o
>   
>   CFLAGS_trace.o := -I$(src)
> diff --git a/net/ieee802154/core.c b/net/ieee802154/core.c
> index 57546e07e06a..cd69bdbfd59f 100644
> --- a/net/ieee802154/core.c
> +++ b/net/ieee802154/core.c
> @@ -276,6 +276,8 @@ static int cfg802154_netdev_notifier_call(struct notifier_block *nb,
>   		wpan_dev->identifier = ++rdev->wpan_dev_id;
>   		list_add_rcu(&wpan_dev->list, &rdev->wpan_dev_list);
>   		rdev->devlist_generation++;
> +		mutex_init(&wpan_dev->association_lock);
> +		INIT_LIST_HEAD(&wpan_dev->children);
>   
>   		wpan_dev->netdev = dev;
>   		break;
> diff --git a/net/ieee802154/pan.c b/net/ieee802154/pan.c
> new file mode 100644
> index 000000000000..012b5e821d54
> --- /dev/null
> +++ b/net/ieee802154/pan.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IEEE 802.15.4 PAN management
> + *
> + * Copyright (C) 2021 Qorvo US, Inc

Feel free to extend the copyright years to 2023 as well.

regards
Stefan Schmidt

