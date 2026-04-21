Return-Path: <netdev+bounces-280018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPMLBAAZ52m73wEAu9opvQ
	(envelope-from <netdev+bounces-280018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:28:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4C436EF7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56AE430074B7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 06:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CF635F61A;
	Tue, 21 Apr 2026 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b="hCo60zFS"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016337F748;
	Tue, 21 Apr 2026 06:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776752890; cv=none; b=PG0QYFbCL/GDSKca11tpkYVBoBKCDToO9w2gnr9iMWhAwS9/yxOdxr4+oENt2aIsSiV6jSgq2O5bizj/A/fUoDANEoOUPluALn8CSix3E6LlQv/dFVBhF79L6pW4qr2Hk+43jvxSLi2l3EKLyRpNoDeoS5gFMATv3ES5V0SPKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776752890; c=relaxed/simple;
	bh=sAyhpimh2UuA5S8MdVBJhno8mFAfNRluJN57KjVdous=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITDQaaFQA6z9dNvhQ8z/TKzbrbkblz3DVIyH4IsMRfzqbURfw5Mcgm3twq2DDKGwXg7yGRxzg2duGODk48t4kngbma+FwxB3gIeNtswgYyV36OinZg9uapycG71ds9uz0U5i68calUJ8E/0Q+z1UXSXG2geP/gjAg/3ltL4YnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org; spf=pass smtp.mailfrom=blemings.org; dkim=pass (2048-bit key) header.d=blemings.org header.i=@blemings.org header.b=hCo60zFS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blemings.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blemings.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blemings.org;
	s=202501; t=1776752887;
	bh=33DB2Llj0G90vqCtW7jD8C0oCdawVsqRQy/5Y7Jzt3s=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hCo60zFSP0qioo9QveFBiJQ6D98hflsntH6zEALhLKw0ViMvPwkul4feY8Pd6eWyp
	 qNhvg0ixzRMUjgg/1Lzwc4ssmEqyfQa1i0IuA2ORYbKfOHISbveekMY2kqte3MbeD7
	 wTqt9xEYFJnDhREdUQVYwEDIBLmM6g1n/vOR9uUP+L9rU5TOsJyCHuS/dLqkuF0jc1
	 xTvEKGRxtivnqWD3PPCKfye5jRWWL529Cnwc0SyAx6mzsG4Rr+EwzSnZMV7wk+lU3g
	 wlNq6mlHD/vevDG38F96OdjiciW44jOYmZtorprGFcIx+PLno9i0m+89ZBp4Lvxj1B
	 oc4olcmwRvy+w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4g0C8k0nHqz4wC3;
	Tue, 21 Apr 2026 16:28:05 +1000 (AEST)
Message-ID: <5549733f-c9d6-4bae-84e3-285a317ee334@blemings.org>
Date: Tue, 21 Apr 2026 16:28:05 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: hugh@blemings.id.au
Subject: Re: Discuss: Future of AX25, NETROM and ROSE in the kernel ?
To: Steve Conklin <steve@conklinhouse.com>
Cc: Stuart Longland VK4MSL <me@vk4msl.com>, Dan Cross <crossd@gmail.com>,
 linux-hams@vger.kernel.org, netdev@vger.kernel.org
References: <54da3df9-6c91-4df0-87ff-1975d536761d@blemings.org>
 <CAEoi9W5o_twDPYMZDqajqz+UYJm5wOvAx+hUFefXmU=vUbOgtg@mail.gmail.com>
 <CAEoi9W6vTPPHh-NBKZcgmo7GKTecQw1UuZ4HjwNTzqvNXWC43g@mail.gmail.com>
 <7a9547e1-9958-4bce-8547-71a93153a0d6@vk4msl.com>
 <c412bf83-e8cf-4a3d-8619-63f68e108399@blemings.org>
 <CALJxBtX_T8sv11ank-arLfoVqJqXegi3D_ZT9ZFbMHkuf-2RAg@mail.gmail.com>
Content-Language: en-US
From: Hugh Blemings <hugh@blemings.org>
In-Reply-To: <CALJxBtX_T8sv11ank-arLfoVqJqXegi3D_ZT9ZFbMHkuf-2RAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[blemings.org:s=202501];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280018-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vk4msl.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,blemings.id.au:replyto,blemings.id.au:email];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[blemings.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hugh@blemings.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[blemings.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[hugh@blemings.id.au]
X-Rspamd-Queue-Id: 1BD4C436EF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi All,

Just to note in this thread (top posting as it's a bit orthogonal to the 
rest of this discussion) that events have preceeded us somewhat here

A patch just recently submitted removes the AX25, NETROM and ROSE code 
from the kernel moving it to the mod-orphan sub tree of netdev

https://lore.kernel.org/netdev/20260421021824.1293976-1-kuba@kernel.org/T/#u

A shame but perhaps inevitable - but I think we have a good plan 
unfolding to both take care of medium term maintenance of the kernel 
code (in tree or out as it may be) as well as a move to userspace in the 
longer term.

For the benefit of the netdev readership - we had a thread over in 
linux-hams on this but that may not have been visible to folks in 
netdev.  TL;DR: we think we have a way forward but appreciate this may 
not be quick enough to meet the requirements/concerns put forward

If we can delay removal, that'd be grand, but appreciate that moment may 
have passed.

Cheers/73
Hugh
VK3YYZ/AD5RV


On 20/4/2026 02:18, Steve Conklin wrote:
> On Sun, Apr 19, 2026 at 4:36 AM Hugh Blemings <hugh@blemings.org> wrote:
>> HI All,
>>
>> On 19/4/2026 14:01, Stuart Longland VK4MSL wrote:
>>> On 19/4/26 05:28, Dan Cross wrote:
>>>> [Top-posting to make meta-commendary]
>>>>
>>>> I wonder if other folks have thoughts, here? It doesn't bode well that
>>>> the discussion hasn't progressed. 🙁
>>> I haven't had a chance to fully review what you've posted… there was a
>>> lot of historical information in there including detail on the
>>> protocols in question.  I've earmarked it to go through closely
>>> however. (e.g. I had heard of "ROSE" but never seen a spec for it.)
>>>
>>> My situation was wanting a library that I could use to do AX.25
>>> networking from userspace without having applications having to
>>> elevate to `root` to achieve it.  There was also a maintenance
>>> concern.  Rather than try and work out the AX.25 kernel stack, I opted
>>> to instead build my own.
>>>
>>> Instructive, but difficult as the documentation is sketchy in places.
>>>
>>> My implementation was written in Python 3.5+ for ease of development.
>>> Probably not the best option, but it got the job done.  `aioax25`
>>> allowed me to deliver a project for an emergency comms group and
>>> provides a reasonable foundation for simple tasks.  The stack is also
>>> portable to other platforms.  (I mostly only care about Linux and
>>> *BSD, but well written software should work elsewhere too.  Apparently
>>> it works fine on Apple MacOS X.)
>>>
>>> A userspace AX.25 daemon which implements the stack would seem to be
>>> the best course of action, but the elephant in the room is what the
>>> API would look like.
>>>
>>> The only thing I've seen close to achieving something like that would
>>> be the AGWPE protocol, however the author of that AX.25 stack has
>>> categorically stated that he "owns" that protocol.  I don't feel like
>>> going to court to argue copyright of interfaces for the sake of a hobby.
>>>
>>> The AGWPE protocol is also very limiting: a lot of fields in the AX.25
>>> frame are not accessible via this protocol, either for reading or
>>> setting.  Want to use the two reserved bits to signal something in a
>>> custom protocol?  Too bad.
>>>
>>> I was therefore pondering a "stream"-like protocol using KISS-style
>>> framing (to re-use existing code).  The frames would serve as an RPC
>>> mechanism for implementing something like the `libax25` API, exposing
>>> the same functionality and allowing an application to interact with
>>> the AX.25 stack without having to implement the whole protocol (as
>>> they'd have to do with KISS).
>>>
>>> Client applications could connect either via Unix domain sockets or TCP.
>>>
>>> You mention the performance hit of crossing the kernel/user-space
>>> boundary… I think Direwolf experimentally can work as high as
>>> 38400bps. A turn-of-the-century desktop PC was easily able to keep up
>>> with that for PPP links (with `pppd` running in userspace). ARMv7
>>> single board computers made 15 years later can deliver similar
>>> performance.  I don't think this will be much of a bottleneck in
>>> practice.
>>>
>>> I think userspace is the right way forward given the niche use case here.
>> Apologies, I kicked off this thread and life intervened a bit and have
>> only now had a chance to get back to read through the excellent
>> discourse since.
>>
>> I did have one off list conversation about this which was similarly
>> leaning towards a well managed/discussed shift to a userspace approach.
>> The individual in question has had quite a lot of both ham radio and
>> FOSS experience - I'll give them a nudge and see if they would be
>> willing to weigh in here too as I think they'd add a lot to the thread.
>>
>> I wonder if anyone on list feels they have the right skills to put
>> together the shim/compatibility library that would be needed to allow
>> the kernel code to be removed?  Seems like that might be the next thing
>> to explore ?
>>
>> Hoping things settle down a bit and will be able to contribute more to
>> ongoing discussion
>>
>> vy 73
>> Hugh
>> VK1YYZ/AD5RV
>>
>>
>>
>> --
>> I am slowly moving to hugh@blemings.id.au as my main email address.
>> If you're using hugh@blemings.org please update your address book accordingly.
>> Thank you :)
>>
>>
> Hi all,
>
> I'm another former maintainer who has been less active in the FOSS
> hamm community for a while. Thanks for all the history, and it's been
> great to see familiar names and callsigns again.
> /wave
>
> My personal take is that moving to userspace is the right long-term
> goal. As for deciding the exact form that takes, this thread is a good
> start.
>
> I'd like to make an offer for a long-term home for these components.
>
> I'm a director at ORI (Open Research Institute), and  ORI could be a
> home for these. We're a project-based, completely open and volunteer
> nonprofit focused on ham radio and communications. We have volunteers
> with FOSS and ham radio experience, and we're already set up with a
> GitHub org, slack chat, and the infrastructure to manage projects.
>
> https://www.openresearch.institute/
> https://www.openresearch.institute/your-project-is-welcome/
>
> Anyone who currently maintains or has an interest in this is welcome
> to participate there.
> I personally volunteer to help move development infrastructure to ORI,
> if that's the wish of the community.
>
> Steve Conklin AI4QR
>
-- 
I am slowly moving to hugh@blemings.id.au as my main email address.
If you're using hugh@blemings.org please update your address book accordingly.
Thank you :)


