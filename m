Return-Path: <netdev+bounces-46922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0C17E714A
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291A0281102
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C232C30322;
	Thu,  9 Nov 2023 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWVZfaJn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E82F358AF
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 18:18:58 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9DC3C01;
	Thu,  9 Nov 2023 10:18:57 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso8749275e9.2;
        Thu, 09 Nov 2023 10:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699553936; x=1700158736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OWgafj54kevub5QuwjRLgVnCD0p1Q643A6n3V1pcLs=;
        b=fWVZfaJnUzoUZr4Ss3pGHTGTM0fhPKQ9uTl1nE+Rwxx0LqM4Ekk6yt0w2K13CUmtxd
         OhZeYhjufqh20cz/m7ksBrj9Ws2RBsOhrRM3CKNtKXIK3LLS+9nyx/V6eD18Ur7tMUfx
         dSIfVz2QHSIXPygNxlhNFixWAvYLpPTSjP5OjvNwLoLh9CvxVIfaiMYZiwzjpgfnbT5h
         zIGQh0Iht0U6l7UyAqW3j4WCsuH51fBzipkNsvX/Mg6vMfR0o/ZG3U8Y6dcSOP9qH5RP
         Vm9f579zqYVbn4/boQDNnf/f+PRI1FowJfDjw/5YpigwYhDq2Oe0saawwpq2xxCLGxnD
         5+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553936; x=1700158736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OWgafj54kevub5QuwjRLgVnCD0p1Q643A6n3V1pcLs=;
        b=KYi6wRv0iy8KNOPvUAWSfLb+xxFbdGL9YapKajBlCXLs1RtCR9dsJLpenBGSt1jurn
         VifGsUcx4ZcmAF+XfQ0NR2Exj2cV9RACppIq1lt2rNaqBLFtWpZu+MX97v71OTJxo6fp
         Ir+y0oFmuOHRkQyyZfspizeifgdpUVu46yUQmUKdUsN6UP+G1eSUBPfp9uGQtojDTcTB
         48U7mCSUM2Qj0ao28Uc/u6PjOZZGRBaIjzNAO9IwxR/fsiHR0JrzEpCeGXIJqY5+DUm6
         Oz6Yx5xaLq49P6PGUNVn8dHcWokmvRk3e6maKe8HyjmHNQ8+SCFSxcGJQU/3Ztq0Nqtn
         9jOA==
X-Gm-Message-State: AOJu0YxHU05G16Beseq3LckHLxz1Cho/sofCFBbA4V2tXzMIWmqj64vt
	3289FUosUb+BS957RQWEwhhM9tScCVPAnxCJSH4MHsRS
X-Google-Smtp-Source: AGHT+IGNrM2VrtZCZ1iHG5iS61vpmfGmwZVJvAETUSs+vsptLcUC8HAIxyHy15HIsMm1QPDzOJ/pe/I6pdKEQtA93jo=
X-Received: by 2002:a05:600c:524c:b0:402:cc5c:c98 with SMTP id
 fc12-20020a05600c524c00b00402cc5c0c98mr5012274wmb.13.1699553935748; Thu, 09
 Nov 2023 10:18:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028011741.2400327-1-kuba@kernel.org> <20231031210948.2651866-1-kuba@kernel.org>
 <20231109154934.4saimljtqx625l3v@box.shutemov.name> <CAADnVQJnMQaFoWxj165GZ+CwJbVtPQBss80o7zYVQwg5MVij3g@mail.gmail.com>
 <20231109161406.lol2mjhr47dhd42q@box.shutemov.name> <11e2e744-4bc7-45b1-aaca-298b5e4ee281@linux.dev>
In-Reply-To: <11e2e744-4bc7-45b1-aaca-298b5e4ee281@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 10:18:44 -0800
Message-ID: <CAADnVQJtc6JJZMXuZ0M5_0A3=N-TJuYO2vMofJmK6KLhWrBAPg@mail.gmail.com>
Subject: Re: [GIT PULL v2] Networking for 6.7
To: Yonghong Song <yonghong.song@linux.dev>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, Hou Tao <houtao1@huawei.com>, 
	Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 10:09=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 11/9/23 8:14 AM, Kirill A. Shutemov wrote:
> > On Thu, Nov 09, 2023 at 08:01:39AM -0800, Alexei Starovoitov wrote:
> >> On Thu, Nov 9, 2023 at 7:49=E2=80=AFAM Kirill A. Shutemov <kirill@shut=
emov.name> wrote:
> >>> On Tue, Oct 31, 2023 at 02:09:48PM -0700, Jakub Kicinski wrote:
> >>>>        bpf: Add support for non-fix-size percpu mem allocation
> >>> Recent changes in BPF increased per-CPU memory consumption a lot.
> >>>
> >>> On virtual machine with 288 CPUs, per-CPU consumtion increased from 1=
11 MB
> >>> to 969 MB, or 8.7x.
> >>>
> >>> I've bisected it to the commit 41a5db8d8161 ("bpf: Add support for
> >>> non-fix-size percpu mem allocation"), which part of the pull request.
> >> Hmm. This is unexpected. Thank you for reporting.
> >>
> >> How did you measure this 111 MB vs 969 MB ?
> >> Pls share the steps to reproduce.
> > Boot VMM with 288 (qemu-system-x86_64 -smp 288) and check Percpu: field=
 of
> > /proc/meminfo.
>
> I did some experiments with my VM. My VM currently supports up to 255 cpu=
s,
> so I tried 4/32/252 number of cpus. For a particular number of cpus, two
> experiments are done:
>    (1). bpf-percpu-mem-prefill
>    (2). no-bpf-percpu-mem-prefill
>
> For 4 cpu:
>     bpf-percpu-mem-prefill:
>       Percpu:             2000 kB
>     no-bpf-percpu-mem-prefill:
>       Percpu:             1808 kB
>
>     bpf-percpu-mem-prefill percpu cost: (2000 - 1808)/4 KB =3D 48KB
>
> For 32 cpus:
>     bpf-percpu-mem-prefill:
>       Percpu:            25344 kB
>     no-bpf-percpu-mem-prefill:
>       Percpu:            14464 kB
>
>     bpf-percpu-mem-prefill percpu cost: (25344 - 14464)/4 KB =3D 340KB
>
> For 252 cpus:
>     bpf-percpu-mem-prefill:
>       Percpu:           230912 kB
>     no-bpf-percpu-mem-prefill:
>       Percpu:            57856 kB
>
>     bpf-percpu-mem-prefill percpu cost: (230912 - 57856)/4 KB =3D 686KB
>
> I am not able to reproduce the dramatic number from 111 MB to 969 MB.
> My number with 252 cpus is from ~58MB to ~231MB.

Even 231MB is way too much. We shouldn't be allocating that much.
Let's switch to on-demand allocation. Only when bpf progs that
user per-cpu are loaded.

