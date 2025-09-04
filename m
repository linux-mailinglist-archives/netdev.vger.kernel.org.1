Return-Path: <netdev+bounces-220137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E94B448D6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8400165D41
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5A2C326B;
	Thu,  4 Sep 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mcYRQTsi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74D02C21F6;
	Thu,  4 Sep 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022756; cv=none; b=L3nvXj6o2QUTcFS8dRI5oZFM5VU22l9tg9qAbYqBL+ti9we7LYXx4iWn6M4VuGvXYXcbTVEkBsJgnZ1NSgrYp4XXPcCp6e2qiZ6h84Hyi8Z/jSi71tMPdHDt2DIvo3iwKFTLFhQbxC8wQImOoLTtDsQI7f8bKbgEwp23PqD9X4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022756; c=relaxed/simple;
	bh=Wwb7gLuPH5i2MVOO8a0ZF1bZVeRY0sNVbcFPH0tOyUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T2X1lGydTxcoWppKBX5D4kPWErsPMrtDm5IHj0vfAixpv4NvkAu8HKIdhGtjglyMI8twkKDYZc7XuHEffC8OtTUGjDAq2q+yXwydx3vgbfVYQgJXqZp8yW6kNXX3N9YZITQcIzH4MeLcbtBJ44kt0JvVYyJ9S+5BnWPq66/MvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mcYRQTsi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D2DCE1A0DC0;
	Thu,  4 Sep 2025 21:52:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9B063606C4;
	Thu,  4 Sep 2025 21:52:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26E03102F0F1B;
	Thu,  4 Sep 2025 23:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757022748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VhdwOIRNIGUQjVektyYqHZFliftV2xljBQytyUGG8AY=;
	b=mcYRQTsidacdxu16HyA4ytNGA6KapP94Uja9WvEe+/TuVE0a0pj9Q1EPehDG+B50qSYahQ
	4UHc67bGoXqiUdGHbhQb69APflPOywZ3mUqoJO/e7VMf2KMR0HyYeybzKpmGYIP1pn4M2P
	Z29bFQRPLprAuG9UCqCQsD6fWy9R4142c5IkTX3hSTf4qL8aYdkaaSqs4Y2QZEOeFNiojO
	qfQEuUnvCTScyF9mOcr0e9FlAbyCX0n5aAkhnWgW25mNeSQI0ocXDxWSaM+c+Nbi78VHDP
	GuXdC5LkLK1RR4dakRHjyn1JEBlyyTB4fxWyGyaFkiIK8hMdDY4QkhZEC/yqIw==
Date: Thu, 4 Sep 2025 23:52:25 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook
 <kees@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net] net: dev_ioctl: take ops lock in hwtstamp lower
 paths
Message-ID: <20250904235155.7b2b3379@kmaincent-XPS-13-7390>
In-Reply-To: <20250904182806.2329996-1-cjubran@nvidia.com>
References: <20250904182806.2329996-1-cjubran@nvidia.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 4 Sep 2025 21:28:06 +0300
Carolina Jubran <cjubran@nvidia.com> wrote:

> ndo hwtstamp callbacks are expected to run under the per-device ops
> lock. Make the lower get/set paths consistent with the rest of ndo
> invocations.
>=20
> Kernel log:
> WARNING: CPU: 13 PID: 51364 at ./include/net/netdev_lock.h:70
> __netdev_update_features+0x4bd/0xe60 ...
> RIP: 0010:__netdev_update_features+0x4bd/0xe60
> ...
> Call Trace:
> <TASK>
> netdev_update_features+0x1f/0x60
> mlx5_hwtstamp_set+0x181/0x290 [mlx5_core]
> mlx5e_hwtstamp_set+0x19/0x30 [mlx5_core]

Where does these two functions come from? They are not mainline.
Else LGTM.

> dev_set_hwtstamp_phylib+0x9f/0x220
> dev_set_hwtstamp_phylib+0x9f/0x220
> dev_set_hwtstamp+0x13d/0x240
> dev_ioctl+0x12f/0x4b0
> sock_ioctl+0x171/0x370
> __x64_sys_ioctl+0x3f7/0x900
> ? __sys_setsockopt+0x69/0xb0
> do_syscall_64+0x6f/0x2e0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
> ...
> </TASK>
> ....
> ---[ end trace 0000000000000000 ]---
>=20
> Fixes: ffb7ed19ac0a ("net: hold netdev instance lock during ioctl operati=
ons")
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>=20
> ---
>  net/core/dev_ioctl.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 9c0ad7f4b5d8..ad54b12d4b4c 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -464,8 +464,15 @@ int generic_hwtstamp_get_lower(struct net_device *de=
v,
>  	if (!netif_device_present(dev))
>  		return -ENODEV;
> =20
> -	if (ops->ndo_hwtstamp_get)
> -		return dev_get_hwtstamp_phylib(dev, kernel_cfg);
> +	if (ops->ndo_hwtstamp_get) {
> +		int err;
> +
> +		netdev_lock_ops(dev);
> +		err =3D dev_get_hwtstamp_phylib(dev, kernel_cfg);
> +		netdev_unlock_ops(dev);
> +
> +		return err;
> +	}
> =20
>  	/* Legacy path: unconverted lower driver */
>  	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
> @@ -481,8 +488,15 @@ int generic_hwtstamp_set_lower(struct net_device *de=
v,
>  	if (!netif_device_present(dev))
>  		return -ENODEV;
> =20
> -	if (ops->ndo_hwtstamp_set)
> -		return dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
> +	if (ops->ndo_hwtstamp_set) {
> +		int err;
> +
> +		netdev_lock_ops(dev);
> +		err =3D dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
> +		netdev_unlock_ops(dev);
> +
> +		return err;
> +	}
> =20
>  	/* Legacy path: unconverted lower driver */
>  	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

