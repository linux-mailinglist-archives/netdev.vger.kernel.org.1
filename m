Return-Path: <netdev+bounces-209329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CC4B0F205
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11A43AC457
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33F32E5B1B;
	Wed, 23 Jul 2025 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Ajrx7Rf0"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1928A40A;
	Wed, 23 Jul 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272910; cv=none; b=uGu2wtGDlE7Xg55AXilHKI4s8D+9sil4LSDTcNDgrbFoVId95WIjkwgzf8OzEN1F5ylPuEXcNmdqn87dSJBlihDLC9ZItyk21fURYhkIGtOANbnEMsVBzgB1QM6nBdoiZyqrQjrfcxCWNU3N7XU81S9hjVJKnBrIZT9JcLBx4UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272910; c=relaxed/simple;
	bh=RcluaWSTV7RMhkPYtyGkDhq29CxqkDH6LdyrXzW2thg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ie2yPG3HPRKDXpD0bZ+E6BxGbfNx3RCLKjtEh6QLBoSlK7RxsL437Iut6qUrHHcMXkMiCBk6OOo2/T0vJjEB13aWFwQ55o91Z/0lh+MAPhNXYZyMGyMyQyxE/UXfYgtg5FI+8/cdxImP4uo7OY0dDghW6yU3qKYPWpjnYSKLLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Ajrx7Rf0; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 777EB1027235A;
	Wed, 23 Jul 2025 14:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753272899; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=A6bPf2Y/Ys3k1BjHRjcA9utwD41fKPr22Vm5lBdHYVI=;
	b=Ajrx7Rf0o5qqIM5S40zV7/mqL9oEzAuXCUFmf8S51oIgvpm29CZm2HeZjxvYX6YRcmgq/8
	JnWYWcEBr+HzK4xa3BKu1A4S/3SlVpBAWyEgmLTxWMO7Jt3hh3zWfpm5/wO0NYoJz6eYkb
	Zs1v7VOW7ZI4cQ44V8zmw+ui5twFuPtI2Ga4PyA6LaQIquKe70JZafVZ6LJNiqm463xiDx
	seXcNKOC3Py5uUq5mJTw+iR4wovBBxfRuIgAXMz4BE48n1kzsP+ozAR0QqJIvnCBNZCXV5
	jeW2J8nAx46UxMOGxhazwouyirBOF1DUzRYoVk/JOEX1y+BC//yWlN14YG21mw==
Date: Wed, 23 Jul 2025 14:14:51 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, n.zhandarovich@fintech.ru,
 edumazet@google.com, pabeni@redhat.com, wojciech.drewek@intel.com,
 Arvid.Brodin@xdin.com, horms@kernel.org, m-karicheri2@ti.com,
 vladimir.oltean@nxp.com
Subject: Re: [RFC PATCH net-next] net: hsr: create an API to get hsr port
 type
Message-ID: <20250723141451.314b9b77@wsk>
In-Reply-To: <20250723104754.29926-1-xiaoliang.yang_1@nxp.com>
References: <20250723104754.29926-1-xiaoliang.yang_1@nxp.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6H=lA4buJ3pmUfyU2INlSc/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/6H=lA4buJ3pmUfyU2INlSc/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Xiaoliang,

> If a switch device has HSR hardware ability and HSR configuration
> offload to hardware. The device driver needs to get the HSR port type
> when joining the port to HSR. Different port types require different
> settings for the hardware, like HSR_PT_SLAVE_A, HSR_PT_SLAVE_B, and
> HSR_PT_INTERLINK. Create the API hsr_get_port_type() and export it.
>=20

Could you describe the use case in more detail - as pointed out by
Vladimir?

In my use case - when I use the KSZ9477 switch I just provide correct
arguments for the iproute2 configuration:

# Configuration - RedBox (EVB-KSZ9477):
if link set lan1 down;ip link set lan2 down
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45
	 version 1
ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 interlink lan3=20
	supervision 45 version 1
ip link set lan4 up;ip link set lan5 up
ip link set lan3 up
ip addr add 192.168.0.11/24 dev hsr1
ip link set hsr1 up

# Configuration - DAN-H (EVB-KSZ9477):
ip link set lan1 down;ip link set lan2 down
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45
	version 1
ip link add name hsr1 type hsr slave1 lan4 slave2 lan5 supervision 45
	version 1
ip link set lan4 up;ip link set lan5 up
ip addr add 192.168.0.12/24 dev hsr1
ip link set hsr1 up

More info (also regarding HSR testing with QEMU) can be found from:
https://lpc.events/event/18/contributions/1969/attachments/1456/3092/lpc-20=
24-HSR-v1.0-e26d140f6845e94afea.pdf


As fair as I remember - the Node Table can be read from debugfs.

However, such approach has been regarded as obsolete - by the
community.=20

