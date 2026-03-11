Return-Path: <netdev+bounces-266786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIPtDzTssWmSHAAAu9opvQ
	(envelope-from <netdev+bounces-266786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:27:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8C26AE23
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 23:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FBAD3044811
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E92391832;
	Wed, 11 Mar 2026 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAeE6Qas"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37527390C8B
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 22:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268017; cv=pass; b=IHXUMhL0/aEj1Lf/6WNUO8QlB+ZqEB9k++mVl7nxHsn54G4tMusmSgRqoAW+XJa1PUpE41Ln3bfGtVv472wXAcumiT6ordxMc6QFZN4T4aY4XJtquPJa3AFJGSIOA38XY2Uk+zbsjBLhY7b/v23mXmih6fJZThsyAWGVFu+/RBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268017; c=relaxed/simple;
	bh=r8jTi1Csxc7R0q0iu4I1AKO4pE2K1C13bkXgSq4z/Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk/xD9U9mVF+zebQm7sXDcU+33t3hq9AXiytwFYmf1uZeitO1Xvg8jHPdbGzC2i1w1Ubu1omgFLKofOUe7dbG6QFxBs/csWxwPUihzhStnENuoWZe8QqKHXXIAsQJ86uMky8TrtFwQHaSdfHfyL2ZZ1KqNS6GQlk1p7TvPsy9ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAeE6Qas; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853aec185aso2625375e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 15:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773268014; cv=none;
        d=google.com; s=arc-20240605;
        b=duIVO+WcfwXy1znMNXgqMmgRh9tXenoaxD38JJua9VL3YlAUfHbgBcdEC/eBR9ZYpa
         BnmMhJTRUlKqWOwMNEutMxGic2NflRgrBO+L4rj+RDOI4zITvp8Q6HzoP4oiyvsWIgmC
         /nVkiPwfFbVm2TsrhsqO2zl6P6m2cZo0P3GnrDKvIBChOYcxc8wnc3BWAtTiNJ0F9j6l
         Y7hPmiNUHbynzajHmNMqHsGd1828oHE0GXGILNg+g/ZpWdb/wothIuPB3FHMsFgLqvyk
         VaeT+QzA9i+/2/tLQtzwrWWl9aAAa5D7hxayHQleqed8gKb58tCWcPTh2b9BHqB9OYKJ
         vrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=22t/Dvy/x6Uq+dtSCro/4b+TaKfnHX5FGmjqe92Ip0Q=;
        fh=TWfw/k/fCN2hw4+fuaqCiIAuud90Ou0k4EkjclwSRBU=;
        b=X12EwUuZ3uaC2R1uvfFCYJBuEB5B3HYze2nxK02begTP3Mw5dO54fCgKf+dixurMUh
         g1HbKvwkjxAG4cQ+vBbCyOEzzZZ/33KQ9eV5amfSmE+Pi+d2hVwcVYNDHCImxafPiIcg
         ld/e9K8spza715q9sZt9dRWUgy+OyvkfoNfrj4OajbndW9dZU7N0el/aSMPTT6zydsHr
         XRgNu9/8BihXVhRSCl2FLnq6suEnAyeLj1zmH2cNMaYNDuR2AitJNKvCyw/6phAosMBT
         2HzPVSSF+ItMxfehuh8w1ty8HyyadMwCFTY8jM4bqrTZy2tudgjVAYM7jBx4qNPlROBI
         fRAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773268014; x=1773872814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22t/Dvy/x6Uq+dtSCro/4b+TaKfnHX5FGmjqe92Ip0Q=;
        b=hAeE6QasMwmuLTHE5Xg04bjE3V7BkdjHL4LUN0xoUUrLfTAN6BnDVyxlrsVfx3lBn9
         Mr5Dwi4ymL2LO1LZmUDfiGyT5cgxcklDdsseiv+itOciC2bDOv5WJTYQZBmKkyAQigpS
         IfssUP5cOqPvDSB52qLl+VrnFI9Wau8qIomAX+lTabm0FZ5UsKkxZnC9h6oyaBENlTIQ
         eveqDqSWlTKx16YZBR/QewmQ1VMXMOH7frDFZWX5OdRLyXmFakQ6h35k3hOYG9jSW6cY
         UQMtPRTn5hTI6m28cICP0wTs+EXhdUM5t9ftFmYRYgzCYFA5WQKt3ztcIbQgyAgivWdm
         kChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773268014; x=1773872814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=22t/Dvy/x6Uq+dtSCro/4b+TaKfnHX5FGmjqe92Ip0Q=;
        b=T49HO2yr/mgRaldJ78Ny8BqIyQ3Nqwji92ktcc8SP5l3fu1KPzMn9Vo2hLuY+v4UVy
         CUMwqYXOtwSabOTNetjRe1XtM6FikB7LkXiexAMC0z0SHY8EjpHlTzO6Y9yslViIPyHp
         4Co7RumznZ+g4eQf+Z0ctswZNlM5hwRCnFVYhA6OHXTJiqRz+q+AOYGAbncKs2r8lHNh
         6pB8iWk9aXzStiC/FYMuefM907XWQCc8BwDiTkmjsEmKrNAfRjjnBs5LTSf0TPfgZGDh
         ITs9Lbf4E1423YyM6WfZaEbL/cg1q1KO22kq1ZgJMjbGbjk0k+s4M3isQLAd4LJR76N0
         GuGw==
X-Forwarded-Encrypted: i=1; AJvYcCWeLAnPK9smMdldk7IQfbCwbcxmD11M0HHr5UvI9QEla6oqyv0oJYkhxt1KwGX6QTaR9p6g3t0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsoaaa4owODX59kw5puWiOr9o2BUD/ouSBnj+xcoXwOMF0BjF/
	HqM3niV5eHINi5iUoG793Thqb/4qxHQsrK+xTPmrR1oAWATj8Z2eemfrLwOwv05p6SbMnngyE1/
	VquaLnnz/9VYCuyfTIhoiji68iYAOgJA=
X-Gm-Gg: ATEYQzzc6VhWl+aPPYF1yINWhm97FG7ewZZxJygvrNFiPvbuIgavordBJPt2kcYTD91
	QonZ3PH0po4Jk/V3IbHcok5tVA+/ddEXDSMGUXy/C6nJJXDoZIWQq5ReZh6VU0tU+cYYQDF/BJV
	2ZUn0EwaS3isV3o2tbwv0g7E/c/9CnCgNMyseKcs0Ax5D+5CxXYYDM4rnxIiuaxbzK/alQo+K/j
	f2D29J/t91CEU2hl1S4kEkvCFjCA0F461e4i5TNU+mhNXurBOHs0/nZWEPd2Pz0qhbyydwUMKju
	nFSnKbZ1SmEFqhaXNGEIX41wGRYobXdi0nRX0M5hNL0tn2nifohvHMgRQ9AN0nPmP1l1DYHOjFd
	yT1qdc20FOvleG3LmQ6C0C3wTyw==
X-Received: by 2002:a05:600c:8b13:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-4854b100f1emr75351175e9.17.1773268014330; Wed, 11 Mar 2026
 15:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-6-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-6-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Mar 2026 15:26:43 -0700
X-Gm-Features: AaiRm50uM1nDQ6hNKBviIGUZSODpYpE_TfMdI9RiPggFO3AjukNsZ_VG5AnuJl4
Message-ID: <CAADnVQKkXKyqqW5zFC+N2NaU+7wD1XouqF9T=ReNivCKDWcFiQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer
 objects after null-check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-266786-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99A8C26AE23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 6, 2026 at 10:44=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Preserve reg->id of pointer objects after null-checking the register so
> that children objects derived from it can still refer to it in the new
> object relationship tracking mechanism introduced in a later patch. This
> change incurs a slight increase in the number of states in one selftest
> bpf object, rbtree_search.bpf.o. For Meta bpf objects, the increase of
> states is also negligible.
>
> Selftest BPF objects with insns_diff > 0
>
> Insns (A)  Insns (B)  Insns  (DIFF)  States (A)  States (B)  States (DIFF=
)
> ---------  ---------  -------------  ----------  ----------  ------------=
-
>      7309       7814  +505 (+6.91%)         394         413   +19 (+4.82%=
)
>
> Meta BPF objects with insns_diff > 0
>
> Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIF=
F)
> ---------  ---------  --------------  ----------  ----------  -----------=
--
>        52         57     +5 (+9.62%)           5           6   +1 (+20.00=
%)
>        52         57     +5 (+9.62%)           5           6   +1 (+20.00=
%)
>       676        679     +3 (+0.44%)          54          54    +0 (+0.00=
%)
>       289        292     +3 (+1.04%)          20          20    +0 (+0.00=
%)
>        78         82     +4 (+5.13%)           8           8    +0 (+0.00=
%)
>       252        320   +68 (+26.98%)          21          27   +6 (+28.57=
%)
>       252        320   +68 (+26.98%)          21          27   +6 (+28.57=
%)
>       119        126     +7 (+5.88%)           6           7   +1 (+16.67=
%)
>      1119       1128     +9 (+0.80%)          95          96    +1 (+1.05=
%)
>      1128       1137     +9 (+0.80%)          95          96    +1 (+1.05=
%)
>      4380       4465    +85 (+1.94%)         114         118    +4 (+3.51=
%)
>      3093       3170    +77 (+2.49%)          83          88    +5 (+6.02=
%)
>     30181      31224  +1043 (+3.46%)         832         863   +31 (+3.73=
%)
>    237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.01=
%)
>     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02=
%)
>    237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.01=
%)
>     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02=
%)
>      8103       8108     +5 (+0.06%)         459         459    +0 (+0.00=
%)
>      8076       8079     +3 (+0.04%)         457         457    +0 (+0.00=
%)
>      8177       8197    +20 (+0.24%)         459         460    +1 (+0.22=
%)
>      8083       8086     +3 (+0.04%)         458         458    +0 (+0.00=
%)
>    237608     237619    +11 (+0.00%)       11670       11671    +1 (+0.01=
%)
>     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02=
%)
>    237387     237407    +20 (+0.01%)       11651       11652    +1 (+0.01=
%)
>     94832      94836     +4 (+0.00%)        4787        4788    +1 (+0.02=
%)
>      8103       8108     +5 (+0.06%)         459         459    +0 (+0.00=
%)
>      8076       8079     +3 (+0.04%)         457         457    +0 (+0.00=
%)
>      8177       8197    +20 (+0.24%)         459         460    +1 (+0.22=
%)
>      8083       8086     +3 (+0.04%)         458         458    +0 (+0.00=
%)

