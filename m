Return-Path: <netdev+bounces-300819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y/jVExamNmqQCQcAu9opvQ
	(envelope-from <netdev+bounces-300819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 16:39:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BABBB6A905A
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 16:39:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=k8eBEuZp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300819-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300819-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33A6F3005999
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407E83446C4;
	Sat, 20 Jun 2026 14:39:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F227467F
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 14:39:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781966356; cv=none; b=ROqzYhA6KtFyQ3bbMSyigLOtzoDDs12gnSK4TamJoqicZvBNF22fkxLLniBxr+zI5b7P4nwE14z62GsjwrJC4e2D3j52fHTBQFInyyrAoKaGOKy7qzzg9N8sUN4vmprHxxpVURYVvcDsIknY0vagX4QvQIedsg70YRZpmLGc6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781966356; c=relaxed/simple;
	bh=xOUlLPpAjv6jUSfM4ODdUcSNds4H2jJhJ7irnTWTmcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCjvGC0QA6fkXVHgfoeRvaikAKFhvAHt5oMPgE3fP0PxBuPWDY2VyKpnBpOHEUTh7joWAQN66iJ924Zijka69+K6pcgH1D8NTytDVAv3nKjCgU3S1vnlQdZx6Pz2JrnZNK4biGvLOhbS7Wn3VL4BW8rWc8n3wpej24KY03p/0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k8eBEuZp; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 440E14E402A5;
	Sat, 20 Jun 2026 14:39:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 02797601B7;
	Sat, 20 Jun 2026 14:39:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A74C3106C8938;
	Sat, 20 Jun 2026 16:39:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781966351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KMsDSZjmjfUor+eLpm4T3lAJdJDoXk0AKdOfBbORGLw=;
	b=k8eBEuZpQCtbV5OVYI06T/6gqIAChTXvP7HYfqd9cFzSEEjHLNvzk3cRboGXt2oU1M80zi
	w0DA4lBkANNRDN002QQMr5f4tt4KO3rYhEX4NWTwh8DF7+9+Jmb9YAYAaTQRTHjK7d68Fp
	AOB7pYfmd6Bv5fakBIShbzixQ++Y5nO0P4RgoawOppMqWDolvnE1ICYRSfvz9cwSZvnJRr
	F19g/g8jax0ednU6dBzWGILXlgc9c/XXZxeKXFXOgz1gvIe9pbB9CE0bosYizKpsp+rvzT
	10REmBbZ6K5eVbRqGbSpdcsi60wC3kaI299MNE6RA/l7CbeSuugLNUwgwWOdGg==
Message-ID: <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
Date: Sat, 20 Jun 2026 16:39:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool : PRBS feature
To: "Das, Shubham" <shubham.das@intel.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Alexander H Duyck <alexander.duyck@gmail.com>,
 "lee@trager.us" <lee@trager.us>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>,
 "D H, Siddaraju" <siddaraju.dh@intel.com>,
 "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
 "Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
 "niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>
References: <SN7PR11MB810923BBDEC398E860099150FF1B2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
 <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shubham.das@intel.com,m:andrew@lunn.ch,m:alexander.duyck@gmail.com,m:lee@trager.us,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,trager.us,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,suse.cz:email,ericsson.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BABBB6A905A

Hi,

On 6/20/26 15:48, Das, Shubham wrote:
>> Can you change the firmware to expose the 802.3 registers for PRBS?
>> You can then write a library which both plylib and your driver can use.
> 
> Andrew,
> 
> No, exposing the PRBS registers to drivers is not possible in our design (the registers are buried deep within the Accelerator/NIC/PHY/Analog IP hierarchy).
> 
> Additionally, the PHY PRBS registers are not in accordance with the IEEE Clause 45 definitions. For instance, the PRBS registers are paged and 32-bit wide.
> 
> Given these constraints, we think ethtool --phy-test is a reasonable starting point for exposing the long-established Ethernet PRBS functionality to Linux userspace, as it aligns well with the driver-owned NIC architecture model. If you think a more generic layered approach would be preferable, we would appreciate guidance on the expected architecture. That would help us better understand the implementation complexity, required effort, and delivery timelines.

Can you elaborate on what you have in mind for now ? what would the
"ethtool --phy-test" command look like in terms of its behaviour and
parameters ?

This feature is interesting for multiple people, each having different
hardware designs and constraints. It's good to consider an iterative
approach to build this, however we need to have in mind that this is
uAPI, so once we commit to a design choice, we have to live with it.

We do have flexibility on the kernel side of the API. We can implement PRBS
in generic PHY, phylib, some MAC driver that talks to a firmware, etc. and
hide away these implementation details to userspace, but we need to make
sure the uAPI we come up with allows us to support all of that.

Let's figure this out together, if you already have some ideas in mind we
can use that as a starting point for the discussion :)

Maxime

> 
> Thanks,
> Shubham D
> 
>> -----Original Message-----
>> From: Andrew Lunn <andrew@lunn.ch>
>> Sent: 20 June 2026 00:07
>> To: Das, Shubham <shubham.das@intel.com>
>> Cc: Alexander H Duyck <alexander.duyck@gmail.com>; lee@trager.us;
>> netdev@vger.kernel.org; mkubecek@suse.cz; D H, Siddaraju
>> <siddaraju.dh@intel.com>; Chintalapalle, Balaji
>> <balaji.chintalapalle@intel.com>; Lindberg, Magnus
>> <magnus.k.lindberg@ericsson.com>; niklas.damberg@ericsson.com
>> Subject: Re: Ethtool : PRBS feature
>>
>>> The host driver does not directly access any registers but requests
>>> the PHY FW to manage PRBS on behalf of it.
>>
>> Maybe a dumb question. Why?
>>
>> Can you change the firmware to expose the 802.3 registers for PRBS?
>> You can then write a library which both plylib and your driver can use.
>>
>> 	Andrew
> 


