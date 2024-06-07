Return-Path: <netdev+bounces-101858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25C0900504
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910961F21F45
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BF31946D0;
	Fri,  7 Jun 2024 13:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441BE19413D;
	Fri,  7 Jun 2024 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767124; cv=none; b=lDnjOuxPeuMyh87CQ+qDoAwdNWBipa1KlWvEfyEJsvwklQSlBfm/qZiNbZnRKQ7sRlv9MiTtN6II9HVMR/HdTg1a+RgyGWWilSRUYwSTneT3WgHLdpu4/xtgThQMaUg9+/pqovkqhiOWTXbVsxc/Lt9MX1+6uuWxOWX1MOy8FMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767124; c=relaxed/simple;
	bh=jK1d3o1QAPsjxRL7F/RTi+01I3SDRcHu6QO1eAUSOe0=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=tkS7k2f0pt5AFvTH2Sgck3OwHPvzOU6EQbg6WAxl5DjH6SY8GSF9wrcC8yx4qet7GBs0BIC1xnCxg2CjzHSYHYkiLMFhrYLrZpYmZf1iqn2JF/Tkp4dsMvEc5q9etoryA7XKL19Atv6SHdP2iG2b7ICR98ZGyL/mmuzxoehcBFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFZhH-005xIM-G8; Fri, 07 Jun 2024 15:31:59 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFZhG-00EM7R-UE; Fri, 07 Jun 2024 15:31:58 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 8F565240053;
	Fri,  7 Jun 2024 15:31:58 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 1974C240050;
	Fri,  7 Jun 2024 15:31:58 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 9D59A381D6;
	Fri,  7 Jun 2024 15:31:57 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 15:31:57 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/13] net: dsa: lantiq_gswip: Forbid
 gswip_add_single_port_br on the CPU port
Organization: TDT AG
In-Reply-To: <20240607112628.igcf6ytqe6wbmbq5@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-10-ms@dev.tdt.de>
 <20240607112628.igcf6ytqe6wbmbq5@skbuf>
Message-ID: <e2439e7d01c4484c59ce3df2707c2e00@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1717767119-36129522-4EAB40DD/0/0
X-purgate: clean

On 2024-06-07 13:26, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 10:52:30AM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> Calling gswip_add_single_port_br() with the CPU port would be a bug
>> because then only the CPU port could talk to itself. Add the CPU port 
>> to
>> the validation at the beginning of gswip_add_single_port_br().
>> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/net/dsa/lantiq_gswip.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/dsa/lantiq_gswip.c 
>> b/drivers/net/dsa/lantiq_gswip.c
>> index ee8296d5b901..d2195271ffe9 100644
>> --- a/drivers/net/dsa/lantiq_gswip.c
>> +++ b/drivers/net/dsa/lantiq_gswip.c
>> @@ -657,7 +657,7 @@ static int gswip_add_single_port_br(struct 
>> gswip_priv *priv, int port, bool add)
>>  	unsigned int max_ports = priv->hw_info->max_ports;
>>  	int err;
>> 
>> -	if (port >= max_ports) {
>> +	if (port >= max_ports || dsa_is_cpu_port(priv->ds, port)) {
>>  		dev_err(priv->dev, "single port for %i supported\n", port);
>>  		return -EIO;
>>  	}
>> --
>> 2.39.2
>> 
> 
> Isn't the new check effectively dead code?

As long as the dsa_switch_ops .port_bridge_join and .port_bridge_leave 
are not
executed for the cpu port, I agree with you.

