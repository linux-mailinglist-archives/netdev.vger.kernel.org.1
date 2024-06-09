Return-Path: <netdev+bounces-102080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D689015EA
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C15281B07
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201D29D05;
	Sun,  9 Jun 2024 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="X3jxOSds"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA313FF6
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717931871; cv=none; b=n/YNd0MvIV3aUc0gM73Tv42jCqCBNydSgGJGNKF9yqNrzXblMsKfcWISbTz1tcWJHbcvKRskfVlisrtdE9JfqjrP91G3F/s6i6bD1dEmGgGCLY942PWCMuzPmUp//tNwt+3wW9hzWxFx+TNs+eC4YmRaN/mxE12Mhy2IDw12nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717931871; c=relaxed/simple;
	bh=sKdjORTXPQJbiQV+A/F0kNH6j18vVT83Q+bzs+TE3YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpJ1npn92ZVZcOYPOwCYO1NQcVYs1Aaw9FGZoqZIdCarEDHKVjjXNOuaUG7KRmvj/8HXDdIfGp6Qk51v6uEyz8X89T8E1/2903oJ/j84e221iTGH9GipyVGkQdON07x+UHHhbmRsxKY4CMrVPlFzKqEUmxDmfgkcmbmyfyN78o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=X3jxOSds; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717931852; x=1718536652; i=hfdevel@gmx.net;
	bh=fkGOhrPF1pzRN8hSEqVCg9ngGplDwFx/beGrAOq8epo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=X3jxOSds+rpeKb34W0uZ32HWzi52UiV3Uz8tYu33/duidL5Vt3NrOF0NCtkKeQjr
	 5xLL5cz0iHruLjpiabduBh3W569uvX1/pyEzLlYn4/FTuPOtEfG8tthPU1zs2ZI7K
	 wpgXtcOZuGPtwCeltQFme1C+YKd2N8dHnHEP10zuksI+5qm0UqEI50WhFYd9C4ndI
	 C5N193APJ4dJg65+V8diHkdTl0Pc/YBeYwnSh94ftvv6/hONuksWZ28OPCoZnZK7p
	 o5AlKoiUdsV1gSxw+WIhevBm2VSULzZoXHoStaPmMDlBqQ2pzVGFIXnR4i7aYRWYO
	 2gL1ANEszoe85gnJCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Kr-1sKxFg3pMB-005zcM; Sun, 09
 Jun 2024 13:17:32 +0200
Message-ID: <7a3af149-89bd-4c9f-88fe-813e84dc98d9@gmx.net>
Date: Sun, 9 Jun 2024 13:17:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 1/6] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, linux@armlinux.org.uk, naveenm@marvell.com,
 jdamato@fastly.com
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <20240605232608.65471-2-fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240605232608.65471-2-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:er62m1HYiMcm9y2SrkvDsQdzwvwQxfMwwl7FZSvh4xXEOtVpKYM
 /oqvFln9K/Zx2u67JY3BgzSejRngrvzx6s05Ja1EOnxqsvaT/wFwq2QyVZQAuAfZsbLXg//
 eakxK/m+3Tpn++PFpD8RfQW7EFCUiEaJlm0ZchAFYYfhAXMaxIEyuJ5VdkxtzZoRZRKxkHk
 ggcnTeBiGpIpKZ97OagzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r8qA06piquo=;746tSGC/CkLipLWV82Hjv5bVmbF
 Szq8DajydLar8WuFhGxrkxKM9X2CSUdYGungK6xn+5iOE5R3U0nmD7clIc4VMFY3+OAvmx8G2
 UJ2rOxYrJoAmztpyYBFxWjPUy6giQgdrTbJGLRjMhwuVzx5ly/mt4LyU5fL3bfRzMxwSbz+2x
 u9BFRe0WLj3/DUjzJnbPZxfbz2fCQPmBIcNJu6S+hQjk75GhSeSHiA6Q0YCVUSwPOyl106sc+
 KNr07gmW1AzVeyBX+YdnIGAo1Tcglbub5I1xqcgag1PvHoK94ganrt+HWRZkucPhk+sJSyhAa
 AXdxTvfutZAyfbWNeETc22ZAocCNf83IDlPPvGHYNx99UFNKymWaiuwyBZZybftDy3AyZsyxO
 sDUVMn8nIA0A6Aa9fMBdbfXvw/rvMBJiW5lv4p7AqR5qD0e/x9AB/zU6rA1CGPdT7wTwplFeC
 fiwUVI+eFaK55dryATM0Wn2LsFUrTHadeezAT35l4WGS/MCWGyhEHgmk5HNffhkMEQ9cUmmXj
 BWHNN+Rlrxkl46RygkafEJ+Q7a7h+EWsNVzch+MzugHZupUDPoMolk6i8eccYbkLdd/JIo/w8
 lmRdGB6ncP+/GG5KsqkTLiD7M7icKMwEYVxrkmnFRKeY3KOgfbOO+F4AMhOBEAaHD4UXJUTBB
 XttykpWqx0O9xKwgGcjDloUYohJmLpI0W9cInBqq0es/MREs9wgoB7MfQpr8jc7ea0PMAgc8Z
 eUydM7FjQLmVsjzUV5IwV3ndNJA5AGqwVoynj0JcXeSh+UyBySfQ9rJCx9G0uj5npIiD7iqlO
 9uN9tu6tyaOxpHBm7BPr5ZRQ5MWx6JZ+LxbgUl/hueUUk=

On 06.06.2024 01.26, FUJITA Tomonori wrote:
> +
> +static const struct pci_device_id tn40_id_table[] =3D {
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
> +			 PCI_VENDOR_ID_TEHUTI, 0x3015) },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
> +			 PCI_VENDOR_ID_DLINK, 0x4d00) },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
> +			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
> +			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
> +	{ }
> +};
> +

Now that it seems we will have another revision of your patches, maybe
we can also continue to do a bit of cleanup:

Is there any reason why you specifically detail every single card with
vendor ids?
Couldn't it just do with the generic Tehuti device number, i.e.:

static const struct pci_device_id tn40_id_table[] =3D {
 =C2=A0=C2=A0=C2=A0 { PCI_VDEVICE(TEHUTI, 0x4022), 0},
 =C2=A0=C2=A0=C2=A0 { }
};

> --- /dev/null
> +++ b/drivers/net/ethernet/tehuti/tn40.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (c) Tehuti Networks Ltd. */
> +
> +#ifndef _TN40_H_
> +#define _TN40_H_
> +
> +#define TN40_DRV_NAME "tn40xx"
> +
> +#define PCI_VENDOR_ID_EDIMAX 0x1432
with my suggestion above, the definition of the vendor EDIMAX would
become obsolete. If needed, it should probably anyway rather be placed
in include/linux/pci_ids.h
> +
> +#endif /* _TN40XX_H */

