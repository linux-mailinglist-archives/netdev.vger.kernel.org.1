Return-Path: <netdev+bounces-255491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFceOl5NfmnQWwIAu9opvQ
	(envelope-from <netdev+bounces-255491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:43:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9F1C38D4
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3CC930041D6
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E62366DB6;
	Sat, 31 Jan 2026 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4C4cc20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BC2AD10
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885019; cv=pass; b=p62CAQKr/Adfhz3Do5ezMJ+YsOPij5tQ7DGSW+dA29Sdw/gVOkPZ2hkuDhjnCmjijJXtD0zMHJh3WZVmRT7K032THluDkKD5nGnYLI18CVfnJdXywo1zDv8/Uw0KF/5dx4eGodqt+eTrZeKlX7gTJkrB383IYoZNtzRWyVmvih0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885019; c=relaxed/simple;
	bh=rkBEBYuwb/JC4c8oQq2ILFkkUFeJejQiN5E98QHGepg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSbfIy4pZHpzp1entDz6/xWZstIxtvzgsbWaDpqfDxVAWFCeWp71tvqU44wFIfuWcjn9RwPTaSvObyb1BPPTcSM7PAxNJncKbXuaysJIWbTttNvtXCy/HkinZJxdDNI+iOdHyKu/WCjmzLIhiw6Gyaq/qipuqV3M5wolVQWrn2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4C4cc20; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6498401cfb4so3119408d50.2
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:43:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769885017; cv=none;
        d=google.com; s=arc-20240605;
        b=lBwRGou9mKe9E0gVMaPYomCLvQddiqI7aiUltPL9unn3hqagmArOMnvhphqAGoQTLz
         0jKoIPiQ7vwQUS/m6dFyEYqDNyUZRBKJ+0UgNR+hgGrDTGggLX0bqnb8/7GrSBO57BD2
         LDzhrASvPA3OA72uDyDChgt7G2UCbs6mat3GgLXIbi+VCwkDGHbDgBSzGBE2hMDyiOZu
         s2/yQvoMTwhA6qhrWSuIRq+lVKQpn7da9t/uqwC79rljPbcOYcFv3a9Ba4Whh9umIp/L
         /Z0tC4WJ88bJfMtE3hsHlBB1z0484aZFObAFzB8/9tl1ZjegD+0emz0Sw2EMOrN+QPBh
         +8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TfO8hD4f0LL/XaXPlEc4lGUvKKLqPmej+W+yxaxFK10=;
        fh=BxC4UBMQbmeD8iQGJRkoKpKR/a11f6dVBm7VmSa4oQc=;
        b=TfFkdngyYcjlRQ07ofrSmwVHx9zfhamNwQwyn7OwkIVzBtw+jqopvNfmQK/Yv74+OS
         RwlNAnHIimnOzOEM7K4oBv7RPywuNGpeepfpx9LP7iE72d8TL5jLjzKlz5kmiXQjAukG
         ze8pb1+ORmfxR3fu1P9F0esCj+z8fa+GmpkJla3M5xpwb1AiNeP4enZxp5bqvRgEQoip
         +cVc8nKvgdkeiy50+UK+Fxchn6TqdLDKKDiepZ4aditE2VpXL32JISi9HW3UuvsShuBm
         y8Vz/zCwfcFjvl6qsd4GsCcN/FdwkZAr7xVRdC20aQmlYL1adsRMUWrqNsFRinxfKVH1
         KyZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885017; x=1770489817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfO8hD4f0LL/XaXPlEc4lGUvKKLqPmej+W+yxaxFK10=;
        b=S4C4cc20kLZB+/nhWaH9zt3S+k1W7YxV23lWhKyHcj6PIMHUcnvANgMGmObYmwQwFc
         8vXKCBDNDBK1qbWdJDLNQvhmf1AhKdT7PWv0lEyBS1PjcyS4Uv2nZ6AOUR1OIuQXiQq+
         yrHIasFa88ri4TW/TUfR1f0HK5zscXk5Q0YjnXYEptla4+b5v6ne4s3oLrLM0dMkv6dv
         X3MhIQhjBaoYwV/2RPQNDOYnRPpsHfsq0YvP1H6MUCGVCOIwZLTn6Bjx6VOyLOqQS4u2
         2rPRdGnmavrfCcwsSerxeKofu/El1wcoLEwCseaJQGI7rsybCP6m56H1ALZA5Ley8j8A
         aPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885017; x=1770489817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfO8hD4f0LL/XaXPlEc4lGUvKKLqPmej+W+yxaxFK10=;
        b=q2AFMubLOICbGiYuVNX4Iw5H5dmnZ0QHSZw37GcKQRRTrXsSgex3+Qq0Zp0tCVyzOr
         D4a1aEh8u8hKeFX/2/w3D/MDKzGyReEufxMiCG2S9gizeKLJ7lku09ZSiegcJMfhS6fh
         wXCUbVq1iqz4WsqJyKYDsYBYPbOhIVznOjoLuTluE0GIRYyQbE/6v8XOD4HAiLxffoai
         Mey15LNyNejJuExEf2ZI5gw4cRfOxPh2Z4usED3B/DObxHjEj2WG8Ec5AJtDKbhpXmHX
         /A5rNBq5b+jwezHpObjH2H5L5cwIOjIOdW1XGSqWycKmbvD85l0Ue50fKZEpNqBnKhIi
         Yj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCViVe2lZVLqzm3rCW00P8lqYw/oez9PQmVI8ZXHa36hzyMQNQ6JLzbmJDO+L71aXfYAG4/okLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJr1RF8GfhJHU0rAr26mKI5BWuB3x/rtM6+uzj1O5tauksOZDv
	TJQEpG1ZSEB6DxS9CzJa5aLmRreVTaDtQKSkZQNdylZKq1kw/mSTptBsI+XnNDGNdi8ukJ/ZHNG
	UOtg7Nhu8Y6xnbPm9Jt7x2xkxmKoDbVc=
X-Gm-Gg: AZuq6aIoChCf886a0xRGslQBdlFzlB1fFP4wdWrr7oJFsvaMnnuwel13XPnEm1CZehu
	wQ67WNMtIeFrsmnmcGU/hnw6z5uMe+sM09T3TzE0L5Q2ueJr7iRNTAeb0KN89ELUjpGWrnIosSe
	3n7hqZ2h0Hfamak514LOQRkQGSG2TQ4NAWiNTNzyd9bre6mfborOd2GzGV+3T77/fRniAqkm68Q
	EWOZUp0d7rlUaPsuYPjw2uhmU0MmVLw6B8ef6Wb5rZ5JsbIgBzxxs+FHpUq+Gnnxc2Xu24=
X-Received: by 2002:a05:690c:6a83:b0:789:2be7:ae80 with SMTP id
 00721157ae682-7949e075338mr133133587b3.54.1769885017480; Sat, 31 Jan 2026
 10:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131050920.2574084-4-ameryhung@gmail.com> <6497e7de7911a13edaf39f91f47719c418c67ea8918f589b7d08737790181e0b@mail.kernel.org>
In-Reply-To: <6497e7de7911a13edaf39f91f47719c418c67ea8918f589b7d08737790181e0b@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Sat, 31 Jan 2026 10:43:26 -0800
X-Gm-Features: AZwV_QjsIQi24JfJzKfp91_VOK65ha6WnTVDIqndrexI5dIoypyp2tgWcMaSbyY
Message-ID: <CAMB2axNgigsCp2AYG9Smj+bRgN6eANP-yqmqUq0dQmSvxr3FNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/16] bpf: Convert bpf_selem_link_map to failable
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kpsingh@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, haoluo@google.com, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255491-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D9F1C38D4
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 9:33=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index de111818f..9da11a531 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -191,7 +191,9 @@ int bpf_sk_storage_clone(const struct sock *sk, str=
uct sock *newsk)
> >               }
> >
> >               if (new_sk_storage) {
> > -                     bpf_selem_link_map(smap, copy_selem);
> > +                     ret =3D bpf_selem_link_map(smap, copy_selem);
> > +                     if (ret)
> > +                             goto out;
> >                       bpf_selem_link_storage_nolock(new_sk_storage, cop=
y_selem);
> >               } else {
> >                       ret =3D bpf_local_storage_alloc(newsk, smap, copy=
_selem, GFP_ATOMIC);
>
> When bpf_selem_link_map() fails, should there be cleanup similar to the
> else branch? At this point copy_selem has been allocated via
> bpf_sk_storage_clone_elem() and the map refcount was incremented via
> bpf_map_inc_not_zero().
>
> The existing else branch on bpf_local_storage_alloc() failure does:
>
>     bpf_selem_free(copy_selem, true);
>     atomic_sub(smap->elem_size, &newsk->sk_omem_alloc);
>     bpf_map_put(map);
>
> But the new if branch just does goto out, which only calls
> rcu_read_unlock_migrate() before returning.
>
> The comment at out: says "the caller is responsible to call
> bpf_sk_storage_free" but copy_selem was never linked to new_sk_storage
> (bpf_selem_link_storage_nolock() never ran), so bpf_sk_storage_free()
> iterating local_storage->list would not find it.
>
> This would leak copy_selem, the memory accounting, and a map reference
> once bpf_selem_link_map() can actually fail (after commit 3636ab200
> changes to rqspinlock in this series).
>

Indeed a memory leak due to missing cleanup. Will fix it in the next iterat=
ion.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/215393=
40647
>
> AI-authorship-score: low
> AI-authorship-explanation: The code follows standard kernel development p=
atterns and the commit message has technical specificity typical of experie=
nced kernel developers.
> issues-found: 1
> issue-severity-score: medium
> issue-severity-explanation: Memory leak, memory accounting leak, and map =
reference leak in socket cloning error path when bpf_selem_link_map fails a=
fter rqspinlock change.

