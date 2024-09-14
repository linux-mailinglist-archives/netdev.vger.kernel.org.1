Return-Path: <netdev+bounces-128344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9019790DC
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB89284D33
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A7F1CF2B4;
	Sat, 14 Sep 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="GqluSyGh"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975C17C79
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319812; cv=none; b=Vh88M6iyjD+KcJA9Tr/dxh9D1+iiIWp0+I1RqDavE9T1rYo6gPdCGlyk0ID8sTeoCTXev87JgGHsWgJ5Bmo+UBxrf4OU5yn+WhYBQdUlTOndNfJgM7lAphfKWoWqFwHSWulcq9x8AQBDP2GlL3FyezkzriAFB/gSMdQHBu1dtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319812; c=relaxed/simple;
	bh=VYDm9cro14DncZyRHPYQ7Xo7/0X83IvUZFTWYCcNvSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ST5UIbHU40ed7aSxh8g2Q2U39XbzLXUjI1RUsOtRE9phd4OaszekrM/N9aoG6cr0mfkm5dJT4D5gWnYrt2SEPUy2gGxikwVSce1OL089uutpOwwK8E5RDC4Kr7VrRxIDIeWDebgOZHbciJDBySdiTe2CTY1UCoRJCbCM0i8pAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=GqluSyGh; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1726319784; x=1726924584; i=hfdevel@gmx.net;
	bh=kJqC5mEV6FLSt+azPcMGg1rzSxJ4ChbRehyN9kNV/08=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GqluSyGhWqWPNGguipy+gXHOGy/7PvCjNCfYKbYEHKyHvtTwYnEdsLQ804ISIM/e
	 p3VFypH5YpjIh59eRgQBWHZYUC5mkeHvrcNxnlqTYu06iz5RVEsrIjjVUI2gjhgBN
	 CRM+ME+lesTsg4NC2GblxbXr6Q/SWB0O65ER6vY6nnalQrR/vPcdxVHfkpF3+uPcT
	 gyrif06feW5v+3EWb+q4/gf6/DXEQX32erZ16LIJQuHbbhai4JY1vAuNYwNq9TEjF
	 +68UvQtqJts+nzJInejAGXiXEhpxdQVpXMhm2E5W23UpZbw48VCqH3hW1V88/k/D9
	 1Mq3kZ5gKk5FLBkKJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1sAflc1OUO-00nlTn; Sat, 14
 Sep 2024 15:16:24 +0200
Message-ID: <fd4ed3cf-381e-4895-8f43-04bcafa3eb6d@gmx.net>
Date: Sat, 14 Sep 2024 15:16:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: aquantia: fix -ETIMEDOUT PHY probe failure
 when firmware not present
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Jon Hunter <jonathanh@nvidia.com>
References: <20240913121230.2620122-1-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20240913121230.2620122-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vQT9aFo2iDezGinNA26XHgQal/k87mCthQ+6iAzoC23HDeqzk4W
 e7BJN5dGRkRCs6uUDrDMzUn+Hwrees9Qpw2huBTFO5aneoGlp5FfH8DCQMDAFnCIp4j/qaD
 bFAX6A0s94xApc0tckgyToIO+VyWbEXryBf7+uRk0Zs8QzCkLMDz6eP1Yps1I0+vlRzqG8p
 nwXMs9A03nSDMLE60mMHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x1OYgHpNlOI=;XTxMNhPQ8SX/wxmOMdGY54HfXQO
 fFetPauoF1Ld8VN/1M8/0I5pvMT3phXc+TAlyLDVkx5sBSCI7Ix8/2tgyzK+IB2Kx7HRMvr+j
 B6jPXAcR5YXvxrSOKBVvyFdS26nwz8QGQqwuKCrkL/j+p1gPCpeBksJoLE0FsrCh7TLHI6Qnf
 hm9dQGphUGCOTYg+By1OxkzSuA8gEEfi9YjVBmmKjzzVXxxn+cXUBJ2RVujHDl7sId9/pPs7y
 nQd7MgVsbtHlxvnoVMCcaSpZZYQXvDh/0N0fdayJ6n9tiEuCEieSL3rebePVQDTSbGNXTt4Ar
 3A7YYqikq7Dyy9NSlQJGiNgTPAzqCg+KOD/scHP0ogQE2LmVuxJ+z6GBvD/Q6FLeCw2p0Tvxi
 hwmnDvjV3+WqZwpu+qSsE7TfVt6VJofdNH67Z/C90gKDS/jxlGklJlkiZ4NNHWpsO96iwqSQC
 zrLz50L9e7Pnipw+1uSmMrBf493JBDIlPCOciXqjlyA5iUiwIUDW/sN8TU1NOnsQthVi2vPPQ
 ZOxB3KTeIz6b/N2NaxgL8y/jzqL8kBUmiibPCaC3nfTt0sweFIGdTKmlutoNuJUibvNt7eGjy
 f4RzmQgETTJH3qzFzKkgs2402j9819tsE9Dr7Tb5J5urxtbmuur4AhTqzJIfOt4kpmNTxX4Zw
 Tolp1If1yjfymQqJH7u9FTxZO3CcZVyjVxJ6dPXxa9RSDvBxg3DcHuDmjEBQwuGutKXpVYvK2
 ixDkJi9SSi+tT3o9y2J+67rLC1FIlW8dYLJYoQ272zx0XhNaoaDfwnzxW+aOJqnsw4aQd9AeO
 gC3QBFK79t5nF7CnaHJB+DwA==

