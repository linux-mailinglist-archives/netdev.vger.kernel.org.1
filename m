Return-Path: <netdev+bounces-297988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YdoTOGZqKmoJpAMAu9opvQ
	(envelope-from <netdev+bounces-297988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:57:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413F66F9ED
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:57:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="MSicNUD/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297988-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297988-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229FA3082E66
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0F9368296;
	Thu, 11 Jun 2026 07:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA630146C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:53:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164425; cv=none; b=VGVLwcQbonM8EHFxV6IGtE0sclA9fppRHBL52XUYvUj0L27UMvq1raQuwvC8tk2sRsQl+94mkD/f+JN62XIxSgqIRUpOncVTSotbvqYKajDoDLD8CFZajyvEv9n7NmUXXllIziptA6pqcNs1wwQAx4VE3CdYiWxM8F4q6fULYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164425; c=relaxed/simple;
	bh=gISp69wTpH2WDrbD33HcQvd5g7lEfMZB4LsfOXLMD70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nnNg+Pme4C6d8SH26Ju3wzsKOORBkPT1m5LI2vs6C3XZf/XOpLKxTz7A/jWXVANCRA6sK2QrldHS9AMX5q1BMQub5iKnzwQQSEpTp2Qzc+65+0hb1ldJ/scTh7MckO2FtvPuUMQ2QbcwAgTYBfhqkTFQBTed4bKgPHjUbEWAYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSicNUD/; arc=none smtp.client-ip=209.85.128.74
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso60845425e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781164422; x=1781769222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JSnnESFuG4rV7GM7o/iJXwkWustj1ziUDEWbZsW2C4=;
        b=MSicNUD/UB2+W69d+BBpmOqwkEZYvlZQGSAw51FXyMxFzpHjlPKJlTBXlI+jBv49rB
         QJE5sgMgcJWYl6D1QmIF8BuqbArFSwy1NrqXYyNgqGUy6/zbdXw9dJWiQOD0pK3f7FNR
         Uvy5soRD0g3q906ik1QikdMLOKMr+Oxp3wOB2qL7xiJbNb5Qu+YUFGCzanlbziHHxDZy
         qupEuBzm0bL+0Bc/DuAlJ+JqlbIaw/ON1/44Wds2dcpXvl0vxYLm5OIiCqvmRtyoGXUU
         KpDgvi195T7sdmxSy86O2Qz9elRmEfuNxAhzVOkahCVyQzU33KWkUNys7piO4tJLvAGG
         f8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781164422; x=1781769222;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1JSnnESFuG4rV7GM7o/iJXwkWustj1ziUDEWbZsW2C4=;
        b=ENXJInTIEG9Py2XWPS8x3st8cW+SLoV1+ZhUIKaDmmUq3aqyI9j39AIYyKgk8tkFcz
         pURURzGZ79WDu34ejJCyWNnUSuuvFDIaiN1P4nVpmWgyiybghphJVvm5pVwzWHJCc8mo
         aIeq746kIimpBVtq5iRQBC+c1hR3l+au/omZ0Hj6PhIy7zwXdKIFtiRriXMwH8aG4Xz6
         Ww5UBWlKGzX2XFNtxT05NaGYkgAw2ZpeuvnZEtGw43HPeLpbCKRtNBItnYb1sUotcAI0
         ag4alHzj9/VPAzLHLotjOOdMEWPr2lA1A1TgpCM765/P9AAsUs1fIDS7Hpy5thQOd7rd
         OA3w==
X-Forwarded-Encrypted: i=1; AFNElJ9kMav63ynRZV4ff9NzXw/IYlLTo5voope9Rq/It+p8BCpkLBrLYYliEA9Mi10zse0be7LKaEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuvkfORY3lipGa1ZxXH+yfIpAdAhQrIn6lJEAkxNAvwIe4xUY
	dU2F088crck60M4iaS4mAK7+j+sMbgkjTRI0pwEIQjJeV5/J6T9RLev78aGFjPNTkZH2iNO4scU
	5AZawXVaHDeVQwy6QQg==
X-Received: from wrbdw5.prod.google.com ([2002:a05:6000:dc5:b0:45e:7588:ecd9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b07:b0:490:bb45:79ef with SMTP id 5b1f17b1804b1-490e534a723mr19329395e9.0.1781164422412;
 Thu, 11 Jun 2026 00:53:42 -0700 (PDT)
Date: Thu, 11 Jun 2026 07:53:41 +0000
In-Reply-To: <20260610230413.D68967BC@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com> <20260610230413.D68967BC@davehans-spike.ostc.intel.com>
Message-ID: <aipphZ5iCnbXVNSR@google.com>
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
From: Alice Ryhl <aliceryhl@google.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Carlos Llamas <cmllamas@google.com>, 
	Christian Brauner <christian@brauner.io>, David Ahern <dsahern@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org, 
	Shakeel Butt <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>, 
	Todd Kjos <tkjos@android.com>, Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297988-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:arve@android.com,m:cmllamas@google.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:surenb@google.com,m:tkjos@android.com,m:vbabka@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3413F66F9ED

On Wed, Jun 10, 2026 at 04:04:13PM -0700, Dave Hansen wrote:
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> tl;dr: lock_vma_under_rcu() is already a trylock. No need to do both
> it and mmap_read_trylock().
>=20
> Long Version:
>=20
> =3D=3D Background =3D=3D
>=20
> Historically, binder used an mmap_read_trylock() in its shrinker code.
> This ensures that reclaim is not blocked on an mmap_lock. Commit
> 95bc2d4a9020 ("binder: use per-vma lock in page reclaiming") added
> support for the per-VMA lock, but left mmap_read_trylock() as a
> fallback.
>=20
> This was presumably because the per-VMA locking can fail for several
> reasons and most (all?) lock_vma_under_rcu() callers have a fallback
> to mmap_read_trylock().
>=20
> =3D=3D Problem =3D=3D
>=20
> The fallback is not worth the complexity here. lock_vma_under_rcu() is
> essentially already a non-blocking trylock. The main reason it fails
> is also the reason mmap_read_trylock() fails: something is holding
> mmap_write_lock().
>=20
> The only remedy for a collision with mmap_write_lock() is to wait,
> which this code can not do. So the "fallback" after
> lock_vma_under_rcu() failure is not really a fallback: it is really
> likely to just be retrying in vain. That retry in an of itself isn't
> horrible. But it adds complexity.
>=20
> =3D=3D Solution =3D=3D
>=20
> Now that per-VMA locks are universally available, lock_vma_under_rcu()
> will not persistently fail. Rely on it alone and simplify the code.
>=20
> Full disclosure: I originally tried to do this with
> lock_vma_under_rcu_wait(), but it did not fit well with the mmap_lock
> trylock semantics. Claude caught this in a review and suggested the
> approach in this path. It seemed sane to me. So, Suggesed-by: Claude,
> I guess.
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
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
>=20
> --
>=20
> Changes from v1:
>  * Move forward even if 'vma' is NULL in binder_alloc_free_page().
>    This can happen if the VMA is unmapped (Sashiko).
>  * Rename goto label to be more accurate for new lock scheme
>=20
>=20
> ---

This seems to include the list of changes in the commit message instead
of under the --- line.

>  b/drivers/android/binder_alloc.c |   26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
>=20
> diff -puN drivers/android/binder_alloc.c~binder-try-vma-lock drivers/andr=
oid/binder_alloc.c
> --- a/drivers/android/binder_alloc.c~binder-try-vma-lock	2026-06-10 15:57=
:55.274412018 -0700
> +++ b/drivers/android/binder_alloc.c	2026-06-10 15:57:55.277412124 -0700
> @@ -1142,7 +1142,6 @@ enum lru_status binder_alloc_free_page(s
>  	struct vm_area_struct *vma;
>  	struct page *page_to_free;
>  	unsigned long page_addr;
> -	int mm_locked =3D 0;
>  	size_t index;
> =20
>  	if (!mmget_not_zero(mm))
> @@ -1151,15 +1150,12 @@ enum lru_status binder_alloc_free_page(s
>  	index =3D mdata->page_index;
>  	page_addr =3D alloc->vm_start + index * PAGE_SIZE;
> =20
> -	/* attempt per-vma lock first */
> +	/*
> +	 * Attempt per-vma lock. This is essentially a
> +	 * "trylock". It can fail even if the VMA exists
> +	 * for 'page_addr'.
> +	 */
>  	vma =3D lock_vma_under_rcu(mm, page_addr);
> -	if (!vma) {
> -		/* fall back to mmap_lock */
> -		if (!mmap_read_trylock(mm))
> -			goto err_mmap_read_lock_failed;
> -		mm_locked =3D 1;
> -		vma =3D vma_lookup(mm, page_addr);
> -	}
> =20
>  	if (!mutex_trylock(&alloc->mutex))
>  		goto err_get_alloc_mutex_failed;
> @@ -1188,13 +1184,11 @@ enum lru_status binder_alloc_free_page(s
>  		zap_vma_range(vma, page_addr, PAGE_SIZE);
> =20
>  		trace_binder_unmap_user_end(alloc, index);
> +
> +		vma_end_read(vma);
>  	}
> =20
>  	mutex_unlock(&alloc->mutex);
> -	if (mm_locked)
> -		mmap_read_unlock(mm);
> -	else
> -		vma_end_read(vma);
>  	mmput_async(mm);
>  	binder_free_page(page_to_free);
> =20
> @@ -1203,11 +1197,9 @@ enum lru_status binder_alloc_free_page(s
>  err_invalid_vma:
>  	mutex_unlock(&alloc->mutex);
>  err_get_alloc_mutex_failed:
> -	if (mm_locked)
> -		mmap_read_unlock(mm);
> -	else
> +	if (vma)
>  		vma_end_read(vma);
> -err_mmap_read_lock_failed:
> +err_vma_lock_failed:
>  	mmput_async(mm);

If the vma lookup fails because the mmap write lock is held, but the vma
actually exists (has not been unmapped), then this code might "successfully=
"
remove the page without invoking zap_vma_range(). This means that the
page does not actually get freed and will just hang around forever until
the process owning the vma exits or Binder needs this page and maps a
new page on top of the page.

Alice

