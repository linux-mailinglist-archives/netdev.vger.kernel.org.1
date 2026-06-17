Return-Path: <netdev+bounces-300258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l7TFJKwgM2ok9wUAu9opvQ
	(envelope-from <netdev+bounces-300258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:33:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A88369CADC
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 00:33:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=everpuredata.com header.s=google header.b=H4jNtnn3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300258-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300258-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=everpuredata.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0013304DC88
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAD1388374;
	Wed, 17 Jun 2026 22:33:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6101A33E35C
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 22:33:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735592; cv=pass; b=OhBtbcXIyQ73u0OipCdg85KvAKdjdb3ZnjwDd+5k+6/W2RoUio5ta5Pxr256aII3F6L5FeJvzly0CQAS/eph4gNaTwowYC+u/p+Dnxz64/cLwhBbOaxfBKYF7IUuruhPZwzQxvNMYvWrIsnJL2r82E31sShVIU9g0R//S3HTOik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735592; c=relaxed/simple;
	bh=5l+fEaL1WEplxnDUt0qVUHS6EWvkfQlrjLMQtAq88hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4poq4FslDmrrGoJ6QLlUBVIEVtcD17VXa1/GvD/pFnQm1bTfsMVh7f3+rXp2RZkBOMAVBIBbA3LUp9ehucwNaKyeai5f3pKPUplX+hEMiYtvRSDAKbl8VQQovq2VMVqmGXjFZNeHTwyTIlsckN0acd4Tdx0X/zMr5PREvEO/Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=H4jNtnn3; arc=pass smtp.client-ip=209.85.217.46
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6cfcad4f979so265570137.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 15:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781735589; cv=none;
        d=google.com; s=arc-20240605;
        b=EkbtGisIKa5Bn7l/pAr8x2z1z2TE2oM91enReHiiqFluqndX/tzRBApgMhXfDuKWQZ
         dwwdNTPR8Ie4ox7UiHlOkBXYVhI5aRKE6X8ZkpaL5nNcNotyX9Jv2LiTcFOWeliscpUG
         tDnpMPqzWccvjDiv6d9bDJXhe0+vIe+gCxMg9JrS/D8kGjeXmjOPxffy/Q2xl4348pCi
         y3k4hqu5Qu7tsWBWYv4wu7lAfOwBuSs3PELi6IhOpDZ4+XTfpZn7vD0fSYgUPYU0TFxn
         6mgv0s/Ez95cT+UfXM6+TViNa2BV06px+ZHg6z+DrrBGcnK37DiLLi95xeDhN5FzaSsV
         bKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nIX3V/paKGZw5NKANRDSrmYEVRCpQD/GRVkStaSWh6U=;
        fh=6NL+27sIBxvB5wwZ0ZBQmTcL/aD2DfokudLcOu/BOqg=;
        b=YC2VKbACF8n/9TAd8TaeAjdH755Jh1IITychK51A6DX1gI8VFXVeGeVnCsGl9Y6Zgl
         d/9BTrLXNlcLD5kZsZYmNJtfBzAzigAbN8IeXaqUXFepa5LQnvwmbShQJcauB41BjK09
         PvaR1YyflkJO71Yt/eBNJBrCnL5vBe6Yg/MsGyJH9aAE+tAX2uzrRG7evU5r7n3ilpUQ
         2m0ZFdcyUXGZEOWf8TfwOGqp/d3yHZ0QS0wgVP9/WrAH5pOSGW0g8CoG/68+mAnB2HHn
         E+AJKs2XtFEqfcyXQSyPtLMQo5E2GdBrCzatOTO+u1VmO7FJAF77Tb/9nrLc4nEyFotM
         M7/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1781735589; x=1782340389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIX3V/paKGZw5NKANRDSrmYEVRCpQD/GRVkStaSWh6U=;
        b=H4jNtnn3SCbIUCGPsorOBqrT/DPZf7/27lHlJBb1YffNlJZl1AK0PTA786OGJdRxkl
         80/c0RPI+uS78mqvpG6O0Erwmu/HLP7KG+2YNRnoHLlJwmWyLaSyTCTZ3/U68+xncGt8
         SxRBdPS/pJtbGQKAqMts476ZX2SIVap7BZW4jpi8ZV35DQhBATFZ/65Ng2CDCmtvHwlz
         TuEPPlkq9memS7Fw1DApffF8K+7BFGb0Q1oQxUp4k9kDiiBK01SObOxNLLT4Pvp8HMwK
         ZiIc4/sBE+ThaDcFyoanOUL29BicLaPyKbxpsgUjDOvS2NBgHFrf4WjS7srkGqSMDR8b
         l73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781735589; x=1782340389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIX3V/paKGZw5NKANRDSrmYEVRCpQD/GRVkStaSWh6U=;
        b=aqZcjDk5hJZlX4s1EqOpKyDkvC1Q/yiZ/Xlw0ZR5E4kPi/FdnN8DMcA9iJz6uxIiSY
         polfnbL/+Tkc4RvOHFDroHvnNMohFIsHLEj6T6Q7TBrWPC/BGjj2CywwQViCJA4sFikO
         WmvIuu1ifgmUXEZ3dn8wCMP3nr90LB9lUjwcU/VtruBAAwwboAEcqrffb0nrldmQeFiD
         vZiLcI0JMMTrSdKXaDiOvDgEWRlS7WG9dSS3Zx1wOoIkyZiqhliEhxmAg1jzzgKESGJx
         GGoj6s+qTQDfg3Yb65zcjFXWcLGNnR5Om3Fw5YL9l67Ds611pnt37moJCWbOk43aAz6A
         gQUg==
X-Gm-Message-State: AOJu0YwXQPeCuivf+nM8OBxJdGJSGuvKF/ySYZsm+NLB5JIE+Eeoboj9
	bGClS+hkMT6OgzhnjUxouwx0AS+aoMG5+1OdqQNME6g87I2PHDpbJy8dxKPbQxYYSigN4M7inTS
	iUSZjTh+mBfN7W3/y9nPzErGlGp3lJTGa1bKBRu8OHA==
X-Gm-Gg: AfdE7ck6eyyVEur+KiTUjEZKBeDt9Do6QX4W4HDCWimJYsAohjRR4urGKQxPQw+2DJX
	5tWfntLOh6GuKwF8GVHsvFl3M2HK9OhD9VUs2p8RJDjUVFb9TQkVp0kQr1ooUVpzqBuCPZzXRqM
	Mx3VMTmP0GeZSmIu78Hquuu9AZhtfUI6LjLgHs27cUa4YolGoqtnR+kca15OphHmYT6yvAnYxyD
	YSBGe5z5Yt2cewDVQiwY663b4u7Df3/MkrP+aD4hBxRq7B8YwZ0Jn285mAtITb9FY2afLX4
X-Received: by 2002:a05:6102:4189:b0:727:c54b:b420 with SMTP id
 ada2fe7eead31-727c54bb580mr1287984137.17.1781735589034; Wed, 17 Jun 2026
 15:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515212715.3151307-7-rjethwani@purestorage.com> <20260525211608.2508449-1-kuba@kernel.org>
In-Reply-To: <20260525211608.2508449-1-kuba@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Wed, 17 Jun 2026 15:32:58 -0700
X-Gm-Features: AVVi8CesUZkep5irSKMclWbPzOUzlF8aAVVjmV3fCpIWd4IqZCtSQn3REw3UZeg
Message-ID: <CAKaoeS3mTGUo-dvtdmQfz3JAnn69-e36xrj9YmjbWTnsiw9uqg@mail.gmail.com>
Subject: Re: [PATCH v14 6/9] tls: device: add TX KeyUpdate support
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300258-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,everpuredata.com:dkim,everpuredata.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A88369CADC

On Mon, May 25, 2026 at 2:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> tls: device: add TX KeyUpdate support
>
> This adds TX-side TLS 1.3 KeyUpdate support for HW-offloaded sockets by
> installing a temporary SW context with the new key, deferring the HW
> reinstall until all old-key records have been ACKed, and falling back to
> permanent SW mode if the HW reinstall fails.
>
> Thanks for the patch.  A few questions inline.
>
> > diff --git a/include/net/tls.h b/include/net/tls.h
> > index 2512a3799b21..c1085873ee01 100644
> > --- a/include/net/tls.h
> > +++ b/include/net/tls.h
>
> [ ... ]
>
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index 7a98d2f6cbd3..c435b3450872 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
>
> [ ... ]
>
> > @@ -222,6 +246,19 @@ static void tls_tcp_clean_acked(struct sock *sk, u=
32 acked_seq)
> >       }
> >
> >       ctx->unacked_record_sn +=3D deleted_records;
> > +
> > +     /* Once all old-key HW records are ACKed, set REKEY_READY to
> > +      * let sendmsg know it can finish the rekey and switch back
> > +      * to HW offload.
> > +      */
> > +     if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) &&
> > +         !test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> > +             u32 boundary_seq =3D READ_ONCE(tls_ctx->rekey.boundary_se=
q);
> > +
> > +             if (!before(acked_seq, boundary_seq))
> > +                     set_bit(TLS_TX_REKEY_READY, &tls_ctx->flags);
> > +     }
> > +
> >       spin_unlock_irqrestore(&ctx->lock, flags);
> >  }
>
> [Medium]
> Is the ordering between the boundary_seq publish and the PENDING bit
> publish in tls_device_start_rekey() strong enough for this read site?
>
> In tls_device_start_rekey() the sequence is:
>
>         WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq);
>         ...
>         set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
>
> set_bit() does not document any implicit memory barrier
> (Documentation/atomic_bitops.txt).  On weakly-ordered architectures, can
> this reader observe PENDING=3D1 with a stale boundary_seq, set REKEY_READ=
Y
> prematurely, and let tls_device_complete_rekey() run before the old-key
> records are actually ACKed?
>
> Would an smp_wmb() (or smp_mb__before_atomic()) between the write of
> boundary_seq and the set_bit, or moving both writes under
> offload_ctx->lock that this reader already holds, be appropriate?

