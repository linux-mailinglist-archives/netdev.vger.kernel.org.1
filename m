Return-Path: <netdev+bounces-252624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AhnOsbmcmmErAAAu9opvQ
	(envelope-from <netdev+bounces-252624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:11:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B2D6FEDA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A5AF3006986
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86603559CD;
	Fri, 23 Jan 2026 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrmStthW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5AD369204
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137842; cv=pass; b=ffKW6+hJeyM3dDRHcuRfcSODi9Ba6mOvyjoaHuCNz3Cdrz4XeZzlOPeAfsTEDXaNAn/nm9lpPShZVQgluvs6sLFqdxP99qV+35bmzMdxid/RqbgSUwsQAM+RjRuE9SzfFTEf7ATB4HJs5JtIaBoPZuxx8AasZ5Tl/8VBMWqT+EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137842; c=relaxed/simple;
	bh=26QD3iTEBUcMQlUM4uGsxaAqXs+lqxOOleJfn0vUbw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqX4dXVETd5SJvV5JPJbqEig/BEU1NIpmTprOy7utHb42H0WHDjgRw6zcFpH4bQbDv1fk9+FcYY60DANl2JZQWeqnHKo2j9Uiy3E8O8X6y0NV8sonBflKG4nX+WJim81nEKEsV2GXsMRsLif2g2gqlNiGman6QqOmfEGR+mC+/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrmStthW; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6467b7c3853so1428916d50.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:10:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769137824; cv=none;
        d=google.com; s=arc-20240605;
        b=fyMdrgJWqCpoBt78jMDK/G6G1Gi3LSX61vIVQ6D33MSfgqtR7VBEtu39Qvokz7MUAX
         rbuibDWKhmOzcJV26B9QeYjEIWTC9TW/TcO01QrNkINL52sGkKcSZpGD026Y5bJVhcyx
         1TOYnqp3s26qTYQUGEQNn6Cbm76B7NGl4jFOLx6rYOOnOf9bQ4MmQTTx5Tho0ceNHvW+
         HqEWpPHV3Xpk23yElI5VDJSRL5NreDWRvINhrb5+4/Nh7zmYnhI+ojIal2TZTnd1EVe7
         Y7CzHVsvKV1GTWcQcLHwNvIt5Oap8UMydqgnSok5f+iCkHpY50jf8VshzpAvMnZOS2fG
         v/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bX1eLwl5u7TS2HDINLkaf1NGNyaQKDoaIks4eZ+myeo=;
        fh=BGLd3oZvFRGZS9MnxucjGm0GKLUtfoWHlnKV0Nsk3Yc=;
        b=XK9jwpjqeWrr1PSjw2hiA4QP4blpSrF0yi+LqZHqmGq1HuP10PRWSKqlPJ/xf7R1xC
         fOGyQNLPl4EAHDbrPZk+xn+/TQqCfSqNrOPJ3qroPnAHXtimMwM0PJnVDvP6h4rnBcX8
         SAyYbbMzBU9qMmSvLYQUUkjzH9Tl+ygbRKb+Ue5yhV5jkceNzB/azzrr+dCA8UFkNIyw
         mxM/YkWkBDn2VkKanv2pHGTVhbySV0ee2C4OLgmoxC60WHgygqeYnTELEyv1hlH6q+J7
         /RmBgoUJ0drHRO9gzT3ykV8TZOj8m7PkqBCoK0DvSskJRBbahsmGpGxMtgzMq7DeWCXG
         Iyig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769137824; x=1769742624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bX1eLwl5u7TS2HDINLkaf1NGNyaQKDoaIks4eZ+myeo=;
        b=WrmStthWThcsnnFzlJFa/ZybjEF5RrnBtgrJrCnOa2BLKM41/BixiSic4iohwaxsty
         2s0u0fbQbPimECkEHXpFHfN6PDoMBpc9s5E7RQoIlbn+5NdDlIUBWTmPWhshTEQVuJBP
         Lx5/YOk7oBF3x+YLhZVtjP2bp92KulL9khE/AJzaOAg50gdlacfUT1ytt4fPmSfwR4ov
         B1Gmn3/PiElBvHwHB6SKJoFvCjFvndr9Lw7bT6sA9jyKBZ7pvGUmxgBCv+lvZjK8RWAY
         CbHxODaI4yZ77ZcI6Iy9JTbrppkrmNqVIKmKkyZH0xC3tmYHddGTaQXAmWxxIbEnc5xL
         fIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137824; x=1769742624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bX1eLwl5u7TS2HDINLkaf1NGNyaQKDoaIks4eZ+myeo=;
        b=iivJdlRN8j/3H4plgPQv3lEVCrTIvXoID5G/B37oAB4Vvjpt7o7PYNiF7hWwV+bqFg
         CXLHqNwHjHkFi8YTEbdbW8k2hkZHDLxwdJPUOyS5SBYBnw7cFraj915VLTak7MMUF4Mc
         PJlWYBqTGp1EGR72TUUKbKkiI+bpE+N7+HmnjUOL/QnwqmcutCFpfbcOBfGDqO/yXVd4
         d27svow7v3aFg8rBBRsqidnEE1OZ5im/DtETIufNwr2fUyBbNQmk0z/SbeZ5+q/q/J2b
         ZinJ5iEZzgViOUlLQc0STHM69E5L433pq2rDZ9U0QWuKapXsoNww8fBuc/+VpvR6/T5A
         Sriw==
X-Forwarded-Encrypted: i=1; AJvYcCVTpmLo/22IoKSEHekHjhkkUPY4XW2gu2OJrDeFcwcCRJAIrEmTIiTtsMqyBiV9oyzt2lQqHHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL27wlNAgJtQuIJYEeFfUK2gscUyHPKm4O1q7Ncwb7uP8ECJB4
	WZvBeBqQHiGyAUYw8g++NU0fOJZEAE/L3MEEReIP7zwE6gioBCeXQ1Kyja56fERI3wbslmqNtGG
	PJUC5m0WMjhfdoyC6RRm5F1AhGAlWRnk=
X-Gm-Gg: AZuq6aIdI45+NA3vQMlIopKzyDkShPZR091S3Zwb385hWFSjX1RCGaR0ynmrd1Zuu3U
	RlDot8Q2rBnnQqocWYfOy1USQRrqcMU6znWdUNdi16tbYUNhJF93168YXMnxepyyosXhwEdUZbP
	6bAue8i7jLLTPJ8lF13zMcETqiWniv7fqR6b84wFZAmb84+PB+nlTY4419TfyZ0xPBLrm+Exdgk
	XFrvXFewKpP5qnBcwP1YCPxd8vGG9UDs4bKGjXf1sIJ0FgAwj5MdQwmYdILKCNpZcMovfE=
X-Received: by 2002:a05:690e:4104:b0:644:78ac:4b18 with SMTP id
 956f58d0204a3-6495bee629emr1188670d50.9.1769137824172; Thu, 22 Jan 2026
 19:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 22 Jan 2026 19:10:13 -0800
X-Gm-Features: AZwV_Qh9PgdUM-Ak3f4CvTCtCy-8sG_yS3plcc5xh6mUH9ThYE24CxevaPzQTFQ
Message-ID: <CAMB2axNQxpJUiz7uE+pAV8uV0fye36OyAJ4qQqO-4Pdkb61=0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Switch from kfuncs to direct helper calls in prologue/epilogue
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	netdev@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252624-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,cloudflare.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E1B2D6FEDA
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 11:53=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>
> This series enables direct helper calls using BPF_EMIT_CALL from prologue
> and epilogue code generated by verifier ops. The goal is to simplify the
> calling convention and remove kfunc support from prologue/epilogue, as
> suggested by Alexei [1].
>
> Patch 1 adds the infrastructure to mark direct helper calls as finalized
> (already resolved) so the verifier skips the imm fixup.
>
> Patch 2 converts bpf_qdisc to use BPF_EMIT_CALL instead of BPF_CALL_KFUNC
> for the init prologue and reset/destroy epilogue helpers.
>
> Patch 3 removes the now-unused kfunc support code from prologue/epilogue
> handling in the verifier.
>
> Patch 4 removes the corresponding selftests that exercised kfuncs in
> prologue/epilogue.
>

Thanks for converting bpf qdisc to using BPF_EMIT_CALL. The patchset
looks good to me.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> [1] https://lore.kernel.org/bpf/CAADnVQJ=3DkmVAZsgkG9P2nEBTUG3E4PrDG=3DYz=
8tfeFysH4ZBqVw@mail.gmail.com/
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Jakub Sitnicki (4):
>       bpf, verifier: Support direct helper calls from prologue/epilogue
>       bpf: net_sched: Use direct helper calls instead of kfuncs in pro/ep=
ilogue
>       bpf: Remove kfunc support in prologue and epilogue
>       selftests/bpf: Remove tests for prologue/epilogue with kfuncs
>
>  include/linux/bpf_verifier.h                       |  1 +
>  kernel/bpf/verifier.c                              | 47 +++++------
>  net/core/filter.c                                  |  3 +-
>  net/sched/bpf_qdisc.c                              | 76 ++++++++--------=
--
>  .../selftests/bpf/prog_tests/pro_epilogue.c        |  2 -
>  .../selftests/bpf/progs/pro_epilogue_with_kfunc.c  | 88 ----------------=
-----
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 92 ----------------=
------
>  7 files changed, 61 insertions(+), 248 deletions(-)
>