The table is missing names.
State columns can be dropped instead.

> Looking into rbtree_search, the reason for such increase is that the
> verifier has to explore the main loop shown below for one more iteration
> until state pruning decides the current state is safe.
>
> long rbtree_search(void *ctx)
> {
>         ...
>         bpf_spin_lock(&glock0);
>         rb_n =3D bpf_rbtree_root(&groot0);
>         while (can_loop) {
>                 if (!rb_n) {
>                         bpf_spin_unlock(&glock0);
>                         return __LINE__;
>                 }
>
>                 n =3D rb_entry(rb_n, struct node_data, r0);
>                 if (lookup_key =3D=3D n->key0)
>                         break;
>                 if (nr_gc < NR_NODES)
>                         gc_ns[nr_gc++] =3D rb_n;
>                 if (lookup_key < n->key0)
>                         rb_n =3D bpf_rbtree_left(&groot0, rb_n);
>                 else
>                         rb_n =3D bpf_rbtree_right(&groot0, rb_n);
>         }
>         ...
> }
>
> Below is what the verifier sees at the start of each iteration
> (65: may_goto) after preserving id of rb_n. Without id of rb_n, the
> verifier stops exploring the loop at iter 16.
>
>            rb_n  gc_ns[15]
> iter 15    257   257
>
> iter 16    290   257    rb_n: idmap add 257->290
>                         gc_ns[15]: check 257 !=3D 290 --> state not equal
>
> iter 17    325   257    rb_n: idmap add 290->325
>                         gc_ns[15]: idmap add 257->257 --> state safe

I'm not following. The verifier processes above as a bounded loop.
All 16 (NR_NODES) iterations.

Why presence of id on 'rb_n' makes a difference?
It will still process 16 loops.

Which insn is safe vs not in the above ?
One after gc_ns[nr_gc++] =3D rb_n ?

