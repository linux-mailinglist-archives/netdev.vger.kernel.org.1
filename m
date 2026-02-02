Return-Path: <netdev+bounces-256022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGcOIZwjgWmlEQMAu9opvQ
	(envelope-from <netdev+bounces-256022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:22:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC17D21D5
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 23:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B9C33017BC8
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34DE34B1A5;
	Mon,  2 Feb 2026 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="Ud4Y4dKi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A43491F5
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770070920; cv=pass; b=OpP+fLPqLQZT9uWDvsQnBErKG4UWbzPPASAv0QuLjqR+mQNih+uLlLfFh2lHujZfjGtXIMGL6NXMJ8jP+Jk1jUrslv/oE6HnykbJQc6ks9l5J72LINew/y/a2cgJbgaiCkFrlN5MqZdMzoFrwqrkwfaL2rYu5K7f7K8O9MvfUvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770070920; c=relaxed/simple;
	bh=jSibtwx6yAvSwaZYLdAH13D5c0/S6RBCjJ96NnnnqHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5c0DS6c1b4S359eB7q42d1SE+/37nvhX1rAnnQLye9QZqcCqVdMbBp7PwxsEGbKt4lYs1gfa8MrWlauO0Lt/FaRyc8BfHxpYA5w6QLKP/7AxBmlcyt/P+ltpd/jJ6PD0DJC9mVYK4TJ/r2mxKb18XCjtMNLNkZmEJ8UH4938WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=Ud4Y4dKi; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e17afd2d5so4449636e87.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 14:21:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770070916; cv=none;
        d=google.com; s=arc-20240605;
        b=LsFCRuY9wJdHYGgEwCZdw0Xyf98osFyCg9yBB91mbovpUYZWtN3RVB87+OrsIBSTPZ
         9MADz5tw0kx833aSOsBRQlBxipT8rxY0+5YKISyQOJEG1d4HrDlQ2lyd2iELVw42LGfi
         +I/+YoBT3rj62iomUpa10PpyPeOUwKeH1fReJGTuwC0I+t6A93czyLh1ORUwQwn/Gm+a
         lB53EFjw+9F+JAr47uVh5Jyzh0M3GIEYfek7aFmS8gcY8IuhKcy4OT9u3Dg5kuDMxFGT
         fOKzj+5G9VJRzavVVRbgAdFz0XR+v56jvwkFmuEQ8Udk6JsOivr03Swt6itLushR6xhA
         T5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZdMYL55NbuxXMsvTGqhp3Jevv9Bp9uyf9kPZ/0v+F8k=;
        fh=YnnKTxHoEqUFOxOYRf98qh3WUyutnbUQEGDSMq2CZGk=;
        b=cR1MC84Qsl9pu2yzvms4yZ7AmurzYIe2/TPJkkCcT6oIuvoKRry55H5utXAwqU+D3C
         J/EjDD+owZbf60QP/HJDgo0z41A7OJcCB0CWpSBGMl5Jgy5fN2S3sb6V0hDgWWYg1THM
         jG/ifvCqPGdqb90LO+CTeeiyj7AzxFnqD1SoySq+yPq9xPHwVeOmB8coDzmiS1nyHTe9
         qGlFNjTlPGl0FdhbwqhTKnbwLSbB6JsU8vGsoEI4FLsoznu10f8RSsgNrBkg2gjkhMw9
         K88eSPItDwyfnYvISdIiWnNj70BVy32a3oQ7mT3Loyp1CIWF7+HDdKvMIzxp0g3SXXmj
         u7OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770070916; x=1770675716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdMYL55NbuxXMsvTGqhp3Jevv9Bp9uyf9kPZ/0v+F8k=;
        b=Ud4Y4dKi/Vd3mYgVaDhe61km3jHupyFCXk/Z8b7pREf+zmiO0F5zC9TqAq+INcPTw2
         1dKulKs4KjjW09/dZGIes+tJfggSydTfHo2favi2p6hLhXxginS774lmC+W5ydirxisJ
         qDrXGEq+PrgriGYozqEpaQ1toEv9Ea/SRZR4jpOUAzbuTPRggeqeakZFpf6GqVwjbgma
         /8EhqW9st9GZuGQ8fsQlu8XsddnCoXh7XsrG4zJ4D75PeqDLtgu+jizH1HkEj9EPCNId
         EpOQL0QW+3dGlw4B1ZBpScSa7MDqy7VBFvXKYptFBDaEvDopdxSDBExw+OVU4RoiaoBQ
         n02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770070916; x=1770675716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZdMYL55NbuxXMsvTGqhp3Jevv9Bp9uyf9kPZ/0v+F8k=;
        b=i4WkrULnV5J32dCIaBT/Pe5pGh/NsLZ5ixsUgC3AqRK3SAJ2Wqy8O48xwKjOfLxJoP
         vhs7IlR3+Z9AuJk6Ihyl9o/wVYeg8sgKAIBzWyUh0sGEe33H6A1JHdUBixpXLwt9KV9o
         Lz9f6H+P4b2HGbbhPAR601W9vBXBuJBqygaRwrJwXuYVtDjJ/XyCR6+FjcM+9h6m2EaZ
         7CFekZNzmAKLs7Dw1uy21SYZswACvAyeykRJANNviAR1G5lpJvg/akPcWvjE6bPC7Yxg
         spycMsLL0u2QKNGV0/z1VlghxzyMB+cjlDYlgXbVltBIGy9REhUwnWfvCLmMxjr4E5sJ
         1tvg==
X-Forwarded-Encrypted: i=1; AJvYcCVVfgKGB9kmH0y3W4Bw5ceAPw9GG8NaQepCFlyyAHZGGngkdzur0TH/BUZ0Fvjh8+7PQ16ze1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxusPhwcPKAvMWVwTB9NL+fdVuYzAMwUS6Qn8gVdNJE9tCl/EHB
	znQbtZuusz2wSeMQVjSAik1cfK+dzMmLdCHbqGgPbMVuVE1YRQiBNd7r6jeuiNWsH03ucs/ZDGl
	8I4SqPHRE2DBqZVM5//KN3F0zupWvIeqW/Sldtp8J
X-Gm-Gg: AZuq6aIUyzgftu1MkzYtSVwNPF8CPi4BVzf89Rr3/96uUN35FC0ww5Sr+nNWqZqyKB+
	P5asaRotvywXXS+aB+mSBzEnaK/PtEuOLEVmX2MducIHQ5C4a6z6JDO/g47rkamwQvt/+sUlKpF
	DTCfUlyo4abHJ77aP6FTsrDs+QlBdPl1mBkchyxPsl6kEGaW25VXHGvticYtS46VTDWgi2uky4C
	dpaE7SEpsm88lO3vbAYMAq73TwSrvtQIKo9TP29k8JqHpltm9obcly2V2DSWV4ttLBRf6DMtzHO
	Lx7OSDwgGwjUeVTetg3FDgi2UR8RoWnq/sm3jITs2ss4Xz28aLT8yojyFmf/
X-Received: by 2002:a05:6512:238f:b0:59d:d32b:1d28 with SMTP id
 2adb3069b0e04-59e164328b1mr5358505e87.34.1770070916103; Mon, 02 Feb 2026
 14:21:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126194826.236075-1-tom@herbertland.com> <20260126194826.236075-7-tom@herbertland.com>
 <willemdebruijn.kernel.19061eebdb902@gmail.com> <31232399-4cf4-49ea-b769-84aceca61dc9@gmail.com>
 <willemdebruijn.kernel.8e46b721f5ed@gmail.com> <CALx6S37LRKzvGF8j93OECgDuVR9P4rz0DNMhM2JwaFziNq2vaQ@mail.gmail.com>
 <willemdebruijn.kernel.b21ec5446983@gmail.com>
In-Reply-To: <willemdebruijn.kernel.b21ec5446983@gmail.com>
From: Tom Herbert <tom@herbertland.com>
Date: Mon, 2 Feb 2026 14:21:44 -0800
X-Gm-Features: AZwV_QgHIyXiT5izvAnODnNoy7Wgkv0EmXPJn9CLP10eftnPVPduRMp5W9jk9VU
Message-ID: <CALx6S36CjFQcNWmLOCbgrfK7RYXri4POJLGWsiD8y6KkfNbo9Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256022-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFC17D21D5
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 9:24=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Tom Herbert wrote:
> > On Thu, Jan 29, 2026 at 11:05=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Justin Iurman wrote:
> > > > On 1/29/26 06:18, Willem de Bruijn wrote:
> > > > > Tom Herbert wrote:
> > > > >> RFC8200 highly recommends that different Extension Headers be se=
nd in
> > > > >> a prescibed order and all Extension Header types occur at most o=
nce
> > > > >> in a packet with the exception of Destination Options that may
> > > > >> occur twice. This patch enforces the ordering be folowed in rece=
ived
> > > > >> packets.
> > > > >>
> > > > >> The allowed order of Extension Headers is:
> > > > >>
> > > > >>      IPv6 header
> > > > >>      Hop-by-Hop Options header
> > > > >>      Destination Options before the Routing Header
> > > > >>      Routing header
> > > > >>      Fragment header
> > > > >>      Authentication header
> > > > >>      Encapsulating Security Payload header
> > > > >>      Destination Options header
> > > > >>      Upper-Layer header
> > > > >>
> > > > >> Each Extension Header may be present only once in a packet.
> > > > >>
> > > > >> net.ipv6.enforce_ext_hdr_order is a sysctl to enable or disable
> > > > >> enforcement of xtension Header order. If it is set to zero then
> > > > >
> > > > > [e]xtension. There are a few more typos in the various commit
> > > > > messages.
> > > > >
> > > > >> Extension Header order and number of occurences is not checked
> > > > >> in receive processeing (except for Hop-by-Hop Options that
> > > > >> must be the first Extension Header and can only occur once in
> > > > >> a packet.
> > > > >
> > > > > RFC 8200 also states
> > > > >
> > > > >     "IPv6 nodes must accept and attempt to process extension head=
ers in
> > > > >     any order and occurring any number of times in the same packe=
t,
> > > > >     except for the Hop-by-Hop Options header, which is restricted=
 to
> > > > >     appear immediately after an IPv6 header only. Nonetheless, it=
 is
> > > > >     strongly advised that sources of IPv6 packets adhere to the a=
bove
> > > > >     recommended order until and unless subsequent specifications =
revise
> > > > >     that recommendation."
> > > > >
> > > > > A case of be strict in what you send, liberal in what you accept.
> > > > >
> > > > > This new sysctl has a chance of breaking existing users.
> > > >
> > > > Willem,
> > > >
> > > > Note that RFC8200 does not use normative language, which is part of=
 the
> > > > problem. It could theoretically break existing users, but I don't t=
hink
> > > > it will in reality. For that, you would need users to beginning wit=
h
> > > > (joke aside, I like EHs). Anyway, if the order is enforced at sendi=
ng,
> > > > why would any receiver accept a different order? In this case, bein=
g
> > > > liberal in what we accept might be a security risk (see below).
> > > >
> > > > > The series as a whole is framed as a security improvement. Does
> > > > > enforcing order help with that?
> > > >
> > > > IMHO, any packet with EHs in a different order than the one specifi=
ed in
> > > > RFC8200 looks suspicious. So, yes.
> > >
> >
> > Hi Willem, thanks for your comments!
> >
> > > Looks suspicious. But does not introduce concrete new risks?
> >
> > Hard to say specifically. On the other hand, there's no known use
> > cases for alternatives for it and given all the other security perils
> > a strong default security posture wrt EH order seems prudent.
> >
> > >
> > > The main risk I understand around IPv6 extension headers is the risk
> > > common to all untrusted network input: bugs in parsing code. Bugs can
> > > cause crashes, infinite loops, or worse subtle effects. This is why w=
e
> > > introduced the BPF flow dissector, for instance.
> >
> > I believe the main risk is Denial of Service attacks and security
> > vulnerabilities.
> >
> > >
> > > I don't immediately see how different order of headers increases
> > > parsing risk. Nor, btw, that reducing max number of headers from 8 to
> > > 2 significantly mitigates a real risk.
> >
> > It's a similar rationale to putting a limit on the number of options
> > in the first place. Going from 700 options allowed in a packet to at
> > most 8 allowed was a no brainer. But even 8 is too much considering
> > that the stack only supports three Hop-by-Hop options and two
> > Destination options. There's a common misnomer that only hardware has
> > trouble parsing TLVs, and somehow it's free in SW (I've been battling
> > that mindset!). For instance, a well constructed attack could force
> > one cache, maybe two cache misses per each option. So going from 8 to
> > 2 as the default limit could materially mitigate the damage for a DoS
> > attack on options.
> >
> > >
> > > No objections necessarily. But I don't fully understand the argument.
> >
> > We selected the default value of eight in RFC8504 based on an
> > expectation that there might be new options defined and that the
> > Internet would be fixed to reliably support extension headers
> > including those with options. I do not believe either of those are
> > going to happen.
> >
> > Hop-by-Hop Options are ostensibly the right way to do network to host
> > and host to network signaling.The only HBH options that might get any
> > substantial deployment are Router Alert option and IOAM. The Router
> > Alert option is being deprecated and IOAM is at best a "nice toi
> > have". The best use case of Hop-by-Hop options is congestion
> > signaling, unfortunately the die was cast when CSIG authors decided to
> > place the information in VLANs at L2 and cajole the information to be
> > routable through a switch. IMO, the miss on CSIG pretty much is the
> > nail in the coffin for Hop-by-Hop options to ever be widely deployed
> > (https://www.ietf.org/archive/id/draft-ravi-ippm-csig-01.txt).
> >
> > Destination Options have proven even less useful than Hop-by-Hop
> > Options. The only Destination Option supported by the stack is the
> > Tunnel Encap Limit option and Home Address Options. The Tunnel Encap
> > Option was buried in the v6 tunnel code which is why it wasn't obvious
> > it was supported in the first version of the patch set.  I'll assume
> > this might be useful, so this patch set cleans up the code for it. I
> > don't believe there's any use of Home Address Option.
> >
> > A major problem with DestOpts, HBH, Routing Header, and Fragment
> > header is that they have no inherent security. Their use presents a
> > security risk especially when sent over untrusted networks including
> > the Internet. Given that and that the high drop rates of extension
> > headers on the Internet, I am proposing that Extension header except
> > fo ESP being deprecated on the Internet
> > (https://www.ietf.org/archive/id/draft-herbert-deprecate-eh-01.txt).
> >
> > IMO, IPv6 Extension Headers are a failed experiment in protocol
> > design. The vast majority of hosts do not care about them, and the
> > best use case for them is Denial of Service attack. So IMO the greater
> > good is to limit them as much as possible. If some private network
> > finds a use case for them they can also configure sysctls if they
> > don't like the default behavior.
>
> Thanks for the detailed context, Tom. May be good to fold into the
> cover letter or commit message if respinning.

Will do.
>
> One remaining question: these features may be largely unused by
> Linux systems, and Linux peers can be expected to follow RFC
> directives on ordering.
>
> But may there be other peers in the wild that are not necessarily
> malicious, but just less strict. IOW could this break legitimate
> users in the long tail of use cases of Linux in the wild?

It's exceedingly unlikely to be a problem, and if it is for someone
they can set the sysctl. I would also point out that the stack already
disallows having more than one fragment header.

> Probably good to explicitly state if we are not aware of any.
>
> Or abuses of extension headers for private reasons inside non-public
> networks.
>
> The risk/reward of lowering from 8 to 2 to me offers at best a small
> real increase in security, but it may have real regression risk in odd
> installations?

I think it's very unlikely to cause any issues. We reduced the number
from infinity to eight without any complaints.

Tom