I'll move both writes under offload_ctx->lock

> > @@ -253,6 +290,14 @@ void tls_device_free_resources_tx(struct sock *sk)
> >       struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> >
> >       tls_free_partial_record(sk, tls_ctx);
> > +
> > +     if (unlikely(tls_ctx->rekey.sw_ctx))
> > +             tls_sw_release_resources_tx(sk);
> > +
> > +     if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags)) {
> > +             TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYOK);
> > +             TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRES=
S);
> > +     }
> >  }
>
> [Medium]
> Should a rekey that was still PENDING at socket teardown count as
> TlsTxRekeyOk?  The rekey never completed, but the counter is bumped as
> if it had succeeded.  Should this be a separate "aborted" counter, or
> just omit the OK increment in this path?

I'll add a separate "aborted" counter.

> > @@ -624,6 +672,19 @@ int tls_device_sendmsg(struct sock *sk, struct msg=
hdr *msg, size_t size)
> >                       goto out;
> >       }
> >
> > +     /* Old-key records all ACKed; switch back to HW. */
> > +     if (test_bit(TLS_TX_REKEY_READY, &tls_ctx->flags))
> > +             tls_device_complete_rekey(sk, tls_ctx, true);
>
> [Medium]
> Should the return value of tls_device_complete_rekey() be checked here?
>
> tls_device_complete_rekey() can return non-zero from its early
> tls_sw_drain_tx() path:
>
>         rc =3D tls_sw_drain_tx(sk, ctx);
>         if (rc)
>                 return rc;
>
> In that early-return case none of REKEY_PENDING, REKEY_READY, or
> REKEY_FAILED is updated.  The caller falls through to
> tls_sw_sendmsg_locked(), and on the next sendmsg the same READY bit is
> still set, so complete_rekey is retried, drain returns -EAGAIN again,
> and so on.  Is there a way out of this state?  Should persistent drain
> failure transition to FAILED, or at least bump a counter so it is
> observable?

