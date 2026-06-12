Return-Path: <netdev+bounces-298710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qrAJDJAtLGrOMwQAu9opvQ
	(envelope-from <netdev+bounces-298710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:02:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF8B67AAFA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:02:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=pD0UlD5t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298710-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298710-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DA123028EED
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001423612D5;
	Fri, 12 Jun 2026 16:01:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1E32570D
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:01:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280113; cv=pass; b=CAoZZpqCmIWkluzdwGXA49xU6EnYBbYHAqRE1DEvMxbzklSZZlFLf6BLn4CyXjNozP4kBQZDWMX/UjiUDLB0PlgO6yVBsgsjpC8b+gVtV1MqKNpbG8To/MhGIv/8DLddDIHyh/gHQmGGk23aquklUlZhw5ByAwSnA27qV1ldBt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280113; c=relaxed/simple;
	bh=Rb8FuojIiOJqGBz+6uVJ+OFzBs3jrD56uWZ1H7iBmBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBan3FOKVVqflx5E62fP8eRjarMeJtdmomOnq9Zg9eejnHSdfxn0SXwsXhd92THjV2wdiEv4Ix5SqqcP9ZZgam9b0dxkh3EryM0oR6jp5y9gNugB5cWqao7+Chh8qw7mdu1CLpyue/LAcT36xSAnFWnhmZF8SzEJY+CeueQVMuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pD0UlD5t; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5177d1ff061so531321cf.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781280109; cv=none;
        d=google.com; s=arc-20240605;
        b=cAxGTrTggKGwoKyCd/IpRVa017qrXFc4Jjsz/vdJURBCRb6mdJpZSWB2NgqQsb9TKQ
         cMuC1WwmbsTV0cmdwfu0v7YnH1yAY9DwbOjpgep1A1V40riTaCl2rBUbNv43qEcqSWm7
         K8iv1Ph0lmpOQy/WfcUlVZMAd9PnWPij0Cc97Nlaz0u5rUMYx0sL3BxHIa85lw/WjEHB
         NG6hplXQ6jF/mazNCmhRs4Dk8jzMNkWzFnCQGdRhIypvCfpOKcLShkK29ujSMru3X6Pn
         N8mfGUZ8wjD2Q8Ndgtvz8Qji7uTRX3iNo7Y9OUq6NF6MSteao2GWQjmWs0otPx+RKMFg
         Paew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a50kyoLhVQeW3U2Ze+HGxZgYK7Tu12TilefkepaSEmg=;
        fh=3hl0SHMMCEbsiu615maYv5coWLHkJi5Q0sNYWSZgcUM=;
        b=G9r67E2w33ooUNpGX/C/z4OVdEYl3Zc+Lne2XqWekVnzGXZ0uV/af4HT19o0ulkEdk
         xQ8pWjjebXoR88TNln8oxJNEWuv5fAhbSN/dNj0eKznwchGKL6OP0nVASmfRgNZmAwx7
         Imub/JdFSIsibC0RKJUn5E7d2bE/hfvoS+FyeqZK2ZVNXKrIqi/tmLkH0n5HVKq0m9Ms
         TTfq7zk7jwwxQZ3IDiEWwO86FBoqpPppgLZVZUwFV3lXrXv8vZ5FYadkMfLWwsgKa8Nq
         Zp8Cno23jsH2kvHM09SuuymgpBIqpBIvx7Jkf4OeZRFLG28M7DRVE97Cp1uD7QcNdpDu
         cQDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781280109; x=1781884909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a50kyoLhVQeW3U2Ze+HGxZgYK7Tu12TilefkepaSEmg=;
        b=pD0UlD5tibWagAxOS8VE8seGVKoBQG1+WrxZilrKgtQTkX3kIdvbCbGJrV6YzEGOSP
         41T38RWG/BmqDvAn/tGehvOJPuOlDcdHQ8/gTGKY+dFZLnsoF6gROjyJl2qj9tQSH1zr
         ofeWkG8j4e7y7ctcdn/4azwDGxHANyf4ZvtHBmbxiseYuNTxZdMjelRpDGAtbm1dcMB2
         wdFDn1/NpHkiqpUsh1IdoJk/6fCXgnZFE2xYftGGRIqv676VjsWlXS6JvxUv38PC0Jt4
         DDODYntw61dWEUOSoT6RKhS/DnFQpbU0Ht45hrJFZWffQoevoBwM1n4A6/FaCYOMsSCu
         W5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280109; x=1781884909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a50kyoLhVQeW3U2Ze+HGxZgYK7Tu12TilefkepaSEmg=;
        b=QstfJ/CKKSQTzBtSJ+WjAIBkQJYzvslg7nB3VR7m74xTo7GgJJbd2il4wfkvU6I0DX
         cE+ySXubShmwbObHU5Mk3LMMbnRhXDP8imEVr113RMfZilOC146CUGI7C8x8XazVPedd
         93CogTZBjcYk2NjAX11EHazxb09mlPbS9FOSkFescyMawRSHa6yiXi7+ha1gANKvS1R9
         6kpFLweohUeTgUII96CXKjrJYA8o6KfJ/KZi9DfxpTmaGF/Xq51I2+lCA3NxwK7RvA/+
         nwxaMEtEEEmnIcn9Kek9cGQB0sSvt7kaE0bWXMz9KUFBR3kno25ImTL5H2axCTxY0hLV
         9Z9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Ifvzg4emWRSZescVQQTyiUuLJZ9mvZcPcqP/CSwj8RJ2xT/e7cVMQoDYtU9G0y5Wn3Dqaglw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSWwqA57J8g9BVKc0krFJjgn3mzx/WTDZ+rXQN3api6KCSUSY/
	KP8TbaUE+61/msxy+aa/HlEK722eAdCHvcD7I+IdCm59Qt3sRqbfW3TzgQXtg8wuSd4anYB/wMc
	TJH+p1Mp26frII/nasvu9HzbQIKt3o1Yx25VvtbO0ZdB8A1IA72qoUd6wJ0k=
X-Gm-Gg: Acq92OEtPxcIC6CySzqarlCCv2QL/hJpOsLvkxLPCDKfJ8FZKpbSH441vT/1L0/erod
	Q9zyR2qoIuF9Sdd+TGi+ZFjfj34fJKB6fm7bPJOkgUD90vCPqrfnEfspNBfv3GUO1DVd+y+nl+k
	WngHkkXKAE5ZlSOBfUzHK+QiHGhDNUuCfhM0v4Hly2uLI6THzt14PhXHjMCU4mcnSSJ9u5/g5cG
	0VuMslgOjHEXORX5hWg0qzzXDPg1VbX8xO5cKBrcGU0SMgXVMPCzW1RVGs4FZqtFGIPOd9ntsM5
	l3Z9wgbqMZHAH69N
X-Received: by 2002:a05:622a:a11:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-517fc520f0bmr7637231cf.5.1781280108465; Fri, 12 Jun 2026
 09:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230413.D68967BC@davehans-spike.ostc.intel.com> <aipphZ5iCnbXVNSR@google.com>
 <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com> <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org>
In-Reply-To: <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 12 Jun 2026 09:01:36 -0700
X-Gm-Features: AVVi8CctRaDJfF5OxV4HwolIWbvnZfBdGqLW9dLOQNg_q1FSz8KvD_IKdVV3A1Q
Message-ID: <CAJuCfpEMF6QMGd=H1+Z_tFzJ8SSvUXZL62r1iijZoEseoAr9_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Carlos Llamas <cmllamas@google.com>, Christian Brauner <christian@brauner.io>, 
	David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:aliceryhl@google.com,m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[surenb@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298710-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CF8B67AAFA

On Fri, Jun 12, 2026 at 8:41=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 6/11/26 21:59, Suren Baghdasaryan wrote:
> > On Thu, Jun 11, 2026 at 12:53=E2=80=AFAM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> >>
> >> >  b/drivers/android/binder_alloc.c |   26 +++++++++-----------------
> >> >  1 file changed, 9 insertions(+), 17 deletions(-)
> >> >
> >> > diff -puN drivers/android/binder_alloc.c~binder-try-vma-lock drivers=
/android/binder_alloc.c
> >> > --- a/drivers/android/binder_alloc.c~binder-try-vma-lock      2026-0=
6-10 15:57:55.274412018 -0700
> >> > +++ b/drivers/android/binder_alloc.c  2026-06-10 15:57:55.277412124 =
-0700
> >> > @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(s
> >> >       struct vm_area_struct *vma;
> >> >       struct page *page_to_free;
> >> >       unsigned long page_addr;
> >> > -     int mm_locked =3D 0;
> >> >       size_t index;
> >> >
> >> >       if (!mmget_not_zero(mm))
> >> > @@ -1151,15 +1150,12 @@ enum lru_status binder_alloc_free_page(s
> >> >       index =3D mdata->page_index;
> >> >       page_addr =3D alloc->vm_start + index * PAGE_SIZE;
> >> >
> >> > -     /* attempt per-vma lock first */
> >> > +     /*
> >> > +      * Attempt per-vma lock. This is essentially a
> >> > +      * "trylock". It can fail even if the VMA exists
> >> > +      * for 'page_addr'.
> >> > +      */
> >> >       vma =3D lock_vma_under_rcu(mm, page_addr);
> >> > -     if (!vma) {
> >> > -             /* fall back to mmap_lock */
> >> > -             if (!mmap_read_trylock(mm))
> >> > -                     goto err_mmap_read_lock_failed;
> >> > -             mm_locked =3D 1;
> >> > -             vma =3D vma_lookup(mm, page_addr);
> >> > -     }
> >> >
> >> >       if (!mutex_trylock(&alloc->mutex))
> >> >               goto err_get_alloc_mutex_failed;
> >> > @@ -1188,13 +1184,11 @@ enum lru_status binder_alloc_free_page(s
> >> >               zap_vma_range(vma, page_addr, PAGE_SIZE);
> >> >
> >> >               trace_binder_unmap_user_end(alloc, index);
> >> > +
> >> > +             vma_end_read(vma);
> >> >       }
> >> >
> >> >       mutex_unlock(&alloc->mutex);
> >> > -     if (mm_locked)
> >> > -             mmap_read_unlock(mm);
> >> > -     else
> >> > -             vma_end_read(vma);
> >> >       mmput_async(mm);
> >> >       binder_free_page(page_to_free);
> >> >
> >> > @@ -1203,11 +1197,9 @@ enum lru_status binder_alloc_free_page(s
> >> >  err_invalid_vma:
> >> >       mutex_unlock(&alloc->mutex);
> >> >  err_get_alloc_mutex_failed:
> >> > -     if (mm_locked)
> >> > -             mmap_read_unlock(mm);
> >> > -     else
> >> > +     if (vma)
> >> >               vma_end_read(vma);
> >> > -err_mmap_read_lock_failed:
> >> > +err_vma_lock_failed:
>
> This label is unused btw, which is related to Alice's point.
>
> >> >       mmput_async(mm);
> >>
> >> If the vma lookup fails because the mmap write lock is held, but the v=
ma
> >> actually exists (has not been unmapped), then this code might "success=
fully"
> >> remove the page without invoking zap_vma_range(). This means that the
> >> page does not actually get freed and will just hang around forever unt=
il
> >> the process owning the vma exits or Binder needs this page and maps a
> >> new page on top of the page.
> >
> > Yeah, I think if lock_vma_under_rcu() returns NULL you just need to
> > jump to err_mmap_read_lock_failed, like we currently do if
> > mmap_read_trylock() fails.
>
> I don't think that will be enough as well, as the current code AFAICS doe=
s
> something meaninfgul when mmap_read_trylock() suceeds but vma_lookup retu=
rns
> NULL because there's no vma at that address. Now we would just assume the
> trylock failed even if the reason was that vma lookup found nothing for t=
he
> address. The problem is that lock_vma_under_rcu() can't distinguish those
> two outcomes, so we would need something that does?

Ah, you are right. I misread the condition in that code.
Changing lock_vma_under_rcu() to distinguish between lock failure and
no-VMA case would require some refactoring. vma_start_read() should
return -ESRCH if VMA was not found and then we handle that in
lock_vma_under_rcu(). That part is not hard because vma_start_read()
has only 2 users but then we have to propagate that error code to
lock_vma_under_rcu() users and there are many of them. Though
converting these users is straght forward. Instead of checking if
(vma) they would have to check if (IS_ERR_OR_NULL(vma)).

