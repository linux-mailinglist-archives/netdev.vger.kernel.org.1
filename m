Return-Path: <netdev+bounces-272471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKT8DblMxmmgIAUAu9opvQ
	(envelope-from <netdev+bounces-272471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:24:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A633D341A61
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A22D300AB2F
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4077E3D9049;
	Fri, 27 Mar 2026 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0lh54x5d"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AC2550A4;
	Fri, 27 Mar 2026 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603145; cv=none; b=Zz+EMaTl/UJXHOnIZpyOE9JXuqcA3zKch5CG1gxS17c+sz4icbo9TH4LSt5lY89pnY98ufjcdZrGgk9pZDKByYizBPRzKN3djMe5Yqku9HX59MYb2nuaAHH5n6ydQ5sv0va5EnhxGPDhIHwjMKpMb48FlJPY7iM63sorp7rbHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603145; c=relaxed/simple;
	bh=4CF7PYvt4b6tzesuETgXaTN8/zMrSqA/CNbfVHbyFPg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lZtr2uPwnSBdcBBmjPsAmjP0nESs9MaW/Hv6d4b9iwkiFFSR/LUrVy4cJBfAYp55eqrje7+KO2Z9sf0Q4/0L9PsoetOkrYcw8H8ygzOHIAq0GFa4wa24gWZlSJWIHLFEbBFjQkVyXhv7UVa6fyBlxiIlrf/n7UdbEZZDWMmT9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0lh54x5d; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DB2734E4281F;
	Fri, 27 Mar 2026 09:18:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF3ED60230;
	Fri, 27 Mar 2026 09:18:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE9D310450FD3;
	Fri, 27 Mar 2026 10:18:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774603134; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=afRiRiJMMFy7Uzz8QhNGXPGqsfB8NykKgUsDtwvQvJA=;
	b=0lh54x5dZYtZEiuLmOPcOunnYKr1J5sDUi9Ec2jZytypGRqTVZYY1iQS3biYJmXz+liW8A
	2KSQCgJh+197YlsgIKolXTu8M9JYhs+e+gZ3xHH0uj9dfxQMdGRxMxfkpNw9PTaT74vv/+
	cyCdlmBBXbe61puzuvmV3/D+hChgx7XYoEGS+Uqm3OY9t6p6XiZNYMD63+oPOV+fEFTxRQ
	CuTvrN6bW2KbWzXa9mIxZMmCHzxBs/NTuzdLX1zO/YouyX3GLNTFBcdDNHjGzrzDjse84N
	gvt7U/5c8O43ya27mzZRZHKq2iHyAX4X2Hq/u8eFjH8nBxCEDs8kGrG5Nc2NrA==
Message-ID: <41bafcbf-d88b-41c8-b2a7-b210cc293695@bootlin.com>
Date: Fri, 27 Mar 2026 10:18:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: lan743x: add support for RMII interface
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 Raju.Lakkaraju@microchip.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260327054008.79294-1-thangaraj.s@microchip.com>
 <20260327054008.79294-3-thangaraj.s@microchip.com>
 <72b79059-25e1-4209-a0dc-30dc0c310aff@bootlin.com>
Content-Language: en-US
In-Reply-To: <72b79059-25e1-4209-a0dc-30dc0c310aff@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272471-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: A633D341A61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 27/03/2026 09:47, Maxime Chevallier wrote:
> Hi,
> 
> On 27/03/2026 06:40, Thangaraj Samynathan wrote:
>> Enable RMII interface in the lan743x driver for PHY and MAC
>> configuration.
>>
>> - Select RMII interface in lan743x_phy_interface_select().
>> - Update phylink supported_interfaces and MAC capabilities.
>> - Enable RMII via RMII_CTL in lan743x_hardware_init().
>> - Define RMII_CTL register and enable bit in lan743x_main.h.
>>
>> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
>> ---
>>  drivers/net/ethernet/microchip/lan743x_main.c | 18 ++++++++++++++++++
>>  drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
>> index b7b1584d867d..86d35810460f 100644
>> --- a/drivers/net/ethernet/microchip/lan743x_main.c
>> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
>> @@ -1370,6 +1370,8 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
>>  
>>  	if (adapter->is_pci11x1x && adapter->is_sgmii_en)
>>  		adapter->phy_interface = PHY_INTERFACE_MODE_SGMII;
>> +	else if (adapter->is_pci11x1x && adapter->is_rmii_en)
>> +		adapter->phy_interface = PHY_INTERFACE_MODE_RMII;
>>  	else if (id_rev == ID_REV_ID_LAN7430_)
>>  		adapter->phy_interface = PHY_INTERFACE_MODE_GMII;
>>  	else if ((id_rev == ID_REV_ID_LAN7431_) && (data & MAC_CR_MII_EN_))
>> @@ -3158,6 +3160,13 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
>>  		__set_bit(PHY_INTERFACE_MODE_MII,
>>  			  adapter->phylink_config.supported_interfaces);
>>  		break;
>> +	case PHY_INTERFACE_MODE_RMII:
>> +		__set_bit(PHY_INTERFACE_MODE_RMII,
>> +			  adapter->phylink_config.supported_interfaces);
>> +		adapter->phylink_config.mac_capabilities &= ~MAC_1000FD;
> 
> Some followup should take care of removing the 1000FD cap for MII as
> well.

Well as Russell says, no need for that :)


Maxime

