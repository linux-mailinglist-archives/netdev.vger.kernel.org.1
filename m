Return-Path: <netdev+bounces-266783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D2OXJuvksWmcGwAAu9opvQ
	(envelope-from <netdev+bounces-266783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:55:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 086F726A9D8
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 22:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2CEE30429B3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD2334C0D;
	Wed, 11 Mar 2026 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/J0xjuJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4253090D9
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266151; cv=pass; b=XBO4xIEywHLi1X8+Iaj3JqS7NlUeFXBE92KtvIIKl1YngP+p3zegFZ00iBAvnhLVKA9D5rTZDWiWmz1eI5VBKb2YEhg6IquI4TQDZaEmWROu/HkkihnSbgCG7QHn2IdkggbHQ2QQbi4xTSSf3t58nDlrSwYZS+gW9TMa2Qp6btw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266151; c=relaxed/simple;
	bh=MahSrqLDYZgcCSnQXbJvJA4ds9Jyo62y5vMoFtBVKTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNjTQUQq0aNCerXNjP0x8EnXhqAZh7ApHnKUAecqAbciHbi5AH/reOoS30tiVEbM58S/fJKkLyJLpr+riC2S+xXJGYSUyGGb+fVppQfeV0H/7nnhjOwqhEeL9IhHNSgErbcd66dEEyDMkpQCughjtIW5Q5oA3IseXAbJwsQpSic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/J0xjuJ; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824c9da9928so211323b3a.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 14:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773266149; cv=none;
        d=google.com; s=arc-20240605;
        b=CDI+zupmTCgCIQNrnuSmqat0jc8ls7iwVIsazaSUgBhZFXqqMo61M6sskX+opmBf8u
         56m8bHivAZUMvBx1MyZ1COWNrz8tHm5k5aOGh58WaPeja+FQuHmi7aOFiLmqVCQ2EUAE
         jKrQw7spNUkze2q8uw1u/OCbmoT3kh0g6O9qwa3bg0mO6fyhLkmYD4m3SUbs6KbJZVxn
         Jk+NBin+DpyOLSOIkDDPrk1e1XInGMjUN3TwzZpD9z7CJXzuz+RSJYF9QXnSAiWSvvwd
         11kL9QpabM3HYbNzflIKgCvWHJkg2u3i+QibwAtVp9I6zeaqDMh1vnZfxbv5S2j1H4oH
         ZzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PolrGNrN8v5vl9MZ7nmCqzTd9hT7eSXkSoKDfYU1uTo=;
        fh=kCHmrFCpL0RuDiJU+lezFni8yl5GEB7KDKOrPeq3XEk=;
        b=bViwgDn/BJINFAz7jM8NEWuJmWj6Uw4TWJkbHbau/ZmnHat44ptk7ZaoF/4CcTijLI
         S7ySO62q2IaW66nrRYSK2NCXIrdQ9romuIbvlz97HBUZvTguDAneeOPLPX7WtCZJqBeh
         pRCTca/mVa9+NqM3uXxMJSyyCQOydnHYJEcxeb4WSMPZ3QqrOZn/EwKL5XQJMFgA1rZT
         DDlGhbx+gopRd2yxQonyFtp63W7G93OmLl3/k53EHryCEaCtpZ/iZq+n7XHcKACiDvZ+
         K/Ioy/ZPqJWazUb5XtItU8rVohk2omSipEtiDK/uxDYKVkRPGK1Iz9futVmj6cttpCea
         DvVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773266149; x=1773870949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PolrGNrN8v5vl9MZ7nmCqzTd9hT7eSXkSoKDfYU1uTo=;
        b=f/J0xjuJL3fJZeNNADU7faRUYBuzDnciYfypIn/Q4qOPLppB9hIoMgql0K6OAKQaV3
         zgPY9+g6A86Jnb79Xdi+Nv6c0Px3HXc6eJwlJOQ+a2IW5HshZa8+g8bVyvsvsesoA7AX
         Btp5ZLp4NpymldtPLGUg3uaDOMXFIbGAsIPSnfXTA7EDsawDYgeSMW00M3OSMQrQuDms
         AxBbJjrKVumBUTedXtMcCErsETMFVzc6lmITFSKtCdDxMSaYafsgWgmAqy6sNkcpOtuy
         2Sxp/vE/vw7jVU8VzMdjHex3QTNmkPHeOpRKf6qhC7K44wJziOnVbJtaIufejAS0AbtQ
         Iu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773266149; x=1773870949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PolrGNrN8v5vl9MZ7nmCqzTd9hT7eSXkSoKDfYU1uTo=;
        b=t0cenkRTTs4lpO9oSXpwr0QeBUC/OWS9CPiKqG8nTeuSdKDuIgm+F0nUbZcwQNnYz8
         rBaOZ2ldffR2YEH5myJRXam6gx4Ieo47zlDMd1BoGHRFoTjOFZd3kISij1tzLHMKRbnw
         060tQFwNOBLtcJ3oWKidsEiHqyj2wwOUDY/E3RuPmNR63Ke8dkx+FRsj+jMgiZqFyWR4
         a0I79UHNihbPc8qzLV5wwB+PTudmwruEfGCIYuAWhZaHHpkuGC0/dTUdlr6atLa9SimX
         ZgfM9D0UUCq+z1vscdTz7BQujDv/ii5RIa7LTcmYi5f7VzrwWzT0VYoYBaHSIYf5Fn3b
         bxcg==
X-Forwarded-Encrypted: i=1; AJvYcCU1dbY/zWpNlEtGt2TI+XgtO7y6NOEGkGHWPAVAnM19+KA7ZzBs87bFit0bTc4jQp87FZL1PCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQAqbAOzKfeYbZihLZGWSKpwyc6VtA0F/S8rbjVuNIKNcrkIOD
	VqYbiZMhDYwIhVQjnmvpDKRXkGK5r7h8bbtJvFaZpuqPD0J/Xl1PIbOEaT9e/raoFvqL04oltOu
	1q9D5E8cFkkWSn2GnIBVYM50ENdeL52c=
X-Gm-Gg: ATEYQzyD4CevRZL3qishyIQvAZ3iLmbDON7hJjwTBq21HNvkKWo3v3pEPVlf19DHT81
	jpuwjArptotdYBlCKNwjSqwjXWaIUI0Zj/8Mfg6sYDOpEPNl5mgD1e8MyygIarpTMWTKor6czQa
	h7wITtRtxWj0ClZHwMYq8V4PLaFbVqqZtqxrid+Unx8D8jCdDqLV10tY6cCH2HnJLfwN58tpxgR
	0YkE0Va17qyWRBnZkzo1yl0j71MDDoOM4+OOwJpV/frD1UjmgzhgWtQXjc+q5BWTE2misdyWm4t
	dlIMWsU=
X-Received: by 2002:a05:6a00:2d28:b0:81e:c67a:1a79 with SMTP id
 d2e1a72fcca58-829f6ec4863mr3698583b3a.25.1773266149145; Wed, 11 Mar 2026
 14:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307064439.3247440-1-ameryhung@gmail.com> <20260307064439.3247440-6-ameryhung@gmail.com>
In-Reply-To: <20260307064439.3247440-6-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 14:55:35 -0700
X-Gm-Features: AaiRm52eCJzfPSFUWrlGtQvYkTOCEjIgp7Uc7ph63emkxA69h0KfqjvrrU11yjs
Message-ID: <CAEf4BzZACu7YVvFt__iR=rhMCoA2cpbD0wqswz31JXU+BD-RMA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 05/11] bpf: Preserve reg->id of pointer
 objects after null-check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, memxor@gmail.com, 
	martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266783-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 086F726A9D8
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
>
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
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  kernel/bpf/verifier.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ea10dd611df2..8f9e28901bc4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17014,15 +17014,10 @@ static void mark_ptr_or_null_reg(struct bpf_fun=
c_state *state,
>
>                 mark_ptr_not_null_reg(reg);
>
> -               if (!reg_may_point_to_spin_lock(reg)) {
> -                       /* For not-NULL ptr, reg->ref_obj_id will be rese=
t
> -                        * in release_reference().
> -                        *
> -                        * reg->id is still used by spin_lock ptr. Other
> -                        * than spin_lock ptr type, reg->id can be reset.
> -                        */
> -                       reg->id =3D 0;
> -               }
> +               /*
> +                * reg->id is preserved for object relationship tracking
> +                * and spin_lock lock state tracking
> +                */

Acked-by: Andrii Nakryiko <andrii@kernel.org>

nice to have one less special case

>         }
>  }
>
> --
> 2.47.3
>

