Return-Path: <netdev+bounces-301415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pcuZAR6+Omp0FggAu9opvQ
	(envelope-from <netdev+bounces-301415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:10:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3396B8F8A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=trager.us (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301415-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301415-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE420303CD23
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75572388E57;
	Tue, 23 Jun 2026 17:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224C388E5B
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234649; cv=none; b=rb0hSJLkjHtSqvLtHC8BfMHHMfq7NRPgTas6wW3pR6zy1GlWsmvNIVhJ7TMGznbezdeRuxqr3cZ8iJz21lUzXM5cMWmcuwZSWD7686Q+YxXCFmStvsdEDrfdRcy3bRH+eHjdNihIpxGz8OiDibMA5tJHikjG5Ms7YGEXPZbtRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234649; c=relaxed/simple;
	bh=m58vfzvlKkIpEq+PFgaC6VpgmvMXBRUD8LHux9BXO5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsZn3lodyJEH6niFtgE/9lQhNmo5sd1LHRBDGtnLziHKMynfvxuMqJPoN7s3VwjjQH7OQo43Yq+4s34HtfJpTsfbJp6eauNDWeKY905kFP3xuFG+nhpXbAb3hj4jN6dpy6+4HY7REZeXlrIBEEmfBQQUnqEC3PFeTRNwfO/Xus0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.225])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1wc4e4-00080Y-Qf; Tue, 23 Jun 2026 17:10:44 +0000
Message-ID: <60af2f94-0fe5-423a-96bb-1c32a221d2df@trager.us>
Date: Tue, 23 Jun 2026 10:10:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ethtool : PRBS feature
To: Andrew Lunn <andrew@lunn.ch>, "Das, Shubham" <shubham.das@intel.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Alexander H Duyck <alexander.duyck@gmail.com>,
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
 <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[trager.us : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301415-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:shubham.das@intel.com,m:maxime.chevallier@bootlin.com,m:alexander.duyck@gmail.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lee@trager.us,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,vger.kernel.org,suse.cz,intel.com,ericsson.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D3396B8F8A

On 6/23/26 2:43 AM, Andrew Lunn wrote:

> Taking a quick look at this:
>
> You are missing a way to enumerate what test patterns the hardware
> supports. There is more than prbs7. You want to be able to report the
> contents of C45 1.1500, and other similar registers.
Not only is there more than PRBS7 but also PRBS 8/10 encoding which is 
an option on any test. There may be other options, that was the only one 
fbnic supported. I agree there does need to be a user interface which 
displays supported tests and options.
> To avoid race conditions, maybe some of these commands need combining.
> ethtool --phy-test eth1 tx-prbs prbs7 rx-prbs prbs7 bert start
>
> The configuration is then atomic, with respect to the uAPI, so we
> don't get two users configuring it at the same time, ending up with a
> messed up configuration.
Testing consumes the link so you really don't want anything done to the 
netdev while testing is running. fbnic does the following.

1. Testing cannot start when the link is up
2. Once testing starts the driver removes the netdev to prevent use. The 
netdev is only added back when testing stops. The upstream solution will 
need something that can keep the netdev but lock everything down while 
testing is running.
3. Once testing starts you cannot change the test, even on an individual 
lane basis. You must stop testing first.
>
> Traditionally, Unix does not offer a way to clear statistic counters
> back to zero. So i'm not sure about clear-stats. We also need to think
> about hardware which does not support that. And there is locking
> issues, can the stats be cleared while a test is active?

fbnic actually has separate registers for PRBS test results. Results do 
need to be clean between runs but I never created an explicit clear 
interface. Firmware automatically reset the registers when a new test 
was started. This also allows results to be viewed after testing has 
stopped.

Reading results was a little tricky due to roll over between two 32bit 
registers. I was able to read results while testing was running without 
pausing. Technically I could clear results while testing was running but 
never saw a need to.

>
> You need to think about the units for inject errors. There is no
> floating point support. Also, is this corrupt packets? Or single bit
> flips in the stream? It needs to be well defined what it actually
> means. The driver can then convert it to whatever the hardware
> supports. How does 802.3 specify this?
>
> Also, 802.3 defines PRBS7 as a benign pattern. With a quick look, i
> did not find a definition of benign, but injecting errors does not
> seem benign to me.
>
> I'm assuming when 'start' is used, the networking core will change the
> interface status to IF_OPER_TESTING. It is not always obvious why an
> interface is in testing mode, rather than IF_OPER_UP. Cable testing
> could also be running, etc. So maybe there needs to be a way to report
> why it is in IF_OPER_TESTING?
>
> I also wounder if a timeout should be used with start, so that it will
> return to IF_OPER_UP after a time period?

When I spoke to hardware engineers at Meta they did not want a timeout. 
Testing often occurred over days, so they wanted to be able to start it 
and explicitly stop it. I'm not against a time out but I do think it 
should be optional.

Since PRBS testing is handled by firmware one safety measure I added is 
if firmware lost contact with the host testing was automatically stopped 
and TX FIR values were reset to factory. This ensured that the NIC won't 
get stuck in testing and on initialization the driver doesn't have to 
worry about testing state.

Lee


