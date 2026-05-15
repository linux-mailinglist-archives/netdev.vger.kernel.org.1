Return-Path: <netdev+bounces-288216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNXrFNvQBmqKoAIAu9opvQ
	(envelope-from <netdev+bounces-288216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:52:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A561A54AD55
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8650C302D115
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2FE3F54B9;
	Fri, 15 May 2026 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BMXDL2Vi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8BD3F54A1
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778831426; cv=none; b=HpWoWkaAl90nKnIkj9Y5BPVKYvq9zwYT/NLstutN9wq7xiURa+41mG+St+1TSf6TAzdDA5qjB1T9X5Xi0jyLy9WpK5hz4u3hEInfZ6vtn1bzVRwbAsK5h0OpDYLVBOg05eAmqCLqvAJ+CkgSwWnr5MqeZI6rE7UfjRM3/kOKOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778831426; c=relaxed/simple;
	bh=PENMvWMvNACL7RAFZtBK6domS7ADeuBRSFkjDQB8gnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qa6opgLRKiBriA40ebuhrg8scNYaf59pL6aTyuipkLhwgJ8UFNCQ1602g/NUcM+eErR1sEj7oeQvO2oc41aqBeWM2qWS+aVpS7I7ZvSkWBCr5L4BIPAdeQZfCXKEArlawVEM35tQOKY0oc6jAeXyyIJqod+/v8LEDlkv91Cprqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BMXDL2Vi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A3DE84E42CAC;
	Fri, 15 May 2026 07:50:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6EDB1606FD;
	Fri, 15 May 2026 07:50:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50F0811AF8528;
	Fri, 15 May 2026 09:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778831417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BSP30ygM+2/LxhRL2CvomgSUsHTxg8hPXBeS5QdMJVM=;
	b=BMXDL2Virb7K5qQaFVit34KGHcYDVSRu7PEV1qZ82XMOBfPhKG75gGRIU72XbxzSiZHyZN
	GaGsfF/6DgG4hvkKfc2H9NsghlU59oNKjN+PnjexMHBL8k1kt8fmFrhSbWR6St7R30zLUW
	ISDqM4MRLnLHK3R9YpIbIkr/Ll/NDIF5xaE+oGLjdNQ7hsVHrcr/p4pMoe1j0nNo8hgx6m
	6Dk8DEV4InXyqXU9poKXehelsSGYpnOhzC8sMOM4k7cDhN3gMEe9oNsPXCmrOsZoO7F1bm
	Nxb6hHAMByhzqqKZ8M5gR4iAWyzXYJvy7hUBVvtsmThcJOZCiMhY5KDnvT4VhA==
Message-ID: <7e173325-0391-45af-a4c4-45bba216b637@bootlin.com>
Date: Fri, 15 May 2026 09:50:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/15] net: dsa: microchip: bypass dev_ops for
 port_setup()
To: Jakub Kicinski <kuba@kernel.org>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, richardcochran@gmail.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, tristram.ha@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260512-clean-ksz-2nd-series-v1-13-c00f6ce037fa@bootlin.com>
 <20260515011513.1270901-1-kuba@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20260515011513.1270901-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: A561A54AD55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,se.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288216-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Hi,

On 5/15/26 3:15 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: dsa: microchip: bypass dev_ops for port_setup()
> 
> This commit removes an indirection layer for KSZ switches by connecting
> the port_setup operations directly to dsa_switch_ops, bypassing the
> ksz_dev_ops callback mechanism.
> 
>> diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
>> index 7385aa4e788a1..2f63a3a7d6ceb 100644
>> --- a/drivers/net/dsa/microchip/ksz9477.c
>> +++ b/drivers/net/dsa/microchip/ksz9477.c
> [ ... ]
>> @@ -1309,6 +1309,23 @@ static void ksz9477_port_setup(struct ksz_device *dev, int port, bool cpu_port)
>>   	ksz_pwrite8(dev, port, regs[REG_PORT_PME_CTRL], 0);
>>   }
>>   
>> +int ksz9477_dsa_port_setup(struct dsa_switch *ds, int port)
>> +{
>> +	struct ksz_device *dev = ds->priv;
>> +	int ret;
>> +
>> +	if (!dsa_is_user_port(ds, port))
>> +		return 0;
>> +
>> +	ksz9477_port_setup(dev, port, false);
>> +
>> +	ret = ksz9477_set_default_prio_queue_mapping(dev, port);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return ksz_dcb_init_port(dev, port);
>> +};
> 
> This isn't a bug, but there's a stray semicolon at the end of the function definition.
> 

Good catch.

> [ ... ]
>> diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
>> index ecb072cd99819..aff0c2735c307 100644
>> --- a/drivers/net/dsa/microchip/lan937x_main.c
>> +++ b/drivers/net/dsa/microchip/lan937x_main.c
> [ ... ]
>> @@ -823,7 +822,7 @@ const struct dsa_switch_ops lan937x_switch_ops = {
>>   	.phy_read		= ksz_phy_read16,
>>   	.phy_write		= ksz_phy_write16,
>>   	.phylink_get_caps	= lan937x_phylink_get_caps,
>> -	.port_setup		= ksz_port_setup,
>> +	.port_setup		= ksz9477_dsa_port_setup,
> 
> Is it intentional to use ksz9477_dsa_port_setup() for LAN937x switches here?
> 
> Previously, the shared ksz_port_setup() dynamically dispatched the
> initialization via dev->dev_ops->port_setup(), which correctly resolved to
> lan937x_port_setup() for LAN937x devices.
> 
> Since the new ksz9477_dsa_port_setup() function explicitly hardcodes a call
> to ksz9477_port_setup(), won't this cause LAN937x ports to skip their
> specific initialization logic and instead receive incorrect register
> configurations meant for KSZ9477 hardware?

True, I'll fix this in next iteration


Best regards,
Bastien