Looking at the actual failure modes, I don't think persistent failure
or a FAILED transition is the right fix here, let me lay out why, and
what I'm proposing instead.

tls_sw_drain_tx() returns non-zero in three cases:
1. tls_tx_records() returns < 0
2. tls_is_partially_sent_record() still true after the push attempt
3. tls_is_pending_open_record() still true after the push attempt

The key thing is that tls_tx_records() (tls_sw.c:460-462) already
collapses every non-EAGAIN failure into tls_err_abort(sk, rc), which
sets sk->sk_err. From that point the socket is poisoned: the next
sendmsg returns the saved sk_err to userspace via the sk->sk_err check
at the top of tls_push_data() (and the SW equivalent), and the loop
exits naturally, userspace stops sending.

That means the failure modes that actually retry on the next sendmsg
are exclusively -EAGAIN-class transients:

- TCP send buffer full =E2=86=92 clears as ACKs free space; tls_write_space=
()
flushes the partial.
- Open record not fully pushed =E2=86=92 flushes on the next sendmsg once
buffer space is available.

Transitioning to REKEY_FAILED on -EAGAIN would permanently downgrade a
connection that's just waiting one RTT for TCP buffer space, which I
don't think is what we want, once FAILED, we never retry the HW
transition.

For observability without committing a new SNMP counter, I'll add a
tracepoint at the sendmsg call site so a stuck loop is visible via
tracefs

