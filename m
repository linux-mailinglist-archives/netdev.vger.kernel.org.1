Return-Path: <netdev+bounces-277732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E91G2EE22kH8QgAu9opvQ
	(envelope-from <netdev+bounces-277732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 04:33:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 316663E2873
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 04:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCDEF301738E
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 02:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD602157487;
	Sun, 12 Apr 2026 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b="iZVUNNZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC76B40DFA7;
	Sun, 12 Apr 2026 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775961179; cv=none; b=rqIZm42inKv+IV0MpRQ9fHTjRQJUzbZpqVEUj9qXIHc8xCoK1dekd4Ah38IpwW0FOh7U/lQxPCcZ1YGN6UR98eTxoyODyyhf9BWQ1t+/zDNRPPaYGLc/m4worsTsMMNg0UBa1XafBb8oKfGBC1aj91Ll/qn3/Kz4T3okvFMU03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775961179; c=relaxed/simple;
	bh=zp1lGZb/Gd+MxuVvsJkpVPzwX7j6FIQDFj2sk7yuL5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0g+F6ew7+I3JQ3agyP/3I49dCtM73u/g3Yvb3sgAaKCUHlr+V1YsP2fePFTrbDAKUhB8iC1WoSsvh0/3MyJGavmVZUrRI3FPwSKbL5UxVV7grOLk1IX72CrgggxfU1i4ymyCCrVO9HmjYTZF5E6MSTQtlysI3WQtk9tA/1SdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org; spf=pass smtp.mailfrom=blemings.org; dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b=iZVUNNZN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blemings.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blemings.org;
	s=202501; t=1775961167;
	bh=0We60X5AUf8OatS8sDaDOf8kvQJA7x+/l9H3m0X8Z6U=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iZVUNNZN8tLQ2arQZZ4cVBbKPcwX1RNwNYD2kvlXHOMdtwIlHu8JqxavLa/c4k3qI
	 893JJsO5PYYmdLU+6aIP/815UViv1WuL/tW4DBcOlY0G2u2ECSlwEEjcSliBkSQomy
	 fjGh1ItaeDSLdeyb+EZwyZ3NXdBZXeyCNS2Z7qC8kqHZBy0YHeKs/aBWOboBbQLxqT
	 2iGq2JEIfuucXb3RB0DD4TxJwR5zs2H8H+AHznZIqTSoCtSHXJRZc2hZHuKFqYpZTV
	 v8jypgsLpr/PTjM3s/E/PzltHy47Urc0gdwpiOFUkdQ1L8E747OFzGTB1wsagiEw3U
	 QOAAN/yL6WfKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ftZMK2VfWz4wJG;
	Sun, 12 Apr 2026 12:32:45 +1000 (AEST)
Message-ID: <3cd91fbc-d3a9-431e-b915-58e851c7df9f@blemings.org>
Date: Sun, 12 Apr 2026 12:32:44 +1000
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org,
 workflows@vger.kernel.org, yizhe@darknavy.com
References: <20260410145448.38253e3c@kernel.org>
 <20260410221220.1708137-1-kuniyu@google.com>
 <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
 <2026041135-shindig-trekker-5d06@gregkh>
 <b9355e3c-9252-4dd7-b7ed-dff13e3b2c8b@blemings.org>
 <2026041124-hyphen-circulate-34ae@gregkh>
Content-Language: en-US
From: Hugh Blemings <hugh@blemings.org>
In-Reply-To: <2026041124-hyphen-circulate-34ae@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blemings.org:s=202501];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277732-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[blemings.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blemings.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hugh@blemings.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[hugh@blemings.id.au];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,blemings.id.au:replyto]
X-Rspamd-Queue-Id: 316663E2873
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 11/4/2026 18:58, Greg KH wrote:
> On Sat, Apr 11, 2026 at 05:24:17PM +1000, Hugh Blemings wrote:
>> On 11/4/2026 15:50, Greg KH wrote:
>>> On Sat, Apr 11, 2026 at 08:25:19AM +1000, Hugh Blemings wrote:
>>>> On 11/4/2026 08:11, Kuniyuki Iwashima wrote:
>>>>> From: Jakub Kicinski <kuba@kernel.org>
>>>>> Date: Fri, 10 Apr 2026 14:54:48 -0700
>>>>>> On Fri, 10 Apr 2026 14:30:42 -0700 Jakub Kicinski wrote:
>>>>>>> On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
>>>>>>>> On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
>>>>>>>>> Or for simplicity we could also be testing against skb_headlen()
>>>>>>>>> since we don't expect any legit non-linear frames here? Dunno.
>>>>>>>> I'll be glad to change this either way, your call.  Given that this is
>>>>>>>> an obsolete protocol that seems to only be a target for drive-by fuzzers
>>>>>>>> to attack, whatever the simplest thing to do to quiet them up I'll be
>>>>>>>> glad to implement.
>>>>>>>>
>>>>>>>> Or can we just delete this stuff entirely?  :)
>>>>>>> Yes.
>>>>>>>
>>>>>>> My thinking is to delete hamradio, nfc, atm, caif.. [more to come]
>>>>>>> Create GH repos which provide them as OOT modules.
>>>>>>> Hopefully we can convince any existing users to switch to that.
>>>>>>>
>>>>>>> The only thing stopping me is the concern that this is just the softest
>>>>>>> target and the LLMs will find something else to focus on which we can't
>>>>>>> delete. I suspect any PCIe driver can be flooded with "aren't you
>>>>>>> trusting the HW to provide valid responses here?" bullshit.
>>>>>>>
>>>>>>> But hey, let's try. I'll post a patch nuking all of hamradio later
>>>>>>> today.
>>>>>> Well, either we "expunge" this code to OOT repos, or we mark it
>>>>>> as broken and tell everyone that we don't take security fixes
>>>>>> for anything that depends on BROKEN. I'd personally rather expunge.
>>>>> +1 for "expunge" to prevent LLM-based patch flood.
>>>>>
>>>>> IIRC, we did that recently for one driver only used by OpenWRT ?
>>>>>
>>>>>
>>>> If the main concern here is ongoing maintenance of these Ham Radio related
>>>> protocols/drivers, can we pause for a moment on anything as dramatic as
>>>> removing from the tree entirely ?
>>> Sure, but:
>>>
>>>> There is a good cohort of capable kernel folks that either are or were ham
>>>> radio operators who I believe, upon realising that things have got to this
>>>> point, will be happy to redouble efforts to ensure this code maintained and
>>>> tested to a satisfactory standard.
>>> We need this code to be maintained, because as is being shown, there are
>>> reported problems with it that will affect these devices/networks that
>>> you all are using.  So all we need is a maintainer for this to be able
>>> to take reports that we get and fix things up as needed.  I know you
>>> have that experience, want to come back to kernel development, we've
>>> missed you :)
>> That's most kind Greg, thank you, have missed all you cool kids too :)
>>
>> More seriously though - I'd be up for doing it, but I think there may be
>> others better placed than I who haven't yet realised we have this conundrum.
>> I'm nudging a few folks offline on this front.
> The main "conundrum" is, is that this protocol completly trusts the
> hardware to give the kernel the "correct" data.  So if you trust the
> hardware to work properly, it will be fine, but as the fuzzing tools are
> finding, if the data from the hardware modems is a bit out-of-spec,
> "bad" things can happen.
>
> I don't know how well controlled the data is from these devices, if it's
> just a "pass through" from what they get off the "wire" or if the
> devices always ensure the protocol packets are sane before passing them
> off to the kernel.  That's going to be something you all with the
> hardware is going to have to determine in order to keep this a working
> system over time.  Especially given that this is a wireless protcol
> where you "have" to trust the remote end.

Thanks for the thoughts Greg - and ya, I guess on balance I come back to 
being generally skeptical of both hardware and software to Do The Right 
Thing (TM)

So bounds checking and the like seems prudent irrespective of whether 
the kernel is getting the data from real hardware, software modems etc.

I've done some initial digging around that confirms my suspicion that 
this in kernel code remains quite widely used, if somewhat out of view. 
Accordingly I lean then towards working to get these various mitigations 
in place with some revised patches etc. as needed and into the main tree.

Once this done I think that'll give me a good sense of whether I or 
someone else is well positioned to keep the code maintained longer term 
and thus justify it remaining in tree or not.

More to follow once I finish remembering this kernel thing!

Cheers,
Hugh




