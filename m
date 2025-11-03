Return-Path: <netdev+bounces-235237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49A9C2E10A
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 21:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668603AC3AC
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 20:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04002C11E6;
	Mon,  3 Nov 2025 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="01dL7c1V"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAB21C16E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203174; cv=none; b=BbbxXKCCw+BeNiNu76MPxfPeZ/7s6nk+/gjDEgShfZ2v563HqiwwtuEF95Oji99LjlNfiqcuGLPf2GdcqzuTIHy8hm9uXhGDbGbbBQZZdw2zVtGrix0zgV+0CgDEBjbE/YUEZNOMhNXUxGOWpR2q1QuaASLGXde1OIYiWoTOazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203174; c=relaxed/simple;
	bh=yhpFLdb8LOwSYBBWQv5JSNuKONGEBLiALxBoop2Ht6I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyFymfYiw+15T6jit3HjtzGqo+ZWkobDG/Oqh+Ma52L1oRnH2EqWzfVsmyoE2dZ+mLVICqOLhxSDXqiyYKhYnTxdM1HBWRUmSjOgqd7iwy2JhPQN1tqBVRAj6r/MVlqwU7vCiDzgL1a8IUuGECaB4v887LrWJRe0OOnzfwtC6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=01dL7c1V; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8D3A41A1864;
	Mon,  3 Nov 2025 20:52:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C8E060628;
	Mon,  3 Nov 2025 20:52:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88BD110B50075;
	Mon,  3 Nov 2025 21:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762203166; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R4Nfsneitz3w2sLpemaMflomcibHN2PqB3MfSETM9Lo=;
	b=01dL7c1VpuURirTrRsJfYJdroqn0prAHnbGo+yGgTZT09hf3p7oZrUf/f9+55HpG3ug+uT
	9+Kh/VImyI4X7TrfIB+R3fGnrHHT0X1u8YOOxId4csqPW2HooOBmbZPskLe6Hd97Bh1wph
	wAXfaQrYZAGcbStRtRky3gUtT5XnhgjZ0QLfyPmCGj+4KTEcZvPmjUjuP/SnyD3YTUlB5V
	6mRNVCYlcOaPjDMy4pqJ5bcJD0LAwII7ny516KbnkDnMe7rhf/DEjdrsBsFAFTIOrhha2a
	blbY9uQmbadu4lFm+rEL41kumE6RUWM0biDWw4MAqKKh9mNsBpjflh3qm/LyhQ==
Date: Mon, 3 Nov 2025 21:52:40 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2] ti: netcp: convert to ndo_hwtstamp
 callbacks
Message-ID: <20251103215240.7057f8cb@kmaincent-XPS-13-7390>
In-Reply-To: <20251103172902.3538392-1-vadim.fedorenko@linux.dev>
References: <20251103172902.3538392-1-vadim.fedorenko@linux.dev>
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

On Mon,  3 Nov 2025 17:29:02 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> Convert TI NetCP driver to use ndo_hwtstamp_get()/ndo_hwtstamp_set()
> callbacks. The logic is slightly changed, because I believe the original
> logic was not really correct. Config reading part is using the very
> first module to get the configuration instead of iterating over all of
> them and keep the last one as the configuration is supposed to be identic=
al
> for all modules. HW timestamp config set path is now trying to configure
> all modules, but in case of error from one module it adds extack
> message. This way the configuration will be as synchronized as possible.
>=20
> There are only 2 modules using netcp core infrastructure, and both use
> the very same function to configure HW timestamping, so no actual
> difference in behavior is expected.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
> v1 -> v2:
> - avoid changing logic and hiding errors. keep the call failing after
>   the first error
> ---

...

> +
> +	for_each_module(netcp, intf_modpriv) {
> +		module =3D intf_modpriv->netcp_module;
> +		if (!module->hwtstamp_set)
> +			continue;
> +
> +		err =3D module->hwtstamp_set(intf_modpriv->module_priv, config,
> +					   extack);
> +		if ((err < 0) && (err !=3D -EOPNOTSUPP)) {
> +			NL_SET_ERR_MSG_WEAK_MOD(extack,
> +						"At least one module failed
> to setup HW timestamps");
> +			ret =3D err;
> +			goto out;

Why don't you use break.

> +		}
> +		if (err =3D=3D 0)
> +			ret =3D err;
> +	}
> +
> +out:
> +	return (ret =3D=3D 0) ? 0 : err;
> +}
> +

...

> -static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
> +static int gbe_hwtstamp_set(void *intf_priv, struct kernel_hwtstamp_conf=
ig
> *cfg,
> +			    struct netlink_ext_ack *extack)
>  {
> -	struct gbe_priv *gbe_dev =3D gbe_intf->gbe_dev;
> -	struct cpts *cpts =3D gbe_dev->cpts;
> -	struct hwtstamp_config cfg;
> +	struct gbe_intf *gbe_intf =3D intf_priv;
> +	struct gbe_priv *gbe_dev;
> +	struct phy_device *phy;
> =20
> -	if (!cpts)
> +	gbe_dev =3D gbe_intf->gbe_dev;
> +
> +	if (!gbe_dev->cpts)
>  		return -EOPNOTSUPP;
> =20
> -	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
> -		return -EFAULT;
> +	phy =3D gbe_intf->slave->phy;
> +	if (phy_has_hwtstamp(phy))
> +		return phy->mii_ts->hwtstamp(phy->mii_ts, cfg, extack);

Sorry to come back to this but the choice of using PHY or MAC timestamping =
is
done in the core. Putting this here may conflict with the core.
I know this driver has kind of a weird PHYs management through slave
description but we shouldn't let the MAC driver call the PHY hwtstamp ops.=
=20
If there is indeed an issue due to the weird development of this driver, pe=
ople
will write a patch specifically tackling this issue and maybe (by luck)
refactoring this driver.

Anyway, this was not in the driver before, so I think we should not make th=
is
change in this patch.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

