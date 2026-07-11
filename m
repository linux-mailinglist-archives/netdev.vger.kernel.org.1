Return-Path: <netdev+bounces-306730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RKx6ESCnUWpwHAMAu9opvQ
	(envelope-from <netdev+bounces-306730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 04:14:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB6D740006
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 04:14:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CnbbcyLS;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306730-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306730-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635B83021E5C
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 02:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396FE2F8EA3;
	Sat, 11 Jul 2026 02:14:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830212DF3EA
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:14:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783736090; cv=pass; b=WlLgussdViPjTxWMziRhqOg3JRrtnil3MKmCubSR5BdjyA6M+xokXLhiZ2nY//CwyS58mbVx5GW0KbTtXGgGE7+V0VzVKlLHNFHHWIj5lv3LeZLaK49yFABpNuBe/Nw/C1koWMzCB+9tLvyU15km7E6bdf2RiXWvBeRCKqkUYOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783736090; c=relaxed/simple;
	bh=FrBzqvvpfoMK6y0mKSyWneI2m4CYwpCTAgS+X62gfi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7L4p67W25VT2LN7T9KXzXz9sP7UMAqAneCn6IgiG/3hIDvtUkrdxW8ePb+xqw9KCROMlStkwyyRs/bXQicSGm11NmV2dn96SVfgDXPy4MNgPso+5FqOKbQJ52/y3D65YKuWm0yda2PWQs3zvHM1UY9rRpVSPNLeONEGWgBwU+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnbbcyLS; arc=pass smtp.client-ip=209.85.160.169
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c04bf4711so14106601cf.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:14:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783736087; cv=none;
        d=google.com; s=arc-20260327;
        b=Owfv+vRwg8AQOtlOwKRH+lfXH4L3GukA5krYwiBbCm3u2x4//uY08P8+XZsZtUQ3zZ
         DwwPhilmDgfwkRX+YVPzAy4fASboBO4RbOiLVUvCU1t9yN0TPSI4dhVgy9wtkFL6Ux4j
         UEBQRdbZ/v0cP6UtU7YEVWkuvuWgctHAFMr8Ie2m0zCfY1MuAUtWqTOjJUMNXoYIRbtc
         PEUho3V6GcnoATScBeomTYABHKyTN+Ul7E/JdyRQMWRFpm5TxcWYuTiA77+roDYibcBv
         AR58Gn58pA2m7JCGc8ObGJUo4+W/eYkwtPfoB5g4agO+ixa1wcZT795SK8nkzS9zGyZ6
         Hs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MhfPzZLV5yhxCKhSH5aaGFL3mdzmDor2bbuA3Q3b6kY=;
        fh=dRN3PtvBMsvW2B/QvQUpc6M0qj+ympbDqYMUDHiyAqI=;
        b=H9Yp61Lt8g3cVYbC+QFtL5Nd+50J9PYqVISRbQbRW11jmZOh5QXy7SPF89K53McI7z
         gblVJ4FxgTIL6Col6SsOApZ7xcSAF1O/HIXaRfpdepOafGOeYNgeBUig/Qbi7DK3FSpt
         77l7OJUklx4DXgIIQJaHG0+DndpWWuAnj4GxkkTlXDrBwAedopHMRMsJInJ22IXouFhS
         HC08stOhOnpdEtI08fqlyVGPvmVDUBtrfONbCiS+3RHzu4oPkV2U4iZl0AisMUZSsA2D
         +BY9rUxpY0KKWEmkt/ieKkk/CJtFz6AT0b9cmTv7mKXFgYAlLgqezgb/NOqs3E/UM/Oo
         acUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783736087; x=1784340887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MhfPzZLV5yhxCKhSH5aaGFL3mdzmDor2bbuA3Q3b6kY=;
        b=CnbbcyLS8SkDMUBSFijObXOWcjllf3bab0nnbpIkV+yIUiTmGl5HHBJl7rwjz10taq
         zSaw2opdQ0JXansENwfbmgkRHMZkL05XoRqy+fO9GFFv5JAuSIjh8FY9j+QmEpMgvKya
         6pMYlwjuKrBVeH2NfQxsYlG20863MRFfhXwPtz0GTPI9sCZoS/NuQBx04Dpkuov5BD+o
         CL/8IMi56qhY2oNvZ4aMf8iuIDzABmLE5XikLVeBf3lSGk3INCeEb2EAqVovZlfH49GH
         MLlwRXUJE7mFEOD0iI8bQp6fNAKs/3dtjbCBeLI9Nd9js0ZZq/zhZV4roRPbSDymHqJr
         gtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783736087; x=1784340887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhfPzZLV5yhxCKhSH5aaGFL3mdzmDor2bbuA3Q3b6kY=;
        b=G4E475PNPuAS9SiFVIJ57Q/sdx9hlEME34a0CGWUPmSNCUqDswIsqdgecCspoXVybE
         /0FpEXdNpgwTA3NCPrEo1ffXrIY//DVCbs46/S/h+1V7+ZKK5/nnzlRkAHHb7j1NPRtT
         D44U9/DkNE1wa+WlQ3NkdqsGCnwmUTBSG80iRnHEo6hsVCqNGIy6Hq+aFMksdTi3KNnM
         FK1oR+WnFxkeJgy67LyF+lIMAn5oQyW4MQ7Jy5+CsQCJi3oCUJY7Kj4Oj5EXAUqLsJZM
         AKB3JiHuqXcbYyGV8gIyRvl+7l3fMQVnm47GEYH1BE1q5dlhHJOWHekSGyeYygV6x7bU
         Huhw==
X-Forwarded-Encrypted: i=1; AHgh+Ro59F91EtTOx1S9sA65s8UHB9BNCPGYPJ7/M3cyerxBsWbCY4AXakOUmjZFSN4l5CG5syJyYW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukMif4iGm/Fms9DwPpQ7dBKoUmuO45BgiJ6W02qJyCIoc1g+n
	vucIph06oHKcJkBlD4RIuxsBaHBieJ3xCOyCnstlVnMK1GutHA0YGP9FLqElqB4c8P7v+i6jePQ
	P+q/flC/gsev0QT6VUlisIyV0szQTRGQ=
X-Gm-Gg: AfdE7cm/YrMN+lnNL5HAJppzBcAFPOj0/DX6p1aYPSbJ1VOsOSRD3IZqzSSJl9O8akY
	plLpHyoqQmIKHQql0/9INoBTQUj7F+xj+p1O3M7CBMFdopBXaqStXPR5VQooZH5UAE7qmEWaYYd
	4b/2WIwPCLIXEudQ9lcoKnUEja2pccFtatK8J4KrnB22CdXhblqEpkN+qS4rUn72a8zBf3wCrhd
	jil7rit8S5WsS+J4tXW44zsEq+u9zksiu8eSgMC5rWfHeR0TV11qwFPNz40O0mkfNjaF+6T
X-Received: by 2002:a05:622a:1390:b0:51c:f8f:13e with SMTP id
 d75a77b69052e-51cbf243d11mr14867551cf.40.1783736087468; Fri, 10 Jul 2026
 19:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708092247.4188498-1-yuantan098@gmail.com> <2026070828-carried-extortion-789e@gregkh>
In-Reply-To: <2026070828-carried-extortion-789e@gregkh>
From: Yuan Tan <yuantan098@gmail.com>
Date: Fri, 10 Jul 2026 19:14:36 -0700
X-Gm-Features: AVVi8CeeSm2x2HB2RYTorhmqUX6nraUWur4McQiSyR0-fU2gppNNR_t3udJjEnE
Message-ID: <CAPuPA7Kdy_wghauOH5pggq+woLmtp4-BEyn8LoBJ2UhRExF+Xw@mail.gmail.com>
Subject: Re: [RFC] VEGA: a syzbot-like workflow for LLM-found kernel bugs
To: Greg KH <gregkh@linuxfoundation.org>, andrew@lunn.ch, 
	Paolo Abeni <pabeni@redhat.com>, laurent.pinchart@ideasonboard.com, hdanton@sina.com
Cc: linux-kernel@vger.kernel.org, workflows@vger.kernel.org, jhs@mojatatu.com, 
	sven@narfation.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, Yuan Tan <yuantan098@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306730-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:andrew@lunn.ch,m:pabeni@redhat.com,m:laurent.pinchart@ideasonboard.com,m:hdanton@sina.com,m:linux-kernel@vger.kernel.org,m:workflows@vger.kernel.org,m:jhs@mojatatu.com,m:sven@narfation.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:yuantan098@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,lunn.ch,redhat.com,ideasonboard.com,sina.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,narfation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BEB6D740006

Hi All,

Thanks for the thoughtful feedback, and apologies for the delayed reply.

1. Regarding Paolo's question, a bit more context about who we are.

I first got involved in the kernel community during undergrad with
guidance from Zhangjin Wu <falcon@tinylab.org>.
I started building VEGA earlier this year while I was a PhD student at
UC Riverside. I recently dropout and start a company called Nebula
Security with my labmates. We want to help fix bugs in open source
software.

The volunteer bug-fixing group that mainly includes students from
Lanzhou University, where I did my undergraduate studies, and UC
Riverside.

I will be at NetDev as well. See you there :)