> > +
> > +     /* Use SW path if rekey is in progress (PENDING) or if HW rekey
> > +      * failed (FAILED).
> > +      */
> > +     if (test_bit(TLS_TX_REKEY_PENDING, &tls_ctx->flags) ||
> > +         test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags)) {
> > +             rc =3D tls_sw_sendmsg_locked(sk, msg, size);
> > +             goto out;
> > +     }
> > +
> >       rc =3D tls_push_data(sk, &msg->msg_iter, size, msg->msg_flags,
> >                          record_type);
>
> [High]
> What happens to a HW open_record across this transition?
>
> If userspace previously sent with MSG_MORE, offload_ctx->open_record
> holds buffered plaintext and tls_ctx->pending_open_record_frags is true.
> A subsequent setsockopt KeyUpdate then routes future sendmsg calls into
> tls_sw_sendmsg_locked(), which builds into sw_ctx->open_rec (initially
> NULL) and never touches the HW open_record.  At socket close,
> tls_device_sk_destruct() does:
>
>         if (ctx->open_record)
>                 destroy_record(ctx->open_record);
>
> so the buffered plaintext is freed without ever being transmitted.
>
> Also, since pending_open_record_frags stays true, would
> tls_sw_drain_tx() see tls_is_pending_open_record(ctx) as true and return
> -EAGAIN, blocking tls_device_complete_rekey() until something on the SW
> side coincidentally clears it?
>
> The tcp_write_collapse_fence() in tls_device_start_rekey() only handles
> records already in the TCP write queue; it does not appear to flush this
> HW open_record.

Right, flushing the HW open_record is required.

