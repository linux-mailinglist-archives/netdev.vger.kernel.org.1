Return-Path: <netdev+bounces-277514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHiRAiJB2WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:27:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DCD3DB72E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD5DB3014BE5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3313E2758;
	Fri, 10 Apr 2026 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIcbLRko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC913E3C4E
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845456; cv=pass; b=B6Kvbd+mWpahlSpZlT1DrZHFEODdB0Kmo3XoJrF9Gs5xs2dA+rPM9b9xf9sYWWmHth1gkcKRVT9/FrlBWDnRy2+53ytzEuuJnhMhJf9P29hwzWowFeNZibcVP6kQdA/4EGhyv3HKJwpOKUjFMO/+1S5XZzEynormzDuC3Q2Lh7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845456; c=relaxed/simple;
	bh=EPE5zIbtuB9mtkemOydEeLuD7X/WZ572Yk/Mfjs+cuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZaJ9CEvcC08P8QS9AF9jY2fwXq4wqx7sZSGHCC96YqQu3vKnYbZ3kcGQ6jF7kmWgLAYolubi6x1JbEC6FryQlZixToAWHjETJLdZMUcLIRbOWcT9XHNNqIhye3rI2hi1b1bVPsQNSzG2ay/X6O0njSiHttBOlS1LeTppFNonEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIcbLRko; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64edf260b49so3649700d50.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775845454; cv=none;
        d=google.com; s=arc-20240605;
        b=drwSvObwmHmWeT20FYsagHzj559KQyIWnWn+Aje7tVtO4qbpKjIwmDwM9OIafrCK+k
         9hb8bg1ZXvFYRSOuHtp6waVsEC3EJyckflvEsl7Wd2m4m9cXInFrJfp04OBa4wproFjQ
         GGXXBy4/5BYfkYAzP3k3HOFCgjmaFMxk2LJqR/NrunKZ+GFACUeES12NK5aU5t0tWO+X
         K6TWpuplIhqzZdVUmvKyrhP3XsPfGgTFUaCrajufOAPM8DC6YD8TiFv0IsiBoWLyxuai
         CpegMFHCnE/5MbetHhqyHnVRSCAmwGgL3PoqwBP9Eq4H5EwM1gWtGfPzfyEfvESJLG8Y
         4zag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OJal6zY8DzVlZERvT/baHzRbKlhu4zXHBYN1HlP+LdY=;
        fh=1auwjbI2VGBKUWmJpibQ56VZ22+lMVm/0B0UMGePahE=;
        b=Ax/9GTtGQJZDO+mYbV2ZAfQANP76hqUk1CNhO3Sg5flL2OPQC/8nptFlAOFCk70fZ9
         hfBCpuqyvthUvIg377VVeROSIpkflK82o0SYjrcH+Cr2hAlgaSBxZPpv0O9V5u71Z877
         Tyf6+E4LLIArjobFf3pLGHnnB1RQuWRqwz7P8LKfVq6tHB2v564IN0MnsOijHZpRU1VK
         KCimxaRd4ok+AmAvXkW6AH116tqUJuPYgXi8MQHmnoTrODOttD2MMUY8B1kPkjMDwPhc
         oSukhRShJ7J3mPI8/PO/rx31BU5cyvzTkhA9+CGAvZ7ISucavBL5QToCM97ThGWvaTjr
         ceww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775845454; x=1776450254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJal6zY8DzVlZERvT/baHzRbKlhu4zXHBYN1HlP+LdY=;
        b=iIcbLRkol0GjO2Vqg4DjEfXCRn5IDJj2/Yx7mI+yyOyET1qhmx0rsx9JHhPayC0YoH
         jbhegpPGr6enzOM6JDxizowcArjzxCD1zdh0k0ykSUOdPcjhhfJOD5H3tI8c94DHUi5u
         XVQmnE1wq+RucEqzJecrBrjAvrrjKScBh/NY/XhlgAatnwD5UnQfEDAef2EuMjR5Uip/
         m3Iur6YKmcouXwih3JSeUYin1ciFcQ4J2rDyTUfTArJ+FM1ht7MlQurmc+Gd0ZmcnXsM
         9GpgaHVIcByC78OOjZEC9cmcXQVP4HQZRJQ2TqY9/hETX6emysvJfBSCm60VnOLXNKMC
         FhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845454; x=1776450254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJal6zY8DzVlZERvT/baHzRbKlhu4zXHBYN1HlP+LdY=;
        b=SvS7xi/EdH3NWygJuvoABqlV9D0Xg7am+JnnSwcrSyl8OZyTQUE60mLleQVNX/ygGD
         QD3uw1xdZgZQAVzfSn/lGMSQWuBxD15DmNQ5+z2XNXFohUTdqvQAcGDnAhwP354UB0QH
         ColLcQMe5ftAa145xtKc2JsJ6tXau0gBe5j8kUBq01r7bL2ZFCh/o3gThe91eanfi+BK
         fQ32oSC/Nhmx0p4qsuL9QG70eUKxg1QqvuyBNWDHdjH4SyBGl/FDtMwjQcJ1vrbXMhaH
         /HdAuL8EctKB32Bu5U87Yh1U6hxsghCpJ1lzi+g3wRCXDvUKhKnUcr6fHoL48XGcCZlX
         yOPA==
