Return-Path: <netdev+bounces-183338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AFFA906B1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2689E175405
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804A91EF36F;
	Wed, 16 Apr 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="MeqUrdA2"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF141B424E;
	Wed, 16 Apr 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744814478; cv=none; b=fJVxEjgT0S+lCylUlReqq3ANWKqocr2CdfVEfToQ/sLE69s8EWqhz2G/JTeb+L8ul3PpVRKkWR3lq4m0oYQQNxG4+iOS91u4oOz0NcfRFqfrHaI/QXVM+y+K57cVI42RoHv/B8FI6q40VD846qsL2JKMH+LCZgJf05FX+72Zyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744814478; c=relaxed/simple;
	bh=DfpuWb/22GXew3sy1TvM9uTDl50inbApNQpWxE9QD1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpgMOcQVjK6icwNXlS3jwyUfUL2Ym+ZWedeo5gEYeMXerUJiJiHX5v/Z69sAohcO+Z8KtagtdUw7f9twSQruy8cxmkTZO2POTBP9j9sZs+vql1boHjMWVtbvD7oB4Knu5ovBWNWNls0q5JzgIXOnHMGJD+wVhCMjdGrDSlkMjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=MeqUrdA2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744814472; x=1745419272; i=wahrenst@gmx.net;
	bh=18H5TLUC1CF5otZG1QFdpiNNN4p5I8XBvX7Pyec6K0w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MeqUrdA2bRehbDNb9TYoh9hrdB6KR0ggIC5wOFEZJeEIjb6xCsR+L6hJRKmciqL+
	 Wz6QbYZk9b7sd0qGdUDc/l2KsjSlzrYBF+XDIQXdJZz4FaYRiEN1CNi8DNah53YLJ
	 xC/RRXFw7tpTx6jn36KDtVZmGnxCWPpRCSqBgdPOq4udKKHZ09dMai0e5jMujc4Tu
	 tsqBu/qvWO4mJUPEKs0OjxFKtJUl+wC6owxO1r12vy2YHXvVeTIjgnrQewMofWqWK
	 oJ8HPw3H8hEmSO2/WKvLcwDQQ0VNhenzQMAvFho5c3leHFQTQ8IEYNpraQ22mmtAj
	 H33Y9T3Dsd4w1X58gA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUnp-1t7D4D2Ba5-00uJCY; Wed, 16
 Apr 2025 16:41:12 +0200
Message-ID: <41ea023e-d19d-40f1-b268-37292c9e15de@gmx.net>
Date: Wed, 16 Apr 2025 16:41:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v5 5/6] ARM: mxs_defconfig: Update mxs_defconfig to
 6.15-rc1
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Simon Horman <horms@kernel.org>
References: <20250414140128.390400-1-lukma@denx.de>
 <20250414140128.390400-6-lukma@denx.de>
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
In-Reply-To: <20250414140128.390400-6-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mNoRLhj9hT8NWX/aDkbZvrNG2VBpqc1HrfN7B6fDlM1xVNWdXf1
 sBcIeS1Qif2V2dG3i0YIbOCloQCCACZlaM7DGApOw3I88/dPRTZ25dFIDRnGkhrwScMuLzf
 +aLJUiOXFLauw+3fMY5cZ+eXFvLhmVJjhIHDqISo7FtmQKxO7LwyZe20Cgi1TOn5R+cWiYo
 I4mrptx9CKBg0st2R3cLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iAsmAnLLOOw=;SamRCY9Aech2UcVi+9U/zQLwRG8
 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
 /e0szfpEfc1Kuj/tqWeDYY=

Hi Lukasz,

Am 14.04.25 um 16:01 schrieb Lukasz Majewski:
> This file is the updated version of mxs_defconfig for the v6.15-rc1
> linux-next.
thanks for sending this as a separate patch. Unfortunately it's not that=
=20
simple by replacing the existing mxs_defconfig. We need to double-check=20
all changes to settings, which was enabled before. This should also=20
include a short note for every setting in the commit log, otherwise=20
every reviewer has to do this job. I'll help you here by adding comments .=
..
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>
> Changes for v5:
> - New patch
> ---
>   arch/arm/configs/mxs_defconfig | 11 -----------
>   1 file changed, 11 deletions(-)
>
> diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defco=
nfig
> index c76d66135abb..91723fdd3c04 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -32,9 +32,6 @@ CONFIG_INET=3Dy
>   CONFIG_IP_PNP=3Dy
>   CONFIG_IP_PNP_DHCP=3Dy
>   CONFIG_SYN_COOKIES=3Dy
> -# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> -# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> -# CONFIG_INET_XFRM_MODE_BEET is not set
>   # CONFIG_INET_DIAG is not set
>   # CONFIG_IPV6 is not set
>   CONFIG_CAN=3Dm
> @@ -45,7 +42,6 @@ CONFIG_MTD=3Dy
>   CONFIG_MTD_CMDLINE_PARTS=3Dy
>   CONFIG_MTD_BLOCK=3Dy
>   CONFIG_MTD_DATAFLASH=3Dy
> -CONFIG_MTD_M25P80=3Dy
This is safe because it has been replaced MTD_SPI_NOR, which is still=20
enabled.
>   CONFIG_MTD_SST25L=3Dy
>   CONFIG_MTD_RAW_NAND=3Dy
>   CONFIG_MTD_NAND_GPMI_NAND=3Dy
> @@ -60,7 +56,6 @@ CONFIG_ENC28J60=3Dy
>   CONFIG_ICPLUS_PHY=3Dy
>   CONFIG_MICREL_PHY=3Dy
>   CONFIG_REALTEK_PHY=3Dy
> -CONFIG_SMSC_PHY=3Dy
This is okay, because it's enabled implicit by USB_NET_SMSC95XX.
>   CONFIG_CAN_FLEXCAN=3Dm
>   CONFIG_USB_USBNET=3Dy
>   CONFIG_USB_NET_SMSC95XX=3Dy
> @@ -77,13 +72,11 @@ CONFIG_SERIAL_AMBA_PL011=3Dy
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
This also okay, because it has been deprecated by moving to EXPERT and=20
its replacement GPIO_CDEV is enabled by default.
>   # CONFIG_HWMON is not set
>   CONFIG_WATCHDOG=3Dy
>   CONFIG_STMP3XXX_RTC_WATCHDOG=3Dy
> @@ -138,10 +131,6 @@ CONFIG_PWM_MXS=3Dy
>   CONFIG_NVMEM_MXS_OCOTP=3Dy
>   CONFIG_EXT4_FS=3Dy
>   # CONFIG_DNOTIFY is not set
> -CONFIG_NETFS_SUPPORT=3Dm
> -CONFIG_FSCACHE=3Dy
> -CONFIG_FSCACHE_STATS=3Dy
> -CONFIG_CACHEFILES=3Dm
This is unintended, even it's not your fault Lukasz. NETFS_SUPPORT isn't=
=20
user select-able anymore, so it's dropped. AFAIU this comes from NFS=20
support, so i think we need to enable CONFIG_NFS_FSCACHE here. Otherwise=
=20
this caching feature get lost. Since this is a bugfix, this should be=20
separate patch before the syncronization.

@Shawn @Fabio what's your opinion?
>   CONFIG_VFAT_FS=3Dy
>   CONFIG_TMPFS=3Dy
>   CONFIG_TMPFS_POSIX_ACL=3Dy


