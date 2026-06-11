Return-Path: <netdev+bounces-298348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4bAbAA0eK2q42wMAu9opvQ
	(envelope-from <netdev+bounces-298348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D96675437
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=O0Z0cfmt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298348-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298348-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 797AA3011F00
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CC84C77AC;
	Thu, 11 Jun 2026 20:40:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431124C6F14
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:40:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210451; cv=pass; b=NwRbvmqG81FyvLF4sB9qKW3AJCjk5ODZUvHD3cUIa09h/NOzKaxZwb7GDg2aNbXp8Rhv7zQmR/wp7nVisgGKxNIqnPuFgYICSMNCW+OHloR/t0U6pM/pFu8uoW0Ad/jAdSyewQFbhNOjqSq0kPvU07hPmyG0BvDLQYoQfC9piEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210451; c=relaxed/simple;
	bh=UW5h7kQOcsoL7dlEsXTdWsLlFYf/7tFpO4dUX5ItpCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rp41a2Lwwx5yqeS2Ma5PsnYLQXUNgyXk8PGO8oXuKqr57WN7F/yidr7tDIc8wQB33MPf06zqVCwnLgcAzEA/N2TQYP/QfUZ9fbHQoJuUZYdLaoU5f1C7h2jMh6QdUte6kHhgn2ba7VGkXRFN+nb1ZtN0HcBCXK6YTB+6vgJqmhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0Z0cfmt; arc=pass smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5175d339e8bso156851cf.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781210446; cv=none;
        d=google.com; s=arc-20240605;
        b=XUG2oFrvBfO0AVIp5vwedf/ExuNQN9TOEbHHnReBiTleC/TqHTEMRH1TfZI7qbGZJH
         OLU7jNISVsKvsW5Dvuc2e65NnuMx7WETbK6cb8KeQ5h33vH1k92BXAWNtL/OKm0Lat3K
         8nZS1taG1YVNF6t3GU5MHE1FpkBNEPbrZQooVNB3O2aEPkyZq84nKXcVCkRPYx9cLbTL
         lTPlFwzjQuEHPr/QJtrk6pxZNn3lY+IY2j5rGi65qxS3snp0NNYkJ1gzXr7My3/tr/fd
         YezzUrXgz+BxwzKtRtf3Qn+D4CV9bLNM3jbmDXk9M6LEBhhRwtjQ3cOfPd1i+eU41fGr
         jryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a67OUTXkhjPmGT9xbEw7aC5sM6vpNtps3UHtPFQcUpU=;
        fh=8BhG7yrFByPd/DBAdVXXxVEeKrkiMI8FW979824XyIM=;
        b=PxeBTWePpzXOkxviMUDSONL24Ws8aRs8pja6PCX0CCpHoIABWFpSYofPw2z0D8jiyq
         6eKpV03vGVFcYM/wsY08ymX9HrqwberIL5BDSsSKm1eSXUj71SmH7YzYwEhZK1ulnd+D
         v2Fh28nBjSZlqf4iGyZtVj9Etf6MTF+AYexJ5fboPGGdym/xMrabGK9GpX8G4UcFCrZF
         jrjNtA8DCGxVp/Ns0IedU467KtcCsyXocRpnFuvGtEUOQ5LYk9EF0tDuu+yqJY8amcKK
         QOCdLBm7r2R3vFd3J6A8vnF/b7lagiQD6e9uCeYVaYSl4/f8MwdbCz3iICZiQw2PDHHa
         4IJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210446; x=1781815246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a67OUTXkhjPmGT9xbEw7aC5sM6vpNtps3UHtPFQcUpU=;
        b=O0Z0cfmtaTkho6MN2MEcS/myzoixTpjQev5SeymIxvfcppNj46lu+w7Nw6soc8RGhI
         gTpdptNzCQuvCmTHjoG2KocIKRjn1dT8fOKnQ25b5pdn/peuyW0l6iIG3Fmifv+vVBIU
         s8Y1kz8C3lv4JnbMlt2v0s6QDz6mX0QrLYZPQQCkrcwpVCTwGDfWLwjeWFcexhdfPkOY
         cU2XgDI8Pt+pvTjVkf6060Ujj0bmhNiMdNhkevLCtzJm73+zbcbsIzlzpxl+Usx5e8Rj
         ZAW3F5q+sSDFIb8rE+tIYZMUXz+2MwHkPwCp882MSiUZeoj1Rh0kiqLl2TK2O8yXyNeF
         JLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210446; x=1781815246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a67OUTXkhjPmGT9xbEw7aC5sM6vpNtps3UHtPFQcUpU=;
        b=kaG7xvHn/y44Vef5YESq9rZVmCI/NXW0IYy7EBIMFSoHTkVtu2KaTsq6jZEE/YROCf
         tBxFysy9UiDIF5xAP1j7NGRok/NYYOYpwlQkbcGmyu3G3nesyTXSzFkT/lB3fAZBYnsg
         x4ui869ubRHG+nic7BlWPGsfieQrUgDvgTmEXcWsJGDsUbv4PrvVHSgohHQ1P2Z730Nb
         eYzbsTX5YcFVu7BEe1gsv25MIiU0uMrcq/oCLFssk7adYD3Sk194iankoEutifSkeCIS
         pSxLPhqRr2bF4kitcshtpuKa41AHK63fUxv3TeFzuE2S5no3/cpbzEYBnxUBiDvpLukd
         PnFA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZPhDUSqbavrzKGo5y6e4lprGCMYN+L/LyP1MGRjCdlQp7HQSwBpipPg+AyppoUAuuCRiDZew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsAubgnQeXTt9Px85zntTaG4uzxJCS3Gsl/9906sVXNitGMDoq
	evw+T2+JitQ6iqOS7RTA7OWdCY0pnvQ/W8yMIDyyWv+K7hiKQRXqhkTIvDh0CFJSpip6NuFwomf
	JTeoyDKYirvDlLohL3QF1BspUrzriHMYM1jIoE5w7
X-Gm-Gg: Acq92OH6g9rkQkRwbIjdCYJEpAKv78HY2iewqxpV6KSLHEhDAMDGHnjKy9fKq5iUdDz
	IsQdW296shP0gOxuUMCPB8mO+ChBa7Z69v/cUU7rZQu0N82/i3JEurkfWTPcWvyCCldxSvxmeK+
	Z3gGDtEmv1vfHrIZY9Y8lbE5qu9KbuBAOQ/7poU2EJ59E9NJxgsFX+NUFMdBGW3gc9n07o8YNXZ
	UU1vo8m/JNHwqfjIytP1Dix2mq8NzmC1PlFk/Pgyr9znTcj9ULW73yL8Vc84Cwi9U87JhALhrx0
	28NxkdH+AMUTtNOvNMuA9zFJD2vuwR1HteM7
X-Received: by 2002:ac8:7d0a:0:b0:516:4f62:85ef with SMTP id
 d75a77b69052e-517fb16d601mr2052891cf.20.1781210444924; Thu, 11 Jun 2026
 13:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230409.A44D29FA@davehans-spike.ostc.intel.com> <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>
In-Reply-To: <20260610230417.77D64DBB@davehans-spike.ostc.intel.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jun 2026 13:40:32 -0700
X-Gm-Features: AVVi8Cew8aBPn6x6_sXyc7lWo3YXmdpq0raUK5xFBrEewhgPTGQ_KDM8NSP7OKA
Message-ID: <CAJuCfpE8VsYTfHA2Qbv-KXBKOV-e4e1MDNJdDYgMCEPjtosgOg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] binder: Remove mmap_lock fallback
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-298348-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49D96675437

