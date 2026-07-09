Return-Path: <netdev+bounces-306224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EtfdA9icT2o/lAIAu9opvQ
	(envelope-from <netdev+bounces-306224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:06:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABAF731630
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 15:06:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IShI0upr;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306224-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306224-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B15C93060D3A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D2225BF13;
	Thu,  9 Jul 2026 13:05:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653B22423A
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 13:05:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602320; cv=pass; b=A7LLoBzmcb6Y+g5WQ7gYUAo1HgcTWNVAP07aehoBi5VUAVUmARXVQ0pkWZdEhw9N7YSyCwcHG3BNWrPkbpYQ5JGVHLD7s03ShrbjF9EszvY8UtD9iUbS3LPyj5CRY1iEeHL1TZNRJcEdPvTF2S6o6cvSvl6N+Ruv3QHPc2Wc5oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602320; c=relaxed/simple;
	bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvbDI8aSKyR7rehoGopsAFB3/Mgdg0XIjqh5+ixHOcd7O/3Z7qFkblWXhwKOoumjgEL4DkLxY7BXVDj2b7n/WCVTF0E4UdgsiWZ5si4/CZ0ocUoKyE/D1YAJo12m4iBRdEkqh2JV0V21Z4VumPPbAZbg1blMCjek5DsPsPI/fk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IShI0upr; arc=pass smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c029505b389so146486766b.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 06:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602317; cv=none;
        d=google.com; s=arc-20260327;
        b=dOz/DfJgtsK63SzTAYRMsXUzR8IyGetUH5MmyYnEQCZ0NJB8Lev/wel+KUlXUDVDZG
         JEQbvcAnlwn0X3qSDgqfWUkRxSFJ4e3coDpfF7+GBnMYtspVWXqzM92Dxl+bW9wI90NG
         1HNdnzowsEO+Nn7zi5XdUKma8/DHZlH67Btcf8WH8nL8kygp1pa4DPx0yAbE55TtODx0
         Ar63F48gvE1fDE0f2MyLDDdTOjQ58zoUVcWyc98AM9YKIUvwI8m9OQNmP+hSq8c/PoVx
         3CyC+MyDZVNJCwPy2XGAkVl4YsIVHJgYFUNGM6jEhAY4G5SSyWPhhhUunEh9qnptdhzK
         IQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
        fh=7+5XlV4ZHQpIeqMtn+makRMBJVPmkzAbJInzC1EMmkU=;
        b=eq73hA5xwYm/E4M6YYjwZoXQdcvAo3Etxb/KjsE7fFsPgoEKoLypDHb/1p7tVye21B
         2QmHyI/5CT/YvO1kgfmHhNnd2pziCbzwY82h8jRJsk9hn3O+QrBfvz08m9nBjF1pbVrv
         NhANKxV0QF3FP8mljgTHpwpF+FVHaFPy0/LCgHbSj/JlQAr10NWTXPjfymzLaJLd0Vfv
         724bnHcrGGLFZ75FSTGbQBLS6Hw4UohRY7qW7n4Tq2Y4DO7qX3/OuEDYAefzucO+WuxA
         vlWg7q01uOd3uYCR94SiszEMZMdOSabFQEUh/RFTVdifMrQSCX8qwfSdXk1GrZwRxVXT
         ttWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783602317; x=1784207117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
        b=IShI0uprFbe7kJ58S81204LrdNUpadM0QEWf1oeBRHmDRrOGgLGbwPYNyepVlqGj0C
         c2dj/56IBfIXJBT0rX2e9WU7UH4o9HgjJGVMavhDlm9//zxswr0RKAGKSI+v9KOK7q1F
         dTvMZlgag8NhcTlobH2veQ4PLjFEbjcZIKETddW1SmAT1DHj8jiuZI3cQ2qcPtd0QLWd
         ks5i6CRCdVbSUJcLbdd6hweDcrjbIzmEKq15ecTDW+ZGfLbZ1YgYMAJQMoFYOIzdzx2C
         XlIpTKvv9zVv7hbbFZqX8He2BZp3J3Vcodj8r9XtjIZtTsaNlHgTbufJCPX81YIdnpzk
         OMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602317; x=1784207117;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w2zFUzgmtAuk8hs2S7KZhdwkyppPnKoB5X6Mdgo9p/8=;
        b=Zb+jf1g6b0RjJjWSFqPoikEPnLonzjj6ciygbDFeXAPhCQAVYKhleVc+IAxduwC/5N
         d7yimQyYJkvCIZIbfl0CK3zgbpCii2RdzM2ClO0QkbAmKxLovySA+ORIa0DeE4gz8gzL
         KDHs0nrztFb8VEBFusWzQoUXMtKHzk1eG6jaDLpTjBIZVaQDqDz8faWoIlV+HhzwLqP+
         0j0Rom/w4RL4VbzIuRvjSsqI1ZKFOC9G1kMYFRksHQQqHCrNV+3DqoxfBn0DHLtcIPi9
         1NdF4Y0NhFRME8MTmWS2QO4ObJs5Bw9WWVFChLtbAvTHovM0ZpK0I+1DCgY7fCOE5NEl
         /dNg==
X-Forwarded-Encrypted: i=1; AHgh+RpA/2HPyD6Rq1NHzLtLRflQaDNewb21XauI4Bi+kR6f4lZ4lvonJivCxyuLa4mfB6zeDbuflN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCuMdWiRri+PFWe1dk3rkUN1fZ3L0HLU5mx5fBcXcKF75125b
	w2h6ko2e6SLILnDKj7vU9yDDPJ70zz+EmTDgCuDBHXevaACe1Eff8feXOaZPnpKSF+F0AZ7VAGj
	U3Y1fyZwLr+zZnDImP+LrKiNf4p3ibRg=
X-Gm-Gg: AfdE7clUskbky0auwfTnAK6SsRH0GYXsslMVE2n6qY/n0AA69o13zHQ424ZE6wZd1R3
	plP7/k28JaimhHp42zsliOL5NLXR1J1LSZk9JFLwfT8RfNS9AnWh+kNlOBGX0pZSzNLF4/bMBP/
	O2HmMaqCCUGXI9CH8/XDBSXAzvhc16uYHoWWeWJT1e7R0+I6iWfdVOnX3JFABlfHtg5w5G3iQx+
	hUHlw4efxx/833cH2NB8dBlNqPdUnMTWzLSGgcKV7msKMIKH5d2nxzeLMtekTm0Xc7ST0jLF4kF
	pUEimw==
X-Received: by 2002:a17:907:268e:b0:c12:4b0f:5d12 with SMTP id
 a640c23a62f3a-c15e77d185cmr145016966b.23.1783602316748; Thu, 09 Jul 2026
 06:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com> <2026070954-activist-left-8303@gregkh>
In-Reply-To: <2026070954-activist-left-8303@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 18:35:04 +0530
X-Gm-Features: AVVi8Cf41M_ijpHkKYz8M_XktE0qZUV9t_0z2x75RapbDuAjnTo52sPGA365USE
Message-ID: <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Stable <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306224-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ABAF731630

On Thu, Jul 9, 2026 at 6:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> > On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > > Hi Greg,
> > > >
> > > > Please consider backporting the following bridge multicast fix seri=
es to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > > >
> > > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplif=
y calculation")
> > > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
> > > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
> > > > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encod=
ing tests")
> > >
> > > Why is any of this needed in older kernels?
> > >
> > > And 7.0.y is long end-of-life.
> > >
> > > And why, if this does fix issues, was it not tagged for stable to sta=
rt
> > > with?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I already explained this in the email thread, "Please backport bridge
> > multicast exponential field encoding fix series to stable kernels".
>
> Sorry, but that's not here (remember, some of us get 1000+ emails a
> day.)
>
> Please explain why patches need to be backported when asking for them to
> be backported.
>
> thanks,
>
> greg k-h

Sorry for breaking the thread. I understand your point, I will
maintain this in the future.
How should I send the patchset that addresses the conflicts on 5.10.y
and 7.1.y? Shall I send the conflicts patchset as a series via a
different thread or how? I've never done this before, so I'm asking.

Here is the explanation for why the patches need to be backported:

History: The multicast stack currently supports decoding of IGMPv3 and
MLDv2 exponential timer field encodings, but lacks the corresponding
encoding logic when generating multicast query packets. As a result,
query intervals and response codes exceeding the linear encoding range
can be transmitted incorrectly. This can cause multicast queriers and
listeners to interpret different timing values, resulting in protocol
interoperability issues, membership timeouts, and premature multicast
group expiration.

Testing: The series adds the missing encoding support for both IGMPv3
and MLDv2 and includes selftests that validate the behavior.
I backported the series to v6.6.123.2 and verified the accompanying
selftests. The selftests fail on the unpatched kernel and pass after
applying the series, demonstrating both the bug and the effectiveness
of the fix.

Given that this is a protocol correctness issue affecting multicast
query generation, please consider backporting the complete series to
all applicable stable kernels.

