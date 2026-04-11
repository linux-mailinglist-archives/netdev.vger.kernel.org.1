Return-Path: <netdev+bounces-277656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG3/K3XQ2Wk/tQgAu9opvQ
	(envelope-from <netdev+bounces-277656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 06:39:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F103DE593
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 06:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15FD3302E870
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 04:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D02D8DDF;
	Sat, 11 Apr 2026 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eei+qXqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6E199EAD
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775882354; cv=pass; b=BIhOYb+Pi+giJ9SCFG3AJCitZHgWwlEbjtXx0m/NaSo1K0YUyCP7xZDz1fmdOXGAR5N4tVDlvfbVbvFkq0mI23f6Qq4ogVBVCh1/q5Z0ED4RqElsf3kcSiRUXxEX+mUoOO56+S1U6JzgdfQi8Lv1NFmLxnHHXqcaUFsRArgDGcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775882354; c=relaxed/simple;
	bh=DqAVYzg35YxGWL9WCukXnG5qvJlP1oQzSfziIeAJ21g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyU566xPHbK/NJYIsog8jY9V8BdGmCuij74gWAT/cGDUhhSphBT90gtn0Nxq43H2B2CB26DySrRr/xQ5Ch1JX2DV3gaJ4SEScHpl6qsw5VxQroL4VQh/MxlWpIr9BetWqmLpx0q4wqZ2vyyFQ0fTHEnf+HLVVGRRb6kz42ZcMPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eei+qXqV; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b00ed86fso28596725e9.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 21:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775882352; cv=none;
        d=google.com; s=arc-20240605;
        b=OiVTvyFfBDkjbg+SxBE4d3YH6InGOU4BkZCGsK4IFZJCtAyv8l7YyibsW1edFaeqDB
         7fDfzJ/AFEJ6yQe0fCbY5AUlbNrNrTTl9ppcEkpD9c83GyjDqHjq0sVtWXvhwPAEQios
         MpvGAYD5jYPvxZOFJkNfdEifuaXEJxg9qH+yPGQdCRGj+PQm7NtyYb+bCDAmmFp4ybrV
         MfAO4xA2b0hMM9kmxhyCST+zUsEwv+Crdjz/j4w3xFGeceHPWzTZ4w6jwW8Ye6qGwHU+
         y/r5YwaPlrEZzoJBhrGeV72/PzvnAX9Abu4KeR5gzwcdAGnMfvWw78rKKBxDNAy4xc5y
         BpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqAVYzg35YxGWL9WCukXnG5qvJlP1oQzSfziIeAJ21g=;
        fh=gfyRTGBYhO0HlvePjlbZ/YtXW4hQReU73KP0x+wzzHc=;
        b=QpjQsuE5aizyVhJ8r8FB9+2Icqaq4ieqxkQt4Lur9f1U27oxulIrXxQU1MJrhOtlyr
         brbdJLXYEJRJQGKKe4MCTOa1g9zd5R7ZygbeKbgBhhiVh0pb2PM0W9xq4kwCoHb4jLlt
         ifE8J/13M1Fu8Ilosy4M6f7iiBBuNLhOax45Fr/WqkHfrfiGUNxRppcTBT70ffSbdSAb
         bbCnjuKt7UbZOMaNupR6PzUpnmL6eB8VTekVVYSSwqTgascsL7sS2SryG9QWQlT+j9WS
         ezMjeFdiPf454R52170XKvnp87A46U4X73/yKuIY21+qFc4QHfdPwc+yJ/rQU4Wd/IlH
         jBQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775882352; x=1776487152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqAVYzg35YxGWL9WCukXnG5qvJlP1oQzSfziIeAJ21g=;
        b=Eei+qXqVbAfanSPq7bteu0R81lv1SPM9rJPFXo90/+dJizkT8xlmZpC0EpLT6Fslmm
         1n3eg08AlLIy4dtDQ3atH6scqPN3S0VnGO5GITf5hOwkZARDmNtbeKFctnJT0R4XzFIm
         t8zwhA1EQwZ+y5uFyH84mxPbM8+ZU6dtfh/bs0eX7YB3BYkIcRfeouQWNGJukX8Ngyuu
         OFwhOCoZiFfEWUgZPL9nn9i9vkR7aZt6a0ShinyxELZmyWDn40Pe/RdgaOknpyAUaqod
         hdycfT4oxZs1alq8BPI63k6wupWy2j2BVlEBKJ4zch0k8v6Eti/Vozqik3EDPU3ZpEMr
         +Yng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775882352; x=1776487152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DqAVYzg35YxGWL9WCukXnG5qvJlP1oQzSfziIeAJ21g=;
        b=PFcSFtVyd/lOZWr+JxawUkg4BP2JaV+NQ6G4EKINm0JSw3HIOD5SmQ5MmXVbt293ho
         reqdaz/zTWaXwwhgPnH67vethudXL4WuM8JxLuPAhyq08c9/I2QpckHlbCzwNAfRewys
         LIJz5xs5gQWyhhDeAdvajTE6T4NBChPLMT/BAPLEt6EuxUUDZU1G10ZnF4wzlqrIKHWU
         nr5cH3jT+Ed4ezDh8DnZOtoAHLJz3qUOqWrw/BD/B1qmFLKzu+f6ZV4il1l7Aa+BkUp6
         qcgRXocUT5RvYE40L1WBgP7lZxZ066BVFMDUjvXWBPuq671C1oV/phCv2etE7DAS2yXK
         VAlw==
X-Forwarded-Encrypted: i=1; AJvYcCXmEGcRxHR7an6ddQgRGC12fMEoUM7Nt/aPheECpFuCLY+HjBZNCnNrFAxy1aBuTptbgDTal4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAI6hoBgKxa3wiRAI3hoin5mIKIZGxuyP6oYcva4kfTXCp2h6m
	XrsAgSAGEqkq2j3UWtLSwBVMtDtJnC6Wlxm5uzDSKIzDza0K7Yv59OOD6x1cconXEPRt0+h1dPr
	EuMb8Nfp9gAhWWzXgH8s3CkddaLE3JzI=
X-Gm-Gg: AeBDiev+iK/7BD9yoCuz0+yMT9LZ06j8fVhuo7tOVJ9ccribZoiMDpzzRJ6re4CZ8wV
	1zSrjIfKpHWVzigHmhKvPZOmRIvVec/W65nar/bVV1UfvbgYzRhQMem1NbyYQoo12OUbH32XPxt
	bZjJ1nEdaOjdCEnoN7H8VKDu5s16Fq3oESXLPTTz0Dp0lge/2ny/Sc+ZELRVk6FcCjU9nJzPCgL
	/1S2Euflc3t6QHBfIbzy9n1OTtxkB7eTJb3W92ODD/WsRNaLhO+bri98NnipwKR6OdPFEwiIduP
	ZzyIfawsYUIVzs/LUyCnbYh3doA3Ua4baOf1abeESCi2iZm4xE03OViAMkrVa6Q5eCewGD1OM6g
	EkxEhlTN7fUghUngt0x2OgqrYgQ==
X-Received: by 2002:a05:600c:5299:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-488d6875f3emr70333425e9.22.1775882351810; Fri, 10 Apr 2026
 21:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411015419.114016-3-ameryhung@gmail.com> <efdb35c2d8151489fb031ad63ce8bd6000b8bbaa2bf5a523c927907399c93ab0@mail.kernel.org>
In-Reply-To: <efdb35c2d8151489fb031ad63ce8bd6000b8bbaa2bf5a523c927907399c93ab0@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 10 Apr 2026 21:39:00 -0700
X-Gm-Features: AQROBzCikxtCHtI5qqdK0C85R-3ghBvHgVMXauRVCn-weANy68D8fquPbHVRm5U
Message-ID: <CAADnVQKeFF--bgnZZSU12UY0muuwYA=7EdzLyOi837oZs+bXTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Use kmalloc_nolock() universally in
 local storage
To: bot+bpf-ci@kernel.org
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,meta.com,linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29F103DE593
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 7:36=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> This allows value sizes up to ~65KB. Before this patch, socket and
> inode storage used bpf_map_kzalloc() (backed by regular kmalloc)
> which could handle those large sizes. After this patch, any
> elem_size above KMALLOC_MAX_CACHE_SIZE will silently fail: the map
> creation succeeds via bpf_local_storage_map_alloc_check() but every
> element allocation returns NULL.
>
> Should BPF_LOCAL_STORAGE_MAX_VALUE_SIZE be updated to use
> KMALLOC_MAX_CACHE_SIZE instead of KMALLOC_MAX_SIZE now that all
> storage types go through kmalloc_nolock()?
>
> Slava Imameev raised the same concern for task storage in
> https://lore.kernel.org/bpf/20260410014341.47043-1-slava.imameev@crowdstr=
ike.com/

Right. Let's update it, but I don't think it's a regression.
On a loaded system kmalloc_large() rarely succeeds for order 2+.
That's why kmalloc_nolock() doesn't attempt to bridge that gap.
One or two contiguous physical pages is the best one can expect.
In early bpf days we picked KMALLOC_MAX_SIZE assuming that
it's a realistic max for kmalloc().
It turned out to be wishful thinking.
kmalloc_large concept should really be removed.
It deceives users into thinking that it's usable.

