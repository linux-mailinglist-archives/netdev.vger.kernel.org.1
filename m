Return-Path: <netdev+bounces-227963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219DCBBE22C
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 15:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D65318875CA
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B3228D8ED;
	Mon,  6 Oct 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DUc3bel/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327526E16F
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755919; cv=none; b=SG31AspRuQaLQIqH7YDErj+pEj6R2Pnq6r/U4ioNwcG3IDgqaOMC3LaeB2N5J68WE6GIXxu0x/Egl/NLUF6MaLNal0zcodXtc+6nwL5ZqGa5yxk0rJhUDMyM5T/OXyzEyF9tp3a0pO6TKUW1y22+0aJmvlKyVLzNuF1mgYggGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755919; c=relaxed/simple;
	bh=S7lyBttrPJPkijgbApllX7uKgB3U2ULIQxLT+nP03f0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FkDPeCCBM9HB9uSGH14iGYns3+d/qrfnxB4WAYXclGw5OKuKhjXhACFH3ETOks1h0SNJ2x62P3RigF1IV9efvIF22kGBPS1U5bLMobzL0uKxbjttOTvexqu+sHP6CoF11EhhCBMshOY6KN292MMAHQfbKaLpVtAo+h+4pVzlE8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DUc3bel/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 09BEDC085C9;
	Mon,  6 Oct 2025 13:04:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3FBC4606B7;
	Mon,  6 Oct 2025 13:05:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F3F5102F1D61;
	Mon,  6 Oct 2025 15:05:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759755913; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JegcGv/k2YQkWxBfURfNq4FiXRA/L/54pqYZ6jCrdts=;
	b=DUc3bel/JP4lBxMuMOn+vV/kxtk4Yi9sI3SSr/iGUh/vUYL55T5No+J1EVQ7xN0hduU/9w
	OjrvAmUKteej+EhhuVXeVF+FxBYcYOccXeLMeh0Probd4NcjLQyv58z9bBbhuDegbVkemJ
	j08zB1aYCnhcGkSed/1Y0N8r0O5L7Ig6/qWUaqvGUj8WfFzzm6I1Ic0OIXf9WpguSlS6cM
	0rNeX3JQfiPUCSTAXzSEC/ohYMydAMpcw8dxfJdV5600vz3HavFkVXRwrNsZd3QGwzH0N+
	5xCzKNhVKlylQ/VjYpcL7oH2Zt59xsVKOnDFuPi96Rpd3wP6k9eE6qFYM/pNSw==
Date: Mon, 6 Oct 2025 15:05:05 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Thomas Wismer <thomas.wismer@scs.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] net: pse-pd: tps23881: Add support for TPS23881B
Message-ID: <20251006150505.643217e8@kmaincent-XPS-13-7390>
In-Reply-To: <20251004180351.118779-6-thomas@wismer.xyz>
References: <20251004180351.118779-2-thomas@wismer.xyz>
	<20251004180351.118779-6-thomas@wismer.xyz>
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

On Sat,  4 Oct 2025 20:03:51 +0200
Thomas Wismer <thomas@wismer.xyz> wrote:

> From: Thomas Wismer <thomas.wismer@scs.ch>
>=20
> The TPS23881B device requires different firmware, but has a more recent R=
OM
> firmware. Since no updated firmware has been released yet, the firmware
> loading step must be skipped. The device runs from its ROM firmware.
>=20
> Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>
> ---
>  drivers/net/pse-pd/tps23881.c | 65 +++++++++++++++++++++++++++--------
>  1 file changed, 51 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
> index b724b222ab44..f45c08759082 100644
> --- a/drivers/net/pse-pd/tps23881.c
> +++ b/drivers/net/pse-pd/tps23881.c
> @@ -55,8 +55,6 @@
>  #define TPS23881_REG_TPON	BIT(0)
>  #define TPS23881_REG_FWREV	0x41
>  #define TPS23881_REG_DEVID	0x43
> -#define TPS23881_REG_DEVID_MASK	0xF0
> -#define TPS23881_DEVICE_ID	0x02
>  #define TPS23881_REG_CHAN1_CLASS	0x4c
>  #define TPS23881_REG_SRAM_CTRL	0x60
>  #define TPS23881_REG_SRAM_DATA	0x61
> @@ -1012,8 +1010,28 @@ static const struct pse_controller_ops tps23881_op=
s =3D {
>  	.pi_get_pw_req =3D tps23881_pi_get_pw_req,
>  };
> =20
> -static const char fw_parity_name[] =3D "ti/tps23881/tps23881-parity-14.b=
in";
> -static const char fw_sram_name[] =3D "ti/tps23881/tps23881-sram-14.bin";
> +struct tps23881_info {
> +	u8 dev_id;	/* device ID and silicon revision */
> +	const char *fw_parity_name;	/* parity code firmware file name
> */
> +	const char *fw_sram_name;	/* SRAM code firmware file name */
> +};
> +
> +enum tps23881_model {
> +	TPS23881,
> +	TPS23881B,
> +};
> +
> +static const struct tps23881_info tps23881_info[] =3D {
> +	[TPS23881] =3D {
> +		.dev_id =3D 0x22,
> +		.fw_parity_name =3D "ti/tps23881/tps23881-parity-14.bin",
> +		.fw_sram_name =3D "ti/tps23881/tps23881-sram-14.bin",
> +	},
> +	[TPS23881B] =3D {
> +		.dev_id =3D 0x24,
> +		/* skip SRAM load, ROM firmware already IEEE802.3bt
> compliant */
> +	},

You are breaking Kyle's patch:
https://patchwork.kernel.org/project/netdevbpf/patch/20240731154152.4020668=
-1-kyle.swenson@est.tech/

You should check only the device id and not the silicon id.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

