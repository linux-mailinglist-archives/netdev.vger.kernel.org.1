Return-Path: <netdev+bounces-298248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xaj7HJbtKmo3zgMAu9opvQ
	(envelope-from <netdev+bounces-298248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:17:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB244673E9E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 19:17:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=iD7FHyXX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298248-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298248-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD287314452A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA97283FE6;
	Thu, 11 Jun 2026 17:14:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEA40FD80
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 17:14:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198055; cv=pass; b=EjjfiHOnf2LKWCUE+mLIhmMAce+yOJLCU+c8Wkb3nlGH+HEnQPN18PZ8FuwrqN4lhltl7+XVizmXbiUhUgzBAhcBzn1T6NBWRSeJqeF0/ifZp7iNTCrQIJet+I3z5+XUseEo3zGvIKteBjAuDWxz0n+9CDaE/9RWo+Lj/Yz85U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198055; c=relaxed/simple;
	bh=oeMIyymx0Y6AF2bzqhxDSo5vzQoVMEoaY1DiqrJhDQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljCN4bPKuMNMlNr/ynVxpr0tCbo+tPfHyWY0ZQSQBexHhBw2LU17BQVMkhyIdlNEuIf0Y1f70lPt+iZ6QfQOAHbcaKZRLHc6XfzezD0H+UDb6Gg6ROij/+shWbwwy01XG4rOXAuPZUd8EYmMlCGv4IXNfZTR0LFT+Mysdl9lVqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iD7FHyXX; arc=pass smtp.client-ip=209.85.128.171
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7efd2dc350cso769027b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 10:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781198052; cv=none;
        d=google.com; s=arc-20240605;
        b=UxmstTp5hmpmHzwqlq7LB07G7xne7jaP0JpbatKDXwZt8YVLSy5/cI7MOUGmxS/WYj
         3Wwq1cEIQJDeXqjhqIPnmtWKx4Yhh6VPp6A82X9KNjOCO1EOeFxQk9f9r3aNfsv5bkJL
         hj5HH5fkb/uxqq498+Cbf6DPEDxwLc6rPgR1/sLAAhR3a5QFRNZghceuey0E4VHO2iN3
         XKiHuJtNrS/XPOu3BWK1Wlm5XeAPoLynsc83m6wT/uPWH18SMpyKTL19+oCYMxU4yRcu
         szKmosr3A7kuiOA9BweQQAypzDyphsSRyluzNE60u365QzwDjjAfKiW8IEu860e0PEln
         RViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QLiqhy+wde/TJ690sjqlEIngf/m+ftSiiw3zKREUvk8=;
        fh=OByieLpmvqX1V7K2m6v9cB84CTC0mqGPfKUKFcjJPAg=;
        b=OcEhxL2XwjemlAohre7BMd60qDB5Hfe4m+JLgiX6aHqnQL0CMqJfeWo2v449dm9Y7P
         aUSwZw+DymVJdgrA7INcOzX6n2s8XHEivJZIH73axpqhZrk59anB2N8C0CO7RGIVVpDk
         E7nvhhGcq2th1s3HJU+4VO8d6xpW1v+RSPiV0+dtcfaA5vjB94/ar2dA7y7c67WePXWd
         2HWxllQn4TzVnSFAoJobIkv1b5myz+Rwmy074RY9CgmxmjHLKBR//tidvmVtjbUw1Wcu
         KRCilnWVi32zeShsHzpEqKgkEPMdj9tumJWwNKCOCSigcg1eEbkZXJ+Xkzkjf0Haeozu
         MO2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781198052; x=1781802852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLiqhy+wde/TJ690sjqlEIngf/m+ftSiiw3zKREUvk8=;
        b=iD7FHyXXVJRTOmJnmcO3vaEkymLGKOR5aq0J4iQ0aJniy/M9qV2JozlvD20VFF198v
         cQ+6kONBVOheMjQxkYIDhBnASQFXYsi8KMg4OruZ7PusoktNt0KhHLOoizSp84Yzu9HC
         0scSULdA1xQXu2jMBk3HbbFqlvO1WyC3uZghFV1enBLJ8YpBmRCiJhV9XQligjH7McWt
         QNjjr3i8KmKy3/6xI8PJpnsAyan5lxgqPOGBYKba3Tbsawh1AmbOzepcWArB2CDfrLLN
         gmmFY9bKJXFR7d9JB27TFhwDtCepmToO2ZlfKkYAId/khCq6+4JjqfWUXwoPo9aIsQiu
         0zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198052; x=1781802852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QLiqhy+wde/TJ690sjqlEIngf/m+ftSiiw3zKREUvk8=;
        b=tMfI5iWBgvJakRcKb97UwYTMoUJwSG2Mm3nxHAS8BCEEHdDwRsr8Sj52O9ITgqvzSF
         nbQHS5M0oIxUSZWGmOI0T/3WNibZ7+zgawvZOxWf5EvA4BlnAyQZ0VR/bgZFBtMTOQZi
         HwwOX8poGgNOfvQEA9nDjJAgSL3QW6c40agds9TLk5ZVxAyYTZKc7BFZ+vr3RkSmcgQw
         v6Z8uiUPKbiAMGe2ap0lTXPz/7VKLWQIwvnHFcG4zY4rWxx8UT4c2tO+nYo4p1/3q1sr
         dyUIAAw6fSD26da4GSJaAx1F7A9B8a5KwGlJ7lIduDlUn5Om0DLBrBaq18cc5/VGv1H5
         NH1g==
X-Forwarded-Encrypted: i=1; AFNElJ//eiw/AiF7T8jJONaac6UqrHRkLynBJnp34oMJQWpiytoqdafa+74pmS/NfVKgjdUI44Amru4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYiKmMJpI2GjCu1iGZBF4SFkTl9h6pPnskUaZn4KCfKR3mtJUR
	zFmMmu1jVL2Yr8hrhv2zReBarR2HWV+1qd4W+z6D9T7MWfNacSuLTI8Oc0Fkyo5aL+td1SOBwiz
	IDdV1jxYd3xr5rTCMHsFfBSaUlJpfz1kVGqq4FZGP
X-Gm-Gg: Acq92OFz23RA8Syj5M7b1wV7nZOcOGyn4+FKr2a8WfSK9VfbxOmx9vhbze8s3ZF/HsI
	vX1bfwNmNW2wgg+E7mca5YrxDW+b1CxKc0EXjlpSAq8ZFT3qQvEeE4VbEQBW/Fzs0vaIdZQQxXx
	wH/BzL9OO1pg7lRh5F6XnRu32OMQHffqM6/8QtpVRG59eqr0k6aciH9yYa7cQHuOGz8u4q5UdaD
	qAkHeMBX5VOYbdWbcWdkw+4IBsYlrM/9zKGHOGfqVpKgohJDgfyGd2IF0n6xVA2/Lluk0SOXYNM
	Pp4EW9RmbF2pbwRX8VcPjMcx23M8m64qwUkXofMuMKfITp1YVy07waYyiDcQ1qONdyE2K1tPckG
	y6pOqwHhG4ygwAz6dhrV5Zg0XOnkR5g==
X-Received: by 2002:a05:690c:4c04:b0:7f5:2648:6838 with SMTP id
 00721157ae682-7f657e3d0d6mr36367517b3.35.1781198051074; Thu, 11 Jun 2026
 10:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780979031.git.bronzed_45_vested@icloud.com>
 <42cd30856907350e1b3834a3338364f9828a307b.1780979031.git.bronzed_45_vested@icloud.com>
 <CANn89iKLKNGE0aqyuCdxTBbRGWwAM0vCup+AL02u1UB-LrTvSw@mail.gmail.com> <20260611102134.5886fe04@pumpkin>
In-Reply-To: <20260611102134.5886fe04@pumpkin>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 10:13:59 -0700
X-Gm-Features: AVVi8CeLa5_sdQ-fu1SQpobJto40GkWBFM00owtpl657aenLm1MuBjfyKlMIlc0
Message-ID: <CANn89iLRKynhu1Qx6Tos+EKd2a5qkYL-tewXBgP+4Mx79FtzTw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: ipv4: bound TCP reordering sysctl writes
To: David Laight <david.laight.linux@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, chia-yu.chang@nokia-bell-labs.com, ij@kernel.org, 
	fmancera@suse.de, yuuchihsu@gmail.com, idosch@nvidia.com, 
	herbert@gondor.apana.org.au, yuantan098@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:n05ec@lzu.edu.cn,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:fmancera@suse.de,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:herbert@gondor.apana.org.au,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-298248-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lzu.edu.cn,google.com,vger.kernel.org,redhat.com,kernel.org,nokia-bell-labs.com,suse.de,gmail.com,nvidia.com,gondor.apana.org.au,icloud.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,lzu.edu.cn:email,icloud.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB244673E9E

On Thu, Jun 11, 2026 at 2:21=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 10 Jun 2026 10:04:06 -0700
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Wed, Jun 10, 2026 at 9:18=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrot=
e:
> > >
> > > From: Wyatt Feng <bronzed_45_vested@icloud.com>
> > >
> > > Reject invalid `net.ipv4.tcp_reordering` values before they reach TCP
> > > socket state. The sysctl is stored as an `int` but copied into the
> > > `u32` `tp->reordering` field for new sockets, so negative writes wrap
> > > to large values.
> > >
> > > With `tcp_mtu_probing=3D2`, the wrapped value can overflow the
> > > `tcp_mtu_probe()` size calculation and drive the MTU probing path int=
o
> > > an out-of-bounds read. Route `tcp_reordering` writes through
> > > `proc_dointvec_minmax()` and clamp them to the per-netns range
> > > `[1, tcp_max_reordering]`.
> > >
> ...
> > Thanks for the patch. I think we can do better.
> >
> > Also I do not see a fix in tcp_mtu_probe()?
> >
> > What about:
> >
> >
> > diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> > index c0e85cc171aec099fd5d4897b1a623dd27eaee08..987bc87e255a81680ae5e23=
ddd01c1f0de4425ec
> > 100644
> > --- a/net/ipv4/sysctl_net_ipv4.c
> > +++ b/net/ipv4/sysctl_net_ipv4.c
> > @@ -1058,6 +1058,9 @@ static struct ctl_table ipv4_net_table[] =3D {
> >                 .data           =3D &init_net.ipv4.sysctl_tcp_reorderin=
g,
> >                 .maxlen         =3D sizeof(int),
> >                 .mode           =3D 0644,
> > +               .proc_handler   =3D proc_dointvec_minmax,
> > +               .extra1         =3D SYSCTL_ONE,
> > +               .extra2         =3D &init_net.ipv4.sysctl_tcp_max_reord=
ering,
> >                 .proc_handler   =3D proc_dointvec
> >         },
> >         {
> > @@ -1293,7 +1296,8 @@ static struct ctl_table ipv4_net_table[] =3D {
> >                 .data           =3D &init_net.ipv4.sysctl_tcp_max_reord=
ering,
> >                 .maxlen         =3D sizeof(int),
> >                 .mode           =3D 0644,
> > -               .proc_handler   =3D proc_dointvec
> > +               .proc_handler   =3D proc_dointvec_minmax,
> > +               .extra1         =3D SYSCTL_ONE,
>
> Would it be reasonable to put in a 'sanity' upper bound here?
>
> Since tcp_max_reordering can be lowered after tcp_reordering is set
> the bound set here isn't 'hard'.
> So the same sanity limit for both may be enough?
>
> I also found this 'gem':
> void tcp_enter_loss(struct sock *sk)
> {
> ...
>         u8 reordering;
> ...
>         reordering =3D READ_ONCE(net->ipv4.sysctl_tcp_reordering);
>
> Which makes be think that someone expected these values to be small.
>
> I don't know what the sane bounds are for either sysctl or tp->reordering
> itself (which is u32).


Kuniyuki, can you please send a fix ? You used u8 in your commit :/

Default value of this sysctl is 3, but it could potentially exceed 255.

Thanks.

commit 46778cd16e6a5ad1b2e3a91f6c057c907379418e
Author: Kuniyuki Iwashima <kuniyu@google.com>
Date:   Fri Jul 15 10:17:49 2022 -0700

    tcp: Fix data-races around sysctl_tcp_reordering.

    While reading sysctl_tcp_reordering, it can be changed concurrently.
    Thus, we need to add READ_ONCE() to its readers.

    Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
    Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

