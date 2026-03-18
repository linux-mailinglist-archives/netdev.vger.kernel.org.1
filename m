Return-Path: <netdev+bounces-269174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEnDHyYAu2mreAIAu9opvQ
	(envelope-from <netdev+bounces-269174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:42:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D62272C21B5
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250C33063603
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA95D3F23B5;
	Wed, 18 Mar 2026 19:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xZtZExaR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150FF3F2107
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862882; cv=pass; b=crLiabPcr/hbHDZX+T4HYFfKQ7rNJr5hQV5vO680q0rSDJW3yFjEc2rVi+/pjS/InO2ifT6CZqg/wpucbW74wdsEr5ChsQ00v0UegDy42Yxkw1Psa7v87SN1olu8KFvYexpIJIHDfjAcCGEaLR0itSZsIVRfj7dJMeaKfvOcHYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862882; c=relaxed/simple;
	bh=PA3vCJ20K9Q7SjSixLQ2dRJhf+GN72f8G1dfLr83skY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmW2MeJFh/46SGQ2HSopA461F/fIia21wVLZJIMiz3rQ727xR38PcZ4bGmZgHwTnQoWToG5i1UX1BCQTk1ATRMyZU67z/eyP+mkpitCo5eD4FEIHOePPryKvtdm5IuimeFsKSmKbx7rDf2YjlF4jjsrSXPGw2cwt0xr67hsfDMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=xZtZExaR; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82a124f3a5bso238741b3a.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773862880; cv=none;
        d=google.com; s=arc-20240605;
        b=SrZBVAUGtlkaeTVcJMww2nwVvpudsI38Ty7SlQDCESe0bR3DxNVWOTjCclXBFz5pF6
         BZAaJ0MDprKRmNKnln9kS9fwUynHrkaw7bGyQIF3KaDsHhVpTIJHUBU/XianE+hnqroX
         ZlDoQ3yGOpmWxAdbdWYURvQgtwmUA6zc8qq26iIhDkfey6rJMNKNFUtbs22eEPrLPTrU
         Kcf7q9WR6VzU8jGd18Kg6fM7PkxsbA7D8fn/nNX2Ff2dy2N4ADWX0IfWs8H+PmO/wEUh
         PM5saWRft+TKY41Xfm46v7ssUY1U3ECRnYPEWUMOZgg3VyBqtA8Zir5mUXpKbhSb7b6s
         h+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KBIeofnSAby/mnGoNMB4d0RTOdEFlbDfua17z6ucLKo=;
        fh=FudP6vj4NiymPtxplzwB89XQl6hjiFnaF76vQw8YVQo=;
        b=ddwnwG2rqyYPfREn7eOfICGIkdpdocrh4K4XOH4dsxVHYjia/a/73D4cGA6bBAIxdN
         gGNzVwhOt36ubliue1oTEb92SmoQfvhjSDTpJW8q7vYkj/ptLAVCo6GnPe57TQjRGPge
         RfJrN+JFjLBfZBEnnfTROhV4TdWsSaW4XBH+NPoqqdW8SEPcHIMhFga5m/RqIt/T/iI3
         4dvKsLDUnHGKYNBaBvVc7mHYNyR4d+cv3d88GaKljaRFtnFSXkdQa0/lIAKg7e5jOehE
         ypNqoXIKzRjCjdNCV6FieQQYY1+wAOy7FSZYi/MsmN+qx1miz03jFHvMQPK3aE/2GCFK
         NVgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773862880; x=1774467680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBIeofnSAby/mnGoNMB4d0RTOdEFlbDfua17z6ucLKo=;
        b=xZtZExaRAqiVH5PZsdcSLdlK1K/39BReSszGSpTg7Kn3QLxj4av22ppRDXFn7KFfHZ
         OdUL8Tr7q1XX1vcg9pFNqlRC5X07Dfq8PS2OKjGcXGdf2N7myPAJLrQ4yMYNcU9o/Ig8
         NesHpA9+getRrOVPp9rcxR+qUbCyAEov2B8MvnUVYGplXDvXikYRv4iIGLvxtY5yVIXd
         kFEfpCE35kqtA9ltrodWcc+1g4EMKH6BJi7NkeQN2ebdoTSqQZmnsvLdLfz97pL5gatE
         7je7LxNA/PX6w+U/n4QmftpUb1hLya5KkF1AFQhziLUE+24f9pz8xstz1UZIPEd4wRH9
         BgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773862880; x=1774467680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KBIeofnSAby/mnGoNMB4d0RTOdEFlbDfua17z6ucLKo=;
        b=FSIF8Fo3xUdzuBZ2Z41t5455nxJmEqSCUWSx3I5y13s+/2vX+YT02L+A+AtkY/hYLY
         7uhXQgDHYN0cMyyUejDjvXxTUFiMzMx8hF2GNhVbsAyQtgmw+XfLYta9qjkZ75cV75XN
         aTYDHm0TNJe5C+AQ3ePnLVoQIh3Hv7zIFzaXCGYwL3e0VH8jOOw6GNJwNNcWGPM0Dt3y
         YLvXlwoEniHTjwLqAjw7ucGpWyH4WAqIb4yFltcN/TDgIpIhBkq7MK5pJmmyVIVfukCU
         jqUJSEM1aJpIk35lmDnwT/tLfU3ci8I54cOPSyQ+oKTFmoQgf/ZLd0iPygiQgxaO3z2r
         yfdg==
X-Gm-Message-State: AOJu0YzYlGGx8jjzb/i/MgWfIedlEEbB2C8ZBtddwXnpYF1LWxL6/3rX
	YAls2jPPqiNvGXjSs97w/D9oRQCqZtaOX7pNRKJMIKWeDvvM89bcoHWyTR+EcunLq4Pi6rl15zz
	K5or7Tj6HxM+YyU1W772nU2kfVZ90kUjBa5pc78sB
X-Gm-Gg: ATEYQzw1bbQQ7GvrnQGCHHthRIyg/rWxDHeAGEU3hbU2cN2gwcYWc1Jp6TiOOiIAm/k
	yM1VVxPQqFIFlpbzWgkd/ITOYkLovWFhz68Qen7/v3fdJQnSN//NG1T7Fw5ILVj/pcxrckPex5V
	aL8qBD5ys9uKCSAW9UgWhzC3gvElWvVUM+aDApV3FpE2yKdm8MXE99fMgM2xb6Y/Sak0tb5d0TH
	DbrWkGh0xNU6yDERFFAyY7NyekBdx7NBmIro1Z1V/GNNjQYgBzyZaGnf5kHMHBiZMi0YsWbIVaA
	kD31O8QxvDO1l0I=
X-Received: by 2002:a05:6a00:1994:b0:82a:7ad8:75f2 with SMTP id
 d2e1a72fcca58-82a7ad8a387mr575045b3a.56.1773862880423; Wed, 18 Mar 2026
 12:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316211052.332383-1-jhs@mojatatu.com> <20260317163633.0c69db62@stephen-xps.local>
In-Reply-To: <20260317163633.0c69db62@stephen-xps.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 18 Mar 2026 15:41:09 -0400
X-Gm-Features: AaiRm51dz8OBzgQcLRYFgKZu-F5JVQO9CL8pt3p2GpEjeZ3RoN_K_a5l7GQFexc
Message-ID: <CAM0EoM=3W7OMiBgGBiGKWxqtC1dKWJ4_Jb6cLq9KwamwR5aQ-A@mail.gmail.com>
Subject: Re: [PATCH net v2 0/6] net/sched: Fix packet loops in mirred and netem
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, will@willsroot.io, xmei5@asu.edu, pctammela@mojatatu.com, 
	savy@syst3mfailure.io, kuniyu@google.com, toke@toke.dkus, 
	willemdebruijnkernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269174-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dkus,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.950];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,networkplumber.org:email,mojatatu.com:email]
