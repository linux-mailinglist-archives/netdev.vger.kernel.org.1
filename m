Return-Path: <netdev+bounces-101821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40102900325
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222121C22E51
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7092190675;
	Fri,  7 Jun 2024 12:14:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B90913C67B;
	Fri,  7 Jun 2024 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762488; cv=none; b=tukFX/WzSK27oB8kGrjTc9x5hBXoPXf64d7uX54bwUZTFe4C6mb9e5JgeaZKoY1xm4x3evcvyMcxZCBio9OU0Jg4tOj/vTHp+Y9Ctpuj3w25srXqPbO+hJsN0crwtGdvkdFCpexsbhjc718mUwhIwOWO3nL5YJ81ahKb0zMMA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762488; c=relaxed/simple;
	bh=rBD/3nCmF1QYjRKRLiSkFwgr2koq+gPST/UnCrH/FVA=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=f+0/XcLF668vfr73Ei/DxIIIB/1XjJROmBu1albUQ5y5TpRJ8//0YaJMpwco8mBruEE5xgmeDtrnbxgyu8jr3noFklv+tAkGCXoGNFlXAE09G1ic64GsVBZOp1Aw9q43/ZtQbb06Wu3dFd9N1zKXpTkOwVkAUCNJX4ZjfJtUYN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=990276a841=ms@dev.tdt.de>)
	id 1sFYUW-007Ysq-Mf; Fri, 07 Jun 2024 14:14:44 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1sFYUW-00DoVi-5M; Fri, 07 Jun 2024 14:14:44 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id D4981240053;
	Fri,  7 Jun 2024 14:14:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 6088F240050;
	Fri,  7 Jun 2024 14:14:43 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id E9DDF3829D;
	Fri,  7 Jun 2024 14:14:42 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jun 2024 14:14:42 +0200
From: Martin Schiller <ms@dev.tdt.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
 f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/13] net: dsa: lantiq_gswip: do also enable or
 disable cpu port
Organization: TDT AG
In-Reply-To: <20240607111830.jfi3roiry27bmwih@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-6-ms@dev.tdt.de>
 <20240607111830.jfi3roiry27bmwih@skbuf>
Message-ID: <449164b18beb18c1dfe2c356ba6af583@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1717762484-AA85434D-581F8BBD/0/0
X-purgate-type: clean
X-purgate: clean

On 2024-06-07 13:18, Vladimir Oltean wrote:
> On Thu, Jun 06, 2024 at 10:52:26AM +0200, Martin Schiller wrote:
>> Before commit 74be4babe72f ("net: dsa: do not enable or disable non 
>> user
>> ports"), gswip_port_enable/disable() were also executed for the cpu 
>> port
>> in gswip_setup() which disabled the cpu port during initialization.
> 
> Ah, you also noticed this.
> 
>> 
>> Let's restore this by removing the dsa_is_user_port checks. Also, 
>> let's
>> clean up the gswip_port_enable() function so that we only have to 
>> check
>> for the cpu port once.
>> 
>> Fixes: 74be4babe72f ("net: dsa: do not enable or disable non user 
>> ports")
> 
> Fixes tags shouldn't be taken lightly. If you think there's a 
> functional
> user-visible problem caused by that change, you need to explain what
> that problem is and what it affects. Additionally, bug fix patches are
> sent out to the 'net' tree, not bundled up with 'net-next' material
> (unless they fix a change that's also exclusive to net-next).
> Otherwise, just drop the 'Fixes' tag.

OK, I will drop the 'Fixes' tag.

> 
>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
>> ---
>>  drivers/net/dsa/lantiq_gswip.c | 24 ++++++++----------------
>>  1 file changed, 8 insertions(+), 16 deletions(-)
>> 
>> diff --git a/drivers/net/dsa/lantiq_gswip.c 
>> b/drivers/net/dsa/lantiq_gswip.c
>> index 3fd5599fca52..38b5f743e5ee 100644
>> --- a/drivers/net/dsa/lantiq_gswip.c
>> +++ b/drivers/net/dsa/lantiq_gswip.c
>> @@ -695,13 +695,18 @@ static int gswip_port_enable(struct dsa_switch 
>> *ds, int port,
>>  	struct gswip_priv *priv = ds->priv;
>>  	int err;
>> 
>> -	if (!dsa_is_user_port(ds, port))
>> -		return 0;
>> -
>>  	if (!dsa_is_cpu_port(ds, port)) {
>> +		u32 mdio_phy = 0;
>> +
>>  		err = gswip_add_single_port_br(priv, port, true);
>>  		if (err)
>>  			return err;
>> +
>> +		if (phydev)
>> +			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
>> +
>> +		gswip_mdio_mask(priv, GSWIP_MDIO_PHY_ADDR_MASK, mdio_phy,
>> +				GSWIP_MDIO_PHYp(port));
>>  	}
>> 
>>  	/* RMON Counter Enable for port */
>> @@ -714,16 +719,6 @@ static int gswip_port_enable(struct dsa_switch 
>> *ds, int port,
>>  	gswip_switch_mask(priv, 0, GSWIP_SDMA_PCTRL_EN,
>>  			  GSWIP_SDMA_PCTRLp(port));
>> 
>> -	if (!dsa_is_cpu_port(ds, port)) {
>> -		u32 mdio_phy = 0;
>> -
>> -		if (phydev)
>> -			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
>> -
>> -		gswip_mdio_mask(priv, GSWIP_MDIO_PHY_ADDR_MASK, mdio_phy,
>> -				GSWIP_MDIO_PHYp(port));
>> -	}
>> -
>>  	return 0;
>>  }
> 
> It would be good to state in the commit message that the operation
> reordering is safe. The commit seems to be concerned mainly with code
> cleanliness, which does not always take side effects into account.

Thanks for the hint. I will take it into account in the commit message.