2. To answer Laurent's question: All bug reports are human-reviewed.
For the past four months, we have been including a human-written and
reviewed patch when reporting bugs, with LLMs used only as an
assistive tool. However, because the volume is large and there are
some bugs we do not know how to fix well, we would like to make some
bug reports public in the interest of transparency.


3. To Hillf's point: if we start sending reports, the initial volume
will stay well below that level.


4. Regarding Andrew's point: Early on, we used syzbot config for
scanning and validation, and that did lead us to spend time on code
paths and features that may not matter much in practice. We should
definitely prioritize fixing bugs in actively maintained code.


5. And to Greg's point:

On Wed, Jul 8, 2026 at 7:55=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Jul 08, 2026 at 02:22:47AM -0700, Yuan Tan wrote:
> > Hi all,
> >
> > We would like to ask for feedback on a proposed workflow for reporting =
Linux
> > kernel bugs found by an LLM-assisted code auditing tool that we have
> > been developing since earlier this year.
> >
> > Since February, we have been developing an LLM-driven kernel code audit=
ing
> > tool called VEGA. It started as a side project, but the results became =
much
> > substantial than we expected: VEGA has found hundreds of valid bugs in =
Linux
> > kernel.
> >
> > That immediately created a practical problem: we do not want to dump a =
large
> > pile of bug reports onto mail lists and annoy the maintainers.
>
> True, which is why we all end up with long lists of issues/patches at
> the moment.  The initial reaction is "we need a dashboard for everyone
> to collab around!" like you did here, but I'd like to say this is not
> the best thing to do at all.
>
> syzbot can get away with a dashboard because someone is tending to it,
> triaging the "serious" bugs before they become public, and only letting
> the "would be nice to fix one day" type issues remain.  That's a huge
> resource commitment that Google has made here, and that's great, but I
> doubt that anyone else will have those resources to do this type of
> thing.
>
> Instead, let's just work to get these things fixed.  We all have
> hundreds of patches/reports in our internal systems right now,
> attempting to triage/rank/coordinate would just waste time.  In other
> words, just grind through them, send patches out, and get these fixed.
>
> I'm doing this now, and I know many others are as well.  We are all
> running "different" tools, and so we find different issues, so we can
> all just keep sending patches as we get them done.  It's going to take a
> lot of effort (I've somehow convinced 8 interns to help me out with this
> this summer), but once we get it done, we'll be much better off.