In the future development plans there was the idea to use netlink (or
iproute separate program) to get the data now available in debugfs and
extend it to also print REDBOX node info (not only DANH).

> When the hsr_get_port_type() is called in the device driver, if the
> port can be found in the HSR port list, the HSR port type can be
> obtained. Therefore, before calling the device driver, we need to
> first add the hsr_port to the HSR port list.
>=20
> Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> ---
>  include/linux/if_hsr.h |  8 ++++++++
>  net/hsr/hsr_device.c   | 20 ++++++++++++++++++++
>  net/hsr/hsr_slave.c    |  7 ++++---
>  3 files changed, 32 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index d7941fd88032..4d6452ca2ac8 100644
> --- a/include/linux/if_hsr.h
> +++ b/include/linux/if_hsr.h
> @@ -43,6 +43,8 @@ extern bool is_hsr_master(struct net_device *dev);
>  extern int hsr_get_version(struct net_device *dev, enum hsr_version
> *ver); struct net_device *hsr_get_port_ndev(struct net_device *ndev,
>  				     enum hsr_port_type pt);
> +extern int hsr_get_port_type(struct net_device *hsr_dev, struct
> net_device *dev,
> +			     enum hsr_port_type *type);
>  #else
>  static inline bool is_hsr_master(struct net_device *dev)
>  {
> @@ -59,6 +61,12 @@ static inline struct net_device
> *hsr_get_port_ndev(struct net_device *ndev, {
>  	return ERR_PTR(-EINVAL);
>  }
> +
> +static inline int hsr_get_port_type(struct net_device *hsr_dev,
> struct net_device *dev,
> +				    enum hsr_port_type *type)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_HSR */
> =20
>  #endif /*_LINUX_IF_HSR_H_*/
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 88657255fec1..d4bea847527c 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -679,6 +679,26 @@ struct net_device *hsr_get_port_ndev(struct
> net_device *ndev, }
>  EXPORT_SYMBOL(hsr_get_port_ndev);
> =20
> +/* Get hsr port type, return -EINVAL if not get.
> + */
> +int hsr_get_port_type(struct net_device *hsr_dev, struct net_device
> *dev, enum hsr_port_type *type) +{
> +	struct hsr_priv *hsr;
> +	struct hsr_port *port;
> +
> +	hsr =3D netdev_priv(hsr_dev);
> +
> +	hsr_for_each_port(hsr, port) {
> +		if (port->dev =3D=3D dev) {
> +			*type =3D port->type;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(hsr_get_port_type);
> +
>  /* Default multicast address for HSR Supervision frames */
>  static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2)
> =3D { 0x01, 0x15, 0x4e, 0x00, 0x01, 0x00
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index b87b6a6fe070..e11ab1ed3320 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -198,14 +198,14 @@ int hsr_add_port(struct hsr_priv *hsr, struct
> net_device *dev, port->type =3D type;
>  	ether_addr_copy(port->original_macaddress, dev->dev_addr);
> =20
> +	list_add_tail_rcu(&port->port_list, &hsr->ports);
> +
>  	if (type !=3D HSR_PT_MASTER) {
>  		res =3D hsr_portdev_setup(hsr, dev, port, extack);
>  		if (res)
>  			goto fail_dev_setup;
>  	}
> =20
> -	list_add_tail_rcu(&port->port_list, &hsr->ports);
> -
>  	master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
>  	netdev_update_features(master->dev);
>  	dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
> @@ -213,7 +213,8 @@ int hsr_add_port(struct hsr_priv *hsr, struct
> net_device *dev, return 0;
> =20
>  fail_dev_setup:
> -	kfree(port);
> +	list_del_rcu(&port->port_list);
> +	kfree_rcu(port, rcu);
>  	return res;
>  }
> =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/6H=lA4buJ3pmUfyU2INlSc/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmiA0jsACgkQAR8vZIA0
zr0erAf+ID2j+HMO54CTX/P4xMr3wl0J7QHferAsHox/jYTuAfwcWKEEVsrHsj+B
3M7A0Lics3/UB8ySusKXOxpgXR9mrJ/MZyr2aLcoyJNhHhcGOTinNiHKjs0Pj1a9
B7iPD98keCXMRx7fmqlar72rQBv0sUyyFRkpjdbgsWyn/+LuMo89W5VlUWtp1+hA
HWS6bz5mNZG1LYa6/CWKozqvACBab3yYliPRX1PO1Kqezsx6XsCJ2Xq5P1HYq4E6
FOBC7ojdzw9q4149Ta6LdYcyHWjhvBR528t1j9ASX0NOJVoGmtbgdlUxRncz63dz
FHbzcU3o7SddZMqztnf1oE0+aQiWhA==
=aenT
-----END PGP SIGNATURE-----

--Sig_/6H=lA4buJ3pmUfyU2INlSc/--

