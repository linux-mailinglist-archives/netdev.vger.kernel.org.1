Return-Path: <netdev+bounces-94637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9D08C0077
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE271B20AA7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF686278;
	Wed,  8 May 2024 14:52:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D3E8529C
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179957; cv=none; b=sblJxAeuEDv2bXrks6omzPSd/6bShY+TbF6FsTyHlwATPY8UitsP6iDGYLAI4jx3/hImST1sh6LZhvGTVtP1udg+YGtux1BScs+8/QiZho7Zg5ElXT8QLpi9dHpUgrRxm4oApl/0lfdBS2WTufVOul6YHoLZgwlUB3T1Ep8NATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179957; c=relaxed/simple;
	bh=2fcy52YdPifCaqVZQ9wrF6n+qppFkNw4Hq8MFJLbjyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=VG1hACyGGiY/HC4Ex0wVrYQfxu6jh/DBVuo1iUREC9VXEmr9TYITzPV1Ng/0cm6AV0IKYV3FI9mwCYOXJcpKu0G6t1meVwH5288K5V5HxhFye5iVn/mXji+FRe7qbkDUb3RrUJHwXb5JOcI6kh+m5CsK8b95ByX2dPNF5Fh5rEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-EJmW7gPBMHKhgz2s_-fVNA-1; Wed,
 08 May 2024 10:52:29 -0400
X-MC-Unique: EJmW7gPBMHKhgz2s_-fVNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5739C3802126;
	Wed,  8 May 2024 14:52:29 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38F3228E2;
	Wed,  8 May 2024 14:52:28 +0000 (UTC)
Date: Wed, 8 May 2024 16:52:27 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 04/24] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <ZjuRqyZB0kMINqme@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-5-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-5-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:17 +0200, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index ad3813419c33..338e99dfe886 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -11,6 +11,26 @@
>  #include <linux/skbuff.h>
> =20
>  #include "io.h"
> +#include "ovpnstruct.h"
> +#include "netlink.h"
> +
> +int ovpn_struct_init(struct net_device *dev)

nit: Should this be in main.c? It's only used there, and I think it
would make more sense to drop it next to ovpn_struct_free.

> +{
> +=09struct ovpn_struct *ovpn =3D netdev_priv(dev);
> +=09int err;
> +

[...]
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index 33c0b004ce16..584cd7286aff 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
[...]
> +static void ovpn_struct_free(struct net_device *net)
> +{
> +=09struct ovpn_struct *ovpn =3D netdev_priv(net);
> +
> +=09rtnl_lock();

 ->priv_destructor can run from register_netdevice (already under
RTNL), this doesn't look right.

> +=09list_del(&ovpn->dev_list);

And if this gets called from register_netdevice, the list_add from
ovpn_iface_create hasn't run yet, so this will probably do strange
things?

> +=09rtnl_unlock();
> +
> +=09free_percpu(net->tstats);
> +}
> +
> +static int ovpn_net_open(struct net_device *dev)
> +{
> +=09struct in_device *dev_v4 =3D __in_dev_get_rtnl(dev);
> +
> +=09if (dev_v4) {
> +=09=09/* disable redirects as Linux gets confused by ovpn handling
> +=09=09 * same-LAN routing
> +=09=09 */
> +=09=09IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
> +=09=09IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) =3D false;

Jakub, are you ok with that? This feels a bit weird to have in the
middle of a driver.

> +=09}
> +
> +=09netif_tx_start_all_queues(dev);
> +=09return 0;
> +}

[...]
> +void ovpn_iface_destruct(struct ovpn_struct *ovpn)
> +{
> +=09ASSERT_RTNL();
> +
> +=09netif_carrier_off(ovpn->dev);
> +
> +=09ovpn->registered =3D false;
> +
> +=09unregister_netdevice(ovpn->dev);
> +=09synchronize_net();

If this gets called from the loop in ovpn_netns_pre_exit, one
synchronize_net per ovpn device would seem quite expensive.

> +}
> +
>  static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>  =09=09=09=09     unsigned long state, void *ptr)
>  {
>  =09struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
> +=09struct ovpn_struct *ovpn;
> =20
>  =09if (!ovpn_dev_is_valid(dev))
>  =09=09return NOTIFY_DONE;
> =20
> +=09ovpn =3D netdev_priv(dev);
> +
>  =09switch (state) {
>  =09case NETDEV_REGISTER:
> -=09=09/* add device to internal list for later destruction upon
> -=09=09 * unregistration
> -=09=09 */
> +=09=09ovpn->registered =3D true;
>  =09=09break;
>  =09case NETDEV_UNREGISTER:
> +=09=09/* twiddle thumbs on netns device moves */
> +=09=09if (dev->reg_state !=3D NETREG_UNREGISTERING)
> +=09=09=09break;
> +
>  =09=09/* can be delivered multiple times, so check registered flag,
>  =09=09 * then destroy the interface
>  =09=09 */
> +=09=09if (!ovpn->registered)
> +=09=09=09return NOTIFY_DONE;
> +
> +=09=09ovpn_iface_destruct(ovpn);

Maybe I'm misunderstanding this code. Why do you want to manually
destroy a device that is already going away?

>  =09=09break;
>  =09case NETDEV_POST_INIT:
>  =09case NETDEV_GOING_DOWN:
>  =09case NETDEV_DOWN:
>  =09case NETDEV_UP:
>  =09case NETDEV_PRE_UP:
> +=09=09break;
>  =09default:
>  =09=09return NOTIFY_DONE;
>  =09}
> @@ -62,6 +210,24 @@ static struct notifier_block ovpn_netdev_notifier =3D=
 {
>  =09.notifier_call =3D ovpn_netdev_notifier_call,
>  };
> =20
> +static void ovpn_netns_pre_exit(struct net *net)
> +{
> +=09struct ovpn_struct *ovpn;
> +
> +=09rtnl_lock();
> +=09list_for_each_entry(ovpn, &dev_list, dev_list) {
> +=09=09if (dev_net(ovpn->dev) !=3D net)
> +=09=09=09continue;
> +
> +=09=09ovpn_iface_destruct(ovpn);

Is this needed? On netns destruction all devices within the ns will be
destroyed by the networking core.

> +=09}
> +=09rtnl_unlock();
> +}

--=20
Sabrina


