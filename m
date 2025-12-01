Return-Path: <netdev+bounces-242912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E9C96348
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 09:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AEC03411B9
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8EE2E7182;
	Mon,  1 Dec 2025 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="W3yrse+E"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E5133985
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578315; cv=none; b=gWqh6bUzRUDcxSnR4NO+ZlJDs1+tk9xED14iA2nVpOBLt+VuAv3qEA8VfEnoDDFTs118EwSPmvzrdcyvjg9jWWGNed+xEaNm0BNW3yty+DUGePTfwKLiprUEuQ1Q+DXUDzcWwPxDvj6L1UrcEMPCyI0CJH8zGbMomzCx8dpyUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578315; c=relaxed/simple;
	bh=CJnutFptugJawrpk4Y7mfOU6178M/8C7migrWyu0RfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtY1cZ0qt+doXDIWM//p6gVotO84GEHPtog4k946U4u6p6h9saIkkw3LBFkb7z6EBHA2yhHS1ftS6wD9J1YIPzz4cHl76iakl7272pf3xszwxPWnzrFsmVsIj69LRs4EIXtt2KzfNDrHUw1H9uG49XFqhyqB8M36E4TVYLYhVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=W3yrse+E; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB86210BF57;
	Mon,  1 Dec 2025 09:32:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1764577974;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hDUgK3FrA3cw6we1m81JE8n0/Zv8w6BEiv2ox618I5k=;
	b=W3yrse+EttJ/hgfOEpySt2K7goITfa5Lj8kCkN0/1OY7rg8mqF71sj6vMMVChmFTl6i+1/
	FtSmTQYO1FeW/nr9lNTby69ii4+bMhAKoTx9E9lmepes28ORIfHbgrCK13jPXIrsiW+mGv
	OVZEIjYb6+NhRosdis2spdmk8TCy3/cu95dsUrcjh22Ytls+8H9fIij3xe/KJ2k61t3od6
	lxNnkJrhrzVMwUpwP1zeC5iYVm2U+A6SoBcDuK0JWX2IfdZf1YnLrFcxT3ptK2YrbTxFmO
	xfhqTau6MmNpZJQaT1JzoDnaiYvNti5ig4p4uygW9ZMAuL4PqFEKEsTQ5iKO7w==
Date: Mon, 1 Dec 2025 09:32:49 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, Xiaoliang
 Yang <xiaoliang.yang_1@nxp.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH net-next 02/15] net: hsr: create an API to get hsr port
 type
Message-ID: <20251201093249.6e451e07@wsk>
In-Reply-To: <20251130131657.65080-3-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
	<20251130131657.65080-3-vladimir.oltean@nxp.com>
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

Hi Vladimir,

> From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
>=20
> Since the introduction of HSR_PT_INTERLINK in commit 5055cccfc2d1
> ("net: hsr: Provide RedBox support (HSR-SAN)"), we see that different
> port types require different settings for hardware offload, which was
> not the case before when we only had HSR_PT_SLAVE_A and
> HSR_PT_SLAVE_B. But there is currently no way to know which port is
> which type, so create the hsr_get_port_type() API function and export
> it.
>=20
> When hsr_get_port_type() is called from the device driver, the port
> can must be found in the HSR port list. An important use case is for
^^^^^^^^^^ - I think that can is redundant here.

> this function to work from offloading drivers' NETDEV_CHANGEUPPER
> handler, which is triggered by hsr_portdev_setup() ->
> netdev_master_upper_dev_link(). Therefore, we need to move the
> addition of the hsr_port to the HSR port list prior to calling
> hsr_portdev_setup(). This makes the error restoration path also more
> similar to hsr_del_port(), where kfree_rcu(port) is already used.
>=20
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Lukasz Majewski <lukma@denx.de>
> Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  include/linux/if_hsr.h |  9 +++++++++
>  net/hsr/hsr_device.c   | 20 ++++++++++++++++++++
>  net/hsr/hsr_slave.c    |  7 ++++---
>  3 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index d7941fd88032..f4cf2dd36d19 100644
> --- a/include/linux/if_hsr.h
> +++ b/include/linux/if_hsr.h
> @@ -43,6 +43,8 @@ extern bool is_hsr_master(struct net_device *dev);
>  extern int hsr_get_version(struct net_device *dev, enum hsr_version
> *ver); struct net_device *hsr_get_port_ndev(struct net_device *ndev,
>  				     enum hsr_port_type pt);
> +int hsr_get_port_type(struct net_device *hsr_dev, struct net_device
> *dev,
> +		      enum hsr_port_type *type);
>  #else
>  static inline bool is_hsr_master(struct net_device *dev)
>  {
> @@ -59,6 +61,13 @@ static inline struct net_device
> *hsr_get_port_ndev(struct net_device *ndev, {
>  	return ERR_PTR(-EINVAL);
>  }
> +
> +static inline int hsr_get_port_type(struct net_device *hsr_dev,
> +				    struct net_device *dev,
> +				    enum hsr_port_type *type)
> +{
> +	return -EINVAL;
> +}
>  #endif /* CONFIG_HSR */
> =20
>  #endif /*_LINUX_IF_HSR_H_*/
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 492cbc78ab75..d1bfc49b5f01 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -690,6 +690,26 @@ struct net_device *hsr_get_port_ndev(struct
> net_device *ndev, }
>  EXPORT_SYMBOL(hsr_get_port_ndev);
> =20
> +int hsr_get_port_type(struct net_device *hsr_dev, struct net_device
> *dev,
> +		      enum hsr_port_type *type)
> +{
> +	struct hsr_priv *hsr =3D netdev_priv(hsr_dev);
> +	struct hsr_port *port;
> +
> +	rcu_read_lock();
> +	hsr_for_each_port(hsr, port) {
> +		if (port->dev =3D=3D dev) {
> +			*type =3D port->type;
> +			rcu_read_unlock();
> +			return 0;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(hsr_get_port_type);
> +
>  /* Default multicast address for HSR Supervision frames */
>  static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2)
> =3D { 0x01, 0x15, 0x4e, 0x00, 0x01, 0x00
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index 8177ac6c2d26..afe06ba00ea4 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -207,14 +207,14 @@ int hsr_add_port(struct hsr_priv *hsr, struct
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
> @@ -222,7 +222,8 @@ int hsr_add_port(struct hsr_priv *hsr, struct
> net_device *dev, return 0;
> =20
>  fail_dev_setup:
> -	kfree(port);
> +	list_del_rcu(&port->port_list);
> +	kfree_rcu(port, rcu);
>  	return res;
>  }
> =20

Reviewed-by: =C5=81ukasz Majewski <lukma@nabladev.com>

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Managing Director : Stefano Babic

