Return-Path: <netdev+bounces-294187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ATzGHurJHmqKVAAAu9opvQ
	(envelope-from <netdev+bounces-294187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:17:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300CE62DED3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:17:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=o5LXz3FW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294187-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294187-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4869E30090AA
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617003E6389;
	Tue,  2 Jun 2026 12:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69963DFC62;
	Tue,  2 Jun 2026 12:15:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780402512; cv=none; b=NkU5mQw9/bIA16jSmNsMHSsQIeo+n9TEmyCWffvq94///HL+mj5Pog8dY7D43cpeoAt7FoLOqifE9Yqw7xZg46q+bIMI2wlD1Z1JbW6BYtDLTIhA7D4v5VROIXN5f6pFoISpqknViltJ73IDMXOPGS79e/yopoPvFiwU7TLNGTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780402512; c=relaxed/simple;
	bh=6KF++XzefhueQyLOPn3gJeJCmRPm99sYnZ3vgRDEz5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjgJRYxlwaSa4Thvs9LEp4CTqQAYIgtBvOWU9yMFWngtOZwXS2R695/TZvvBIAjwGJEq+nZK+7UM/25xxqr7tQmkzAMOfrw07r+3xdG6lD2O6WS+Kw8+cgWoXW6iaDu8AaZ6pufoxnzM+l+7JsPWKU0fcknHJ7yU2RMPfDZwVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o5LXz3FW; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6D9B41A37CD;
	Tue,  2 Jun 2026 12:15:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 375D2603BC;
	Tue,  2 Jun 2026 12:15:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6F8A10888429;
	Tue,  2 Jun 2026 14:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780402506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=C5QfWp41cPYkzLFw+jr79Kx6dVzy6kB4KelAVlv/xac=;
	b=o5LXz3FWEsEm48oeSYmEpLIQA+atNh2jcFF3uKTPayjZvMH48SRTYBzHjlU5Svwx2yqLci
	VdiSJz4xdLwuQ/QBr6jMUtGNBVYbBaTqkw0U7xHlypI8/CMWAfoj3U8iNGmx4/Z0kqUZMM
	W89tR30zU1fmx4tLnbzmQ8eD42cwACj2BJEMKPwYtJ3mSdoD1D+AE9l8PbBu9jz6juu1GC
	1wK7YpEiYa6Yh7jzh/UU2MZM3Y834tnHSI/xilHW2tlmVuke79jy4f1Tzle0bLKoduxtuw
	GAHPQjkSZxWJBaJjCQ/iVyH/jvjgYPQYSYgl/2Mn6pcTHWSsNCCd0X3QyRAgfQ==
Message-ID: <be45fc3c-7599-4d07-8268-6e50b554946c@bootlin.com>
Date: Tue, 2 Jun 2026 14:15:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/9] net: dsa: microchip: remove
 setup_rgmii_delay() KSZ operation
To: Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com>
 <20260526-clean-ksz-3rd-v1-4-5b63e732149a@bootlin.com>
 <27937ce7-ec1c-4aab-9061-cedcf4f89d12@redhat.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <27937ce7-ec1c-4aab-9061-cedcf4f89d12@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294187-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,bootlin.com:from_mime,bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 300CE62DED3

Hi Paolo,

