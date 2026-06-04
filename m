Return-Path: <netdev+bounces-295070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LMr4BawqIWrv/wAAu9opvQ
	(envelope-from <netdev+bounces-295070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:35:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A28E63DA8A
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:35:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=OnGzAOeU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295070-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295070-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B7223038B9F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 07:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673813C4561;
	Thu,  4 Jun 2026 07:28:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1039DBCC
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 07:28:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558095; cv=none; b=uowTar39YWYEyl1DFZ2lDQUu8mYYe6QCDZ4bbHxeXIoqvG6MdDEFE7Sgubss40JXGpsVv+HZrIj3uYwuJ0QqQXow/s/J1kMkWx+C7n5apHDd6G1VCp26/jKQv/CmMayXopqftFvY9NG/0/qywGdbyFPY8KehZK2UXIl2UdrJmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558095; c=relaxed/simple;
	bh=OQ2CY/I0RuEA9zQmRMG9+3p2eLTqmrVvYmFTN9Bnbbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTps2YyHV10LqgoElMetmjc+uukxDBLGHlL7/H+hE8/VL47VpYcp6L5FasAV06IiCoDeeY+MG80ByZTtepcel1k/rQZGnPEnbryGGdamgO7r7xXCKn7zmcw8R+LtjV4+aZpP1PDOt/tZjVl131/x+E6Ocdx1v8ACsTXc329VvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OnGzAOeU; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ADCD11A058A;
	Thu,  4 Jun 2026 07:28:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 81A8D5FEF7;
	Thu,  4 Jun 2026 07:28:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DD2E106A1767;
	Thu,  4 Jun 2026 09:28:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780558091; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=z+NfAZ+z731qUJUIS44wvo1vE8Ea95Oiw6x09RDCHYA=;
	b=OnGzAOeUiUy7biv3gzeHPnFEeJIJu6BYie5ooL/HZiyD4GdGMA5E8p81vnwhlLwYoATmIm
	P0yTD6a24LVpP/ikkDMCFFGFsvIvGJq7Jrd/+S+6pgbuIa+mLbMuSKClkqjNvMkoQZO7xe
	TgLzAEt6k8pLr3h4ZjBobn4TGGNXMb55cR6iQevZp6Vv9OG/U8EuJ6JBXWH0tpdq8kCcsb
	AsdLynXBa3R+NQhqsQYUTQgymcrAQiY3deMfH7pVKBLJnRuvkMCC/WVWshrc9SMDcEfYe+
	4KV66dglT/bs8tkE4thF1O8m3WtjCbgxRRUH5bwUTitSXysZX3PgtN8Ne5iubw==
Message-ID: <82b0be82-5b1b-4204-8a93-a2a3d06af9c2@bootlin.com>
Date: Thu, 4 Jun 2026 09:28:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] net: phy: don't try to setup PHY-driven SFP
 cages when using genphy
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20260601084029.815461-4-maxime.chevallier@bootlin.com>
 <20260604022729.2925198-2-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260604022729.2925198-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com];
	TAGGED_FROM(0.00)[bounces-295070-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:from_mime,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A28E63DA8A



On 6/4/26 04:27, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: phy: don't try to setup PHY-driven SFP cages when using genphy
> 
> This change skips phy_sfp_probe() when the genphy driver is bound,
> avoiding an RTNL deadlock in sfp_bus_add_upstream() since genphy
> binding runs under RTNL while non-genphy driver binding does not.
> 
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index a171cbe2a74a..8eace58e9f12 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -3512,9 +3512,14 @@ static int phy_setup_ports(struct phy_device *phydev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	ret = phy_sfp_probe(phydev);
>> -	if (ret)
>> -		goto out;
>> +	/* We don't support SFP with genphy drivers. Also, genphy driver binding
>> +	 * occurs with RTNL help, wich will deadlock the sfp_bus_add_upstream().
>                           ^^^^
> 
> [Low]
> There is a typo in the new comment, "wich" should be "which".

Sure thing, I need to respin anyway, let me fix this :)

Maxime

> 
>> +	 */
>> +	if (!phydev->is_genphy_driven) {
>> +		ret = phy_sfp_probe(phydev);
>> +		if (ret)
>> +			goto out;
>> +	}
>>  
>>  	if (phydev->n_ports < phydev->max_n_ports) {
>>  		ret = phy_default_setup_single_port(phydev);


