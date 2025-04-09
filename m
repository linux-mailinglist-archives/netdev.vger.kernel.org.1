Return-Path: <netdev+bounces-180868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A89FA82BB2
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA837A8911
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25721C84D6;
	Wed,  9 Apr 2025 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="uh1XqO9m"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326531C1F0C;
	Wed,  9 Apr 2025 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744214553; cv=none; b=dvVWZH9w1o0Z1VvqlDRmfJWKGGTh1waNcG78o+fZkekjap1fjJb4Yxs0PPPM0JCeUpVsNdFVNXaTtFqmubksggekn5Yy3+KaJbR7dEE/pyC7nZiyY8JK8aWXCA5Y1NkKdo73ctLevJQ5pbHPIohw4U/3TFcXe/GnTzpxqoOMrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744214553; c=relaxed/simple;
	bh=bWjKZWGcLrX2LMShH+VAwIZzXlyUx/AVkhZt7QnY6P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6QSSJJkISxDqck33AhlxmPNLnNeLRi4BwejwnYLzmkks9DvwXyPNFZCqf1rlHA1tLEpL8QvtoISB50jlICtOnwSM9pqzQHaGDEfzyw9TpXkUHF0GntVTCcmZvQbxzl3GPTQb1Nvs8K2ExX+Vwv/kI5WyjjdCI5pC45zPWVWiqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=uh1XqO9m; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744214503; x=1744819303; i=wahrenst@gmx.net;
	bh=GT+e0rgk5at2BiS7exBI3n9s8/eUZISH0DmawBVE9Ck=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uh1XqO9m44OLywMw5J3jhDWcs77Cz+bVQp+9fgKs3nfx5wbZmNJez6sm+T/kVtkS
	 alfyOcM/+iU91cSeARDCZGgzPUc+bVs+lsW32UzaNYxE0zMGh9b4h7tvMzmclJLtf
	 haSAQlZhWqAdWsE91HBq5CZpRLjMeLgKyiuEQjRf5/o8USje8g/l5Rg4SE/ue1JBC
	 +UfhFwR92XIAB4MJwQdxWIhpn/DEKKX2JjQWfwsEkI+DXwGaSVj6YuFOw/qIXutpS
	 LLQvA4h3kI1L2ra0dRdMhQ704HyFhrKk5EWP57DnbIuRrWCQUwqrxuDyhRlBBeJsk
	 okdS0xNFonCPsLoUMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQe5u-1texFJ1NfK-00Nnw3; Wed, 09
 Apr 2025 18:01:43 +0200
Message-ID: <c67ad9fa-6255-48e8-9537-2fceb0510127@gmx.net>
Date: Wed, 9 Apr 2025 18:01:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v4 5/5] ARM: mxs_defconfig: Enable CONFIG_FEC_MTIP_L2SW
 to support MTIP L2 switch
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20250407145157.3626463-1-lukma@denx.de>
 <20250407145157.3626463-6-lukma@denx.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20250407145157.3626463-6-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C+u//MOKrD6OdwvSME77qybiBXe8adc+njD77MBHM1ou1SB80g9
 CfCohUvsktjxjtntt5js9Ty3COdHeULgaRnhBHHLgQIAwUJwW5jpBMHhH/y28PpuTcVa0Xt
 NUZzHDi8osc+iFVGUZEnfhgcpRZmvQO63hb/o9UYD2DifW+ODJqnrPlxGgcKLL5f4D8l72r
 DnIvoB9kQQrjxQQ6QPh0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h0HaSYSRWiA=;9+RUTCpsfpjtjY9+/fAxrUKZlov
 en9y0HFgHTqcg/tTomRJXXnKDodyPsrawVBHjmREAT+vi9nezDT1o3dXhmnjyrPzCGbiAYqO9
 m5aTfBilljd+4GP8Fd0eiBknFpE/RW2JUKOr7PDqsfZO39RqdMTugoZMcb+KwBN678RNijbUz
 ZadVP+Pagi9G3ek4w6BJ0sJBpNsinoPp9gQXJd9D1E6py+KrLqQ1DCiQBrAGzA2csvJKNocLy
 2JMgJrGWuEvii3JW/QsZFeyA5tUaOzSr88pHzmb7ppaRdfCnIV14yl4eQInAiz2WoDxkhQJTH
 s1gpWGw0nJPKlNmO96ZOHI6s6UqiITzy++DGlf90aTN83+rW3b8i91D+ZemFvMZSYX5pNIfrD
 l8E5FngLmD/fJ8ZUAgzSN6HEip1IrKv5kjgKjck9bmkl2JAdS+vc0pfmAbpKzY5riUNv156BV
 s8hWUkxFU6hYV+uNK0TcG4akL3K9J/w/XEjWxg44kCZtnvbNCcu8cXY5TA1S/OWtbpr9ph5AP
 SGzz37iNu9PFdnOj6Rxg1tuEwqw0nVe3Hy162pyMiyA+NcEcIwo/0OPRN+iwyLKqjwH8WsgRA
 NRpX6GSN8kW004v22qYLKQmCCltpdN/qSkl+4ZNnTAlixCrnM6kXtyUV9IaVmGRCh/MM8bFgc
 mmdzQz54c6SjBRkFpn4CYW3k2Phw6eqw+VR+9x+8TMRuudOHlE9uf2W+gT6kFv3xMre/HhfQc
 I8/n44itpdaTDiH6SUOGux/r2p3oGL1UVHesvkgZ3YIsO74hU4v/w15PAYJEXOHdZffIsBhnt
 QwjNy7Sst1rMF5e4IwhjH3jQn2JDApo+6FebR8YvrAwocR3e6UNgbHJ4No1rin7af0mjDbB3K
 6rlODNmQoHCA7fVsqR+gHAUkrBKn/PnPTgfqONjwJPyKnVKK73VUPAdDL3MGcT4wYbH2VRk+j
 J0g1VFdQYwYWj+3gXragNVb8UPO9sVbb/JhMC7lldzzNmeKdPazCtQRqdJiKWlwcJwQBjj5t2
 kHMaXhvqHWkFKxidP1pWXy8xaTgWgBq4iDy4+fsjslurKS1+ImyhEd3WjKeks49/R8rbfjHfx
 4vdDSHAFYmkbmVXMFlqPYoSq5QPRADXqca+YtIk9s4Ji8KM2fj2ORaO6XwG/DbZrZTPhdZs3C
 +83/UadyftJ02TTSh67jc2cDyhcXfJVQv4tOpefzok3wJ4/J+NbqwIY5/aeGRyrbV9FjJCGzy
 DBTnUeC7Ax/ObUIJxQKeUXFFl0A0RaYDlyRw+sV0iIel4IRQXpFic/v/JrOS72KTUF0MbuIkG
 7z6szCO/Vdawq8BcPZKS3BigX3DEyDNeEFxkT4wyDMXe9/vas9OF0m/C2wPoqgQwuBJhzivvS
 Rhsm6/vWInQLqWIZhomLfqsRSqrWqaVeYkwCLvzqv7y/wPtGjqw/jTyJ8i+eHSc6S+lW/FtJM
 SMMWrrp2+Er+POSLNtsK24LHUW94=

