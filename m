Return-Path: <netdev+bounces-290977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPnVM5/1EGrNfwYAu9opvQ
	(envelope-from <netdev+bounces-290977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:32:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B345BC090
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 02:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87E5F302CE53
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 00:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29E1C3BF7;
	Sat, 23 May 2026 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QoPlrSYN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95411FC110
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495782; cv=pass; b=EkW/t398sxI9EnymXKFxPm0nCyNQfWS8H8e3W7A03UOws5e8+h48qei/X1UdcLzdO/8FIPBwpWZhMYREtvRGP4BFGxppL8zBv2GqaFpJ7ejp+gfhYCq/VJ27+7Z+FfKLqqJXzVJq+ojt+GNHj3/p4IfSbNkWLmyQEzOcskoVNtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495782; c=relaxed/simple;
	bh=+b4RqN/bq99NFKJTF469ATTYpo2k0M6WRaHIdC7aoF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTrDBPBSg3wirNbr6lICsmQu/EtDyVE2cbI6wNbWqlefAEY7ayfQy8DikS55eXVQoFRaE0YX5SNt7OKmOOXYKDkgsvR21tWinSwH3pZ/EsCnD2j6PictBbOcaM/+VVQuS08Gh63EFkk+AX3EnL0rNjAV+89cHNguo6yW3fF16zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QoPlrSYN; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-135e88b8e55so2601174c88.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779495781; cv=none;
        d=google.com; s=arc-20240605;
        b=ImLy037sypwE4R/QwLOOrNyOoRAkS/1fovBSGtQL6WKY/cfQGISuAFHDgH+d4SPmeG
         YnNMSNL3jLnfRuFgi8HAXqPafVub9N7MK4/20xnwrZUWLRKTlVco1Vrjm6yIytlgUWC0
         8BL6d0/sRlT6Y0SCOGjCs9yPbHY5NFeVS4SqxgErn5Dh4jwQs4d0ZNWQkxukQzkaou17
         fEDX8nO5UNLxcEU1qhvh3tICHydQ89Pc4hKr/vbS9UgG4Ob9/ptoYxnFxh0Z1atetYZW
         eqLXjO/tWOh19XSVYd003/shRUsR2cFhWsIgVxbMw0p3dg2IDRph/aWbi1KRDAYlKewZ
         NFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xYj58BCtDwMdw4Un0o/5awfHoJ76G8q7m0EyUW6lkM0=;
        fh=Krl+YgkH7XdOUbJV598UrEZ+uTPPLSGlYtvi8waaDgQ=;
        b=Ti+KuZZvArm+uW5hRLq0ZxHi+EarZnC/nlD6iM4qJZ63aoOvZpQM0VmkmHwutpoDKy
         MBnXt9ib8DVclxUBVHjp/GjQNXoBvxok7/AQXn62KBWKJwEIrbdYIxcR9OTfLPmoyJW2
         P16syqe/F2Vp5vzZItIUJ/TG1Hz52EtpNTRdr7wp1qGTXDRjTOUHkGPUDbl1CyhzAvzm
         T2Eisj+R6SoiBWEY/rzEgKHrK0mkeXscpfiAWqxVQQf+oqMeLP2FkWm57nghOSS19vwi
         JDbF4PJYdyjoOLr+o9DAAN1Y56Z6xT3WjP08KqdTsrBSKhUz0KIyIW05ncXMTq+JdtbS
         CUAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779495781; x=1780100581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYj58BCtDwMdw4Un0o/5awfHoJ76G8q7m0EyUW6lkM0=;
        b=QoPlrSYNM6Jn0/A8KBQZrw/SMhB+eK8rBVfqg+h5pvc6MJ5BQkhBmClfv7os3GlzPg
         2vti1FkMuO/8e7Wtq1qXR6DDpG6oOr8i/o0/l7jTZUej5s1BZgbwHzpBir9znZyaTI40
         UdDHfDQ/FVonTS/PzKsM/dbvNUXz4mMhl8fu2e5wVvU4zibXyf9PtoxmV9IqQjuh1yj7
         MixJgqD2bXyM7JVfR+xpiwpI0II83EAdo6HTSbJDBUMMT6S8LaaGIXcX5SQT8axkl5IH
         /nHe+WdguSXE7W1anSygvusndVZELvkQ7VhSZwTWMMPKaEaYytSReZbK8OMkZyOc8YcZ
         0zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779495781; x=1780100581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xYj58BCtDwMdw4Un0o/5awfHoJ76G8q7m0EyUW6lkM0=;
        b=FjcjIhu3CF3ESIg2uK2PmsYQ9E17hzAoPPnp/VXan33oiZnpdClS/7UuybSg5Lp7/d
         JiiGA3em/AV7mxDlcUCYEyRxsAntmbDfHjL1czvtiWJCuIJ9gxSZjxkayBVCqwLJoVF4
         GL9PoKODO1bi0jktL0orlyd1W7MDDn3Jzqi2fHKw5icKRUuuW1yMFh/RfmeQrklA+Yjl
         OgCiGqGI2GhAesHQR468iBEYpSQCDRgtLP3Gu4DtVd+geag2I+pb6WdqADciyEWl94rc
         Eh/kR899n/13COhfKkodzaO7Y64YJGCf79KoasFVzCKrATsyNvFRAHD+S0t71lDSgSg5
         DXvg==
X-Forwarded-Encrypted: i=1; AFNElJ/ekynZCypJJXcqmJuKESvvEBrF4s50BfwlKPY7ZcAE0w5Y0+LdYM5CynW0sXFKdc+iZpCER1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYIVifc7kaBBz0PhpDl2wdi0wIwsOu+JZpVwmcSNpkjZ7acB/R
	ZNpdtkiEdoHGMHRY8tZLHHc8hxLjwFLes+5/LFlQyjS2F4mlSj+FJtuY37MZAreXnyDHwlQzCD+
	Kf5lOTZVCBfCzNnT3xYUMdvjTDhry0qbbHJHh1WDf
X-Gm-Gg: Acq92OFor7db3Ft7PUNwgb8G+WfTFHBf8SlsXMOY+tNAReSpCfLyWuaeBU7oe8XpNDh
	BVMORE7+FjMEH1/Qg5zOqfvWzMuRb5jvdVYgeiSg7G0ac4DtfC73lCX9fXVMsg64Je/tCVBtjsz
	BdDzEFLDKzKKLQQnKp3c0xTjU6CnGWjQNbdaERHfB+ZdFKk+mGAeNkRW2AMw/8zQFWP11fZw4WX
	QwMooW9Ob/OQu3NECdyLpp3G3mBMV97lBMx/7Q/8s+WqiMI7PXo+nLNYvUh8YeDpjZp45RDNEJd
	iC7AsckK2V15GWOjb3rGD4LXyiVJZypY7Bbzd1hw5Dr/6nzdowMn7YD8ZEdN1OfbHwt4fYY/oEp
	vYXtAtTyLhJaS3Zpnsy0u59AkqveOlFM6SAs2jUOCC+g0ZzjnzXLc4cQ82N+yjC0=
X-Received: by 2002:a05:7022:45a9:b0:135:dc82:85f7 with SMTP id
 a92af1059eb24-1365f70ab48mr2139390c88.4.1779495779978; Fri, 22 May 2026
 17:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522074601.1658705-6-kuniyu@google.com> <b5c171e50d47d65d8bd9edc67d002f02f9843a5ab2677183f57756ff25c8a2f3@mail.kernel.org>
In-Reply-To: <b5c171e50d47d65d8bd9edc67d002f02f9843a5ab2677183f57756ff25c8a2f3@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 17:22:48 -0700
X-Gm-Features: AVHnY4Kod4mBHGxbv2PQA_sK6_vl2iDOwVTcGIw1DgrxSyf0au5JEiV13xePDdw
Message-ID: <CAAVpQUC3ryDha_Hxev3pt40Yp3zb2RzefWJqwxDdJRrErJL70A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 05/11] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290977-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	RCPT_COUNT_TWELVE(0.00)[20];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 97B345BC090
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 1:22=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index fa8a7c7d86eb..3608036632a8 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12388,6 +12388,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct=
 __sk_buff *s, struct sock *sk,
