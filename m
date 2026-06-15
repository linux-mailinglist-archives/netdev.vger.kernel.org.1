Return-Path: <netdev+bounces-299458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c2gaG7r+L2rrLQUAu9opvQ
	(envelope-from <netdev+bounces-299458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:31:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB05C686C37
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 15:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=DQHVEXjM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299458-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299458-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E68F9300CFF5
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19E3F1678;
	Mon, 15 Jun 2026 13:31:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019B3128AB;
	Mon, 15 Jun 2026 13:31:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781530295; cv=none; b=JqFXBnNhfRQdncqmYa4SjL9RwNbXMlehrLJuqydj2h+BKQxHOuWh8H37NL7AlBEXXHP0L4YUSr+q/M4ImbZFdCjMz/wBCDEBiDVHtVm8R2gO5jt26PN7w5NgrH3DN1KFKcU+VUQx3AUBbkDlOzcjMxLoJFuFIvjuyKPu3noDXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781530295; c=relaxed/simple;
	bh=vxGw+J6MkVQiW1g+xovzopOXnMIewQeQRSZQMf+b2JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tvgu68UEiSxjr7EqHqeh9gLt61ONeB8jEuxT3G7J2FWG+m8W/CvQbEc40Ho7YQqHnx7e8kRqVjeyevMbSpx6FMEir/NjgQKa1BEyBRg7KXA7xQliIhgmyVT8m6igHzaoJWQ0gCnVxQTONMuCimzjwRe4V7gyAjkWuRt/vgb5a0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DQHVEXjM; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A230E1A37CE;
	Mon, 15 Jun 2026 13:31:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67AD660015;
	Mon, 15 Jun 2026 13:31:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3D57106C94F2;
	Mon, 15 Jun 2026 15:31:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781530290; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AztGQmlWKqiomMfQy7VwV1LA90NR9R4FU4YZ8MZTWBc=;
	b=DQHVEXjMGNQkj6OzgBLI7rDFOF/FNM88+41WUUHPg+BrpSxpFT/14EES1zC3zgPtRppV60
	O/iPBXU1sjhMFIr08FKA2puoS7HgC/bWwTXrmDzUaK3SFJ7tECgzgjpg+p+hGU3l+iTm2z
	zgXUvvlFaH/R7/vmVhczsdW4ctDr6SPdHLCYBxty/3ZOB3ezGRLdk2JSR2hYx3L9bje1hf
	tw/7W857gReWfemIRnofdh0QdG7+BjBOnIpc9ZpisndoW3pcIZk0PjYmEBYOqyQSvQSyqk
	5SpkK1Ff3Z4+YOJBS56jp8YaE91zYpo2Bd/AFirKKZd/rvWYqKTzYd3ur43wtg==
Message-ID: <3bbacda3-4225-4536-a4b4-3aa31a47a3aa@bootlin.com>
Date: Mon, 15 Jun 2026 15:31:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 02/12] net: phylink: introduce internal
 phylink PCS handling
To: Christian Marangi <ansuelsmth@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 llvm@lists.linux.dev
References: <20260615122950.22281-1-ansuelsmth@gmail.com>
 <20260615122950.22281-3-ansuelsmth@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260615122950.22281-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299458-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ansuelsmth@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:lorenzo@kernel.org,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:p.zabel@pengutronix.de,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:llvm@lists.linux.dev,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,armlinux.org.uk,pengutronix.de,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB05C686C37

Hi Christian,

