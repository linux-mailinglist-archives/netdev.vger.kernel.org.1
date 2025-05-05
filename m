Return-Path: <netdev+bounces-187788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCFCAA9A3D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B7347A1B08
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6215B25C81B;
	Mon,  5 May 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="N8YDXxJm"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4B1A841B;
	Mon,  5 May 2025 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746465430; cv=none; b=Uku8ADdD8wPMqd6i8B5RWDA+sx0kv3x/c0a5r5Lgw9bC83CbucuvZ6YyMZahEeHwdnKqIGOTo9eir5fxuS5iUSmu679nQerSxoNTCp9ib+Z00Idkws1MWBg+CpM1MEd+p1X9pNYAv68K9PJRdMMFilKbOmkLZpYI+hE1uP4k3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746465430; c=relaxed/simple;
	bh=Hml9TVBh6aj3dyxSBs/WiRTSA/hKsF6Tmpu2siws/K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIg7XuPE42VlZh4bVqyeWzQERbO9r5Q6PyYhwq9DlFUYvPGqfMBGQ+brJEyLtc1v8ddQDW2CILvhGmBiIJ3PVs0/ol4WgoA/RnyMd8NA8jFJw7pntMoHLWaQ738EYTInTKNM+qVoaEeQBOfbyAIizMJ61uFSuzc7ISE1RZGNWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=N8YDXxJm; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746465413; x=1747070213; i=wahrenst@gmx.net;
	bh=cLDXsZGYD6q0gy/FV+zDspd5anO+yccSzga1fFE+UGY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N8YDXxJmofIOgqz5XkLuTEi9iBjGw+DJNex9WQOXQot4ZV+5AttOudSjaVJc8inc
	 v/auhtVFAR+iHOxo9PM294IKenOJw57E2FkIJzsPRURHq7lVD9cbKrL+xxnY3MKH3
	 B3DKL1Gu4iia3RToxCn673xrYcjr/EO4ngFZwGrFVm5sl78RFUD7YlDwMIS3kxZvJ
	 0tTQh30BcuTStpedz9TaJs7gXJ/iQegYejTRKHEEeA6fkHGPPj2YgLg8ucD/afB85
	 XE69/YemwUA+pQfSprZweNNUS1LpJy55uSyBbksfkgJvyws+dvqwdYdWCBXXkucaU
	 tJHiD3fnwkHRE+ZFaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.101] ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1ujgMQ2Dl5-00kdMm; Mon, 05
 May 2025 19:16:53 +0200
Message-ID: <c1fc1341-4490-4e22-a2ee-64bb67529660@gmx.net>
Date: Mon, 5 May 2025 19:16:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] net: vertexcom: mse102x: Return code for
 mse102x_rx_pkt_spi
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250505142427.9601-1-wahrenst@gmx.net>
 <20250505142427.9601-5-wahrenst@gmx.net>
 <3b9d36a7-c2fd-4d37-ba33-fc13121d92e6@lunn.ch>
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
In-Reply-To: <3b9d36a7-c2fd-4d37-ba33-fc13121d92e6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7AXzuM2iX2ojF4KGGHK+3BedcyHtcSCJZHehgfHPSB+/eUuUmu6
 hwwx5avNQy0EXd1X59G9YffL7bv+EgPVo1Yl+B131NrTgnXnUADSW9t4gp56wkG8VEXRgtl
 HlK732Z75kUKq6NWFW4D3KjWd1Q5KoYt4U9GnbAwjU55vy+cmsVilYP4oO0eZRAHLaZW14a
 nYASm0j5YAu4QppYfjqxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HSRHXNXONBg=;eZw6Cme4f/CPGl3qGMIKIx5xzGF
 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

Hi Andrew,

Am 05.05.25 um 18:43 schrieb Andrew Lunn:
> On Mon, May 05, 2025 at 04:24:26PM +0200, Stefan Wahren wrote:
>> The interrupt handler mse102x_irq always returns IRQ_HANDLED even
>> in case the SPI interrupt is not handled. In order to solve this,
>> let mse102x_rx_pkt_spi return the proper return code.
>>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/net/ethernet/vertexcom/mse102x.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/eth=
ernet/vertexcom/mse102x.c
>> index 204ce8bdbaf8..aeef144d0051 100644
>> --- a/drivers/net/ethernet/vertexcom/mse102x.c
>> +++ b/drivers/net/ethernet/vertexcom/mse102x.c
>> @@ -303,7 +303,7 @@ static void mse102x_dump_packet(const char *msg, in=
t len, const char *data)
>>   		       data, len, true);
>>   }
>>  =20
>> -static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
>> +static irqreturn_t mse102x_rx_pkt_spi(struct mse102x_net *mse)
>>   {
>>   	struct sk_buff *skb;
>>   	unsigned int rxalign;
>> @@ -324,7 +324,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *=
mse)
>>   		mse102x_tx_cmd_spi(mse, CMD_CTR);
>>   		ret =3D mse102x_rx_cmd_spi(mse, (u8 *)&rx);
>>   		if (ret)
>> -			return;
>> +			return IRQ_NONE;
>>  =20
>>   		cmd_resp =3D be16_to_cpu(rx);
>>   		if ((cmd_resp & CMD_MASK) !=3D CMD_RTS) {
>> @@ -357,7 +357,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *=
mse)
>>   	rxalign =3D ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
>>   	skb =3D netdev_alloc_skb_ip_align(mse->ndev, rxalign);
>>   	if (!skb)
>> -		return;
>> +		return IRQ_NONE;
> This is not my understanding of IRQ_NONE. To me, IRQ_NONE means the
> driver has read the interrupt status register and determined that this
> device did not generate the interrupt. It is probably some other
> device which is sharing the interrupt.
At first i wrote this patch for the not-shared interrupt use case in=20
mind. Unfortunately this device doesn't have a interrupt status register=
=20
and in the above cases the interrupt is not handled.

kernel-doc says:

@IRQ_NONE:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 interrupt was not from thi=
s device or was not handled
@IRQ_HANDLED:=C2=A0=C2=A0=C2=A0 interrupt was handled by this device

So from my understanding IRQ_NONE fits better here (assuming a=20
not-shared interrupt).

I think driver should only use not-shared interrupts, because there is=20
no interrupt status register. Am I right?
May this SPI client protocol limitation should be documented in the=20
dt-binding?

>
>         Andrew


