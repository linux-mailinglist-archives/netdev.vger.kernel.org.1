Return-Path: <netdev+bounces-280896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBbnEC+06mnACgAAu9opvQ
	(envelope-from <netdev+bounces-280896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:07:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0546458809
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83BD9302E41E
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A7117D6;
	Fri, 24 Apr 2026 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3jygZv4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F95B22097
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776989082; cv=pass; b=TTwmyxNTClc6kJn1pEkZDI1SpoCcC4exiXWSV+ygdrCNSaI3NGN1L6MU/UdutsoxXkn1X4EzR02kv0oquZk7yauAzdqKd1ohLuoX9HFiKlixvczpodvDywBpLfQmkpY2vasuUcGalJ+8dKh+Nu8USTNZUOSrj3P3OF0FHHbNpT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776989082; c=relaxed/simple;
	bh=XYZmYU7R757R+kJImYb8VbDrjzv14DOjMhqjQNfJoKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipL6mDfd8vCqC5r28QNipZMZA6wttAT3EG3+0/0w0cr7s5xygGwDlf9fl4bedfm1TykuIVeKfq79T9ndDHc6aS5X7/xHG8oWqyCITYFlNKb8TNNXq1ES9GBTFHqBgMMfCqCNT159xDBjRCgrxV+jxCwRQMrLXhIiRNyHjyhyyAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3jygZv4; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2503753efso73721975ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 17:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776989081; cv=none;
        d=google.com; s=arc-20240605;
        b=ZFpXCfy5sxZSpJo6u7SLpUDB6js2HDrnfPpQmTbFBJ3DjSVC3HCsNbxhy6pB85Ooou
         7LiurnLt8q5833acWGt22fXqKcaGEk7LJrOeB3dnCnVR6Q2yMaq/O6YuSmd0obPHqVuB
         by3TMZIpkv3YFgqrsi8LX0bdZHsXyz95MR8dOusVdmTFt6jlIewbG5DmM9TWVrAckWWM
         Il5E36MBa03H2/OuZnrLrYn1ab222Y0PCVzrdQ2YgpgvwlhNnI60BEdLNzoKq54MqVkq
         cyxUBkrrqbJlXO84tRnCnzBHT7yq7vtY3Lcx13taJxduNzzdapsL+mXn24p+91nItoDZ
         71/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=25ufDGXhGZece21opl5fPUpmPYr8ALP3YrC4huWBc6A=;
        fh=H4duIC4Ifg9vGood3IveibTUV7DPDWPvNZkZBGjb6xg=;
        b=j1eIMVhYgOu3P+sJk9BIy8l7It4+xWY8FabkSSTTrh13I/62Q48yzvdU0EZ87GFUhn
         poXQqmiHyV8KbBErhkEhkJNCWF5dDrRH1B1hHxK+ezz3IrtlPIIGppbW+my1Vd+xaxKU
         ou6NUDefWkwU+YQCGzKpWgRp/k4pAfOgDNwgIaBQ4gdGdM/Ld+VxhhZk3aGXFA4RKx/I
         RM4viFcthE17c5qAIwwOiuVATvSpqoF+zAtzDlfP47CaLdd/YbFCy4dyY43Glkc0SsE9
         pB2kwPUJn7kNPk0W72lvUyM8rGvniAA+luLSQQd3b7OReGtv7jdgAZkb7nr16N0Vqg5R
         nkaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776989081; x=1777593881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25ufDGXhGZece21opl5fPUpmPYr8ALP3YrC4huWBc6A=;
        b=A3jygZv4bIk99Op6jbxvZZr8GbiUKzO53qyz3+HhgMh/TplF01ByQpKicvv4Ykzhby
         Pm5IU2oI1MrG4JUMOJEtT/fwfIxH9Pq5/aRxfPSdzToysVuZwHNSvuvIsom9ehcs7Y2l
         6m7KHAFnkikQkcfVjmZzsL2QpCsECyzvX1w9OzsrSArH5IXUo4TfbEG4C5uAzukZz1Ky
         quqVDFav/q3orgLt4pcS01o2ViUe5hPSVL2lxF3GfEXZPRlH2w8Wv4biW5pjVUw5hCC1
         mZG5tfRGpPqwQcGGod/X124zyC2QlddtN3vDsITkw0d+qyrbY9nuWStxGJ4W96VMJsCi
         +aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776989081; x=1777593881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25ufDGXhGZece21opl5fPUpmPYr8ALP3YrC4huWBc6A=;
        b=fVmU9jZasAFHJDewAF+4LMB9vWOUoO/FgQiA1jI/mnCBND1uAlPolIUZjnpBwEdDg3
         J1OvITaK/J/ZhX96ZMeNKHS3YKx2tMny7jkf1OnqD71qMyBsq8JZZ3XK/ok2uwXvDztA
         hbr3ve22OWL4elGJKj6Hbkaoi8KkDPQ0yAmsZK9tB5HyJ7i0KosmWginpQjU1iDQybh0
         /NaJJJW3q4XjDNfw9rQE0JVZkLsvDK0wE4bnoZ6tvdVbtoez9/50JZ/8WX10seWCz99X
         1I+v2QnnLhE4+tnh3dK7PoByL1I7wRgMPPIhTfmmm7IJi64BNYBbO4GHxcl8wg1hvfUg
         +2ww==
X-Forwarded-Encrypted: i=1; AFNElJ9tjoyM/dqxbBggngH/ZzdpvLzE2gV/+TRIXACxp/c2bs8s0mv5/qLZ4hAaa5MM7GFH+2skujI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYB2+XbOVMoTLmsi1rYIMSgNaSRQ6shYerxJJFFWAuGL9ujq8
	9bgrkP/5AgSNHZVQo2nvdNEZv5Kdcq6WlH6QvqmD55uG/CUfkR1xD0q0EGfCfnQc5UotaRu+EGq
	a0Awtx79C3mAj+zRGvrxQacNbAjQdiOeZzQ==
X-Gm-Gg: AeBDietErgjheeaRKdq9JckkkRJ/+Vw+5PE2ACLgG+pY8rdszilunrsnnXf6orPrWdc
	TLwg4QoxwkqqYWpjjElcVLCZgBzOD8ZSYywtp3WIM/oXJ+ZqIPN2WPIvkyu2FdEPLLVdVDqyjhU
	ICJqTlMFfiM9H0mtmbLmdUjyPNNBWWzlViNKlyGikeK/YM+IgEvkxfAiXtrJ7IMqtbtDG1vU8fA
	s326p3L9i/1ytv+zh+6C/051xWWSE/TRGoiRitiXihJ7DY6UWvg5GuLIqLxwOGO07a3bJZ3HXs9
	PCHi38fSISkdPMlEqmNKaDpLg8INR9Tmyw==
X-Received: by 2002:a17:902:7c0f:b0:2b2:81aa:f6c3 with SMTP id
 d9443c01a7336-2b5f9f6408emr248803555ad.29.1776989080715; Thu, 23 Apr 2026
 17:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421221016.2967924-1-ameryhung@gmail.com> <20260421221016.2967924-4-ameryhung@gmail.com>
In-Reply-To: <20260421221016.2967924-4-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Apr 2026 17:04:25 -0700
X-Gm-Features: AQROBzDTUcAGssQhOFcSS6UXDb2vYMnNc_kbBkRlJMvtnJ84oTJ7xeXG6eX-fzc
Message-ID: <CAEf4BzYoZaEPjbFBdUQP6kGYz-YPUKzYY1ngGhu0wNCLzT26=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] bpf: Preserve reg->id of pointer objects
 after null-check
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A0546458809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280896-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 21, 2026 at 3:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
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
> Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A=
)  States (B)  States (DIFF)
> ------------------------  ---------  ---------  --------------  ---------=
-  ----------  -------------
> rbtree_search                  6820       7326   +506 (+7.42%)         37=
9         398   +19 (+5.01%)
>
> Meta BPF objects with insns_diff > 0
>
> Program                   Insns (A)  Insns (B)  Insns   (DIFF)  States (A=
)  States (B)  States (DIFF)
> ------------------------  ---------  ---------  --------------  ---------=
-  ----------  -------------
> ned_imex_be_tclass               52         57     +5 (+9.62%)           =
5           6   +1 (+20.00%)
> ned_imex_be_tclass               52         57     +5 (+9.62%)           =
5           6   +1 (+20.00%)
> ned_skop_auto_flowlabel         523        526     +3 (+0.57%)          3=
9          40    +1 (+2.56%)
> ned_skop_mss                    289        292     +3 (+1.04%)          2=
0          20    +0 (+0.00%)
> ned_skopt_bet_classifier         78         82     +4 (+5.13%)           =
8           8    +0 (+0.00%)
> dctcp_update_alpha              252        320   +68 (+26.98%)          2=
1          27   +6 (+28.57%)
> dctcp_update_alpha              252        320   +68 (+26.98%)          2=
1          27   +6 (+28.57%)
> ned_ts_func                     119        126     +7 (+5.88%)           =
6           7   +1 (+16.67%)
> tw_egress                      1119       1128     +9 (+0.80%)          9=
5          96    +1 (+1.05%)
> tw_ingress                     1128       1137     +9 (+0.80%)          9=
5          96    +1 (+1.05%)
> tw_tproxy_router               4380       4465    +85 (+1.94%)         11=
4         118    +4 (+3.51%)
> tw_tproxy_router4              3093       3170    +77 (+2.49%)          8=
3          88    +5 (+6.02%)
> ttls_tc_ingress               34656      35717  +1061 (+3.06%)         93=
6         970   +34 (+3.63%)
> tw_twfw_egress               222327     222338    +11 (+0.00%)       1056=
3       10564    +1 (+0.01%)
> tw_twfw_ingress               78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       1058=
4       10585    +1 (+0.01%)
> tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_egress                 8080       8085     +5 (+0.06%)         45=
6         456    +0 (+0.00%)
> tw_twfw_ingress                8053       8056     +3 (+0.04%)         45=
4         454    +0 (+0.00%)
> tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         45=
6         457    +1 (+0.22%)
> tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         45=
5         455    +0 (+0.00%)
> tw_twfw_egress               222327     222338    +11 (+0.00%)       1056=
3       10564    +1 (+0.01%)
> tw_twfw_ingress               78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_tc_eg                222839     222859    +20 (+0.01%)       1058=
4       10585    +1 (+0.01%)
> tw_twfw_tc_in                 78295      78299     +4 (+0.01%)        382=
5        3826    +1 (+0.03%)
> tw_twfw_egress                 8080       8085     +5 (+0.06%)         45=
6         456    +0 (+0.00%)
> tw_twfw_ingress                8053       8056     +3 (+0.04%)         45=
4         454    +0 (+0.00%)
> tw_twfw_tc_eg                  8154       8174    +20 (+0.25%)         45=
6         457    +1 (+0.22%)
> tw_twfw_tc_in                  8060       8063     +3 (+0.04%)         45=
5         455    +0 (+0.00%)
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

totally seems worth doing

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 93003a2a96b0..0313b7d5f6c9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15886,15 +15886,10 @@ static void mark_ptr_or_null_reg(struct bpf_fun=
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
>         }
>  }
>
> --
> 2.52.0
>

