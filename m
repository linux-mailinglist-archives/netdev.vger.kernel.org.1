Return-Path: <netdev+bounces-220293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBD6B454C5
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B5CA64594
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF98A2D5A01;
	Fri,  5 Sep 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="N8VeVrTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F682D5C95
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068237; cv=none; b=sgo+XL6IHhCd6yWiAUe/o5GjkWttaYFsg5aWILSvcDmKFO2R8wyYztAsBXlklYsZ23Qyd30sgajXztifYaA3ZYaH8lGptp3vt/+CDE6Rfx1cOId6RE1CaLvvNxZA8EB16d9aVgab6lWuNaRmCU/kEpng8fvkbEBzkhdy1FyByLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068237; c=relaxed/simple;
	bh=BKM72VCjZI+Xr9iDez5Yzps9AYG6Qw9bHedIMduJtjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eB+Hv8H8KR2s/HvXzE33i2x1cHbmB5uFdqXKzvk92tiSruQyPwUNyKoNs+4v1Wq6DaS3+8vF7EhZQlIE4FK2xduTv/9x3qE6+16WhkQGr9zo/b6C6cGGjr9BYVGOqUV2GkKuCks+sYNH8ZsgZMXYjLalk0V82cRUMmnAoMJNi+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=N8VeVrTJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1757068222; x=1757673022; i=wahrenst@gmx.net;
	bh=r2uVXcs0QAahaIUn5OuRKUawW0ZN6MGD4Ad8KRXCsP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N8VeVrTJhygLXNGXyttCk4xvfGPZNvaflV+Klrs1ETuMVX0JlQLo1c9Enu1RDW3s
	 00C12nBc7xxqABQCI9gEZE6NrXnmhc9xWK+GaTeU0ITb2hEzt5v8EfnuCCgFQ2sDV
	 dWrvR7JDa9N/ti9UN+UPp783bx0y3kSvMrTHG2qHlFlnKXWuPA2knSvdZ1j/Rfz59
	 u2wIIYym3zzk4QBn57zSyzW1M3NskLxPM5hDFV42AyouNDWbDES0tBQJoJQV3HlAb
	 LISvWrXxiQDZIFitSEr6qUvm+r9wUPPPwVzaLCnNGGsFGaz4UXBL45TS5HHF5a/vf
	 /byPb2KJIW6MyODWbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([79.235.128.112]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5mKJ-1uN4ZJ2Oi3-0155SO; Fri, 05
 Sep 2025 12:30:22 +0200
Message-ID: <56f30191-029a-4af5-be47-72480b8d32ad@gmx.net>
Date: Fri, 5 Sep 2025 12:30:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2 next] microchip: lan865x: Allow to fetch MAC from
 NVMEM
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20250904100916.126571-1-wahrenst@gmx.net>
 <20250904100916.126571-3-wahrenst@gmx.net>
 <60547e0f-f1ef-46e1-a7ce-ea302ab08584@lunn.ch>
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
In-Reply-To: <60547e0f-f1ef-46e1-a7ce-ea302ab08584@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LPaqkitXVegMbi0R3GZyWDkQ1Tj0YTDZPxS+r4sm7Dl+4JmYKOS
 fJlZ9ygea/pY3+gNhe696AxH7GjhsREaYB3GsN6gQjqspGowicg88FqyyM6PjuwZnXXbsj+
 zvvPdI1sdFzZ8ubZbVC5UaLAqMpyn24Qt3eieu3n99eBnUewMfN9Da5SYPDE++B7xwrMvnK
 9InZb3vvXpwKlEKp0UxqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HejsVBUrzXw=;xXqFodqbQQ5O43hhUvFhTk7T8pA
 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
 tMMiX5Wn1LIvKbGkYrd

Hi Andrew,

Am 04.09.25 um 20:54 schrieb Andrew Lunn:
> On Thu, Sep 04, 2025 at 12:09:16PM +0200, Stefan Wahren wrote:
>> A lot of modern SoC have the ability to store MAC addresses in
>> their NVMEM. The generic function device_get_ethdev_address()
>> doesn't provide this feature. So try to fetch the MAC from
>> NVMEM if the generic function fails.
> I notice this is RFC. What comments would you like?
>
>> -	if (device_get_ethdev_address(&spi->dev, netdev))
>> -		eth_hw_addr_random(netdev);
>> +	if (device_get_ethdev_address(&spi->dev, netdev)) {
>> +		/* Get the MAC address from NVMEM */
>> +		if (of_get_ethdev_address(spi->dev.of_node, netdev))
>> +			eth_hw_addr_random(netdev);
>> +	}
> Maybe chain this onto the end of device_get_ethdev_address() ?
yes, this was one of the reasons I had in mind to add RFC here.

I will give it a try.

Regards
> Looking
> at the current users of device_get_ethdev_address(), bcmgenet,
> enc28j60, and emac are all likely to be DT systems which could benefit
> from this. You just need to make sure ACPI don't dereference a NULL
> pointer.
>
> 	Andrew


