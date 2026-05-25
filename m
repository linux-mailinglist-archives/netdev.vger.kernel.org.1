Return-Path: <netdev+bounces-291246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCDpFtj4E2puHwcAu9opvQ
	(envelope-from <netdev+bounces-291246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:23:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D12955C7146
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F49030048E1
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B243D1AB5;
	Mon, 25 May 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4Xd/IrL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2D3D1A81
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693740; cv=pass; b=unHKqzeOVabnHOfTQhXm4y3eIC7lO8VFyuvLE8K30rCq7D+GOsUNIVjOn0K4bSG+tBEyEvTOxecB/84ORJns6d0deBHJrSSi2mirwWNBQIb9E1tKQ8lC7Kj3QErdN0ZSfMs/hZ8gkVI94PzjsvK+mXFiGq6lpL2w0Y/J9+nqejM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693740; c=relaxed/simple;
	bh=X+7djYcP9GEagwqG8m/X7AI21c2H+orZX9PlTDd1uts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkiBE6zPTLz12YXCgDqenO2G+mcw8CtOXv344wd1iCc/GXBIApRyD4dVT9J2QXXAqgXmWw+YGy41MrI4o49GQQjff6Uz5Dvq9d162JkSMNKACOONEdmpaV1luteqd2G+A6Kgv3ldKLpHUQM8RaGGF8dau7pSOcnNxOzTKjx6J3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4Xd/IrL; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-516d1ddcdf4so5781cf.0
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779693738; cv=none;
        d=google.com; s=arc-20240605;
        b=HHd69zpN9VruzO8bKtZxiUOGrgcee+G79XMLzJmZhsWxb3cohZh+EWcCqK1a13ZH+D
         8QySSJmvBZfcMPRclfctOUyd50otgQUckOedzb6pjqsJLBlbXDB7jH1KrHrdtkkE4XL6
         Qd3X+XSC5Hhr+/W3hQZfgeXJhiUWQIwSmOSvVQnUgj1DHZAnh/DjjMf/bvDVYnUcoI4Q
         uevzNB4eURwEXN5zNVxQg8/iE4qQoF+7NhqCuKyKt9yI/mjNyjpp3AexXaEVTGjcuE0p
         QN1f+VsEKep4QN6qGyu64BCDnoXQrIPxjzkF/hKZqcc8aUoDPts/wOrBRTFwZuCGpugg
         Hadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y5njTe4srkYzXCM80V2lfRLC7p2SgEf5NieyXgBYSB0=;
        fh=u/Pjd3mLQF5oiX4rphkB/f0S5aBCy1jaYysIh275ph0=;
        b=iQmzUhUsYa1p/fnfn+Gye5zc+/rHKOX5MydkjZF1AUN6BoDsYZ9FNEIS0B59/bggMh
         rWT0KH1xFcXzOIQxy8tQvoXZp+H+UK8oBpVJjDgursnGYL8OtfnUwsavgN5dkkayHLXf
         wqq8HcSsX4zZ+4x46nVcER0ZXkKABa7nd11gV0lMfurggqES+17OIFNQh6dkfvLEk+dN
         Ef0Bndj0RaVgAby1s+9MGp2jZJWA8SF1kiIDN9XiJx6Tbci2tTH1uVxkd6E2lCeMpqpi
         Fg6bLXRGOaO93tXHf2psgfU6RrPIMMxPwxnD5ChSK49QhECRiFm7aJeLyrs6H3lxhhqx
         cQWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779693738; x=1780298538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5njTe4srkYzXCM80V2lfRLC7p2SgEf5NieyXgBYSB0=;
        b=b4Xd/IrL+T87r+U2VbjRDAUuzMG7zz3EI/yzK9pbyJfpgbMR+GLEW0CAdcVnFJ7UDi
         1IHrmhfzzTBAzfb/YUsjOPEd19qhEubDheoaRCmTyG6W6QXG5YQ1EC+dlDcgE9FryAtq
         hSeoGGhXUvFYeWl6UyAgL39mlYCNNFPnEsKgIkvujjk7HJ3vKjlTUR0YRssRDJcPu5RC
         AhzFpptixYNG8SX9fRQXpxpNtZ85rBdhX8JjzyLAl3RRR1gvdN8GCXrZwFJ3iB0tAqT6
         H5KZjBWH3nNRiGmTitP9VJex3NtwZjqkFrp6izdFokwBglZx4cumcWyJWCgr2ObCfBPw
         5rPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693738; x=1780298538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5njTe4srkYzXCM80V2lfRLC7p2SgEf5NieyXgBYSB0=;
        b=gHdqrmMY5kFuwuUaqlZHe1kq5kz4pPG+pTf+LWdcMX+x8t0vUjTk5tlWShENEfxAiF
         GJ10MBJez4zdHjTpLC4bZ0lJZUrkXScBFElbVB9AR1wDP/p+uLg2Wc15V6D29tuvIzAQ
         2FlHJuFKb5XUuB+cN1EWVhVbgJipaFXQK4zmvK/CIDqJgaWKA8AXdvmzPtukeZLH9fme
         3azLwat1+rm6wV7KRjF879piDxqx+ZCs1IDg3yM0BeWZcoafrjkZ33eOchkyqMidp8kI
         H63NygvpSr0VIKUIIyTGtrNRkWUsgVUB5rwG1mpzph2ln4hMsn5NNiQ6JzSiv82xl4aa
         pDAg==
X-Forwarded-Encrypted: i=1; AFNElJ+cDJU9QIgdRN/zt9FCNJ/YLnKEmcxfjGYdf8m27cG52FYuxTINnhCvppuT5Dt0g0SvdxelhbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpbb03lwwmlRH4jv6Wz8Rs+NP7HTCHGSwLnx58nRMnBaOE8YyT
	Nlsm8ZOU6Y0DSb4ezCKrNf1uw7nFSj1JZvVacu/MDfv7vi0/4IBlyele2fqkDEUR9ch9EhBj7M/
	KEi92JY7hn0f/CHrxcwack6sEt8EFfmyygW8Of/pO
X-Gm-Gg: Acq92OFRvSXOj8sSg5z0eC6pUhb4U9556kWW5gNZNVKVPF7CfrDphADnJEuZ/yLV2Kg
	gWMRTLIHsz8Gpsrs96eJg7lFNn2Qi5juh6mbyE92+7/sDrYBNt54Y1SeNMlmjiD32nCLM+FTT6I
	KtoKA08jSZUdumjXY5KZi0Qs7XjPfq7VRtOxCaYlVcts5lqgTp4Sg9i2FZUVweP4enrJyoUc129
	3KkxtJ767EU0Oi8jCtYlQvq+/QhhlPgF+nSoZ6D+Av5qbmhGkCxOPZ/wMYFtZOvAb8py7U/lgbt
	G3RFO6s60YxvZgh6CM684zIBMy6SHGUmTKPiJuswRewfKJchXnFKVVUik2NUJfXeXV8gSPG3lAM
	KVKtg6A==
X-Received: by 2002:a05:622a:201:b0:50e:595d:164 with SMTP id
 d75a77b69052e-516e0cf98d8mr18186391cf.8.1779693737022; Mon, 25 May 2026
 00:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com> <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
In-Reply-To: <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Mon, 25 May 2026 16:21:41 +0900
X-Gm-Features: AVHnY4JA9Kqb5fOY7fSO1LmnGe3xgrK64F2oWnLs97m99yzTrV6-pG4BIKgY5OA
Message-ID: <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
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
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,lunn.ch,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D12955C7146
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the review comment. To better explain the problem, please
bear with me through this long email reply.


>AI is wrong.
>The fixes tag should probably point to 053c8e1f235dc or a subsequent patch=
?

Thanks for pointing it out. I think the correct Fixes tags should be
as follows, and I will split them individually in the v2 patches:

Fixes: 053c8e1f235d ("bpf: Add generic attach/detach/query API for multi-pr=
ogs")
Fixes: 120933984460 ("bpf: Implement mprog API on top of existing cgroup pr=
ogs")

>Please provide more details.
>I'm still not convinced that what you're saying... is a kernel bug.
>Looks like user space is querying new attachment types with old structure.

I created a small C program using BPF_PROG_QUERY to query
BPF_CGROUP_INET_INGRESS (not the BPF_TCX_EGRESS) to demonstrate the
full problem , hope it clarifies:

```c
#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>

#define __NR_bpf 321
#define BPF_PROG_QUERY 16
#define BPF_CGROUP_INET_INGRESS 0
int main() {
    char buf[64];
    memset(buf, 0xAA, 64); // Set 0xAA signature
    memset(buf, 0, 40);    // Zero out legacy 40-byte struct
    *(int*)(buf + 0) =3D open("/sys/fs/cgroup", O_RDONLY);
    *(int*)(buf + 4) =3D BPF_CGROUP_INET_INGRESS; // Explicitly set attach_=
type

    // Call BPF_PROG_QUERY (16) with legacy size (40) on x86_64 (syscall 32=
1)
    long ret =3D syscall(__NR_bpf, BPF_PROG_QUERY, buf, 40);
    printf("Syscall return value: %ld\n", ret);
    printf("Revision (offsets 56-63): %016llx\n", *(unsigned long
long*)(buf + 56));
    close(*(int*)(buf + 0)); // Clean up cgroup FD
    return 0;
}
```

Before the patch:
  Syscall return value: 0
  Revision (offsets 56-63): 0000000000000001   <-- Stack/Heap Corruption!

After the patch (Safe / revision writeback is gated):
  Syscall return value: 0
  Revision (offsets 56-63): aaaaaaaaaaaaaaaa   <-- Safe (Signature intact)

For this example, the regression lies in legacy CGROUP queries:
1. BPF_PROG_QUERY for cgroups is not a new feature; it has been in the
kernel since 2017.
2. There are existing legacy userspace applications and language
wrappers (like our android net-tests) written years ago with older
structure layouts (passing size =3D 40, ending at
query.prog_attach_flags) that query cgroups.
3. In June 2025, Commit 120933984460 backported "revision" support to
cgroup queries, introducing an unconditional writeback in
`__cgroup_bpf_query()` at offset 56:
```c
// In __cgroup_bpf_query() (kernel/bpf/cgroup.c) - Introduced in 1209339844=
60:
if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
        return -EFAULT;
```

Now lets talk about BPF_TCX_EGRESS:

> bpf_mprog_query() and tcx_prog_query() were only introduced there.
> How come your userspace passes shorter uatter to query newer
> BPF_TCX_EGRESS attachment?

I understand your point, but two common cases exist where userspace
will legitimately query BPF_TCX_EGRESS with a 40-byte structure:

First, a generic BPF querying tool (assume it called `./bpf-query`)
compiled in 2020 (when the query buffer size was 40 bytes) might
accept the attach type dynamically from the command line:
  ./bpf-query --type 47 --fd 3  # 47 is BPF_TCX_EGRESS

The unmodified 2020 binary populates the struct dynamically and
invokes the syscall with size =3D 40:
```c
   ....
   attr.query.attach_type =3D 47; // BPF_TCX_EGRESS (passed dynamically
at runtime)
   syscall(__NR_bpf, BPF_PROG_QUERY, &attr, 40);
```

Without the size check, the unconditional writeback of revision at
offset 56 would result in an out-of-bounds write on the stack.

Second, in dynamic language environments (like Python), UAPI
structures are often declared manually. The developer might only
declare the subset of fields the application actually uses (40 bytes
in this case) to optimize memory overhead. Even with this subset
declaration, we believe the kernel should ideally respect the declared
size limit to prevent accidental out-of-bounds writes into adjacent
userspace memory.

> Looks like user space is querying new attachment types
> with old structure.
> Potentially the check can only be around:
>         case BPF_TCX_INGRESS:
>         case BPF_TCX_EGRESS:
>                 return tcx_prog_query(attr, uattr);
>
> to be nice to broken user space,
> but, really, attr->query.attach_type shouldn't be equal to BPF_TCX_EGRESS
> with a smaller uattr.

Add gating to the TCX path, will not be able to fix the legacy cgroup
query path. As shown above, the cgroup query path has the exact same
OOB writeback regression affecting legacy userspace. Since we must
plumb uattr_size to cgroup.c to resolve the cgroup regression safely,
applying the same consistent size-gating in bpf_mprog_query() seemed
like the most consistent and robust architectural path.

Feel free to let us know your thoughts.

Thanks,
Yuyang

On Sun, May 24, 2026 at 8:22=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 21, 2026 at 1:41=E2=80=AFPM Yuyang Huang <yuyanghuang@google.=
com> wrote:
> >
> > >This looks like a bug fix for an out-of-bounds write vulnerability.
> > >Should this include a Fixes: tag to identify which commit introduced t=
he
> > >unconditional copy_to_user() calls for query.revision without checking
> > >the user-provided buffer size?
> >
> >  > Fixes: 3fe213c040b3 ("adding ci files")
> >
> > I completely missed this checkpatch comment. I will add the Fixes tag
> > in v2 if there is a consensus that this patch is the right approach to
> > resolve the issue.
>
> AI is wrong.
> The fixes tag should probably point to 053c8e1f235dc or a subsequent patc=
h?
>
> bpf_mprog_query() and tcx_prog_query() were only introduced there.
> How come your userspace passes shorter uatter to query newer
> BPF_TCX_EGRESS attachment?
>
> Please provide more details.
>
> I'm still not convinced that what you're saying:
> "
> For example, our Android net_test  suite uses this legacy 40-byte
> Python ctypes struct layout:
>
>   # legacy 40-byte layout (pre-revision field)
>   BpfAttrProgQuery =3D cstruct.Struct(
>     "bpf_attr_prog_query", "=3DIIIIQI4xQ",
>     "target_fd attach_type query_flags attach_flags prog_ids_ptr
> prog_cnt prog_attach_flags"
>   )
>   # Invoked via: syscall(__NR_bpf, BPF_PROG_QUERY, &attr, 40)
> "
> is a kernel bug.
>
> Looks like user space is querying new attachment types
> with old structure.
> Potentially the check can only be around:
>         case BPF_TCX_INGRESS:
>         case BPF_TCX_EGRESS:
>                 return tcx_prog_query(attr, uattr);
>
> to be nice to broken user space,
> but, really, attr->query.attach_type shouldn't be equal to BPF_TCX_EGRESS
> with a smaller uattr.
>
> pw-bot: cr

