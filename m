Return-Path: <netdev+bounces-277719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKxOAFaw2mme5QgAu9opvQ
	(envelope-from <netdev+bounces-277719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 22:34:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C893E1A49
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 22:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BF29302A2E8
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E003033FD;
	Sat, 11 Apr 2026 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jISlVvnS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960427A92E
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775939607; cv=pass; b=VkEjHpb0o+fDGzu+VuCHhCQ1Go3f1E4By4e7Sf6bcV9KfngkoM2E6kmHqxYqUwJ0sz+6oc3SWjqMh8eJ8I8YpQJJDAVCFBYiE0yZiUfqpwZmc3Xw8CC84It5lKat+evF+mrcutkSjjrfn/08CLoh42xPFMrvWhxLrBCKt+WiGGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775939607; c=relaxed/simple;
	bh=stUxAk/UMqLZRW7gIM/oYk4oFTQ1kRZpwHgj++FtDZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaShJYMMdhD/HfEKP193JW1gvijQ44LT7QLXWvwdR/EU4igmf5Zmzd4pj67SX35xlFUOralFgO7G6k5SozGpFh/TIVFP6hjl+ph+0GsuxITmGJe/N9HM2XleqeFJiCmklV/XVklgPu9FKKu1+fxXPBv+zHxaq5x+4qEWH9WTkMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jISlVvnS; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50d6144877aso33039251cf.3
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 13:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775939604; cv=none;
        d=google.com; s=arc-20240605;
        b=HSDFKuJG27ZEB5QfmbBgnFCCr+fztPP9nX9o0Y4tKxx3pOCvaorZg1pGovpGqXdmAy
         bgZLyTTGmDpJIOpoj9PD5Oh9NiBAYke+GZJi3NYjjlMDZ/tldNmmfnGZg1te8LPv5al7
         MegqrGQeVdJRZoMF3FTyPgHebMIDuaHwu9277+6vT7JY+OGZUr34t9QgpQfFT6DOaBMd
         iV8IUpCGtEYu7HyPx/A3/KJpWuoYiGDWromGCXirWx5a396ng49cIAbrugJgG/gGgVW7
         1uINL0CV5pnDnegMzMVtwQR/PilsLEn8nsC+yx9kwjFJL8rkhRogJVZned6aL9YGaMED
         nhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YbYPJS5lZrojp3il9+9KagoVrK8OHrWbLRyBn3DiYtM=;
        fh=pU/n3w09/KkfO9ZhbZV9bErAogVxDH5K+KXinLeXmh0=;
        b=h8sTGeG4AbZSiagQyDVX7JcIf57Ex2Ar03j3u7EeFc0CXI2KW2yB/EaZBh7EaQo0wR
         olAD9NA+yRvd7pgWaWYUG1YTldEFrQZx8SBElS3woll//RtswuPmrp1sSo7HcnXbGqH8
         jU4XuKATl8YqXuVWqA4MAa/hSbRjn51AT8SzzLP/7T+/YnJ+CoWmDlp5irTmOadhHxAV
         HLmCZ4WdKaXIt14CNEiqFUDBZUmCX4A14IrrDRGKTpLEdFvxa0q0ROEIhRFhJT12+aIY
         MGxX0VBiXBbCPn4m0kmBmXydbyTl/ZDjWgl7KpIn7XSPtIxnKze6Q77uMNCkbrSaFfXG
         4BSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775939604; x=1776544404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbYPJS5lZrojp3il9+9KagoVrK8OHrWbLRyBn3DiYtM=;
        b=jISlVvnSPXrMQqrc5tSZ0yM9hpu49ziY8xATLgMmlIcYJCmYkVaOyweAdmCMk0FIxt
         +QL/fYLI6jTw+XPxx3TcJ+2SGR32SLkD6Ajs0qG+SLodNUbhq9o169+U70FaKksyxKR+
         n5Mt/Ae4GU/lZoTYHHXCkDnturoUgplf8vX9kPAyFwZzzz+Jt6WDN7seB6L37uibRQA+
         xBGyojRL0uxp4/y+hb/KaUo2EmQw27y3ZXlQLrOsj4B1JK6z6oPO8QGMOUDl4PgFZv5o
         cNmpgC662Jj98mxGooDYR5bOvpMrSDICFhiNu5xYjgZfqSjhmyEh3cRNBuAiaXAjPvpX
         Doyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775939604; x=1776544404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YbYPJS5lZrojp3il9+9KagoVrK8OHrWbLRyBn3DiYtM=;
        b=bE+WRnK6W0o88No/YZXih6XtqEGMR4y4JpsyVLNpOac0YlX5xCLFi/QEe5w/dUvNzL
         H6WdBJB29oVYdtLHA8Y/SFLE2eTNTbtvi7b5Pyf+LRTzR14gP0K3kHn6WeC4c7HkCOp/
         8auOIjLq5da01gffcF4uwbX3cR1iaAnlVV9FQIKhPCTXnxEXn0uuXFgPMH4XGsyB1feT
         7P52ZXMTbMogcOXfIjpwytKqpu+EO0MM5ntFUr+12plw8GhvdkCwhYFxwtbmWWrsYg2m
         x+qsPPVBeDthwJUZ63CQVCP3OEYu7z9Et6+2Et8Lw8mOSEGlKhav5poe0wgNHiHpnAsW
         J1SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPRg0rjhyOmiNEY6KTdVOL4jX8PImQfcrHUsXZlPW0ntXOrd2tl+N63opZfwNUpkuFNgLdCNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2YeVddRB33nzPnNjMYGUPi58c2snfhPjqWwA3nhiJgaTg6MM6
	Gcbr3VcHycPEj9fmo6/2IWAwjx6OsLRKv8YzrG/wJK+VJZjbbudHNKsMvpqLnMRfLXP/SrlJcYz
	M/kKJvdzyWXHU953yJi6FlenOx1ogrSw=
X-Gm-Gg: AeBDieuRW6zStkQfCjbxl9kIkWNb0adXYyBs46SEqh/wYOzYIG+DlIRNtG0zVESlhPD
	IDDamv1zSYo/LttPmDj1iJrhcd0Lqh5KX2z83TAVXs4ojk/fPyGFEm1FWAhuDSaw7vIqmfmxL9D
	a+9hodYDooGe+FeauPgj/+dvVn5LoPaO6M2zvuBoMoB/xc8vrxeWfUPV0WqJpKitZL02NbqtmrX
	+KXNZvAjh0oIC+qa263e+IoYtktumRZtvlYE5f26gQRf9wnH0HUJIL3wQ2PF9GKeC0d+VpSWziV
	X4bBzds=
X-Received: by 2002:a05:622a:1493:b0:50d:89f0:9a00 with SMTP id
 d75a77b69052e-50dd5ba35f9mr127453991cf.42.1775939604226; Sat, 11 Apr 2026
 13:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410145448.38253e3c@kernel.org> <20260410221220.1708137-1-kuniyu@google.com>
 <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org> <761f83cc-58eb-4b4a-ba91-d11412e7b2a6@gmail.com>
 <91d50a72-a121-4b24-a559-892f8a3b3c3a@blemings.org> <CANnsUMEniMzLnp5h=Gz83=Wcegc-jGz9vqyWyEpWx-OH=Dij1w@mail.gmail.com>
In-Reply-To: <CANnsUMEniMzLnp5h=Gz83=Wcegc-jGz9vqyWyEpWx-OH=Dij1w@mail.gmail.com>
From: Chris Maness <christopher.maness@gmail.com>
Date: Sat, 11 Apr 2026 13:33:11 -0700
X-Gm-Features: AQROBzCuNQvfNSHedoiJ49QhORLxTNM3Za7NywU29Q6uUwGEHGkvN9Vg7THWeek
Message-ID: <CANnsUMGrgXei5BUKV-FqBCdTwf4LqwKns4vJz7Dx5UgSq0R4aQ@mail.gmail.com>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming frames
To: hugh@blemings.id.au
Cc: Craig <edfardos@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	horms@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org, 
	workflows@vger.kernel.org, yizhe@darknavy.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277719-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org,davemloft.net,linuxfoundation.org,vger.kernel.org,redhat.com,darknavy.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophermaness@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blemings.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,winlink.org:url,blemings.id.au:email]
