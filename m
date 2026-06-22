Return-Path: <netdev+bounces-301192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8PQ8Mr2HOWptuwcAu9opvQ
	(envelope-from <netdev+bounces-301192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:06:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB66B1FD5
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:06:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=trager.us (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301192-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301192-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B0353025A5A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ACD347BC4;
	Mon, 22 Jun 2026 19:06:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7001C2324
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 19:06:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155195; cv=none; b=p6UoP4B6swTWnzH0AU9MsxcR99M93Q2JEzckmErGs8IbewfSOhdzn4KVj/+4PLpOiEUHeQA+YaBfATfNnAK1c34TSG8m8cAdhbKiomVcuWjeV5PXONTO1wDsjoT5IYGVaOmn9c1qcJqXkhyAuRN569JfMgpatE4qay4+3Ngx1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155195; c=relaxed/simple;
	bh=jg+J7Z05s/OxCLHQHKhL8Q8/aSgcFvwJWjp91o97TcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sAwbhwuTyKeYEDpL9gh/VH6lMlKkNce6tw3DGvPJRmZ6zkvYqBY2q5dTGtRfIwDuLBGAetmxjZirvTcfr/3RCTYeaY36v3URG0a6HNTToA/fXxdNRDuFg8d3kUF6jq/2w8+xW121tVGca+IcYo9FmAgc4Mpm9Yt7LwCF1x6q+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.225])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wbj76-0006Ku-Mm; Mon, 22 Jun 2026 18:11:16 +0000
