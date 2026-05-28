Return-Path: <netdev+bounces-292763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL9bAXlxGGq4kAgAu9opvQ
	(envelope-from <netdev+bounces-292763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:46:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0235F533B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25EF130836F8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A842A3F4DC7;
	Thu, 28 May 2026 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="La3S7RSD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFE3F6C33
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985146; cv=pass; b=NUCgofMdoFh//q/7ehLiqikDLO611FMIMg7jzs3186oiOsgj9Xa8GoCcFfRgHYW/r3Trdk6yuFIIWMfqmSTcNTVN5xXHiNxVQ9VQbeXWmXtXWnvidyVbR5vK5Qt8CuLY7SBcOBglG3Sq2fjMdC/DEETg1pq47QIxeLa3K1YPfcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985146; c=relaxed/simple;
	bh=2cE3e8QUtpQIKPo3dwPxuDOlqzE1WmRPLP72+IMItW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWpjamusLvzhKsZhNdBnM2HmUAkuApDhC5PFTIrw7INoVAXXa8CrgaKUYTs8T9GFXdBAu3ebRKqTYi2EaLKPeyTM3Vfhw/bzqMhqoKvVw/GdfptNd8IqN9Sy69NRrLQTVssUE0JWnkcthqrvCrbHOVzGm8jjZIz/UWnHlBcnvEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=La3S7RSD; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516d6009380so1261cf.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779985144; cv=none;
        d=google.com; s=arc-20240605;
        b=FilsoTdHm+5LZ2fisD9W+9c7ymF9G0hPigcL6L2DwFYph2SZsLJq7iYJZRQ292GNXu
         B4guIoXQGDQx9O2QiD60Fr2DdFkXYaorZ+LTbQtI2nLXqqgiYrJk4bnzLN9q6C1yH7UW
         T4HMK4dlVvO7AhjwZV8UWshYm7SW7QlqNCEQd+sC0U8Ka9i4w2xFkYz15rq2VZVd0bms
         En998ezxpfBNsCFIpQHlIfDJM9gcDgVP24jDc/Y6mahg92jKy2B0tUMK/0QeIexG+Qwo
         zyjAhNmY3kz6IACfemeMHYuCKHUtCJSisP0LE1bpWZKU7YSXPNK1JXu1jjISiiIG02Td
         xwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=478/AxxorbjxlL+8D6YnRYxtGnmoIrfbdOmlHjfNrLw=;
        fh=IG2XVDkj3t2pWf/32CEFCgiE+Td1dFXkMILtJmeu4jg=;
        b=XG8w+ASVt2GNItOVVmaxsBErYScTGGczErIUDsB+sSKA2LWHH6RMFFGhRI4nS93Mx5
         sZmWgyyM/RLnBre0sWvlmwarbUx5TQk6ZLkQK5RnrY08pU8f395KZk8VQ6ymoDLihuT6
         cmNAKVe7cGKu+GzC/8xXkacleGFF+/odi6HsQiXTb5wBg1eXiGcpmT6i3vfCvAwVH4QE
         kXu/Fmv8XVwnYwQJI5YJXWicmL95I48nnnRK2Aa9LM2X2eusID7yj/UUEtZqxcXGMtVn
         HRIPurFlU54XROpffZG9CQQxRxmrpBBpy/dhcyK7KzpBVGgOvIhw3bpsjYOZgzj8fYQg
         2Guw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779985144; x=1780589944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=478/AxxorbjxlL+8D6YnRYxtGnmoIrfbdOmlHjfNrLw=;
        b=La3S7RSDJMGaMLw5jnVAqR/vltkQGXt0kscfRO3bsMYYJmvImaOI7uumWRhYD8PHxZ
         LzfrpC9xxbyFQe5k52hu5VTvvHnLrIuPskzNkJ7rP1DRCUG035YnQq8xkBxOhnimhU4A
         jf1S91fK+487OQdzK3V1xEam2avtAqjF/1UxXwF5LPnR8kpYmQfdOQ0vQxx4yhTMGLD+
         n4zB16j31j9ek4G3FYiyE4bAbQ/JwpxPTHTCaBGXp1i2fuU7dp/ZgDc+6Dtegd5HFEy1
         AUAcWyvYMBgln45cs8bqJTM9mYeEr3754CaGoi1Kusdfu5lMXsEyWDe/AWg408dur31K
         ywxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985144; x=1780589944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=478/AxxorbjxlL+8D6YnRYxtGnmoIrfbdOmlHjfNrLw=;
        b=dtPeBdZzFrBEdR61yFXIntkWcXOR+UaeZbzx2nXv1yXBdXu4arW/Jr0Ey8MN1l1kFq
         pRJovy+prUKC6efFGLd29IS+pI9bA8h7f9NXlgf7XMb2co9iVB7YT7wBuvPRqM3qMnXL
         aClLYhXHGXTKR76SmO2ghzqC0I/MxyOFDIIabz9jWlOzHM4s4cBJhO9VaKEdxnpk1OIh
         EDsntLvvm36yoVyJfJHIhdXBmROfPgjs9NcnKgpQHKtlkqXFXztST3uPNF0b9g8dAV3a
         2Vape3/G+77t8C/BPjdmeg5mCMB0mf6EscZOowYFluHeRj2idMqd+fQkadbFaq4PGS1T
         KF5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/4l9aADiAtPqDYVWaOay3Sj2YUiDSIFIy8JIENoMZrCR0OgwCExI9UULE/lb6NEk5rLqO6pzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAke0tp9kvc8mQg5XR2inyqfomp0PHtCpEmHolE4RHOOODhEA
	w2l4y6LqEuKN6e/dankfL/YtU2CUVFy8FWKhkmA6A3QjSQpybWTOfNp6FqAnQdUCWRFTOSeuDtX
	jkPlmWvkvjebpK0r59qaGeyeNkWOyMaTejsjuNEXh
X-Gm-Gg: Acq92OEGQLeLSnrTeG5+IODZsz/0ShcGYekPETdHoGhhnXQgJsq9OR+gS4LnuSl0QmL
	6TRF4lKHQ4CCMeqd3IHFIZ9r1kRnbVnvRyeecx8jmviqtAfd4wr2pV+njOGwReSBpPvaNGYCjNe
	JqIZiXfSkcikNc9/U3me1HYKo2UuXYBF3hxwwopbxS7cPFg9rBcEdbNEPPvplZnpbvnb3E/o0RI
	o/wVLNrRpMoKzufS7nuStxMaDwGOVvyba0rj1CDnMxsfP550yiKZItmubgbNTSKlJFJNoVxPg5D
	/rwNHcIJ8MXm2WUELpBQJaWvKZWlz1denl26YXkOvWiqxCLOieI2jpwJjdA2sIifM+060vXDFJE
	=
X-Received: by 2002:a05:622a:5cf:b0:516:4f62:85ee with SMTP id
 d75a77b69052e-517223b0ecdmr7990661cf.19.1779985142931; Thu, 28 May 2026
 09:19:02 -0700 (PDT)
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
 <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev> <CADXeF1HRe=U7aWx2yx6RFZ_uH-mMbdsxMheofr2tMD9wae46oQ@mail.gmail.com>
 <6083831a-dc6d-42e4-a1c8-8b7f6b966650@linux.dev> <CAKD1Yr32VMefwq7Bo6_hmhFrDVsttNFwZJZcaXS4P-ACOwWobw@mail.gmail.com>
 <CADXeF1EWY0=TyvhFap3iyKdpHNkk5pZuHD-RDnXuqMa5LrNJ2Q@mail.gmail.com>
In-Reply-To: <CADXeF1EWY0=TyvhFap3iyKdpHNkk5pZuHD-RDnXuqMa5LrNJ2Q@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 29 May 2026 00:18:23 +0800
X-Gm-Features: AVHnY4KqO-LYOyvwglTe5XXMvZnX3bL1FOeWTgsNanJEKjebhIA0UQKFOY71MtE
Message-ID: <CADXeF1EwaZ+a953KOW4d5cU7f2GWiTNn9LKbEgHHXa2XxmXNeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org, 
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
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-292763-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,iogearbox.net,kernel.org,lunn.ch,google.com,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BB0235F533B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>The fixes tag should probably point to 053c8e1f235dc or a subsequent patch=
?

>bpf_mprog_query() and tcx_prog_query() were only introduced there.
>How come your userspace passes shorter uatter to query newer
>BPF_TCX_EGRESS attachment?

btw, If there is a strong preference for the BPF_TCX_EGRESS type,
specifically, that userspace shouldn't send a size smaller than the
newly added structure when using the new attchment type, I can modify
my patch to limit the fix to the BPF_CGROUP_INET_INGRESS type only. I
do agree newly added BPF_TCX_EGRESS and the existing
BPF_CGROUP_INET_INGRESS worth a different discussion.

On Fri, May 29, 2026 at 12:01=E2=80=AFAM Yuyang Huang <yuyanghuang@google.c=
om> wrote:
>
> >It seems you haven't convinced Alexei in that thread.
> >Attached below.
>
> Thanks for the test program. It proves my hypothesis: you had to
> manually unmap a page boundary to force that `-EFAULT`. The part that
> is still under discussion is whether there is a kernel bug or not. I
> think there is no question about the behavior of when the -EFAULT will
> be triggered.
>
> > To avoid such stack corruption, you should reserve enough space for the
> > query, e.g., by extracting union bpf_attr from kernel BTF vmlinux.
>
> I agree that your suggestion to extract the layout from BTF is good
> practice when writing a new program from scratch. However, our focus
> here is on maintaining backward compatibility for existing binaries.
>
> I think the core question is: **is a 40-byte query a valid request or not=
?**
>
> From my understanding, under the syscall ABI contract, passing a
> 40-byte buffer (at least for query BPF_CGROUP_INET_INGRESS which has
> been stable and supported since 2017) is 100% valid and legal. **The
> kernel must never break existing userspace on a kernel upgrade**.
>
> One example of a syscall that maintains such backward compatibility is
> openat2. The documentation notes it as follows:
>
> EINVAL size was smaller than **any known version of struct open_how**.
>
> If this bpf() syscall want to follow the same way to maintain the ABI
> contract, your `mmap` test actually let kernel return -EINVAL to a
> userspace program that passes a 40-byte buffer (declaring `size =3D
> 40`),  because the kernel unconditionally tries to write to offset 56,
> which happens to be unmapped.
>
> Are you arguing that the `bpf()` syscall does not need to follow the
> ABI contract to maintain backward compatibility, and that it is
> expected that newer kernels can break binaries compiled against older
> kernels? If you believe that all binaries must be recompiled or
> dynamically updated against the latest vmlinux BTF upon every kernel
> upgrade, please be explicit about it.
>
> Thanks,
>
> Yuyang