> > @@ -1103,6 +1164,260 @@ static struct tls_offload_context_tx *alloc_off=
load_ctx_tx(struct tls_context *c
> [ ... ]
> > +static int tls_device_start_rekey(struct sock *sk,
> > +                               struct tls_context *ctx,
> > +                               struct tls_offload_context_tx *offload_=
ctx,
> > +                               struct tls_crypto_info *new_crypto_info=
)
> > +{
> > +     bool rekey_pending =3D test_bit(TLS_TX_REKEY_PENDING, &ctx->flags=
);
> > +     bool rekey_failed =3D test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> [ ... ]
> > +     if (rekey_pending || rekey_failed) {
> > +             rc =3D crypto_aead_setkey(offload_ctx->rekey.sw.aead_send=
,
> > +                                     key, cipher_desc->key);
> > +             if (rc)
> > +                     return rc;
>
> [High]
> Can there be in-flight async crypto requests on this aead_send when
> crypto_aead_setkey() is called here?
>
> While a rekey is PENDING, sendmsg has been encrypting via
> offload_ctx->rekey.sw.aead_send through tls_sw_sendmsg_locked().  Async
> backends can return -EINPROGRESS and complete later.  Other call sites
> that mutate AEAD state (tls_sw_release_resources_tx, tls_sw_drain_tx,
> tls_set_sw_offload) call tls_encrypt_async_wait() first.  Should the
> same wait happen here before re-keying the same tfm, so in-flight
> encryptions cannot pick up K2 instead of the K1 they were submitted
> with?
>
> [ ... ]
> > +     } else {
> > +             rc =3D tls_device_init_rekey_sw(sk, ctx, offload_ctx,
> > +                                           new_crypto_info);
> [ ... ]
> > +             WRITE_ONCE(ctx->rekey.boundary_seq, tcp_sk(sk)->write_seq=
);
> > +
> > +             /* Prevent a partial record straddling the SW/HW boundary=
. */
> > +             tcp_write_collapse_fence(sk);
> > +
> > +             ctx->rekey.sw_ctx =3D &offload_ctx->rekey.sw;
> > +             ctx->rekey.cipher_ctx =3D &offload_ctx->rekey.tx;
> > +
> > +             set_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> [ ... ]
> > +     unsafe_memcpy(&offload_ctx->rekey.crypto_send.info, new_crypto_in=
fo,
> > +                   cipher_desc->crypto_info,
> > +                   /* checked in do_tls_setsockopt_conf */);
> > +     memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
> > +
> > +     return 0;
> > +}

Yes, I'll add a wait for in-flight async encryptions submitted to this
tfm with the previous key before changing it.

> [Medium]
> new_crypto_info is zeroized after the copy, but is the staging area
> itself ever scrubbed?
>
> offload_ctx->rekey.crypto_send.info, offload_ctx->rekey.tx.iv, and
> offload_ctx->rekey.tx.rec_seq receive the same key bytes via
> unsafe_memcpy/memcpy.  tls_device_complete_rekey() does not scrub them
> on success, and tls_device_free_resources_tx() / tls_device_tx_del_task()
> kfree the offload_ctx without a memzero_explicit().  Should those sites
> zero the staging area to limit the window in which key bytes are
> recoverable from slab memory after rotation?

Yes, I'll scrub the rekey staging area.

> > +static int tls_device_complete_rekey(struct sock *sk, struct tls_conte=
xt *ctx,
> > +                                  bool deferred)
> > +{
> [ ... ]
> > +     if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
> > +             netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
> > +                                             TLS_OFFLOAD_CTX_DIR_TX);
> > +             set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
> > +     }
> > +
> > +     memcpy(crypto_info_rec_seq(&offload_ctx->rekey.crypto_send.info, =
cipher_desc),
> > +            offload_ctx->rekey.tx.rec_seq, cipher_desc->rec_seq);
> > +
> > +     rc =3D tls_device_dev_add_tx(sk, netdev, &offload_ctx->rekey.cryp=
to_send.info,
> > +                                tcp_sk(sk)->write_seq);
> > +
> > +release_lock:
> > +     up_read(&device_offload_lock);
> > +
> > +     spin_lock_irqsave(&offload_ctx->lock, flags);
> > +     memcpy(&rcd_sn, offload_ctx->rekey.tx.rec_seq, sizeof(rcd_sn));
> > +     offload_ctx->unacked_record_sn =3D be64_to_cpu(rcd_sn) - 1;
> > +     spin_unlock_irqrestore(&offload_ctx->lock, flags);
> > +
> > +     memcpy(ctx->tx.iv, offload_ctx->rekey.tx.iv,
> > +            cipher_desc->salt + cipher_desc->iv);
> > +     memcpy(ctx->tx.rec_seq, offload_ctx->rekey.tx.rec_seq,
> > +            cipher_desc->rec_seq);
> > +     unsafe_memcpy(&ctx->crypto_send.info,
> > +                   &offload_ctx->rekey.crypto_send.info,
> > +                   cipher_desc->crypto_info,
> > +                   /* checked during rekey setup */);
> > +
> > +     if (rc)
> > +             goto rekey_fail;
> > +
> > +     clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
> > +
> > +     key =3D crypto_info_key(&offload_ctx->rekey.crypto_send.info, cip=
her_desc);
> > +     rc =3D crypto_aead_setkey(offload_ctx->aead_send, key, cipher_des=
c->key);
> > +     if (rc)
> > +             goto rekey_fail;
>
> [High]
> Can these unconditional copies of the new key material into ctx->tx.iv,
> ctx->tx.rec_seq, and ctx->crypto_send.info before the rc check leave
> inconsistent state on failure?
>
> If tls_device_dev_add_tx() failed, control reaches rekey_fail with:
>
>   - HW context removed (TLS_TX_DEV_CLOSED set)
>   - ctx->crypto_send.info advertising the NEW key
>   - ctx->tx.iv and ctx->tx.rec_seq holding the NEW salt/IV/rec_seq
>   - offload_ctx->aead_send still holding the OLD key (the setkey for it
>     is reached only after the rc check)
>
> Userspace getsockopt(SOL_TLS, TLS_TX) would then read NEW key bytes that
> no kernel AEAD ever absorbed.  Any subsequent fallback that builds IVs
> from ctx->tx and encrypts via offload_ctx->aead_send would mix NEW salt
> with the OLD key.
>
> Could the memcpy block move below the rc check?
>

I'll move the memcpys below the rc check.

> [High]
> On the success path, is there a window where tls_device_down() sees
> stale TLS_TX_DEV_CLOSED?
>
> The success path here:
>
>         if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
>                 netdev->tlsdev_ops->tls_dev_del(...);
>                 set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
>         }
>         ...
>         rc =3D tls_device_dev_add_tx(...);   /* installs NEW HW ctx */
>
> release_lock:
>         up_read(&device_offload_lock);
>         ...
>         if (rc) goto rekey_fail;
>         clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
>
> Between dropping device_offload_lock and clear_bit(), can
> tls_device_down() take down_write(&device_offload_lock) and run:
>
>         if (ctx->tx_conf =3D=3D TLS_HW &&
>             !test_bit(TLS_TX_DEV_CLOSED, &ctx->flags)) {
>                 netdev->tlsdev_ops->tls_dev_del(...);
>                 set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
>         }
>
> It sees TLS_TX_DEV_CLOSED still set, skips tls_dev_del() for the
> freshly-installed NEW HW context, and proceeds to clear ctx->netdev.
> Would the new NIC-side TLS state then be leaked until the netdev is
> unregistered?
>
> Should TLS_TX_DEV_CLOSED be cleared while still holding
> device_offload_lock?

