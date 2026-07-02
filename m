Return-Path: <netdev+bounces-303916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BOjZJ8LRRWruFgsAu9opvQ
	(envelope-from <netdev+bounces-303916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:49:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA146F31B1
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:49:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=QsF0Qq1w;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303916-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303916-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C97AD302DCDC
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A242E1F06;
	Thu,  2 Jul 2026 02:49:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34530C176
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 02:49:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960577; cv=pass; b=Ahky+v8Ti7zGF2x6+gZcEeKBljrQ5LJVcBSCb+PIK3AxHkMGyLrsCbBrtgRONYa5maycSecS6/bmQczFdrCOsh3sPjBlHKB+Nfj94e8Z080ydTcJ1hov3CP17EQhb0AYQnd9VVjmasFgS3FMM+OrQVGIOG3ErM1/nGqhClvDlck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960577; c=relaxed/simple;
	bh=20Cs05/1g216Q8Pm02I0IC3Cu9w+JzJeH5u39yu/Z18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Md+WdhVUqc9YsfO7wuWsRQcupXCWfl+P2lW0dfltxIVHrklanBH1ojEKdQukC4ctfNLRdKzQnsMK22KWZXY9IApI6u+QRMCHxuCEsLaKvJOAFPz/r82I6vZRH1X1CkH8lKKmJK1L5InGvKE4KCZsHZsmq5844yvMyp7ubZz1evs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsF0Qq1w; arc=pass smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3804e42ad5fso1245289a91.2
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 19:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782960575; cv=none;
        d=google.com; s=arc-20260327;
        b=IYL/GRcke9pC4eg+J8omdwrP0mncxMpGn44/HgkPXWK66/J1ZGYPskllQeAWlXLPDX
         fMgezJv52kz+ntwyAYiXU05K9weAIKQRSSGvCsgLkF5rnjbnjhdBsTL2a84vuS1dm+3k
         LBvTtkvs/E6VIBiPvy35U52nAnDhFyJIMiUtw0lrLb034yf8pjL5pmcZFh5NHoVJ3uNQ
         4sy9HAU3nzjWS+Sudh5QrEkpebtegT7XKCKdZdiVaziV1qZMSBOPSewP1mC5ddcPETwA
         wtZu2YiIz7SWKW5DHGE8b+MLB0Tje7MnUNUEQfkNwIbk8ixDJtnqeAzglqH+BUhTBtfH
         mBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8eQAI0v5Y3TrXT+9Uezh7Aosnjw6vsbtAoQhIAs11SQ=;
        fh=oTxuMu1kybQnZM+G6X5nngDpfnlm8V0Rh3RQ42EcwI0=;
        b=IUuSM+MoLAeVyucEcMw3RC7az6lesc0qZgdk68KiO6byNWehMFRIIxIAP9tKwIR1z7
         qDRkmrdtVVtof0qSk1hDSvFYcE3arOty6UiYTGsFwujd6t+Del6LXyhyrbKlVir4R8WQ
         Elb5g13GAVMxWUOL91100r0kXVYWhkTRk3ekudwbmXsOkh2h8EkqA0gkMufXhHJp2XWy
         tVB5s3W+pd+LmTcaGminD1piS361ZJtBfUhHzRHR7CwrylrEpkMlBswNVPAjkFgZcBhZ
         x4SOMxIwVcFHRNymmA+QOhLbgl+W6sswFgyxBlcjhCnCGsU59ZgtVeq03+nXjJYDgKJH
         izAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782960575; x=1783565375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eQAI0v5Y3TrXT+9Uezh7Aosnjw6vsbtAoQhIAs11SQ=;
        b=QsF0Qq1wLI7zkTpBO18RTz0bCIm8JklGkyrVtFgbnP9StfZkieVHW+NbActFoGpGJE
         z19hjmHqRx3KDRnIemFOM8EkcEqiRsWbfIXEf0/7oPRo8I9IFeYSSwOSGhZZvvHEhilS
         /7f6Fx5ehLnt8FI1Bp8Ow4wu5t0CHJGH7xqsG3Faj2nstQmJfu1LmAdmKBugFZjZVbsI
         Q+cD1OqCQEO0ZDdjcjt6HkIWn3b26Osx4Ak1vy0efmY7R0NVJBJZkjPA8olHyT8+qhq6
         xdXcwrdTFAQ/tHroDjvsg7TXJZNpG/JRWSCTyFwxIMI1YTCD5pa8lBR48FNe+zn3+Lok
         28ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960575; x=1783565375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8eQAI0v5Y3TrXT+9Uezh7Aosnjw6vsbtAoQhIAs11SQ=;
        b=kn3WK6JSdBJ/+zc5jXWJwfObPDdMMR2+a+xdrr1yE9JU7pJGsOQSyn0Milp0DHlhv6
         LQaKQuwic7wssZn3ufERBNOLXXcFHueUiok0lXypNFGJ82a1jA+1EFl9rOB5fmRd8IqA
         lVPu+mdttuqlZc/iuCwVdUPvQ1hHJVDO0zMiSCq/2gBHVcHWEUiUbUKuCGJ9ofEDqjES
         a5RUrRD0T1lFOHxQtmNxo89DiNxkxE2JO4qbAK6eegF0dKEGmMvL8fGSNhjKTX847hXZ
         Uuao2sIde+dPG5pUHxU+j2jWNbrZ6KRU8Ais/4bPfvQDlJsz2OjV7Fcp9Q6jW+bX9Q4D
         kPTw==
X-Forwarded-Encrypted: i=1; AFNElJ/zKkE/asg5wMExoNCOH2DkTtqrweQ6HWyovkqh3GyFISKZthdPbSzNWA+IytK849lXpGv0zkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwImruWe58q4743m0Y5tr5BQ9h6Xz6VdJfTUf0gPeB/J+V2t+tZ
	4Jzjj3klrLelfLZ2O6G/XWEFGA/trQvo0NCZZhwonLSpt3Nk15mkDmjYSSb636rAJz0x1hRpewz
	nNpCjNOP8FwPYfubtnxzISVm8bIN13FtZRTHOfBbB
X-Gm-Gg: AfdE7cnM1bglN7I/9a/XHotJBOBnlw9fh0NtqAaokR/kzzXl8HnNaYGeqsbklSuVTOE
	8GzDWejYWx4xEdtrYPbzMNcM+3sK7tB5/KiFVRGBhDNBW+L+yEJITJ232e2aTlmBYBhNdJruldH
	biBfg6yzglaCjBURq9apUgfpbfudnyzar5B82NRM/qd4NdujYYkUSrQoLVobNKTk4gtYAnS2IRO
	rTlz+rgYR93ZK/i9JZ0+1jCUrzYhKQN8QpEq5igAUYmwDI1fl1ZI6dHNY5z9D6m2YoWaIh+LWIi
	HoOJo9oUCd1nG58XRBtj1YZsD6B5H3mbjod6SJnMFKmDU/ZdlRGQmCh/EWbL9TkgWlwKDn1E1fb
	iB2Ir3OQm/fodmgHJUSLNLTnZPHP7jwPCg64DLSEhAQ==
X-Received: by 2002:a05:6a21:38c:b0:3b2:a809:ffe with SMTP id
 adf61e73a8af0-3bff407cf6dmr3804885637.14.1782960574625; Wed, 01 Jul 2026
 19:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701120454.3533252-1-edumazet@google.com> <20260701120454.3533252-2-edumazet@google.com>
In-Reply-To: <20260701120454.3533252-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 19:49:23 -0700
X-Gm-Features: AVVi8CcaqUV_D3c45RB2N1qbwLeQJXBi4eS-YxGEKk4deJDSP8YuoX8_lVSnUGw
Message-ID: <CAAVpQUBDbn6GCxTjDcg56Xb4ni83YuMXOxwBU7Xggke3SN5tNQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] geneve: convert config to RCU-protected pointer
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303916-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CA146F31B1

