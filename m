Return-Path: <netdev+bounces-101818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC48900309
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6321E1F22FAB
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D3A187324;
	Fri,  7 Jun 2024 12:09:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2351847;
	Fri,  7 Jun 2024 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762167; cv=none; b=kGVIeBGpeJZbmv71qswFjD1sbsbS65bgXt+jdVtB3NpKQ353txUuaJkmxmyBL1AK6f0dVY9OHCX1otXmNWw8tPApBVJ3rwnNpO9PjQzcD5RGEzzUtxuNltLHBt2epeA6g4R32TDB42oYJgm9VJMm3w+wSkmAa7vv3PjKIBE5U0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762167; c=relaxed/simple;
	bh=gwKwTD1WKix0cop8Lpfa38D2U/BH7EMvYjh2D2pY+1g=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=YWvWC0+i4Cgna+bDaYuMGzimD+0iOanBmLuLe9eP+FWdJuuOIZgU6oPj9UM9cpT2tpRyufdYCP2loQDd3J0c0ZLRgVNFUh6cYJkpxk+BwpZJFj6AxqeHcaT1ED0Z8rDZ8h1BU9h/EVv6ABP0y7c0xJXGbc8JYy5TwqhrgeMrgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFYPD-00F0Vb-S9; Fri, 07 Jun 2024 14:09:15 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFYPC-005Nrm-W0; Fri, 07 Jun 2024 14:09:15 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id A5A7C240053;
	Fri,  7 Jun 2024 14:09:14 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 35689240050;
	Fri,  7 Jun 2024 14:09:14 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id E10A43829D;
	Fri,  7 Jun 2024 14:09:13 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 14:09:13 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 03/13] net: dsa: lantiq_gswip: Use dev_err_probe
 where appropriate
Organization: TDT AG
In-Reply-To: <20240607110747.zsiahnzge2bvxd4l@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-4-ms@dev.tdt.de>
 <20240606085234.565551-4-ms@dev.tdt.de>
 <20240607110747.zsiahnzge2bvxd4l@skbuf>
Message-ID: <9a9ca4e015446b9a0f76fa3d5e6e9f0b@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1717762155-91E7E642-919E136F/0/0
X-purgate: clean
X-purgate-type: clean

On 2024-06-07 13:07, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 10:52:24AM +0200, Martin Schiller wrote:
>> @@ -2050,8 +2048,9 @@ static int gswip_gphy_fw_list(struct gswip_priv 
>> *priv,
>>  			priv->gphy_fw_name_cfg = &xrx200a2x_gphy_data;
>>  			break;
>>  		default:
>> -			dev_err(dev, "unknown GSWIP version: 0x%x", version);
>> -			return -ENOENT;
>> +			return dev_err_probe(dev, -ENOENT,
>> +					     "unknown GSWIP version: 0x%x",
>> +					     version);
>>  		}
>>  	}
>> 
>> @@ -2059,10 +2058,9 @@ static int gswip_gphy_fw_list(struct gswip_priv 
>> *priv,
>>  	if (match && match->data)
>>  		priv->gphy_fw_name_cfg = match->data;
>> 
>> -	if (!priv->gphy_fw_name_cfg) {
>> -		dev_err(dev, "GPHY compatible type not supported");
>> -		return -ENOENT;
>> -	}
>> +	if (!priv->gphy_fw_name_cfg)
>> +		return dev_err_probe(dev, -ENOENT,
>> +				     "GPHY compatible type not supported");
>> 
>>  	priv->num_gphy_fw = of_get_available_child_count(gphy_fw_list_np);
>>  	if (!priv->num_gphy_fw)
>> @@ -2163,8 +2161,8 @@ static int gswip_probe(struct platform_device 
>> *pdev)
>>  			return -EINVAL;
>>  		break;
>>  	default:
>> -		dev_err(dev, "unknown GSWIP version: 0x%x", version);
>> -		return -ENOENT;
>> +		return dev_err_probe(dev, -ENOENT,
>> +				     "unknown GSWIP version: 0x%x", version);
>>  	}
>> 
>>  	/* bring up the mdio bus */
>> @@ -2172,28 +2170,27 @@ static int gswip_probe(struct platform_device 
>> *pdev)
>>  	if (!dsa_is_cpu_port(priv->ds, priv->hw_info->cpu_port)) {
>> -		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
>> -			priv->hw_info->cpu_port);
>> -		err = -EINVAL;
>> +		err = dev_err_probe(dev, -EINVAL,
>> +				    "wrong CPU port defined, HW only supports port: %i",
>> +				    priv->hw_info->cpu_port);
>>  		goto disable_switch;
>>  	}
> 
> Nitpick: there is no terminating \n here.

Oh, thanks for the hint. I'll correct that (and also check the complete 
source
file for that kind of mistakes).