I will fix this TLS_TX_DEV_CLOSED issue.

>
> > +
> > +     /* Start marker: the NIC passes through everything before
> > +      * write_seq unencrypted (already SW-encrypted during rekey),
> > +      * same as during initial offload setup.
> > +      */
> > +     tls_device_commit_start_marker(sk, offload_ctx, start_marker_reco=
rd);
> [ ... ]
> > +rekey_fail:
> > +     kfree(start_marker_record);
> > +     set_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> > +     clear_bit(TLS_TX_REKEY_READY, &ctx->flags);
> > +     clear_bit(TLS_TX_REKEY_PENDING, &ctx->flags);
> > +     if (deferred)
> > +             TLS_DEC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYINPROGRES=
S);
> > +     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYFALLBACK);
> > +
> > +     return 0;
> > +}
>
> [Medium]
> After REKEY_FAILED, the connection is structurally encrypting in SW even
> though ctx->tx_conf stays TLS_HW.  TLSCURRTXDEVICE is never decremented
> and TLSCURRTXSW is never incremented in this path.  Should the
> current-mode gauges in /proc/net/tls_stat reflect the actual encryption
> mode for these connections?

I'll make suggested change

> > +static int tls_set_device_offload_rekey(struct sock *sk,
> > +                                     struct tls_context *ctx,
> > +                                     struct net_device *netdev,
> > +                                     struct tls_crypto_info *new_crypt=
o_info)
> > +{
> > +     struct tls_offload_context_tx *offload_ctx =3D tls_offload_ctx_tx=
(ctx);
> > +     bool rekey_pending =3D test_bit(TLS_TX_REKEY_PENDING, &ctx->flags=
);
> > +     bool rekey_failed =3D test_bit(TLS_TX_REKEY_FAILED, &ctx->flags);
> > +     bool defer =3D true;
> > +     int rc;
> > +
> > +     if (!rekey_pending && !rekey_failed)
> > +             defer =3D tls_has_unacked_records(offload_ctx);
> > +
> > +     down_read(&device_offload_lock);
> > +
> > +     rc =3D tls_device_start_rekey(sk, ctx, offload_ctx, new_crypto_in=
fo);
> > +     if (rc) {
> > +             up_read(&device_offload_lock);
> > +             return rc;
> > +     }
> > +
> > +     up_read(&device_offload_lock);
> > +
> > +     if (defer) {
> > +             if (!rekey_pending)
> > +                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYI=
NPROGRESS);
> > +             else
> > +                     TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXREKEYO=
K);
> > +             return 0;
> > +     }
> > +
> > +     return tls_device_complete_rekey(sk, ctx, false);
> > +}
>
> [Medium]
> On the rekey_pending path here, TLSTXREKEYOK is incremented before any
> HW reinstall actually happens.  Combined with the increment in
> tls_device_complete_rekey() on success and the increment in
> tls_device_free_resources_tx() when PENDING is set at close, can a
> single logical successful rekey produce more than one TLSTXREKEYOK
> increment?

