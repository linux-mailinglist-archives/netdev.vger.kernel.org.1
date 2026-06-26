Return-Path: <netdev+bounces-302078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id itRgN+jGPWqr6QgAu9opvQ
	(envelope-from <netdev+bounces-302078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 02:25:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 503C86C9468
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 02:25:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="WappjDp/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302078-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302078-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F9D1302A737
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 00:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90EC25B663;
	Fri, 26 Jun 2026 00:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035B412CDA5
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 00:25:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782433507; cv=pass; b=CTSwimuh+VuWnYJToIyuMsveQ4Dg7DDTJO/XXGjyKVA7F33w2VnAHVkjuI6Z2UhYGlZOmEvViMsNJwZFh53iXBx367gaR1iEzFRYifyRTco6c6INw8tdCJV40SjOwnD8Q4pdolqy7hJWMNEgVzdnBZh0Mz01KLvoznx8XsANJOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782433507; c=relaxed/simple;
	bh=tm/9ng6QXFy/yxdcAYME2k/dGepHGP2ultLBruVBzUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1az1Vg0o+Hnu0uOgvVJ/SOtH0pIdEHVGtc32QDpfcJOeO9QMXN6haBZDseOiYVZviL4wledHoDGvw7B180MOoyRV0mXeuHRZ3m7k7EbEzDd044MdD3CGdQEib4Ynwuh5aa9CUHUwqEjyEH7RA/bqmfSNzt7DBv8ppVfAmr6GSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WappjDp/; arc=pass smtp.client-ip=209.85.208.171
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39ad188f6d8so4008481fa.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 17:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782433504; cv=none;
        d=google.com; s=arc-20260327;
        b=NSGPJ0fNSQiOmc3EhCyX2xJ6OF/8ajjbqeLylJh6eABxztYpEVcXNpoZCmGzcEJQ/H
         6YfAGD5mw42kd/ebD7vrMcCLCdJkEWr62h+chFAO6dOkzZBl4U0fjk4Pjpk/+hHRPwHe
         Urf7blmiIylklJdXJBItOtJkYvK6NJWYdtOq6B0Ht8NPSs12mQ093e4Vnj7EaK6ZGRNH
         i+yDqEtpp6jU3MLuRT7lDjruyTuggzEzEE6Lmo5dEKQF0+MxiYWbzsTEzR4X73OxcWzs
         WolqXdrjPFL6mkv3LggZrV7fWTJRAvX7BVuEeAJQOS4RMxcddbIwmWZYJ4jpHMbgebZi
         cLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jWB/65iCNGVpgG5qvQh/EqdccH9lpCvvVXNz6Hio+Y0=;
        fh=5EYkW9yVxODaH2SKcC5G59cm+3YBX7tLwNyJmwYCBrI=;
        b=NG0ZaJ/ASfGBCWHqfBJ1S9ct/d2NsFH23Bc3lXM40+nSXA461Gbi/yIbs3iWpESHb7
         diAKzAaQeDD/r/EsioxXelFdbQ45zKL+5jYO3CMMSosjB667zhgnlqR7sTOmMLnzr6pD
         cHy1xMAxxyXk75ZJhAPBCo98D/8SACaq66XZTHyJbN6RvXjFpvFQLH8WovYVlHNtJPKM
         j8nsUyv7StZLgUwt2JM8TsaJ4AUX3wBu0J6PqpV0riterYGTUti8A0CuwfM1/giChPZK
         DuhWuSO9ojMxUL3Yqmwikm9zjUQz/Md1DfLfwylpkLGO3Eth9qu1VXmROcdUTYyr93rK
         buRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782433504; x=1783038304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWB/65iCNGVpgG5qvQh/EqdccH9lpCvvVXNz6Hio+Y0=;
        b=WappjDp/3a8DXz73rBdAYr2m+md6mqy8AvIAtJ/ONV3PzIRbiYEfSjxKohCBC8OCH7
         brp5yy+T4kCkr2dPqZLkuqZ/81UFQMC0CLSaRc1z+dWvECbdCki7W5iJ05FXldUXnvIB
         6B8NBPPqbHuKRwxgEdYZHYoqjgUq5bEL8x7HoYAGReQu0njY2KN3gh8pzPPz5Xha9sd2
         Hbnd5a9daRTp72wzd3mHpYQDEVfkevnAF62l1B24cEwo//nf+nRS810ZYMFWlN7dZ+5x
         eQxjFbux4RnTGuyd9EqDey3dm5vnK42sk9aEUzNX+wdtfs83r95edL6pQ0H6O0tmU7P9
         DogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782433504; x=1783038304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWB/65iCNGVpgG5qvQh/EqdccH9lpCvvVXNz6Hio+Y0=;
        b=LNHAq1nvDo1a02IatmfPOQiQ3UH1riuK2TR0K8M1aYX2FiMD0MWR6jawuQtTZUH5NJ
         WPEwffLCRGPjaOSQonteiA9RgQvke9eJaApzz0lUZXX+JlQXzuYrg35xW03A9WOSUwHG
         lBbMhnLdbybgoh30TXbXqcoLjm6oyM2bQXKLraZMDAD2+JP1XqtbszuZNo2Fp5+N+q01
         kFpRh3OYQxRiHwt+edfIzmVXUIwOeOZihkbMbhNrA62ikqGhfWSOd77QhudjyhdwIMK7
         ANTdiVTYNeYY53ZegfAi4WQA5Vne6qF7cyREUVmkPS5HSwzYxJfpwS/Ac4+bxfbhyiv7
         1UIg==
X-Forwarded-Encrypted: i=1; AHgh+RowzdIjQMIokzr/ndr88+tP+1M7o/W9CCy1Qd6PeWxrdzVEgNhJN2necsqRK94OptgkhhzVMUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcBFCcqCqhNH7mCzjRwHNwSuF/QzMQ1C3jYzdU/iwBIgfuLGYI
	IHi5EYFOQcXxTl0QsD9dTlx/XZbLcHELw/eiCvFI1xLH4oionfXi+15GCTpYvT5OfwkCTSzh2gu
	tRdEvoEQY1RKgc3y5hTJTY0jKMtqbVXM=
X-Gm-Gg: AfdE7cnR0QKgXXeJ27BqeiNgumxHxwf9sFFzbaDGlABgtdrJpE4vNl12t0KEh707s9h
	qH/3gEsR4G2VqtBIjK6ZKZFBbPzoOAeD9p5fJz+1tnlWPiB0kBBgg7Iup78NJC96aDm/Bwaw5ax
	BOa71ZLaaAATYBxsbAT1GszsSprWotEOXK5eL2TxqTRRpbzjVUR//uUylCY/Y4szEFP/889mCqx
	2/ir5k8mf/eJ6GlCYnqdSW6b3GMuu0Akxviw+8hP1+aeRFRRX+xBRhwq166huF+RmO3cBqBIUzk
	G7quQyN+QSZpqkLFsvLbFj+LHIl6N5HWgQxxy9OGFfheg8pV1uVaRI5DBfHGzADPPHkpz/c8vvx
	Qc6Y0dx/isg==
X-Received: by 2002:a05:6512:2514:b0:5aa:6c05:f0e with SMTP id
 2adb3069b0e04-5aea1f3a44dmr1939611e87.7.1782433503822; Thu, 25 Jun 2026
 17:25:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com> <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com> <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
In-Reply-To: <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 26 Jun 2026 08:24:25 +0800
X-Gm-Features: AVVi8CdGlH37vkcvNTjP4W11sfJkcnM8sH0E8DVFLnXKaCset2j3vqBKKK-QGP8
Message-ID: <CAL+tcoDOFtTKavz8TWpU6BPrHCcL6TjY8xrmFA5y3P9Wn0T4ZA@mail.gmail.com>
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor reclaim
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-302078-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 503C86C9468

On Fri, Jun 26, 2026 at 12:05=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 06/25, Jason Xing wrote:
> > On Thu, Jun 25, 2026 at 12:37=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> > > > On 06/23, Maciej Fijalkowski wrote:
> > > > > Hi,
> > > > >
> > > > > This series fixes several AF_XDP multi-buffer Tx paths where desc=
riptors
> > > > > consumed from the Tx ring are not consistently returned to usersp=
ace
> > > > > through the completion ring when the packet is later dropped as i=
nvalid.
> > > > >
> > > > > The affected cases are invalid or oversized multi-buffer Tx packe=
ts in
> > > > > both the generic and zero-copy paths. In these cases, the kernel =
can
> > > > > consume one or more Tx descriptors while building or validating a
> > > > > multi-buffer packet, then drop the packet before it reaches the d=
evice.
> > > > > Userspace still owns the UMEM buffers only after the correspondin=
g
> > > > > addresses are returned through the CQ. Missing completions theref=
ore
> > > > > make userspace lose track of those buffers.
> > > > >
> > > > > The generic path fixes cover three related cases:
> > > > > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> > > > >   continuation descriptors left in the Tx ring after xsk_build_sk=
b()
> > > > >   reports overflow;
> > > > > * invalid descriptors encountered in the middle of a multi-buffer
> > > > >   packet, including the offending invalid descriptor itself.
> > > > >
> > > > > The zero-copy path is handled separately. The batched Tx parser n=
ow
> > > > > distinguishes descriptors that can be passed to the driver from
> > > > > descriptors that are consumed only because they belong to an inva=
lid
> > > > > multi-buffer packet. Reclaim-only descriptors are written to the =
CQ
> > > > > address area and published in completion order, after any earlier
> > > > > driver-visible Tx descriptors.
> > > > >
> > > > > The ZC batching path can also retain drain state when userspace h=
as not
> > > > > yet provided the end of an invalid multi-buffer packet. To keep t=
his
> > > > > state local to the singular batched path, the series prevents a s=
econd
> > > > > Tx socket from joining the same pool while such drain state exist=
s.
> > > > > During the singular-to-shared transition, Tx batching is gated,
> > > > > pre-existing readers are waited out, and bind fails with -EAGAIN =
if the
> > > > > existing socket still has pending drain state. This avoids adding
> > > > > multi-buffer drain handling to the shared-UMEM fallback path.
> > > > >
> > > > > The last two patches update xskxceiver so the tests account inval=
id
> > > > > multi-buffer Tx packets as descriptors that must be reclaimed, wh=
ile
> > > > > still not expecting those invalid packets on the Rx side.
> > > > >
> > > > > This is a follow-up to Jason's changes [0] which were addressing =
generic
> > > > > xmit only and this set allows me to pass full xskxceiver test sui=
te run
> > > > > against ice driver.
> > > >
> > > > There is a fair amount of feedback from sashiko already :-( So the =
meta
> > > > question from me is: is it time to scrap our current approach where
> > > > we parse descriptor by descriptor? (and maintain half-baked skb and
> > > > half-consumed descriptor queues)
> > > >
> > > > Should we:
> > > >
> > > > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> > > > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to user=
space
> > > > and do a full stop here)
> > > > 2. now that we really know the number of valid descriptors -> reser=
ve
> > > > the cq space (if not -> EAGAIN)
> > > > 3. pre-allocate everything here (if at any point we have ENOMEM -> =
cleanup
> > > > locally, don't ever create semi-initialized skb)
> > > > 4. construct the skb
> > > > 5. xmit
> > >
> > > Yeah generic xmit became utterly horrible, haven't gone through sashi=
ko
> > > reviews yet, but bare in mind this set also aligns zc side to what wa=
s
> > > previously being addressed by Jason.
> > >
> > > I believe planned logistics were to get these fixes onto net and then
> > > Jason had an implementation of batching on generic xmit, directed tow=
ards
> > > -next and that's where we could address current flow.
> >
> > Agreed. That's what I'm hoping for. There would be much more
> > discussion on how to do batch xmit in an elegant way, I believe.
>
> This doesn't have to depend on the batch rewrite, we should be able to re=
write
> this non-zc in net, this is still technically fixes, not feature work..
>
> There was already a couple of revisions with this drain_cont approach
> and every time I look at it feels like the cure is worse than the
> decease :-( Obviously not gonna stop you from going with the current appr=
oach,
> but these fixes feel a bit of a wasted effort to me (since the bugs keep
> coming and we are piling more complexity).

I see your point, but rewriting is something that cannot be easily
applied to the stable branches? Until now, we fix issues one by one
which have an explicit target branch (because of the fixes tag). Cross
fingers :(

Sashiko has the magic to find out the hidden bugs more than ever and
AF_XDP is not the only place where a pile of reports are coming in.

My take is that batch xmit has been appending too long and at least so
far less and less bugs are found by sashiko. I believe if the mode is
changed to batch xmit, there are likely to be new and challenging
problems to discuss. I prefer to solve questions of the batch xmit
series.

BTW, would you both come to Netdev 0x1a next month? I believe we could
sit around the table and discuss some future plans there (in xdp
workshop?).
https://netdevconf.info/0x1A/sessions/workshop/xdp-workshop.html

Thanks,
Jason