On 13.09.2024 14.12, Vladimir Oltean wrote:
> The author of the blamed commit apparently did not notice something
> about aqr_wait_reset_complete(): it polls the exact same register -
> MDIO_MMD_VEND1:VEND1_GLOBAL_FW_ID - as aqr_firmware_load().
>
> Thus, the entire logic after the introduction of aqr_wait_reset_complete=
() is
> now completely side-stepped, because if aqr_wait_reset_complete()
> succeeds, MDIO_MMD_VEND1:VEND1_GLOBAL_FW_ID could have only been a
> non-zero value. The handling of the case where the register reads as 0
> is dead code, due to the previous -ETIMEDOUT having stopped execution
> and returning a fatal error to the caller. We never attempt to load
> new firmware if no firmware is present.
>
> Based on static code analysis, I guess we should simply introduce a
> switch/case statement based on the return code from aqr_wait_reset_compl=
ete(),
> to determine whether to load firmware or not. I am not intending to
> change the procedure through which the driver determines whether to load
> firmware or not, as I am unaware of alternative possibilities.
>
> At the same time, Russell King suggests that if aqr_wait_reset_complete(=
)
> is expected to return -ETIMEDOUT as part of normal operation and not
> just catastrophic failure, the use of phy_read_mmd_poll_timeout() is
> improper, since that has an embedded print inside. Just open-code a
> call to read_poll_timeout() to avoid printing -ETIMEDOUT, but continue
> printing actual read errors from the MDIO bus.
>
> Fixes: ad649a1fac37 ("net: phy: aquantia: wait for FW reset before check=
ing the vendor ID")
> Reported-by: Clark Wang <xiaoning.wang@nxp.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/netdev/8ac00a45-ac61-41b4-9f74-d18157b8b=
6bf@nvidia.com/
> Reported-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> Closes: https://lore.kernel.org/netdev/c7c1a3ae-be97-4929-8d89-04c8aa870=
209@gmx.net/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Only compile-tested. However, my timeout timer expired waiting for
> reactions on the thread with Bartosz' original patch, and Hans-Frieder
> Vogt wrote a message in his cover letter implying that the patch fixes
> the issue for him. Any Tested-by: tags are welcome.
>
>   drivers/net/phy/aquantia/aquantia_firmware.c | 42 +++++++++++---------
>   drivers/net/phy/aquantia/aquantia_main.c     | 19 +++++++--
>   2 files changed, 39 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/=
phy/aquantia/aquantia_firmware.c
> index 524627a36c6f..dac6464b5fe2 100644
> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> @@ -353,26 +353,32 @@ int aqr_firmware_load(struct phy_device *phydev)
>   {
>   	int ret;
>
> -	ret =3D aqr_wait_reset_complete(phydev);
> -	if (ret)
> -		return ret;
> -
> -	/* Check if the firmware is not already loaded by pooling
> -	 * the current version returned by the PHY. If 0 is returned,
> -	 * no firmware is loaded.
> +	/* Check if the firmware is not already loaded by polling
> +	 * the current version returned by the PHY.
>   	 */
> -	ret =3D phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
> -	if (ret > 0)
> -		goto exit;
> -
> -	ret =3D aqr_firmware_load_nvmem(phydev);
> -	if (!ret)
> -		goto exit;
> -
> -	ret =3D aqr_firmware_load_fs(phydev);
> -	if (ret)
> +	ret =3D aqr_wait_reset_complete(phydev);
> +	switch (ret) {
> +	case 0:
> +		/* Some firmware is loaded =3D> do nothing */
> +		return 0;
> +	case -ETIMEDOUT:
> +		/* VEND1_GLOBAL_FW_ID still reads 0 after 2 seconds of polling.
> +		 * We don't have full confidence that no firmware is loaded (in
> +		 * theory it might just not have loaded yet), but we will
> +		 * assume that, and load a new image.
> +		 */
> +		ret =3D aqr_firmware_load_nvmem(phydev);
> +		if (!ret)
> +			return ret;
> +
> +		ret =3D aqr_firmware_load_fs(phydev);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		/* PHY read error, propagate it to the caller */
>   		return ret;
> +	}
>
> -exit:
>   	return 0;
>   }
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/=
aquantia/aquantia_main.c
> index e982e9ce44a5..57b8b8f400fd 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -435,6 +435,9 @@ static int aqr107_set_tunable(struct phy_device *phy=
dev,
>   	}
>   }
>
> +#define AQR_FW_WAIT_SLEEP_US	20000
> +#define AQR_FW_WAIT_TIMEOUT_US	2000000
> +
>   /* If we configure settings whilst firmware is still initializing the =
chip,
>    * then these settings may be overwritten. Therefore make sure chip
>    * initialization has completed. Use presence of the firmware ID as
> @@ -444,11 +447,19 @@ static int aqr107_set_tunable(struct phy_device *p=
hydev,
>    */
>   int aqr_wait_reset_complete(struct phy_device *phydev)
>   {
> -	int val;
> +	int ret, val;
> +
> +	ret =3D read_poll_timeout(phy_read_mmd, val, val !=3D 0,
> +				AQR_FW_WAIT_SLEEP_US, AQR_FW_WAIT_TIMEOUT_US,
> +				false, phydev, MDIO_MMD_VEND1,
> +				VEND1_GLOBAL_FW_ID);
> +	if (val < 0) {
> +		phydev_err(phydev, "Failed to read VEND1_GLOBAL_FW_ID: %pe\n",
> +			   ERR_PTR(val));
> +		return val;
> +	}
>
> -	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> -					 VEND1_GLOBAL_FW_ID, val, val !=3D 0,
> -					 20000, 2000000, false);
> +	return ret;
>   }
>
>   static void aqr107_chip_info(struct phy_device *phydev)
Tested-by: Hans-Frieder Vogt <hfdevel@gmx.net>

 =C2=A0=C2=A0=C2=A0 Hans

