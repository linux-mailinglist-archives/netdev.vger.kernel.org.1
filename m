Return-Path: <netdev+bounces-265195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKhDEl6crGn1rQEAu9opvQ
	(envelope-from <netdev+bounces-265195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:45:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9521E22DC07
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D60301C3FF
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDA636F413;
	Sat,  7 Mar 2026 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="xCtPdzN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611CA59
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919898; cv=pass; b=rGlPfq1qvIEXasrMbHy3K2XA3D7jw1trKqzPVbvuze4dR7/4xZ9rhwCdxHbO0L6l+oHf+mNBZClnIa/DGrFSVxQRHICCIbhqv+xaLjsLGySm4UrB5X6O6c2eySunCRMBsQbmzM23RqfrxYUzQN3lNNmD9Kxtz9dM1XevaQyIBm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919898; c=relaxed/simple;
	bh=8Nkt2Hzm/eKoD0o78Q0vwEVjA5+jdOgq9O130/QWXwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEyopm7id8Ra4mK7r5/rDovntyVDc331CaYiWh/qiNP3uYdIPz9yTvQVFMo5CVLOGtfc799L1/Cj6f9ivVaAspD5f1w5o/m3P0glUsWIIR2pKAZ6oMJoRImkiEiCMypfJ6VL1jx9JhR/hFd5AvnzvrmVkRxHB0S6uT0IQGqYElk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=xCtPdzN5; arc=pass smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c7382731edfso2558151a12.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:44:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772919897; cv=none;
        d=google.com; s=arc-20240605;
        b=eDu90wDXcaa/HtfavivUkFc/fy3QAPgc904015sNKTzBnr5FWMNvGyOLejHbqQhRtC
         x26I/heA2IaPUXFRxZMVE2Y7TQ/VEfsPwlV51n3aG3zv57RGZZUhkgcCsvdj1wIZhDOk
         98ebifoLNavwY4muNHt6cDqL32kPz8Rd7B1SgncO76y+6bPK0KZd0nt8irXyxNfcfgs1
         PnreHElQvEiUOZ4UemvW8HCZVLA8Ww1YlqeeHQ5U0cWepRcyErTDfvazjbOZ2HaCGbLd
         MKs47icMcXdsgppDTmSCu5H4rPZnhq5ou+Tzvi6K/5UwBB2xOn2vKAI0v74F3g4D2roa
         8SUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oks8lHMp6UuyX/hSHIVsSt7ajtxYcSLJoT7pKnR6Wz0=;
        fh=ZdmH6RzG/W+vp3LR2CqFQNddfyY8x4lUC9infNw7qkw=;
        b=WvcLTXHb+5DnYyxBrheeIbhCO6Rw8OdDVG/d+ciTMSRf2Eg1/njY/4HiS+CWfAlj7r
         tW1btVhXkDlCUHDC2fkWr7dunBOK9n70M8/wK+f/H4XPWxzAXZRAaYfoxh0/jC4eGluB
         XOtG/wE6YxQ5c8NSgiwb2Lp2f2HueMzEPX4+gnWn96iB44SXiTaZxaOe+1rZ4M8DJceU
         DaOaF88YCScXQ3mle7IZGPhGwdQ/bxDSzGaqmmrVRFCQYlhRfcQ+ASpyZty8LbozYI6y
         5FPo4WgPbuJtD/6UH9TcwETl81tHQTuQ3rFSBYiHu+YbTmYoRN7Qayn3JtrjVlA5p9Fn
         LlSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772919897; x=1773524697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oks8lHMp6UuyX/hSHIVsSt7ajtxYcSLJoT7pKnR6Wz0=;
        b=xCtPdzN5bKU9x9TjLCTegdi73WQ8fYj6G9YhHKonDhuD9Gbc6L2rGqZZAen1PtuFsJ
         bGyVLH9/qgHHBxQ5P1y9EmlqnPCSuac/B+6VfN7H/DV09mvBVfTi5xNMVkpOMmATEYgX
         phuTX9Q6RSOVaaTEcLgTonIAeyzTSX8lL26pT1x7+gWNXUyEX20RSTDAbhHdHDPgJpLi
         lke9nMDRINm+va+hL1Sh1VbRzNJMZ3m0/a7Ixm9P8bgRW6SohB1wI3AYL6OLjeyDF6a7
         eXNc/0t2dN3wDC3++plTJqARAYhoZgP7G3KHbYGdAjQVfGtp8/hLF6qiCm7Cm/zFTb9p
         pUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919897; x=1773524697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oks8lHMp6UuyX/hSHIVsSt7ajtxYcSLJoT7pKnR6Wz0=;
        b=pKZydu33UCcli03dvYPbeWyMjkI4AjAAV1WM0h2nPshiLqre88HtZh2zaGNfq09XO2
         0AlWoTzF/LVqLnoLoxbVLM7JpwguRKC0FO6twLcPTZWCq7FIMZYXwTxP5jF7rpk1S7sH
         ZZ5DoeoZwmtOnbnNR4k6Kwto+3T2PTm02xJVtK12gxDLYXxqWPA6SYklegf7elepz19w
         tfDMsz5bkQnNnvcTRzNCzeIpSTKSo3HCoA0Af7rAlHW0Lqg2bFLlSfY6HX+PdId/o/w1
         NkeUks19TtVK7AIe7qXSd66nG32YZJEiRwOMeWw+a1jgFRiH+OUM46VzFyENTOKIzLwe
         QVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZk458B8x14sTcd69FfjDgInAMv4qbZauLVAFqm9COZrhQGgCp/2x9+LHPMhcX/ZxyoLvFbZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nyk+kg006v5VvoxWJPcXevAXgMfiXrIk3Yg1FhLrxoKphG0E
	0hSad5yfVPR4tHTSFa4E79xV3U9bxTHzdDHlPNZ1kMN3fEdEjJeLAeZ07dWCNF48vFRWX9ZpOw/
	hckOjUeoug3iCj0ZBZotWrRWQ8Z6nmt4UD88vG5sN
X-Gm-Gg: ATEYQzz7pgHd96G3XGf9HakePa4+O+8At//BOOscLij6NrymGJ0bN1CdhwUA8k8EXZU
	+DaXbm3gbfQwfMgNWMeP/3G4IJ81kRRsdpRLxJIl55NcHQwnmONmFTGBFru+nYe+hpeZHHruXTn
	EIIt5o0ypmQkQHw0z6DQ4i8erwDP160ycVC5vAC93xSPVF68AuPWEyHoqA68drEHmGxCexC2y7G
	k4ofeRuNO3brGeyIovQQQTqoAHosK80QTiRTuRgpCWFGkEWnHpZeOkgWxQd3p4NGqnh/ou3rJl8
	f3aPwudmv/qfrh8=
X-Received: by 2002:a05:6a21:6089:b0:398:7ed3:a001 with SMTP id
 adf61e73a8af0-3987ed3ab79mr824686637.2.1772919896797; Sat, 07 Mar 2026
 13:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307133601.3863071-1-edumazet@google.com>
In-Reply-To: <20260307133601.3863071-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 7 Mar 2026 16:44:45 -0500
X-Gm-Features: AaiRm53Ej8ujSJi7AvTD3476hDaPoo4HqsT_Xs11QlemmRVWKTS4Axwz4ENE6cM
Message-ID: <CAM0EoMmEaXQO5YbLvmty0rcpe3=P9ckbNtskiXZ_vvHeVVk9cg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: refine indirect call mitigation in tc_wrapper.h
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Victor Noguiera <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9521E22DC07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265195-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,vger.kernel.org,gmail.com,mojatatu.com,mojatatu.ai];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,mojatatu.ai:email]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 8:36=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Some modern cpus disable X86_FEATURE_RETPOLINE feature,
> even if a direct call can still be beneficial.
>
> Even when IBRS is present, an indirect call is more expensive
> than a direct one:
>
> Direct Calls:
>   Compilers can perform powerful optimizations like inlining,
>   where the function body is directly inserted at the call site,
>   eliminating call overhead entirely.
>
> Indirect Calls:
>   Inlining is much harder, if not impossible, because the compiler
>   doesn't know the target function at compile time.
>   Techniques like Indirect Call Promotion can help by using
>   profile-guided optimization to turn frequently taken indirect calls
>   into conditional direct calls, but they still add complexity
>   and potential overhead compared to a truly direct call.
>
> In this patch, I split tc_skip_wrapper in two different
> static keys, one for tc_act() (tc_skip_wrapper_act)
> and one for tc_classify() (tc_skip_wrapper_cls).
>
> Then I enable the tc_skip_wrapper_cls only if the count
> of builtin classifiers is above one.
>
> I enable tc_skip_wrapper_act only it the count of builtin
> actions is above one.
>

