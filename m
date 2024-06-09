Return-Path: <netdev+bounces-102085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D2901602
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 13:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF98B21429
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840E83D57A;
	Sun,  9 Jun 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="YuJxtc0i"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751C37700
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717933299; cv=none; b=cdP/62HFbdQ5ayTF4l7twHWS8OObb+AzZ+q6qe66NbI2J3lHnJiG9C/GnafqnUCO+mdTNlK3nB0lzlXeFdN4ymSC7EaJAaMivrYoNDEGmQ0IdSkNIwI4rWU/5wHp8CAhjOcFktySci1aEUF08C/vK0Z4xI6x15+uY/8DnbPxREw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717933299; c=relaxed/simple;
	bh=+h9RGuZKE588sElun1MmFTpXxG6FHjZmB9t5+Y8+r0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgjF+migqDIG8MjV9RV5sJMvE7FzzGTy5Wmz2OrgRIsy9XFm1j8gkTr2K2aaf2KlYFrmKkhWMV247AHb9LWOG6n2YkUaOrn3O9CfI+7y8ODPFDSPsJL2CuIdmBaOgX78J248AaXGtaZOhxVHTPy+uuBcONDrA1IkrF/+0EDL4HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=YuJxtc0i; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717933281; x=1718538081; i=hfdevel@gmx.net;
	bh=o1buYnkk3rT8KCCEkir/g/xC5NxFMu1cJckK9Y8p4lY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YuJxtc0iTrIiuFBzwMtNlSWPAwYStKfHNEvlXGAjRndOdkas1G7kQ8eunj+1i2HY
	 Yc9WkneFS5RiML/QHG4yPam81UK+03S6eGegFV2p/mVoYEmbjBRzEU3oykpjrmjKI
	 Lcs3NsDVzuyXaPfcJ9+80CDUJU0iYrAToiznsa83MYKNhUbGc5w0wt3CbLSh1cM6T
	 UYaHMuF0ZyMPHMSWcYJGr4ZYECz0Mel6jfkGmevdOAgAY2dI0xpmFExZZ3ghrghGt
	 kGahzk+9Z1LjeWsoqhGrJhMGYY9L+PruPWUKidR1EEwB1WlPHI+hAEiUsxjVXDoR3
	 YqdLvO7LzeueO+z3zQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdeR-1sAVl62mV3-0049N7; Sun, 09
 Jun 2024 13:41:21 +0200
Message-ID: <78ecc7a9-bb33-4c2d-a797-87f782b6a382@gmx.net>
Date: Sun, 9 Jun 2024 13:41:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/6] net: tn40xx: add basic Tx handling
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
 pabeni@redhat.com, linux@armlinux.org.uk, naveenm@marvell.com,
 jdamato@fastly.com, netdev@vger.kernel.org
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <20240605232608.65471-4-fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240605232608.65471-4-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wq1HA6+lYD+6cWAo2qgYz9Gj8x8D5U6hTMx05/OSm/w108eLl4A
 sT0snxVX2C6tsjiB7KKN4LevLUo4gKJB0aM3atJd4KdMi3JrXyabj1Bq8yAsvXKygr2YWMb
 FMNy/77o1RcF44Pz+fzKJiLcNJwFUMuP8uMJe/oS0ZsTyNKxcSm+cnSJUrHJKtm5hcDQEH5
 GICvE67ZtgIGqNLfZjM8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sxkErPTtnmo=;kdo+u6XTbxSPLfTSIqrJZItwwvW
 TDLOuVEEPnmUcyL5rED15dJ6brCYqw8SihPqoseGxkZPiUeEhdlyyPj9c8a9H9hbaAprL2g4r
 gld6/9I5yJ4m6wyFOMWa1HviKXWsowJSf8Z8D6+Tr0hUWGreVNgtUXh1qwtCLZ4E4xpT6lrRk
 lyzl8Io+hUxqyE3g7OfGylZM6g7hN3WQ+Z0zw/wqBXhLQhJy6IYXuwYUhcCczsaPslJbu8ZW0
 DPbe528JyjTjPgJSZbdgNECCEjMqRInwJ9yb4uHlSolqau8zvgUsoTADg+gds/9JMqo7YHDYr
 S861gOlW8C9tiyK8l0p2pSz9vgQYMUZKsd44UzBZxoT5fLfq9VyUyLUu5/JLSqiuExbUbc4uo
 RQtq2ZGu5qSvDJ302TLPDwpkx6LxTolf6oIOi662dDctKHCpoh86B4BjVMGii66CuaPlA6Plf
 jqqapBjGPp0JaC/FZg3znX5EqNyK+3v1aXdw8iHbnV3PU1aWD99DMnTQhKecUC72y18Fr5RT+
 D8Uu4Ob9xTEzoUpYBoQzIRGgRElaRUY0JDB4AhE9ruMYFAWp5RqdLTChFIo3jtyr8zOvGGegz
 C7PUzn81dBVqXXkk3dGGSXfZ5dUyToJGP34cj3hr8eXQtkKS3+/pa+fNb8y6kfZMpjulc2apF
 cGOGiZWsTZT5P/dwiwI+8kOuAeVE/scOO54wCbN6mTIFlqzA1Ci7ZVj3mgXnKtBo8rQ2X0JaS
 IeGeKdhrizPZUl1b/K1nvqILD7rPQIFuTOW0AWyZgCLapLnYEqO9AxDvErx8bKZAkLXLCQoJ2
 Pgf5ffBnk8L7peUrAn35T6eosIwVv/jqzNOk5rV0DvfXY=

On 06.06.2024 01.26, FUJITA Tomonori wrote:
(deleted quite a few lines, because the relevant topic is nearly at the
end).
> +
> +static int tn40_priv_init(struct tn40_priv *priv)
> +{
> +	int ret;
> +
> +	tn40_set_link_speed(priv, 0);
> +
> +	ret =3D tn40_hw_reset(priv);
> +	if (ret)
> +		return ret;
> +
> +	/* Set GPIO[9:0] to output 0 */
> +	tn40_write_reg(priv, 0x51E0, 0x30010006);	/* GPIO_OE_ WR CMD */
> +	tn40_write_reg(priv, 0x51F0, 0x0);	/* GPIO_OE_ DATA */
> +	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, 0x3ec8);

the last tn40_write_reg (to TN40_REG_MDIO_CMD_STAT) is in fact the same as=
:

tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_1MHZ);

Use of this function would IMHO enhance readability of the code
(obviously will need making tn40_mdio_set_speed non-static in
tn40_mdio.c and adding the function to tn40.h).

> +
> +	// we use tx descriptors to load a firmware.
> +	ret =3D tn40_create_tx_ring(priv);
> +	if (ret)
> +		return ret;
> +	ret =3D tn40_fw_load(priv);
> +	tn40_destroy_tx_ring(priv);
> +	return ret;
> +}
> +

