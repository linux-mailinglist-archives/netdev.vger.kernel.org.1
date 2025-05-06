Return-Path: <netdev+bounces-188251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EACBAABD0C
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10403A515D
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADC9239E83;
	Tue,  6 May 2025 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="gvfVxeci"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448C214210;
	Tue,  6 May 2025 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519875; cv=none; b=r19kW69axWqr9IgljPt9BTda+yvlmDkfTy2pGDINm5FPHzP1mR+jgZmuXQWXVea3aBD/nwo8aX/B4GMPnrQ/fmNA9yv740CfkfO2XfYZ+qVcI38nK8kSkObIufJOXFf3sd3CqzxiMN3343Vnky71A66JAexovqpc1GVmV0218dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519875; c=relaxed/simple;
	bh=e00Jb3ViMpP+JZNFvvI3iacYaihUs//0oW8T/5s0AfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XspPPt2NN7VgZ77db6HSvB7rtYVIuXT8i3E7GsOHtef4d+hLlyQw+/9Di/AgEFC2+vxVetIk/KeFElWxjk9AJHdStJTBOaCwMZ9goB4hfQtqJqmef7Cpb9y8onWHtJUCaZc0ln0XAV4PYCwiMTLa1EvQC12gZ4F/PFga/sGfQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=gvfVxeci; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746519868; x=1747124668; i=wahrenst@gmx.net;
	bh=EAKgez/ycANs861LxuWgGXq/t0netUcvLVCm0u8mb5w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gvfVxeci5nAsaKh7S7NXqzC672NNtF5pCGWrmYexyPf4yjKRH8RNKokUwFrG/C51
	 sd7HmXS0SbqXqi/NrEkd2tN0lf+jsK/rHj6CaOUslGDwoJRnewaDAuTk89lbkTlOR
	 AjKtUbPXrXt2irfdCHko8778yMY6AmPcWoopUIs7LQo+0OmWwsQOd6xLSp4jwmK7A
	 E5SXDJ2E633OazG2Zf/RTHYA6qrUA8lbg13hHGr1CN9vU5H5ciiuzy97odtnlP+UW
	 ZIN0BqjNvDgrs/s1TWufqcOCM6X1GglmrzXrlDMT9wVOHz9aqdfpd4e44vL+syKoD
	 bs57OCJCG4RnNY6jCw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.101] ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1u86jA404x-00GTDI; Tue, 06
 May 2025 10:24:28 +0200
Message-ID: <923bc33f-db94-4aea-8225-9125298ecfff@gmx.net>
Date: Tue, 6 May 2025 10:24:26 +0200
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
 <c1fc1341-4490-4e22-a2ee-64bb67529660@gmx.net>
 <51cdf94b-6f97-421d-916c-aca5e7c34879@lunn.ch>
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
In-Reply-To: <51cdf94b-6f97-421d-916c-aca5e7c34879@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5uQ/P3rCn/9GXH5RZZEpVkap42WKidOaFig0pllcur/3lJHL3ck
 EMPTWXtyquHd8QpfZo2igdRe1nyA3JgGWxEjODoPPMI4Sfo1ifUYl0iX7pWqLWt40LxV/n5
 tGZdf61yvv+sgmPzJlnVaf5ADCOvpmvj5XGgPPJxcChKcoCOKGE0q4voY70KTdOBx78memH
 FcfNuQYqDTqP2UGr+Yv6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mCTLQm7UyYw=;OVDOWkw80o8DgSzN3iZGMpWzf2Y
 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

Hi Andrew,