Hi Lukasz,

Am 07.04.25 um 16:51 schrieb Lukasz Majewski:
> This patch enables support for More Than IP switch available on some
> imx28[7] devices.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
thanks adding the driver to mxs_defconfig. Unfortunately it's not
possible for reviewers to identify the relevant changes, also the commit
messages doesn't provide further information.

In general there are two approaches to solves this:
1) prepend an additional patch which synchronizes mxs_defconfig with
current mainline
2) manually create the relevant changes against mxs_defconfig

The decision about the approaches is up to the maintainer.

Btw driver review will follow ...

Regards
> ---
> Changes for v4:
> - New patch
> ---
>   arch/arm/configs/mxs_defconfig | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defco=
nfig
> index d8a6e43c401e..4dc4306c035f 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -32,11 +32,10 @@ CONFIG_INET=3Dy
>   CONFIG_IP_PNP=3Dy
>   CONFIG_IP_PNP_DHCP=3Dy
>   CONFIG_SYN_COOKIES=3Dy
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>   # CONFIG_INET_DIAG is not set
>   # CONFIG_IPV6 is not set
> +CONFIG_BRIDGE=3Dy
> +CONFIG_NET_SWITCHDEV=3Dy
>   CONFIG_CAN=3Dm
>   # CONFIG_WIRELESS is not set
>   CONFIG_DEVTMPFS=3Dy
> @@ -45,7 +44,6 @@ CONFIG_MTD=3Dy
>   CONFIG_MTD_CMDLINE_PARTS=3Dy
>   CONFIG_MTD_BLOCK=3Dy
>   CONFIG_MTD_DATAFLASH=3Dy
> -CONFIG_MTD_M25P80=3Dy
>   CONFIG_MTD_SST25L=3Dy
>   CONFIG_MTD_RAW_NAND=3Dy
>   CONFIG_MTD_NAND_GPMI_NAND=3Dy
> @@ -56,11 +54,11 @@ CONFIG_EEPROM_AT24=3Dy
>   CONFIG_SCSI=3Dy
>   CONFIG_BLK_DEV_SD=3Dy
>   CONFIG_NETDEVICES=3Dy
> +CONFIG_FEC_MTIP_L2SW=3Dy
>   CONFIG_ENC28J60=3Dy
>   CONFIG_ICPLUS_PHY=3Dy
>   CONFIG_MICREL_PHY=3Dy
>   CONFIG_REALTEK_PHY=3Dy
> -CONFIG_SMSC_PHY=3Dy
>   CONFIG_CAN_FLEXCAN=3Dm
>   CONFIG_USB_USBNET=3Dy
>   CONFIG_USB_NET_SMSC95XX=3Dy
> @@ -77,13 +75,11 @@ CONFIG_SERIAL_AMBA_PL011=3Dy
>   CONFIG_SERIAL_AMBA_PL011_CONSOLE=3Dy
>   CONFIG_SERIAL_MXS_AUART=3Dy
>   # CONFIG_HW_RANDOM is not set
> -# CONFIG_I2C_COMPAT is not set
>   CONFIG_I2C_CHARDEV=3Dy
>   CONFIG_I2C_MXS=3Dy
>   CONFIG_SPI=3Dy
>   CONFIG_SPI_GPIO=3Dm
>   CONFIG_SPI_MXS=3Dy
> -CONFIG_GPIO_SYSFS=3Dy
>   # CONFIG_HWMON is not set
>   CONFIG_WATCHDOG=3Dy
>   CONFIG_STMP3XXX_RTC_WATCHDOG=3Dy
> @@ -138,10 +134,6 @@ CONFIG_PWM_MXS=3Dy
>   CONFIG_NVMEM_MXS_OCOTP=3Dy
>   CONFIG_EXT4_FS=3Dy
>   # CONFIG_DNOTIFY is not set
> -CONFIG_NETFS_SUPPORT=3Dm
> -CONFIG_FSCACHE=3Dy
> -CONFIG_FSCACHE_STATS=3Dy
> -CONFIG_CACHEFILES=3Dm
>   CONFIG_VFAT_FS=3Dy
>   CONFIG_TMPFS=3Dy
>   CONFIG_TMPFS_POSIX_ACL=3Dy


