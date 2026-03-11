Return-Path: <netdev+bounces-266763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEdAFCLFsWnvFAAAu9opvQ
	(envelope-from <netdev+bounces-266763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:40:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F653269799
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 20:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AB0E3104CAE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E1344DAA;
	Wed, 11 Mar 2026 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brcFPstz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7233D6D5
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773257948; cv=pass; b=XhjJQ9eEwjlIDPZgxsJqOSwPzxd/0dQAGPE8FwwhMPXfWlH5BFlDcYniG/nDFRP3AbN7fG1fRCsw6xcLsxHZ6a77mguTzi+aPR56K+lvU5Rwebg9qIS4c9O1yQh7/L0WLxAAZ580sDgQvlIitiuALZVGGRaNYZs005RMkSR1QG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773257948; c=relaxed/simple;
	bh=mLyJKX0z0UnD26/fVrqGAyrbVvIvKVQWy3TTCO3UDic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkGWnQ9x8euoFoNTi9renk0R7jGQYc5pqK0t9K6eEBD7fYLDf7C8p9+d83cJ/vyjozd9CycxzwtFcjRG2ih+MEdwGj8BkFm/maQRAuLKf+B5FdE5qEwm0JqcYhsRC3zG5EIRYPmxP7mp80tCq3RzTXrvchHht7JIaBVD/GzzwV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brcFPstz; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8299f1ca894so148330b3a.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773257944; cv=none;
        d=google.com; s=arc-20240605;
        b=C+/xbg2Kxby0CnqwO+LgPbzJVJk/TKXGF5aZC7fQS4NrTewOQ21ibdQ58Ln5yvSrKW
         /f1M1lJiaJW1GUqyEYmQXfNBM2+5jMp1RuBWuN5Xv4cG/wuIUiA9zlV7zf2A3ESlZnx5
         WU2rW7VrIi+HV5Lg6EOJ7MjebHhRmV4qKeEx/8GNNPp+nKpH2QvWioU6WHsYSmLm5Ryn
         LzoesWNgIqbQC9hIqeA2Ur4DZKvUdZOy6i1dFCL221ZCI3qf81cAm4l6Y5esIykEP+Fd
         4x1T4XcfUqWxS1bgeKW1vSB4l3daV9r47cNTGbC0VIaxM5sFEOFJHhN7yzPnPWtDNyAN
         L/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oGo8IaRI6nSCWA6TsgbfmpupCTd4jSfs0Q7c1ociq6k=;
        fh=DXUFXJEW0WVSry5PtLxv7Ofg6GhDWpThuuv5DvT7R/0=;
        b=frFqUhLgEBWOuEqCBKKI/xZAegRC3wSyz9Z7WWGBgz09N3zPqlxnEyijNZcS18Ayc/
         yYyKxCGOhC/iTdx3dADnjUhRoyV2F2lnfHgC6IwbfdjVCh9vTlty9JqTWjoupNfSn/OR
         EMJoQELb+EquZuEM5D+wQmOoukHHCwBPh3B72fPG3svFU/6onVI0SMHgvshE56jdGK60
         C6fVlsKUxyYl4/P/jNrXWRi79xWWcJILSCh2JcMDWTzN9hycifP4C9ef1oK5AB9D3Ius
         VXIWkWKDIMpsHvNMm72SlTcwwn8DtLN03yz9KgQbeaiQ63DEV3+Ralm89Y0Ec2GcL0cO
         yv1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773257944; x=1773862744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGo8IaRI6nSCWA6TsgbfmpupCTd4jSfs0Q7c1ociq6k=;
        b=brcFPstzzD55BjbN/zufg2Xia8eWLJxvmbbkjJZMp8Kwux7f/bDarKRoS0frYjLA4G
         lsiPHCRQujuJwzni34hPQuIQmf2BXgzsBf2fRtH51/VXguUvf2Fp5h9bXEs00jqo3Bl9
         XhQyF3OusaCAJ54uEvVF9qOMvxWnZOskoJv3n2OXieQKE6OnGCay2B5t6R/IQMY7hyUe
         vmBIi1YAfeomK/x1idBZP57K+xfLZM1d0yFJeBWJHQtB/z+1rx05VOcSNtfhT6OUUaHo
         XIYEwdI+mmgrstptSDKDmVgloS8fICobrJo7L9H2XaonfrJeVmxyB9NEMQ/tK2Gj2eQQ
         Fw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773257944; x=1773862744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oGo8IaRI6nSCWA6TsgbfmpupCTd4jSfs0Q7c1ociq6k=;
        b=efA/aJmOWFC4D5wF8VqzRjiDLVzmvoTCYnJpA1Qm8YPV00SFdpvbO7Tl4xxWdD1/Nl
         OtaAP/MYqwaY5K1XRMoBHnxsEYFDoixXhUonrcbYvRVjJkMy65f/TEad1gEFUomD1VmQ
         wP4Mwvd0QgiHScfD1shgvc4N2B37bdzrgymSIKokSL5H3T2tEZAUKmkoHwdAvO/D/5El
         fMiT8rScYCazHmA3ORboma3xx8w/WaB6/ypOZ1slsbWb5Qn9MDMpFCSy4HdTQs+o1AiA
         CDMzbrneX9uiRrMM352REDyrkmDr942vtqyqVqk5+r+OM8KDDVfV1A8HOVdJ1NARY0EV
         UHCw==
X-Forwarded-Encrypted: i=1; AJvYcCWGam0Pi2++VbC/konARYr/BREnMuyYINWd8acPfYMGmGDSQ7Ekfs0O5FeStbr7y4qOCgJFYek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwYbVugnc/FkgO3+QGhuYfaU68a+Ziy5nbvzUJFYDIjT8nUeQy
	OlRm9LonJxiacj9enztIFqAIxV+NedSzwJin2HVOt5nor4Esi1sVi6BOnhduhwooAjQ0B7bKbLY
	cDYbfgg3hxxI6tu7hHoRP3EMvCFw1n88zyg==
X-Gm-Gg: ATEYQzzuEd6ygWWQQ7xK8kr6CpDNJ1UoSkRC9W/tNfSrG1hFuC5I3rkpxF2dLlk0XE2
	pMdhsQY4su0ity8NkmhK4w8yd9oTfIm+ROfoIOlY04N0ufG/gqY6liZX0YoMI/kBHo7+nchiy7i
	i//sleuMwtQPKd3vBfZRuNpGz/iY4Ytd8PIpBos5onojoAtAoA0FoR2UyLX6QBlOnzN2EXxCrdT
	oQAiqJh3WSyXFhIQuc0JcYcL6juY0QBL30YSEnuatGc8Aw6ac5rPwv7/1Z0TycQQJ7mdbU/38ev
	t3L7Quo=
X-Received: by 2002:a05:6a00:3ccf:b0:829:8b1f:a3e1 with SMTP id
 d2e1a72fcca58-829f711ff45mr3517560b3a.63.1773257944550; Wed, 11 Mar 2026
 12:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 12:38:51 -0700
X-Gm-Features: AaiRm51lohapAmPtjK0MnVRFvwqN3yzgXqYTsFTHxMmpnr58SiY3v0-8oHya_NA
Message-ID: <CAEf4BzZab92hO9ERcfkkg2OHab9F4M9fmwc8yudDu7kjp_qu+A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 00/11] Dynptr cleanup and bugfixes
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266763-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F653269799
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> This patchset (1) cleans up dynptr handling (2) refactors object parent-
> child relationship tracking to make it more precise and (3) fixes dynptr
> UAF bug due to a missing link between dynptr and the parent referenced
> object in the verifier.
>
> This patchset will make dynptr tracks its parent object. In bpf qdisc
> programs, an skb may be freed through kfuncs. However, since dynptr
> currently does not track the parent referenced object (e.g., skb), the
> verifier will not invalidate the dynptr after the skb is freed,
> resulting in use-after-free. The similar issue also affects file dynptr.
> To solve the issue, we need to track the parent skb in the derived
> dynptr and slices.
>
> However, we need to refactor the verifier's object tracking mechanism
> first because id and ref_obj_id cannot easily express more than simple
> object relationship. To illustrate this, we use an example as shown in
> the figure below.
>
> Before: object (id,ref_obj_id,dynptr_id)
>   id         =3D id of the object (used for nullness tracking)
>   ref_obj_id =3D id of the underlying referenced object (used for lifetim=
e
>                tracking)
>   dynptr_id  =3D id of the parent dynptr of the slice (used for tracking
>                parent dynptr, only for PTR_TO_MEM)
>
>                       skb (0,1,0)
>                              ^ (try to link dynptr to parent ref_obj_id)
>                              +-------------------------------+
>                              |           bpf_dynptr_clone    |
>                  dynptr A (2,1,0)                dynptr C (4,1,0)
>                            ^                               ^
>         bpf_dynptr_slice   |                               |
>                            |                               |
>               slice B (3,1,2)                 slice D (5,1,4)
>                          ^
>     bpf_dynptr_from_mem  |
>     (NOT allowed yet)    |
>              dynptr E (6,1,0)

