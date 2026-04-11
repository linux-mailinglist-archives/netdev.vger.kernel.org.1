Return-Path: <netdev+bounces-277673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPxhFC/32WncxQgAu9opvQ
	(envelope-from <netdev+bounces-277673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 09:24:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C37DB3DEAA5
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 09:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D84ED303AF0E
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC1C32FA2E;
	Sat, 11 Apr 2026 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b="EajprrFB"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569B32BF5D;
	Sat, 11 Apr 2026 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892263; cv=none; b=NwXVUPgQfNtAsS5J1ozA50YAnS3Bawvu6XhrpwZHWjQ5j7rdlt3W1ZUiJ+2n0ajMtisZzA76bwAWdqfmDvuPWLduuf55lWZsk6AHrm/9Aec5xeMo5RRRAPiX1xbbNy/HqhtlbErf4Z4t2SXfHxxzlUetoooRq0PjT5X1ORda2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892263; c=relaxed/simple;
	bh=069FMlWOZ762g0DeUeR14CPGc6EqxAXTGHYAIw3GVk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLjXBk6KLn0rzYRsnOjhlIf/xN8EjaxT3dUlL4nn/oPxUEzJfJoAGTWLUZaHIPIvndxb9RAFhLSXg7t+qLBqzzuUi6kM6CPyKZmsPpeAD5vgyGkXma3DpjRIwMCxVd5/dOBZowmeIi3idQANem7BLFcuvHIYtD8fPOIOwthFhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org; spf=pass smtp.mailfrom=blemings.org; dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b=EajprrFB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blemings.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blemings.org;
	s=202501; t=1775892260;
	bh=P587PAWRGw5EUkO02MO/7KJsYZrtrTl7DRb/I70f/MY=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EajprrFBd6AVXrhTOjX2ojMIrGdHgYj2g01kY5P15sTRCV7bVbJhSd0n/y2n4PrkW
	 o+g/kgXFGFNSc9erd2gQVi80ePzK+7Kj1OExRz4Nt+tVH2ejDqCG3q78NqjkIYsF++
	 7Lzu0vAl25VDwkSWswd0OCUGIwjHFP1rTHdRIxdmimosykdDtZ47V8RjspW/ktovcc
	 k+2URIebwr5Dwb7kz0OXS5+UuLchhYxKDAHa9MdUKMmV7Oiw24rg7KXwB5JSQiezkG
	 aDlg447v12m/vhuKE9E9FuOkpSLg/2NYrGXxQ/U21plTlSW7o3Qbx3bsF9i7pYRcNn
	 eJi7LDw3460Ow==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ft4t96DBgz4wJP;
	Sat, 11 Apr 2026 17:24:17 +1000 (AEST)
Message-ID: <b9355e3c-9252-4dd7-b7ed-dff13e3b2c8b@blemings.org>
Date: Sat, 11 Apr 2026 17:24:17 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: hugh@blemings.id.au
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming
 frames
To: Greg KH <gregkh@linuxfoundation.org>, hugh@blemings.id.au
Cc: Kuniyuki Iwashima <kuniyu@google.com>, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org,
 workflows@vger.kernel.org, yizhe@darknavy.com
References: <20260410145448.38253e3c@kernel.org>
 <20260410221220.1708137-1-kuniyu@google.com>
 <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
 <2026041135-shindig-trekker-5d06@gregkh>
Content-Language: en-US
From: Hugh Blemings <hugh@blemings.org>
In-Reply-To: <2026041135-shindig-trekker-5d06@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blemings.org:s=202501];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277673-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[blemings.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hugh@blemings.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blemings.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[hugh@blemings.id.au];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blemings.id.au:email,blemings.id.au:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C37DB3DEAA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 11/4/2026 15:50, Greg KH wrote:
> On Sat, Apr 11, 2026 at 08:25:19AM +1000, Hugh Blemings wrote:
>> On 11/4/2026 08:11, Kuniyuki Iwashima wrote:
>>> From: Jakub Kicinski <kuba@kernel.org>
>>> Date: Fri, 10 Apr 2026 14:54:48 -0700
>>>> On Fri, 10 Apr 2026 14:30:42 -0700 Jakub Kicinski wrote:
>>>>> On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
>>>>>> On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
>>>>>>> Or for simplicity we could also be testing against skb_headlen()
>>>>>>> since we don't expect any legit non-linear frames here? Dunno.
>>>>>> I'll be glad to change this either way, your call.  Given that this is
>>>>>> an obsolete protocol that seems to only be a target for drive-by fuzzers
>>>>>> to attack, whatever the simplest thing to do to quiet them up I'll be
>>>>>> glad to implement.
>>>>>>
>>>>>> Or can we just delete this stuff entirely?  :)
>>>>> Yes.
>>>>>
>>>>> My thinking is to delete hamradio, nfc, atm, caif.. [more to come]
>>>>> Create GH repos which provide them as OOT modules.
>>>>> Hopefully we can convince any existing users to switch to that.
>>>>>
>>>>> The only thing stopping me is the concern that this is just the softest
>>>>> target and the LLMs will find something else to focus on which we can't
>>>>> delete. I suspect any PCIe driver can be flooded with "aren't you
>>>>> trusting the HW to provide valid responses here?" bullshit.
>>>>>
>>>>> But hey, let's try. I'll post a patch nuking all of hamradio later
>>>>> today.
>>>> Well, either we "expunge" this code to OOT repos, or we mark it
>>>> as broken and tell everyone that we don't take security fixes
>>>> for anything that depends on BROKEN. I'd personally rather expunge.
>>> +1 for "expunge" to prevent LLM-based patch flood.
>>>
>>> IIRC, we did that recently for one driver only used by OpenWRT ?
>>>
>>>
>> If the main concern here is ongoing maintenance of these Ham Radio related
>> protocols/drivers, can we pause for a moment on anything as dramatic as
>> removing from the tree entirely ?
> Sure, but:
>
>> There is a good cohort of capable kernel folks that either are or were ham
>> radio operators who I believe, upon realising that things have got to this
>> point, will be happy to redouble efforts to ensure this code maintained and
>> tested to a satisfactory standard.
> We need this code to be maintained, because as is being shown, there are
> reported problems with it that will affect these devices/networks that
> you all are using.  So all we need is a maintainer for this to be able
> to take reports that we get and fix things up as needed.  I know you
> have that experience, want to come back to kernel development, we've
> missed you :)

That's most kind Greg, thank you, have missed all you cool kids too :)

More seriously though - I'd be up for doing it, but I think there may be 
others better placed than I who haven't yet realised we have this 
conundrum. I'm nudging a few folks offline on this front.

I've also kicked off a thread in linux-hams to discuss some of the 
broader questions raised about staying in tree, going to out of tree or 
looking at userspace solutions instead.

We'll try get a cohesive picture back over next few days.

Cheers,
Hugh

-- 
I am slowly moving to hugh@blemings.id.au as my main email address.
If you're using hugh@blemings.org please update your address book accordingly.
Thank you :)