Am 05.05.25 um 21:27 schrieb Andrew Lunn:
> On Mon, May 05, 2025 at 07:16:51PM +0200, Stefan Wahren wrote:
>> Hi Andrew,
>>
>> Am 05.05.25 um 18:43 schrieb Andrew Lunn:
>>> On Mon, May 05, 2025 at 04:24:26PM +0200, Stefan Wahren wrote:
>>>> The interrupt handler mse102x_irq always returns IRQ_HANDLED even
>>>> in case the SPI interrupt is not handled. In order to solve this,
>>>> let mse102x_rx_pkt_spi return the proper return code.
>>>>
>>>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>>>> ---
>>>>    drivers/net/ethernet/vertexcom/mse102x.c | 15 +++++++++------
>>>>    1 file changed, 9 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/e=
thernet/vertexcom/mse102x.c
>>>> index 204ce8bdbaf8..aeef144d0051 100644
>>>> --- a/drivers/net/ethernet/vertexcom/mse102x.c
>>>> +++ b/drivers/net/ethernet/vertexcom/mse102x.c
>>>> @@ -303,7 +303,7 @@ static void mse102x_dump_packet(const char *msg, =
int len, const char *data)
>>>>    		       data, len, true);
>>>>    }
>>>> -static void mse102x_rx_pkt_spi(struct mse102x_net *mse)
>>>> +static irqreturn_t mse102x_rx_pkt_spi(struct mse102x_net *mse)
>>>>    {
>>>>    	struct sk_buff *skb;
>>>>    	unsigned int rxalign;
>>>> @@ -324,7 +324,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net=
 *mse)
>>>>    		mse102x_tx_cmd_spi(mse, CMD_CTR);
>>>>    		ret =3D mse102x_rx_cmd_spi(mse, (u8 *)&rx);
>>>>    		if (ret)
>>>> -			return;
>>>> +			return IRQ_NONE;
>>>>    		cmd_resp =3D be16_to_cpu(rx);
>>>>    		if ((cmd_resp & CMD_MASK) !=3D CMD_RTS) {
>>>> @@ -357,7 +357,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net=
 *mse)
>>>>    	rxalign =3D ALIGN(rxlen + DET_SOF_LEN + DET_DFT_LEN, 4);
>>>>    	skb =3D netdev_alloc_skb_ip_align(mse->ndev, rxalign);
>>>>    	if (!skb)
>>>> -		return;
>>>> +		return IRQ_NONE;
>>> This is not my understanding of IRQ_NONE. To me, IRQ_NONE means the
>>> driver has read the interrupt status register and determined that this
>>> device did not generate the interrupt. It is probably some other
>>> device which is sharing the interrupt.
>> At first i wrote this patch for the not-shared interrupt use case in mi=
nd.
>> Unfortunately this device doesn't have a interrupt status register and =
in
>> the above cases the interrupt is not handled.
>>
>> kernel-doc says:
>>
>> @IRQ_NONE:=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 interrupt was not from =
this device or was not handled
>> @IRQ_HANDLED:=C2=A0=C2=A0=C2=A0 interrupt was handled by this device
> A memory allocation failure in netdev_alloc_skb_ip_align() does not
> seem like a reason to return IRQ_NONE. I think the more normal case
> is, there was an interrupt, there was an attempt to handle it, but the
> handler failed.
In my opinion this applies to both IRQ_NONE cases. The problem here is=20
that there are no interrupt register provided by the MSE102x, so the=20
only way to handle the SPI interrupt is to fetch the whole packet from=20
the MSE102x internal buffer via SPI. But this requires a receive buffer=20
which is big enough on the host side, so we use=20
netdev_alloc_skb_ip_align() here to allocate this (SPI) receive buffer.=20
The only way to avoid the second error case would be to preallocate a=20
buffer which is big enough for the largest possible Ethernet frame.
>   The driver should try to put the hardware into a state
> the next interrupt will actually happen, and be serviced.
>
> This is particularly important with level interrupts. If you fail to
> clear the interrupt, it is going to fire again immediately after
> exiting the interrupt handler and the interrupt is reenabled. You
> don't want to die in an interrupt storm. Preventing such interrupt
> storms is part of what the return value is used for. If the handler
> continually returns IRQ_NONE, after a while the core declares there is
> nobody actually interested in the interrupt, and it leaves it
> disabled.
Yes, this was the intention of this patch. It's better to disable the=20
IRQ completely because there is something wrong with the hardware=20
instead of triggering a interrupt storm. So this is an argument to=20
return IRQ_NONE and not IRQ_HANDLED.

I was dealing with interrupt storms on Raspberry Pi caused by dwc2 and=20
it's a PITA.
>
>> So from my understanding IRQ_NONE fits better here (assuming a not-shar=
ed
>> interrupt).
>>
>> I think driver should only use not-shared interrupts, because there is =
no
>> interrupt status register. Am I right?
> I don't see why it cannot be shared. It is not very efficient, and
> there will probable be a bias towards the first device which requests
> the interrupt, but a shared interrupt should work.
I agree in general, but i don't recommend it.

Regards
>
> 	Andrew