X-Rspamd-Queue-Id: 46C893E1A49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

forms of validation on incoming frames

I for one run two BBS=E2=80=99s that use LinFBB.  LinFBB uses the kernel co=
de
for its AX.25 stack.  This is still excellent software that is
maintained.  I also use Linux as a netrom node for said BBS with real
radio ports and internet connectivity to out of town nodes using the
ax25ipd/netromd that both use kernel stacks.


73 de Chris KQ6UP


Thanks,

Chris Maness


Thanks,
Chris Maness
-Sent from my iPhone


On Fri, Apr 10, 2026 at 4:53=E2=80=AFPM Chris Maness
<christopher.maness@gmail.com> wrote:
>
> I for one run two BBS=E2=80=99s that use LinFBB.  LinFBB uses the kernel =
code for its AX.25 stack.  This is still excellent software that is maintai=
ned.  I also use Linux as a netrom node for said BBS with real radio ports =
and internet connectivity to out of town nodes using the ax25ipd/netromd th=
at both use kernel stacks.
>
> 73 de Chris KQ6UP
>
> Thanks,
> Chris Maness
> -Sent from my iPhone
>
>
> On Fri, Apr 10, 2026 at 4:38=E2=80=AFPM Hugh Blemings <hugh@blemings.org>=
 wrote:
>>
>>
>> On 11/4/2026 08:51, Craig wrote:
>> >> If the main concern here is ongoing maintenance of these Ham Radio
>> >> related protocols/drivers, can we pause for a moment on anything as
>> >> dramatic as removing from the tree entirely ?
>> >>
>> >> There is a good cohort of capable kernel folks that either are or
>> >> were ham radio operators who I believe, upon realising that things
>> >> have got to this point, will be happy to redouble efforts to ensure
>> >> this code maintained and tested to a satisfactory standard.
>> >>
>> >> Or, alternatively, as a technical community it may be that the Ham
>> >> Radio interested folks conclude that out of tree or user space
>> >> solutions are a better way forward as others have proposed.
>> >>
>> >> Give us a few days, please, for the word to be put around that we
>> >> need to pull ourselves together a bit as a technical group :)
>> >>
>> >
>> > I, for one, really can't imagine pulling an entire network subsytem
>> > out of the kernel without any
>> > knowledge of how/if/when it's used.  Like intercontinental radio
>> > networks, global email, ax.25
>> > keyboard-to-keyboard, BBS and other emergency-communication systems
>> > throughout the
>> > world.  If you're sure the Internet will never fail, I guess it makes
>> > sense removing all of this
>> > since it's inconvenient to maintain.
>> >
>> > Global AX.25 keyboard-to-keyboard on 14.105Mhz
>> >
>> >    https://qsl.net/kb9pvh/105.html
>> >
>> > AX.25/netrom VHF routed networks spanning from Oregon to Los Angeles.
>> >
>> >  https://www.easymapmaker.com/map/80666c4898ec6e8fa0c35add5d03282d
>> >
>> > Global radio email using AX.25
>> >
>> >   https://winlink.org/RMSChannels (1,336 AX.25 email packet nodes on
>> > the Earth and Space)
>> >
>> > This is all in operation by Amateur Radio ARES emergency
>> > protocols/technologies.  This
>> > will not pass the headline test when it comes to Linux detractors.
>> >
>> > Most of this is running on Raspberry Pi / Linux 24/7.
>> >
>> > If we want to kill all these apps and somehow force them into user spa=
ce,
>> > it's akin to just switching to Windows - and flounder with the
>> > Microsoft folks
>> > trying to do the same thing.
>>
>> Your email Craig neatly encapsulates just some of the practical and
>> ongoing applications of the kernel code in question - I don't think this
>> is in dispute.
>>
>> What's pertinent is if we as the ham/amatuer radio community can agree
>> on whether in tree, out of tree modules, or a userspace device driver
>> approach make the most sense.  If we are to keep code in the kernel in
>> any form, we as a community need to find someone(s) that have the skills
>> and bandwidth to keep the in tree code up to date.
>>
>> I don't think this would be onerous and I have a couple of people in
>> mind to nudge who may be happy to do so if that proves the right way
>> forward.  At a pinch I could do it, but that'll mean a lot of catching
>> up. But I think it reasonable that the responsibility here falls to
>> folks that are closer to the code in question than the wider and
>> overworked kernel maintainer community.
>>
>> That said, I think Dan Cross (KZ2X) earlier email makes a pretty strong
>> case for moving out of the kernel while still providing a way to have
>> backward compatibility, perhaps this might be the way forward?
>>
>> In any case, done well, this approach would not kill the apps or force
>> anything like switching to Windows! :) Great projects like digipi would
>> be able to continue with minimal changes.
>>
>> I wonder if a separate thread in linux-hams makes sense to discuss the
>> various longer term approaches to maintaining these capabilities - I'll
>> try make time later today to kick one off - such deliberations will be
>> of less interest to the broader LKML and other lists.
>>
>> Cheers/73
>> Hugh
>>
>>
>>
>> >
>> >
>> > -craig
>> > https://digipi.org/
>> >
>> >
>> --
>> I am slowly moving to hugh@blemings.id.au as my main email address.
>> If you're using hugh@blemings.org please update your address book accord=
ingly.
>> Thank you :)
>>
>>


--=20
Thanks,
Chris Maness

