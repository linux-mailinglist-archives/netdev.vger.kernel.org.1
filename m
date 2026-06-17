Return-Path: <netdev+bounces-300261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6UCOI6shM2pQ9wUAu9opvQ
	(envelope-from <netdev+bounces-300261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:37:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E1769CB1E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:37:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=everpuredata.com header.s=google header.b=3OMAiouU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300261-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300261-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=everpuredata.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84D7130FE709
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB60D3A83AC;
	Wed, 17 Jun 2026 22:37:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBF348463
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:37:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735830; cv=pass; b=EzRgIK0ox2gY6iJSufIz/AdLphDMmrYFkPecZM49Pzg+Qrj4AWawPsRB8loz95Qq+fL7eqWAJAhNqX9XEMkILulmaRd4JLQXvEIfbqEWvsza7/ZUxqRoKCMtRUJI0j4d5ypgNfLXu8DIxtZCRl9Yrr+ioOetVxBtXrQ6CM/hfQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735830; c=relaxed/simple;
	bh=+dmiLLVKdxhLglzGhqPaLcJFTLz/LxxtRAicdovoNsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+eRprSNSO9zFS1KBXjs5FS9qICaH4kwF+pj/W1RRKwuMVKtgz21YMfk4W7GsvH+047tGvkm0pxeQekMdHUhLu/1FKEiHDwmS2fDi8uyNdlc1Pp9QvLxCA+zZFCRUIf1alisZm9tL2JCw3A1z9zY8vECsX/mvH1YYWOVf4tDvfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=3OMAiouU; arc=pass smtp.client-ip=209.85.217.42
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-6c3099b11a9so114726137.2
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781735828; cv=none;
        d=google.com; s=arc-20240605;
        b=SMsPZtltwkYTJ+dl4YVPH26ZTqCI3uw30USjx/LTPIrvKO5oKao1Re/nqmM9opQvto
         1Y7egvH/27KOQJIC6tvckCq+foB+HzabQ2RHJJuhccjU9WDsY6IjVQAsLZMSOZvb+fdT
         QkUKwnBK7tsx6eBB4J9cUnwY1LyyY2sb5WfEh9SCcC3uo1nmkdm3NyRj0DR8W9XRzRUP
         3NY8HooldEp8CZkYet5MDo0U7n5xmS+Mfsj0YmTx/STcPy0bvSFT7bl864LfR/oFkkSr
         r4djfcULKlYP9gsnHQ2zbonfWBmElPiSHXiKvOuZthn5x8tFVb3JZ7iP8cB1nhT/tBBi
         cGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/TuTjI3SSiG/sqTgjAaS5HsPuuxGHy2RURPXcuTraJU=;
        fh=6NL+27sIBxvB5wwZ0ZBQmTcL/aD2DfokudLcOu/BOqg=;
        b=GbdHPa5s3cFCz7wza4S2sTZ1e0Zx+x4geRwV+EM2KWyu3axioXF27O4ktQQZgq7Nl9
         Inbwef/aM/L8/CYKrOUIkdGaqGIV5S+mXQxZyANAdFZexVzUCQ+Cm8fD7RRoWWyT07BQ
         ZKchhpZ64vvmcurLcpYfVIYY2v/Swp8hUVoygOGsnDLlnbfTkxTyzJDafyPwyEvTXYWZ
         hcTqvr2OvizlTzSPTmlOA5lOcmVwbrJ6VwU0guJP6tpC1eo3CHsR737Q5UrgfWyOwo1P
         w3VaZ9aARgJQgeKoIJ6IB8tIDR65yMwFEjaUcsrDQ1I/nvCtcfcFVT7ZGGvv4SC4tvnb
         hXew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1781735828; x=1782340628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TuTjI3SSiG/sqTgjAaS5HsPuuxGHy2RURPXcuTraJU=;
        b=3OMAiouUsobo93BKmrb6pFMgMYKwY39EPWDsthenrfFt0nGSvxhA9Wqg1FiAcGKnq+
         f7u8iyYm1kQFWqS2CNQgXnh4Vw3bnNtfhb4KVx6wbQZ5WKvyM4h9ZtXXaTKNPw4pKUmq
         J0ioXIBZDWpU67xOjUS7aX1i/G6ZtZNPrF2/EuJvXfbn2SFC7c/LCkeCMNF2NcTwKoR9
         YyfJchmU56uUArDbItqMrQdscoQikhvq8/HOZ5cemT7mpxIGl3q3bRHMBAsKLbBToxGj
         pM9HpFWPvMgxGEpw811kCzaJBXRE/E30/aYxv2BMNFhkEc78Z+SL5YRaym5ZdCsQbvS1
         b6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781735828; x=1782340628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TuTjI3SSiG/sqTgjAaS5HsPuuxGHy2RURPXcuTraJU=;
        b=mKUiCd8WUpde5/gZoONjfStS0bKQRwrAVT7JiHahCUUbFnkj9AbH5Rvtw/aoJ4yQVR
         t0udCNBsHuXqzpe6oOwmqdtURsVwrdPXMrpcRSC2mWSCMdCG0wc4Qo+cFEs9xCTjPIdz
         aU3L1C2M76OlPCgbMG2MPcwpTiCECSXXHgk2tapwn+MlO9Npw2RWuRrg6W1q8e/tYCoF
         HXQQ/1Dd72n+T6XtNE6QMe8MIxKfFfo97wGL3NTER6nN84XuyL66JeCaL2ifO3/SmiS6
         mSx0sP28k0EFf6vO03E8WsmwfPASVr/OXfznepl4QPj4AtgyQtAbWFrKXyE7JC2S5ryD
         zihQ==
X-Gm-Message-State: AOJu0YyWA6nUPk4lSEUILEIaClp/C8sOlVdEU7T6VjE4Uxe5jcbpJusN
	OLOoaeTE5KC3aTHaaSwTxWc4wzycTS+qGXrrdjfnYkcbDGaZPm9gJ+yPjmN38B6ti5BuW4BiFaK
	rIi4YSghVD6hbUZrghAUHKjlqI1gdZjZEozwUYzW4NiQmUt3ZtQkgZSvGNQ==
X-Gm-Gg: AfdE7ckHgUPT6GQq1EV8irl+UVoWdYL/hrAi1nMjroFtPTIRcXoDyxrFiZxr8U3OJNJ
	WOqvaBr00Ty+zukaC74L5O2RQrL9E9iyU2Tvbwj29wXA0fCfyIk2phf2/4iNp2dbsWdu9bKBV4t
	xaWjvGmMocU7ZFvpn2NlY4ASx5nIqpmKofupLJrmARqHK2M6jiGoYdLUzHflyNV/2/+tOmH0TSo
	6CIVeQ0YPhKVpFhW0NOqgOPscY/1B2MhaSg6IH4T8bUMJjexV05TzUZ/b3TsN8x1mudITX5
X-Received: by 2002:a05:6102:947:b0:612:21f8:5afd with SMTP id
 ada2fe7eead31-7245da8b3edmr3480717137.12.1781735827961; Wed, 17 Jun 2026
 15:37:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515212715.3151307-8-rjethwani@purestorage.com> <20260525211610.2508479-1-kuba@kernel.org>
In-Reply-To: <20260525211610.2508479-1-kuba@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Wed, 17 Jun 2026 15:36:56 -0700
X-Gm-Features: AVVi8CeU465uyLZdlle7X1mkxaod539fULG9hdP3ERJnHpSEBOznzdG8QQtQeZ0
Message-ID: <CAKaoeS2W37dRH_KA5Qgp-qP6dZDUpLd7FuJxPcdUZDumWLxe5A@mail.gmail.com>
Subject: Re: [PATCH v14 7/9] tls: device: add RX KeyUpdate support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[everpuredata.com,quarantine];
	R_DKIM_ALLOW(-0.20)[everpuredata.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300261-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[everpuredata.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@everpuredata.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,queasysnail.net,davemloft.net,redhat.com,google.com,kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,everpuredata.com:dkim,everpuredata.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01E1769CB1E

On Mon, May 25, 2026 at 2:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> tls: device: add RX KeyUpdate support
>
> This adds RX-side TLS 1.3 KeyUpdate support to the device offload path,
> keeping the old AEAD/IV/rec_seq around to handle in-flight records that
> the NIC already decrypted with the retired key, and deferring tls_dev_add
> of the new key until the old key has fully drained.
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index c435b3450872..1c58cbd55ffb 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
>
> [ ... ]
>
> > @@ -1552,13 +1722,30 @@ int tls_set_device_offload(struct sock *sk,
> >       return rc;
> >  }
> >
> > -int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx=
)
> > +int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx=
,
> > +                           struct tls_crypto_info *new_crypto_info)
> >  {
>
> [ ... ]
>
> > +     if (new_crypto_info) {
> > +             struct tls_sw_context_rx *sw_ctx =3D tls_sw_ctx_rx(ctx);
> > +
> > +             if (!test_bit(TLS_RX_DEV_CLOSED, &ctx->flags)) {
> > +                     set_bit(TLS_RX_DEV_CLOSED, &ctx->flags);
> > +                     synchronize_net();
> > +                     netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> > +                                                     TLS_OFFLOAD_CTX_D=
IR_RX);
> > +             }
> > +
> > +             if (context->rekey.old_aead_recv &&
> > +                 before(copied_seq, context->rekey.old_nic_boundary)) =
{
>
> [ ... ]
>
> > +                     context->dev_add_pending =3D 1;
> > +             } else {
> > +                     u32 rcv_nxt;
> > +
> > +                     if (context->rekey.old_aead_recv) {
> > +                             crypto_free_aead(context->rekey.old_aead_=
recv);
> > +                             context->rekey.old_aead_recv =3D NULL;
> > +                     }
> > +
> > +                     /* flush the backlog so rcv_nxt is accurate */
> > +                     __sk_flush_backlog(sk);
> > +                     rcv_nxt =3D tcp_sk(sk)->rcv_nxt;
> > +
> > +                     if (before(copied_seq, rcv_nxt)) {
> > +                             context->rekey.old_aead_recv =3D sw_ctx->=
aead_recv;
> > +                             sw_ctx->aead_recv =3D NULL;
> > +                             memcpy(context->rekey.old_iv, ctx->rx.iv,
> > +                                    sizeof(context->rekey.old_iv));
> > +                             memcpy(context->rekey.old_rec_seq, ctx->r=
x.rec_seq,
> > +                                    sizeof(context->rekey.old_rec_seq)=
);
> > +                             context->rekey.old_nic_boundary =3D rcv_n=
xt;
> > +                             context->dev_add_pending =3D 1;
> > +                     }
> > +             }
> > +     }
> > +
> > +     rc =3D tls_sw_ctx_init(sk, 0, new_crypto_info);
> >       if (rc)
> >               goto release_ctx;
>
> [High]
> In the rekey branch, sw_ctx->aead_recv has just been moved into
> context->rekey.old_aead_recv (with sw_ctx->aead_recv set to NULL) and the
> NIC offload has already been torn down via tls_dev_del with
> TLS_RX_DEV_CLOSED set.
>
> If tls_sw_ctx_init() then fails (for example crypto_alloc_aead, setkey,
> setauthsize, or an ENOMEM in the strparser init), control jumps to
> release_ctx, and for the new_crypto_info case that label is essentially a
> no-op:
>
>         release_ctx:
>                 if (!new_crypto_info) {
>                         kfree(ctx->priv_ctx_rx);
>                         ctx->priv_ctx_rx =3D NULL;
>                 }
>
> So sw_ctx->aead_recv stays NULL, the rekey state stays populated,
> TLS_RX_DEV_CLOSED stays set, and tls_sw_ctx_finalize() is never called.
>
> The error returns to do_tls_setsockopt_conf() and, because
> update && rx_conf =3D=3D TLS_HW, it goes straight to err_crypto_info with=
out
> restoring anything, while rx_conf is still TLS_HW and the socket remains
> open.
>
> Can a subsequent recvmsg on this socket then NULL-deref in tls_decrypt_sg=
(),
> which uses ctx->aead_recv unconditionally to compute
> sizeof(*aead_req) + crypto_aead_reqsize(ctx->aead_recv)?
>
> Should this path roll back the rekey state (restore sw_ctx->aead_recv fro=
m
> rekey.old_aead_recv, clear rekey state, clear dev_add_pending) on
> tls_sw_ctx_init() failure?
>
> [High]
> The error path renaming from tls_sw_free_resources_rx() to
> tls_sw_release_resources_rx() in free_sw_resources, combined with a later
> kfree(ctx->priv_ctx_rx), looks like it drops the strparser anchor cleanup=
:
>
> > free_sw_resources:
> >       up_read(&device_offload_lock);
> > -     tls_sw_free_resources_rx(sk);
> > +     tls_sw_release_resources_rx(sk);
> >       down_read(&device_offload_lock);
> >  release_ctx:
> > -     ctx->priv_ctx_rx =3D NULL;
> > +     if (!new_crypto_info) {
> > +             kfree(ctx->priv_ctx_rx);
> > +             ctx->priv_ctx_rx =3D NULL;
> > +     }
>
> tls_sw_free_resources_rx() previously did three things: release_resources=
_rx
> (frees aead_recv, stops strparser), __tls_strp_done() ->
> tls_strp_anchor_free() which consume_skb()s the anchor allocated in
> tls_strp_init() during tls_sw_ctx_init(), and finally tls_sw_free_ctx_rx(=
).
>
> The new code only does steps one and three =E2=80=94 calling kfree(priv_c=
tx_rx)
> without first doing the anchor consume_skb().
>
> Since tls_strp_init() runs inside tls_sw_ctx_init() during the
> !new_crypto_info path, and free_sw_resources is reached only after
> tls_device_dev_add_rx() fails (i.e. after init succeeded), is the
> strp->anchor SKB leaked on every initial-setup failure here?
>
> > +     if (!context->dev_add_pending) {
> > +             rc =3D tls_device_dev_add_rx(sk, ctx, netdev, src_crypto_=
info,
> > +                                        copied_seq, !!new_crypto_info)=
;
> > +             if (!new_crypto_info) {
> > +                     if (rc)
> > +                             goto free_sw_resources;
> > +                     tls_device_attach(ctx, sk, netdev);
> > +             }
> > +     } else if (!was_dev_add_pending) {
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRES=
S);
> > +     } else {
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
> > +     }
>
> [Medium, Medium]
> For the rekey path, context->dev_add_pending is set to 1 before
> tls_sw_ctx_init() is called, but the matching
> TLS_INC_STATS(LINUX_MIB_TLSRXREKEYINPROGRESS) only happens later in the
> "else if (!was_dev_add_pending)" branch after init has succeeded.
>
> If tls_sw_ctx_init() fails, the goto release_ctx is a no-op for
> new_crypto_info, leaving dev_add_pending =3D=3D 1 with no prior
> REKEYINPROGRESS increment.
>
> When the socket closes, tls_device_offload_cleanup_rx() then runs:
>
>         if (rx_ctx && rx_ctx->dev_add_pending) {
>                 rx_ctx->dev_add_pending =3D 0;
>                 TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
>                 TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYINPROGRES=
S);
>         }
>
> Does this decrement TLSRXREKEYINPROGRESS without a prior matching
> increment, wrapping the per-CPU SNMP counter to a very large unsigned
> value, and bump TLSRXREKEYOK for a rekey that never installed a new key
> on the NIC?
>
> Separately, in the same cleanup tail, dev_add_pending =3D=3D 1 means the
> deferred tls_dev_add never ran, so the new key was not installed on the
> NIC. Should this path really increment LINUX_MIB_TLSRXREKEYOK, given that
> tls_device_dev_add_rx() is the documented place that bumps REKEYOK after
> the NIC accepts the new key?
>
> [Medium]
> In the same hunk, when was_dev_add_pending is 1 (a previous rekey is stil=
l
> draining) and a new rekey arrives, the third arm runs:
>
>         } else {
>                 TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXREKEYOK);
>         }
>
> dev_add_pending is still 1 here and the new key has not been installed on
> the NIC yet. The eventual tls_device_deferred_dev_add_rx() will also call
> tls_device_dev_add_rx() with is_rekey=3Dtrue, which on success increments
> LINUX_MIB_TLSRXREKEYOK again.
>
> Is the same successful rekey getting counted twice in this case, and a
> never-completed nested rekey getting counted as success?

Not double-counted, the totals balance. REKEYINPROGRESS is raised
exactly once per draining-chain (by the first rekey that defers) and
lowered exactly once (by the single deferred tls_device_dev_add_rx,
since nested rekeys hit the draining branch and don't re-arm
old_nic_boundary). Each nested rekey is counted immediately in the
else arm; the deferred add's REKEYOK is credited to the rekey that
opened the
INPROGRESS window. So N accepted rekeys =E2=86=92 N REKEYOK, gauge back to =
0.

