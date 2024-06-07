Return-Path: <netdev+bounces-101873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232890059C
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE06428B8A5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4832194C9D;
	Fri,  7 Jun 2024 13:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4B190672;
	Fri,  7 Jun 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768285; cv=none; b=QEXzbi2ROeVhWTn15WQpKn0mkdzKinmF2n/TAv36+8unP4WmcGXNMlOQ686IXUk/3rR21wpD2yFS90gtxPd/nbdGEvNGtBjN7BOTyGmUN/iE087M5p2IYuxDepuCdAgQficcyyqP58UGaIneCzCbIz/3cY3dapgYtQQd5Td/W7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768285; c=relaxed/simple;
	bh=m4/aUaYB7+H0xvvRnmmHXRxI6eX0FFHtmVkd9ToVzrc=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=LmguqOQ4n7Rcr8lsJSUapcKWLyhKE4cpHjBtStpmXbQdq0plGw9okgi1tlQJlEPU79RLuIx76czDlb2IYxOoHINelqBFfFqSQlbFw+qwjXnKAwrHckDy51xSAsAPZ9W5Z0C6QLhIz6TwXjvyg/Ij1Z7s0Hk6qIW8S2EYvXAnczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFa01-00FiZe-9x; Fri, 07 Jun 2024 15:51:21 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFa00-0065O5-Oe; Fri, 07 Jun 2024 15:51:20 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 63929240053;
	Fri,  7 Jun 2024 15:51:20 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E9548240050;
	Fri,  7 Jun 2024 15:51:19 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 8DD9020974;
	Fri,  7 Jun 2024 15:51:19 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 15:51:19 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 13/13] net: dsa: lantiq_gswip: Improve error
 message in gswip_port_fdb()
Organization: TDT AG
In-Reply-To: <20240607114144.knza5aapic2j5txu@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-14-ms@dev.tdt.de>
 <20240607114144.knza5aapic2j5txu@skbuf>
Message-ID: <57e896de3b23929dde870316f999c821@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1717768281-834B4642-AC69B6F7/0/0
X-purgate: clean
X-purgate-type: clean

On 2024-06-07 13:41, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 10:52:34AM +0200, Martin Schiller wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> 
>> Print the port which is not found to be part of a bridge so it's 
>> easier
>> to investigate the underlying issue.
> 
> Was there an actual issue which was investigated here? More details?

Well, there are probably still several problems with this driver. Martin
Blumenstingl is probably referring to the problem discussed in [1] and 
[2].

[1] https://github.com/openwrt/openwrt/pull/13200
[2] https://github.com/openwrt/openwrt/pull/13638

> 
>> Signed-off-by: Martin Blumenstingl 
>> <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/net/dsa/lantiq_gswip.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/dsa/lantiq_gswip.c 
>> b/drivers/net/dsa/lantiq_gswip.c
>> index 4bb894e75b81..69035598e8a4 100644
>> --- a/drivers/net/dsa/lantiq_gswip.c
>> +++ b/drivers/net/dsa/lantiq_gswip.c
>> @@ -1377,7 +1377,8 @@ static int gswip_port_fdb(struct dsa_switch *ds, 
>> int port,
>>  	}
>> 
>>  	if (fid == -1) {
>> -		dev_err(priv->dev, "Port not part of a bridge\n");
>> +		dev_err(priv->dev,
>> +			"Port %d is not known to be part of bridge\n", port);
>>  		return -EINVAL;
>>  	}
> 
> Actually I would argue this is entirely confusing. There is an earlier
> check:
> 
> 	if (!bridge)
> 		return -EINVAL;
> 
> which did _not_ trigger if we're executing this. So the port _is_ a 
> part
> of a bridge. Just say that no FID is found for bridge %s 
> (bridge->name),
> which technically _is_ what happened.

Yes, you are right. I'll change that.

