Return-Path: <netdev+bounces-298344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fCoWJq4cK2pl2wMAu9opvQ
	(envelope-from <netdev+bounces-298344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:38:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C4C675388
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:38:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=p8wyuvTr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298344-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298344-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62263336CE17
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CC8408617;
	Thu, 11 Jun 2026 20:35:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F635675A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:35:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210148; cv=pass; b=HA53zcsipBBc9ElRp0rXrMxbmVg6hCR015Mrcho8FizlALXJqS1zbbeM73ol7MIuJHnB+qzCLgS0Zpru+8k6UTTHM1PuKk0GSHr4AgAARcZ2S+Rj1spFs9E+mT7rpUPWVeikTemIl+uE3OPj92t5kCjjxtt7Rhh9/ZnJdCHGnmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210148; c=relaxed/simple;
	bh=26I/E0jqclwBNbMJrzETQh1RkPAD+xcgw5219s0GtO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qjzw2jBIXE0/y/+3RNdpJ7HsE1lseK01hV8tN3ADBLNHFbMi7Zq95T0VzAYovMadCbosAaTqt5Oc7pdsiZ3VPSw1u92tHrBnZhHbmE/i2mvhaDarQ6+h70FR0bkOR9bVvjmJ2zlpeBU2ZgNeKXgKdn6e9S6teVzfG9OhlAMus18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8wyuvTr; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51765331535so33761cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781210143; cv=none;
        d=google.com; s=arc-20240605;
        b=AN8Mx8E53ePTUDe6Okamoq9F7LhRVb4AX9TBEq3aFlzZFfuprxY8qKmmrs6JrVJPVQ
         cQ0li4v3gboH5pwjoAMxIp9K4HNxVMaFn+1gaQy5csMPjefSOypHZz1LFgiNBw1IaDjq
         GTp8E8COldCIXTfMJd8hhFpLvGRLymSLVRbL9rOJVle4/aaAisdlLhuqiNsuvoIMzbfE
         4eqZft5Ry2Uf9h9JYF/BDhnIoMKhvO6etUkAOUedi6emUHkbG30T10Z/t64d97CQs5Xv
         xcury8FODnFTunki8JMz7kJykYOgSb3lX00QErbAJUpYlMiu5Xs/bwLemC9AuD1mfQeh
         CKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rTG2eVgH5EFpBrpxCMtRpc9OUYBRrWqg91YAZm7sJjo=;
        fh=W28MWSJi/EE32J/gFiuARbKHWYvDZUpWgA7sjYLzthE=;
        b=Gssg3MnILjjOTvnrM1+xzE7tVSCrj0v2iurVBeVe1KiCbLojL8STrQdFnF/s9ul0y8
         xiTSNmYPyZubfxQTyp0I1ZYpVtd2JYWPMsyhZdSwX8Ko/Bk6mYjeMIaFjR3prcKDi8IM
         Ks2mxGleuyVrucqT+P6Agm9H+/x873a1mIC3z9xxo4ZnL+N9FjI9pB/aVnIhnhlYSFoS
         Zu5+ehD3L2w+ZKChojMJyCH58dZ5URV8VuLVfZqZTvqfoUa1hzn884DpPp7qubjcFd+o
         QFymB/5UE1hs2k281j4dLbUSzHtrvOGuP4Us2BQrIrno0cMxCJSNxwKbuLmyko1nJhsc
         m9nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210143; x=1781814943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTG2eVgH5EFpBrpxCMtRpc9OUYBRrWqg91YAZm7sJjo=;
        b=p8wyuvTrqhLx0NJXBhlHlMdiv6cwCTZgAZAR4N9f8wKLdJYJizCLPSZhumL6EvoywA
         ztkEBf/QeE9h2X6oyqdaM2n5ZEbUxT19gVck2x7bl9dTS3EKdzAvQ0Oe0DhdG69cCajk
         0Ji6qGD+1WMvDNMWDbcnVlaCWHMttF21DLi7Zh0TkLmOObmfErH9WwKtWa3JA/b5kp9+
         fKZP9tWtCernPFBQHlDdh0pu/X5YzPm3MkJwB7VI3Lpz6vApFQz0D2PIL3lsh9UsmmHi
         MP6JpKxfq/6nWUsjPtXNDlntOeUTe6HLcYv9M3axoz64EUSxSjVcy8Aj8j9U3xuKAKBZ
         vcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210143; x=1781814943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rTG2eVgH5EFpBrpxCMtRpc9OUYBRrWqg91YAZm7sJjo=;
        b=HVwngLhneLebJkG6qk6OhYos21G3/aiMfiCuLlyI5KMtchEaLz+M2FMtX2T5J/e4J0
         8xwDqiGX50ad/UwFUMj6sChWK4moxNlX/4sG2d2tJRs2T+60oABUoKDTuZ+o96kZWFmP
         XHxhclUF+sAb6imUkeo5nS3hho87xe6qL3UOA5chamFA6CFQbG76jXSy+bBZaCKNSyZu
         AfLsyjwW3X5PG5T0sD8LhOFnPlJRZTn208dGbT/rkd5GXPH3bkcyaic0IzyJDr2AxUvC
         3fbBJUc0ac7w/IGljL8QiWbkBCzmh98VUDYwrN8RnGLlhazxfr7/71OeYOG3vNoQgVOL
         uisg==
X-Forwarded-Encrypted: i=1; AFNElJ96d8fXAPqYAwYtOkrne4LVV2j8RDAAg7ay5PAtBvIBP1qfTCCqhViGB5yUNL8amAh+bMO9qEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABS8wnjh8uqxN1ZGghBRleDxr/v77kYr+edBSqaftbhBtzL+e
	a7Wcvs/Ca9ZQuzgx0EZJ1rHFFZBv/PR0eEcFvM2KDRj/pvaicrhGDDa4ccj0G0hm9LYQFGR7yIb
	Du2F6MlknquVz1Kp8EZ/KeHqGeUqIPG23/b2XJfy3
X-Gm-Gg: Acq92OF9SLDslb9+y1xTlXCYx8zAjJR19b0a5GqiNFRrf4oZ2My3t9RBN8od/7CBfMS
	IVSk/s5AyXQzkuxZ5BKGVlzLMfyM1B27m2T/DJBTLR3b+d5TtN0NM4/Za/g5HZWJtQIjrtEeyX0
	hLa5rGrL2uXuJCAigoVx3Pt1cXDTkPn/5DBRpRg+VBJue0M56V7IJ5g7jlfB1iz0f2qcCHfLdUw
	dmaBcUZ5zCwJSkZqJfY041a9Lx21Sg9Q/DKgWCLABm1KTSFkiX7MHpPRCH0jFsTElcy3/BoaYjP
	hMJpjnX4EXe4zW5ksHo3wQPp4PVjp4DYDRMp
X-Received: by 2002:ac8:5a48:0:b0:517:5f1d:9f7 with SMTP id
 d75a77b69052e-517fc506a8dmr436611cf.7.1781210141994; Thu, 11 Jun 2026
 13:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com> <20260610230415.C0521C88@davehans-spike.ostc.intel.com>
In-Reply-To: <20260610230415.C0521C88@davehans-spike.ostc.intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jun 2026 13:35:29 -0700
X-Gm-Features: AVVi8CdN4TFi21bTDduKLyadU8rWfGxctdFy54TtZGcrA-1-JxHz0WBnpM-4hE8
Message-ID: <CAJuCfpEu4HfUOVd1dTGdDNxq91Ts59ab_LiVPQEnxRUWUi3WaQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Add RCU-based VMA lookup helper that waits for writers
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:aliceryhl@google.com,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-298344-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2C4C675388

On Wed, Jun 10, 2026 at 4:04=E2=80=AFPM Dave Hansen <dave.hansen@linux.inte=
l.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> =3D=3D Background =3D=3D
>
> There are basically two parallel ways to look up a VMA: the
> traditional way, which is protected by mmap_lock, and the RCU-based

"which is protected by mmap_lock" better be more specific "which is
protected by mmap_read_lock".

> per-VMA lock way which is based on RCU and refcounts.
>
> =3D=3D Problem =3D=3D
>
> The mmap_lock one is more straightforward to use but it has a big
> disadvantage in that it can not be mixed with page faults since those
> can take mmap_lock for read, which can deadlock when mixed with page
> faults.

"when mixed with page faults" or "when mixed with address space
modifiers that take mmap_write_lock"? I think that's what your example
shows.

> For example:
>
>         mmap_read_lock(mm);
>         // Another thread does mmap_write_lock().
>         // New mmap_lock readers are blocked.
>         vma =3D vma_lookup(mm, address);
>         // This deadlocks on mmap_read_lock() if it faults:
>         copy_from_user(address);
>         mmap_read_unlock(mm);

Ultimately the problem here is calling something that might require
mmap_read_lock(mm) (in this case copy_from_user()) while already
holding mmap_read_lock(mm). Normally that works up until you throw an
mmap_write_lock(mm) in the mix.

>
> The RCU one can be mixed with faults, but it is not available in all
> configs, so all RCU users need to be able to fall back to the
> traditional way.
>
> =3D=3D Solution =3D=3D
>
> Add a variant of the RCU-based lookup that waits for writers. This is
> basically the same as the existing RCU-based lookup, but it also takes
> mmap_lock for read and waits for writers to finish before returning
> the VMA. This has some advantages:
>
>  1. Callers do not need to have a fallback path for when they
>     collide with writers.
>  2. It can be used in contexts where page faults can happen because
>     it can take the mmap_lock for read but never *holds* it.
>  3. Its fast path does not require taking mmap_lock for read.
>
> Basically, when applied correctly, this approach results in faster
> *and* simpler code.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: linux-mm@kvack.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: netdev@vger.kernel.org
>
> --
>
> Changes from v1:
>  * Add a comment explaining that this can not be mixed with other
>    per-VMA lock or mmap_lock users. It is prone to deadlocks if so.
>  * Add a FIXME about making the mmap_read_lock() killable
>  * Add more chaneglog bits about the possibility for an infinite goto
>    loop.
>  * Adopt vma_start_read_unlocked() implementation from Lorenzo
> ---
>
>  b/include/linux/mmap_lock.h |    3 +++
>  b/mm/mmap_lock.c            |   27 +++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff -puN include/linux/mmap_lock.h~lock-vma-under-rcu-wait include/linux=
/mmap_lock.h
> --- a/include/linux/mmap_lock.h~lock-vma-under-rcu-wait 2026-06-10 15:57:=
55.828431712 -0700
> +++ b/include/linux/mmap_lock.h 2026-06-10 15:57:55.834431925 -0700
> @@ -257,6 +257,9 @@ static inline bool vma_start_read_locked
>         return vma_start_read_locked_nested(vma, 0);
>  }
>
> +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> +                                              unsigned long address);
> +
>  static inline void vma_end_read(struct vm_area_struct *vma)
>  {
>         vma_refcount_put(vma);
> diff -puN mm/mmap_lock.c~lock-vma-under-rcu-wait mm/mmap_lock.c
> --- a/mm/mmap_lock.c~lock-vma-under-rcu-wait    2026-06-10 15:57:55.83143=
1819 -0700
> +++ b/mm/mmap_lock.c    2026-06-10 16:02:50.723860779 -0700
> @@ -338,6 +338,33 @@ inval:
>         return NULL;
>  }
>
> +/*
> + * Find the VMA covering 'address' and lock it for reading. Waits for wr=
iters to
> + * finish if the VMA is being modified. Returns NULL if there is no VMA =
covering
> + * 'address'.
> + *
> + * Use only in code paths where no mmap_lock and no VMA lock is held.
> + *
> + * The fast path does not take mmap_lock.
> + */
> +struct vm_area_struct *vma_start_read_unlocked(struct mm_struct *mm,
> +                                              unsigned long address)

It's harder to review a function without a user but I guess users will
be added later in this patchset.

> +{
> +       struct vm_area_struct *vma;
> +
> +       /* Fast path: return stable VMA covering 'address': */
> +       vma =3D lock_vma_under_rcu(mm, address);
> +       if (vma)
> +               return vma;
> +
> +       /* Slow path: preclude VMA writers by getting mmap read lock. */
> +       guard(rwsem_read)(&mm->mmap_lock);

guard() is nice but mmap_read_{lock|unlock} has those
__mmap_lock_trace_* traces which we lose with guard(). Not sure if
that's a good enough reason to keep using older primitives.

> +       if (!vma_start_read_locked(vma))
> +               return NULL;
> +
> +       return vma;
> +}
> +
>  static struct vm_area_struct *lock_next_vma_under_mmap_lock(struct mm_st=
ruct *mm,
>                                                             struct vma_it=
erator *vmi,
>                                                             unsigned long=
 from_addr)
> _

