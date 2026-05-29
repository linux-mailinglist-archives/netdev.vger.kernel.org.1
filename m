Return-Path: <netdev+bounces-292972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMwHLhkaGWoMqQgAu9opvQ
	(envelope-from <netdev+bounces-292972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:46:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0075FD222
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E8B2304DAD2
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183B9376BC6;
	Fri, 29 May 2026 04:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOKyv5qB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49291376BD9
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029900; cv=pass; b=hUWMvkeq1m9Oj1d0evF/gBAFIrtH2QjH0YFrnnj98/mQoKAyZUccxh1qLoOxHAUwQ/po8jkgmJ+ahWGpySl95FwEuYthRdGzJRtUrokmimi6BzOmnmoU5A8F42m8G3c/jlw2LitNCPbZm1E34rFlbFmWG9S+WJub3yS9Ke5tdds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029900; c=relaxed/simple;
	bh=eQP2e/SSLB4Pxhr6C2kldz7+bmcpYvVX3g6PAxO4izA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE0d/qx9ONOKAnAqIrGssrY62QymWApMLrF770oHkMp0/sYRRCavWcH5ZFXOGa+QwOGusJbdLD63iRC1x0jzj/nxLcmlfCu1tuA6o58ILyHxcxMeGGNvazuhbHPWxx2wfm7Rtgrim21QdR0G48Se7kvHVPGhnKzXeVLJQZ+UiXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOKyv5qB; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e61648f10so4781cf.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 21:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780029897; cv=none;
        d=google.com; s=arc-20240605;
        b=TMcK9nIqJUJdycG1pxo1irqfjAHiUSn+JV4uuo9Hzzh8coiMkMx7IN1N8MEqZCETq9
         y6zbkHSc5vYHB+ds0WTNTHkxGW0m2aJuj4rvOzgdmlkXydsRT+Bklj1p7EiLmyMvp9JY
         wSZnLjv25gbWPNIN9EOEFRAogvSwJd3T8vJg4nK3ndqkUz2pP1btbKLmq23X5Uz3HQb5
         IqBPxdzRtIiDW0E7lVnlhp8ai3cunzv5jNmQW9Ym9s3JItYg2NS8wISDqE586rwJTIpE
         jSYuvSop2k0uswNiiEEL9RSpJyl5e1kZpcqYF9690Tc7ZbRQQdIdQWUUF0NxHH3Hj9+D
         q7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CeB6crplwXIBRzpCdZlH9G0V46TK/YkUIeRLLxmd+lU=;
        fh=CcdmQEZpe7z3loHIRW2QTNFQxQWRFhlQLV0uQmR9M0s=;
        b=PQG6WvwEQ2U6/LC8xHJbhIs4h1N7ZP0WLNs3RTWU4TkvVqbTTfwF3VjAdnGV058H2E
         JZF7ifQXKfucbA7OL2nbrorEdVHQQh+2CzCWATV//lDOC8yM4C08uIRPyOpE3eQNN6dU
         lZI3DUBjAT1IRfo6PVptL/dFIE0//1awXGxHuL+krJo/NHT8KuTHtNb8P3aRMub1pWMI
         XXW5PXxxM72VouK2CkyzNsei/6d23sHh/a7sLk6Jk8+zXwbw+4uI7o+Wo2tB/uKJ8WOS
         AnnjhSVp/0iYQeDBaxyZ11HbZ/ziqMSTrePAdfB8PjjXtqbbxBWNoMCRWBUdubs2wQm7
         UH7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780029897; x=1780634697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeB6crplwXIBRzpCdZlH9G0V46TK/YkUIeRLLxmd+lU=;
        b=MOKyv5qBfjv4HCt2SmfipjFFImdM5broZf7t7YOzLBMto7GTY2z7+QlCpn2lQzfew2
         9mB4Pi+9ykpUcfihDza+3pofT8hJkfI5SrmRpIbHTg8T36OHOJF/zdyo7hLBs+jIH3pt
         ncZVuyMWag8zlPlxNErYIswBIxLHSxZIpBwEGl5foGHCxy5yUO35JvZ5S6F96GMMU7SV
         oc0JbdLn7YTV9hbsoJ5iRWTpYuuz0bZDLGnO7vXDx9ERuWi8WMjACjZlXeJoFwY3wIql
         sy03TLTDAgxPtfquR2OJKb+N7lN0itUY/epr8dJ8i0X65iESQchoS33+x86MyGsT7p5Q
         FVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780029897; x=1780634697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CeB6crplwXIBRzpCdZlH9G0V46TK/YkUIeRLLxmd+lU=;
        b=Kbbn2POXU1loezIBfKkpexq8vzs10cYmbtCPsvcZaMrtEZg45izhIRJRybmlHL62QU
         vivfMp16WzKGMyQ7mPJNQqix7yhP73qORLzppx0bSNsrytfGxuwUFbBxnackZ9Nd1tWg
         WfdOBK15FIVWycfLelr+w6yyXzV/YIHt6PzxZKfyZmkFBl2RllGFuvDmR24DIFd1XUYa
         NXFKeGYbNs2vI1/rW6+UsaJ8yMyrscDEQQslMvRJamA62VM+J88Ryve2R1liFXjBJ8fy
         N+D1RwNfRTVcTGvBRUmOYDb9f3zxfBiRNnWWsy5qkjNUQugEwaVFJviBD8wToJspXUGW
         EYMw==
X-Forwarded-Encrypted: i=1; AFNElJ9TCi8R13OjHPr3yTLrWP1wwBsIzT83Q93sGJcmLhRUqcNEBniyY4NbpfCvwlOovpeR2du8oKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvy5cpXso1/mnNtYe0pTGUiMqot6mLDY/KVIbXPraw2Gb3oyET
	iH79QV6PMqRTb8HPowI+gmQ4/mhgVOtc7pJU+4gB3qF9DhW32pSQ92dC1+bu2Y2VBUVRR76DDDA
	NE2Gkb2fz3n/QcjbAu99F/hhER0HRsHBGeX8ObMLr
X-Gm-Gg: Acq92OFz4f44I5IaZef1EXToajcmrmR5MyDueQdeHjSw3wwizODDbtZaMKpXi2X0Kf4
	DvSBCEyU1cRFymMvxRqRsYUwP/lZhDa7V8ftym96liqAzcULgbU3L5pCZ6BZis5B0sOF1y59NMh
	WXUShAa20tuSPzAsjRiufkP6zvZzq8MAaCt91+2YjJ9nnVFD1Qq4eUkLvzpws2lIVhwYfPNoWdM
	qPzqi+SEvBoJJS48exNa3pyzg6OdxslBepctQrOwq5aBMCITyROyGZM/mVC1X2FlQ3kEGxhJWz6
	eEZutXiM/lAzrTLMuaT3Y/bnJCbR1RlTdEqNUXdQ+DNSckqChRWZDnY8X+G2Kbcj
X-Received: by 2002:a05:622a:9d3:20b0:50f:d03e:6482 with SMTP id
 d75a77b69052e-5172dcef32amr4403711cf.4.1780029896687; Thu, 28 May 2026
 21:44:56 -0700 (PDT)
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
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com> <DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com>
In-Reply-To: <DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 29 May 2026 12:44:18 +0800
X-Gm-Features: AVHnY4KeGTzWQs0Ti0amBOZL7bylrTP3wH1i0px8sXV1Q7lFoUnTtYhLJT-e-9E
Message-ID: <CADXeF1E-QpKj-37T5ghiycXrVR_YN72fOc3M4OQg-Arz7JNjsQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292972-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2F0075FD222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 9:03=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon May 25, 2026 at 12:21 AM PDT, Yuyang Huang wrote:

Thanks for the reply.

> Ok. This is fair. 120933984460 is indeed problematic.

I'm glad to hear we agree that 120933984460 is problematic.

> Not really. Your patch adds checks to what looks like "random" copy_to_us=
er()
> places. This thread is clear indication that it's not a "robust architect=
ural path".
>
> True robust path would be to wrap every copy_to_user() into another helpe=
r
> that takes uattr start pointer and size, does extra check, and
> returns something like ENOSPC (and not EFAULT),
> but that would be a significant churn.

I agree that the truly robust path would be a proper copy_to_user()
wrapper instead of doing the ad-hoc check in the current path, but
indeed, that will be a big change.

> So I prefer a minimal patch that add single check in bpf_prog_query()
> that checks that user space supplied buffer is large enough for attr->que=
ry.
> If not -> EFAULT. That would be better than overwritting.
> One can argue that partial copy_to_user() in __cgroup_bpf_query()
> should still be allowed, but I'm against partial and
> inconsistent queries.
> query.revision might seem benign, but if we do it for all copy_to_user()
> we better return ENOSPC to differentiate vs EFAULT to tell user space
> to fix itself.

Okay, I understand the preference is for a minimal patch to implement
the fix. Just to make sure I fully understand your suggestion:

Are you proposing that we add a single check at the entry gate in
`bpf_prog_query()` like this?

```c
static int bpf_prog_query(const union bpf_attr *attr,
                          union bpf_attr __user *uattr, u32 uattr_size)
{
        if (uattr_size < offsetofend(union bpf_attr, query.revision))
                return -EFAULT;
        ...
}
```

If we implement this, I want to confirm if you are okay with the
consequence for legacy cgroup queries (e.g.,
`BPF_CGROUP_INET_INGRESS`):

1. Before 120933984460: Legacy userspace compiled years ago with a
40-byte `bpf_attr` layout (ending at `prog_attach_flags`) regularly
queries cgroups passing `size =3D 40`, and it worked perfectly.
2. With this check: These unmodified legacy applications will now fail
with `-EFAULT` on newer kernels because they pass `size =3D 40` which is
less than 64. This means all user-space applicaion is expected to
"fix" their code when along with the kernel upgrade.

Is your preference to explicitly fail these legacy `size =3D 40` cgroup
queries (breaking backward compatibility for them) to avoid "partial
and inconsistent queries"?

If we want to keep these legacy queries working safely (without
failing them and without causing memory corruption), we cannot use a
single check in `bpf_prog_query()`. We would still be forced to plumb
`uattr_size` to `__cgroup_bpf_query()` so we can conditionally skip
the `revision` writeback when `size < 64`.

Would love to get your confirmation on which trade-off you prefer
before I send V2.

Thanks,
Yuyang