The accounting is per-setsockopt, not per-HW-install, same convention
as the SW path (tls_main.c:743 also bumps TlsTxRekeyOk once per
successful setsockopt). When two
setsockopt calls overlap a single HW transition, each call gets one
final outcome. The early OK++ in the rekey_pending branch
credits the previous in-flight setsockopt (which is implicitly
"completed" from userspace's view, since its key is now being
replaced). The trailing complete_rekey
OK++ credits the current one. No setsockopt produces zero or two
final-outcome bumps, each produces exactly one.

> [Medium]
> tls_has_unacked_records() inspects offload_ctx->records_list only.  Is
> that sufficient to decide whether to defer?  pending_open_record_frags
> or offload_ctx->open_record can still hold pre-rekey state, in which
> case the !defer path falls into tls_device_complete_rekey(deferred=3Dfals=
e),
> tls_sw_drain_tx() returns -EAGAIN, setsockopt returns the error to
> userspace via err_crypto_info, and none of the state transitions from
> tls_device_start_rekey() (PENDING bit, sw_ctx, cipher_ctx, boundary_seq,
> sk_validate_xmit_skb) are rolled back.  Should the failure path either
> roll those back or transition to a defined recovery state?

I'll check tls_is_pending_open_record also to decide whether to defer

> [ ... ]
>
> > diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallbac=
k.c
> > index 1110f7ac6bcb..64ac4ef4012b 100644
> > --- a/net/tls/tls_device_fallback.c
> > +++ b/net/tls/tls_device_fallback.c
> > @@ -435,6 +435,30 @@ struct sk_buff *tls_validate_xmit_skb_sw(struct so=
ck *sk,
> >       return tls_sw_fallback(sk, skb);
> >  }
> >
> > +struct sk_buff *tls_validate_xmit_skb_rekey(struct sock *sk,
> > +                                         struct net_device *dev,
> > +                                         struct sk_buff *skb)
> > +{
> > +     struct tls_context *tls_ctx =3D tls_get_ctx(sk);
> > +     u32 tcp_seq =3D ntohl(tcp_hdr(skb)->seq);
> > +     u32 boundary_seq;
> > +
> > +     if (test_bit(TLS_TX_REKEY_FAILED, &tls_ctx->flags))
> > +             return skb;
> > +
> > +     /* If this packet is at or after the rekey boundary, it's already
> > +      * SW-encrypted with the new key, pass through unchanged
> > +      */
> > +     boundary_seq =3D READ_ONCE(tls_ctx->rekey.boundary_seq);
> > +     if (!before(tcp_seq, boundary_seq))
> > +             return skb;
> > +
> > +     /* Packet before boundary means retransmit of old data,
> > +      * use SW fallback with the old key
> > +      */
> > +     return tls_sw_fallback(sk, skb);
> > +}
>
> [Critical]
> Can this leak plaintext on the wire after REKEY_FAILED?
>
> The first branch returns the skb unchanged whenever
> TLS_TX_REKEY_FAILED is set, regardless of where tcp_seq is relative to
> boundary_seq.
>
> After tls_device_complete_rekey() has called tls_dev_del() and then
> landed in rekey_fail, there is no NIC TLS context for the socket.
> SKBs from before the boundary are still sitting in the socket write
> queue with plaintext payload, because HW-offload semantics expected the
> NIC to encrypt them at TX time.  When TCP retransmits one of those old
> skbs:
>
>         tcp_seq < boundary_seq, but TLS_TX_REKEY_FAILED is set
>         -> early return skb unchanged
>         -> NIC has no TLS context for this flow
>         -> driver transmits the skb as-is
>
> Should the FAILED branch still route pre-boundary packets through
> tls_sw_fallback() with the old key, the same way the non-failed branch
> does, so that pre-boundary retransmits are encrypted?
>
> > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > index fd04857fa0ab..2548ad2b2219 100644
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> > @@ -371,6 +371,8 @@ static void tls_sk_proto_close(struct sock *sk, lon=
g timeout)
> >
> >       if (ctx->tx_conf =3D=3D TLS_SW)
> >               tls_sw_cancel_work_tx(ctx);
> > +     else if (ctx->tx_conf =3D=3D TLS_HW && ctx->rekey.sw_ctx)
> > +             tls_sw_cancel_work_tx(ctx);
> >
> >       lock_sock(sk);

