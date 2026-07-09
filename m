Return-Path: <netdev+bounces-306296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9ABPALS6T2qVnQIAu9opvQ
	(envelope-from <netdev+bounces-306296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:13:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F985732AFE
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 17:13:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cZShSS8r;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306296-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306296-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9A0E3002B20
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB073815F3;
	Thu,  9 Jul 2026 15:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A437AA75
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 15:13:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610033; cv=pass; b=huAecdmiLBNS9c9f7ddGVUC5ESnLL4GImG2wU2GKMy4G+Aw+adb70Rqp58tP5qRAAubVMM5Tir2KjhwzLKwWGvsCkjRQlP8Skr8vjoO0qq0SCVEtXHigb+SlbOtvb+7N9Fr98oGyHpi4zGyQIuRWTc663gMYMMLZCWs3QPVhIBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610033; c=relaxed/simple;
	bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dt0vpwVjQUBijgtE/TUQoXMUE+BLSaztMDYZmWIoiDNRo1vab61YwDuXyCOVkb/8RrxfMUCDv7zd0+M7WuT2pJLOMABsLkuI7OWHcO1D+bldSu8qXZpB8SLRde4tJkW2VhEGs/cMGN6zj9hrygr3+eUGC4ynwg+Sw1BKUm1K1h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZShSS8r; arc=pass smtp.client-ip=209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15bf399d3bso240505166b.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 08:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783610030; cv=none;
        d=google.com; s=arc-20260327;
        b=PXfWY+frKLP7Rr912I+iBhYPeIdlSPuY41rvK91Z0BezXv2Ao9OzWRJyhtzJlDCSN4
         hDo79hflAxVmzpqJYtj5eoreAk8v8wKRixI1L+6TC+9Ls2K4gxYdqBZhQcJJ53/oHlgs
         vxQ2qrythg8Qic6F5UyJUqFbqJrfwgAiqreJ9PAYsVvLst7VWT5CTvKbx55yrjSAVur4
         zewXV0I3DUviNwWpPkPmEJqy1dhZTwWpxEiju/XidLTQ71nC63U10KuNIGaAfrLMPoqC
         juHM0hc5MkcHFMo/1cjIiT9/89LBaTJkLsEuCSDK7l66XCFQlWQ7hwcJdQivLHpCEMNA
         gbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
        fh=QFq5JyauwUEu/nmh6dodvSqs+LcRe7kdIe2nwoQLwqM=;
        b=UnAkfCyCFgX/mKmhYEC5EktvyZPszE8H0/4d7sUTEq8Hq1vERB7Xs1pkIjNe0SKqTk
         n+Qr49UfhoZ2qiYPxEHI4BKNa2D5hho9wL0+WFUw8USibV7N0TgiVlxJhZH6Hm78bRhm
         i8h/P98A4uJTcKBSgvKcWk6FTKKHC9mjASZMqmfF8G2EJQSlcfEGAgEGB/tzRFDjI7xr
         uUv4vOER4deDDZ21O/2zp7TBMI/6WppBz6goGAsuARAuqFm7iPw6OjPiseJgd2eIhVvT
         T0TjMvmvtQo0oERl+YqzZ49B5LW3rV6IFLx9K/S0Q9H48cshykJRpsDTlYaVM+EPDeZk
         0SNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783610030; x=1784214830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
        b=cZShSS8ro0THpxKUvnqocyUpAo9soBXcXvDp47ckLhenrBhPQ4tyd8EgkuJyqEpedz
         Oqy8pQnBufM2azAaXoVITXgjgXjm5gIRGUUctc3JpFFFt4lxLafzDe/H/TZPlx9P/9f5
         MKacuUcSnVUzfgRrbScM/zrSNXAw+G0+JCAwxID5SKn47zNpFcuB5R67QtMe6fugaxjW
         vzNrVUyE3/O4N/f4kQA/I3Aw3sm5YnTU4tWoHydMSFE/7T1ngHtUncDPtlvYVaz5oIq/
         XaiqR3rdwn7uMOTnzFX1ba4h+KnthRIOTFc+jdn4avr8ApxEuTrBZrt1XzHuYprYhRjU
         z5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610030; x=1784214830;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lm+iwZuldvNfgm8Lzbku/fwQXnHvxwIB+0za3JCHtHk=;
        b=fZDZXsz58fDtqJuB6jly/xGIXG67nX+01EfEjmlDWyhwT5tzWKF/az9vEJ8X0Xzvlg
         70KSMp5PKffYZ153ubj1kFs9o5v5D22gBCpcuNWQwM6WMBK3XVgaNdC5aQRHq9cOZ6pe
         TOV8E5MoI6wpwKbx01YNjlH+wk62uJNIwrHuBUY5ksYwa3NvKY9mrrPK9J2vc3B81nyt
         MWdd7TF7AVmw7nbBheOBogD0Cb98opxv8WRtI7EgpyXWRrTBO1528kmOj+AsIxmOFqEu
         uHO4vrmB1yK/ydBcd22zR+h+NDzIWbjYAMhBPzcPUa6PPInzLO2DfClpiC+jdGlPfiXx
         9coQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSwF6AZr48wuBXX8MN395pYDmyuMlWdxOiG8U3hv2skQi7OZEHVCTHqaHVGSQ4YFkcT68X1to=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Sy5or372u3aC3aFIfYWukgz403rp+/Kg3CS3lo9cvYUVxFi1
	KSX0Qsn7PydOgyDxY43N3Bw5kXmmfX0+sbMYN5MdA+dpaqmg+vPBMdFf16tN+PwAR0TwrhMA4u/
	M5MJCbSylYSzmh3yZ1950Ni5b+ZJn+IhrxZIQQLtaPw==
X-Gm-Gg: AfdE7cnpQ4v5DPICzTO+PsSpN2MaeFc3U6ofnn3cHiA4kgB+9z98QLJmCsuPqQYcSxr
	bNr0iIl1mT83XengA3Wuas9QH6sNijb0hjz7HhxwgvN/uXEmo47Lgl4FrMIyXDV9ML2XRA1jP1u
	kpNkG66n3X1moAmVHzzYw0mv9gkiOBeJcnk7IP5B0PLpIrpje6Flwk4PXhrX7tbY/H7UmbGpU5n
	t7Z8G6P99KGu/mCvL0LKS+DpE/rXLKMzsPMiWxhjW1yAcja2pAORYd1Jtf9m/mxmxL21DQ=
X-Received: by 2002:a17:907:1b1c:b0:bed:19af:f89a with SMTP id
 a640c23a62f3a-c15cde8c84dmr329373166b.7.1783610029787; Thu, 09 Jul 2026
 08:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh>
In-Reply-To: <2026070948-lively-exchange-a458@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 20:43:37 +0530
X-Gm-Features: AVVi8CfKbtzcJnRxXIx3ULOTra4r8qYMzKp7zTKSzETyFRYKJOujtPr221wvxYo
Message-ID: <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306296-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F985732AFE

On Thu, Jul 9, 2026 at 7:52=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jul 09, 2026 at 06:35:04PM +0530, Ujjal Roy wrote:
> > On Thu, Jul 9, 2026 at 6:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> > >
> > > On Thu, Jul 09, 2026 at 06:12:40PM +0530, Ujjal Roy wrote:
> > > > On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfoundat=
ion.org> wrote:
> > > > >
> > > > > On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > Please consider backporting the following bridge multicast fix =
series to 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> > > > > >
> > > > > > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and sim=
plify calculation")
> > > > > > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi(=
)")
> > > > > > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields"=
)
> > > > > > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > > > > > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field e=
ncoding tests")
> > > > >
> > > > > Why is any of this needed in older kernels?
> > > > >
> > > > > And 7.0.y is long end-of-life.
> > > > >
> > > > > And why, if this does fix issues, was it not tagged for stable to=
 start
