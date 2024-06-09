Return-Path: <netdev+bounces-102081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA49015F2
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7922810B2
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 11:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C556D22626;
	Sun,  9 Jun 2024 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="bPBtautZ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C41865C
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717932208; cv=none; b=LqVrVvz2m1HPgM7ohQryuvjWtuMccKOiaJ735tqjpPvMmsYKoXUFBz7VGMlzmZlYr3vQe4j4gkRH/nC1mF1hJFuhkfWi6NyKBqY644WKerfiCDxUKFjTg/gPeUcmRmcHO49EosXpv94f6feAXonOMlIbVCMe/Pz8QHvQOwGX5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717932208; c=relaxed/simple;
	bh=s/1gzQD73zhQ5I54cicssp7mPuHgYqrDtOn+EZWnJzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAeXRW4G0QtU6fVZDgmouqrr3lvtOsyg1Z8W22ke1tT69+kI0z58roNn/NbbrdfbJ1QXgCW9f9DWeYXm+X2WsLIO4wJaeayZf0zOz50+7PFT8oQVJZpkRH53+KR+v7v/YYFFEOTWM67mSsvlduxbwZkfAVf09Fx2kqF3qHVJbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=bPBtautZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717932179; x=1718536979; i=hfdevel@gmx.net;
	bh=OySWXdbbCnbT8HcitiW07cGcpBzbyOTf5ern2Cyjp8Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bPBtautZckcks+uNIGuaOwY9wB5v5jeuf9AQgXvHZEfM142+1eCSprICl3qBTMQn
	 PlqWU/AcN/qKNIPTDNWS8tr2xu1GKiavUw2BlOJnAdss4c9jGi1YxgkJzpL+WmDbd
	 EStZC5R5NkXq+TEEmv6p+8UyAd3mgdUyti3FjOVsYamDUqWZ853jwgRdITcVJT8Mz
	 rOMLzERho6Iup2kFod70GWYoFx5uCvNhMhLom7e7OJbXLAY3HsqzGXA7UoovkfMZo
	 edVHz3sofn7bZeMPlgnhYCIJVAPlZ0H9zQm0wGxbCYptB4nLzZf9c6l74HqsX7jC0
	 8aEwZX3T+Fyr6uHl1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1sewMC457q-00zr1d; Sun, 09
 Jun 2024 13:22:59 +0200
Message-ID: <de03d402-306c-419d-a441-2fa3c3b63a89@gmx.net>
Date: Sun, 9 Jun 2024 13:22:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 5/6] net: tn40xx: add mdio bus support
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, linux@armlinux.org.uk, naveenm@marvell.com,
 jdamato@fastly.com
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <20240605232608.65471-6-fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240605232608.65471-6-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gp7ouvpTXEEl7zIjgOThH9jrl5uUj+fqVl32QiJFeCDlg6Ge5bC
 zBFZD+aYypQRifZ7qDnU/tA55O6HN5BkOCZXZvckdpt8aVZCuTjZt1Od8s0UrkaVIKCV3dx
 +h9mzg3WNEBMOpfmhx6jRwTVXcrIuKsRMM0FDIqdthMU/WCt43V0OUZBZFO2qUd7XuZqXRc
 xZ0WzqzwclWcZnKmSJYSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JUNjmqM6Qj8=;K5WvdDM9JREpOoM5cENfF9nxHo6
 RUz5UJHRPCJ/Tg3xc2l6fymFHOhoVnmgema9kTptuUATmGCdSH0QhK2ao+rQTNUeY6zrR+zPx
 zc6o0evMG91F4qWxrHfIrtpxY+SuMjvDWUypmCOgnoc7cUnQgntKY4ORxvXoYHuM8rJ4kV2di
 YeGLHW1ufR1vmQzW0/2otH2sU5FHvTz+XwGp47ZXpp4VB6i+cvT4N3eqV6knN88Y62MEfOHjY
 IsXNSFwdXR2Nk/hfRzcI+nHicbzYlVzCNRw9UfhNINgkvnYAhUj6cDxvCeI7XJfXSseYAZ1gu
 DboUkTKnzxxGDQgF3uSQqyGPgxBhghgeqy+eXGm/ZFc/PFAQBseELdJ8UQpjWEKxShuK1zM0r
 S/LjEQvtlmz7Uts0q6kD2M9rJxWc2WqXjqeRnTPMWwQ1eE7/Sa8Gh1w6kY2eZgFIvt9sbtz0Z
 jyiRxIiDgPq6zHv6sVWrnI58HhIH/ZjAiPUUdHBQDTci7zAh+TLsGki3E+MFXF3pRnXeOvvjG
 O0GwawHkxNxoanCby6Puvj7LjJiwvOL1GbWoD6WDqVkqKkJsAV54tcIynLxm9U/xpqF4zedzy
 8J72+mzYhIRRP8TCLxtLxm/mCmyPsnePLPF+dEg/6EmvHu4GqzAAdU61lCjxRTsKsFFKmgER1
 alpSlUA65FSj6z5sXbWo0nhYOsvZD83HHGgCklwKVljNjJ6CruiKrypLiyiqx2EshEOR8RliD
 eF5+dnJc9KxkYS+9iHK0CxYo0Qbt9+fiwEXEB2fljvdrud1C7w9MxmkqPH79Lt39jf27ypW3S
 NWNLw9kGeRFzzcb+TGHZZP+vIAlBpzWclMw3q/AqjBPVE=

On 06.06.2024 01.26, FUJITA Tomonori wrote:
> +
> +static void tn40_mdio_set_speed(struct tn40_priv *priv, u32 speed)
> +{
> +	void __iomem *regs =3D priv->regs;
> +	int mdio_cfg;
> +
> +	mdio_cfg =3D readl(regs + TN40_REG_MDIO_CMD_STAT);
the result of the readl is nowhere used. And as far as I have seen it is
not needed to trigger anything. Therefore I suggest you delete this read
operation.
> +	if (speed =3D=3D 1)
why not use the defined value TN40_MDIO_SPEED_1MHZ here? It would make
the logic of the function even clearer.
> +		mdio_cfg =3D (0x7d << 7) | 0x08;	/* 1MHz */
> +	else
> +		mdio_cfg =3D 0xA08;	/* 6MHz */
> +	mdio_cfg |=3D (1 << 6);
> +	writel(mdio_cfg, regs + TN40_REG_MDIO_CMD_STAT);
> +	msleep(100);
> +}
> +

