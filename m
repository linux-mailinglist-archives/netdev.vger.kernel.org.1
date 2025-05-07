Return-Path: <netdev+bounces-188685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E7AAE32E
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517F71BA5EF9
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2422289372;
	Wed,  7 May 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rXUEyQZw"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9B289365;
	Wed,  7 May 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746628523; cv=none; b=kXexxddIwrGfKdvIv7dASOfRArz0BOqsRhvSg9x2z9U86tBsmSDKZyoQy3IzD2QmUkWd2eZ13NAEayxud6FBgUgnXGd+feHfgpL2DXQ3mcLJMOGG2NRnB/+pbzNNi2I77b4CJuw/iWB2Z3ZCJwFlK3TK/0dxHRtHuUkqoJ00CDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746628523; c=relaxed/simple;
	bh=nEZ/X/CSa6CpJDBkA277TD/Y7XJmH0AfsOiAQ8MtW+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnnDa8PcUYxKeHIPA1EENUo453tvjK/3bF/JbAQzp0k+tWkIF6PVfEAiuK9wazNioMs0476Ddnkk5r9Lv0gsaCCmsOBuanoL6koD6byhiPtFEMEe52BulNVRlewkgZjYixctozge6oNEPO1jZ2sh/5W37/+88nHiS0e7qwxxX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rXUEyQZw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746628509; x=1747233309; i=wahrenst@gmx.net;
	bh=Ut6H0hDVHeAmPZH3h31kBg4T5UPa/h5BzSiJ1oq/iGo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rXUEyQZwXOAJnYHbD3SY9uBkl2/+qlpXK8TJOF/kH/rYdyv7KEV4KKQ2k8+KSRDB
	 G5B5CvWjwLzyIn2/3eTseH9yYoDUA3Mf4J2tf2njvASc2mjBXc1EdHmJKqumQVPJJ
	 AAqQOpaMP3nRHEkL2Vxf5vguz/9JS+QHc80eNwcBGZHnIyK+CVNdMwjA2uiSA6/MT
	 nRk1RWehnVFo0gfB5AcJ5+nEtaFci4p6JkMBzFxkDnTuByWhCFzAHrwCk/6XQRJmi
	 +0GWic9I4R2RKn7i8eW6/JD7/xILsatdcQBnH4GIVBjTcgOFGDwusi+pndXxlIDlT
	 l5K3WdZMU0Wcx1As6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.101] ([91.41.216.208]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNswE-1uNc6H0OrY-00Oqtt; Wed, 07
 May 2025 16:35:09 +0200
Message-ID: <c9c2f4cb-614e-496a-852b-ca8af034c2c1@gmx.net>
Date: Wed, 7 May 2025 16:35:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about
 IRQ trigger type
To: kernel test robot <lkp@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250505142427.9601-3-wahrenst@gmx.net>
 <202505071827.nbdcs1rW-lkp@intel.com>
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
In-Reply-To: <202505071827.nbdcs1rW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HM+jVi0Q2F+6Nvpk2DtOxtn3Uwzm6lnAPq3bASXL6d2VB8Xg5fq
 gVRdsT6+VY/qdEHHnZo7XeOwgH5IcMiwoXZJflsw3l12VVCYC4Pdr5AWKrpks0YoAoZbPkH
 MF0AXj0/swToxOGX2XPw+zhrfPi1TW66uAhotICX62Ispg+yMlq+Gu1LbO9aMNozkBRGNgm
 nUhoOa3W+xBm1y20rWPlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GxDhRsOPVo8=;9aw5O2splymu8Yz1Jeu+1+BUt4Q
 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
 6JtmM901eMbAUuCAXEPEmrruX

Am 07.05.25 um 12:25 schrieb kernel test robot:
> Hi Stefan,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Wahren/dt-=
bindings-vertexcom-mse102x-Fix-IRQ-type-in-example/20250505-222628
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20250505142427.9601-3-wahrenst%=
40gmx.net
> patch subject: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning=
 about IRQ trigger type
> config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250=
507/202505071827.nbdcs1rW-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arch=
ive/20250507/202505071827.nbdcs1rW-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505071827.nbdcs1rW-lk=
p@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     drivers/net/ethernet/vertexcom/mse102x.c: In function 'mse102x_net_o=
pen':
>>> drivers/net/ethernet/vertexcom/mse102x.c:525:37: error: implicit decla=
ration of function 'irq_get_irq_data'; did you mean 'irq_set_irq_wake'? [-=
Wimplicit-function-declaration]
>       525 |         struct irq_data *irq_data =3D irq_get_irq_data(ndev-=
>irq);
>           |                                     ^~~~~~~~~~~~~~~~
>           |                                     irq_set_irq_wake
>
this issue has already been reported by Jakub. I will add the missing=20
include in the next round. Sorry about that.

Regards