> > > > > with?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > I already explained this in the email thread, "Please backport brid=
ge
> > > > multicast exponential field encoding fix series to stable kernels".
> > >
> > > Sorry, but that's not here (remember, some of us get 1000+ emails a
> > > day.)
> > >
> > > Please explain why patches need to be backported when asking for them=
 to
> > > be backported.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Sorry for breaking the thread. I understand your point, I will
> > maintain this in the future.
> > How should I send the patchset that addresses the conflicts on 5.10.y
> > and 7.1.y? Shall I send the conflicts patchset as a series via a
> > different thread or how? I've never done this before, so I'm asking.
> >
> > Here is the explanation for why the patches need to be backported:
> >
> > History: The multicast stack currently supports decoding of IGMPv3 and
> > MLDv2 exponential timer field encodings, but lacks the corresponding
> > encoding logic when generating multicast query packets. As a result,
> > query intervals and response codes exceeding the linear encoding range
> > can be transmitted incorrectly. This can cause multicast queriers and
> > listeners to interpret different timing values, resulting in protocol
> > interoperability issues, membership timeouts, and premature multicast
> > group expiration.
> >
> > Testing: The series adds the missing encoding support for both IGMPv3
> > and MLDv2 and includes selftests that validate the behavior.
> > I backported the series to v6.6.123.2 and verified the accompanying
> > selftests. The selftests fail on the unpatched kernel and pass after
> > applying the series, demonstrating both the bug and the effectiveness
> > of the fix.
> >
> > Given that this is a protocol correctness issue affecting multicast
> > query generation, please consider backporting the complete series to
> > all applicable stable kernels.
> >
>
> But this really seems like a new feature being added, it's not fixing a
> regression of something that previously worked, right?
>
> WHy can't people just update to the latest kernel release to get this if
> they need it for their environments?
>
> thanks,
>
> greg k-h

This is a corner case when people set the query timer value higher
than 128. People usually use the default value and don't change it, so
they may not encounter this issue. But I found it when I changed the
value during some extensive validation of protocol timeouts.

If one host doesn't have this fix, clients will observe premature
multicast group expiration. For example, a set-top box channel might
disconnect early.

But we can ignore this until few more people request this fix for older ker=
nels.

