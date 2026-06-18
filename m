Return-Path: <netdev+bounces-300400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NCNZLBjMM2q/GQYAu9opvQ
	(envelope-from <netdev+bounces-300400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:44:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4675069F77F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 12:44:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=gCtuwvlR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300400-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300400-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58E3311352B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991E53EE1C6;
	Thu, 18 Jun 2026 10:42:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C802609E3
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 10:42:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779327; cv=pass; b=XBYDsz85+yQIzxaUG0iKNmsBvU11uCq9LyzJCvcWSXNqpTrwrDPPgaoeY6lRPWlopVUAc5w1UMDzYRM+g9Obvu04pZALIZ98gsOGG+668dniJDC8VNf2x9pC8zLsxaOuka6AY+xP+WCr4iMyTK6GWH4CEyLWjkG1o+bx3neIhUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779327; c=relaxed/simple;
	bh=PkXDbza4wegosMh0y4ws8yaqtpEYJocm6SUZzmJvjnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7svIGwbOMdhQgA/GW/FDaJc0Q38VhufomvsyXW6gspso3oBmvPbrsszuoy/d6K203PXKdeGVXcFgJ2WJv1bNuFVbmcwJCQAXI0Ly1HaBGv8Bd9XcyHfBTWvrXygBxeUmPJPIX8g60pq5UGV1CWOOSvFnfOn/C5aSFGoo0CjXO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gCtuwvlR; arc=pass smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84538597e1fso416736b3a.1
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 03:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779324; cv=none;
        d=google.com; s=arc-20240605;
        b=c3Dcj2iPJUQdNs2X17kiD8LIbt0IRjNJYtWh5C8KeumGXUXOTnrEkv6Lf1jORpcH+u
         spFK98E/7M1RJJ9TjFnUq0JvomQ617bR+dVJSpWp/nIToslFvyKIcbVMHgkVRWQ0HFRm
         3zkQDFmnryV0vqXEwGAAGCp3Wai6zKI3/TzCU9TSmTt8Deftan/r0e5xezqnmu1VnTtf
         JoVv9Oxq+YV62KVFl/O2Aquuutp+RsKYbbVXPZnnX3XwOKnonfUFwgZcbMmX1sQnpcpX
         mCe8yPcnoLIZx4+GRydds6q2PcEVx5XOSTt7xseotxRdJ8P6REqLc8eIzibhw5cFn5Ml
         zJKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5IEYm84ZjCI+7+fjWXOcYr9O9+l/FFoAWeDbyIBHSAo=;
        fh=d4eX+sdOs+pxtEewTfjhC7wZOVMPpPK6yxZ18h5RvbM=;
        b=aoVNOhudnTTycE6tOvr11SzRBMj+2lVH9uBNiKnVYhvn9Z/65EfYwwovcNrlhkMNiy
         pxLIVEgAjjHcI+/FAwUZowxN6pXeZu3vB4Xf8czFj5vdhmziOwD8b/NP1dHOeWoI1LvX
         lQAhXgGT51eoFeomXyAYb17aSDfUy9cGEFo2S+I2N7bmc6XETCRQU4he0K2n19Iv5jbR
         /hYqmXJhRiL4EA2IhIEMqjRLdq3i/XLvk4ClXW+dqZbQhvFciNQYC0dIeOyOcDpcvPEd
         nfJqlN8f1XX16HZ35H9wMrIvApXFf8AqPANXvn5wwHj1aTKXZH67hDOFTMbYlbe9NbLh
         iZfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781779324; x=1782384124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IEYm84ZjCI+7+fjWXOcYr9O9+l/FFoAWeDbyIBHSAo=;
        b=gCtuwvlRRk7U352eggo/wwJT1PU6wsvRSA/2Ro4F6qG1UAd15Ft3VjMqB2749to6pK
         Qn9JricyjzspLg4/5B+yzpbs626wEUx3VWtb3FGr2XcyQX85I+PCE5RJoNYCsJtvRfa3
         L3OVydyQHqmixEOZLYA8gvf8/dWSstb1t7O4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779324; x=1782384124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5IEYm84ZjCI+7+fjWXOcYr9O9+l/FFoAWeDbyIBHSAo=;
        b=ofBDN7KR/mQK5/1hdNTcm0xedPaq4LlaV+H8bzAyfkc6y64MrofDMeam/rBBnutqnT
         4n7cSjQchBDpPSggrkynDWgmAFr3GbEcX08BSBbc85iHZd7hMUWkO5YqYKLYFAkUu0iN
         vwFFC97tHj4QQEddIELq53yENzFUPOp2WBhXqlSdga8/4HYx/hIYyB41SOui8Lex1AoV
         wStA5ZLiz5Gw0zG5lsea4t+BMvAECyNnTX1GT9J0b3HEm78TMvxPyUIHOr8tV1SO3fQX
         B58sJCOXrHoQAuRwmmzgWrvmKHzxzsa8gzuZnPegdqjlfIlrUlh69nnbDpvSSBUFSNbh
         xWvw==
X-Forwarded-Encrypted: i=1; AFNElJ9B99PxZcmoAH278AfSCER6mFXWG9O4XMAOhlEj4m5VEKHjsMYLpQTBvadUM3JdTjlICBsVliY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0bnzs1nx4W+G+jJfkX3zdnkNP2iKrxxQGhmsaHlHf4SOstEi
	ukf4lmV5P1vErLNELYEsTStA2L3G+SKHGF6WyukxecJdbXXvvsUN+SLRfwnp5lIwWNp1k2/u5Xp
	qt25e5NTbZ8UwVgNz38fxpEz9C10uIomfPPE4XdA5
X-Gm-Gg: AfdE7ckeZmACNG2Mq2prmFYWxs/CJB0t2kz4vut+txAPKc7fxVua8hwSpH+taW/FMUW
	9wMQe/Vj0p5IKkkC2i8YukibTXO8k3HFghLgNF+6yQ9VIWxqqgDJwQGtkIBPANR0SXwb4iMKBOt
	zsL0p9RSULr6kh0NOO2YW5530h7UmSTXkKDN2SveKuTt1Hr9XWSZNoTP+8+DUWF8VRXAIcVP5B3
	/I6dGHEiLWsEc0yD6fXvwSee4eegXCOMC7YPfpbsFv9i+qvtGJMAl+STCu+Y0zHGBTMs7lskk/+
	0Nj+BE8r
X-Received: by 2002:a05:6a00:3a04:b0:842:7f81:8079 with SMTP id
 d2e1a72fcca58-8452459a173mr8136943b3a.37.1781779324212; Thu, 18 Jun 2026
 03:42:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617215708.1115818-1-michael.bommarito@gmail.com>
In-Reply-To: <20260617215708.1115818-1-michael.bommarito@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 18 Jun 2026 06:41:53 -0400
X-Gm-Features: AVVi8CdNZwPZ_sUPjd_dnqga-P_8YoXiTVb-qs_49YvJVPIhZdp4EVCpWxdhPDg
Message-ID: <CAM0EoMmNsaRoq7rCLBKzu+QieucYPUyH=NkKe2dOT_sb8f6gOg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_ct: fix nf_connlabels leak on two
 error paths
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:jiri@resnulli.us,m:pablo@netfilter.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300400-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[mojatatu.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mojatatu.com:dkim,mojatatu.com:email,mojatatu.com:from_mime,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4675069F77F

On Wed, Jun 17, 2026 at 5:57=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> tcf_ct_fill_params() calls nf_connlabels_get() (setting put_labels) when
> TCA_CT_LABELS is present, but two later error sites use a bare return
> instead of "goto err", skipping the err: nf_connlabels_put() cleanup.
> They also precede the "p->put_labels =3D put_labels" assignment, so the
> tcf_ct_params_free() fallback does not release the count either. Each
> failed RTM_NEWACTION on these paths leaks one nf_connlabels reference:
> net->ct.labels_used is incremented and never released. The action is
> reachable with CAP_NET_ADMIN over the netns, i.e. from an unprivileged
> user namespace on default-userns kernels.
>
> Impact: an unprivileged user with CAP_NET_ADMIN over a network namespace
> (e.g. via user namespaces) leaks one nf_connlabels reference per failed
> RTM_NEWACTION on the two error paths; net->ct.labels_used is never
> released.
>
> The err: label is safe to reach from both sites: p->tmpl is still NULL
> there (kzalloc'd, not yet assigned) and nf_ct_put(NULL) is a no-op, so
> no inline release is needed.
>
> Fixes: 70f06c115bcc ("sched: act_ct: switch to per-action label counting"=
)
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Testing: refcount/counter leak (CWE-772); no sanitizer for this class, so
> the oracle is the nf_connlabels accounting counter net->ct.labels_used.
>
> Reproduction (UML, before/after, same trigger): CONFIG_NET_ACT_CT=3Dy,
> NF_CONNTRACK_LABELS=3Dy, NF_CONNTRACK_ZONES=3Dn (forces the zone-disabled
> path). A raw RTM_NEWACTION trigger adds "action ct label 0x1/0x1 zone 1"
> 20 times; each returns -EOPNOTSUPP.
>   stock:   net->ct.labels_used climbs 1,2,...,20 (get, then bare return,
>            no put) -- 20 leaked counts, never recovered.
>   patched: counter stays balanced (get then goto err -> put); baseline.
> Control: the same loop without "label" (no nf_connlabels_get) leaves the
> counter unchanged on both trees -- the trigger reached the labels path an=
d
> the synthesis is not itself the cause.
>
> Conditions: reachable via RTM_NEWACTION with CAP_NET_ADMIN over the netns=
,
> i.e. an unprivileged user in a fresh user+net namespace on default-userns
> distros. The easy path needs CONFIG_NF_CONNTRACK_ZONES=3Dn; the
> nf_ct_tmpl_alloc ENOMEM path leaks on any config under memory pressure.
>
> Mitigations: restrict unprivileged user namespaces; otherwise none short =
of
> the fix. Harness (trigger.c, init) available on request.
>
>  net/sched/act_ct.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index 6158e13c98d35..f5866a364a74a 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1295,7 +1295,8 @@ static int tcf_ct_fill_params(struct net *net,
>         if (tb[TCA_CT_ZONE]) {
>                 if (!IS_ENABLED(CONFIG_NF_CONNTRACK_ZONES)) {
>                         NL_SET_ERR_MSG_MOD(extack, "Conntrack zones isn't=
 enabled.");
> -                       return -EOPNOTSUPP;
> +                       err =3D -EOPNOTSUPP;
> +                       goto err;
>                 }
>
>                 tcf_ct_set_key_val(tb,
> @@ -1308,7 +1309,8 @@ static int tcf_ct_fill_params(struct net *net,
>         tmpl =3D nf_ct_tmpl_alloc(net, &zone, GFP_KERNEL);
>         if (!tmpl) {
>                 NL_SET_ERR_MSG_MOD(extack, "Failed to allocate conntrack =
template");
> -               return -ENOMEM;
> +               err =3D -ENOMEM;
> +               goto err;
>         }
>         p->tmpl =3D tmpl;
>         if (tb[TCA_CT_HELPER_NAME]) {

Looks sane to me.
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> --
> 2.53.0
>

