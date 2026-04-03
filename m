Return-Path: <netdev+bounces-275162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHvsCVQL0GkZ2wYAu9opvQ
	(envelope-from <netdev+bounces-275162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:47:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C433975DA
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 20:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0DF303D30C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4835A391;
	Fri,  3 Apr 2026 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="rLNZUIBF"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EF3368A6;
	Fri,  3 Apr 2026 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242054; cv=none; b=kVRz8LX0poltBcfgo1Jl2paIXGwr3yuwN/tTM3zK7lYWl1vhc83ytDs9l8L5J32DgalJKRJ2v+P37fs6EmlwKXD6g6IgQpwO4cfh2YCAs3ZtQn3Cjh8iqdN4gJvOja1izoHcHmMt/UUNogDdLOTV6bOGvIAxO6J8eTNKhalYDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242054; c=relaxed/simple;
	bh=5BPMK30EdUf6lrcstEuFWW/L/u0KTrVwDcnY4J3PKh8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=mQf+KmGSm81zQEIPrXhOk4OJCRCEBjhIacmStkV+RYmQm9JFJspTpdRSjWcipEo/VbJHfj3mOd3S8N4ls+2bxDXohE28p+9B01CfDuoOFzgMEpM2xQ/LMK9mqOzz0IW/gJCGt/7k515meRwCCPrQ7lui6XyQ6rxpUwPwx+483Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=rLNZUIBF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0AC0A0311;
	Fri,  3 Apr 2026 20:47:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775242044; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CH0yyrQZInUfuLOCxhhnxj/VLPGjptiPMOMcl+uV17Q=;
	b=rLNZUIBFOzrCOxM1V4KGaaInTgEujeIcuq50ffTG6PpJG8p6FDg1q+uUFbpRkGVW6ylnMk
	Fa4Bi3XBRWwP40XM7Ww3vNDVvflSzzAT9b0tSVl99AHKACBP9K93deK90yPg4Q8Gv+L0hp
	yVNkZqgYIDyF1HF3SXKK7sJFkZYWRb3XMDAFbwFPjnEcY234UsMuw1oM90RqUR4tq862Q0
	RonCPzTBASuq/NnQSHB053GL0/VY29jW9HUq45dv/kITWK8eBusuL9a6EYnAcYPWWXywi9
	QoiyiysX/7EvkTyTsLuMPPr/vbyJF/xOsYvqlryng8IhZEyBAHr+XU1O6iazpA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 03 Apr 2026 20:47:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/3] net: phy: add support for disabling
 PHY-autonomous EEE
In-Reply-To: <fcf80c9b-de04-469f-b66b-b39760fc9af4@lunn.ch>
References: <20260403090656.733985-1-nb@tipi-net.de>
 <20260403090656.733985-2-nb@tipi-net.de>
 <fcf80c9b-de04-469f-b66b-b39760fc9af4@lunn.ch>
Message-ID: <7cc447d8fcc2d38a53e614e675746457@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,armlinux.org.uk,broadcom.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[tipi-net.de:?];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275162-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	NEURAL_HAM(-0.00)[-0.670];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[tipi-net.de:s=dkim];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C2C433975DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3.4.2026 17:27, Andrew Lunn wrote:
>> + * @autonomous_eee_disabled: Set when autonomous EEE has been 
>> disabled via
>> + *	phy_support_eee(), used to re-apply after PHY soft reset
> 
> Thinking ahead to when autonomous EEE is supported, there will be
> other reasons to disable it than just phy_support_eee(). So i would
> not say this here.

Makes sense. I will amend all comments accordingly.
> 
>>   * @eee_cfg: User configuration of EEE
>>   * @lp_advertising: Current link partner advertised linkmodes
>>   * @host_interfaces: PHY interface modes supported by host
>> @@ -739,6 +741,7 @@ struct phy_device {
>>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_disabled_modes);
>>  	bool enable_tx_lpi;
>>  	bool eee_active;
>> +	bool autonomous_eee_disabled;
>>  	struct eee_config eee_cfg;
>> 
>>  	/* Host supported PHY interface types. Should be ignored if empty. 
>> */
>> @@ -1359,6 +1362,21 @@ struct phy_driver {
>>  	void (*get_stats)(struct phy_device *dev,
>>  			  struct ethtool_stats *stats, u64 *data);
>> 
>> +	/**
>> +	 * @disable_autonomous_eee: Disable PHY-autonomous EEE
>> +	 *
>> +	 * Some PHYs manage EEE LPI autonomously without forwarding LPI
>> +	 * signaling to the MAC.
> 
> My understanding is that LPI is always from the MAC to the PHY?

Probably not the right wording, agreed. I was thinking of the RX LPI
counter on macb, which wasn't incrementing until I noticed that the PHY
had AutogrEEEn enabled. After disabling it, the RX LPI signaling
worked.
> 
> 
>> +	 * Called by phy_support_eee() when the MAC indicates it supports
>> +	 * EEE. PHY drivers that implement autonomous EEE should provide
>> +	 * this callback.
> 
> Again, there will be other reasons to call this, than just
> phy_support_eee().

Will do.

> 
>     Andrew
> 
> ---
> pw-bot: cr

Thanks for the prompt review

Nicolai

