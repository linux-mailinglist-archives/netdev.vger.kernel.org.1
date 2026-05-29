Return-Path: <netdev+bounces-293264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ks9K5n5GWqN0QgAu9opvQ
	(envelope-from <netdev+bounces-293264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A8A608A32
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F05302D0B4
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC37409E16;
	Fri, 29 May 2026 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz4fwJ/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7243A8734
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780086998; cv=none; b=mTMduMzb4hDaE+LyCLAnPUypRATGo/jVotjMIrtIKBdA7c9chrU+AcwSm0neY77iDjJXxpuupHhHa6riP1C7EBkiY6nicYp/Aj24ucV529iOtS+sHWDEpxcmowYB6Bl2Moj3Uc/VNw339sXSoZw6kPJS1wmbX7BCImvSDr75bH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780086998; c=relaxed/simple;
	bh=iQNyPSB6d4pRiCH+WP5fQJzoEg3EGVgrTx0xcFYHvCs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ckrZBcPPxd8RIc81YezPre92PiIrMzWfvZhWvH33BkxWfpHjllGeVfRvX9gNJZCzI/gfwUOnihRoxZLyKemU0tEVXBLFjjeXeukZu3Hm8gcFkEYb6VRnOCAsgIQSaJmgVQteD9NHgbI03uDYpWDbedZWNYe0rt4r6l61jOv+//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz4fwJ/Y; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e5fd39cf11so7004984a34.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 13:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780086995; x=1780691795; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/dZIPQs4IpSSy6mNi2UlIteDsWuWh8/BhCXqaiofzE=;
        b=hz4fwJ/Y5FWns2VZpClGk7XG3rEM0K4QjryTwxpXjr92kecDDjcQBQPx2ii0SjOvwY
         ef9b3pI0CBb9fshM8haK9IGNu/M7GcRPl7OIVuGgRmlYImRwXjkWRQ4+efn9p49aZkxS
         oYfOc4vR4p3XQX/dgYK8zMQ8TgkjvUuik9kQ3guYkJHODqRWTdPlrkGiVKuD3Xc+fk1h
         vLP1FdF3M/nd4HzwWtJ0LcyncAKOjdo4YXx5hZ797IhqLXo267zqTvKr4FidvsRlBRDK
         Ao4spF3iSaQVSnrTHvkMoeh9qpT90SybT3eaES++37rN5VJKL9zoBaRt2iTIvMmpYSri
         +QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780086995; x=1780691795;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/dZIPQs4IpSSy6mNi2UlIteDsWuWh8/BhCXqaiofzE=;
        b=AsVwEJ15Xwe5hTZhNSf1XihBGfiLy59YYW0dK2N57+UYw8qePc37NqvqbSFuFZcJOe
         pZdZCOlSOvOSwx8xw/5TDBxypY661d2SHIu/uCXNJ1IY6WjhztLSMHdTP6yhi0MiZmgZ
         YwK6yyJVQKJPE6PgrESJXkOZePlzK/WjDjF074wGAPwLD0aq5akKZg+symLqpXoyPEtZ
         a8/4At3iXphzd8FnXZoIcmT4mEy42dR9F2C+0xJ7G415qbx25ekuYnATmV29TRQkZkRL
         uvExLdg3ls59/NeF0WV4pfHskTyZ7t5x1CdqlsY/I+tvAVtoP0z3MISxTgqVQU/fg09Y
         iAoA==
X-Forwarded-Encrypted: i=1; AFNElJ9XVcY5QEZJt7BIyan6y/PqnaNUmVBslaGxX+GJYlImFN9r4slWCkCAfMjwexYZnGzPX+SzeQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANamyRM87fyqiC1S92LtIc3r/I3wpfTytk/kdFcxKJQdblcN3
	AFVnCTeZ5Jh40/rslPQN3FO9KcFOw3Jjm95FLFW+pn58gnJjx/BgCG0V
X-Gm-Gg: Acq92OEI1N1UkH4naP6IdswHNhrk6MSkFrI1VhMS6OnHLWvaFSaCad+eyqQYB7CoqqJ
	hli1m1WRGq8hcmPkVek3sXvpvjMfiwi5ja+yrmCQuzzBUcpVLQKv/4LvCNiSmPs1HnDq2V8leUQ
	yphmFaTobCIl4ej7I3Y9XQVTzf7fU2I9lW0Q88Enaq0YqiBVS0E1YOA8FWjmBg206DmNObIE6wX
	SnaRrqTcm/v5Q8mV7ZGfHYiqnvSQs/yiqSx60N+9Byam4ZijkD3aeF10an9XnUpztpuV0Z8llND
	8Szx8RHPsbv7+FVHHbZETH+cGQx8MRrWPg//dJMSSHNuAK9nvO1qmDnIIRbmctk15li/dhwNElT
	WiHwQx4mn3WIAz4+7qCXSmBcGLo6FoQqU2DUMzOc4y0/vZV9T6HLjS9p/bcOu15e4UQebMWzLBo
	z+9Lvbi5VUKpqyNmm/hLGFVvhQHVlsP+M8EotV0UpS7iDcLhv/BTALKFrVbBKM3Gbv5QpDaEeWP
	2OmKAFb38jgIh25YU2/2IuUCyC3
X-Received: by 2002:a05:6830:4884:b0:7de:a2cc:9dde with SMTP id 46e09a7af769-7e6a1df5c12mr902807a34.15.1780086995443;
        Fri, 29 May 2026 13:36:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695bb393bsm2116002a34.7.2026.05.29.13.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 13:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 13:36:31 -0700
Message-Id: <DIVG6ANND95G.2MC7WWJG1P01A@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, <bot+bpf-ci@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard"
 <eddyz87@gmail.com>, "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski"
 <kuba@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Nikolay Aleksandrov"
 <razor@blackwall.org>, "Paolo Abeni" <pabeni@redhat.com>, "Shuah Khan"
 <shuah@kernel.org>, "Simon Horman" <horms@kernel.org>, "Song Liu"
 <song@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Yonghong Song"
 <yonghong.song@linux.dev>, "bpf" <bpf@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, "Network Development"
 <netdev@vger.kernel.org>, =?utf-8?q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, "Lorenzo Colitti" <lorenzo@google.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, "Chris Mason" <clm@meta.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Todd Kjos" <tkjos@google.com>, "Carlos Llamas"
 <cmllamas@google.com>, "Kalesh Singh" <kaleshsingh@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yuyang Huang" <yuyanghuang@google.com>
X-Mailer: aerc
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org> <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com> <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com> <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com> <DIUR88219HWQ.26T4D7ZX8CNTC@gmail.com> <CADXeF1E-QpKj-37T5ghiycXrVR_YN72fOc3M4OQg-Arz7JNjsQ@mail.gmail.com>
In-Reply-To: <CADXeF1E-QpKj-37T5ghiycXrVR_YN72fOc3M4OQg-Arz7JNjsQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,lunn.ch,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 38A8A608A32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu May 28, 2026 at 9:44 PM PDT, Yuyang Huang wrote:
> On Fri, May 29, 2026 at 9:03=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon May 25, 2026 at 12:21 AM PDT, Yuyang Huang wrote:
>
> Thanks for the reply.
>
>> Ok. This is fair. 120933984460 is indeed problematic.
>
> I'm glad to hear we agree that 120933984460 is problematic.
>
>> Not really. Your patch adds checks to what looks like "random" copy_to_u=
ser()
>> places. This thread is clear indication that it's not a "robust architec=
tural path".
>>
>> True robust path would be to wrap every copy_to_user() into another help=
er
>> that takes uattr start pointer and size, does extra check, and
>> returns something like ENOSPC (and not EFAULT),
>> but that would be a significant churn.
>
> I agree that the truly robust path would be a proper copy_to_user()
> wrapper instead of doing the ad-hoc check in the current path, but
> indeed, that will be a big change.
>
>> So I prefer a minimal patch that add single check in bpf_prog_query()
>> that checks that user space supplied buffer is large enough for attr->qu=
ery.
>> If not -> EFAULT. That would be better than overwritting.
>> One can argue that partial copy_to_user() in __cgroup_bpf_query()
>> should still be allowed, but I'm against partial and
>> inconsistent queries.
>> query.revision might seem benign, but if we do it for all copy_to_user()
>> we better return ENOSPC to differentiate vs EFAULT to tell user space
>> to fix itself.
>
> Okay, I understand the preference is for a minimal patch to implement
> the fix. Just to make sure I fully understand your suggestion:
>
> Are you proposing that we add a single check at the entry gate in
> `bpf_prog_query()` like this?
>
> ```c
> static int bpf_prog_query(const union bpf_attr *attr,
>                           union bpf_attr __user *uattr, u32 uattr_size)
> {
>         if (uattr_size < offsetofend(union bpf_attr, query.revision))
>                 return -EFAULT;
>         ...
> }
> ```
>
> If we implement this, I want to confirm if you are okay with the
> consequence for legacy cgroup queries (e.g.,
> `BPF_CGROUP_INET_INGRESS`):
>
> 1. Before 120933984460: Legacy userspace compiled years ago with a
> 40-byte `bpf_attr` layout (ending at `prog_attach_flags`) regularly
> queries cgroups passing `size =3D 40`, and it worked perfectly.
> 2. With this check: These unmodified legacy applications will now fail
> with `-EFAULT` on newer kernels because they pass `size =3D 40` which is
> less than 64. This means all user-space applicaion is expected to
> "fix" their code when along with the kernel upgrade.

I bet you fixed your android setup long ago,
so all of these "but what about backward compat" is getting annoying.
Whatever kernel patch get merged android won't even backport, so enough of =
it.

> Is your preference to explicitly fail these legacy `size =3D 40` cgroup
> queries (breaking backward compatibility for them) to avoid "partial
> and inconsistent queries"?
>
> If we want to keep these legacy queries working safely (without
> failing them and without causing memory corruption), we cannot use a
> single check in `bpf_prog_query()`. We would still be forced to plumb
> `uattr_size` to `__cgroup_bpf_query()` so we can conditionally skip
> the `revision` writeback when `size < 64`.

Replied earlier that I don't like random checks like this through the code.

