Return-Path: <netdev+bounces-256414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Bi9FE06gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:11:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2BDD5DF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0977301E3C7
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D239350D4F;
	Tue,  3 Feb 2026 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BDUPmSHt"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A131C84A2
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142177; cv=none; b=CR1lJILNZxAICTmOIQO4Ylxl+MvdCqLXOY+6hsg9lBns4ls9okX1yo56sWwzXeE9T8V7O4UJTc08uXN6GL8b4Nyw5uL9b7IWZUByLHTgck/xSYwIw7N/D9GaBQLXlwH+FddKQZTLC9MBPIHmp5VslHo/vwxONIK2agMTk7OjQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142177; c=relaxed/simple;
	bh=GaOJeKxxP/WpuIajStYc3OIVeEcfNxKCGLhqZ8ZN4UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sv3PjsKCxCQ/FgkncOm1TcqZB2A5KC4KWl2/qNGhCZw/K2XIWkboJkHxSduXGufS4Q1+qyDQeAZ9tZdpQEP6yQ/I6ohe0ls1jhYnSOWzBioFzl6IdV+/1cypGN5w2uaGJEZFv3O1cfxGTl0LGg51JeWozvAJ2PLEcnhHyzwzw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BDUPmSHt; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BE1AC4E423E4;
	Tue,  3 Feb 2026 18:09:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 79C4E60728;
	Tue,  3 Feb 2026 18:09:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B66A8119A8888;
	Tue,  3 Feb 2026 19:09:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770142173; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=O62isuvLKNo91bhpciiMqvou6yopkPFDMX5oCBp2AOw=;
	b=BDUPmSHtuUq2bGYeKax3QUBnvdHV42iUDt1R/zkMlUJVAH/h7PIF0dsOZWyxMs43flF8+h
	N2nV023ZH0kc/e6i4z7dQNN67aWyBEIcHTTD7Y9/zmBNtiQWEH872U3E0QBEEFjQbcK+e9
	sVaiIQw2NoUAOri8mYdcqm23SJj8daLcoRlcug9x/Dn7sL01Vs4xOwQdmpFGBF0/W1B+Hb
	cuoAb0JQchyg7FkIFnMgEdvn8ga8FcRLa5L3TLyT2IvyWMaL+lUv4CGasQGgvPlozHfy7e
	if4pL02AIWEiLaWmiJqK+Vg6NFIe5Ygw2VA26xNqQHxfjMYcLpc2NO+dC9C6ig==
Message-ID: <7150d811-df6a-488d-a7d8-96aec01365db@bootlin.com>
Date: Tue, 3 Feb 2026 19:09:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 05/11] net: phy: Create SFP phy_port before
 registering usptream
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 mwojtas@chromium.org, Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
References: <20260201151249.642015-1-maxime.chevallier@bootlin.com>
 <20260201151249.642015-6-maxime.chevallier@bootlin.com>
 <aYI1zd6Iddcdt6xc@horms.kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aYI1zd6Iddcdt6xc@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FC2BDD5DF
X-Rspamd-Action: no action

Hi Simon,

On 03/02/2026 18:52, Simon Horman wrote:

>> -	if (!ret && phydev->sfp_bus)
>> -		ret = phy_setup_sfp_port(phydev);
>> +	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
>> +	sfp_bus_put(bus);
>> +
>> +	if (ret && port) {
> 
> Hi Maxime,
> 
> If bus is NULL then port will not be set here.

Arg... I though smatch was running in the NIPA ingst-mdir script, but I
was wrong :(

I'll address that in V5 as the problme is still in V4, thank you for the
report

Maxime




