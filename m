Return-Path: <netdev+bounces-187790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0DDAA9A80
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445233BE195
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C0126C389;
	Mon,  5 May 2025 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ctRys7Jw"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C426B96B;
	Mon,  5 May 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466137; cv=none; b=pTPtBwqrj/ZeJaV1JLGclvrOTGC8O2eGrxsJcLs29Hcs2atlajBc5kAjzqMqYv7a7uzWvgQuUrX24AmmGr7X9r14apaSulbF9ZOiBVrG0sHC8JW2HNGSY35M1ragWNMOCUOWaO4Lkr4lIG//+sfA+WQgegr2QwKzBrOpkoElXbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466137; c=relaxed/simple;
	bh=Q9SUJDlxu7+oHqqERc9KWOzxSght9ksFz6MmLIcSFVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEjMtV5SCcNVqnewbCsLAWji1sGfEgvXULahkifUjJg1PV8pEZKQojWJfDrqRxfGXHGPOnZ4ZN/AxluMxGQrZ5rklgnO8na2tTA/LB5lqRKuP8qmOr4Yo6/dpg+nvznbVUamOpvbHlc9KcCFzgYK7MX1ojLpxgiaVGqYE0bYRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ctRys7Jw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746466118; x=1747070918; i=wahrenst@gmx.net;
	bh=TS+8AQqmHliHMq0qcLfbUxz1SOqHNnQuwRnW5p6kMog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ctRys7JwUqbmYB6bjCdds4rzccyadII+UAdqJ5H2kdwPg3r7d0XagiqcZxuoA5Zd
	 Wr2bdlIHwwFxqKpdVO/mbwcEuD01xGwe9DjI9i2PJxK2nwypJfIK+rt6apTac0iWW
	 k2A8RV2xptPVJu/XTq61B7pit80cHicmMFID0ICjm4Z7q4F/UpC/rJsadvvejD6xN
	 0tkaJYMGAHuDgwvN9mrun1n/DyteBt2OCJ9Ow1WaN/tUIIHj3rYWE6kmZfRLBkYSn
	 XqO8Rd9/zkcliFgq9Q4lIe7iu3ImWyOZwIOLBTEWv0VZGYJ6E+tZv/piLpqmoE//R
	 fUB0SVarFSGtXtvZog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.101] ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1ug5qS2xqg-00oARP; Mon, 05
 May 2025 19:28:38 +0200
Message-ID: <3b9bf068-fa84-454f-8cca-cb424a1556a4@gmx.net>
Date: Mon, 5 May 2025 19:28:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] net: vertexcom: mse102x: Drop invalid cmd
 stats
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250505142427.9601-1-wahrenst@gmx.net>
 <20250505142427.9601-4-wahrenst@gmx.net>
 <fdac2206-86ad-4d07-9aea-ef88820dfc88@lunn.ch>
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
In-Reply-To: <fdac2206-86ad-4d07-9aea-ef88820dfc88@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MEuqLFBDy73ap3gVhdMkTjQFy7LTG3+oKSvKM0vpIZmL8MvWi/7
 JzzxmRNupbKnu6Ix57G2Zo23B+vFR0uMf+KkN8544m4s/zyYlaO0H+MwyeBKSjC68y0/6z6
 iL5xISX1Uym0JIvCvuB+33j3Bvz3PKo4LIJJKWNkoOk9bsuOwtTTjBVS8y6WB0YF3VpYy0j
 rQDgmkez/VtCNvdw94SPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3OGx38FJPJw=;Sdx4+6ly0SSU7GWDYtj4lyNB02G
 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

Am 05.05.25 um 18:35 schrieb Andrew Lunn:
> On Mon, May 05, 2025 at 04:24:25PM +0200, Stefan Wahren wrote:
>> The SPI implementation on the MSE102x MCU is in software, as a result
>> it cannot reply to SPI commands in busy state and increase the invalid
>> command counter. So drop the confusing statistics about "invalid" comma=
nd
>> replies.
>>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/net/ethernet/vertexcom/mse102x.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/vertexcom/mse102x.c b/drivers/net/eth=
ernet/vertexcom/mse102x.c
>> index 33371438aa17..204ce8bdbaf8 100644
>> --- a/drivers/net/ethernet/vertexcom/mse102x.c
>> +++ b/drivers/net/ethernet/vertexcom/mse102x.c
>> @@ -45,7 +45,6 @@
>>  =20
>>   struct mse102x_stats {
>>   	u64 xfer_err;
>> -	u64 invalid_cmd;
>>   	u64 invalid_ctr;
>>   	u64 invalid_dft;
>>   	u64 invalid_len;
>> @@ -56,7 +55,6 @@ struct mse102x_stats {
>>  =20
>>   static const char mse102x_gstrings_stats[][ETH_GSTRING_LEN] =3D {
>>   	"SPI transfer errors",
>> -	"Invalid command",
>>   	"Invalid CTR",
>>   	"Invalid DFT",
>>   	"Invalid frame length",
>> @@ -194,7 +192,6 @@ static int mse102x_rx_cmd_spi(struct mse102x_net *m=
se, u8 *rxb)
>>   	} else if (*cmd !=3D cpu_to_be16(DET_CMD)) {
>>   		net_dbg_ratelimited("%s: Unexpected response (0x%04x)\n",
>>   				    __func__, *cmd);
>> -		mse->stats.invalid_cmd++;
> If the net_dbg_ratelimited() is going to stay, maybe rename the
> counter to unexpct_rsp, or similar?
The problem here is that there are many reasons for the unexpected respons=
e:

  * line interferences
  * MSE102x has no firmware installed
  * MSE102x busy
  * no packet in MSE102x receive buffer

So without further context like the actual response this counter isn't=20
very helpful and more likely to scare users. But I would like keep the=20
debug message for hardware / wiring issues.

Regards

>
> 	Andrew


