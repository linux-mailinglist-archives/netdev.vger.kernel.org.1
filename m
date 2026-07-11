Return-Path: <netdev+bounces-306768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VK3fE/IBUmr9LAMAu9opvQ
	(envelope-from <netdev+bounces-306768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:42:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D619740EE6
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:42:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=m2w7Nr04;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306768-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306768-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6255C3011121
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 08:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31AC37A821;
	Sat, 11 Jul 2026 08:42:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F322083
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 08:42:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783759343; cv=none; b=hVWPjp0tDPNNVXuJjU6aokEQcw+4vgPR/Ssm4mFvmIjW+e8euDIb5dEHib4NAna0bMRH2lPp+NN8MTGX7JIGOiky2VX1ENnn5VDtj6fcHGvwSJhLnxAjbvzgUcq2I43qrpB23K0w+L7tbTTpBJbGhZWqc6hsSfquDhyIV5HTKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783759343; c=relaxed/simple;
	bh=iS1c4hvGH/LXlRadNhieKEoeuzlGxODr9gWM+1BYuVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUUqUVInVOZZyDIaGWlErUtG0Qo9IUjgPOLbJLQQKL0fJbIKBrpLSSIpNQCvDrvbJUC6qAIcOo/avdum/ofaT5MugLX3Q3ciqmItoo4c3F7iDkF+/9Xz243f5KKBf7tyZEypsx3eszD52Y56QwFp4Q9nuLZ3+tQWSizIrsaaa4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m2w7Nr04; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D289D1A0F61;
	Sat, 11 Jul 2026 08:42:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 991DC60343;
	Sat, 11 Jul 2026 08:42:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7447411BD1CD7;
	Sat, 11 Jul 2026 10:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783759330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SK7W81fF4n3/gbjdgCeCa6t2meM8xhrSq1ENEJSgQ7Q=;
	b=m2w7Nr04oCpdms+SFBCUOFxzClexX1LAeYhPa5uaP0r2R2b2Lj/L1WcsYyA55z1O/HCYco
	ULWtj4Ydbn1/X1ixFpAXNWKIZE8YWXWAg2+M3+IWBn+dIl/M9pWEcYkTQLp9r+VOhO9sDw
	CXFLcoYDI1Tp7Ndv/7wVRFcXXfBnqNb5z9Dim1EgqzH5s/MzyZE0DlqiDXgO1RUsYdlMQ3
	MEr5KbJONSDdDJGvPIxs4d/fDDynJWDZU/03+pLT2rE1NT/EhzSVmheKMJqOTm8GfcSpEc
	chGBhofORDkhmwpqnjeIaL/DFzQ4mCm7qAi3lP67nA7Dedh6Pjw0L3FB8v4oMA==
Message-ID: <bb7bb5c6-5643-4e5b-b26b-9363127bb2d8@bootlin.com>
Date: Sat, 11 Jul 2026 10:42:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool is missing C2C link modes
To: David Laight <david.laight.linux@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: "D H, Siddaraju" <siddaraju.dh@intel.com>,
 Michal Kubecek <mkubecek@suse.cz>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
 "Das, Shubham" <shubham.das@intel.com>,
 "Srinivasan, Vijay" <vijay.srinivasan@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "singhai.anjali55@gmail.com" <singhai.anjali55@gmail.com>,
 "Brandeburg, Jesse" <jbrandeburg@cloudflare.com>
References: <SN7PR11MB6900E94E718175AACB2309109AFD2@SN7PR11MB6900.namprd11.prod.outlook.com>
 <e3dd8e06-97d1-4943-b54c-fdd0d0e6ecaa@lunn.ch>
 <20260711073128.7f94e0ac@pumpkin>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260711073128.7f94e0ac@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306768-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:andrew@lunn.ch,m:siddaraju.dh@intel.com,m:mkubecek@suse.cz,m:netdev@vger.kernel.org,m:balaji.chintalapalle@intel.com,m:shubham.das@intel.com,m:vijay.srinivasan@intel.com,m:sridhar.samudrala@intel.com,m:jacob.e.keller@intel.com,m:anthony.l.nguyen@intel.com,m:singhai.anjali55@gmail.com,m:jbrandeburg@cloudflare.com,m:davidlaightlinux@gmail.com,m:singhaianjali55@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,suse.cz,vger.kernel.org,gmail.com,cloudflare.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D619740EE6

Hi,

On 7/11/26 08:31, David Laight wrote:
> On Sat, 11 Jul 2026 00:54:00 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
>> On Fri, Jul 10, 2026 at 09:45:43PM +0000, D H, Siddaraju wrote:
>>> Hello Linux Ethernet team, Maxime, Andrew & Michal,
>>>
>>> The IEEE AUI chip-to-chip (C2C) is the accepted standard for connecting
>>> chips that handle subfunctions within the OSI physical layer. Just to
>>> pick, the C2C is widely used when connecting Ethernet SoCs with retimers
>>> and PCS SerDes terminated external-phys to offload PHY sublayer functions.  
>>
>> It cannot be that widely used if Linux does not support it yet :-)
> 
> It also seems like something that is fixed for a physical board.
> So while a common MAC driver would need to be told how to configure
> its output, the user wouldn't be changing the value so it would
> be more of a DT parameter than an ethtool one.
> 
> ...
>> Also, an architecture question...
>>
>> It sounds like you use this between the MAC and the PCS. The PCS can
>> then be connected to a PHY, and the PHY then has a line side. (I'm
>> being a bit loose with the terms here, i should probably be saying
>> PMA, PMD etc.)
>>
>> Should ethtool be saying:
>>
>> Settings for eth0:
>> 	Supported ports: [ TP	 MII ]
>> 	Supported link modes:   25000baseC2C
>>
>> or should it be reporting:
>>
>> Settings for eth0:
>> 	Supported ports: [ TP	 MII ]
>> 	Supported link modes:   25000baseSR
>>
>> I _think_ ethtool reports the media, not some intermediary format.
> 
> You'd want to use ethtool to set the final link parameters of the
> external phy?
> So I think you's still want to be able to select (say) 100MHDX
> for a TP link.
> 
> Remember the history.
> The parameter was originally used to select between the the AUI, COAX and TP
> connectors on a 10M ethernet card.
> Then the internal TP gained extra speeds.
> We then get MII for external 10M and 100M PHY, later RGMII for external Ge PHY.
> But you rarely get boards (not MAC chips) that have a choice of interfaces
> any more.