Yes, getting bugs fixed is the most important thing. The reason we
considered a syzbot-like workflow is that there are some validated
bugs which we currently do not know how to fix well ourselves. For
those cases we thought the community might have simpler ideas once the
report is made reproducible and concrete.

But we agree that any process around this should help move fixes
forward, not create another layer of overhead.

>
> > The first thing we tried was to fix as many as we could ourselves. We
> > started working with a group of student volunteers. Most of them are
> > college students, so we have been training them, reviewing their patche=
s,
> > and trying to build an internal review process before anything is sent =
to
> > the mailing list. The goal is to turn these findings into useful fixes,=
 and
> > also to help new contributors grow into people who can reduce maintaine=
r
> > workload instead of adding to it.
> >
> > The process was not perfect. Some patches were not good enough, and we =
also
> > made some mistakes early on when deciding what should be called a secur=
ity
> > issue.  Our internal review process has been improving with the help of=
 the
> > community.
>
> That's great, keep it up!
>
> > But the remaining queue is still too large for us to handle.
> >
> > Recently Jamal pointed out problems around our tags. That made me reali=
ze
> > that we should probably stop treating this as an ad-hoc patch effort an=
d
> > build something closer to syzbot: public, reproducible, trackable,
> > deduplicated, and useful to maintainers.
>
> Again, I think that effort is going to be larger than just getting the
> patches fixed and pushed out.  It also turns into a central
> point-of-failure, which is what we do not want to have at all for the
> kernel.
>
> But hey, I could be totally wrong.  Maybe some generous company that is
> involved in unleashing this hell on us would be so kind as to pony up to
> do the work to create this and help fix the issues that their tools are
> finding.  Just like Google did in the past, there is precedent, but for
> some reason people don't like learning from history...

We have also received some bug bounty rewards from Google, which gives
us some resources to put back into this effort.
We are prepared to invest more engineering time in fixing these bugs,
and we are also considering hiring engineers to help.

Will you also be attending NetDev in person? If so, perhaps we can chat the=
re :)

>
> It's going to be a long 18 months...
>
> greg k-h

