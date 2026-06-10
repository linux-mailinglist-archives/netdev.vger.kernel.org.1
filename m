Return-Path: <netdev+bounces-297405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VXFsAcfEKGpJJQMAu9opvQ
	(envelope-from <netdev+bounces-297405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596E6655C2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:58:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IHt6vqUW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297405-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297405-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4E9130357B2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C4025B09B;
	Wed, 10 Jun 2026 01:58:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B70248F66
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:58:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056706; cv=pass; b=jXfWN4ZCLfKRUahHmOVwgLmdCKEpPm8Ah9uCar+DS8TVpYtA2kTYLrv4HBMl66WUxrz0mTuV8Q3TzFpkO+YuBAS3DgLg/2h960NEHbjyHPkwpWMQ0H7ynoJ3Bg7HV0p54pcUGgJdcipXjBJKylDx1KhmgjhbrVhcrL8ur7jZFUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056706; c=relaxed/simple;
	bh=r7wZRIULkzfdJ6PbIVDPQrynqxU84BnGc6ZnGMKQxbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdQGQVF0kOhj4Zr3hWq9XF4gmhPGCDFvtT3TE+ncT5P8hAD5BrYxvT/wFwJRNHYt5gkmSz7xo28sUpaAV46ilV/YpK8rUiRIoE13XofaIO2WLcvJDR6cQ4afHPZnvD5W48M9F9wxZjDJuFelk+G6K47eVTXmkJUCW3UhjKNJS/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHt6vqUW; arc=pass smtp.client-ip=74.125.224.41
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66049669d78so5517598d50.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 18:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781056704; cv=none;
        d=google.com; s=arc-20240605;
        b=Qu3RSZBg6iw/rl3Yk3kdKEjxpkVGm4CrZwoB2TQp9JjxHVfjMa/yzKVK9rJX3I+K97
         qyxoO9ZEljitBLeZe5nt4Enncpu5pm4CMZUBKq6lEFXVAJz+ZVAiNmmYoo9Sq/33CTrK
         Gy2uilrnUDYqvOcAwkBr4npOnypgfRJu8JnEK9BVOTwGPA3LCpG37rYG061nFIHwQ7jV
         EC2fI0A3G+UuwxPxk+1NduhWackM4Hav63De4mD3O7sXCNsiopnIJA7YT1k8r5qg+PKz
         M8NsiqybGXensELvIuxioOiSbwJRf3S8bFqOfc7Oz3xDf0mc8wnV60j/m0b0u1tTiEzO
         xPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V26tMOgLqjN+F+t/D87zLfcdZGcgB0R+hwG90xbmU9k=;
        fh=e2HXHl3Uhh6sVAEHMqFo8daB6/7mfT6DDxeM7O3BiEQ=;
        b=IHs5mMhYnH/uP2xT6oELPsezA3zt1C1IAyxjeJOCRswnz0w+40tDRkOGjeVnhvp2xG
         545GJgrRg11BzxdupsJB3Q5iCrq0lfBL8LiL37xgyMyhCguwsicjkKpuaiTlQ5qLrgO/
         ZLAcM8KB6wkUg7e3xlNJzrXt20Z7XhhKi0AErsmKRonnlT+69yiivTEVOtD2BifNR5Te
         n7BVHP16RwuGMB1E2y25zbQktAYHaaO0wyXpPLs3ZYDTvmkuvkRrzlzXgJ1pM46C8XST
         45jERDgBu2N9fCXatrgFRqP1FVzLP5Y+x0tvsOo2tM4cPpoys7bajiDKxFoqFjE+RgKY
         jhQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781056704; x=1781661504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V26tMOgLqjN+F+t/D87zLfcdZGcgB0R+hwG90xbmU9k=;
        b=IHt6vqUWTuoZQ6HfufaMFIuLw052EaXdX8WR6Bn8l0Zcj9CUfBNVtlj+y+OblMvU3+
         R5cMN5n+jW6V7I2+Aq58v39Y14o4e2l6YXq0p2HQ0qLH6fWJpxqfLckfIqsJBADapRTn
         iJzHgEt7YXq+OuSufbQFiP9UYS0h8HGrNwj5VF/FPKx3Tba6il9QnQzDeCJO2gYmrWml
         C2SWNZpiErUUpSBs1SWocJdfNrgO9RyKA0mQ7MS65XahO6PcZiUQD2QubNxnQoyw1lWK
         YzUD2bG2KVd+ACm5Zai4385tTx5/yPGWsWIrhTHfFxS0HJHKZA6b1rY0Tl0dHWZSy/7c
         vC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781056704; x=1781661504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V26tMOgLqjN+F+t/D87zLfcdZGcgB0R+hwG90xbmU9k=;
        b=Hs/8eq+2onQCc0t987HD0w5jyrKMBVQSK2w3CkjXoPzeJQOddPrdR47yMHww9N/pRP
         qX8tDa0sz+7b61HG6vORwrPTdQV1tSKc0XFhk96cbzNuMFyjF9CRtwemdFFwTPUbluu6
         ZAGsYOMKxj5duhX2Qb2pMr73ij8Hdl9fk76WoV4C+gHk5fVWWmq4IvHUq0wThupJbQkP
         FwqIN1Rq/biucaJLP5fhQUyxxg/afr0sNcl1PRApnvvVEKA/9LZ2Jb/xQ/FX4zkhKJ1N
         xpUBHoYPDJUsKABYiRBeGClCX3GFx4L3b+5oKA5hXlSl1FSjvE6oU4YzSK/cwIO3RMq/
         dJ9g==
X-Forwarded-Encrypted: i=1; AFNElJ/rN256hVK5XcjAS4fBBxjrZ77FMK0nxRokA0GudoJGT5SMGIHuUSmoWYWxwUfidyRQmez6hvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyutoJCGfPVuXCHTcckMJuGz+m7KMiudFExYAuJHFUMju2G4K1s
	/WsmJUvg+NPW+7+fhIM6CFBSD0g2JaQCc0IDhTHDKVtJO55UU5k2331AqUQoEpuDZ5L+BvDcVdF
	wWjEEuOvz5rTS5ylpoaJCL60L00O1f2A=
X-Gm-Gg: Acq92OHTFkkWnUlCaMbOFuZYaiGYYkBirf5p4R8+wGHbw+2C5X35PWI/Df9EOEfpS2h
	DLsV+f1opnDaO4hYt6nyaxIYNf2HVIzDiIgpuR9PVBwCHosq+mjA6zSskpP+aZ7XPMFDh0JGbmV
	heK3uq7uWhYjHxnJZVG0/DudQY+MInfkAIPNVSRJEYCFGXgLaxCrSV6yt0yEebbz6FuJ5gNOrjX
	vvrTl1890hWR5LblWTuoGbNjq55I3G0NWviDj551NT6AWiepmbQbODJ7jv1Hjuu/9YDSssLomrP
	YAkknq4WzNn4Esc4A/HroqdtombM29Uvh/UIUYD3sdk5+FpbPUwGs135qQt+9i3hGQyvVHpM
X-Received: by 2002:a05:690e:4390:b0:660:4369:8cb1 with SMTP id
 956f58d0204a3-66106e90b5cmr15646241d50.24.1781056704624; Tue, 09 Jun 2026
 18:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
 <L0cwr1-KRSKR7-dJdjDmJA@linux.dev> <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
 <AgOg1pJHQN-gpKhYUz3SMw@linux.dev>
In-Reply-To: <AgOg1pJHQN-gpKhYUz3SMw@linux.dev>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 10 Jun 2026 09:58:13 +0800
X-Gm-Features: AVVi8Cd2Bbe0wde5qToQ7hXErFi3TvnK9_5Ol1Mi8_YsK_saSVysuCpjLW1uQ1Y
Message-ID: <CABFUUZH9F+tiitstSBy2-M=WC84jg28CVMXU+Lu-va6jm71fDw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org, 
	liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297405-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[etsalapatis.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9596E6655C2

On Wed, Jun 10, 2026 at 9:21=E2=80=AFAM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
> On 2026/6/10 08:06 Emil Tsalapatis <emil@etsalapatis.com> write:
> > On Tue Jun 9, 2026 at 7:06 AM EDT, Menglong Dong wrote:
> > > On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
> > >> dev_map_redirect_clone() uses skb_clone() when redirecting a generic=
 XDP
> > >> skb to multiple devmap destinations. The cloned skb can share packet=
 data
> > >> with other clones.
> > >>
> > >> If the destination devmap entry has an egress XDP program, that prog=
ram
> > >> can modify packet data. Such modifications can then be observed by o=
ther
> > >> clones sharing the same packet data.
> > >>
> > >> This can be reproduced by strengthening xdp_veth_egress to configure=
 a
> > >> different source MAC for each egress device and checking that store_=
mac_1/2
> > >> observe the MAC configured for their own egress devices. Without the=
 fix,
> > >> the SKB_MODE subtest observes store_mac_1 receiving the MAC configur=
ed for
> > >> the next egress device.
> > >>
> > >> Fix this by unsharing the cloned skb before running the devmap egres=
s XDP
> > >> program. Limit the extra copy to destinations with an attached egres=
s
> > >> program.
> > >
> > > Hi, Jian.
> > >
> > > This sounds like a good idea in this case. When I have a look at bpf_=
clone_redirect(),
> > > I found that it use skb_clone() too, which means it has the same prob=
lem. The
> > > data can be modified by other xdp prog in the destination NIC if we u=
se
> > > bpf_clone_redirect().
> > >
> > > So maybe this is the default logic, and I'm not sure if this patch ca=
n break the
> > > existing users :/
> >
> > I think for use cases where we are using bpf_clone_redirect() to use
> > one clone for inspection this would add an unnecessary copy. Maybe
> > adding *_copy() variants instead of changing the *_clone() would be
> > better? That way we wouldn't be changing the behavior for existing
> > consumers and the naming would be consistent with the skb_* methods.
>
> Agree. It's not a good idea to change the logic of the existing API. Or
> maybe we can add a BPF_F_CLONE flag for the existing API.
>
> >
> > But more importantly, is there an actual use case for the kind of API
> > that the modified selftest requires? Nobody until now has considered
> > the existing behavior to be a problem.
>
> Agree too. Obviously, this is not a bug. For the use case in the commit
> log, it's something that can be fixed by the user themself. If we need
> modify the MAC, we'd better attach a BPF program for all the egress
> device in the devmap.
>
> >
> > >
> > > Thanks!
> > > Menglong Dong
> > >
> > >>
> > >> Tested with:
> > >>   ./test_progs -t xdp_veth_egress
> > >>   ./test_progs -t xdp_veth
> > >>   ./test_progs -t xdp
> > > [...]
> > >>
> > >>  destroy_xdp_redirect_map:
> > >> --
> > >> 2.43.0
> > >>
> > >>
> > >>
> >
>
>
>
>

Thanks for all the comments.

I agree this should not be treated as a generic skb_clone() issue, and I
understand the concern about changing existing clone/shared-data semantics.

The case I was trying to address is narrower: generic XDP devmap
broadcast/multi redirect with per-devmap-entry egress programs. The use cas=
e is
not newly introduced by this patch. The existing xdp_veth_egress test alrea=
dy
attaches xdp_devmap_prog to all egress devmap entries, and that program rew=
rites
eth->h_source based on ctx->egress_ifindex. My change only strengthens the =
test
from checking that the observed MAC is not equal to a single magic MAC to
checking that each destination observes the MAC selected for its own egress
ifindex.

So attaching an egress program to all devmap entries is already what this t=
est
does. The SKB_MODE failure happens because the cloned skbs can still share =
the
packet data, and a later per-egress rewrite can be observed by another
destination.

That said, I see the concern that this may need a clearer semantic boundary
between clone and copy behavior. I will also check the last_dst path pointe=
d out
by Sashiko before deciding whether this should be handled as a bug fix, or
whether it needs a separate explicit copy/isolated redirect semantic instea=
d.