Message-ID: <d8dd2a52-ee75-4d20-a99d-73caff59da76@trager.us>
Date: Mon, 22 Jun 2026 11:11:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool : PRBS feature
To: "Das, Shubham" <shubham.das@intel.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexander H Duyck <alexander.duyck@gmail.com>,
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
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
 <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[trager.us : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301192-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:shubham.das@intel.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:alexander.duyck@gmail.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lee@trager.us,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@trager.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:email,intel.com:email,ericsson.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36CB66B1FD5

On 6/22/26 8:38 AM, Das, Shubham wrote:

> Hi Maxime,
>
>> Can you elaborate on what you have in mind for now ? what would the "ethtool --
>> phy-test" command look like in terms of its behaviour and parameters ?
> We are trying to converge on a userspace uAPI for PRBS/BERT functionality that can work across
> different hardware models (PHY-managed, MAC/NIC-offloaded, or firmware-based implementations),
> without exposing those differences to userspace.

This was my original thought as well. Create a well defined uAPI for 
PRBS testing/TX FIR tuning and allow the driver to implement support 
however it sees fit. Since our target is for ethernet devices ethtool 
was a natural spot for the uAPI.

I presented this at netdev last year and received strong push back 
against associating PRBS testing/TX FIR tuning with ethtool. The 
argument being any new uAPI added to the kernel should be generic enough 
to handle future use cases so duplicate uAPIs don't have to be added. 
Since PRBS testing/TX FIR tuning can be done on many phys(Ethernet, 
PCIE, USB, etc) the uAPI does not belong in ethtool and needs to be 
structured to support other use cases.

As drivers/phy is the base phy library the thought was support should be 
added in drivers/phy and a new phytool should be created to interact 
with a uAPI. This would be generic enough to support all use cases, with 
the downside being existing drivers would have to onboard to drivers/phy.

I do wonder if the best path forward would be to create phytool in a way 
that allows the driver to implement PRBS testing/TX FIR tuning as it 
sees fit instead of being strictly tied to drivers/phy.

>
> Based on the functionality we currently have, we proposed below commands in first email :
>
> PRBS Transmitter/Checker Pattern Configuration:
> ethtool --phy-test eth1 tx-prbs prbs7
> ethtool --phy-test eth2 rx-prbs prbs7
>
> BERT Test:
> ethtool --phy-test eth2 bert start
> ethtool --phy-test eth2 bert stop
>
> BERT Test Counter Read/ PRBS Lock Status:
> ethtool --phy-test eth2 stats
>
> BERT Clear stats - Symbol and Error counter:
> ethtool --phy-test eth2 clear-stats
>
> TX Error Injection:
> ethtool --phy-test eth1 inject-error 1
> ethtool --phy-test eth1 inject-error 1e-3
>
> Disable PRBS Pattern : TX/RX
> ethtool --phy-test eth1 tx-prbs off
> ethtool --phy-test eth2 rx-prbs off

The goal of running testing is to validate TX FIR values. If testing 
fails we need a uAPI to change those values.

Also the uAPI need to support testing per lane. One thing hardware 
engineers at Meta did was test each lane with a different set of TX FIR 
values which allowed them to quickly determine the best set of values.

>
> Approach would be to add a generic ethtool netlink API for PHY/SerDes and allow drivers to implement the operations directly.
> Conceptually:
>         ethtool ⇒ ethtool netlink ⇒ driver-specific implementation
>
> We would appreciate your input on whether a command-based model is suitable for a uAPI, and how we should design
> it to accommodate different implementation models, such as PHY-based, phylib-based, and MAC/firmware-offloaded PRBS.
>
> - Shubham D
>
>> -----Original Message-----
>> From: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> Sent: 20 June 2026 20:09
>> To: Das, Shubham <shubham.das@intel.com>; Andrew Lunn <andrew@lunn.ch>
>> Cc: Alexander H Duyck <alexander.duyck@gmail.com>; lee@trager.us;
>> netdev@vger.kernel.org; mkubecek@suse.cz; D H, Siddaraju
>> <siddaraju.dh@intel.com>; Chintalapalle, Balaji
>> <balaji.chintalapalle@intel.com>; Lindberg, Magnus
>> <magnus.k.lindberg@ericsson.com>; niklas.damberg@ericsson.com
>> Subject: Re: Ethtool : PRBS feature
>>
>> Hi,
>>
>> On 6/20/26 15:48, Das, Shubham wrote:
>>>> Can you change the firmware to expose the 802.3 registers for PRBS?
>>>> You can then write a library which both plylib and your driver can use.
>>> Andrew,
>>>
>>> No, exposing the PRBS registers to drivers is not possible in our design (the
>> registers are buried deep within the Accelerator/NIC/PHY/Analog IP hierarchy).
>>> Additionally, the PHY PRBS registers are not in accordance with the IEEE Clause
>> 45 definitions. For instance, the PRBS registers are paged and 32-bit wide.
>>> Given these constraints, we think ethtool --phy-test is a reasonable starting
>> point for exposing the long-established Ethernet PRBS functionality to Linux
>> userspace, as it aligns well with the driver-owned NIC architecture model. If you
>> think a more generic layered approach would be preferable, we would appreciate
>> guidance on the expected architecture. That would help us better understand the
>> implementation complexity, required effort, and delivery timelines.
>>
>> Can you elaborate on what you have in mind for now ? what would the "ethtool --
>> phy-test" command look like in terms of its behaviour and parameters ?
>>
>> This feature is interesting for multiple people, each having different hardware
>> designs and constraints. It's good to consider an iterative approach to build this,
>> however we need to have in mind that this is uAPI, so once we commit to a design
>> choice, we have to live with it.
>>
>> We do have flexibility on the kernel side of the API. We can implement PRBS in
>> generic PHY, phylib, some MAC driver that talks to a firmware, etc. and hide away
>> these implementation details to userspace, but we need to make sure the uAPI
>> we come up with allows us to support all of that.
>>
>> Let's figure this out together, if you already have some ideas in mind we can use
>> that as a starting point for the discussion :)
>>
>> Maxime
>>
>>> Thanks,
>>> Shubham D
>>>
>>>> -----Original Message-----
>>>> From: Andrew Lunn <andrew@lunn.ch>
>>>> Sent: 20 June 2026 00:07
>>>> To: Das, Shubham <shubham.das@intel.com>
>>>> Cc: Alexander H Duyck <alexander.duyck@gmail.com>; lee@trager.us;
>>>> netdev@vger.kernel.org; mkubecek@suse.cz; D H, Siddaraju
>>>> <siddaraju.dh@intel.com>; Chintalapalle, Balaji
>>>> <balaji.chintalapalle@intel.com>; Lindberg, Magnus
>>>> <magnus.k.lindberg@ericsson.com>; niklas.damberg@ericsson.com
>>>> Subject: Re: Ethtool : PRBS feature
>>>>
>>>>> The host driver does not directly access any registers but requests
>>>>> the PHY FW to manage PRBS on behalf of it.
>>>> Maybe a dumb question. Why?
>>>>
>>>> Can you change the firmware to expose the 802.3 registers for PRBS?
>>>> You can then write a library which both plylib and your driver can use.
>>>>
>>>> 	Andrew

