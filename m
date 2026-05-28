Return-Path: <netdev+bounces-292752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GduNXRvGGp6kAgAu9opvQ
	(envelope-from <netdev+bounces-292752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F5B5F5172
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE2F73383B29
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13D423A6C;
	Thu, 28 May 2026 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0L2C5OB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16B423148
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984104; cv=pass; b=JGShSt+ZZHHweSwJ8BfW1vPwfirK5+CeDYcGgWh/duuj9hMidlhcycLE1KSGdqEddYRZkoI5pD0iUYYoHy5oIO28FIzAIDxqQC1oHJM4ylAknwGLUR7wDGC52OcD4HNKUfnkMf05hrHfsIv+lPjvzpmvxH5EZOwxzNSDWJNTQi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984104; c=relaxed/simple;
	bh=HoRv3ITsVYotYbByUgMqXQNPFv0UOt3EzvZpSuUdf5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH/qHQFAgnYSWmAxV7zF/1SOkCDdD/AW2R+JWiVPd/b4/fcpD2KHo6b7yEFmJSOlzJb046tFIgz2L18BUuehx2zaIrlNiDOAnQpo/7w5gBs25hhPnZ7c0j1PIqEk74Mw07TKz8GEO6lILHmksakw219XPwZJuapXP2TTLWIwvgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0L2C5OB; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516d1ddcdf4so13051cf.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779984102; cv=none;
        d=google.com; s=arc-20240605;
        b=I8mgdn6Mr8uZxLYGvjo5SGTIw3HeOr1RZvnXCw6f13gSYM57YFoV1k1f2YJ1OB+Ar4
         lo46+19VQLzUsl11sFPdC+JFSGLkO4qYmzVoHpD6ADEpT9VQw+kpYibzSiWcSJ2NIMoz
         46igeaWElJpPOmEsyO47WQGzkklGm1sURk+a9EYS8o3NUQPwWmS42plIeOtQKe925iwo
         zruXaakpOrJji8HFzLPTmU3afOBil8NUcF2LIfkJLZNiP2jECyJACArP8kxZOo3EDXL5
         C8Y/82VYZcvE6yBed+PbqMCxEvlHb1TnLIdODi9Zm5RmdIM32DKl3/WocTzvcgXn83c0
         +qaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BYsaex7hgpDTcxP9G0jUXkwS6mGFhA1uEqhqBMmQ8iA=;
        fh=WP0OLf7r9DS1CcsXofT/5rfWcibF2WiYhSDWzzqwFk8=;
        b=Kpji7ck5jr7v7TlmsHCaz9uRPl/HV+xZ/CL5A7D3/S6e0yXvVPYYC07pDkXmtkrr1m
         ujsXioNHyC29tRIRic5aZHj+tmN9RisvHDurTxAu59WhAKTXGia1Cs+U6YYrW8pB4n1i
         tmT/KHRxHkD/LXTeSz4CDi6k0Jn4Uw0aRlUSbKbJH2a4ykjpvZKzbC8QWlVhQlwefG2/
         zP8uN09Iw5XlQ3rvvaErx0khT1N9bLeRXZysnMBM+ZfJPdsTMu5pPi15j7eRN0YONpx+
         UFeXX56rg5rewJXs8Azdr0x1ENl7blgknalRZ3YN2haD2/90VI4HxR17JQPcNi0UhFIn
         Pt4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779984102; x=1780588902; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BYsaex7hgpDTcxP9G0jUXkwS6mGFhA1uEqhqBMmQ8iA=;
        b=T0L2C5OB5eyKIPzMHsiPVQNr1viCSihOUZmkYUM5cGPXkhMxoJ6M3OzSgpCKFExWDy
         szdyZoMpD9zxcItskA+UbPBxYHZTegez2MJySasSWzj6ryqYLVVBCl81AJjBJxO1P++U
         FtF5D4uKoHrnYsSr5CM9DRAXsFIeVDwgWTITtrt7fuuylaTUZDyK/JH8UvpmtIpQGdlK
         aYIgu51EvAqaxzk5pXAAJYZHODvlvxsKYeuG1EG5o5/LO5RAwLEQsF+iPzqDwBe1x5C1
         zEotfoDoz5fHx8B5n808J/IFfRdT7t5Z47BjvXsew4l7v5kLJ0ZNvmwtUDI415N7ev5s
         n8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779984102; x=1780588902;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYsaex7hgpDTcxP9G0jUXkwS6mGFhA1uEqhqBMmQ8iA=;
        b=FWS8gdq1BK4WRLN8llnEbuitcpqjzFfsD7KglkUiWPC+Itehc+imzusLtfQi/OSmAW
         GQv7PjSIvzeACZwJdBZnhRWsm5dQxk7eQTa9tHZWkDKjDmBzcEBi73rN+HhPrm/qfHXf
         OpBUARrB+j++RkaTTF2kfNO227axOPmITutgqGx9NzYJO1AM6nXwlIRi7+wShe4DiD+Q
         pfeUOVvoBWv/dtEFIW/ithbtRWcVmMMdoL0piY/u5/lDXGOdI6Zodr4F0jM22a9Hkkrk
         ICrdc/uxXE3BPAgwnhxFJBji9YBEfFmee615w80ue87BCkgCgEzAxMrP5NvSAkUsV/QZ
         4DbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RkgaK2DgW6x0WXlf9NAtCX2QsusyOSYV4XmguXztTCe1wNXX/IhSmjg30L6SUfQuo2pdwIzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTK3npDGZvTLyl4hXwfAasQZ1U8yeshGKZ7Sid0A5KSaFc6CgE
	DuZ9Qkr/Os8nSTmtnhh8+WXr5iXtLQQrix1yPFF9sxK3XaBoEdPf4tOWeTFGm7w5YQwWIfg/1il
	g/zDaTISTCosUNZz8Ylm/fIqaVq6VuqT6AR56P6aF
X-Gm-Gg: Acq92OHXhSXOy3VRMCpEII8uwk7LwOQh+De6MNzWwZpQj/6IWCo2pM9YfbkMvR2gr6J
	y7cyzgAx4xLPznk2DVghSUxoJo1SCtqq6fjyKrUOZCczgzZuhJxuSNlSht85cVSnSuxmnbS1Lv6
	aowsxWCwXiAwfmKYTHr1kO5yMdKw0f8mmVpQvlP70zglzXSFz/sR7ymYVoyFxGITKlKAwZHVfXm
	dzxQXYX/31kcLtLMXGZFwlOwFJX7IHneJcJPNGmMJEzZv8ISx+dz7HzTTO1DS6QPdrtp9uoX9t9
	ksOTcpsohZkVAM0G8Kjolspop4Nl2DJGuB9FJG96o/zqSrj8hi5r6h7lv1Fw7Jod
X-Received: by 2002:a05:622a:8c02:b0:516:5709:45e5 with SMTP id
 d75a77b69052e-51720af90damr6978311cf.14.1779984101530; Thu, 28 May 2026
 09:01:41 -0700 (PDT)
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
In-Reply-To: <CAKD1Yr32VMefwq7Bo6_hmhFrDVsttNFwZJZcaXS4P-ACOwWobw@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 29 May 2026 00:01:04 +0800
X-Gm-Features: AVHnY4KYoAqz9rUtz8nGlc7zWjwvk4SuqM2I4D6DnfwQvY05GaYxUOEso4as720
Message-ID: <CADXeF1EWY0=TyvhFap3iyKdpHNkk5pZuHD-RDnXuqMa5LrNJ2Q@mail.gmail.com>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292752-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,iogearbox.net,kernel.org,lunn.ch,google.com,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 52F5B5F5172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>It seems you haven't convinced Alexei in that thread.
>Attached below.

Thanks for the test program. It proves my hypothesis: you had to
manually unmap a page boundary to force that `-EFAULT`. The part that
is still under discussion is whether there is a kernel bug or not. I
think there is no question about the behavior of when the -EFAULT will
be triggered.

> To avoid such stack corruption, you should reserve enough space for the
> query, e.g., by extracting union bpf_attr from kernel BTF vmlinux.

I agree that your suggestion to extract the layout from BTF is good
practice when writing a new program from scratch. However, our focus
here is on maintaining backward compatibility for existing binaries.

I think the core question is: **is a 40-byte query a valid request or not?**

From my understanding, under the syscall ABI contract, passing a
40-byte buffer (at least for query BPF_CGROUP_INET_INGRESS which has
been stable and supported since 2017) is 100% valid and legal. **The
kernel must never break existing userspace on a kernel upgrade**.

One example of a syscall that maintains such backward compatibility is
openat2. The documentation notes it as follows:

EINVAL size was smaller than **any known version of struct open_how**.

If this bpf() syscall want to follow the same way to maintain the ABI
contract, your `mmap` test actually let kernel return -EINVAL to a
userspace program that passes a 40-byte buffer (declaring `size =
40`),  because the kernel unconditionally tries to write to offset 56,
which happens to be unmapped.

Are you arguing that the `bpf()` syscall does not need to follow the
ABI contract to maintain backward compatibility, and that it is
expected that newer kernels can break binaries compiled against older
kernels? If you believe that all binaries must be recompiled or
dynamically updated against the latest vmlinux BTF upon every kernel
upgrade, please be explicit about it.

Thanks,

Yuyang