Ugh... This cover letter is... intimidating. It's good to have all
this information, but for someone who didn't whiteboard this with you,
I think it's a bit too hard and overwhelming to comprehend. You are
also intermingling both problem statements and possible/actual
solution (and problems with earlier possible solutions) all in the
same go.

May I suggest a bit of restructuring? This diagram you have here is a
great start. I'd use it to "set the scene" and explain an example we
are going to look at first. (Keep all the IDs, but mention that they
will be more relevant a bit later and reader shouldn't concentrate on
them just yet), and just explain that in BPF we have this potential
hierarchy of interdependent things that have related lifetimes. When
skb is released, all dynptrs and slices derived from those should be
released. But also mention that it can't be all-or-nothing, in the
sense that if dynptr A is "released", skb and dynptr C should still be
valid.

And it's currently not the case. That's the problem we are trying to
solve. At this point you might use those IDs to explain why we can't
solve the release problems with the way we use id and ref_obj_id.

Then explain the idea of parent_id and how it fixes this hierarchy
reconstruction problem.

But then, mention that socket casting problem which introduces shared
lifetime while objects are actually semi-independent (from verifier
POV) due to independent NULL-ness. Which makes parent_id not enough
and we still need ref_obj_id (maybe we should rename it to
lifetime_id, don't know).

In short, I think there is a clear logical story here, but your cover
letter hides it a bit behind the wall of dense text, which is hard to
get through initially.

>
> Lets first try to fix the bug by letting dynptr track the parent skb
> using ref_obj_id and propagating the ref_obj_id to slices so that when
> the skb goes away the derived dynptrs and slices will also be
> invalidated. However, if dynptr A is destroyed by overwriting the stack
> slot, release_reference(ref_obj_id=3D1) would be called and all nodes wil=
l
> be invaldiated. The correct handling should leave skb, dynptr C, and
> slice D intact since non-referenced dynptr clone's lifetime does not
> need to tie to the original dynptr. This is not a problem before since
> dynptr created from skb has ref_obj_id =3D 0. In the future if we start
> allowing creating dynptr from slice, the current design also cannot
> correctly handle the removal of dynptr E. All objects will be
> incorrectly invalidated instead of only invalidating childrens of
> dynptr E. While it is possible to solve the issue by adding more
> specialized handling in the dynptr paths [0], it creates more complexity.
>

[...]