X-Forwarded-Encrypted: i=1; AJvYcCXazEYWKNexAVwFrLJzFTMNZ9lh/LXWqA4Sa0JQVYTLvnOZhaz9FShT5S0uHTzr4gq3lTFDjSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdHAozfDJRbdJV/4HUOgJuoXIiTqEtV6o9HgnltMxVL2Rg3Gs
	izr1tB+c49VaWaDMDQ+bPQQCQi7tURsVBrTIJ2umLOs/MawlzUGPWxMbogMvwqGnXdYa5ruI/xY
	93f33FCwEWO7dAHYFSQRUu4JUV0mOsllgz8o6
X-Gm-Gg: AeBDiesmzJF9JKJaka1br7a7q9U8T/GvvNPmLkjus1Bxu0PhapjzQ5Jnf0GIcw8np77
	yS0Qp+kMZp08GJPswCDJZH5SP0bsWb83vH1OKkVQ9VHPmAVdnONJFEgTre6MVhFy8tzCxgSquPc
	7U7GCiUqQlusFTKgc/NJ30v8mykrtANWiup2saWA9bKl7cWbifR5lLFNHH1weeYar0jSyQn380z
	feTEkyQybsbBfN4rSOmhB3r/6fzzrnJx1QJpC+hKUYQ7MMYXU1PLzT5BvJXjXgVTL2vOtGEQUlU
	s3VNrOSUKbUfiRCzEk1sNUrY6AapnJ9ArBRCqnyQbsI3mfo0u37H6oMSP3GEXYHYt41zyleToOe
	qQwwIUY0PBPAurAXSwg6YcZeoGXKGgX8T4WzV
X-Received: by 2002:a05:690e:151b:b0:650:3124:b8c9 with SMTP id
 956f58d0204a3-6519905ad2emr2529277d50.20.1775845453876; Fri, 10 Apr 2026
 11:24:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026040730-untagged-groin-bbb7@gregkh> <20260409190328.GS469338@kernel.org>
 <20260409203235.6b9329f0@kernel.org> <2026041026-excuse-slashing-c4ee@gregkh>
 <20260410102827.GT469338@kernel.org> <18e3df62-34f9-4de0-903b-19919d7ae2ca@eastlink.ca>
