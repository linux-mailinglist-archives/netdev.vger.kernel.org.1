Return-Path: <netdev+bounces-260598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMUNHqHanWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:06:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2CC18A4B0
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AC14315C5ED
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCDD3A9618;
	Tue, 24 Feb 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFWQhHH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AD3A9610
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952271; cv=pass; b=ZCfkOPejMWmlGHtbUN9pcO84WG+IkPGm/Nn9LoxG4fl7XkUGv4wmKsYohuadJkwhjrInbU37D7+zBYo23m4tDycFUCuQ6mD77Z/Nnd/xTBUXsfK0ByfQJfCoaFzyOs/bA9vMF3Lr5LfApvbPEkq+hPyzPyaJNJb6hwnFsb+uVF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952271; c=relaxed/simple;
	bh=LFeQAmfI2jWzGO6ITz55S3PHrzjDrm/EzGFx3B4VgN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tb1P1l8z3rqDL+I7sVSSPirmEKILSvmr8CRJM4PQOOkcKy08nac2hlx8gne2HPWL1D8OiWNE6+KCBoCe/93daM5hkuluNwQu3YHQIOj7OWHxdpWYt18p5ewIPePD9RbUTMLDYLY7jDxG7bs9rhGMnefkuiSC6I+zJwA9c71D9OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFWQhHH0; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359a16a400so5082074f8f.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:57:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771952268; cv=none;
        d=google.com; s=arc-20240605;
        b=iFF8xb3C8w+hzV57ZXvHIUAxjoya00O9BnUJ7tV1zYz5mFQtwPp+IuDfjIZWEZR79d
         1OHf7u9RV8tlMsM5mhvMuecTfkD+sB/QZpkRaBZk2zfyT72o3t/X2awucrjXwJjlqorX
         5Tp2dnGp22U0gZZOoQ8B+VBFthUl4zoE73A+3lDMTEI+pJ+W8PzUs5LMFzKQ0/rct1QS
         S8gUbLaQ1+xZiJ3CmjpYZWmYkhM2WntyDmLLeD4IIjqBlQP8+vn/igstJXgneBxL6AWT
         nlsnA/F8ddX60Hy/uFJw4ew2zjs7OP18vCVhLSaPUfTJmd3Sy/zxhPs0BQSS5HTMYeDI
         2Zjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/LZ5/ET/z0VwePFl8rmo2+n6v10vbg5EI+OLa8kbxI=;
        fh=IT+EplJ8lme9JNDpuihppNQcHiw3EviUV69F/hQBl3U=;
        b=NbyUAWZq5r6n2lEiJVFAuY8JdvcIC0H58MmyjzsnBhrjX7C+hlV3YaB6AzkfgbiR6T
         oVyh5uxRfbfjSSVC6roz3GMH3INPpksQFVdXNp07MUZFvOEtL+Wf2y8+if+mAkAzhSh9
         hSLkVJk6i1vnCaNoBUIlfN+qKK9CIDqfWah6CCKUKvlKNREMVFq/8+W73hTLJo6L61Wq
         4meobjSs04FUwGTPQHi7VhfcHdpswe2AoQzKzCXCQButUqCEEuhturdq6V5h+m9i3QTp
         3g9mqp/VeHe5Uyw/oehGAJ9J9BHeUaGcUkFV/y1drd1Azl2AeWhdPgYoQmsFndl9C+aO
         3IdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771952268; x=1772557068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/LZ5/ET/z0VwePFl8rmo2+n6v10vbg5EI+OLa8kbxI=;
        b=eFWQhHH0tXrcLKY/l/h63HjEN4E5cgnjyg/bZkhOlXYfKPyjIZkb78Oh+FyxIfkTFi
         7fCWJ9wUePTGSYEymzuljKO+kK4YZV2/G6TGaCAeribNY/zxMIMsRqnUq2830SDTHe1V
         BVw8721IvYqBpvRvCRyAENNID9X9SECoy2QUBZLvjMt3s802aD6WlAe+RAEjXlyPJyX9
         3sFlpWc177VtO6PEqk+BEXjirVByVhRu55obFAvNPJaZmchRmZ3E2MbLoPHTq5Y9TYg1
         6S8Zp7Jg5AteW2VqXdkcnkJmWLxRuHT3pxOv111WI+15N1T2GvoFUK5XUe/6G5ogzmTI
         Wu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952268; x=1772557068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/LZ5/ET/z0VwePFl8rmo2+n6v10vbg5EI+OLa8kbxI=;
        b=kr5JdQDlUPED08d4xL0RNE1W862QIuc6B0KdGOHmUuxM0U9Fu6P56xQxa/WHXzw2qa
         XHS4hJ1wOFWAqQZxBLidiNCvdnHX0zXv92bWZRhBX8TIQX31XE96F8FUdCp7bwjLU19R
         gjxqGWvoTcCnJ7W0v1t5wFki0MzxwSMUwK0kjSqJQgl0ZuOBkDAgaueHMm7ThiKR4ZpI
         Wzy7zc53NTjklbvtDBMnS7IJkpGscozt/HInZAackaZWm/VLRFOPO5QWKuy3VNfHX1EV
         Ca3Skq7aD32ynhBhkl+tdeg/0cMhWlkUTMHgsIxC6nf7zF0VRreReCd9hobpDQ/paSfx
         BNDg==
