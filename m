Return-Path: <netdev+bounces-300243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YFbeNXYNM2qs8wUAu9opvQ
	(envelope-from <netdev+bounces-300243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:11:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31869C7DA
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:11:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jrife-io.20251104.gappssmtp.com header.s=20251104 header.b=NHQjduAY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300243-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300243-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F7E3006B3A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63440BCB6;
	Wed, 17 Jun 2026 21:11:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAEF42EEC4
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 21:11:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730672; cv=pass; b=ZEzRbPRo00VIpWSBlFV3ezRMNEdMuNEmgP/Ptu1h9edHLJIqhnXuL2KlEOiwn6wCVobpWkpxen1dxK4vgoPBPgNvRFwVflXQpdYs0g3LZkXUZ9o6gX2mJgmEZzj4zFgATWRuL2x0cakOkxQ8mTeNu0ikEtHlTodLcLh65LS2qus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730672; c=relaxed/simple;
	bh=J40Tvu1rOCL+IK2vrbjXSPatiwaLTLlKb/XEG1NrFCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USdR26MGZ2n8uzHBJqfHEtxW26JUi96TLcaN/C4uJMXY86rMKNzesMcys5i4hw6pV11dVjwOTJ5G8WcbxhikgGmuFgSH4uTdITm9PvycgqXobblF6ym5qtERsEh+zzVRx1YekS3ktHE8y0Cmo+7ErFQXGvxBDPIuyisugEwcKm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=NHQjduAY; arc=pass smtp.client-ip=209.85.160.181
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5175d230f1dso312101cf.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781730669; cv=none;
        d=google.com; s=arc-20240605;
        b=B1xy4peAOuungptbDOSHOcr+TC7xldKHBLWETY3F3KEKM3or/PdcDB2OdNhZqjWZyr
         N+pJs8H/gYInwaWZsIU9qdZVEEaT14Z6rmmKNKDo1FIcPQYqCl6rSPS2Z23ACnuqs2q0
         aHtiFvKpaUvllnFAfkZ4+vz31/oPzVzdWtmOS/VIxlIseqyppvUjIyXYPyJakMK2FwEP
         hB1DS/GJQJr69GEO6NZeRxzO38wQ1WNAuZPmKqIaBtl4wgJBu+q4xefbByCFQ5CNY8vO
         wXwEII1t6EYHNcSKW6RlEWC5H2GIYdWiIehBhu+NVbk2PNkv/H7uD5edqQlhdJlVCQVw
         EHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jNsypXk54MyAofAuixyNUwSehIAcko2VU3Z85jm6x+I=;
        fh=4SRluCEKrkjjqmcOQ38rSuTfxJmUAqrje+YSm4uTod0=;
        b=c2R0eNYG5kxzzLziyj6JBxUbKrGgTGMEFayacUKIaOG4HGAeJNgE0bK+vLEm7QK97c
         EgiZJoW/+jCjWy+tglXZLaRJmEMwgxNJcdRWHv4/jF2VrOkCNYPVl0Ki1h+xcV5eZBRI
         Bz0wgXBUy+bYT51VXc6mzuXKjdvrbEyjQx33ddPgnZV44whw/RZ+SSKpQhe2AGiHHYBl
         jXxtaU1jT5WjIk68W1zPAgzJiL9/K0o+8fxMp0ahDc77dhqufs4rEw3quP/eiWIiGbMu
         Pub86+O6McVgDbbtEZD+Kax+jz3OiwOnOH9K2xM+ps9yRSfyHffDcz48Zx5DMbnwyFmC
         4hXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781730669; x=1782335469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNsypXk54MyAofAuixyNUwSehIAcko2VU3Z85jm6x+I=;
        b=NHQjduAYYH3NxfMTEhW/wkQ6Y+kxjRH1azaC1eY0h9ADwdWykju0TWbFX4zCJwywo0
         lDYyY5DZYfHMMdOZscDHHTdfh1feUyCXpWApX78Dcg15h3S9APnhykPtTOOdUw4dgdxA
         Dyo9OnUD0bkVwb/mQZ1m/FRJvI4IvbU9RnVrmkBLKxrrvx5lv0hZ715plWKWW6wsA+nj
         uO8vP11QdD3+1FsOpxjNN5msbRDbV+Y/foSktgNsbZppC+ikNXh8kv/WFChcUtSBoPpB
         4fr7FZQ8/6oXyJC2WUAxFIRwSGAlVQ69/TjMKohKHHpIljuwqujuycWvWzq3+NayKPeA
         sv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781730669; x=1782335469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jNsypXk54MyAofAuixyNUwSehIAcko2VU3Z85jm6x+I=;
        b=S2FTjl2rEG/si2vRPRAnM+1iTv4o7pX/SGN9/JgcjRzevTO//t4yQPTsoBZ7SfA7Aw
         cYeNhXQyg67DIwEci2YJULZV2l4bnxxCn+BwMPLot3EeSNW+LYj5W+wHyl0BxgNEolNG
         WW2HtUgNqQWnqUCEIRQDarWJ9eE5t9zVsf3ecUcr1hAZzrq9o5fYT+ZlwlWhdTjLabnB
         w9a0NgGzbmCwbXCqdPg5mNWQOX7+VKNe2XfQLxXLH76a8IcC7qGdvVbHxNaOIhap/axi
         XYV74Z3gFnBKfot9FfAW2LvMW9u7KPVjTAS0BwWIU5xCXTQvfYeDzsJUNUiH4lDVmu5g
         WGxA==
X-Forwarded-Encrypted: i=1; AFNElJ+7eCKICKcRWLKOpS2KIMJz1uY8dcLhpsimsKT8J13a88BlqznN7Ha5fZogIZFVtuJGgoGZdsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBm87xF4PkggQ7LEMSOu5HKWfBQwdrHitxL1C6nve0earoiyFV
	9HujJ4X6Jz9vkFI2BeUnMrIOtotds7loMv4n4CIcLnUTKHskjnpcOJ8g58hdIu115TZdf9CO4ZT
	wDxTM808mpuaGJCDV0q10VxdUCCFlKfbS7pszvtTPKg==
X-Gm-Gg: Acq92OGwJa5/AXcdkcK1P096t/jcBc7vqrcBJ37Ic6r87fPy9vfkxl8o2XQxnEZ7C/Q
	Aw3VijhnniENHzoJa0ThcTmlgNbkxG/58Up6peJgizB22x+ZYhcifAlJt0MSajsmkKFWllNlfpR
	xggJYqTBlKFkAd21E9hnTqC+efUvmyjHKT1IflDADl+PxS2hUzqGsgDP+JIlkU0PNGiMzKYLHoG
	RGZCXaM8LDHimv5mDqwnhAa1ox3uuNYVig7mTM2Rs2rwHVDDfbSjorXAGpTmelpcEl5GomczAtj
	Hod2YgDDkdUH/8LGr0DYJPVaYsVpPQ==
X-Received: by 2002:ac8:5f0c:0:b0:517:5cbe:515d with SMTP id
 d75a77b69052e-519c6f2b40emr8185321cf.5.1781730669446; Wed, 17 Jun 2026
 14:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613183424.1198073-1-jordan@jrife.io> <ajAXF8Nvg91xU4f2@mail.gmail.com>
 <9da94ca2-a479-42e2-8941-b38c1a08566b@linux.dev>
In-Reply-To: <9da94ca2-a479-42e2-8941-b38c1a08566b@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Wed, 17 Jun 2026 14:10:58 -0700
X-Gm-Features: AVVi8CeEoqA4Hb4ot8Vx5adymXrSmujvHBhdKdVYZkDkbwAQc0BBebVHurmB8Iw
Message-ID: <CABi4-ohaL5Sov1rzms+0wT1Dd5ov3e_r6KxX-qOwFBLxrzuG=g@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jrife-io.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300243-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:paul.chaignon@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[jrife.io];
	FORGED_SENDER(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jordan@jrife.io,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jrife-io.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jrife.io:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A31869C7DA

> Agree.
>
>
> For the existing bpf_redirect_peer(ifindex, 0), there are two ways to
> read what 0 means:
>
> 1. If we consider the operated object to be the peer of ifindex, then 0
> means the peer does ingress.
> 2. If we consider the operated object to be ifindex itself, then 0 means
> ifindex does egress
>     (which results in its peer doing ingress).
>
> This patch's new mode operates on the peer =E2=80=94 on the host side, we=
 want
> to "write" to the dev inside the pod to
> make the packet look like it leaves the pod. That fits reading (1), where
> the flag describes the peer's direction: 0 is peer ingress, and this new
> mode is peer egress.
> So BPF_F_EGRESS would be the clearer name; reusing BPF_F_INGRESS for
> what is really a
> peer-egress action is what creates the ambiguity.

(2) is my original interpretation that makes BPF_F_INGRESS make sense;
you're operating on ifindex, so the flag matches the direction
relative to ifindex. Under that interpretation, 0 for "egress" (really
ingress on the peer side) and BPF_F_INGRESS for "ingress" (really
egress on the peer side) makes sense.

That said, I agree BPF_F_EGRESS is probably clearer, so I'll go with
that in the next version of the series.