X-Rspamd-Queue-Id: D62272C21B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 7:36=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 16 Mar 2026 17:10:46 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > We introduce a 2-bit global skb->ttl counter. Patch #1 describes how we=
 put
> > together those bits. Patches #2 and patch #5 use these bits.
> > I added Fixes tags to patch #1 in case it is useful for backporting.
> > Patch #3 and #4 revert William's earlier netem commits. Patch #6 introd=
uces
> > tdc test cases.
> >
> > Changes in v2:
> > Do not reuse skb->from_ingress (which was move skb->cb)
> >
> > Jamal Hadi Salim (5):
> >   net: Introduce skb ttl field to track packet loops
> >   net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loo=
p
> >   Revert "net/sched: Restrict conditions for adding duplicating netems
> >     to qdisc tree"
> >   Revert "selftests/tc-testing: Add tests for restrictions on netem
> >     duplication"
> >   net/sched: fix packet loop on netem when duplicate is on
> >
> > Victor Nogueira (1):
> >   selftests/tc-testing: Add netem/mirred test cases exercising loops
> >
> >  include/linux/skbuff.h                        |   2 +
> >  net/sched/act_mirred.c                        |  45 +-
> >  net/sched/sch_netem.c                         |  47 +-
> >  .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
> >  .../tc-testing/tc-tests/infra/qdiscs.json     |   5 +-
> >  .../tc-testing/tc-tests/qdiscs/netem.json     |  96 +--
> >  6 files changed, 674 insertions(+), 137 deletions(-)
> >
>
> I would also like to add additional guard rails here for netem, and you
> might consider the same for mirred.
>
>  1. Do not allow duplicate option outside of root namespace.
>  2. Cap the duplicate fraction at some rationale lower bound like 25%

I never understood that logic: don't allow root because it might cause
a security bug?
here's a different view:
See: https://lore.kernel.org/netdev/20251201162524.18c919fd@kernel.org/#t

cheers,
jamal

