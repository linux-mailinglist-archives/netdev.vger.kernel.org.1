Return-Path: <netdev+bounces-214896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CD6B2BA9D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CE16201A1
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 07:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF49286884;
	Tue, 19 Aug 2025 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="GhDXxOlA"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4983101AD;
	Tue, 19 Aug 2025 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588157; cv=none; b=O+pemBIhWqBmgJWnvRjzD2cwqXlF+Ux+FHiutHfBdjaRScQUUZU0kwUoxnc/ANa5WAIL8Gec/wPjzNaOYvNclu4azsFB3eGfRlF1FQehRWnfJF0CYYAYs/iIFViyG6LfpJnNvPPIUHAs19D3G2LAxe8wBuCV81SPmPUR2Junu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588157; c=relaxed/simple;
	bh=mHHwcXLtWYfq0J9lQmT0S1WlJlAOgeO6qk/TxEG6yuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHDXR0g+raZ/nfDzB7gv3D6IU9zcRhiJZNncgqUhmC7hLgwuglkXFWDwL5LW3q069k82Z8Mo1W8yjbzqKrT+/DmOayoNa0jmFUhfVHlnVM7MevYCLW2wYCmYrn1DWfYIqhSlesx7euwaXgN9SxzO5FL/UQFohKn+g7TKxJ6+X44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=GhDXxOlA; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D3176104004;
	Tue, 19 Aug 2025 09:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1755588146;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uBFbvxvPxL6c/cy0MPebSjUC25NdiMBM7wRlE7Ty0y4=;
	b=GhDXxOlAGFJT+C19rSesj1D6usAuzDkKrMnOFdVDCOa0rqQinVUu84b/jg7gDrfA9376Ak
	LlSFGE6nVWI3et7DzDSthGxw8yAtMRzwRxKE2YF89b/JRWfTDAfpqNW03qrNVlGSR9BQXD
	BUny+UEA2jKL528/40F+kQrQWRZEkWVPfy1KvBp5csYXWbhcA/8JAfI2AyYWJCuA6dNBJ8
	+ww+FohsaG6JcijimzbWVjrpRLDT3+uYBcu3R7jpi7E3BvB55hMoylbaCuDE1EuvcSrq5D
	4L3XeQijFv+3dDjiB7w2DC5aGMeA28aEJ92kQqjRTFz3EsoC7RIxzdEsUBeUsQ==
Date: Tue, 19 Aug 2025 09:22:22 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: <Tristram.Ha@microchip.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dsa: microchip: Fix KSZ9477 HSR port setup
 issue
Message-ID: <20250819092222.598e8d24@wsk>
In-Reply-To: <20250819010457.563286-1-Tristram.Ha@microchip.com>
References: <20250819010457.563286-1-Tristram.Ha@microchip.com>
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

On Mon, 18 Aug 2025 18:04:57 -0700
<Tristram.Ha@microchip.com> wrote:

> From: Tristram Ha <tristram.ha@microchip.com>
>=20
> ksz9477_hsr_join() is called once to setup the HSR port membership,
> but the port can be enabled later, or disabled and enabled back and
> the port membership is not set correctly inside
> ksz_update_port_member().  The added code always use the correct HSR
> port membership for HSR port that is enabled.
>=20
> Fixes: 2d61298fdd7b ("net: dsa: microchip: Enable HSR offloading for
> KSZ9477") Reported-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c index
> 4cb14288ff0f..9568cc391fe3 100644 ---
> a/drivers/net/dsa/microchip/ksz_common.c +++
> b/drivers/net/dsa/microchip/ksz_common.c @@ -2457,6 +2457,12 @@
> static void ksz_update_port_member(struct ksz_device *dev, int port)
> dev->dev_ops->cfg_port_member(dev, i, val | cpu_port); }
> =20
> +	/* HSR ports are setup once so need to use the assigned
> membership
> +	 * when the port is enabled.
> +	 */
> +	if (!port_member && p->stp_state =3D=3D BR_STATE_FORWARDING &&
> +	    (dev->hsr_ports & BIT(port)))
> +		port_member =3D dev->hsr_ports;
>  	dev->dev_ops->cfg_port_member(dev, port, port_member |
> cpu_port); }
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
Geschftsfhrer : Stefano Babic

