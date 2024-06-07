Return-Path: <netdev+bounces-101861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E85900519
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71ABC1C24B4A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246F194A50;
	Fri,  7 Jun 2024 13:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40601946AB;
	Fri,  7 Jun 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767259; cv=none; b=hgU7bWYCTYHbkrpsEjk+2CZvCrOwphemYV64UcpZ7wS8i85nFy0QBIPPXorLm/i1WXzmFHw0VxoPMZuRan5RNx2VDPqndymW7eJMM1ZoOBLZON/tQrfouFyT6ncv9GWnR0sqwUXS8QdTVVcgB9EnEfKqXXgLN/WQ5hXaijZLF2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767259; c=relaxed/simple;
	bh=6p1R3jgBWGcBkfv4pBjSAmPrqdO5jpX7UsZJf+Dnvo8=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=KglRpPehAiKDWkXBOBupnF7eUPG4H/VFB/uS8tIYFsadPTGZpXcmtEoITSypwxkq86uafxg+Gc4Yhsi34IfUDmzRw9v2SlX3UGkPNozAfAfp1dHnCmt6E3t3hPH5X07OaAtNiozrHQBVHalrilrdBpT2EzbXhe77LxOFNruSgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFZjT-005xhe-JY; Fri, 07 Jun 2024 15:34:15 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFZjT-00ENF4-2Z; Fri, 07 Jun 2024 15:34:15 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id BE735240053;
	Fri,  7 Jun 2024 15:34:14 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 53F0F240050;
	Fri,  7 Jun 2024 15:34:14 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 09FE238490;
	Fri,  7 Jun 2024 15:34:14 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 15:34:13 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/13] net: dsa: lantiq_gswip: Fix error message
 in gswip_add_single_port_br()
Organization: TDT AG
In-Reply-To: <20240607112710.gbqyhnwisnjfnxrl@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-11-ms@dev.tdt.de>
 <20240607112710.gbqyhnwisnjfnxrl@skbuf>
Message-ID: <07b91d4a519c698bb80c0f50a0d00067@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-ID: 151534::1717767255-36936522-0A96A253/0/0
X-purgate-type: clean

On 2024-06-07 13:27, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 10:52:31AM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> The error message is printed when the port cannot be used. Update the
>> error message to reflect that.
>> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/net/dsa/lantiq_gswip.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/dsa/lantiq_gswip.c 
>> b/drivers/net/dsa/lantiq_gswip.c
>> index d2195271ffe9..3c96a62b8e0a 100644
>> --- a/drivers/net/dsa/lantiq_gswip.c
>> +++ b/drivers/net/dsa/lantiq_gswip.c
>> @@ -658,7 +658,8 @@ static int gswip_add_single_port_br(struct 
>> gswip_priv *priv, int port, bool add)
>>  	int err;
>> 
>>  	if (port >= max_ports || dsa_is_cpu_port(priv->ds, port)) {
>> -		dev_err(priv->dev, "single port for %i supported\n", port);
>> +		dev_err(priv->dev, "single port for %i is not supported\n",
>> +			port);
>>  		return -EIO;
>>  	}
>> 
>> --
>> 2.39.2
>> 
> 
> Isn't even the original condition (port >= max_ports) dead code? Why 
> not
> remove the condition altogether?

I also agree here if we can be sure, that .port_enable, 
.port_bridge_join and
.port_bridge_leave are only called for "valid" (<= max_ports) ports.

