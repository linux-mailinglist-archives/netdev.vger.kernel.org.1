Return-Path: <netdev+bounces-288382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG8vKylSB2qnyQIAu9opvQ
	(envelope-from <netdev+bounces-288382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:04:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C76554652
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 19:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BEB513055856
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54F4C040D;
	Fri, 15 May 2026 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5rx6qwb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A34C6EF9
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863974; cv=none; b=WFPp//kDB3KyPnY3hq6GBzW2Ol/mMJ9BkdQvJNzgC1L7DIAbS2ZymRZ7oTCeIWmDXU8LTAh7AF3xiVhtDA3YBE7RmLMIEAfj43xPjJrgbJkPdPIpPlkjibRSeii+4UpZTJ5+gdzf1FJoS1ZRoBHjzzEWj5zD06KzxyVtuhHBky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863974; c=relaxed/simple;
	bh=jqy6pie5NKXVd5lptsDRlT9orMAig9Xp/4v49EmxTXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOj8fDD9j3ykvWqQvk5eoVQMZffzurdgK6tU8wIkioXdVo99f/7TiNBwJVMO3GJlLrztrCmaweqPFNeeGvH+wX3qqROntMmLlwyoYr1UyqXcmxZatXLyOcWIrssWcGHbQZXEiYS2PYguJ7yCC2+hqGMfztCPR3gkBf6yI1BNCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5rx6qwb; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8379e010b01so15362b3a.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778863972; x=1779468772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YEaTPZsnfnlCqQjTdEY5h+UhTgui6HNvvTL5mus4tlk=;
        b=D5rx6qwbyGd+Od+A/n3rbVVHyj8d9Qt8JsPs8r/rKcnVtU6G+7/R0JAa20m6CkQ6nn
         0jqNxpBZtK2rJ31MwTP/ytzj8EuZtrVBWkofe335zA7UN1ZoONylFFs9ax+p3P8gFUEG
         y351laZBJjPXdQGYQ3ZgYPVxGDYyJgeL6CIa9WdQzi3ZXa8fcCm+lzOTRDUlkcMAEwK+
         JmfRFi+cAm+YbwkPTaEr+ihzM9JWsj70km7/XoKKhXCrQJ4vkKrcEc+rri4vS7LlbJXP
         bFI4gNTUIanh5mxMle3ljaTkMDpL/jdyGi5pvnecOz6iTvWLI8bA6g8QJIHerCt+KIaK
         FExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863972; x=1779468772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YEaTPZsnfnlCqQjTdEY5h+UhTgui6HNvvTL5mus4tlk=;
        b=lX8F1WW7qNoJnUS51tkHDlzg3XH+lV8wdbN7Lui4Z65j1HFCgVBpVGVxNmq20ynYXY
         j0EsqT6qRj6lOJfHVWYJIanHhD6Cr3DkNz/NKqVAJt1lSzCh8y+OPGi/qJYjJrmCu1Iv
         oTQc1CTaQa+tPOslX8aqfxh4K2di3x9F1dWK0J6CerzdVTBTjK9p0EArsFG9jfu6UyDv
         PEpaASPPExMvgfdkIAMkkEtPSBiZMZAFiKK+rPU/mQkSg7jDcyXNWH1G3XkXmpgxF05H
         B+3ENTGFyDTcQQrR0svlSUyqsP6Nbnr3HRw9i2a2ioFU9hu9xWc3m8W/u49LiFwEFJhr
         MtXQ==
X-Gm-Message-State: AOJu0YwexWNaapZou5xT0XkP9TvIssWlNhH2R7CXxwMH7l4yYZnanIRQ
	DR8Ju4ywA7skREoJ3LVXnc5b42bTAz5nW1X/IlvQ03bF9aYm++PEOeiJH79NlA==
X-Gm-Gg: Acq92OGVXd1g7wlxsrMcnIZSdLZ/vLmPTLeETMfLagEHzrspuYiFJXV2opdu9Xlx4Qd
	YIvfjHS9sI15v77olypN3RX6rbYOJk8YaWlMzjg3jOZV9v83zJxkxz3ehKGZ1UwK8MVZI3BlskP
	YKmqXe+dH5LYrUWNV0bjlQY2Dfi5LLACbTWh/+AbA3zPzcVH/ee+eDvz4zooCEM8iMqCb7GVqFk
	hoH4K7/CUTgDE4Q9iEDxes5p1bSuW0H4CWDbFIGpMDRsfyyI3yM/rC0K88oZgui+fsMmONvkolH
	Fa6egeZr/glt1ONRN+GAMTR5wY/cDVGAxomA4MGB4N3rZazkKl7noQAI7WRpTmt8l1wGHKr0Cq3
	7o9vLrgh+gpz/WnNygIf2crPqO75hDoK++s0Gi/0XATgIRnltoqsW/KcdTQ9fUzCLzBGqQ72CiP
	KYP8zh29fEYsLOFhMYwv0wRqOXL/0N9uELKCISNWbOzokyUj8wEWB7pSjDIyZC8r0e7TmivI0Ct
	Hynf63GZ+fMX8911F2gTxfO9isqlW+lMaETFxwScbP3/dYPZZZP6jUic5cHkbBhLA2mQWnzIf3P
	VmeSqAXhNKQBXA==
X-Received: by 2002:a05:6a00:39a8:b0:82f:7252:38cf with SMTP id d2e1a72fcca58-83f33cc34bcmr5166201b3a.16.1778863972003;
        Fri, 15 May 2026 09:52:52 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83f19c78844sm6087063b3a.47.2026.05.15.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:52:51 -0700 (PDT)
Message-ID: <922f2ade4ee5f10e5645e3b1a194d024b88f0d76.camel@gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: pcs: xpcs: Add hooks for xpcs
 configuration of rsfec
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: mike.marciniszyn@gmail.com, Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski	 <kuba@kernel.org>, kernel-team@meta.com, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Kees
 Cook <kees@kernel.org>,  Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 15 May 2026 09:52:49 -0700
In-Reply-To: <20260511182604.1338-2-mike.marciniszyn@gmail.com>
References: <20260511182604.1338-1-mike.marciniszyn@gmail.com>
	 <20260511182604.1338-2-mike.marciniszyn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B5C76554652
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288382-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexanderduyck@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 14:26 -0400, mike.marciniszyn@gmail.com wrote:
> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
>=20
> The DW PCS IP data sheet calls out the need to populate
> these vendor registers when operating at speeds above 10Gbps.
> This change enables the correct FEC settings to enable RS-FEC
> encoding on the link which is the standard used for most links
> at these higher speeds.
>=20
> Note that the overwriting of the MDIO_PMA_RSFEC_CTRL register
> is intentional and consistent DW PCS IP requirements.
>=20
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
> ---
> v2:
>   - Allow mdiobus probing for addr 0 and addr 1
>   - Add xpcs_find* helpers based on phy_find* to avoid hardcoded addresse=
s
>   - Remove xpcs_bus write and use mdiodev_c45_write instead
>   - Address comment on use of MDIO_PMA_RSFEC_CTRL
> v1: https://lore.kernel.org/all/20260506190904.4029-2-mike.marciniszyn@gm=
ail.com/
>=20
>  drivers/net/ethernet/meta/fbnic/fbnmdiodev_c45_writeic_mdio.c |   3 +-
>  drivers/net/pcs/pcs-xpcs.c                   | 105 +++++++++++++++++++
>  drivers/net/pcs/pcs-xpcs.h                   |   6 ++
>  include/uapi/linux/mdio.h                    |   3 +
>  4 files changed, 115 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/e=
thernet/meta/fbnic/fbnic_mdio.c
> index fe3a4ce88413..e29534dd1e0c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
> @@ -263,8 +263,7 @@ int fbnic_mdiobus_create(struct fbnic_dev *fbd)
>  	bus->read_c45 =3D &fbnic_mdio_read_c45;
>  	bus->write_c45 =3D &fbnic_mdio_write_c45;
> =20
> -	/* Disable PHY auto probing. We will add PCS manually */
> -	bus->phy_mask =3D ~0;
> +	bus->phy_mask =3D GENMASK(31, 2);
> =20
>  	bus->parent =3D fbd->dev;
>  	bus->priv =3D fbd;

Why are you messing with the PHY autoprobing mask? That doesn't make
sense to add to this patch. The side effect is that it is going to
expose a phydev that won't be used as we access the PMD direcly.

[...]

> +static struct mdio_device *xpcs_find_first_mdev(struct dw_xpcs *xpcs)
> +{
> +	struct phy_device *p =3D phy_find_first(xpcs->mdiodev->bus);
> +
> +	if (!p)
> +		return NULL;
> +	return &p->mdio;
> +}
> +
> +static struct mdio_device *
> +xpcs_find_next_mdev(struct dw_xpcs *xpcs, struct mdio_device *mdev)
> +{
> +	struct phy_device *p =3D container_of(mdev, struct phy_device, mdio), *=
n;
> +
> +	n =3D phy_find_next(xpcs->mdiodev->bus, p);
> +	if (!n)
> +		return NULL;
> +	return &n->mdio;
> +}
> +

Okay, the use of these functions explains the issue. You shouldn't be
using phy_find_next. You know the bus will be located on mdio.addr + 1.
You should not need to have a phy_device assigned for each of the PMA
devices.

The general idea is you have mdio_devices you shouldn't be trying to
use the phy_device functions in the PCS driver.

> +static int
> +xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values =
*v)
> +{
> +	struct mdio_device *mdev;
> +	int ret =3D 0, i, pma_mmd;
> +
> +	pma_mmd =3D xpcs_get_pma_mmd(xpcs);
> +	if (pma_mmd < 1)
> +		return pma_mmd;
> +
> +	mdev =3D xpcs_find_first_mdev(xpcs);
> +	if (!mdev)
> +		return -ENODEV;
> +

There shouldn't be any need for a special for this. You already have
the capabilities to write to the devices you need to write to.

The only things you need to change would be to access the nearest PMA
to the PCS as that is the one that holds the RSFEC configuration. For
that you just need to know what devices are already enabled and you can
access them.

> +	for (i =3D 0; mdev && ret >=3D 0 && i < v->lanes;
> +	     i++, mdev =3D xpcs_find_next_mdev(xpcs, mdev)) {
> +		ret =3D mdiodev_c45_write(mdev, pma_mmd, MDIO_PMA_RSFEC_CTRL,
> +					v->rsfec_ctrl);
> +	}

You don't need this "find next" logic. It is just the device on the
adjacent bus. Also I am not sure we even need the loop logic since
there are only 2 devices you have to configure as currently only 2
lanes are supported.

[...]

> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index b2541c948fc1..5219c877b2cf 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h
> @@ -317,6 +317,9 @@
>  #define MDIO_PMA_10GBR_FECABLE_ABLE	0x0001	/* FEC ability */
>  #define MDIO_PMA_10GBR_FECABLE_ERRABLE	0x0002	/* FEC error indic. abilit=
y */
> =20
> +/* RSFEC PMA Control register */
> +#define MDIO_PMA_RSFEC_CTRL_4LANE_PMD	BIT(3)
> +
>  /* PMA 10GBASE-R Fast Retrain status and control register. */
>  #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
> =20

The AI review complaint about this bit seems to be based on an outdated
version of the IEEE specification.

This is called out in 9802.3-2022 as "Four lane PMD indication" so
perhaps sashiko needs to be updated.

