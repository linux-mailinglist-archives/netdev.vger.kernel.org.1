Return-Path: <netdev+bounces-265215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM01E5+6rGmDtgEAu9opvQ
	(envelope-from <netdev+bounces-265215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 00:54:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A289622E07A
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 00:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0D6301AF7E
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 23:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7362F99BD;
	Sat,  7 Mar 2026 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2DUKnzaj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580DD18CBE1
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772927644; cv=pass; b=sJwWhEC4jv3lLaElkcOVKNYtSMMs13iKfk78nexvfQ5k6qwfF346Zd8J71VGUiDHJMT3ccepjHy6rGOoFwlR4fzMmppE2wZEM32gymVTyfuAeD48ez1AYtthTlnDtb8OY3uMrDWBdn9Aun9Q1nYhvREpyW3/3StKbtds/XDQEFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772927644; c=relaxed/simple;
	bh=jvNjsmTzZlWTA1QEr930aA2AeasK55Y0T9pcZb3b0ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0zMdyRgUi2d3j8k6+uPn8/Fdel+JoYMjfpZz6XlCdarqP6TaUUK+HrhINGRNzRQYrrIGdaVLJvsvAjw1Nn9DDs7azsv153zxoJGKBg9KjF+tsHv2EptGtVSIGaIfZVC8HMhMuU3fqXQ6+C3KrQhQ8s4IYbVdjQf/gncss/jfS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2DUKnzaj; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a321cc53so115952191cf.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 15:54:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772927642; cv=none;
        d=google.com; s=arc-20240605;
        b=gGOVfeA6isDXjoMH34rhSsIVqov66zaUmwrnUk3dq76Ej8EXn6OaN/soU/Xy+v8yIM
         A+Oqs3vY0JuEAiB4aNT44LZAfp4YcOKZ3HAjpzKQ5uCLhOaLvMqPnvSXLwn59viJ6h4v
         mGEqL1bVha41U9z5XCG09TbnWplIpagVZIjQ03LRByT6f+H9JHyODIIz6+f/jn1mQ1sH
         m1Ss6yC1pkbkkGo7AnkeuCeOHm5apyYEHpaTiBBt0MvkCH9F1aatz1yMB/dSP71peCfo
         1P+fheBkLfpMjftU7d9FbsVUpDVZmyG5lnmshpkBhaUSWHXgsdGOJAh/sVXDjHaLNVi/
         CD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6Z3h91TAwd6kv5KQ2e8atWB3dcqmRjfYadM579a45Nk=;
        fh=Usht79FeQ/5u2IgVNVDDxaODj37nvIs8qWz+MBEqFVA=;
        b=YYIgzsPpxNNO2ZczJ8HqpjmxxJ32zOQrOrh/NxU7ujRPVbcnllw4lqWLj3BxOzmUrR
         cvJWvRSneX9myw7+qoHsuHf3jwWTz4hCE/zHsfqdAwPXKQkyg0K2JjT6q3R3wsa1ct6R
         GtTspPSU+swqO7mREzwa8TTIsYmywukPROVO4Rgl7Gh2r5uapexuwtYMJdvk8geTsZgK
         PF9mHVliKtvsHjEt/y2GdPTjGIMfQBbttoNSf17WGfo02w9V88p4LCGoq1Ah0bezL4kM
         7KS9zBPzcvz3c8G1qialOG0PpWjFFKwV6sPMm7wulNZ4DbHELK5itPJ7a8GB8AlPdMH7
         QZWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772927642; x=1773532442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z3h91TAwd6kv5KQ2e8atWB3dcqmRjfYadM579a45Nk=;
        b=2DUKnzajmvjCYWMxAE77KbJjbGUtZXsJ9zIh5ZFcF1UlQC0f4NDDcs/7UvKLCfV51Z
         3tbfcwZlZ8i1ptXQj34bVLIRALwwwQKyVemLLwZfNQukUrjUvvva5KR9im2LFBINqNWH
         F0GPNmjDdYl+XP2VnqvYmTrFaJ7zFkaFjrezllogSTzmKTtjdDcyiktTwqth2L8VOm8M
         BNouJBaJDDkftI3C/kNmjkj6RC/MnTP6iBvBuOlM9+9I6bo3jw7qkoIAZcAAB+V5W0xI
         OCc4Wo7swOus+mxcFfZ/leDiRB2sZzN7YAf2/8fZ18WtowGJPWahbN46LIukVjAORkh6
         oZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772927642; x=1773532442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Z3h91TAwd6kv5KQ2e8atWB3dcqmRjfYadM579a45Nk=;
        b=dpjPTlSPCyXEAkXnSH6c+9pz2L5ieNu0rurwS5aXTJ+V1935R+G1PNdEs4S0pQ6yaD
         uunsOTbNateLq2rRffSc6LsIGPTiMFsjHM4iRTiLo4/ohrkJPzgYqfjHzlywQKokJy3O
         p0dm3sjbFQb+9yqy5A5I6pEPADKP/AIkPoU2xAQU/THx1fpm34624D8N6xMsAji1IZqc
         jMlf1m2ArFRljGFjzB8w90xy9zAXOLyOCWbFxCdiSjyhv6+hYu5kqgrA3nLZdycwrSYb
         F+vqlcQdSDzE/L2KSuo68tfVAEW7D1kjz8Xng6C/y3KUoqp/AJced57dTbfz7Q7rnsNe
         uqIA==
X-Forwarded-Encrypted: i=1; AJvYcCXG80X9Kfc7KEgZnzix8tGhficSFW3LNS8Frs3xMpqFYon1pPuYnRqzg+k+PxkDH/u2i6+/jFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwujCZbAaZDbJLP01FEvpdXej+9y3JfjSq2X5oB5DCyuZbCXe9Z
	+wQW2BSvZt9pf9ixGJezuYFmG0atw0I58JEj4VD58Ls5GRkJp4CfcXHt4yb7Du6DD1HL5Q9Cw6z
	HCKGjc5g0CdZ46ygVAPNSrl9gxb8eqR/4fqy4zXfj
X-Gm-Gg: ATEYQzyukogoZKZDyJ/obfIKi1PrXQh79BjYxdF0ppx3C1m7f2wUpzT9tU6pzvBrJ6b
	RTUbYIfOEUXtIaeMesZLrZJIjZyGinfh+JqwKd9fNtQYBf90j0vaXHOBnftnKlglyykekJOjWUA
	7k0lXBSkuZgp2xOGbUQHcHeXMM/6/hrfJrBvvxxlNM8wDbwM+Ec76wmPcCOG/AR+sS/6Z+8Q/Ck
	dS6B+MREH0TLPpuuSV585xkRItj8DBzowIAKjTZ3RkcM65rB12egyns585RFna5gwWTw1uV/lO/
	l1BI62IT
X-Received: by 2002:a05:622a:178c:b0:501:47c4:a4a3 with SMTP id
 d75a77b69052e-508f46d1660mr90155301cf.10.1772927641690; Sat, 07 Mar 2026
 15:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307133601.3863071-1-edumazet@google.com> <CAM0EoMmEaXQO5YbLvmty0rcpe3=P9ckbNtskiXZ_vvHeVVk9cg@mail.gmail.com>
In-Reply-To: <CAM0EoMmEaXQO5YbLvmty0rcpe3=P9ckbNtskiXZ_vvHeVVk9cg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 8 Mar 2026 00:53:50 +0100
X-Gm-Features: AaiRm53X3A99FZx9-ZLySFfvzSg81F6STTftdrOGa1b6Ap3SnSmBIKuWqDlE_nM
Message-ID: <CANn89iLKXBAiPkdh3SsBLD=_JheoNwhz=V4EqHM4bddJVyEYug@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: refine indirect call mitigation in tc_wrapper.h
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Victor Noguiera <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A289622E07A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com,mojatatu.com,mojatatu.ai];
	TAGGED_FROM(0.00)[bounces-265215-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 10:44=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sat, Mar 7, 2026 at 8:36=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > Some modern cpus disable X86_FEATURE_RETPOLINE feature,
> > even if a direct call can still be beneficial.
> >
> > Even when IBRS is present, an indirect call is more expensive
> > than a direct one:
> >
> > Direct Calls:
> >   Compilers can perform powerful optimizations like inlining,
> >   where the function body is directly inserted at the call site,
> >   eliminating call overhead entirely.
> >
> > Indirect Calls:
> >   Inlining is much harder, if not impossible, because the compiler
> >   doesn't know the target function at compile time.
> >   Techniques like Indirect Call Promotion can help by using
> >   profile-guided optimization to turn frequently taken indirect calls
> >   into conditional direct calls, but they still add complexity
> >   and potential overhead compared to a truly direct call.
> >
> > In this patch, I split tc_skip_wrapper in two different
> > static keys, one for tc_act() (tc_skip_wrapper_act)
> > and one for tc_classify() (tc_skip_wrapper_cls).
> >
> > Then I enable the tc_skip_wrapper_cls only if the count
> > of builtin classifiers is above one.
> >
> > I enable tc_skip_wrapper_act only it the count of builtin
> > actions is above one.
> >
>
> Sorry, not clear from reading the patch - why "above one"?
>

Rationale of the code before my patch is :

For platforms with IBRS, it is not worth having many tests that could have =
bad
branch predictions, only to avoid one indirect branch which is okay.

My patch refines the logic to still allow _one_ conditional to allow
one direct call,
because we know this construct is better, even with IBRS.

This is the reason we do not have static keys guarding many INDIRECT_CALL()
in networking stack. Only TC seemed to care about that.

Our use case is only having CLS_BPF as a builtin, I will let people
needing 2 or 3 builtins
amend the code with their performance numbers.

Thanks !

> cheers,
> jamal
>
> > In our production kernels, we only have CONFIG_NET_CLS_BPF=3Dy
> > and CONFIG_NET_ACT_BPF=3Dy. Other are modules or are not compiled.
> >
> > Tested on AMD Turin cpus, cls_bpf_classify() cost went
> > from 1% down to 0.18 %, and FDO will be able to inline
> > it in tcf_classify() for further gains.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> > Cc: Victor Noguiera <victor@mojatatu.com>
> > Cc: Pedro Tammela <pctammela@mojatatu.ai>
> > ---
> >  include/net/tc_wrapper.h | 47 +++++++++++++++++++++++++++++++++++-----
> >  net/sched/sch_api.c      |  3 ++-
> >  2 files changed, 44 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/net/tc_wrapper.h b/include/net/tc_wrapper.h
> > index ffe58a02537c3ae7979e37ace09373a443d81cc9..4ebb053bb0dd6f5f1af572f=
e62404eacfd0885ed 100644
> > --- a/include/net/tc_wrapper.h
> > +++ b/include/net/tc_wrapper.h
> > @@ -12,7 +12,8 @@
> >
> >  #define TC_INDIRECT_SCOPE
> >
> > -extern struct static_key_false tc_skip_wrapper;
> > +extern struct static_key_false tc_skip_wrapper_act;
> > +extern struct static_key_false tc_skip_wrapper_cls;
> >
> >  /* TC Actions */
> >  #ifdef CONFIG_NET_CLS_ACT
> > @@ -46,7 +47,7 @@ TC_INDIRECT_ACTION_DECLARE(tunnel_key_act);
> >  static inline int tc_act(struct sk_buff *skb, const struct tc_action *=
a,
> >                            struct tcf_result *res)
> >  {
> > -       if (static_branch_likely(&tc_skip_wrapper))
> > +       if (static_branch_likely(&tc_skip_wrapper_act))
> >                 goto skip;
> >
> >  #if IS_BUILTIN(CONFIG_NET_ACT_GACT)
> > @@ -153,7 +154,7 @@ TC_INDIRECT_FILTER_DECLARE(u32_classify);
> >  static inline int tc_classify(struct sk_buff *skb, const struct tcf_pr=
oto *tp,
> >                                 struct tcf_result *res)
> >  {
> > -       if (static_branch_likely(&tc_skip_wrapper))
> > +       if (static_branch_likely(&tc_skip_wrapper_cls))
> >                 goto skip;
> >
> >  #if IS_BUILTIN(CONFIG_NET_CLS_BPF)
> > @@ -202,8 +203,44 @@ static inline int tc_classify(struct sk_buff *skb,=
 const struct tcf_proto *tp,
> >  static inline void tc_wrapper_init(void)
> >  {
> >  #ifdef CONFIG_X86
> > -       if (!cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > -               static_branch_enable(&tc_skip_wrapper);
> > +       int cnt_cls =3D IS_BUILTIN(CONFIG_NET_CLS_BPF) +
> > +               IS_BUILTIN(CONFIG_NET_CLS_U32)  +
> > +               IS_BUILTIN(CONFIG_NET_CLS_FLOWER) +
> > +               IS_BUILTIN(CONFIG_NET_CLS_FW) +
> > +               IS_BUILTIN(CONFIG_NET_CLS_MATCHALL) +
> > +               IS_BUILTIN(CONFIG_NET_CLS_BASIC) +
> > +               IS_BUILTIN(CONFIG_NET_CLS_CGROUP) +
> > +               IS_BUILTIN(CONFIG_NET_CLS_FLOW) +
> > +               IS_BUILTIN(CONFIG_NET_CLS_ROUTE4);
> > +
> > +       int cnt_act =3D IS_BUILTIN(CONFIG_NET_ACT_GACT) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_MIRRED) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_PEDIT) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_SKBEDIT) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_SKBMOD) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_POLICE) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_BPF) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_CONNMARK) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_CSUM) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_CT) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_CTINFO) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_GATE) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_MPLS) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_NAT) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_TUNNEL_KEY) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_VLAN) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_IFE) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_SIMP) +
> > +               IS_BUILTIN(CONFIG_NET_ACT_SAMPLE);
> > +
> > +       if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> > +               return;
> > +
> > +       if (cnt_cls > 1)
> > +               static_branch_enable(&tc_skip_wrapper_cls);
> > +
> > +       if (cnt_act > 1)
> > +               static_branch_enable(&tc_skip_wrapper_act);
> >  #endif
> >  }
> >
> > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > index cc43e3f7574fae203989f5c28b4934f0720e64c2..61a9dc219a18fb34d10893f=
e45a0030d3c23f5d0 100644
> > --- a/net/sched/sch_api.c
> > +++ b/net/sched/sch_api.c
> > @@ -2479,7 +2479,8 @@ static struct pernet_operations psched_net_ops =
=3D {
> >  };
> >
> >  #if IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)
> > -DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
> > +DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper_act);
> > +DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper_cls);
> >  #endif
> >
> >  static const struct rtnl_msg_handler psched_rtnl_msg_handlers[] __init=
const =3D {
> > --
> > 2.53.0.473.g4a7958ca14-goog
> >

