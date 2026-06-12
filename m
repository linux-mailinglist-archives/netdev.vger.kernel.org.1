Return-Path: <netdev+bounces-298434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5It1B35oK2oQ9AMAu9opvQ
	(envelope-from <netdev+bounces-298434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:01:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3D6676393
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=OHsH3lT0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298434-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298434-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E95E03004D82
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C9E189B84;
	Fri, 12 Jun 2026 02:01:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E51C68F
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:01:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781229687; cv=pass; b=ivvbKEx4e6lp00HYtt68FggZfWKhEIb6oVoRtf6ZYIitOXsdDQ3W+MayhhCaaiQJZ/BN8Mk0Tw43D1GgicLZRgur/dhEotmiMwvBoC7WCRTBhedNIUPE6Ge9rkvp6bgl01WZYPhjSWTGTa8L4CuHzcofyh8/I+lRjqthjxbuITk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781229687; c=relaxed/simple;
	bh=9cVS4+/pTMcP4zjSNNOOJgnzi7lXmd/1/ObEp3xoFAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwBp0Vs8DmIgkDK448XHimt+js6LEYcPDCqVkGa0E1btiXS5YGCvVfV8ErDycDui/3H2GE395LuDSiNSsvFsVF3aQ2m1Y/p644M252bcXJ1+EwXxuOPrYuZZeOAR+P7nHfm5d4BHzNtz+1feuiWyV1mmHoJltqSp1IChr5va4ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHsH3lT0; arc=pass smtp.client-ip=74.125.82.179
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30807ba471bso1462701eec.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 19:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781229684; cv=none;
        d=google.com; s=arc-20240605;
        b=BcELYP0ZqKBCRTZfkJEJMrFPz3v0covkemJ2OCCmUYJeg2jCgzoYMaVnqKurJWXgyz
         PX68wuQSNhu7lxwgkDUycln4Bi2c7xV+bMVk0TG/bp9HW99rW4MRsrd7db2gmlDv8mqQ
         DKZKPbYvkBR73P7vTIH2xZQNixuFUKt6Lb0VH/CCrXXk+DDlLUrsrnY47xU6bOAO7Hcc
         3QWIqbRbv6TY9bMqaY+30RZr0twRUNosYCoun24ytNLqtyQ5LTYGwtS1cu/ZgHiE8tsN
         WAiZUipMVmyiX7R+CBDf1DrYvoRE6AZqLi598cdvL8DMX2zNI/FC0thSCP609eqXqRBL
         ymOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ft2W5RB58Rb4Slw9wZsgp63p3M0qZU00EzOvBiQY7/8=;
        fh=z9+Mm0lKDKjPJ1BPaXtUSjRP6TkzWYdswQGpb1+v6EQ=;
        b=J4B57JVkXiXqwiNc6OBRGkjWhhf5pQ8PGVipJv4ktGe0Wy0hHMZK+xPGwF5GENKk76
         khf+JmL4EU6Pt8LTow6IcHzKVtrHRCkDOZEhc5/W740wPP9/JexWFa/nnag7l0UzADP2
         32z0TQAMdZFlU4NEqeRIyYzfNi+fWPGl7p4BRmUvZv5WfcHPmn6NWxotRFhElXkjsmdh
         LugF7fbYlN2q4OO4J4pPkt+iDrH1fRK8H62VLbara0RS7lEq/zVx/3E1MlWKvwyvT478
         0g5bXIy9Q7mJwZYx+WBRDfg0gJwuV/cSsBVPcGwqmPDJBu4/96KtpMBYN/HQP1l8/qvx
         8UdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781229684; x=1781834484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ft2W5RB58Rb4Slw9wZsgp63p3M0qZU00EzOvBiQY7/8=;
        b=OHsH3lT068+eoc7CEqSwQpETrdT7/YK98IJZq7cD/IgNvf9vA/OqKRcSiO3FCIjvRb
         y3PsY4cV6wHzO26apiIgmwVv6ULf5Vbbw3DlsNW8rBqQhVC1hSnO4rf9QlyVjGSKkH1w
         msH+fOBGkUGLvwGQ4Q6BHE6rBiVRhb3Jy7fGGt5fUgbRW/Xms3z1sMbVpOlhSALXKI1a
         hnIwj4EzBG65fhUlekcBZo823a3T3x8EBsw2LoRHSWwBQiQ3OwO4Odr7nDJrtvM5eHNZ
         7LTWPK6Qk+fT/D48FCC6JA1AQWspSM4mwuM8INgIpgSmFHCDZ8goTuhNd2zucFA0q2r4
         nrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781229684; x=1781834484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ft2W5RB58Rb4Slw9wZsgp63p3M0qZU00EzOvBiQY7/8=;
        b=Swto+2wklrQ+QG7qNO7lwOAyRhwK3vj8wHtUw32pyKjnolp1EyljYnHu9fl7bWlRlh
         zuE3wUEAQ0iJc1oh9vbLQuypVaL46jr1aUXojf+goTQZyGZJGA6YD0CIP986O8X/JYlK
         NgDtFRHb6i71Esq+mySGsmPTUyYMA6TdGcYnZut/qkw1i2n3zmv5WDfUFDG6prSspu+L
         Pzwd5KQssTHMSuhT+Xdor4H473Hz6QmqdkeFHovR1yKKsh5TFUGX/3r6yW0kAe6IodZF
         u6vJPF3AwxF172hL/v2df8JUqAMmqFtkujtrDuSm9Ya8+6fww4eYpBPqpmpKZzu1E63o
         mxKA==
X-Forwarded-Encrypted: i=1; AFNElJ+c2eQBT/ke2JIdh1NpD3iRsKvDFIz0S2WtfRzblk1nVXDjqQx0P7kskE4Htdkaiw2PXpHcZ2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9YLSQIUpgq16Oks18EzBTEMqof+qXuOkvnQG4JNFaZl6abUFM
	4ycsmeHmtkZe32Aaft0duRIwfP4ffzoG6yeHU5RotvjWxczByWr5p12kp/u2DdTXIoa02OFNyzi
	TrCRoFHD11DZenpa62ss76nX3ssYf57VCnPrE1fBD
X-Gm-Gg: Acq92OGgkpbOvOn4ivrKdPuwtQartucTwvuVCYiT+30dLYnOaT+hpGYzrz4iHOS1LX/
	+2WouojpBwJ16JVNmeR8gC6OV45/00IZqC5+RHkuVZI4rL8s7J83n4J+pfm7+40ZcriLwya6b4l
	NQ+4YiKOfHKC4yIZPr/t2GS7WBXsuyNSATPJoXC+43UQySTeEmSyyOXlWjMcn5LKotkOk5o3iof
	VIh+ZP+NMVdpAdFbbewo69ViwR7IRnK1EbVQLqNdEu13HQ19qel/S/ScQmrh4jlnoUTPjAGBQrV
	GzI/zIGAMzbwRx0QH/UW+sdEwpMYE0Zhx3s/niM0JRzvXuH9SH3RiEJnikxNdPoiOJLJTxDKoBR
	UEbZrSkcQCkvF1i82l4P+pY62CNUvqeNvIZWqu6UOikoon/Udow==
X-Received: by 2002:a05:7301:4b17:b0:2db:2089:460f with SMTP id
 5a478bee46e88-30820054a9dmr562424eec.19.1781229683424; Thu, 11 Jun 2026
 19:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780979031.git.bronzed_45_vested@icloud.com>
 <42cd30856907350e1b3834a3338364f9828a307b.1780979031.git.bronzed_45_vested@icloud.com>
 <CANn89iKLKNGE0aqyuCdxTBbRGWwAM0vCup+AL02u1UB-LrTvSw@mail.gmail.com>
 <20260611102134.5886fe04@pumpkin> <CANn89iLRKynhu1Qx6Tos+EKd2a5qkYL-tewXBgP+4Mx79FtzTw@mail.gmail.com>
In-Reply-To: <CANn89iLRKynhu1Qx6Tos+EKd2a5qkYL-tewXBgP+4Mx79FtzTw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 19:01:12 -0700
X-Gm-Features: AVVi8Cfwr2IZx43_oxskbRmSyJK3thHzN12IM2-RnVrHXAE8cBSuvHz7TlY6GEA
Message-ID: <CAAVpQUAH6f0fvvmwxcTuLVzCTzq2Dz8=mzchZg_4B2AHp7y-qg@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: ipv4: bound TCP reordering sysctl writes
To: Eric Dumazet <edumazet@google.com>
Cc: David Laight <david.laight.linux@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, pabeni@redhat.com, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:david.laight.linux@gmail.com,m:n05ec@lzu.edu.cn,m:ncardwell@google.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:chia-yu.chang@nokia-bell-labs.com,m:ij@kernel.org,m:fmancera@suse.de,m:yuuchihsu@gmail.com,m:idosch@nvidia.com,m:herbert@gondor.apana.org.au,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298434-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn,google.com,vger.kernel.org,redhat.com,kernel.org,nokia-bell-labs.com,suse.de,nvidia.com,gondor.apana.org.au,icloud.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,icloud.com:email,mail.gmail.com:mid,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F3D6676393

On Thu, Jun 11, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Thu, Jun 11, 2026 at 2:21=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Wed, 10 Jun 2026 10:04:06 -0700
> > Eric Dumazet <edumazet@google.com> wrote:
> >
> > > On Wed, Jun 10, 2026 at 9:18=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wr=
ote:
> > > >
> > > > From: Wyatt Feng <bronzed_45_vested@icloud.com>
> > > >
> > > > Reject invalid `net.ipv4.tcp_reordering` values before they reach T=
CP
> > > > socket state. The sysctl is stored as an `int` but copied into the
> > > > `u32` `tp->reordering` field for new sockets, so negative writes wr=
ap
> > > > to large values.
> > > >
> > > > With `tcp_mtu_probing=3D2`, the wrapped value can overflow the
> > > > `tcp_mtu_probe()` size calculation and drive the MTU probing path i=
nto
> > > > an out-of-bounds read. Route `tcp_reordering` writes through
> > > > `proc_dointvec_minmax()` and clamp them to the per-netns range
> > > > `[1, tcp_max_reordering]`.
> > > >
> > ...
> > > Thanks for the patch. I think we can do better.
> > >
> > > Also I do not see a fix in tcp_mtu_probe()?
> > >
> > > What about:
> > >
> > >
> > > diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> > > index c0e85cc171aec099fd5d4897b1a623dd27eaee08..987bc87e255a81680ae5e=
23ddd01c1f0de4425ec
> > > 100644
> > > --- a/net/ipv4/sysctl_net_ipv4.c
> > > +++ b/net/ipv4/sysctl_net_ipv4.c
> > > @@ -1058,6 +1058,9 @@ static struct ctl_table ipv4_net_table[] =3D {
> > >                 .data           =3D &init_net.ipv4.sysctl_tcp_reorder=
ing,
> > >                 .maxlen         =3D sizeof(int),
> > >                 .mode           =3D 0644,
> > > +               .proc_handler   =3D proc_dointvec_minmax,
> > > +               .extra1         =3D SYSCTL_ONE,
> > > +               .extra2         =3D &init_net.ipv4.sysctl_tcp_max_reo=
rdering,
> > >                 .proc_handler   =3D proc_dointvec
> > >         },
> > >         {
> > > @@ -1293,7 +1296,8 @@ static struct ctl_table ipv4_net_table[] =3D {
> > >                 .data           =3D &init_net.ipv4.sysctl_tcp_max_reo=
rdering,
> > >                 .maxlen         =3D sizeof(int),
> > >                 .mode           =3D 0644,
> > > -               .proc_handler   =3D proc_dointvec
> > > +               .proc_handler   =3D proc_dointvec_minmax,
> > > +               .extra1         =3D SYSCTL_ONE,
> >
> > Would it be reasonable to put in a 'sanity' upper bound here?
> >
> > Since tcp_max_reordering can be lowered after tcp_reordering is set
> > the bound set here isn't 'hard'.
> > So the same sanity limit for both may be enough?
> >
> > I also found this 'gem':
> > void tcp_enter_loss(struct sock *sk)
> > {
> > ...
> >         u8 reordering;
> > ...
> >         reordering =3D READ_ONCE(net->ipv4.sysctl_tcp_reordering);
> >
> > Which makes be think that someone expected these values to be small.
> >
> > I don't know what the sane bounds are for either sysctl or tp->reorderi=
ng
> > itself (which is u32).
>
>
> Kuniyuki, can you please send a fix ? You used u8 in your commit :/

Oh sorry, I'll change it to int.


>
> Default value of this sysctl is 3, but it could potentially exceed 255.
>
> Thanks.
>
> commit 46778cd16e6a5ad1b2e3a91f6c057c907379418e
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> Date:   Fri Jul 15 10:17:49 2022 -0700
>
>     tcp: Fix data-races around sysctl_tcp_reordering.
>
>     While reading sysctl_tcp_reordering, it can be changed concurrently.
>     Thus, we need to add READ_ONCE() to its readers.
>
>     Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>     Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>

