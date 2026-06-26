Return-Path: <netdev+bounces-302267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q3CSHN7kPmrAMgkAu9opvQ
	(envelope-from <netdev+bounces-302267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:45:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF26D0113
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 22:45:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Vgzm9yi6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302267-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302267-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E40E3005D06
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 20:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663FF30E858;
	Fri, 26 Jun 2026 20:45:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF33AD510
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 20:45:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782506715; cv=pass; b=iYbggHD1dzY6PcQO4jjgGccR37tSEakK6eUEK4GW4gntyrH1c9VGQvzqIjm8MRlNH+SGK5wrKAX248tQCRpdydAAUMkKHU1rw5ZPQW5d1ac0zqWHESiTW9q4BAYt3pL6782qzoWUIruj1q5pZ1BY2HX7Wm2yc7VOKE4ZkdwvWAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782506715; c=relaxed/simple;
	bh=HXwE5QE2AygpKQCNKUenfAe+L8jeFrlMx2EkQ7aQSiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ov4JVm3SHR2dGbSJXlCHLrOjVu27zvL3gSaww2YF46ofZ/7IXtDvoqC3afRRiitHWrmYfKxrWBLsblQXDkt7F1lNxBv72j8vEPztb19oDhF3WEbpf+EqcNMNxBEIHNDl1ZzrKlYUqelmCsHCJbhoq+4loQsLj6157b95jp166pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vgzm9yi6; arc=pass smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139edc6bfc0so921871c88.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 13:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782506713; cv=none;
        d=google.com; s=arc-20260327;
        b=qBsnM19vdDlKoACskX1vIshMzoWbT3y2qwEdfSRGLJ9n9wyu96xcd0gI0Iwf81Wnde
         qFGz/elJG/074VHcznEQbhSEfVTAlnjcUYFk1/IdpXHbbvLnujvWW3kPzb5ih6i566pD
         UUKUC9ZXdnFcisD1u2DULZwzcclCPxg/mpU2vKJYXdr0vWtUwjEDFByVmi5cw+vhDq8P
         OKXus1d8I6e4ZUNdMwpXeddDWj+sRdh13XsdUOF/OyszIVkpVeLsxAsZ8dx80LcR1bTM
         DRSVPeN7amKAJS7VvkEg6UH0DlvuNfqC7mDpUn0gHhEJybe+8dItkYbSrgrScVk8SYSz
         rZVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I7hKSiMuJoFJUDE/f83Nn28oo6Runy3fp0E90qXAz6E=;
        fh=NqSUj7Ns48U7etoMqZc3lGKI62KUsUfqFtEBhkzsRdQ=;
        b=W9cEGm7VzJ0by2V/ATnBKHgfRyBQsQD+mk347njT5S5vl9mo3GsKTdHJ6OSyCdZ49k
         Sh0nOdNKicOdM4StC10k03vN11z1cxJ3Cwb05FycMRUoGpCZ1a9PJVNucvJ0EmmT2mJ2
         xCyX7zZK5dkpYyOH627BlUsTsA8m+f9D/SAHuE31cQ/QYCO0BEeUpeaNAw0LLj2p/gdf
         FWriA2xrA7ANxS3Nohog6+AQSYKtGMDyGsWC1bM5VaTyhQ2JMdC+uYfJ6QIjA0m/v2Kk
         tro+rxtYdvAqx7hMXIqqCj6EiWNeBP50rxhXq36pCYHj1XPF6DugyyoCfLPg2JJ3SdfX
         SDKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782506713; x=1783111513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7hKSiMuJoFJUDE/f83Nn28oo6Runy3fp0E90qXAz6E=;
        b=Vgzm9yi645IYFY3FSgjzxuRZfiZlZ5yvyVT2Ix8SBGeoHRTY+e59da8NCcApRaGIVA
         DIgyCP0LKGxMjINreahD9gO4WoPDXLkYAvqD+/3xu9MR0lZ9FPcO5WKF+icH7Zadux4Q
         LG1hlRMJn1Ee/NudgV61xHXQHbvqaRRXmUJ+i2361joqbPdBr2WLzt0M43QwUCzUwPcb
         hbKLpPpSYoiblfw2Dh4A3mXFmlnpM/o4nEye44Md/wYXfcZptfMJAr4UyYBVLYym6UVB
         dYyl7CAldB6B6xYsDQ0iV6fAgTSe8YBFfOWFrzLC1k0IEebnu89bXivB7ouZx04xiPbE
         +zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782506713; x=1783111513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7hKSiMuJoFJUDE/f83Nn28oo6Runy3fp0E90qXAz6E=;
        b=pEA/oXQOG/yDORlGYnSVwC+hwiJzEf6dnH10ns8sgtj9R4RXAAo48UH/r9RF3VNu0w
         u0jSZUaV8OgegGOceNpfmVJ46zLpKPsrcEtF7s+o4yeQCjykDtafJH87Cgli4zSlScdz
         5zJ4CtYN+Cqm1rAsploODZIXTyu5GrAR6AAycXpbF/ch+AjJByVaXfskW2tBSEfclD9b
         G8OxpMoR42otNPOk+ItsJ6mJ5fMG0GLwMjjOTrX4tYMGQAVIgXv9kZ2+SnDkD0AvohVy
         g0XJeydofdHqMN8Z73HF0BPp+xMtLKth45iWmb40fFGjQQRNc896QrTvpKQg/9Ms4ifQ
         sY+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/tRTZ1/j0xJOxlkseVjuEoIs92mv37EfQV1/X4TelbEQrUir+5h0sDZxFigcR6vPcqbCGEbQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZwFNarVGw8QFwVQ5Vak9YdKQe2upAWcom//w9OpzfNItORja
	75JlxnjkRIZggsufF7SHTwDbp3cP1ahxrlfHt+3tKsEqQIy0YjFXHHzBO9PbgBaHmV/cgOx/3Gc
	4PXhKHPM8KCPCKIZQCANHntw8RIsYWBzkqzUkk9I9
X-Gm-Gg: AfdE7cmm8+LXMmHAFi0Ict2845V0P94J9w0m8a9BOU3igGduiKgb6qTbMWQi+zEenoT
	CKaMzVZxWX0aiO6oUPxLNshV7Vj8MgQ385tc2ttYGx/fw5YYGKWIFzYojzoiib7A/p2DOpd39DD
	P/3sZkLHYsiZ7LMBd05Idxqb3p3lzXV2CPPpWKnNWKdc2hepbgHF39V8X7HEfpIReYDtEtMnLqn
	IeatOwU6/0kPHrnauyuyHYd46E2dk1Ouv+dBUuc7qquELHpd7wHRwhpudiboWFAgutPE8FbtIYw
	Tg5AY/sclxgmhpepWiTH0wGM2tHmVj1LnpuD8j4DUxnEuaryjoN8u2zg++Y2f2G60xFz9sIo7CL
	djN1kxr6D3Fzhrfuesj9Q7EG1H5nMq0xy4wB9MKc=
X-Received: by 2002:a05:7022:41a0:b0:139:b977:9bc5 with SMTP id
 a92af1059eb24-139dbb2ea4cmr7763842c88.17.1782506712014; Fri, 26 Jun 2026
 13:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co> <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 26 Jun 2026 13:45:00 -0700
X-Gm-Features: AVVi8Cf-y03bJ43WYYvw9v-GEe05G2Y8Afs3h_aEIlBR5CD6DchBEBYz4DVEdgo
Message-ID: <CAAVpQUB-hMuVpT0dcTcDDsSeDLXgBmNuMF4HTniHhJhVuxbFqA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
To: Michal Luczaj <mhal@rbox.co>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Cong Wang <cong.wang@bytedance.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:edumazet@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:ast@kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,redhat.com,gmail.com,cloudflare.com,linux.dev,davemloft.net,kernel.org,bytedance.com,iogearbox.net,etsalapatis.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rbox.co:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBDF26D0113

On Fri, Jun 26, 2026 at 1:37=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> UDP sockets get SOCK_RCU_FREE set when (auto-)bound. This means
> sk_is_refcounted(unbound) =3D true, while sk_is_refcounted(bound) =3D fal=
se.
>
> Because sockmap accepts unbound UDP sockets, a BPF program can increment =
a
> socket's refcount via lookup. If the socket is subsequently bound, the
> transition from unbound to bound causes bpf_sk_release() to skip the
> decrement of the refcount, causing a memory leak.
>
> unreferenced object 0xffff88810bc2eb40 (size 1984):
>   comm "test_progs", pid 2451, jiffies 4295320596
>   hex dump (first 32 bytes):
>     7f 00 00 01 7f 00 00 01 d2 04 1b b7 04 d2 00 00  ................
>     02 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
>   backtrace (crc bdee079d):
>     kmem_cache_alloc_noprof+0x557/0x660
>     sk_prot_alloc+0x69/0x240
>     sk_alloc+0x30/0x460
>     inet_create+0x2ce/0xf80
>     __sock_create+0x25b/0x5c0
>     __sys_socket+0x119/0x1d0
>     __x64_sys_socket+0x72/0xd0
>     do_syscall_64+0xa1/0x5f0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Instead of special-casing for refcounted sockets, reject unhashed UDP
> sockets during sockmap updates, as there is no benefit to supporting thos=
e.
> This effectively reverts the commit under Fixes, with two exceptions:
>
> 1. sock_map_sk_state_allowed() maintains a fall-through `return true`.
> 2. In the spirit of commit b8b8315e39ff ("bpf, sockmap: Remove unhash
>    handler for BPF sockmap usage"), the proto::unhash BPF handler is not
>    reintroduced.
>
> Historical note: this issue is related to commit 67312adc96b5 ("bpf: reje=
ct
> unhashed sockets in bpf_sk_assign").
>
> Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagra=
m sockets")
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Looks good, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