On 6/15/26 14:29, Christian Marangi wrote:
> Introduce internal handling of PCS for phylink. This is an alternative
> way to .mac_select_pcs that moves the selection logic of the PCS entirely
> to phylink with the usage of the supported_interface value in the PCS
> struct.
> 
> MAC should now provide a callback to fill the available PCS in
> phylink_config in .fill_available_pcs and fill the .num_possible_pcs with
> the number of elements in the array. MAC should also define a new bitmap,
> pcs_interfaces, in phylink_config to define for what interface mode a
> dedicated PCS is required.
> 
> On phylink_create(), an array of PCS pointer is allocated of size
> .num_possible_pcs from phylink_config and .fill_available_pcs from
> phylink_config is called passing as args the just allocated array and
> the number of possible element in it.
> 
> MAC will fill this passed array with all the available PCS.
> 
> This array is then parsed and a linked list of PCS is created based on
> the allocated PCS array filled by MAC via .fill_available_pcs().
> 
> Every PCS in phylink PCS list gets then linked to the phylink instance
> by setting the phylink value in phylink_pcs struct to the phylink instance.
> Also the supported_interface value in phylink struct is updated with
> the new supported_interface from the provided PCS.
> 
> On phylink_destroy(), every PCS in phylink PCS list is unlinked from the
> phylink instance by setting the phylink value in phylink_pcs struct to NULL
> and removed from the PCS list.
> 
> phylink_validate_mac_and_pcs(), phylink_major_config() and
> phylink_inband_caps() are updated to support this new implementation
> with the PCS list stored in phylink.
> 
> They will make use of phylink_validate_pcs_interface() that will loop
> for every PCS in the phylink PCS available list and find one that supports
> the passed interface.
> 
> phylink_validate_pcs_interface() applies the same logic of .mac_select_pcs
> where if a supported_interface value is not set for the PCS struct, then
> it's assumed every interface is supported.
> 
> A MAC is required to implement either a .mac_select_pcs or make use of
> the PCS list implementation. Implementing both will result in a fail
> on phylink_create().
> 
> A MAC defining .num_possible_pcs in phylink_config MUST also define a
> .fill_available_pcs or phylink_create() will fail with an negative error.
> 
> phylink value in phylink_pcs struct with this implementation is used to
> track from PCS side when it's attached to a phylink instance. PCS driver
> will make use of this information to correctly detach from a phylink
> instance if needed.
> 
> phylink_pcs_change() is also changed to verify that the PCS that triggered
> a link change is the one that is currently used by the phylink instance.
> 
> The .mac_select_pcs implementation is not changed but it's expected that
> every MAC driver migrates to the new implementation to later deprecate
> and remove .mac_select_pcs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

[...]

> @@ -1872,10 +1993,28 @@ struct phylink *phylink_create(struct phylink_config *config,
>  	mutex_init(&pl->phydev_mutex);
>  	mutex_init(&pl->state_mutex);
>  	INIT_WORK(&pl->resolve, phylink_resolve);
> +	INIT_LIST_HEAD(&pl->pcs_list);
> +
> +	/* Fill the PCS list with available PCS from phylink config */
> +	ret = phylink_fill_available_pcs(pl, config);
> +	if (ret < 0) {
> +		kfree(pl);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* Link available PCS to phylink */
> +	list_for_each_entry(pcs, &pl->pcs_list, list)
> +		pcs->phylink = pl;
>  
>  	phy_interface_copy(pl->supported_interfaces,
>  			   config->supported_interfaces);
>  
> +	/* Update supported interfaces */
> +	list_for_each_entry(pcs, &pl->pcs_list, list)
> +		phy_interface_or(pl->supported_interfaces,
> +				 pl->supported_interfaces,
> +				 pcs->supported_interfaces);
> +

I'm not entirely sure about that, we may need to restrict the supported_interfaces
from the MAC.

As an example, take mvpp2. We have 2 PCSs, one for BaseX/SGMII, one for BaseR. But
if we don't have a comphy (generic PHY) device, then we can't use all the
combination of modes our PCSs can provide :

https://elixir.bootlin.com/linux/v7.1-rc7/source/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c#L7074

These aren't external PCS IPs, but from what I understand you'd like to
handle these the same way as purely external PCSs, right ?

I'd say the MAC driver utltimately has the knowledge of all possible interfaces.

The way I see it, it's probably safer to let the MAC give a wide range of interfaces,
and filter that down with what the PCSs can provide (i.e. turn that or into an and,
while handling the case where the pcs supported interfaces is empty).

What do you think ?

Maxime