Sorry, not clear from reading the patch - why "above one"?

cheers,
jamal

> In our production kernels, we only have CONFIG_NET_CLS_BPF=3Dy
> and CONFIG_NET_ACT_BPF=3Dy. Other are modules or are not compiled.
>
> Tested on AMD Turin cpus, cls_bpf_classify() cost went
> from 1% down to 0.18 %, and FDO will be able to inline
> it in tcf_classify() for further gains.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> Cc: Victor Noguiera <victor@mojatatu.com>
> Cc: Pedro Tammela <pctammela@mojatatu.ai>
> ---
>  include/net/tc_wrapper.h | 47 +++++++++++++++++++++++++++++++++++-----
>  net/sched/sch_api.c      |  3 ++-
>  2 files changed, 44 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/tc_wrapper.h b/include/net/tc_wrapper.h
> index ffe58a02537c3ae7979e37ace09373a443d81cc9..4ebb053bb0dd6f5f1af572fe6=
2404eacfd0885ed 100644
> --- a/include/net/tc_wrapper.h
> +++ b/include/net/tc_wrapper.h
> @@ -12,7 +12,8 @@
>
>  #define TC_INDIRECT_SCOPE
>
> -extern struct static_key_false tc_skip_wrapper;
> +extern struct static_key_false tc_skip_wrapper_act;
> +extern struct static_key_false tc_skip_wrapper_cls;
>
>  /* TC Actions */
>  #ifdef CONFIG_NET_CLS_ACT
> @@ -46,7 +47,7 @@ TC_INDIRECT_ACTION_DECLARE(tunnel_key_act);
>  static inline int tc_act(struct sk_buff *skb, const struct tc_action *a,
>                            struct tcf_result *res)
>  {
> -       if (static_branch_likely(&tc_skip_wrapper))
> +       if (static_branch_likely(&tc_skip_wrapper_act))
>                 goto skip;
>
>  #if IS_BUILTIN(CONFIG_NET_ACT_GACT)
> @@ -153,7 +154,7 @@ TC_INDIRECT_FILTER_DECLARE(u32_classify);
>  static inline int tc_classify(struct sk_buff *skb, const struct tcf_prot=
o *tp,
>                                 struct tcf_result *res)
>  {
> -       if (static_branch_likely(&tc_skip_wrapper))
> +       if (static_branch_likely(&tc_skip_wrapper_cls))
>                 goto skip;
>
>  #if IS_BUILTIN(CONFIG_NET_CLS_BPF)
> @@ -202,8 +203,44 @@ static inline int tc_classify(struct sk_buff *skb, c=
onst struct tcf_proto *tp,
>  static inline void tc_wrapper_init(void)
>  {
>  #ifdef CONFIG_X86
> -       if (!cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> -               static_branch_enable(&tc_skip_wrapper);
> +       int cnt_cls =3D IS_BUILTIN(CONFIG_NET_CLS_BPF) +
> +               IS_BUILTIN(CONFIG_NET_CLS_U32)  +
> +               IS_BUILTIN(CONFIG_NET_CLS_FLOWER) +
> +               IS_BUILTIN(CONFIG_NET_CLS_FW) +
> +               IS_BUILTIN(CONFIG_NET_CLS_MATCHALL) +
> +               IS_BUILTIN(CONFIG_NET_CLS_BASIC) +
> +               IS_BUILTIN(CONFIG_NET_CLS_CGROUP) +
> +               IS_BUILTIN(CONFIG_NET_CLS_FLOW) +
> +               IS_BUILTIN(CONFIG_NET_CLS_ROUTE4);
> +
> +       int cnt_act =3D IS_BUILTIN(CONFIG_NET_ACT_GACT) +
> +               IS_BUILTIN(CONFIG_NET_ACT_MIRRED) +
> +               IS_BUILTIN(CONFIG_NET_ACT_PEDIT) +
> +               IS_BUILTIN(CONFIG_NET_ACT_SKBEDIT) +
> +               IS_BUILTIN(CONFIG_NET_ACT_SKBMOD) +
> +               IS_BUILTIN(CONFIG_NET_ACT_POLICE) +
> +               IS_BUILTIN(CONFIG_NET_ACT_BPF) +
> +               IS_BUILTIN(CONFIG_NET_ACT_CONNMARK) +
> +               IS_BUILTIN(CONFIG_NET_ACT_CSUM) +
> +               IS_BUILTIN(CONFIG_NET_ACT_CT) +
> +               IS_BUILTIN(CONFIG_NET_ACT_CTINFO) +
> +               IS_BUILTIN(CONFIG_NET_ACT_GATE) +
> +               IS_BUILTIN(CONFIG_NET_ACT_MPLS) +
> +               IS_BUILTIN(CONFIG_NET_ACT_NAT) +
> +               IS_BUILTIN(CONFIG_NET_ACT_TUNNEL_KEY) +
> +               IS_BUILTIN(CONFIG_NET_ACT_VLAN) +
> +               IS_BUILTIN(CONFIG_NET_ACT_IFE) +
> +               IS_BUILTIN(CONFIG_NET_ACT_SIMP) +
> +               IS_BUILTIN(CONFIG_NET_ACT_SAMPLE);
> +
> +       if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> +               return;
> +
> +       if (cnt_cls > 1)
> +               static_branch_enable(&tc_skip_wrapper_cls);
> +
> +       if (cnt_act > 1)
> +               static_branch_enable(&tc_skip_wrapper_act);
>  #endif
>  }
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index cc43e3f7574fae203989f5c28b4934f0720e64c2..61a9dc219a18fb34d10893fe4=
5a0030d3c23f5d0 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -2479,7 +2479,8 @@ static struct pernet_operations psched_net_ops =3D =
{
>  };
>
>  #if IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)
> -DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
> +DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper_act);
> +DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper_cls);
>  #endif
>
>  static const struct rtnl_msg_handler psched_rtnl_msg_handlers[] __initco=
nst =3D {
> --
> 2.53.0.473.g4a7958ca14-goog
>

