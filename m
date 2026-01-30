Return-Path: <netdev+bounces-255149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOWNCIS0fGm7OQIAu9opvQ
	(envelope-from <netdev+bounces-255149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:39:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F702BB352
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 14:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8603003338
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAE32EA16C;
	Fri, 30 Jan 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XcXUIUNC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D01155757
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769780186; cv=none; b=IssJzt6DT7XDkh7qhQ99P6g214/2xnmDQLp0BVsDvXBHEx+qfPSKgbPlj8Luu3q0axvpn2K6I4tdk3tW7BuUmm8qLy7jZAqww3KLFPdKec05QBFGXwn6cviaPouFcInoySI/pj75xCixJjmzqeiMyKwgbl04W7oNsUSFAHsh+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769780186; c=relaxed/simple;
	bh=fPfC3d3Zxx+RhTICVIvrYBWckYaYM0qOks46HcJDVBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LshGfu/NdPNUl104TmFB7P36PVHryLPJbgXExq93tOp+LS5PPXISLpsytL9fY8o+cLcE+ZL/i4iHtbhBt7aQOMRneT0YzrRG8OEQFUYmzbJmaHCrM1Uc8PlaIMBcuYKkXalQAjRSoC2oC/Eu4rhhQ5E++NVUwf3eRmy8v260PIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XcXUIUNC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 223701A2B3A;
	Fri, 30 Jan 2026 13:36:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4C1F6075A;
	Fri, 30 Jan 2026 13:36:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E9FA119A885C;
	Fri, 30 Jan 2026 14:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769780181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=9AkBeD0/m2/gh93dclxVIucwTWWcVXPrPD9ERp3+UDc=;
	b=XcXUIUNCjMh65rwQ8+RGYbMzPZPJq1pFiKoTZEhCjSyIG20b63vtlHafpLLDDCHEbipywO
	QO0Urqiv6cLjTAaMsI6CmXh71KfI2u/b4SP5yjTBnXgaJXXA0mqSN5is12OuNw2j+TrpvK
	kAI3cRBhZPM9kSuTg33DfmKxYkLuAPN7PbUXbXmqZyEUqPswOmGc8O64h16crBEnYaibAG
	eARkpOKRkX8RD923eLGvwNKq7G+Pj1Dzyr6SOgFWHpuOdXdadrO6VNKrd5h2Mv2SPQdZAl
	WZgQzMo9KkvyeZf2YCQ37Jn8nmIyPrgXX74IgfFWSqePtYriBww831tVa070xQ==
Message-ID: <7947c611-982f-4ece-b7f4-d151f728fe6f@bootlin.com>
Date: Fri, 30 Jan 2026 14:36:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/13] net: phylink: Represent PHY-less SFP
 modules with phy_port
To: Romain Gantois <romain.gantois@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
 <20260127134202.8208-9-maxime.chevallier@bootlin.com>
 <3029118.e9J7NaK4W3@fw-rgant>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <3029118.e9J7NaK4W3@fw-rgant>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255149-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,csgroup.eu,gmail.com,nxp.com,kernel.org,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F702BB352
X-Rspamd-Action: no action



On 28/01/2026 17:01, Romain Gantois wrote:
> On Tuesday, 27 January 2026 14:41:56 CET Maxime Chevallier wrote:
> ...
>> @@ -1786,13 +1787,31 @@ static int phylink_create_sfp_port(struct phylink
>> *pl) else
>>
>>  		pl->sfp_bus_port = port;
>>
>> +	if (pl->mod_port) {
>> +		ret = phy_link_topo_add_port(pl->netdev, pl->mod_port);
>> +		if (ret)
>> +			goto out_bus_port;
>> +	}
>> +
>> +	return 0;
>> +out_bus_port:
>> +	phy_link_topo_del_port(pl->netdev, port);
> 
> This seems strange to me. Why clean up after phy_link_topo_add_port() if it 
> returned an error code? Presumably phy_link_topo_add_port() cleans up after 
> itself if it encounters an error doesn't it?

Because we're not cleaning up the same port, notice the 'port' vs
'pl->mod_port' params :)

> 
>> +	phy_port_destroy(port);
>>
>>  	return ret;
>>  
>>  }
>>  
>>  static void phylink_destroy_sfp_port(struct phylink *pl)
>>  {
>>
>> -	if (pl->netdev && pl->sfp_bus_port)
>> -		phy_link_topo_del_port(pl->netdev, pl->sfp_bus_port);
>> +	if (pl->netdev) {
>> +		if (pl->sfp_bus_port)
>> +			phy_link_topo_del_port(pl->netdev, pl->sfp_bus_port);
>> +
>> +		/* Only remove it from the topology, it will be destroyed at
>> +		 * module removal.
>> +		 */
>> +		if (pl->mod_port)
>> +			phy_link_topo_del_port(pl->netdev, pl->mod_port);
>> +	}
>>
>>  	if (pl->sfp_bus_port)
>>  	
>>  		phy_port_destroy(pl->sfp_bus_port);
>>
>> @@ -3998,6 +4017,49 @@ static void phylink_sfp_disconnect_phy(void
>> *upstream, phylink_disconnect_phy(upstream);
>>
>>  }
>>
>> +static int phylink_sfp_connect_nophy(void *upstream)
> 
> I'd name this "phylink_sfp_connect_no_phy" just to keep the name formatting 
> consistent.

having 'nophy' as a single word made it clearer that this was "phy" vs
"nophy" IMO, rather than potentially interpreting "phy" as a suffix. but
I see your point, I think I'll rename it :)

Maxime

> 
> Thanks,
> 