On Wed, Jul 1, 2026 at 5:04=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> geneve_changelink() currently updates configuration by copying it over
> the old one using memcpy() under RTNL, forcing data path pause via
> geneve_quiesce() and synchronize_net() to avoid reading torn values.
>
> Convert geneve->cfg to an RCU-protected pointer, allowing lockless
> and safe reads under RCU read lock without synchronization overhead.
>
> Key changes:
> - Introduced geneve_config_alloc/free() helpers for lifecycle.
> - geneve_configure() allocates config and publishes it via RCU.
> - geneve_changelink() performs RCU swap; old config is freed via call_rcu=
_hurry().
> - Allocates new dst_cache during changelink to prevent pcpu sharing.
> - Removed geneve_quiesce/unquiesce() and synchronize_net() from changelin=
k.
> - Added rcu_barrier() to module exit to wait for pending callbacks.
> - Updated data path to use rcu_dereference().
> - Updated geneve_fill_info() to use rtnl_dereference() for now.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks for this change !
Sashiko always complained about this for every geneve patch :)


[...]
> @@ -1539,28 +1551,36 @@ static int geneve6_xmit_skb(struct sk_buff *skb, =
struct net_device *dev,
>  static netdev_tx_t geneve_xmit(struct sk_buff *skb, struct net_device *d=
ev)
>  {
>         struct geneve_dev *geneve =3D netdev_priv(dev);
> -       struct ip_tunnel_info *info =3D NULL;
> +       const struct ip_tunnel_info *info =3D NULL;
> +       const struct geneve_config *cfg;
>         int err;
>
> -       if (geneve->cfg.collect_md) {
> +       rcu_read_lock();
> +       cfg =3D rcu_dereference(geneve->cfg);
> +       if (unlikely(!cfg)) {
> +               err =3D -ENODEV;
> +               goto tx_err;
> +       }

Do we need NULL check for geneve->cfg in the fast paths ?

I think genve->cfg is cleared only in the error path of geneve_configure()
due to NETDEV_REGISTER notifier.   Although dev is already published
by list_netdevice(), it's not UP and socket is not yet created, so I guess =
no
one can reach the fast path when geneve->cfg is NULL.

In that sense, the NULL check in the next patch makes sense.

[...]
> @@ -1962,10 +2040,13 @@ static int geneve_configure(struct net *net, stru=
ct net_device *dev,
>                 }
>         }
>
> -       dst_cache_reset(&geneve->cfg.info.dst_cache);
> -       memcpy(&geneve->cfg, cfg, sizeof(*cfg));
> +       new_cfg =3D geneve_config_alloc(cfg);
> +       if (IS_ERR(new_cfg))
> +               return PTR_ERR(new_cfg);
>
> -       if (geneve->cfg.inner_proto_inherit) {
> +       rcu_assign_pointer(geneve->cfg, new_cfg);
> +
> +       if (cfg->inner_proto_inherit) {
>                 dev->header_ops =3D NULL;
>                 dev->type =3D ARPHRD_NONE;
>                 dev->hard_header_len =3D 0;
> @@ -1975,10 +2056,15 @@ static int geneve_configure(struct net *net, stru=
ct net_device *dev,
>
>         err =3D register_netdevice(dev);
>         if (err)
> -               return err;
> +               goto err_free_cfg;
>
>         list_add(&geneve->next, &gn->geneve_list);
>         return 0;
> +
> +err_free_cfg:
> +       geneve_config_free(new_cfg);
> +       RCU_INIT_POINTER(geneve->cfg, NULL);

I think we need to clear geneve->cfg before geneve_config_free()
in case call_rcu() run before RCU_INIT_POINTER().