In-Reply-To: <18e3df62-34f9-4de0-903b-19919d7ae2ca@eastlink.ca>
From: Dan Cross <crossd@gmail.com>
Date: Fri, 10 Apr 2026 14:23:38 -0400
X-Gm-Features: AQROBzBxfq16lsxWS4FbNmSiSUcjbWC2_Z2j86CJK6UrfqmFioX4ACM672Jt4CI
Message-ID: <CAEoi9W5HOmH3AdCEjQqDo8f7=525k9HbvByiFhiWSmG1LmsAzg@mail.gmail.com>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on incoming frames
To: jj <ve1jot@eastlink.ca>
Cc: Simon Horman <horms@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org, 
	Yizhe Zhuang <yizhe@darknavy.com>, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277514-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[crossd@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 49DCD3DB72E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 11:49=E2=80=AFAM jj <ve1jot@eastlink.ca> wrote:
> This is NOT an obsolete protocol..this is in use by amateur radio
> operators world-wide...we use it for RF comms usually, because what
> happens if the internet goes "down", we can still provide comms over
> slower RF links....(plus it's a fun mode)please PLEASE do not drop...and
> sorry for the noise...

There are at least three separable issues being conflated here.

One is whether amateur radio operators are using AX.25, NET/ROM, and
ROSE.  They are; that's indisputable.

Another is whether those operators are using the implementation in the
Linux kernel.  Some are (myself included), though many fewer than are
using the protocols generally.

The third is whether preserving the implementation of these in the
kernel is the best mechanism for using those protocols on Linux-based
systems.  For that, I would argue that no, it is not.

Taking just AX.25, the current implementation has known deficiencies:
it is buggy, implements an older version of the protocol, and at best
receives nominal maintenance: notably, the newer networking tools
(`ip`, `ss`, etc) meant as replacements for `netstat`, `route`, and
`ifconfig` have not been updated to incorporate information about the
amateur radio protocols, and recent changes have left them broken for
long stretches of time.  More details are available online, such as at
https://blog.habets.se/2021/11/AX25-user-space.html

There is very little to recommend the kernel implementations, and any
unique functionality they once provided, such as IP over AX.25, can be
done via other means in userspace; e.g., one can use TAP/TUN for IP
over AX.25.

Therefore, it would be better to remove these from the kernel, and
implement them in userspace instead, or use an existing userspace
implementation (e.g., LinBPQ or similar).  Backwards compatibility
with existing Linux applications that expect to use the sockets API
with amateur radio could `LD_PRELOAD` a shim compatibility library
that simulates the current programming interface.  There is simply no
reason to preserve these in the kernel, and bluntly, the
implementation is pure drag at this point.

Note that this doesn't preclude anyone from using AX.25 et al on
Linux, or force dependency on the Internet: it just moves the
implementation of those protocols out of the kernel and into a normal
userspace program, which is arguably easier to maintain and iterate on
for the ham community, anyway.

        - Dan C.
          (KZ2X)

> On 2026-04-10 07:28, Simon Horman wrote:
> > On Fri, Apr 10, 2026 at 07:24:36AM +0200, Greg Kroah-Hartman wrote:
> >> On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
> >>> On Thu, 9 Apr 2026 20:03:28 +0100 Simon Horman wrote:
> >>>> I expect that checking skb->len isn't sufficient here
> >>>> and pskb_may_pull needs to be used to ensure that
> >>>> the data is also available in the linear section of the skb.
> >>> Or for simplicity we could also be testing against skb_headlen()
> >>> since we don't expect any legit non-linear frames here? Dunno.
> > Sure, that's find by me if it leads to simpler code than
> > using pskb_may_pull(). Else I'd lean towards pskb_may_pull()
> > as it is a more general approach that feels worth proliferating.
> >
> >> I'll be glad to change this either way, your call.  Given that this is
> >> an obsolete protocol that seems to only be a target for drive-by fuzze=
rs
> >> to attack, whatever the simplest thing to do to quiet them up I'll be
> >> glad to implement.
> >>
> >> Or can we just delete this stuff entirely?  :)
> > Deleting sounds good to me.
> > But we likely need a deprecation process.
> > In which case fixing these bugs still makes sense for the short term.
> >
>

