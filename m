Return-Path: <netdev+bounces-293288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFXaARkmGmqJ1wgAu9opvQ
	(envelope-from <netdev+bounces-293288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 01:49:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E61609F56
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 01:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B03D30D5759
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680733B9DB6;
	Fri, 29 May 2026 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLJ5ZqyL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA935E1D5
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098192; cv=pass; b=N9DZxmnilUjvqd6SYHUG1XOa0nOVx38lWCEd3mrnQqta19NQjaZfwI70SLiczzJfLJ+XuVj6ugzA3xk9t+tOr9Erg4+EzHq3CDthlzEquAqL+D20UJQiQuJR6ghnGw/baNfEWU6xjRJoQ2hLpg2xgN5UB997tZFHGg4REMmCDWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098192; c=relaxed/simple;
	bh=s24YjcNDlm5RkCq/PpxAqixsoAF1LSfQA7DLLpd5Rvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hZawBL0tpYoGo9PSnKVZnJ63smN+oDVpC6bTOW0pDnFi87T15w/rAdLPVPm6E26xYm4u8gjcRiZKd1YIEhJ4hWTng4kjZ5tEbv+ACEACz9IoqQMAVy0n0E1DnzzA6d6YXt/Q4bjaIcMvg6Pd2/5UteisdNO3oDjTQ4CExqudEd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLJ5ZqyL; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-516d78ba1adso6141cf.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 16:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780098190; cv=none;
        d=google.com; s=arc-20240605;
        b=I2DwRhzYQb1KSaW3cuR4n/qcNWCdYtvbhBMEj6M8S0CpKUhr7WUCI16e5vwiW1CN1z
         hLrlJcAc9QrmdjRlLNPmKygnwJtqkZ4cZ3eAsSCYLZkKwnMqvddFQxK5DlXxQabIvc3E
         uNrQu89qX2rc13mkxsjfA1CGPpMihDky+e544kEfWIPWxKbakvl6DwO/TT3CkmuF65i7
         yKWo+TGVysbXIUBDF7TxkUO2aSh7UfcRvherL1nROfTsAMX4wEdrRn9dLesPl+x2HJwV
         rS9m2d8rtN0Ml6FrZrdQOGaYXsf0DIrlesU50fGqM/uCBYNdjm9HB82rJr9ZvWUaTKlZ
         byVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tKzq7IfcEZUd3hgNxILmg8jMvNqPdQHBBOhGY2G7POA=;
        fh=sxZIH0hqH3wdlQQAanWL2P5+rIXt15wM6058eWQITmc=;
        b=i0OrosSYN+4itgpIjWtijD8Brf1FJay6k92KVemGNDs6brhKVARfGiSTIcZMR8rEyF
         +oEbbyTXr/V80lLyBaeh3mGSH1gtMjzJTQGkUQ6BfrKvxjyMWjnUQuoJRGA1K1c/zcMK
         gw0Hve+N4/7w3r89ELoCAF2LO6t9uQXdoFmG8ZKZvM4qOo+MZ9VVURAgclqPoG4piUF3
         1vr1mjwXUBOL1LvTiaSIm5g/dzLQWp/kJ3yxa8LdZPggwUkiln957helePM99+zlNgP8
         bKmfWAWyjS+5XFdNMYI16q8dOwcXvsxBKFBaigbrJTnW9LzRmL2zhjBOBNqRFl/vnNWw
         wc8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780098190; x=1780702990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKzq7IfcEZUd3hgNxILmg8jMvNqPdQHBBOhGY2G7POA=;
        b=sLJ5ZqyLgFGzRytaxjXwrF5SYHqWFCPB2mwACUvWOzeMFUEFPCkNjiJ+TgVHLhJ4jI
         3b4M4aN3SA+ZdQWcu95JNMjfaODQ4pJnAMnIeyW9/IIdDl16J6B+8kJ9csCHYoV1zE8V
         IVQ+n3QP1YBOsxxsvCyUvB2fQOoW2v15on/yO7hc5NCZHUwKxwq1aY2JypIxeSqyquir
         AXf13tGp3razthQCOpqSbHxYdw6ZHiPU0bAOs02C33jzygv6wZYL3ggBDpOxl2GH7Alh
         8t50zhGJ63P0vM24YFh0sVn4al2/1dkiUfxENoa4pSbFqpUDFKrIU5a7UsKt2tNKHVRx
         09hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780098190; x=1780702990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tKzq7IfcEZUd3hgNxILmg8jMvNqPdQHBBOhGY2G7POA=;
        b=QamymxUHXQFN1EYxetVPto6lZkFIJXPRE3FT+Ou9JFj4+1j4cs9Ty1FhtLH0QBjFBt
         mNXosZlp7Fq+JQ09Qkj+D5v3Q7eULJ6NfuMaqbe6F8f46iitxutZ0tff+XZ9jKb7sYKq
         mkomtch2OjsfiwfO6vNP0uPYgVYv2eIOH7Ohp+xrWI2Y/TkEZ4thjv7UYT+bykOSh85a
         KT/65rU2y4zuvYjF4jt9l4cAvPwGP/ogD8u9dOY5q8GnwzKqlCIh7Pdr67TmDY8tu5Fj
         7jAPRy3XldUuT5oHOCsI2S0aVck1PvgAvGLsCCbi/IA0eL01uCSFnmR+vT+fbnjSj+ss
         hqvA==
X-Forwarded-Encrypted: i=1; AFNElJ/tzy1sLfyq9lmpNKa/xd7d+hefGQDED2GIYSqsD52SEqW6jHLGlJimOk6uny79+eEPJLsr0Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBlQmIZnZfbn+FVUtcFfX4AvCU30Tqy6iuik5tEXL/QXfTdBiZ
	6SeOQlTnxFlyLtBIbnk5SudqKFc78DBsgHLpRBrT4J0AYL/mjxq/xgke/ywQ5zNiczYhZJtiwN8
	SxRfcZHMCnImmPmXyt60AWO3nzETfK23wPoHqsjAj
X-Gm-Gg: Acq92OHnZH6B6yMtAq84HWEf4ifRSdzEYbQLU9DDrHE8WiY00lBWY8K0e9VyPIV6uvG
	OclG6yG5zVMnGv7xWRMgyJzhmnzZeF8R3s+s209NVh9KMJws0+qi+ZqMSpE2nUKrhfl8dpGyNEX
	FuPF0T30BxagdD8FbM8ICVtxM5ap0nQxlRqp54prF63gbULKQCbOY90CS0pHif9S/UYP1Lb137x
	9F8vwlGWavbgStzvdOnFaMfIdNTs0fbK6/4lHgOl72a/Dt7yyX1Nw42yE3l/lmjF/nepULTGs2t
	u2j74pfrcFRZiCRaaSuIg4lpO1P1iRHwxxFQxBA3xkEJ6Rb5kmK+1qED0RKdk9ngS8NSqVZgiw0
	=
X-Received: by 2002:ac8:520a:0:b0:516:cc18:4760 with SMTP id
 d75a77b69052e-5173c7f8e90mr2205181cf.21.1780098189444; Fri, 29 May 2026
 16:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
 <DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com> <CADXeF1E-QpKj-37T5ghiycXrVR_YN72fOc3M4OQg-Arz7JNjsQ@mail.gmail.com>
 <DIVG6ANND95G.2MC7WWJG1P01A@gmail.com>
In-Reply-To: <DIVG6ANND95G.2MC7WWJG1P01A@gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Sat, 30 May 2026 07:42:33 +0800
X-Gm-Features: AVHnY4J1Ig3EmZdh4uvcsIMLiW1cS4wpj2bYrs1Iukydy3ntReQaRHUXULNuSBg
Message-ID: <CADXeF1HQ-Ep-DVGfDs7u7YB9prjAuotS9qRBg2xWP980a27t_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Todd Kjos <tkjos@google.com>, 
	Carlos Llamas <cmllamas@google.com>, Kalesh Singh <kaleshsingh@google.com>
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
	TAGGED_FROM(0.00)[bounces-293288-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,lunn.ch,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 57E61609F56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 4:36=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> I bet you fixed your android setup long ago,
> so all of these "but what about backward compat" is getting annoying.
> Whatever kernel patch get merged android won't even backport, so enough o=
f it.

That=E2=80=99s partially correct,  Android GKI does stick closely to upstre=
am
and mandates an upstream-first policy by default. However, we merged
this specific kernel patch into the Android GKI 6.18 branch as an
emergency fix, because internally we determined this is a kernel
regression (introduced in commit 120933984460) rather than a userspace
issue. So only kernel fix is merged, all the userspace program is
untouched.

We want to avoid carrying out-of-tree patches forward into
next-generation Android kernel releases. That is why we are raising
this here: we want to align on an upstream acceptable strategy to fix
this issue so we don't carry a permanent fork or risk regression on
future rebases.

> Replied earlier that I don't like random checks like this through the cod=
e.

Acked, I will raise a v2 patch to add theck in bpf_prog_query.