Note that there's ongoing work[1] to better support nics with multiple connectors,
which also includes reporting what the 'media-side' of a MAC / PHY can do :

[1]: https://lore.kernel.org/netdev/20260701110427.143945-1-maxime.chevallier@bootlin.com/#t

Taking the example of a combo-port (SFP + RJ45), it would look like that :

 ethtool --show-ports eth1

Port for eth1:
	Port id: 1
	Supported link modes:  10baseT/Half 10baseT/Full
	                       100baseT/Half 100baseT/Full
	                       1000baseT/Full
	                       10000baseT/Full
	                       2500baseT/Full
	                       5000baseT/Full
	Port type: mdi

Port for eth1:
	Port id: 2
	Supported MII interfaces : 10gbase-r
	Port type: sfp

or even

# ethtool --show-ports eth3

Port for eth3:
	Port id: 1
	Supported MII interfaces : sgmii, 1000base-x, 2500base-x
	Port type: sfp


Now, with this infrastucture also comes the ability to list the media-side
interfaces that are not MDI but rather MII.

The main goal is combo-port support, but also media-converters, e.g. things
like :

MAC ------ PHY ------- <something>
     rgmii      sgmii

(for now, the ongoing series focus on supporting this through SFP, but extending
that to other link types is something I'd like to achieve)

As Andrew says, when you use "ethtool ethX", the list you get is the media-side
modes that you can use at the connector, so it's an aggregated list of the MDI
that are usable based on the MAC, PCS, PHY you're using (MAC and PCS would limit
speed/encoding, PHY defines the actual MDI modes)

For the C2C modes, it's not clear to me if these are MDI modes, i.e:

  ETHTOOL_LINK_MODE_25000baseC2C

Or a phy_interface_t, i.e:

  PHY_INTERFACE_MODE_25GAUI

We already have XAUI and RXAUI as phy_interface_t as of today, so it looks like
we don't want an ethool linkmode for that but rather a phy_interface_t

Maxime