boundary_seq captures tcp_sk(sk)->write_seq at start_rekey;
clean_acked_data only sets REKEY_READY when acked_seq >=3D boundary_seq;
complete_rekey is only invoked when READY is set i.e.
complete_rekey only runs when all pre-boundary data is already ACKed.
So when complete_rekey fails and sets REKEY_FAILED, the pre-boundary
plaintext SKBs have already been ACKed and removed from
sk_write_queue. The early return in tls_validate_xmit_skb_rekey is
safe because no pre-boundary data remains in the write queue for
retransmission.

> [High]
> Is reading ctx->rekey.sw_ctx before lock_sock(sk) safe?
>
> ctx->rekey.sw_ctx is published by tls_device_start_rekey() under
> lock_sock.  Here close reads it before taking lock_sock, so a concurrent
> setsockopt rekey can publish sw_ctx after this read but before close
> acquires the socket lock.  Close then proceeds without canceling the
> delayed tx_work, while later cleanup
> (tls_device_free_resources_tx -> tls_sw_release_resources_tx) frees
> aead_send.
>
> If a tx_work_handler scheduled by the rekey path runs after that, can it
> touch the freed delayed_work or aead_send?
>
> Should the read be moved under lock_sock, or should
> tls_sw_release_resources_tx() internally cancel the delayed work?
>

Why setsockopt and close can't be concurrent here:

  tls_sk_proto_close is proto->close. It is reached only via
inet_release =E2=86=92 __sock_release =E2=86=92 run from __fput when the fi=
le's last
reference drops. Any syscall that could mutate ctx->rekey.sw_ctx
(setsockopt, sendmsg) holds a file reference for its entire duration. So wh=
ile
one thread is inside do_tls_setsockopt_conf publishing sw_ctx, the
file refcount cannot reach 0, and tls_sk_proto_close cannot start. By
the time tls_sk_proto_close runs, no setsockopt/sendmsg is in flight
on this socket.

  The existing line proves the pattern is intended:

  The pre-existing check at tls_main.c:372 (if (ctx->tx_conf =3D=3D
TLS_SW) tls_sw_cancel_work_tx(ctx)) already reads ctx->tx_conf before
lock_sock. tx_conf is likewise only written under setsockopt. The new
ctx->rekey.sw_ctx read at line 374 relies on the same invariant, so
if you accept line 372 as safe, line 374 is too.

