Return-Path: <netdev+bounces-255686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDHdDenhf2mzzQIAu9opvQ
	(envelope-from <netdev+bounces-255686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 00:29:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BDC788B
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 00:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F30483004F6E
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 23:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B462E975E;
	Sun,  1 Feb 2026 23:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrYtnijW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD02D8DD6
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769988581; cv=pass; b=ifXKkLki2SFw84e57BdpYuH70vVWrXInZ31pG67HJTNfJcwFr5cEy6AQif0V8wtH2jdvg0S51/1aYeKuKOjR3wPTmJfhH+pu3cQgVUTCQclhlz59LdkPqDnaGQ2nhcNrxigvdVbN/YJDiA4Xg7sQn1N98kRHHg2fTmVJJt6uqN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769988581; c=relaxed/simple;
	bh=e8ReX8e88Ag4Qzd4SHgnsQJCxLwBL5X//YElMuIDLU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbErGzZDhLjzpbwtqHUmM3nIMow+y05p2ymF4r2VF7/XrELAKGSG3R/O8v9vmsABuL9F5BRTHINlJGU0rC0s2dA6iyoBlFHuDbEJnI3zSGQIqcKMgLmhVURqDGolt9m8THtCYsE8LiK95la0v5v+gpYQMu/+x4nmAqMYJ5MjNhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrYtnijW; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so29498865e9.0
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 15:29:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769988578; cv=none;
        d=google.com; s=arc-20240605;
        b=e3pv8xywpnMrboJ6YB3Zu1KYDqSXDI7MCgIpVyc0uZtGnOOhCqYZgYyFNxLMq1IYoA
         VJFwOycL7nkjMVw7E+2iy+Eda8EtAmF0Q3FyY2MqlD7OrXccQspI8Qsdt3q5FS+S2Ouq
         4mdAN3IlYlVWyH8Bs4S1oTDYl5nzwp0hBjkhaGqDdyxWP7q1bxmoXqxavY193KvTOb01
         1i1ac28S4ItkCSJZvyOiY/mxOxX6u4NSPPqzw926aLnXU8HW6SR6WR+GEUnscXkoSE1A
         HjGMGFK5kgzvCe4Xz7wbu4BSED5YtGcywaFGWPzQxh2oaziZ8pEgRPdktMBreAWDR5gt
         +Vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e8ReX8e88Ag4Qzd4SHgnsQJCxLwBL5X//YElMuIDLU4=;
        fh=PwGJSLOvMpGzT2VDU1eOP9PA+a6/y3idZzuUhQdeROk=;
        b=isoVjjWI8VjmVWmG4Buw5QQ00TSaJDre3R6MqhwKQL6mSTKLe6mO0A1e1RKnrQpsaf
         4xg4XZ/b9bjIr/1/QPa3uvVhwhtLnKP2KaTCycALSuTSUs2WojMVBGSTxaw9T+SKu2b6
         kFIW79PKZ5rlwuq9gl1jx8E6nJnYFX07cXJ7uSP1bS9cHx/zOnOQ0uxO59JNJL0r0BVs
         u6zH1pd+AndkPpMZVia5nOXZt96FCWVnpM6KMJTjwh3oRJXWBTvGhgdFAovJ8LP1PfZL
         HIntLeHgSEh5rN9k6oaZsnYfP/li3FQkNjK4fshL8gk5ePmeSDW0ZGpfNYFwuPKH5nvL
         Jp8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769988578; x=1770593378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8ReX8e88Ag4Qzd4SHgnsQJCxLwBL5X//YElMuIDLU4=;
        b=mrYtnijWNKGXC/0CzSclTmWu8AKqhk/7o1qqjgEu37pch/cjpourDfO4XbMaMMllpq
         otzmNiT5g1SXQo/Q3aMYBIaDevNPTU5fVyxUvk5MSWDGDdR0zUrZmX7Sx3F2lmpObEX6
         ZhRscv0/WDx1YteVSCAW+cXwxQnVA7hCMwb8nL9d/bA3V+MFukyeIBs+UiXTvMDFvXpV
         4BS0tOznSz9pY8BC7AYtITEZV05rN3Cg2RpPrgyxM/L6YsDy6fWKLVO4aBoizADteqKE
         ku7kMPC0O/ZxPasY9aEmSJVGCsqb3jU24KrRNs7PQpCAUaeg0yrBDxxqUvOP1zyEE3MR
         18jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769988578; x=1770593378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8ReX8e88Ag4Qzd4SHgnsQJCxLwBL5X//YElMuIDLU4=;
        b=s5z1Hd8yVOwOHGyIjf8+lt9fy8trx1tqsUSM4soWpBzrsdeumXI23E1J5JdaQATS3b
         hqskN/ean81ABix3EOUWhcdW/dOxYgL63Hdtzmi6n4tPIWRiMBxcizBioivUElvXfEu+
         o+Tf1YSMWEcMoe2R3ZccAuvz4ECEWifEI2Zl+9vTW9IEScs6tF6ZcA5ZNjyzI/zQid4E
         BmMCB0wlCxEuiH6CtNmx/9rfkeE/ZevsSJRVXHWkWg8fGOwaU9lbsQVOdR1DjR3+MFAA
         Efl99pjdcQrFyF32YCmh5FsBldmaFiwjwOhix4Nqa+N1WCd1dLoXgDveBU0JjdiKwiWT
         WuJA==
X-Forwarded-Encrypted: i=1; AJvYcCVVduVoU35U/w8gZBWVkXDPlfZsNG1W9Z+xXV3FfnjRMqC5o+km8Jtmy/OxbyDozOj2pAR2+h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTyp+MnneBTP708/aEnZvBEdWZuNjDFGsx1BqldlA4l3ivo3W
	VV1Z3g9oewLlfOHbbCgWpRFk6ALJdtnZ2HWtBUddBQrWfc3i7vZ3exkOuAqiNNi+bQIVKzoDZss
	Y8ennN601cLR3m6g2azmN4OsbbxI2cFc=
X-Gm-Gg: AZuq6aJx4Lxv70uhxWtscNLtDmFw25I9In9lHak19y71AQC4YgGkI10IcroCYEWsCsy
	nyhmORbjhtmH0C4OeMDrvyrlWi1+7lpP7wLLwsRb1LFK0Dqr3BPIZ6ZPeyXJoewjW3w37i8nDSq
	j3GLzoCM8SvW5XCU8VvuORef8TnPu2mii9Cdo42BfVtma8C2IGv0M+eFln5uP74Xeg8jaGbx/4U
	FoDe6nq2s5i4/gnIWmvzZ/dDOjaR6R0Jk2n6GOwv/Op5SmOQq17NZi/Z7yIEvCmrRzMCJotSxap
	mYrW95XItFEgF2jjrhdxi1VxbBSEmaJafGvvfoHaiguoaoDwJztxIuwC3179qWztX8tIE2vn0Te
	dAKExjeHwM6kEVw==
X-Received: by 2002:a05:600c:3b23:b0:47a:8cce:2940 with SMTP id
 5b1f17b1804b1-482db49ff27mr126833365e9.14.1769988577771; Sun, 01 Feb 2026
 15:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201175050.468601-1-ameryhung@gmail.com>
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 1 Feb 2026 15:29:26 -0800
X-Gm-Features: AZwV_QgigZDNlyNlUEuotYwPWIfWCOvZzkooPWr-8YPomJXC71WGcJvjLP8f1xM
Message-ID: <CAADnVQKxcbWB03cu7j0RC6-iR1gT=m6n8ZgqDpoQXW0MB+eqUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/16] Remove task and cgroup local storage
 percpu counters
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255686-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 897BDC788B
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 9:50=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> To remove the percpu counter without introducing deadlock,
> bpf_local_storage is refactored by changing the locks from raw_spin_lock
> to rqspinlock, which prevents deadlock with deadlock detection and a
> timeout mechanism.
>
> The refactor basically repalces the locks with rqspinlock and propagates
> errors returned by the locking function to BPF helpers or syscalls.
> bpf_selem_unlink_nofail() is introduced to handle rqspinlock errors
> in two lock acquiring functions that cannot fail,
> bpf_local_storage_destroy() and bpf_local_storage_map_free()
> (i.e., local storage is being freed by the subsystem or the map is
> being freed). The high level idea is to refcounting selem when any locks
> cannot be acquired. Additional care is needed to make sure special fields
> are freed and owner memory are uncharged safely and correctly.

for the set:

Acked-by: Alexei Starovoitov <ast@kernel.org>

Martin,
pls do another pass and apply if it looks good.

