Return-Path: <netdev+bounces-87576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D28398A3A3B
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 03:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CD21F21C53
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 01:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6322A95B;
	Sat, 13 Apr 2024 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aokWUM5k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B3D2F32
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 01:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972981; cv=none; b=u+USLyGeIQZMKrfmh2RKNAVJ0dR6FO3P1tbeXMrT0edL8Avo/edkvVu9ouW44/eBuoS/dr0Y6v7CJqoR3EdpLvADA8cQm3rrerO4r984qlto2IwM9OB56D49tq12oMHMQ/aPONFkqUH0KlJ+UBYiIos7c3KPxrzy5Wh3BpdlBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972981; c=relaxed/simple;
	bh=zjiEwIGjJUYHWO7zNL0UZxudPeYSdpy2KGnIY81YnCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9sUeK9YtcvaZ11pjCRGbWa41vv1p8x6gnk5EMq+WQ9tEuOnogPk9l071zdDjG23PwLG9Iic+P4SbeZwsDKFcV7PsIfx7zqPkcR9NixHIt9KS+paD8NuUkUH0JMn3XlX4HECBNxpRNhCvWoPcQpu8aBUesRWYU70blmdxxxoK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aokWUM5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86869C113CC;
	Sat, 13 Apr 2024 01:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712972981;
	bh=zjiEwIGjJUYHWO7zNL0UZxudPeYSdpy2KGnIY81YnCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aokWUM5kCnrSDX0m9QgCmY1YEPV7sgD8bRQSpnljz+YhvZNxnh+dbDb41hRO6RjyR
	 YW9TtfwlFIdpr10zDGjmk4jBD5dMOTG4vy2NFiuQiwi+G8AsaO8nr/kE62p/4iXXzH
	 y9Ab7pojSdawO4SiNDJbXS2/C0xcM5/IOTTtJTaMLeE9tqqgLmFWA+XTJZpw9kIbvJ
	 x9uYz++sI7Y4G5QtwORxCF036fewocnlFKtMVPRE+IbGBfOenHro+uVx9dNYQm7qtY
	 jn21IUtY1d/GZVs5GZLpsKeSjcq1JgU304xBCk5MghHbdfF3Bm7xpZpv2g8klHP35C
	 ED3L9s2+Q7Hnw==
Date: Fri, 12 Apr 2024 18:49:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 fancer.lancer@gmail.com, Jose.Abreu@synopsys.com, chenhuacai@kernel.org,
 linux@armlinux.org.uk, guyinggang@loongson.cn, netdev@vger.kernel.org,
 chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v11 3/6] net: stmmac: dwmac-loongson: Use
 PCI_DEVICE_DATA() macro for device identification
Message-ID: <20240412184939.2b022d42@kernel.org>
In-Reply-To: <b078687371ec7e740e3a630aedd3e76ecfdc1078.1712917541.git.siyanteng@loongson.cn>
References: <cover.1712917541.git.siyanteng@loongson.cn>
	<b078687371ec7e740e3a630aedd3e76ecfdc1078.1712917541.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Apr 2024 19:28:08 +0800 Yanteng Si wrote:
> Just use PCI_DEVICE_DATA() macro for device identification,
> No changes to function functionality.
>=20
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9e40c28d453a..995c9bd144e0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -213,7 +213,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loong=
son_dwmac_suspend,
>  			 loongson_dwmac_resume);
> =20
>  static const struct pci_device_id loongson_dwmac_id_table[] =3D {
> -	{ PCI_VDEVICE(LOONGSON, 0x7a03) },
> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);

In file included from ../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson=
.c:6:
../include/linux/pci.h:1061:51: error: =E2=80=98PCI_DEVICE_ID_LOONGSON_GMAC=
=E2=80=99 undeclared here (not in a function); did you mean =E2=80=98PCI_DE=
VICE_ID_LOONGSON_HDA=E2=80=99?
 1061 |         .vendor =3D PCI_VENDOR_ID_##vend, .device =3D PCI_DEVICE_ID=
_##vend##_##dev, \
      |                                                   ^~~~~~~~~~~~~~
../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:11: note: in ex=
pansion of macro =E2=80=98PCI_DEVICE_DATA=E2=80=99
  216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) =
},
      |           ^~~~~~~~~~~~~~~
../drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c:216:44: error: =E2=
=80=98loongson_gmac_pci_info=E2=80=99 undeclared here (not in a function)
  216 |         { PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) =
},
      |                                            ^~~~~~~~~~~~~~~~~~~~~~
../include/linux/pci.h:1063:41: note: in definition of macro =E2=80=98PCI_D=
EVICE_DATA=E2=80=99
 1063 |         .driver_data =3D (kernel_ulong_t)(data)
      |                                         ^~~~
--=20
pw-bot: cr

