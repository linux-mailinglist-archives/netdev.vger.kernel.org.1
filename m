Return-Path: <netdev+bounces-301261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T102DroYOmqc1QcAu9opvQ
	(envelope-from <netdev+bounces-301261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:25:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3616B4293
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 07:25:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=DmH1FXGH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301261-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301261-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA37303AF2A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 05:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF5A3A7F69;
	Tue, 23 Jun 2026 05:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E85813790B
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 05:25:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192311; cv=pass; b=ELTBEPapPA7hfS+Y0Yi7Eip18fpVnj6bKHPu38xcF7cwvE1PLPVj8bnwyVi1/Znso0xARVyTngVDZyBRBMqItDLFuDkQs972K6lejRKtOufA4QF31EcvZQgOMa3mo3gLQB22R3gTP5cSpxxCRTtdRJa8Tzs0C+PzZzfoUBIzt/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192311; c=relaxed/simple;
	bh=bafH7SfCvZZYJJlRd6r3UJ6BDIENx2mwxSoHNd+2Mak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVaNZiHGpsyhLgwNxOuqoK/QE+ae5OvxlpxYWv/DA1WrAAGSJQBdOwGkibJ5H1N2gDdQQPLSsavlLuHtvmpj774twIfYzOhrK0Bo7R5EtfdtB3O57AhQ92UhODHrZRjs/Ey6MipSIytKYrEvx8rmHfKEqC9GpqJr6ubTeRTYDbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DmH1FXGH; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-517b1f2c6adso46668301cf.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:25:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782192309; cv=none;
        d=google.com; s=arc-20240605;
        b=bY9025TwlOagveNWlpW9RGwctnz3W1LF7A+wPR26CLjFgDQsx5FDchfdVMROxjbTeV
         z242Bp5xXU8l6oKRL0EM5NiM6sPOHLz3gMcup01O2amebxxNiRS0EHHVMHXhZ2PN2rM7
         bdRVZ+8gCiQ1hIV0FWpxSUgO2DFTeDHLmPEcrnq/ntEcANVDAIhgOMZAQ9kzRIJNHCE5
         6SATLMh44Eg7ptoB2B/yKorSg3HaUXKKAsnQ1ok9dy2LvxrT9ErbgriQXP4OTylL34cv
         MrFyPlL5pa86zaHoCve0mkf8auQLsBYjdh0Z8At35brOQ6BEQNyikbfr6I8Xcp4wyY8g
         JwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=su7vB+T2G0XZpcIOEK7YwCiwTZ2c3jrfADaCXTfNy1U=;
        fh=JhPro8i5iQuIoPzFo1JERbUPl9Ji/axW9NG58EeH32U=;
        b=JzJK8VvPcPX60OLpD5LQXyLnJg36ttvK2q4z+KdHJu7rQd75YzKH6xptjrPrWhOv19
         JU+gV+pVbH4Hta16wRZ8h1FI7fVwr6RqOljULvJFt37wvkBTUAwgrm3BQRnksVPQ2aXG
         Mcl7dIEGBehHGWW2MnTaDNSCgnfZzLRcVmUHPvTAtQsReZanCALv0cdTqYdfGxJsrnWU
         AL1vOBC2id7Yem6jbkNnHbJ77QPelikE/AEsj9R/erANvEAGV13138ax9jIJwFhErlxN
         ZuJqcZ/xxYeP9qqZAdYkd5HitOFYMjPL00O3bIFirGJ6fBqO51rRwO+mCKs2uAhPhlIY
         B17g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192309; x=1782797109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su7vB+T2G0XZpcIOEK7YwCiwTZ2c3jrfADaCXTfNy1U=;
        b=DmH1FXGHjbj2RH497vZYXyCo/WbI/TTe/xZxtcm5OEiVaA1JEXlgSDapeVXZUBuAQ6
         pQk5FGWDWAAkXM8rjz6CYfEOCjrTPUmuIERc331lJAxnr/O5ZDvkP1Z/g/U+7BE6pa3P
         AzG7tGgbfnaHPDGKman46nFqNBleQdMGF0zf6M5HYkE5K4lqbaSClkMjC90KvC58KFdj
         XjuelXt7+8u7Ha54fY5T0wbkGkYdGGTTP5bh0oiyiEkhE0gwCujsACXu/rqI00usyq4/
         jcUHNy2suQt4l3kSAsR1xQN1VFjmow95HZZZzXMu7ExdUUqeEsB96YzcJS5AaUitSeS0
         qnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192309; x=1782797109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=su7vB+T2G0XZpcIOEK7YwCiwTZ2c3jrfADaCXTfNy1U=;
        b=ss6PCeVgc+qCMr0azGGhb9gQWu0b2hbghP97ijSLUfNxa4d9eAP8dlEmCI35GzjHIn
         GXPpjsY3QPB/d2z9Z8p896VSt7bhG/xlYWMjJvXjuZYYlAQ+vEhrlt7KZJjv6aUSR/k3
         wz5UrKfbTaB6978m7PR9Tq9MC8pcicYpk023HC46RiANqIN/InGk4mu700JkxCno+EDQ
         iL8iws6Lai2xLk8YNM3GeUv74mj0FUB0EtqFW6QEzEJj4f4uYMykDNd3/FwMu99r7m79
         ns1uc+WAhYk1oy4M7ZGs42Ey1LMHgQPjm0QHFPUcXip6XfiligrLBXBF+7/YX3pUdtjr
         406w==
X-Forwarded-Encrypted: i=1; AFNElJ+Pt9oTre5ZboAu1/Cz1kn3sn2WdmCl3JtYHOw/E5BJh4NdKj3Pn3IkviYvEfYuiMnvGGS0lPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFKKlaaq/xGMjrUb3e+lL6yFDjgDZe0YJ05UxfF7RHA9ZNiJM
	1eMgmTkiOZsYA/25qnkRn1OhVBbqU63VC5IUiI6CVtATuzQt8ukRX/1Dc4YS2uEde0nZMjUr17H
	e5H6pRTuRdoCqod62iC1BDokh7drbAts8ueeRLqBU
X-Gm-Gg: AfdE7cmSYgFjhQ6fpNHSs7Li0tADf3W0RRV8/d0lmW5yL8/NIl3Cu2MizRcFsr3pfFG
	LL5pV0IwKuMq485Qti7PkIRYDkP6ArgrJCaBv/FZ3H5OlRlv8Rg/1d6H0cS++mZHeO39ngxOkZW
	oxpUozvqhipVb1T5Vh+5p0GvsBXY4nwf2OFLGgFIyU2JTg+lmMKv70e+eAw8WkJ6N25llO/4A2z
	ucadkvNoZM0EdHMUujcjBZmQ2tmBjMgzKrhvDvqy7EcQo+tgK7sYAVgKQNxuw/2Bh8yguslfIWl
	vnQPnAplqiFJMnSTsQxxNgHfAkWvWeg9da0YQfq/xVQk2XNcq/MRjRqboM5HwvqzdYCjwCo6a4g
	zr6N6Ebv8
X-Received: by 2002:a05:622a:1e85:b0:517:8315:d6a5 with SMTP id
 d75a77b69052e-51a54904ea0mr22334671cf.55.1782192308855; Mon, 22 Jun 2026
 22:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622185248.1717846-1-edumazet@google.com> <CAJwJo6Zc7Raz9HkKEARouSnz+FgTi9C5kAA+sa=-5Cg-CLe=MQ@mail.gmail.com>
In-Reply-To: <CAJwJo6Zc7Raz9HkKEARouSnz+FgTi9C5kAA+sa=-5Cg-CLe=MQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 22:24:57 -0700
X-Gm-Features: AVVi8CcrWVaMZ6ogMWyZXFM2qlZ3akVg5id-brtYc-W18NivwQbTqVipUEcH-yI
Message-ID: <CANn89iJL1sx4Jmb3P4cKiEqP_FmWQ3N1BwfH15LHwhFjUoCYsA@mail.gmail.com>
Subject: Re: [PATCH net 0/2] tcp: make TCP-AO lookups more predictable
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301261-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:0x7f454c46@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E3616B4293

On Mon, Jun 22, 2026 at 6:13=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.co=
m> wrote:
>
> Hi Eric,
>
> On Mon, 22 Jun 2026 at 19:52, Eric Dumazet <edumazet@google.com> wrote:
> >
> > This series fixes a TCP-AO key lookup precedence bug.
> >
> > TCP-AO stores MKTs in an unsorted list and returns the first match. Thi=
s
> > allows newer, less-specific keys (wildcard VRF or shorter prefixes) to
> > shadow older, more-specific keys if inserted later.
>
> Yeah, at this moment, TCP-AO doesn't allow any intersection of the keys:
> If you have matching VRFs, matching keyids for matching peer/masks =E2=80=
=93
> then when the userspace tries to add the second key, setsockopt() is
> going to return -EKEYREJECTED/-EEXIST. This is quite different from
> TCP-MD5, where the most matching key is the one that's going to be
> used by the kernel.
>
> This simplification (not allowing any key intersects) is mostly from a
> very permissive RFC5925, where MKT matches can be: ip-addr/mask; ip
> address ranges; wildcards of addresses; tcp ports. So, this part was
> intentionally simplified until there is a user who requires one of
> these things. And based on their requirements, a better data structure
> than a simple list could be used. Basically, the longest prefix match
> is like adding power-of-two ip ranges. Also, that's another reason why
> I wanted an extendable setsockopt(), where one can add new
> flags/fields to uAPI without breaking the existing users.
>
> Anyways, if you have the requirement to have intersecting keys with
> bigger mask matching (imitating TCP-MD5 behaviour), we can do that,
> but I think that needs a new TCP_AO_KEYF_PREFIX_MATCH (or something of
> a kind). Then the keys with everything matching, but a prefix could be
> added to the socket, and the longest prefix match will be used.
>
> I think one API decision should be documented straight away (besides
> the key flag) =E2=80=93 how this flag works with multiple keys.
> Say there are 4 keys on a socket, all match the peer being connected:
> keyA: ip 10.0.0.0 /8 (keyid =3D 100)
> keyB: ip 10.0.0.0 /16 (keyid =3D 100)
> keyC: ip 10.0.0.0 /8 (keyid =3D 101)
> keyD: ip 10.0.0.0 /16 (keyid =3D 102)
>
> So, keyA and keyB obviously will have to use this new
> TCP_AO_KEYF_PREFIX_MATCH. Should keyC or keyD be copied to the
> established connection socket or not?
> I'd think the presence of TCP_AO_KEYF_PREFIX_MATCH flag on keyC&keyD
> should also affect whether they are copied or not. If the flag is not
> on keyC&keyD =E2=80=93  they should be copied to the established socket
> (together with keyB, preserving the previous behaviour).
>
> Otherwise, if they have the flag, what should happen?
> 1. keyB + keyC + keyD
> 2. keyB + keyD
> If we go with (2), then if a user wants keyC on a socket, they could
> either remove TCP_AO_KEYF_PREFIX_MATCH from keyC or add keyC1 with
> mask /16 and the same password as keyC =E2=80=93 slightly inconvenient, b=
ut
> quite flexible.
>
> What do you think?

If intersecting keys are not yet allowed, I think we must return an
error code at the insertion stage,
instead of hoping the user will do "the right thing".

Thanks.