> >  #endif
> >  }
> >
> > +__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern=
 *skops,
> > +                                           int rcvlowat)
> > +{
> > +#ifdef CONFIG_INET
> > +     if (skops->op !=3D BPF_SOCK_OPS_RCVQ_CB)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (rcvlowat < 0)
> > +             rcvlowat =3D INT_MAX;
> > +
> > +     return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);
>
> Could this reproduce the MPTCP subflow issue from commit fcf4692fa39e
> ("mptcp: prevent BPF accessing lowat from a subflow socket.")?

At this point, this kfunc cannot be called since there is no
hook placed yet.

Also, a subsequent patch disables BPF_SOCK_OPS_RCVQ_CB
for MPTCP subflow.


>
> In the v1 review, Bj=C3=B6rn T=C3=B6pel asked whether BPF programs could =
call this
> kfunc on MPTCP subflow sockets. The response was "I'll rather drop suppor=
t
> for MPTCP for now," but there's no check here to prevent this kfunc from
> being called on MPTCP subflows.
>
> Without a check like:
>
>     if (sk_is_mptcp(skops->sk))
>         return -EOPNOTSUPP;
>
> or a protocol check, this code could trigger the same warning that
> fcf4692fa39e was designed to prevent.
>
> > +#else
> > +     return -EOPNOTSUPP;
> > +#endif
> > +}
> > +
> >  __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern=
 *skops,
> >                                             u64 flags)
> >  {
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/262756=
74572

