Return-Path: <netdev+bounces-188269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEBCAABD78
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9517A7ACC85
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC6E2472A1;
	Tue,  6 May 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="p+iHhScL"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB11B4121;
	Tue,  6 May 2025 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520745; cv=none; b=eDfVldDlv4PLaF6/rN/YG+xJJ2IoTbobzZp4iz0bVakeq8vSxkkk2Ea3SoEHDehRAsX5Eb2IBf27yjKl0Uoy5mgqr2IL15nsAOhZQxacArNUZkeXnXmgBGe5tTyFFyiC2UJDFfimQTATVP2/3YOhXwGV4esJ31S+sjQH30PnIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520745; c=relaxed/simple;
	bh=HHjsPZq8uzrPCe0zD/AzJMWNs04iV5XRcTof+9yIwpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naysQAu4AP7vk4T7wwlDce3tWF3ngYYVI/Mvb6oCFxaQpLDWJW1eBigeQ2+zTA5nK3FW526mccB8zThcivrVvZ6o8jOcJjOGnUxOdrGq/SagVCzRN2f/t3JubAkRW4ot09Y7oBmv4QSLV6pfgnHGq6byF4vIt3yGuNKNlhy/F6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=p+iHhScL; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746520734; x=1747125534; i=wahrenst@gmx.net;
	bh=7LjBU1VRNS5UV3VYq3NfB+N0ZXJorinGcA/ME8xyElg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p+iHhScLZi8uzQhCHoeeOT5Eo3P43nXFU16ka0OkkYeMb796XJ2RVwhGBglVymqd
	 1uN38zvA4y6lqLWy/Z+jSctM0tv1Zt+NaeB3eJticO9d4X1cJBdTxNtXgdfKs8Kpi
	 fj4chye4jfxs0a6oItzf0JAc7ikFOU2w+yzipdo9yz1co+VJvKRyGMrILRM20VNbh
	 nDjOhU084S+NC8mdbfcjysB7Crwdo9f8tK2BcHvYMrvLvN3zlSPW//3EBm2zYD87N
	 B5rn0qH75HwehNon2IND/2rZmZgfw27+v5ApE2TddO6a5YY6XLaODJ7aD9s+RfmUg
	 UfhwPSpAuKhN1SRdKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.101] ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBDnC-1uKV1s1P7W-001srh; Tue, 06
 May 2025 10:38:54 +0200
Message-ID: <e75cebaf-6119-4502-ae63-a8758d0dd9f5@gmx.net>
Date: Tue, 6 May 2025 10:38:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/5] net: vertexcom: mse102x: Add warning about
 IRQ trigger type
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250505142427.9601-1-wahrenst@gmx.net>
 <20250505142427.9601-3-wahrenst@gmx.net>
 <14326654-2573-4bb6-b7c0-eb73681caabd@lunn.ch>
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
In-Reply-To: <14326654-2573-4bb6-b7c0-eb73681caabd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nyYn9MGcsSn3H6u/52dswZlCjiPZgP00KwLLYk57Pyf1yCmTJYv
 1302kaXrVQXkmgdolfMjd/lkDWtsv30kiy1dboMDVSMFAj1uH17mcrHIE2QnFcUih/rMDHF
 28VHfaWRVH/U2997aVJUqdo58Fccf45As5BnABmItddzJnj9lq3Kp1Z+oMp7G601738A1D6
 L6bx/OKXXlNdzWrIygR2Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7l6dMTvSR7k=;iSvewER8lGBR9mfNddXgeb4nBGD
 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

Hi Andrew,

Am 05.05.25 um 18:32 schrieb Andrew Lunn:
>> +	if (!irq_data) {
>> +		netdev_err(ndev, "Invalid IRQ: %d\n", ndev->irq);
>> +		return -EINVAL;
>> +	}
>> +
>> +	switch (irqd_get_trigger_type(irq_data)) {
>> +	case IRQ_TYPE_LEVEL_HIGH:
>> +	case IRQ_TYPE_LEVEL_LOW:
>> +		break;
>> +	default:
>> +		netdev_warn_once(ndev, "Only IRQ type level recommended, please upda=
te your firmware.\n");
> I would probably put DT in there somewhere. firmware is rather
> generic.
I'm fine with changing it to DT. I slightly remember of a patch for a=20
BCM2835 driver, which also had a warning to update the DT and a reviewer=
=20
requested it to change it to firmware. I don't remember the reason=20
behind it, maybe it's the fact that not all user know what a DT /=20
devicetree is. A quick grep shows both variants (DT vs firmware).

Regards
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>      Andrew


