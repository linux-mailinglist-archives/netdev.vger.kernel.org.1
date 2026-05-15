Return-Path: <netdev+bounces-288363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDc+LM5PB2o9yAIAu9opvQ
	(envelope-from <netdev+bounces-288363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:54:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F463554291
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FF7A3126943
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC63F58D7;
	Fri, 15 May 2026 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EnyFIQ0z"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEA3EFFC9;
	Fri, 15 May 2026 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862157; cv=none; b=ebl4aSOA0aKDPqR4x17LOMpIHdaf305Pl2seC7NLjDGdJ5fFvvTZGQx9s9laOk97rZqLQpat1742qZjmORFtFZbSmvA6OD162SOtMZyW8y+4uChuj6rScpimhfK1OqGhJx0YALzlpRdQ7J7OUuQvDno4oep2iDnHywFv/M/MnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862157; c=relaxed/simple;
	bh=RFIxxGupQOQAst8dpVpNkaa9M21OnXF1JMqigtKLPaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYm+O4Tixagvaow8mZqNtGF9BXXslMx6LTqLSVdcLH46SqYImd8JU2TTDjSyRg4u3X0aPDtCB/dUeA2JLtXnvgj1mW8RIonnH5W42qva4t46sNXaVnJfJNMPCVMWIXa0L1octPFQbIOO5+8Zswe8/M2DYWiD8JnWxX0UwjNtLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EnyFIQ0z; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E7FDA1A35EC;
	Fri, 15 May 2026 16:22:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BA50B606FD;
	Fri, 15 May 2026 16:22:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AD57511AF8D6E;
	Fri, 15 May 2026 18:22:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778862152; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QD4twp9ma9NDSyrwSFUQpy1DH5AFl+x5xI25hNp8S68=;
	b=EnyFIQ0z/r6H3zZxOeE6oZbKmzzgv6dSV8+IdSEHL6gxlotdBhnQNkuRtZ9xs9dbp4MqLj
	ItB/BP+GiFTxFElNaaMXLBRUnixZQxWA0x6iK4VMVcAtN3iNPPFY2wVZMbGaEtoRV4kSE5
	1nVxslmOYtNovrAzsaJ9jblcCzpEBt600KINSf6ZdyvyqcigFdfcXe011CYPoDiboFk7Md
	JCuSwSDfJAhFQaX79/7jy7ZEyFxBNPGab/hz64gk2y1V529HHDpE2PtInmxLvCCkbGwStJ
	QYGkoWevavDmLfhl5pCDcBPr9oEUEwp6NCrG2sig0P6ngjRZEdjpSxkk+lsE+w==
Message-ID: <dcba6047-d49f-4c82-add5-ec17b9c89c1a@bootlin.com>
Date: Fri, 15 May 2026 18:22:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 6/9] net: phy: phy_port: Store information
 about a MII port's vacant state
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
 <20260513130521.1064094-7-maxime.chevallier@bootlin.com>
 <97cd33a0-ee74-4f64-b11a-bb5b88bce79a@lunn.ch>
 <c68f3abd-7a3d-4d37-9589-02433bbd5c5c@bootlin.com>
 <d7086094-9f8b-4d18-92ae-e278b4e67658@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <d7086094-9f8b-4d18-92ae-e278b4e67658@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 4F463554291
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action


On 5/15/26 15:12, Andrew Lunn wrote:

> My comment is really about, what do we mean by vacant/empty?

Ah yes got it :)

> 
> Is it simply about there physically being a module in the cage, or is
> it also about being able to drive that module? If it is just about
> there being a module in the cage, then vacant/empty is good. If we
> also want to say that we have been able to read out the EEPROM and
> determined the module will work in combination with the PCS and MAC,
> then i would probably use a different name. "usable", "compatible"?

So the direction I have in mind in the first one. We have a device with
a port that's an SFP cage. It has its set of capabilities, in this case
they are a set of phy_interface_t that you can use in that cage. It's 
empty/vacane withouy any modue in it.

Now you insert a module, the SFP cages is still there, same 
capabilities, but there's a new physical front-facing MDI, with its set 
of capabilities (baseT, 100FX, you name it). Now the SFP cage isn't 
vacant anymore.

I'd say, if we can't read the eeprom, or if we insert an incompatible 
module (10G module on 1000BaseX port for example), the SFP cage stays
non-vacant. The port corresponding to the module itself may or may not 
be created (depending on the error, the more we can tell the user the 
better IMO).

> 
> Either way, i think the code either needs simplifying, or made more
> complex.

So, I think the direction will be "let's make it simpler" :)

Maxime

> 
> 	Andrew
> 


