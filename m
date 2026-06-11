Return-Path: <netdev+bounces-298326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hb6SLNoTK2oV2QMAu9opvQ
	(envelope-from <netdev+bounces-298326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:00:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F47674E4B
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:00:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RrmB9Kww;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298326-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298326-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B24063012356
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0E7369203;
	Thu, 11 Jun 2026 20:00:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5603672B8
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:00:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208009; cv=pass; b=Kqd/Goiyd6xXGbIggesc7R/bY6cMFR1N6r+v44iiUSvhEgFoxuyYxUZtCz3b/Nfcs1vlOSJj3jA4VuTfuuR6Axu0kQwx4rrrs6A95ZreLl/NgeM4JRRRmkkwz4JhB4LQ7labWXNNqBCk45gIRlKagWjKb48N1AdLCgKZpU1F/qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208009; c=relaxed/simple;
	bh=1fk2BVgsDhbcfdy/pEAiV7KO2we0OtIUAfsHXo+K4yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9pfgMrQ1lXL+nhaAUAI/5vYAcD1dikp3WvHJ9z30TQmq0lYkrB7XYroKOGkFR+gcV8ezxdFRGffosNN6c3dtZvj4SYe4TcXjisFgyE6Cju5WayZ0oy3Mh6JjC7g1/+HgxHUcK6YhlY+0zPL3p0kOuUZcg4wjjNuhB7y9mnTCRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrmB9Kww; arc=pass smtp.client-ip=209.85.160.169
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51765331535so18941cf.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781208007; cv=none;
        d=google.com; s=arc-20240605;
        b=EplMV14hmpAd7SkSjYaNkrR72YEGpp9GTqdGSq3ZeWBBN3WfFI3ut7TzfvDvB9Guia
         n95+5HdB+2m7+mhHVIl3zVsC/NGQwDo0hWa+UpujYLEA/9M39NqW7kzRifBbM8blKRzT
         /eThZ2DAyDpT5Y77nQNQxbAmNwU37uQobYzcQUJ7769SVj5udVeqLwI9wrNsqw7+Vpay
         lcUqP9i8jJ322IPMa6xn+zkGbI9h3j0Xa8qE7AjT4pGi/KvsxqFn2uJBNvJcfkFv+5hq
         oJ/1XfbvUUjgPVH5+TZ6lJr/OMtxgC4hLpXxSeLsMu6/jLhV5jZj/ZnQNos8KbdYVmRZ
         eDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+DZhnLtU4hkHNEj9D5IMZ233IFNNjbtecRnYLHLtb/s=;
        fh=jk498YIpqGk86bpy2k1XDlncrvdkgq4ffmkyQL4NUD4=;
        b=U4aq/yjsnVLUMEOWMSNh+pKwbqq6ieKclHTW87D30p3xrMXsa8GWBLASLeQDn7P/bZ
         YZSkxCiMBDuUyKcJIqi37LHmivVqoZvO401ERo/u44pZ3hoh6jr+AfjRWuBsNLusafDX
         cOTh0Y/viSyML5S5bN0IUn6DbWkeoKJcQmVqXZJ+lUYdFORE2Tz2bNuNtPFhvxWrPHO0
         efbs+J/mT7IRmlaHqdleGoMYaumPyxBlstplqV3bT8VJ+nMUwvA5US5iDygC9r+IJ9hl
         8Vhk/gHXb2xlpiDZXCYDGQYyDR33N7hM5hC2iWrJl3MNcPPPEVgbqvDqW94HKmegF6wF
         C6rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781208007; x=1781812807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DZhnLtU4hkHNEj9D5IMZ233IFNNjbtecRnYLHLtb/s=;
        b=RrmB9KwwpcaicwuuDyzR7IwR8tWYqyD+Hb4TwmNs4rUB6jj2waV7J/bRhcsvIqKufs
         PdjP6R1L7ak2EJ3HbwnVgt7uMvjhQX9HJD+VjqCGoMNMLzW7PPp2o6XyFraxG2qJyYhG
         uAYceogRZwSR451ByKysNemxhIz/AjqWQepNp9iT69djwc3VS+q+bEWPU5v+Pm17tRa8
         jP0dIgUeSMEklrDgjonqCqsGwiuh6jJMXSTU9hfJLLtoiMJImEhFssWaiGL0bMJcylnS
         hA3OXN7eEe8u+wYKOB4vJg6eUynGpZNk1VWoS8o2HJK5Cx+F5eSss0SpLUKn6BBrUaRR
         kXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781208007; x=1781812807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DZhnLtU4hkHNEj9D5IMZ233IFNNjbtecRnYLHLtb/s=;
        b=IHuivAjPCjzhKnRigVXEpMfdu7cgjbvqchxJFXIhm+HogvMtRP/6KuWtvsu3Kz7KJq
         wdBLWjEFMRErV1+EWLZcjZnpydXJory43MADGncjmxDCh2S3lb5/a+Kv0tukUEP7BHp1
         xs882oEx69EbeN0bSscwYAaBidvIeFknfGPMkvcGiDgPXVEcJEd6wbyQd0P4EBl2OqrR
         Rwx5hRzJwmE2Q3jhU+j4TltvaFF34Xa3EDVmp78BPO5KgGb6euWt/j9mMz/MfRcbUlE4
         wBcVCZAQgSit5y09MhHwNv9Cy0RWA4Zl6Yp6knFMdDt98dtPeWgqhcgQaCT5QsJbJYEh
         PkVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yJiZ7m8csCaGJguccPPSMRrNnQUjFTzu1SUVeyKi1M/5rTuimnnCWgSA64/u/M0quwWl36HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZsya5+9VYPj7xJPYD5WHBURTLx3Uls4hbBbIEkBK37/7HhEy
	WNW95YWm39XTp5AMvEl9MRAAt1VSb9WjJBQqxbVrjXPPz7S5pziBk8mhuk+9JVDi4eSPh9TEz2e
	TuDEZGiYI84tV6N+oOciXGbmhUk+CprnX0BAMFxJS
X-Gm-Gg: Acq92OEmgSRkcxd+Oo898NPvJUY/iR98IXTWt/Pnp2OD6tu1yZvgHz0I2CG2/Wdy0RM
	hpvavyoJdM3HMDu5FXYzHDuI0Vmh/JRPumPJ/4g16zdUxfX6dEk+DW1CimQ8bu/OWt7XvLcRZge
	S1y0myAjAtyo9KNG1p+C22qc+nznBwGT6I8DbAZWiCsgXUQ5mmvsusux9HxwdI4sKb+INo38KQv
	6rgheWijHkVPPZ7PaJriwjNlCR2m8lV1hVvqUurQtXhlQveZTp8l1y+luZE6Ys8ZPN1Mmfe66OD
	RWKEbH9t7t58rVvNLGA3pFo2/IjU64mmmYxI
X-Received: by 2002:ac8:5c84:0:b0:516:4f62:85ee with SMTP id
 d75a77b69052e-517fc539337mr136551cf.19.1781208006277; Thu, 11 Jun 2026
 13:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com>
 <20260610230413.D68967BC@davehans-spike.ostc.intel.com> <aipphZ5iCnbXVNSR@google.com>
In-Reply-To: <aipphZ5iCnbXVNSR@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jun 2026 12:59:54 -0700
X-Gm-Features: AVVi8CfiycZWPLAG7ErSZzCpvKT0WKpbhzlOg1vhjFlK_wz3B5LNBv38FT83m08
Message-ID: <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
To: Alice Ryhl <aliceryhl@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,m:vbabka@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[surenb@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-298326-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6F47674E4B

On Thu, Jun 11, 2026 at 12:53=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> On Wed, Jun 10, 2026 at 04:04:13PM -0700, Dave Hansen wrote:
> >
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> >
> > tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> > it and mmap_read_trylock().
> >
> > Long Version:
> >
> > =3D=3D Background =3D=3D
> >
> > Historically, binder used an mmap_read_trylock() in its shrinker code.
> > This ensures that reclaim is not blocked on an mmap_lock. Commit
> > 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> > support for the per-VMA lock, but left mmap_read_trylock() as a
> > fallback.
> >
> > This was presumably because the per-VMA locking can fail for several
> > reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> > to mmap_read_trylock().
> >
> > =3D=3D Problem =3D=3D
> >
> > The fallback is not worth the complexity here. lock_vma_under_rcu() is
> > essentially already a non-blocking trylock. The main reason it fails
> > is also the reason mmap_read_trylock() fails: something is holding
> > mmap_write_lock().
> >
> > The only remedy for a collision with mmap_write_lock() is to wait,
> > which this code can not do. So the "fallback" after
> > lock_vma_under_rcu() failure is not really a fallback: it is really
> > likely to just be retrying in vain. That retry in an of itself isn't
> > horrible. But it adds complexity.
> >
> > =3D=3D Solution =3D=3D
> >
> > Now that per-VMA locks are universally available, lock_vma_under_rcu()
> > will not persistently fail. Rely on it alone and simplify the code.
> >
> > Full disclosure: I originally tried to do this with
> > lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> > trylock semantics. Claude caught this in a review and suggested the
> > approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> > I guess.
> >
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Shakeel Butt <shakeel.butt@linux.dev>
> > Cc: linux-mm@kvack.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> > Cc: Todd Kjos <tkjos@android.com>
> > Cc: Christian Brauner <christian@brauner.io>
> > Cc: Carlos Llamas <cmllamas@google.com>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: netdev@vger.kernel.org
> >
> > --
> >
> > Changes from v1:
> >  * Move forward even if 'vma' is NULL in binder_alloc_free_page().
> >    This can happen if the VMA is unmapped (Sashiko).
> >  * Rename goto label to be more accurate for new lock scheme
> >
> >
> > ---
>
> This seems to include the list of changes in the commit message instead
> of under the --- line.
>
> >  b/drivers/android/binder_alloc.c |   26 +++++++++-----------------
> >  1 file changed, 9 insertions(+), 17 deletions(-)
> >
> > diff -puN drivers/android/binder_alloc.c~binder-try-vma-lock drivers/an=
droid/binder_alloc.c
> > --- a/drivers/android/binder_alloc.c~binder-try-vma-lock      2026-06-1=
0 15:57:55.274412018 -0700
> > +++ b/drivers/android/binder_alloc.c  2026-06-10 15:57:55.277412124 -07=
00
> > @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(s
> >       struct vm_area_struct *vma;
> >       struct page *page_to_free;
> >       unsigned long page_addr;
> > -     int mm_locked =3D 0;
> >       size_t index;
> >
> >       if (!mmget_not_zero(mm))
> > @@ -1151,15 +1150,12 @@ enum lru_status binder_alloc_free_page(s
> >       index =3D mdata->page_index;
> >       page_addr =3D alloc->vm_start + index * PAGE_SIZE;
> >
> > -     /* attempt per-vma lock first */
> > +     /*
> > +      * Attempt per-vma lock. This is essentially a
> > +      * "trylock". It can fail even if the VMA exists
> > +      * for 'page_addr'.
> > +      */
> >       vma =3D lock_vma_under_rcu(mm, page_addr);
> > -     if (!vma) {
> > -             /* fall back to mmap_lock */
> > -             if (!mmap_read_trylock(mm))
> > -                     goto err_mmap_read_lock_failed;
> > -             mm_locked =3D 1;
> > -             vma =3D vma_lookup(mm, page_addr);
> > -     }
> >
> >       if (!mutex_trylock(&alloc->mutex))
> >               goto err_get_alloc_mutex_failed;
> > @@ -1188,13 +1184,11 @@ enum lru_status binder_alloc_free_page(s
> >               zap_vma_range(vma, page_addr, PAGE_SIZE);
> >
> >               trace_binder_unmap_user_end(alloc, index);
> > +
> > +             vma_end_read(vma);
> >       }
> >
> >       mutex_unlock(&alloc->mutex);
> > -     if (mm_locked)
> > -             mmap_read_unlock(mm);
> > -     else
> > -             vma_end_read(vma);
> >       mmput_async(mm);
> >       binder_free_page(page_to_free);
> >
> > @@ -1203,11 +1197,9 @@ enum lru_status binder_alloc_free_page(s
> >  err_invalid_vma:
> >       mutex_unlock(&alloc->mutex);
> >  err_get_alloc_mutex_failed:
> > -     if (mm_locked)
> > -             mmap_read_unlock(mm);
> > -     else
> > +     if (vma)
> >               vma_end_read(vma);
> > -err_mmap_read_lock_failed:
> > +err_vma_lock_failed:
> >       mmput_async(mm);
>
> If the vma lookup fails because the mmap write lock is held, but the vma
> actually exists (has not been unmapped), then this code might "successful=
ly"
> remove the page without invoking zap_vma_range(). This means that the
> page does not actually get freed and will just hang around forever until
> the process owning the vma exits or Binder needs this page and maps a
> new page on top of the page.

Yeah, I think if lock_vma_under_rcu() returns NULL you just need to
jump to err_mmap_read_lock_failed, like we currently do if
mmap_read_trylock() fails.

>
> Alice

