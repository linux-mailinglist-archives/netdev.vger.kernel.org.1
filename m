Return-Path: <netdev+bounces-306300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3AXsOvW+T2rjngIAu9opvQ
	(envelope-from <netdev+bounces-306300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:32:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5571E732EDC
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:32:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TsqHczED;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306300-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306300-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7557A306F6E7
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 15:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02560367280;
	Thu,  9 Jul 2026 15:22:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF98364949
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 15:22:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610523; cv=pass; b=XLsvdi34vOWKU9a8g1LTlUciqAmeTN8mXQ1kqCh37Fw/1dVfp9TG+M49rDMt/Ar3JTk7bmBM/bYgMD490wQo8TwxX9RURAsJ+6JbMYejl8kFY0j/508vM82B5CnbOly4IDiuWc7m0JLqySFY8hWQ8hW8Bfl6gLsIMhPVQWwEwgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610523; c=relaxed/simple;
	bh=iDolcu2mWBl3uEuQAfKWNLBAt748fEeXf9V7/Qg2coE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZK7T295i7Sr267RDaDwRKEd9r2W9Eiv9RMIpy2sOBVzG20BjyrsozKtK+rfEPMWRhkYv9Rq7w7vHzXZKsGM01a5c87R2kzHO/ycSmP7569FMcxZSOZzfANdTrMrkUqPGUp3rmWnP8jARTJHs0Dm4JK1JFh95Ebf/p3JDQujrj+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsqHczED; arc=pass smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso54057a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 08:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783610521; cv=none;
        d=google.com; s=arc-20260327;
        b=VwCyqYv9R81H/3VB6w3hoaeSTn9sWu7PBgB3lUrZYzRCJEYS9g6Z9V8oTn0ZLT/Woa
         v/tpIgnwqcTDfoEkzy8FGJwVwb4khRyU5qHlz4Ti4nkDHDdBJOwG6JgJkYkai2DfUN8Y
         nuRfntyU9l0/aXW0xv4Q2JNayIyguT1num1rxpeMVl65/MaqR8GfxxJVEYUGxBZiTD8F
         sHkzPuZZNIwRC0IL476pqtxq053lc1uCdDULV5wfpNfJul6K0wwG6+RYcVal1Uty/ClG
         jaqhNt/mbh1sCOb0kYP/i3tc2E9Gugz2bZX6tbN7+tF5yWmZJNt26hn9Zles7wd7O6JY
         o7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hl6Al4OsGwcvHqvs4fyMXGCvJt1Svt3mIHpxW1j8jYM=;
        fh=ZPkSkUo8Y+KoHGHJKw0Ua4MlYinV2HaJce5/3HtR82U=;
        b=c/4UkVV94Zooxb4LyackLvlgDgjtpmzqzQP4M2geijx6JpOzYDoh9i2Wv/ooIWstO1
         CLlwh8yUpOhtYfYiRBjaznTpI4gLcD6LYV5MdaovwijfVDdDEOhNJYKP3EqhwBYCw3/9
         +ST2s+RyXUK+uYLWHZQvF9balmPss+/x7rXhqxW6r7tTL/YHL1FKO0KzYr0dOqQZvwxe
         WrmsY2GrqksaGNC9NXbpMDi1EgiU1NpWlag2is7Wl06otzz7UaFrm0T5kXc6191fA3vX
         N1DpxIyQE0NIRbPyvKNuQbAI26732H7/XosD8Tpd22pJw5y3D5uyuUyJxMWWTsm77oPl
         VH+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783610521; x=1784215321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hl6Al4OsGwcvHqvs4fyMXGCvJt1Svt3mIHpxW1j8jYM=;
        b=TsqHczEDJldQiZK/ESWR3KqkEm6n9cEFC70RJpD5dXohfFRnFlHO8ST/g0njQFxcI9
         D+ppeeF28wysOQP7cOxXtWEJZlkw4wjN2qbqD0hXlm9ZYR0tOuHXn88MnHR2HBNRr09K
         hyXTgtAGNn8z/KWcjSIowJDRmXJED7XtVfKBINAIpkBaVuG0SsUIQ1wsYz7k7Tdg3N7t
         +p493Ulp4DVQEqRDph2S54h2vHX3TQznLI6lZZQA58/k8PV/2cFTEHODiyBRMwRu+8Vn
         pyZctllTnAdJWreT+tzWfvydtrmu33+WNkL7/uW3KfNpdY0xGfXHxqbJdAifeqZAuB+M
         U6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610521; x=1784215321;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hl6Al4OsGwcvHqvs4fyMXGCvJt1Svt3mIHpxW1j8jYM=;
        b=ptoeKSuzc0YNbt36gSofPFojT1y6ML+FBMzUk/4Jltw3PaSfHjcYT+KeM1qGH4lEHT
         jhHduF1EoKRsX/loWnxCM4l6Rw+emPbCu4pEK57DTYcoqggV67tN+dpNsmXeMqJp3LmD
         Czanw+e0TaehsCsBIVx2X8ex7VrQRzsJBLOv2bylnM+jrUnWcifhhRWOcwO1+x4WL16H
         CGHehH+OXoxL3adV4w/6eyx0Nb6CDlZ9zu2I8KUq6nb2LhRLK+CC8bza1lPyO0vd956g
         p+gjtPzcKX4Sn17nmTRCLYAR4BN6VyucA3PEfplTDLb9sg6kRm40Z1Vv6qzqXlC96oH5
         esKw==
X-Forwarded-Encrypted: i=1; AHgh+RrMGCbiBiSp/ysAsFTAp5N3B5jGTRSqHomFtiB0YjYgALVxqUP/Yg5Hq1L+qt7IKuMH9oRwVk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzerpsVc1DFkOX7FhU4WWm+Wzk5oq2aoyXYN2+nxFhcPNcVX2v1
	gdTuSVzc7urJ+s+zs3qXuD7Yep7pLp9anQcbW3QfaiZnw5HFHFvBD4sc7I3srPvTKbgHtRhfoo+
	QUbhZxIsMZmUA4tUghdHRqZFDnaSanqw=
X-Gm-Gg: AfdE7cl/jOlTizwZwAynYqBJpApf+ALZFMIN7IFycjBHwRtzpgPv/HmrRa7bAitERE0
	tS/bIpnp3pewwHJL4RgQzxiMZ1zuR04DXZ9FuOwu2ve63r99aKykGjuIh6eZBibA04S1Vd04xR3
	wBKlUr7JBbnCy2prYQiI1iTeWUjNLv15dT78R5H/DCv1l5EwuqS3ae6+vsP29ZIF+J9m7MXKfHC
	nWNl+p4mCRxdX5WrujwP+1pDwURdhwKdxO7C2rChkL+DfCTwfcr6RwlankwKIAsoWfL9sY=
X-Received: by 2002:a17:907:c50e:b0:c12:6280:33c9 with SMTP id
 a640c23a62f3a-c15e780ee92mr173767266b.28.1783610520581; Thu, 09 Jul 2026
 08:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
In-Reply-To: <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 20:51:46 +0530
X-Gm-Features: AVVi8CdJgqKVLA2sAn6f7XPums4J2L125q9McUSFj0u2k_NGu-cn3IODEhE9pa8
Message-ID: <CAE2MWk=xfQ1SpkHnVL0Tsru4e=_8xi2XvESs4Lh+=g4cbFEuuA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306300-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5571E732EDC

On Thu, Jul 9, 2026 at 8:43=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> wrote=
:
>
> On Thu, Jul 9, 2026 at 7:52=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> >
> > On Thu, Jul 09, 2026 at 06:35:04PM +0530, Ujjal Roy wrote:
> > > On Thu, Jul 9, 2026 at 6:23=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > > >
> > > > On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> > > > > On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfound=
ation.org> wrote:
> > > > > >
> > > > > > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > Please consider backporting the following bridge multicast fi=
x series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > > > > > >
> > > > > > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and s=
implify calculation")
> > > > > > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qq=
i()")
> > > > > > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential field=
s")
> > > > > > > e51560f4220a ("ipv6: mld: encode multicast exponential fields=
")
> > > > > > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field=
 encoding tests")
> > > > > >
> > > > > > Why is any of this needed in older kernels?
> > > > > >
> > > > > > And 7.0.y is long end-of-life.
> > > > > >
> > > > > > And why, if this does fix issues, was it not tagged for stable =
to start
> > > > > > with?
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > >
> > > > > I already explained this in the email thread, "Please backport br=
idge
> > > > > multicast exponential field encoding fix series to stable kernels=
".
> > > >
> > > > Sorry, but that's not here (remember, some of us get 1000+ emails a
> > > > day.)
> > > >
> > > > Please explain why patches need to be backported when asking for th=
em to
> > > > be backported.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > Sorry for breaking the thread. I understand your point, I will
> > > maintain this in the future.
> > > How should I send the patchset that addresses the conflicts on 5.10.y
> > > and 7.1.y? Shall I send the conflicts patchset as a series via a
> > > different thread or how? I've never done this before, so I'm asking.
> > >
> > > Here is the explanation for why the patches need to be backported:
> > >
> > > History: The multicast stack currently supports decoding of IGMPv3 an=
d
> > > MLDv2 exponential timer field encodings, but lacks the corresponding
> > > encoding logic when generating multicast query packets. As a result,
> > > query intervals and response codes exceeding the linear encoding rang=
e
> > > can be transmitted incorrectly. This can cause multicast queriers and
> > > listeners to interpret different timing values, resulting in protocol
> > > interoperability issues, membership timeouts, and premature multicast
> > > group expiration.
> > >
> > > Testing: The series adds the missing encoding support for both IGMPv3
> > > and MLDv2 and includes selftests that validate the behavior.
> > > I backported the series to v6.6.123.2 and verified the accompanying
> > > selftests. The selftests fail on the unpatched kernel and pass after
> > > applying the series, demonstrating both the bug and the effectiveness
> > > of the fix.
> > >
> > > Given that this is a protocol correctness issue affecting multicast
> > > query generation, please consider backporting the complete series to
> > > all applicable stable kernels.
> > >
> >
> > But this really seems like a new feature being added, it's not fixing a
> > regression of something that previously worked, right?
> >
> > WHy can't people just update to the latest kernel release to get this i=
f
> > they need it for their environments?
> >
> > thanks,
> >
> > greg k-h
>
> This is a corner case when people set the query timer value higher
> than 128. People usually use the default value and don't change it, so
> they may not encounter this issue. But I found it when I changed the
> value during some extensive validation of protocol timeouts.
>
> If one host doesn't have this fix, clients will observe premature
> multicast group expiration. For example, a set-top box channel might
> disconnect early.
>
> But we can ignore this until few more people request this fix for older k=
ernels.

Last two patches actually fix the timeout issue. Below one fixes QQIC
encoding BUG for IPv4.

95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
@@ -780,11 +780,9 @@ static struct sk_buff
*br_ip4_multicast_alloc_query(struct net_bridge *br,
        case 3:
                ihv3 =3D igmpv3_query_hdr(skb);
                ihv3->type =3D IGMP_HOST_MEMBERSHIP_QUERY;
-               ihv3->code =3D (group ? br->multicast_last_member_interval =
:
-                                     br->multicast_query_response_interval=
) /
-                            (HZ / IGMP_TIMER_SCALE);
+               ihv3->code =3D igmpv3_mrc(mrt / (HZ / IGMP_TIMER_SCALE));
                ihv3->group =3D group;
-               ihv3->qqic =3D br->multicast_query_interval / HZ;
+               ihv3->qqic =3D igmpv3_qqic(br->multicast_query_interval
/ HZ);  // This was not encoding earlier

