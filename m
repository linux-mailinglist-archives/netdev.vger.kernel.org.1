Return-Path: <netdev+bounces-292692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFnZEjpBGGrfhwgAu9opvQ
	(envelope-from <netdev+bounces-292692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:20:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E27925F2A1B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3826930234C6
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D73F1AC9;
	Thu, 28 May 2026 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKfFiyed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF533E63AD
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974453; cv=pass; b=D3QIK+wCkmFaebdFawmb6UZsga3lZXur1U6w0DU8+j9XS2XYZREib+1IuJstGxIouTSzJf/tWkM7hKaFJ0GOS+HPnAn/7GHJ88OTfZXp4ueYM2MgVtLAHQUZ2L7KTcq2275cgtBuu+f14dknlRMUzkNP+HBATfyGZJaS3CLGEMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974453; c=relaxed/simple;
	bh=doRGNSl+JRMvhI+mexfOV/FktFb7ko4VJp5Tr8m1gg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYYmu52Lc5/kInpZcdQ3f7NXoBylwmQCPN1Bh70Y2BM84HD1EPvTCEysxJpAaUOdrdk7R+v/7ZexoF1+O8BM0EcSsMN3jLYA7Fj8WYwTzzAp0vKEy0weFEVll7q7uOFQuoJFPIs2/PYsvHzajQR/4N6Edud9h1rxk6CWixiJzlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKfFiyed; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516d78ba1adso4171cf.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779974451; cv=none;
        d=google.com; s=arc-20240605;
        b=Atg7pVvAdIpwafRg2HdByOIyKQa3+UjsxKk4LgwoaD7VGDgmJOEs5k8JL/QIwulEoM
         g4qyw67S/Iw1YyJ1Ch6YIzTvIGmQbqT+bQEp2JwTegxqpLEBlVcpvyxE+W2krI6bThmQ
         lzk/NHX04vqlH3yf4IhwW5Rg4ytyfhSx029CU4jkHsJFXM/Dct4HdJ55HNQyUmY+y9zd
         yRjA7Q2Iex6mM8jI1fb82Vs8aMbP/elUw7sfzFFby2uqEU4Y3d9g1JgnFR17zB1+Z1gX
         GPGW6A0cT1yrKIragnqtn3XUSbEGNOaIWwGlWE6XtfizG1V+4CayJ3A+kkmtHeuImvV+
         aiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bVIvtekCCz2sDbkbLvNpEsNZ2RPanGuWqkWHrLbqD/o=;
        fh=tJPVbgyVr6B1UKq+8XncrDFzHuEX6pJgRzx5zdYUjYQ=;
        b=ckzyXWNqkr1YRd33ThpjpYUN1BVw9/rYgTBI3wIzak5A4xqr/TxOhSJiVogsHQg+ad
         SEA5OW3XHPb7y3OSPnkwQF7ryQLJBaeDzLYkJ0DR3xz0/iodqtrjh+ekMLMuwEl2OiXQ
         bmBSrANabfW1yEbX+snPIHhkC7yGx1ee/wPgx+aTPJ89kd48gvoGDH2GFQjvgR0qA5kq
         WB+jmxicvtyv3F7hDHfWJycauNm1DUgz5rVkcXksnsffSgJT68KNPTjz5F0RKsmkYk4N
         h1ng+y8l/n5U67CZ++ED3M1VOUtvUfTjNyD+A5ql+Ksl3FJ5Ptj2ZsWU+G8hAb20fDET
         b+VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779974451; x=1780579251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVIvtekCCz2sDbkbLvNpEsNZ2RPanGuWqkWHrLbqD/o=;
        b=NKfFiyed1NpjzEk5cKYX5h5D8N50kGSt9SbV7gDczD4BJsVp7ZvK7858LtmxgNcmWw
         t45+QxwFtwTfXQ4Txgz31vPxlhn611qVbpO+/sEZ4orcET1qe2HGVOdxc64hNqAijj1z
         dXAoHH4CIgwUHVYg2C/zg6qDJUHWsYQM1M/1q9C240DHcuhtrrzaX7ePnMLrcWMKROd4
         EbYz1dCCniBLcJFvKzjURTATtwU+NsYdD+JBZquGMbJXyljYclQBJIjPr8vKGSWbi5XX
         MQ+suc1vJcVvNv/3aGGaPxMO51ZY0bVwCDsffgZDraUpXAmGSssBakkGepjPbpTahosE
         G0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974451; x=1780579251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bVIvtekCCz2sDbkbLvNpEsNZ2RPanGuWqkWHrLbqD/o=;
        b=UTwaUKpkGRfY7TIj4QlAd4Lpdr1zcx9+eFmsZjB0ecbaozPwNz6W23rLxijM1sjx+7
         QFFnSEZioxe61/QG4NP+hX5GeTLm+cMGih/I1ldtRgiDCe5f3W1h1y17YRQxMBG+cdpr
         lL7WJXVM4moK1JXwzxVMmbPuhDqHL/W5xcc7GK9Kiv5hBIyWHDyqphU8/Dbx8m8CEkG1
         ebOSXlfPJF4O9ne8BB5DIDDlBoGhsS3mhqpN202Vtd00YNQUmNM/jPV0ssn/7zkQNm69
         dzp4fFZd0ryNGebEsU0HtjrBw5v+6D/MlBtwKw5M1uJLrq+m4urzINwH2BY4ErA6uged
         0J7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+fQGTXFC8+mQ7eAvcE6ojSf+ZAwueUJWBnuZ3IRK5hljBH8Ff4hpDy3Cxuw4kaJouCv0PvMAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLyaYpb/Bf7bpTNDQnhonEvOm18Vnwn5kJGWbl1hYalbX0oq+E
	++DPm5U12+Zumttiifj8v1NPMrmSf0ciIffGc2XP71vCKNDUz6udIDJ7MiaFuR5r+38U04aGhGj
	bdLaG/YBlR3KP5QYYDDczrOOKNLiXMxzS/DflusbJ
X-Gm-Gg: Acq92OHrsoEmei8WEnKluQw2NZI2TYTrQRIR+lv4gGqLxARTosFIDbWac/9wBlHvR/+
	tecOKQmPTpbq3BNpUlnP4YkMr+QXnKAx8m9Ah4RvoPD+4w3MOXJs0ysj/kHu2C40CGYLSrrEWcx
	V6lFuejWYCWZypltJqUWpD4HcCq7BcUHXIVdxmisG9zSeIk9Ro7+aKQ1KZ3aFDfCpkTwq8x8S9L
	QylfHUBZ+ft035Xm5GFurS7cokSIPBqW5cj8aEDe85CPlIrdsZtSrx9NBmPgGiSIT6eYCQQr8mS
	mCuVjcHbjAma4X/wT0pJ1HblAFpoDTBGZgYcw/wueh1NlMXjjR0nJxPgtxge+6Pu
X-Received: by 2002:a05:622a:588d:b0:510:fa1:73c5 with SMTP id
 d75a77b69052e-51720c148d9mr6767901cf.16.1779974450621; Thu, 28 May 2026
 06:20:50 -0700 (PDT)
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
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com> <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev>
In-Reply-To: <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 28 May 2026 21:20:14 +0800
X-Gm-Features: AVHnY4Ly9tBoka2LFYS2KTGQrglvyFosDs5Do3AvNO7tPh98ZxORc7T-1s-cUUE
Message-ID: <CADXeF1HRe=U7aWx2yx6RFZ_uH-mMbdsxMheofr2tMD9wae46oQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	bot+bpf-ci@kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
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
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292692-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[gmail.com,iogearbox.net,kernel.org,lunn.ch,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: E27925F2A1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 1:43=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 25/5/26 15:21, Yuyang Huang wrote:
> [...]
> >
> > Feel free to let us know your thoughts.
> >
> I believe this is a user space issue instead of a kernel bug.
>
> I tried to use mmap() memory as uattr that got -EFAULT instead of crash.
>
> [................] /* mmap() memory */
>              ^ tail 40B as uattr
>                     ^ 56B offset for copy_to_user()
>
> Thanks,
> Leon
>

Thanks for testing this!

There are some discussion in the original thread:
https://lore.kernel.org/all/CANP3RGfZTXM_u=3DE_atoomPZXutoQJ02nOMkCCR-YBZbO=
m2suWA@mail.gmail.com/
as follows, which might answer your question

> > > If the uattr indeed has less than needed space, then for
> > >          if (copy_to_user(&uattr->query.revision, &revision, sizeof(r=
evision)))
> > >                  return -EFAULT;
> > > the kernel will return -EFAULT to user space.
> > >
> > > Maybe userspace didn't handle the return code properly and causing
> > > user space corruption and segfaults. This shouldn't be a kernel issue=
.
> > > Maybe I missed something?
> >
> > That's not how that works at all.
> >
> > copy_to_user() will only fail and thus EFAULT will only be returned if
> > the memory area copy_to_user() is trying to copy into isn't
> > owned/mapped by the user (or perhaps is read-only protected, not sure
> > about this last one).
> >
> > Because memory is mapped in (at least) 4K pages, the memory after a
> > user buffer is almost always still valid memory.  It might be unused,
> > or it might be something on the stack - like a return address, or it
> > might be on the heap - metadata tracking, or a different memory
> > allocation perhaps entirely.

You might hit the same case as maze@ mentioned in the thread.

To trigger -EFAULT, you likely positioned `uattr` at the very end of a
mapped page immediately followed by a protected page

Could you share the test program you created so we can verify?

Please check the test program I shared earlier in the thread (where
uattr is stored on the stack); the BPF syscall returned 0, but stack
corruption occurred.

If you think my test program contains a bug, feel free to let me know.

Thanks,

Yuyang