X-Forwarded-Encrypted: i=1; AJvYcCXuo7+Qr3W5ol/Eqc3uBXx0OOounVyVWPgLmbg3HKyWJYx7QTYvRabnrNg38EjyCp6sXm9G7CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhSsMnPMX581UKF0wg0LUBqW5y3rCdMkXksDejOMMXN8Ymh7EI
	/yfYJNK4jmc5nIysrtioYtJADQJToTbXd80jMnlprWLn0NGs/Y9zHAZSsbeWOIVDW0Lt8/Rc9KQ
	YM4b85kDwyETgk+aajWDwrwyhjbEzUUk=
X-Gm-Gg: ATEYQzy4eiYGa9i3dPn7no2sy4JSxVzWbX0JwmAa3sN8F353e8/8NtY2xjqfmTuerN2
	afzQma1VqQQxRRGthuXkLyy7AsgczaxJLgWJMDtEa4K+zBNiVI+DQxfiIrnH001nN1UdrnlJHCO
	IWbwsJoCLcTFcTINeSe6L1sKfhGqoGQ8IxqVhZSAmMa/50dmtta3isdVAGwI4JP3mhXkpnfdi8w
	+c440445lTCN41BoJ+rrtvoa4mZGrd7hCuCpbPvEnNqZkTDHPM2rN+SsdkBBYREv/+0gqnnYT0k
	5pJDiiBlDzSigDl2QiDaYD/phDg09ytaqCwKGg6DHKwEx0OA7YTNCWIKou7+69l0o2bOIFAwyx/
	oZslVOlNC
X-Received: by 2002:a05:6000:2407:b0:435:bd00:cb4 with SMTP id
 ffacd0b85a97d-4396f15b2a4mr21141471f8f.23.1771952267940; Tue, 24 Feb 2026
 08:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224154024.12504-1-leon.hwang@linux.dev> <20260224154024.12504-3-leon.hwang@linux.dev>
In-Reply-To: <20260224154024.12504-3-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 08:57:37 -0800
X-Gm-Features: AaiRm53rqopHuRGSK2_nQdOAXTbOuxaGhPPN68Nah4CqapKdrc7UpjUZrDEx1NA
Message-ID: <CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM3Az197eL_0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	Menglong Dong <menglong8.dong@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260598-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,kylinos.cn,huawei.com,fb.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CE2CC18A4B0
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 7:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> uprobe programs that can modify pt_regs require different runtime
> assumptions than pt_regs-read-only uprobe programs. Mixing both in
> one prog_array can make owner expectations diverge from callee behavior.
>
> Reject the combination of !kprobe_write_ctx progs with kprobe_write_ctx
> progs in __bpf_prog_map_compatible() to address the issue.
>
> Fixes: 7384893d970e ("bpf: Allow uprobe program to change context registe=
rs")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h | 7 ++++---
>  kernel/bpf/core.c   | 3 +++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b78b53198a2e..2a2f6448a5fb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -285,9 +285,10 @@ struct bpf_list_node_kern {
>   */
>  struct bpf_map_owner {
>         enum bpf_prog_type type;
> -       bool jited;
> -       bool xdp_has_frags;
> -       bool sleepable;
> +       u32 jited:1,
> +           xdp_has_frags:1,
> +           sleepable:1,
> +           kprobe_write_ctx:1;

Don't you see how much churn you're adding this way?
Every patch has to touch two lines instead of one.
Use
u32 jited:1;
u32 xdp_has_frags:1;

also the bot is correct on patch 2 and 3.
Don't be fancy. Require strict conformance both ways in *all* patches.

And your codex selftests are garbage. I don't have other words
to describe it. They are not testing the actual bug that
your patches are fixing. Think of what you're doing.
Asking LLM to write a test for your other patch is not what you
should be asking it to do. The selftest should be such that
it proves the unsafety/crash before the fix.

pw-bot: cr

