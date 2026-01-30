Return-Path: <netdev+bounces-255196-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D34Ae7mfGlTPQIAu9opvQ
	(envelope-from <netdev+bounces-255196-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:14:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615CBCE6F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E76C305148B
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42335A943;
	Fri, 30 Jan 2026 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="P7j8RRw6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E635971E
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769792818; cv=pass; b=jNyj7W7dx7CifQNPbXAfgKCrNmHk4imMxA0JZq0ZLFVQBCMIyEtgU7IixFH7TkLDFkWE5ZIDvo7vqES7/ZqtEkhGmIfguhw2bAKvUUtqeZX0idBtMLCkKL16OIZnrlE1pj2X1iB0VLcdGPxjS5uEBqthPqFElQUAWrO/EPeggtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769792818; c=relaxed/simple;
	bh=eUxOHcVOxZOVybOf5KZUKuwaKQO597KFmV6MPa+TvMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VlcvDbuOeWOQ+hpK4aOnsvJCNSLVYjvLCo3Y73RaxUpuH8TmathBZLeHjXdyWfSdsA9BHvfup6rgWKheK63hfQpzESW6fF+ouA22iBsCXmu21OmsaOQi3A78fh2G5T5kBtr7kewOQNxGNbmIg+/kpPQOG8yuaZpT8hNAIrN7D80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=P7j8RRw6; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b6c13b68dso3144802e87.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 09:06:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769792814; cv=none;
        d=google.com; s=arc-20240605;
        b=W0hm2J0kqyVmhY4Q/wS4WwGVU+iOSxaF70V91NxREKvGlmbNIkCXWcRVrsvsUFw2hi
         f4+KRg3Myv3TX2bQLZWk5IJzu2HUtFqYECO5cN2jr8ZOAyYQpVsyFMRxxnUQwHHN1u86
         W8Nh/HIZm4mPNpm8X4BIWKsM15eQrRfE4IEyAVMTdDmsitH/LCVvaYzCzb96RVI3IU/V
         J+TUsirDVRO0rvxq3Iym/UOC5HyULaqan6LgU6h43ja0wDYZ//DxFpNxE2kn1Qr+7a/Q
         8Y2GSgG/nIifX7pbX80w0U1R4J6NxA6metIfl2jJXNda71uGXqFC3m+L3YY4BcwapmWf
         dJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SY/RtYrL9uUrBJipnltGZg4fdUSuf+85z80kgcLrjIU=;
        fh=q9nQjFw8ZEbNy9NnwsqLKRofNa3NEN32JgmXvy6R3jA=;
        b=YvloTovaHZWuRgxKxjdj5ot4IbPgeDwmaozxWzklBo42M27ZN2j4GizYPWCRySMoDJ
         MrLgE87CUVbB3jEM9/DQYN+AO8sPsgSZfqc950Zwjskh71nZbHkBUH9tA1QpRegYbyaZ
         3AqLQrED2zvDHGr4nvGYWS+lNTLwTDcFw4NOvYNMriez1J7vNY1PBSjt15hlZ6TDjoY1
         A6pF6MnFFqxqMm8ybtX9UR8/rPYu76Y/eblwCnALwWQTD30HngjxmPvbg1uzQYo18aP0
         eyx6Gy9IANbShCidYlG5Y+PIArXI/iYo6bqWonVj3QJmkGlhClOw8D+CHNUOpmk1NTMf
         5o7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769792814; x=1770397614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SY/RtYrL9uUrBJipnltGZg4fdUSuf+85z80kgcLrjIU=;
        b=P7j8RRw6kIzQpLN8NN+X0nB4zZn4YB2qTRYOISzjsg4tcBIbAPbLtVHNm8Cw8dfI1o
         RqpqobFzV9llt3fPlY5AdnGQitU2iqJVyf5OSyW8oxZO1NNINuYncqn5TX6oLzrSKUv1
         AFpK2jlfWki06DHol6tEyL+FhzZUHwJmJuoubEPQL04PXQ651rv+vY4uTeHyz+7ILsOL
         JiajaK+PRqrybL0l9tH6R8L7mJ3Z8T/Nf5SZjo/vSC6taV9HD2hWtNWDmoNnJoNknX05
         XWHzH6BOG+ubHbLrCIaRzkutYa4uIdEBZgg/xm6m0gltd07NQra2CePp9+c/+G38rtkY
         ZUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769792814; x=1770397614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SY/RtYrL9uUrBJipnltGZg4fdUSuf+85z80kgcLrjIU=;
        b=LqGHG1dbHGj7DfsSj64QuBfNwILer7Ot0MLwWqI59RDXY0wpdfaCDD8LYKQLdOk8ni
         sD7W63J1aGtM63BXCB4WPHa4OLWvW2xinIvg4wVtaz1MuA2ebPi27L5mfmQu8xtborui
         kgIhPcCBS++k4Ryl/5IK1HrddJ1/y/qbH+m25ijNv1fhO6kwSuplDnDUnWkhYHNyKTzd
         9PzZ6wH/VcNH0WuqDDfjS5NBN5eA1QbT9bJcJHkET7Whsqx53JR1xCwmqf4KKdvP4+VJ
         ilAiv1UWITMkR1Ei8T94XvhZ7/3T55hq3i4DqYVaqZ6axHXi7CtxGf1aI3Dm41Spl+My
         JcTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU39YU/RlWSmiWX5VwITPMad0reTVd4scDCyQ1ZXq8AZc1AOn8P5Mm7+wlp2+R7lrTi8Y7pPrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+pKrNO6RlCRFxHPT1ya8N4xChi/Z1z7pC/Ubn6ymGeBqRKcKs
	LJlEmNwe5COUUxc1wCPfPfvDBZhio6eEwBKgb8Uh/boT3Es2J1NLGaGts/1Ov1Z/Euky+fTVFhc
	aYCgzYt3TQKoVcq6uYFO37i7FLORMXWM+WZXTLNml
X-Gm-Gg: AZuq6aK8PkqL1wzWQ+AKqKYN/5swxu7jE9C2umHwDsHGDkOaAPRJiFlwKKGb5iJtbjn
	1dnoRSt523PGBaS7Fb9xQUf93GaGI0H0IXvtx8rBuKfkMVfkks0GX2Pc0VfFdkCCibx/md6Orlz
	cJCc4ncAknE10NJ71FjSUI0dlFMXZE8sDUaQa3CXprbE6Dyu2hRWQe161J575PixxhR3MdOyJnC
	NCJasVec8dYlW6fJuI5A7NX6DlXeNzmi1z1cb3wtZA8Yw/bsBi+a6rr9DyPOKF0WY3gP1+k6hXH
	5oT35HEaY/+ybfvhRudJ1Pdi2DKgHJFoii4hxUnJ+qRrL+gfiJGV/zRlFiFq
X-Received: by 2002:a05:6512:4484:b0:59e:ef6:62ab with SMTP id
 2adb3069b0e04-59e0ef66368mr3144353e87.16.1769792814296; Fri, 30 Jan 2026
 09:06:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126194826.236075-1-tom@herbertland.com> <20260126194826.236075-7-tom@herbertland.com>
 <willemdebruijn.kernel.19061eebdb902@gmail.com> <31232399-4cf4-49ea-b769-84aceca61dc9@gmail.com>
 <willemdebruijn.kernel.8e46b721f5ed@gmail.com>
In-Reply-To: <willemdebruijn.kernel.8e46b721f5ed@gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Fri, 30 Jan 2026 09:06:43 -0800
X-Gm-Features: AZwV_QgCJaqpyZsRG0Du7YFHlLnJHQpDf05WhObOFui3nXaUXUkiJph1sGoxbqc
Message-ID: <CALx6S37LRKzvGF8j93OECgDuVR9P4rz0DNMhM2JwaFziNq2vaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 6/7] ipv6: Enforce Extension Header ordering
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Justin Iurman <justin.iurman@gmail.com>, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255196-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ietf.org:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7615CBCE6F
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:05=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Justin Iurman wrote:
> > On 1/29/26 06:18, Willem de Bruijn wrote:
> > > Tom Herbert wrote:
> > >> RFC8200 highly recommends that different Extension Headers be send i=
n
> > >> a prescibed order and all Extension Header types occur at most once
> > >> in a packet with the exception of Destination Options that may
> > >> occur twice. This patch enforces the ordering be folowed in received
> > >> packets.
> > >>
> > >> The allowed order of Extension Headers is:
> > >>
> > >>      IPv6 header
> > >>      Hop-by-Hop Options header
> > >>      Destination Options before the Routing Header
> > >>      Routing header
> > >>      Fragment header
> > >>      Authentication header
> > >>      Encapsulating Security Payload header
> > >>      Destination Options header
> > >>      Upper-Layer header
> > >>
> > >> Each Extension Header may be present only once in a packet.
> > >>
> > >> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
> > >> enforcement of xtension Header order. If it is set to zero then
> > >
> > > [e]xtension. There are a few more typos in the various commit
> > > messages.
> > >
> > >> Extension Header order and number of occurences is not checked
> > >> in receive processeing (except for Hop-by-Hop Options that
> > >> must be the first Extension Header and can only occur once in
> > >> a packet.
> > >
> > > RFC 8200 also states
> > >
> > >     "IPv6 nodes must accept and attempt to process extension headers =
in
> > >     any order and occurring any number of times in the same packet,
> > >     except for the Hop-by-Hop Options header, which is restricted to
> > >     appear immediately after an IPv6 header only. Nonetheless, it is
> > >     strongly advised that sources of IPv6 packets adhere to the above
> > >     recommended order until and unless subsequent specifications revi=
se
> > >     that recommendation."
> > >
> > > A case of be strict in what you send, liberal in what you accept.
> > >
> > > This new sysctl has a chance of breaking existing users.
> >
> > Willem,
> >
> > Note that RFC8200 does not use normative language, which is part of the
> > problem. It could theoretically break existing users, but I don't think
> > it will in reality. For that, you would need users to beginning with
> > (joke aside, I like EHs). Anyway, if the order is enforced at sending,
> > why would any receiver accept a different order? In this case, being
> > liberal in what we accept might be a security risk (see below).
> >
> > > The series as a whole is framed as a security improvement. Does
> > > enforcing order help with that?
> >
> > IMHO, any packet with EHs in a different order than the one specified i=
n
> > RFC8200 looks suspicious. So, yes.
>

Hi Willem, thanks for your comments!

> Looks suspicious. But does not introduce concrete new risks?

Hard to say specifically. On the other hand, there's no known use
cases for alternatives for it and given all the other security perils
a strong default security posture wrt EH order seems prudent.

>
> The main risk I understand around IPv6 extension headers is the risk
> common to all untrusted network input: bugs in parsing code. Bugs can
> cause crashes, infinite loops, or worse subtle effects. This is why we
> introduced the BPF flow dissector, for instance.

I believe the main risk is Denial of Service attacks and security
vulnerabilities.

>
> I don't immediately see how different order of headers increases
> parsing risk. Nor, btw, that reducing max number of headers from 8 to
> 2 significantly mitigates a real risk.

It's a similar rationale to putting a limit on the number of options
in the first place. Going from 700 options allowed in a packet to at
most 8 allowed was a no brainer. But even 8 is too much considering
that the stack only supports three Hop-by-Hop options and two
Destination options. There's a common misnomer that only hardware has
trouble parsing TLVs, and somehow it's free in SW (I've been battling
that mindset!). For instance, a well constructed attack could force
one cache, maybe two cache misses per each option. So going from 8 to
2 as the default limit could materially mitigate the damage for a DoS
attack on options.

