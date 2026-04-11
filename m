Return-Path: <netdev+bounces-277637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBtCDLij2Wm9rggAu9opvQ
	(envelope-from <netdev+bounces-277637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:28:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4313DDDBF
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 03:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 115923034541
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B4B1F419A;
	Sat, 11 Apr 2026 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOHFOsXb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433851D5151
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870897; cv=pass; b=S6/hlglvOkY/Y3tC+IlnSQqxfgrUiuDjR9FNyifSbYGGqPqa0YLx/gh1Tq/wOFNVFCoLPvpjDgsSLciDoPBnWtq9+yvUimtA8UxK8h9FrOprnknUJ9zdArckLeKOgt1qxhZWPTECTVp80rl4LMet/FEGCaIkPGPhjv0eOq8we2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870897; c=relaxed/simple;
	bh=sARHTMqKvBCZQlh4hioib58ltF7mRpUhN3lu0IlCoM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bK1ZxiNPhbOOmw0e4OnDMtkuaCx7ds1A2xW2T1Z6tmyKF4Fjyowau4uAW23gIzF6dJJu6kvyfKv7tWKUSF8SHNsABhPmAFF+VbeWbs46Jxy1nXo7PPZHuPmkJBmJ/uod88Ac2wK9XiXdkbr0b0B00sSkKNlzoSPZNySBEOvXgEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOHFOsXb; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79ab5fd969aso29557867b3.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775870894; cv=none;
        d=google.com; s=arc-20240605;
        b=HuwBc3D5mEkyfil+0rawuIf3Hco9No88rDj9uuVZWQWBfvwykyD0/3axvBUGWetPVb
         Bjs0Ugba17g0Ox0q9NEZ/iTJgl2+t4JiVrR8aR3FIME7FBwoRAxsrT5QvuuIFlhHV2Y3
         6P2xdGg7+rj8DYpndDZBpUQz0hvctssybTDULL6oEVG0erYpsdAcVVm8wz+junXrtlZM
         nTzZekllebcLZ0F+qNB7YyAcwUT76MgZZEDj77b04oFybaxcE0cAybyynBYaV0p5HNFl
         7iqD4hO43MLUqZf7YTaEBVgCkEwxrR5SeW+jJ6XM9sBUfMPYY0U6mEQgjfGzejdF80bM
         elpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0bew957SGHSKvBzAS0ore+LVnHZLQj3z4pL95ua2ACY=;
        fh=y6ObkKybqDtZlun7gIpDxHAo+1JDKZIIkVGubnS+7bE=;
        b=AHAdhmstmy4nJBk15fcFm2TLR4J6MtXK9N2MGShbdeWc7OdFSudsgVwEhJEhccO9eL
         DeYqTdgK20mJ+ixJnu/J9a/Fby+CBux+2qtwkwDZj7rTIoDCxlf9JpDLgzvaQYm6nTnz
         BKCly/6UtsSUUiA/08KhC0ufOYbQbQu+PQbY7P2EA7QfbCDzEtL8q5/Fq62n9h7draI2
         YwVbIYDW1pYGMhz/D8bEStyzoAiC12F+oRr9u1+xJI53shBXVXLg8cZZIeUF1ywAUPhR
         xBre/Lm3C7h0rEhUiSlKvPJ3ntxhHjb838GsCndbFcrPUxtNsE+Q8QFiITWFfsAqHWkJ
         ZIFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775870894; x=1776475694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bew957SGHSKvBzAS0ore+LVnHZLQj3z4pL95ua2ACY=;
        b=jOHFOsXbtu+xkTIVOziqHO2CKjQ268jRahPto8NgjFW5TLp0OfAxjUqyZ3IOTOCis0
         +jrc05dOHwTlCUN3T8VXX5RqOauCEXs1A1iNuQhNOMEHhtM+RsD4kp7nq75IhVFjtASM
         CEwd4yE4dmi8uYpc06KyKf7BijdvWJqVysw5Fakp6fW+eQsV8Ebbm21Ctj/1yI5sV1JT
         rn+yQ6v06pEa44U1OWBl+R8LSTSNZgC4kLpfdkzm7/IBhhidJu3IpTeG1PNk4ZMMExTv
         vbcq+B9BqbdzZN6vMh7PDpfTUhfUT/4g1/0+mybUG+rYdknWAGnAilM7OKapt1zSH2DQ
         4Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775870894; x=1776475694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0bew957SGHSKvBzAS0ore+LVnHZLQj3z4pL95ua2ACY=;
        b=VE0hSXe9Ym6J1bamM4tBkyeD4tFjIdQg7vTVMrk/pOgCTMU+M0T+KlaGrtv6VIZAFi
         BrsgmM1nEfq1nMq94H1amLwxRtTpdMutvsvhWj9I46vWNvfjQXqFi8V9VYiXRskDFInu
         77jTwwsL5S2CjFc58P2OVoVjrxvjFsV9cKJvMRlH6G6Mj65TWibVexrqcaNxCuBxKW+A
         wOqrIE35QHZexkAdT9murUx9zS7B0JajrNAnIt9puUYh4elo2ZapJIMAmKkV71QOU+V+
         X6OH4oBkQh0bu5Mv2OJ1kTqJiwZVW5Bec600HAUEpqpEGcPP3j39Yfg2+tvvKPKK4z+S
         r5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV+U3H6pbMWlHPCliPfWeJgPYq3wiqDLbLoH7S/gQdewlMpAZ3cKBlWm5WPclueKgEcsvsefuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI/Iz9xIE67exp+N/n2YBa3IW5rZoC8zfL7MonCh0qKHfVg5Ua
	7nwEhj91ICrR1KqV3dAwYFFpBhXqfMmxU7uweH/6V0MqfZM5Xha1AC6CXrDF4SH55eCWTuIpJ+6
	aXrt3AV/tAkZ7YbhRzAzV9Xp5nnMp8pY=
X-Gm-Gg: AeBDieuGda5mQvgn60SVAIpQGDbQeBE0cx3XJNqtmV/TsECWwMu3m2RQXVibsr6nzdn
	SLFIWq2jAHs9wUGcoaW4QNfawxHy/WAr69yxBqBk3n8luwUnGP4vHWZ5KLOX5G115l5uYQ2m5JO
	tYxWb3dtnj/coLscT7o+5OYXsiMqluhen89WNNf4tuLHkKxe+Ioenh8dMJMABQut9kQOyuKGMZA
	FLwefqqbhFTi+zAq+jzhGhmftEPpuV9L40fq+j0VgHVoMyXC0SKjbHdvUU6JwU1pZg0q6Phhqrj
	n1TqKjE=
X-Received: by 2002:a05:690c:c147:b0:798:1219:c780 with SMTP id
 00721157ae682-7af71478e3dmr55601077b3.26.1775870894222; Fri, 10 Apr 2026
 18:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411001711.3418264-4-ameryhung@gmail.com> <9f7e217d9a5184bfcf0bd1112a9075c0f3633266e8eb1026cd1c651a0754edb2@mail.kernel.org>
 <CAADnVQJ5gSL1XDYYwgKgq6pxLG0m9m6mC1DntHxLCrMmQ8Gp=g@mail.gmail.com>
In-Reply-To: <CAADnVQJ5gSL1XDYYwgKgq6pxLG0m9m6mC1DntHxLCrMmQ8Gp=g@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 10 Apr 2026 18:28:03 -0700
X-Gm-Features: AQROBzB3Y0gFVbZ0QmWcDCTtHxj-St6CKseFfy6xjF80Iq5WC9m-ibzU1-h_apA
Message-ID: <CAMB2axPw_YQZaj3LoYVbR3Wo+RzWma32KfXzdedz9Of_nakVWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] bpf: Remove gfp_flags plumbing from bpf_local_storage_update()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277637-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,gmail.com,meta.com,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8A4313DDDBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 6:19=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Apr 10, 2026 at 5:51=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
> >
> > > diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_lo=
cal_storage.h
> > > index dced54e9265f..9e4f5c45c974 100644
> > > --- a/include/linux/bpf_local_storage.h
> > > +++ b/include/linux/bpf_local_storage.h
> > > @@ -188,7 +188,7 @@ int bpf_selem_link_map(struct bpf_local_storage_m=
ap *smap,
> > >
> > >  struct bpf_local_storage_elem *
> > >  bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, voi=
d *value,
> > > -             bool swap_uptrs, gfp_t gfp_flags);
> > > +             bool swap_uptrs);
> >
> > [ ... ]
> >
> > > @@ -196,12 +196,11 @@ void bpf_selem_free(struct bpf_local_storage_el=
em *selem,
> > >  int
> > >  bpf_local_storage_alloc(void *owner,
> > >                       struct bpf_local_storage_map *smap,
> > > -                     struct bpf_local_storage_elem *first_selem,
> > > -                     gfp_t gfp_flags);
> > > +                     struct bpf_local_storage_elem *first_selem);
> >
> > bpf_selem_alloc() now takes 4 arguments and bpf_local_storage_alloc()
> > takes 3, but bpf_sk_storage_clone_elem() and bpf_sk_storage_clone()
> > in net/core/bpf_sk_storage.c were not updated:
> >
> > net/core/bpf_sk_storage.c:bpf_sk_storage_clone_elem() {
> >     copy_selem =3D bpf_selem_alloc(smap, newsk, NULL, false, GFP_ATOMIC=
);
> > }
> >
> > net/core/bpf_sk_storage.c:bpf_sk_storage_clone() {
> >     ret =3D bpf_local_storage_alloc(newsk, smap, copy_selem, GFP_ATOMIC=
);
> > }
> >
> > Won't this break the build?
>
> Nice cleanup! Pls fix the build and respin right away.

Oh well. That's embarrassing... I made some changes to the last patch
at the last minute but didn't test it. Will respin right away.