On Wed, Jun 10, 2026 at 4:04=E2=80=AFPM Dave Hansen <dave.hansen@linux.inte=
l.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Previously, the per-VMA locking could fail in the face of writers
> which necessitate a fallback to mmap_lock. The new
> vma_start_read_unlocked() will wait for writers instead of failing.
>
> Use the new helper. Wait for writers. Remove the fallback to mmap_lock.

Nice!

>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Lorenzo Stoakes <ljs@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
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
>
> ---
>
>  b/drivers/android/binder_alloc.c |   17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff -puN drivers/android/binder_alloc.c~binder-vma-waiter drivers/androi=
d/binder_alloc.c
> --- a/drivers/android/binder_alloc.c~binder-vma-waiter  2026-06-10 15:57:=
56.419452721 -0700
> +++ b/drivers/android/binder_alloc.c    2026-06-10 15:57:56.423452863 -07=
00
> @@ -259,21 +259,14 @@ static int binder_page_insert(struct bin
>         struct vm_area_struct *vma;
>         int ret =3D -ESRCH;
>
> -       /* attempt per-vma lock first */
> -       vma =3D lock_vma_under_rcu(mm, addr);
> -       if (vma) {
> -               if (binder_alloc_is_mapped(alloc))
> -                       ret =3D vm_insert_page(vma, addr, page);
> -               vma_end_read(vma);
> +       vma =3D vma_start_read_unlocked(mm, addr);
> +       if (!vma)
>                 return ret;
> -       }
>
> -       /* fall back to mmap_lock */
> -       mmap_read_lock(mm);
> -       vma =3D vma_lookup(mm, addr);
> -       if (vma && binder_alloc_is_mapped(alloc))
> +       if (binder_alloc_is_mapped(alloc))
>                 ret =3D vm_insert_page(vma, addr, page);
> -       mmap_read_unlock(mm);
> +
> +       vma_end_read(vma);
>
>         return ret;
>  }
> _