>
> No objections necessarily. But I don't fully understand the argument.

We selected the default value of eight in RFC8504 based on an
expectation that there might be new options defined and that the
Internet would be fixed to reliably support extension headers
including those with options. I do not believe either of those are
going to happen.

Hop-by-Hop Options are ostensibly the right way to do network to host
and host to network signaling.The only HBH options that might get any
substantial deployment are Router Alert option and IOAM. The Router
Alert option is being deprecated and IOAM is at best a "nice toi
have". The best use case of Hop-by-Hop options is congestion
signaling, unfortunately the die was cast when CSIG authors decided to
place the information in VLANs at L2 and cajole the information to be
routable through a switch. IMO, the miss on CSIG pretty much is the
nail in the coffin for Hop-by-Hop options to ever be widely deployed
(https://www.ietf.org/archive/id/draft-ravi-ippm-csig-01.txt).

Destination Options have proven even less useful than Hop-by-Hop
Options. The only Destination Option supported by the stack is the
Tunnel Encap Limit option and Home Address Options. The Tunnel Encap
Option was buried in the v6 tunnel code which is why it wasn't obvious
it was supported in the first version of the patch set.  I'll assume
this might be useful, so this patch set cleans up the code for it. I
don't believe there's any use of Home Address Option.

A major problem with DestOpts, HBH, Routing Header, and Fragment
header is that they have no inherent security. Their use presents a
security risk especially when sent over untrusted networks including
the Internet. Given that and that the high drop rates of extension
headers on the Internet, I am proposing that Extension header except
fo ESP being deprecated on the Internet
(https://www.ietf.org/archive/id/draft-herbert-deprecate-eh-01.txt).

IMO, IPv6 Extension Headers are a failed experiment in protocol
design. The vast majority of hosts do not care about them, and the
best use case for them is Denial of Service attack. So IMO the greater
good is to limit them as much as possible. If some private network
finds a use case for them they can also configure sysctls if they
don't like the default behavior.

Tom

