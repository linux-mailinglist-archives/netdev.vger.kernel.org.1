Return-Path: <netdev+bounces-278292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCrQFt/S3WkqjwkAu9opvQ
	(envelope-from <netdev+bounces-278292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:38:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1813F5C29
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C00C3022F9C
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 05:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E719303A07;
	Tue, 14 Apr 2026 05:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EECnFpuC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F995279DAD
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776145100; cv=pass; b=nQ1F4YLRdhewj8VHZNlPp2wxwcKHOkdJDs9i67FRe8qoMhyhFP0tUEANE7tgL32vQRlqGtV2+pBf+h56Me6CHT0qi+cKEV/s2vGx/Q6+ISSsYJAaOHckuDpn3Z7lENINkJXnSCm1zBXu3wZGMr/8wttl1M4B9NGgNIRStRJfvfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776145100; c=relaxed/simple;
	bh=SEgP0fceE86DFC9oMMpK1J7dvL8jcergkUr0WSq3DWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaGekYVDMMkvDDe3ETibnTFA16aoG4qEPmhvjnUPFNQwBX2Ww96lTPcNtHopAlIVya6ze0o8xcCwEg0nlFz69CurBCAxas8+uqq4ap2ICgp31OZttO0PKnMZFJKEPjHUEb7wQdHIt5aPJa8b+gpTSZoOac8VFdhhIY66wMGVaA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EECnFpuC; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732165d1eso15402760c88.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 22:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776145097; cv=none;
        d=google.com; s=arc-20240605;
        b=AqRpt4tuFirf9f/L1DMwWx9wNXx0qmH6l1mnW3/jBNomlTcQZvpeUJwaPy0yLA5HmF
         d1ZWzEveTPwFLvdDLQ/zssDkcD6GIGe73qn7H9P4fYKck/toX+NlzCQ0CiNNPfez/0za
         IRiTHftV0Q2B1/il+QzMVetALkGA0Lxtx5bts3ZcNLdiT6a6mY1Ezwp8OYbi3p+6abFX
         8bgEaBJxrUsapcWMciTsxRJVSQmc3KJZZiTWVKcMijUW61+v1bZs021FdXL3NMm1pZcz
         4W3meBAgMbvCd41mxh34EZxv5IDU6cOg56zWbM5P3flY+cnhBOLOXTXkcrsCP4Ey2ISq
         t5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXWo2P9ezVXwa5LmBlwuFL6gAkMCnXORmCYFdzrnPqA=;
        fh=APTv+NnghxbF/Ency2ZFXk9PKE651yw+Wi94ZaZk/tU=;
        b=aPDokMrsrZrKsCIpVWWz+sGVbJ5/J4E8FRIk8jwSmsaG6G0Hy4DZa7c5uHhgZzHr+R
         mPt0Q4H46U/txYpIClsQWlAUuTHhJigbKxn85w2VfCF5LZLOWwZe0jggMmDsqXB1fS/O
         CLZfqjn98T6q3SIGh8cy74QwwZj0DlaLTXKlqiy4SHwKoq6gBm2Bg4scIupSuuvMhmtx
         Moj+zvLpevmV+/CSzcRQ57+TMYpf42U2tuPw5VVnAmZZxUZtcq2a0GBZB+ObPC/Vug8H
         sULXLvn0krNIvuR1J81IGuy9HGH3yB4JEXR0h+HB/rLh0ctC3I8+NwA3lfYuYGlRdInl
         IOKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776145097; x=1776749897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXWo2P9ezVXwa5LmBlwuFL6gAkMCnXORmCYFdzrnPqA=;
        b=EECnFpuCM4sgtbnXwfpLTi7lZFQBehnXL2My/7EJ6oh4vIv7pelG9p8n1jjmGg0LU9
         yR+vkNnlH0mnwYQXrptgOdslKht1B8W4h8rC9crgoGQ2lsVapIAVAg5IhIx9WluIAXB/
         Wihjp8vx8xE9n3FDoS+jD+fuSEvgHdXR9dZ6DqVLRob+usgi0IeuHLh3vM0KTHdKuE67
         Lu8BCYLVMggEob0L0xhlxsC4Fhsqa9jLP+Vbq+88jNP4b5Qwq6ctx4Rab4eBLwOjQJ4R
         9ttVldDmEjppu9mUwWWV6NijcwI52gYLS/4ifUX7SmBmwCClfSAVBmNlO2xE1W7FZDM6
         TK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776145097; x=1776749897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXWo2P9ezVXwa5LmBlwuFL6gAkMCnXORmCYFdzrnPqA=;
        b=FSMMia9i8JAj7OuuroKjErOWviVi1Xk4ODSLzyXQRFo/lSqPmMsiojg831wBLLMnFq
         K0YPOkkhKEc2V4ul8z8agOzYSyS1OuSeWoTfFxI22IiNQHHipEcHf5Tstx0UMd59mpmj
         wLPYONN8GSaQp8Ch5T61OQNhDdSTNAyfWblersum6//uoKEZZvSqICxxFRBK3JbCVsxa
         q+kFBV1zG8KUeIA/jA5vRL6DEdCAPUYZVuh72jdMCkzlosiRHzLpVEMoDMr7SAvOY1vT
         XGuYeTu/+JqTE5NRV+b/5xfX6lIwPLktfd+z4EZIqgbvpN6a5fYyBWPEySJk8PnVj7fR
         7GmA==
X-Gm-Message-State: AOJu0YwHtk0uTFACZcznZKhZebnyVzNZcSWnLTgURxO3+r+jjyjIOvs8
	r+VQr2btvLhN/wmdC4Wmbzrhp3qjAT0ZS8zi5fMhQjbRKzHcGPX/eFu0OH7OLbdrksWC1xVU3o6
	xjxSlrewR36Vdn8bgboIIn44LjkavrPTvdhbyGAEp
X-Gm-Gg: AeBDievDW4CdDuEMwK6BpUcTekv8U6z5iylxoI8l36JhbzVPihI+DF767GsZOBT78Gb
	Z/LJnbDV9nwPi2UaTTjm0g1dizPNi0DpK0cASio7XGEeir1Sx3VUJI3AmDvyVMtCI/Wbm9pqHyD
	AnxOlv3cy5kifUop/y8xOnsLac+dG5lNglLP1ZnXYD1UK0aAyXOuIYuF8CslEstudWp1cWXTbxk
	6S3OjfBgzTW6ffbrVpjxzRoxPiLI+bRDhhjpRIWOZZQGR4sXUpzBhYv5MVdOFKYCBV5WboKJ0zS
	+6owP8hRr+PzQXbUGrrHNLi/GgqaR9PMPkSnmxrwYCueKuRLJwyYNGYXuMe4HHneyWUD8Ih1boa
	7Nmm0tc9d3dohxmFRMC7piCSEQIxnDfZFOrR4Wn9KwYMGmYdbESmk4V5vmHND6qqejHg//fYsOQ
	==
X-Received: by 2002:a05:7022:5f0b:b0:12c:4931:c2c1 with SMTP id
 a92af1059eb24-12c4931c48fmr3119961c88.17.1776145096772; Mon, 13 Apr 2026
 22:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411013211.225834-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260411013211.225834-1-jiayuan.chen@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 13 Apr 2026 22:38:05 -0700
X-Gm-Features: AQROBzC27SzddYjwc9fK9yY-9esB3ZsjrFKLPKh5IEaWO3wNOlhHf7godPh6RSE
Message-ID: <CAAVpQUBWSHG77Az0uXODq50q9Ys7H8a+v8qkSBG-PLqBUx68qw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] net: add missing syncookie statistics for
 BPF custom syncookies
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278292-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: AF1813F5C29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 6:32=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> 1. Replace IS_ENABLED(CONFIG_BPF) with CONFIG_BPF_SYSCALL for
>    cookie_bpf_ok() and cookie_bpf_check(). CONFIG_BPF is selected by
>    CONFIG_NET unconditionally, so IS_ENABLED(CONFIG_BPF) is always
>    true and provides no real guard. CONFIG_BPF_SYSCALL is the correct
>    config for BPF program functionality.
>
> 2. Remove the CONFIG_BPF_SYSCALL guard around struct bpf_tcp_req_attrs.
>    This struct is referenced by bpf_sk_assign_tcp_reqsk() in
>    net/core/filter.c which is compiled unconditionally, so wrapping
>    the definition in a config guard could cause build failures when
>    CONFIG_BPF_SYSCALL=3Dn.
>
> 3. Fix mismatched declaration of cookie_bpf_check() between the
>    CONFIG_BPF_SYSCALL and stub paths: the real definition takes
>    'struct net *net' but the declaration in the header did not.
>    Add the net parameter to the declaration and all call sites.
>
> 4. Add missing LINUX_MIB_SYNCOOKIESRECV and LINUX_MIB_SYNCOOKIESFAILED
>    statistics in cookie_bpf_check(), so that BPF custom syncookie
>    validation is accounted for in SNMP counters just like the
>    non-BPF path.
>
> Compile-tested with CONFIG_BPF_SYSCALL=3Dy and CONFIG_BPF_SYSCALL
> not set.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