On 6/1/26 10:49 AM, Paolo Abeni wrote:
> On 5/26/26 11:47 AM, Bastien Curutchet (Schneider Electric) wrote:
>> setup_rgmii_delay() operation is only used once during the common phylink
>> MAC configuration. Only the lan937x switch implements this
>> setup_rgmii_delay().
>>
>> Remove the setup_rgmii_delay operation from ksz_dev_ops.
>> Implement a lan937x-specific phylink MAC configuration that does this
>> RGMII delay setup.
>> Export ksz_set_xmii since it's needed by the lan937x implementation.
>>
>> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
>> ---
>>   drivers/net/dsa/microchip/ksz_common.c   |  6 +-----
>>   drivers/net/dsa/microchip/ksz_common.h   |  2 +-
>>   drivers/net/dsa/microchip/lan937x_main.c | 29 +++++++++++++++++++++++++++--
>>   3 files changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
>> index 5fb151fbf4f3..d6511fcebcf2 100644
>> --- a/drivers/net/dsa/microchip/ksz_common.c
>> +++ b/drivers/net/dsa/microchip/ksz_common.c
>> @@ -3127,8 +3127,7 @@ int ksz_set_mac_eee(struct dsa_switch *ds, int port,
>>   	return 0;
>>   }
>>   
>> -static void ksz_set_xmii(struct ksz_device *dev, int port,
>> -			 phy_interface_t interface)
>> +void ksz_set_xmii(struct ksz_device *dev, int port, phy_interface_t interface)
>>   {
>>   	const u8 *bitval = dev->info->xmii_ctrl1;
>>   	struct ksz_port *p = &dev->ports[port];
>> @@ -3233,9 +3232,6 @@ void ksz_phylink_mac_config(struct phylink_config *config,
>>   	}
>>   
>>   	ksz_set_xmii(dev, port, state->interface);
>> -
>> -	if (dev->dev_ops->setup_rgmii_delay)
>> -		dev->dev_ops->setup_rgmii_delay(dev, port);
>>   }
>>   
>>   bool ksz_get_gbit(struct ksz_device *dev, int port)
>> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
>> index 804912fdd2db..ab08c98ed257 100644
>> --- a/drivers/net/dsa/microchip/ksz_common.h
>> +++ b/drivers/net/dsa/microchip/ksz_common.h
>> @@ -410,7 +410,6 @@ struct ksz_dev_ops {
>>   			   u8 data);
>>   	void (*freeze_mib)(struct ksz_device *dev, int port, bool freeze);
>>   	void (*port_init_cnt)(struct ksz_device *dev, int port);
>> -	void (*setup_rgmii_delay)(struct ksz_device *dev, int port);
>>   	int (*tc_cbs_set_cinc)(struct ksz_device *dev, int port, u32 val);
>>   	int (*init)(struct ksz_device *dev);
>>   };
>> @@ -468,6 +467,7 @@ void ksz_phylink_get_caps(struct dsa_switch *ds, int port,
>>   void ksz_phylink_mac_disable_tx_lpi(struct phylink_config *config);
>>   int ksz_phylink_mac_enable_tx_lpi(struct phylink_config *config,
>>   				  u32 timer, bool tx_clock_stop);
>> +void ksz_set_xmii(struct ksz_device *dev, int port, phy_interface_t interface);
>>   void ksz_phylink_mac_config(struct phylink_config *config,
>>   			    unsigned int mode,
>>   			    const struct phylink_link_state *state);
>> diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
>> index 57e289637193..f8f220242f7a 100644
>> --- a/drivers/net/dsa/microchip/lan937x_main.c
>> +++ b/drivers/net/dsa/microchip/lan937x_main.c
>> @@ -643,6 +643,32 @@ static void lan937x_setup_rgmii_delay(struct ksz_device *dev, int port)
>>   	}
>>   }
>>   
>> +static void lan937x_phylink_mac_config(struct phylink_config *config,
>> +				       unsigned int mode,
>> +				       const struct phylink_link_state *state)
>> +{
>> +	struct dsa_port *dp = dsa_phylink_to_port(config);
>> +	struct ksz_device *dev = dp->ds->priv;
>> +	int port = dp->index;
>> +
>> +	/* Internal PHYs */
>> +	if (dev->info->internal_phy[port])
>> +		return;
>> +
>> +	/* No need to configure XMII control register when using SGMII. */
>> +	if (ksz_is_sgmii_port(dev, port))
>> +		return;
>> +
>> +	if (phylink_autoneg_inband(mode)) {
>> +		dev_err(dev->dev, "In-band AN not supported!\n");
>> +		return;
>> +	}
>> +
>> +	ksz_set_xmii(dev, port, state->interface);
>> +
>> +	lan937x_setup_rgmii_delay(dev, port);
> 
> I think you can avoid some code duplication with something alike the
> following:
> 
> - factor out of ksz_phylink_mac_config() a  __ksz_phylink_mac_config(),
> helper, with the latter doing all the work and returning true when
> actually calling ksz_set_xmii()
> 
> - implement lan937x_phylink_mac_config() on top of
> __ksz_phylink_mac_config():
> 
> 	if (__ksz_phylink_mac_config())
> 		lan937x_setup_rgmii_delay(dev, port);
> 

Indeed, I'll do it in next iteration, thank you.


Best regards,
Bastien

