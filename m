Return-Path: <netdev+bounces-187095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A71CCAA4E87
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7046A3B56EA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AC225D900;
	Wed, 30 Apr 2025 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Of4pPNuO"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5E1EB5B;
	Wed, 30 Apr 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746023277; cv=none; b=p1pa3dsxYTD9Es2+MHh7mXKh7aRJ1qkpzndlSfRPObhKPknwpTWtUJOHO2R8iwp6t4eDTgVBnI7KfCcPjok5QT+tawwLh1YZuTnFmfHLrs8lCJiJkhuNPISP/kQzgxYOQ4YzqONhrX16F7DOUrHEhv0oL0N4CHlrykswRuz9JXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746023277; c=relaxed/simple;
	bh=H1komDYuRUm4Fvu9WXyqZGzUDq9K7D4kY6fcj+TLNmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7dpUcapk5PsEXcHX4pyrLMzK4ryiaip2WUB+II9oH31sLccLZusQ8D5XXNIi2GmP9jWhri1+IWhKUk+cJ9bCAE4w52vr76ffMs6aa2FNmC/h52n2qsY0UFPREU7pqax9sxF2ThF/APjv338k+f43NHK2JrsrSfXe90bHN0xWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Of4pPNuO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746023266; x=1746628066; i=wahrenst@gmx.net;
	bh=2ejeBxGyY8Dxc6lMYk+w3HrovDXOZlNhETQ2l/KQ2RY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Of4pPNuOYLT1hpSYbIZNqGIFLzEaeXIOz9u0rk0PspDoftZnRmSMA/dj7BJKcu7q
	 6+mC6DpGQawt2nAhsAljkJ9Bn0RNuZHeT5lsXDAIpc7s7Knor2w89t9+tosEXF8dS
	 k6sQavWzuF4UutRhjMUfE+dYZ71MBU97pw2/0Mfw2KEkm0dxl14dNGl2gzQFyDUOU
	 5rCLsYvXSQ4IYvEdD4wqJX3F32XbX9seXB7sLJph9KANJqmbSOk6MwA2YggvmlBID
	 epkPPlXgeysX4/TKv77BYaPhLwfASz+8p7hE8HoLyn3yxxbAPTMu2SAXwgMsRIoFe
	 LGFZg4YEbELgkHsEXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.101] ([91.41.216.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6lpM-1u8Tj22gMo-005wOq; Wed, 30
 Apr 2025 16:27:46 +0200
Message-ID: <fc9cb634-2061-4933-839f-1298906ea189@gmx.net>
Date: Wed, 30 Apr 2025 16:27:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2 4/4] net: vertexcom: mse102x: Fix RX error handling
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250430133043.7722-1-wahrenst@gmx.net>
 <20250430133043.7722-5-wahrenst@gmx.net>
 <bd31ce70-4157-42fe-b398-f1ed6e188506@lunn.ch>
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
In-Reply-To: <bd31ce70-4157-42fe-b398-f1ed6e188506@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r3jk8koXVim8I/Peht+/m3pMBwmp+sz00erJyDHSJ/+En43TJG/
 JA9SGWZ9CYxfMoysQxDxMfbyDBQL7TpujaKwesYhOh3aqL/OBV7LxQPHLvW5IFAPP5ZEDXL
 ZSPpD12JkWMaalnFY+Qo6yr4Z4WMtyWILb5QJIx8J2k2n2qBKU71wcJKHsUZwk5cGuSKPZg
 xI5JY/NXwaS6wF/YRmRZg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hH6/7E+9pPg=;fg8+VwDFSYKQy0PHMFIeJPYQ4uy
 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

Hi Andrew,

Am 30.04.25 um 15:47 schrieb Andrew Lunn:
> On Wed, Apr 30, 2025 at 03:30:43PM +0200, Stefan Wahren wrote:
>> In case the CMD_RTS got corrupted by interferences, the MSE102x
>> doesn't allow a retransmission of the command. Instead the Ethernet
>> frame must be shifted out of the SPI FIFO. Since the actual length is
>> unknown, assume the maximum possible value.
> I assume the SPI transfer won't get the beginning of the next frames
> to make up the shortfall of bytes when the frame is short?
Correct. The only possibility would be to triggered on the falling edge=20
/ low level of the SPI interrupt and try to cancel the possibly ongoing=20
SPI transfer.
I think this would introduce a lot complexity for an issue which is=20
actually caused by poor hardware design.

I think it's not worth the trouble.

Regards
>
>> Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>      Andrew


