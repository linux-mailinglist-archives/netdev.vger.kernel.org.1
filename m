Return-Path: <netdev+bounces-300538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WplCANdoNGpEXQYAu9opvQ
	(envelope-from <netdev+bounces-300538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 23:53:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC936A2D05
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 23:53:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="oaX/Ezio";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300538-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300538-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E98AE303CF1F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9702DA768;
	Thu, 18 Jun 2026 21:53:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D222D4C3
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 21:53:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781819604; cv=pass; b=M/Hxg9YeK3pPuLrue+w7Ui3SW68TLJ+b4vMfYVi3i9Pwnl6Rw1P10dKkgOQdrGPmclWORhqJe19oGMT8WBw+7wnMdblhHdsu/F6TomRAHcNKdXQr/vuF9Wod0wzNC3DCqjdPoAxM8ErTB6d37zWivQ9jIT8evQurVxMi6K0+kqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781819604; c=relaxed/simple;
	bh=YMO43J3cZnRUvfuLZ+1gETkymzPbzO86fspB24J5G6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MYoG4pyFSP76+O1rzNTMr8uDjggIo3B4eNme8WS/LS/ZmkBrEmvw8HZv/NXRRCpPbWrbPolZS1g9MwP3xx+h2f1LTiFcL1uIRjooWz5JUkNvgdUwBV7t27GuD7M+oTm6c/5jSZZ/ElPD9n+lOu+VBmKztt/qQ/LNgoP0/Ft3g7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oaX/Ezio; arc=pass smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8424b00710aso994762b3a.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 14:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781819602; cv=none;
        d=google.com; s=arc-20240605;
        b=VSwpkWoQdsd+4qwvuYE6eafBEhR7K1eA2xR/QeW95VloGLbilbreclec3zR0nKo/IP
         GcrSWIqL7dTNdxri5La1KJFyIlJwicPrqH32OSjHIhpBzlnL6xG5Sqjjaqytldh6LVsK
         GmqQKtNAF/nDq6eje1P+2cUb8UPB4s0XEa5JEsCz+keZKJJ+lRexJIHPwIjS1ziWNTqM
         OVQHfs4WBDpZu1JUyQsYeRjrl3r4ex+lDdu1cl1TJhzkOdrmr4Km6r9XgrCR2RJhDU9i
         ETodiIAr8FeirXd+9z0tf3OWE+zH5OjZqLneCP+qHJn9P2YR4K1Rx1xjYGTuzpguLOF5
         TIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAny38H7bKaGVLr4LVrVXviNVzbAjjQaLOwVhV4pBI8=;
        fh=bPWtr0gPe0NqD52gA6wscJA50bRcDkbd6O3I13RwQtQ=;
        b=B6ULlRv4zc93VCUMU2I+qXVkwvacTnKTo5ffK9lw4GnhBVWF1XMfUH0AFFXgL+IfSb
         o2PG5TAZ+ohZv3gJG/2IPI0LfZERms2NBSgTAlUsUCa7Z7aC8uY9MiL9O0HYaZqu5jZK
         DSJzfC/SClsSyTMRzGYQ2dpPffK6F27nFOvD/PMe+S9WPC7qK1fOf6mPRm3qFJ8xNa/L
         Zupzjpu6rPTZlrB509GrLb361WO78XHIVdrhtgEMJcj09wZEkkxu2AiEp7SmCd8ghYqT
         IKAngdQuC4Vb4yOkGqK8iqh2dyzZ535E7IzjuFpDpLAejHAvUlldBcYPN0i6taNJ5gKF
         +5Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781819602; x=1782424402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAny38H7bKaGVLr4LVrVXviNVzbAjjQaLOwVhV4pBI8=;
        b=oaX/EzioW199wp958FgJcJSNXCaPB+VN6O8y7OkoWxJqotVlczPD+KrtXd0HYZbflZ
         p/Y3kGojDY+kNP4KIVX4mu3xNjzpSzZ8a3FhOm4Syrx1QdsT74PdU25IlBXDCpzQALcC
         uSl5BKCwxTJ5HfYH9yr+ALwZ8mQkZryz4ZxN0BpFGdQ9sdmMg3xQmZvdoGIsDLcysHZh
         1yKO3SpXfIjyHcZHPasYxRm9Hzf30ynBRmizHA7Gm5iWFJGme+P9tp4XUEIUsIgsp51H
         tglygqMV3C6+mM5dKC8+Si+Ka9pngCcSa5slw5JjekwmRC82I8dq/JW/GoRV6Ii201+j
         3aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781819602; x=1782424402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAny38H7bKaGVLr4LVrVXviNVzbAjjQaLOwVhV4pBI8=;
        b=XPiAO/k8K6JI8yxuwrRunRBpYM1KEOedb6UOZjzfejjBXgPa/X5qpLE3pvsC2+b8zZ
         JGizvQ5uOMk7AXyFPXGNhbkEfhmGL+vdgK1YELNZ4HoLcm6zl9nkjgZ7mFRgjA1HSt4S
         EjrHIoob3aXObB+1BQlI6Pn7OpErvYvcdlggdi31LcXWVEnV7YPy5e1mYtU7NTN0MBjD
         fvx2GC4BqsvZVE7EoyRSJRe9x1NwVjnpqMTS19g2jgrk5zhtGEMudX+FIeZ2f4lGchxD
         BeMwkAZxGZDHXkRGqSs70IzyC5s2YXS8/MMapsTFNbsLl3wWX5O3RDi9lrc2xY0r0DLE
         zAxg==
X-Gm-Message-State: AOJu0YwF6I4BpmVAlAtRzRX8yopFaGGbzNl91MuTP9rTJwViGhoLSyaC
	mGAwQydRIYD+RzWipASglPPTcnRpzW0MfyL+ujQOq2txWEIs8wSoUwmmEQgvC0gbAoNN6Wp5GQG
	P7m5rQ0aIWYvvnI3PkK/z7sLoRbuDJTE=
X-Gm-Gg: AfdE7cn0k2X0/I0mP56sssVAPN0R1EFHC6R9Fazuud1PQZP/3KbysrEqtNDKa4iach5
	hZgX+hPDT9cAchVi9ihzAWyNuhlpxAWGKhHAJAeABygcUelEZgV3Hm/I1YpMwLxsuu2yaa7KMCB
	963nbTY7q3zXE7zcJELNTkeO3VlhMmg4e0DLYD5yPoghPWuRhvb5z66X0BgRpPxAcc4HALNpv5h
	T83Hec7+PQX49+0lx8jf8UX+efE7mSh42oAkk4p1w8v654vCztgRyIaiiT0AWhPDcRa1gSjTOCk
	Nq7i4tNfZZIMf8XO2KC7UTuyriset6po4Cs+01A6s5133ebDd3Gqn9SwFmXPaXuwhmQdD4A=
X-Received: by 2002:a05:6a00:2eaa:b0:842:7992:bdd6 with SMTP id
 d2e1a72fcca58-845508a31e5mr765052b3a.36.1781819602018; Thu, 18 Jun 2026
 14:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6fb546c80126a410349e724045ce16a41413c8a6.1781570014.git.lucien.xin@gmail.com>
 <20260617103954.852101-1-horms@kernel.org>
In-Reply-To: <20260617103954.852101-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 18 Jun 2026 17:53:10 -0400
X-Gm-Features: AVVi8CdIsFlMHiqeipmDpZBZDCGc_EtgA5iE9uNSAv2R6sb5gq0MCQADkEqE1ag
Message-ID: <CADvbK_eCmu6vTWPhTXXua46wP9HJ6LB8PD7pjPo163jqvKjJZw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] sctp: factor out INIT verification failure handling
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	marcelo.leitner@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300538-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEC936A2D05

On Wed, Jun 17, 2026 at 6:40=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> sctp: factor out INIT verification failure handling
>
> This refactor moves the duplicated INIT/INIT-ACK error handling out of
> sctp_sf_do_5_1B_init(), sctp_sf_do_5_1C_ack(), and
> sctp_sf_do_unexpected_init() into a new helper sctp_abort_on_init_err().
> The commit message states "No functional change intended."
>
> > diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> > index 9b23c11cbb9e..544f308ee527 100644
> > --- a/net/sctp/sm_statefuns.c
> > +++ b/net/sctp/sm_statefuns.c
>
> [ ... ]
>
> > @@ -548,50 +531,9 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct n=
et *net,
> >       err_chunk =3D NULL;
> >       if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
> >                             (struct sctp_init_chunk *)chunk->chunk_hdr,=
 chunk,
> > -                           &err_chunk)) {
> > -
> > -             enum sctp_error error =3D SCTP_ERROR_NO_RESOURCE;
> > -
> > -             /* This chunk contains fatal error. It is to be discarded=
.
> > -              * Send an ABORT, with causes.  If there are no causes,
> > -              * then there wasn't enough memory.  Just terminate
> > -              * the association.
> > -              */
> > -             if (err_chunk) {
> > -                     packet =3D sctp_abort_pkt_new(net, ep, asoc, arg,
> > -                                     (__u8 *)(err_chunk->chunk_hdr) +
> > -                                     sizeof(struct sctp_chunkhdr),
> > -                                     ntohs(err_chunk->chunk_hdr->lengt=
h) -
> > -                                     sizeof(struct sctp_chunkhdr));
> > -
> > -                     sctp_chunk_free(err_chunk);
> > -
> > -                     if (packet) {
> > -                             sctp_add_cmd_sf(commands, SCTP_CMD_SEND_P=
KT,
> > -                                             SCTP_PACKET(packet));
> > -                             SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNK=
S);
> > -                             error =3D SCTP_ERROR_INV_PARAM;
> > -                     }
> > -             }
> > -
> > -             /* SCTP-AUTH, Section 6.3:
> > -              *    It should be noted that if the receiver wants to te=
ar
> > -              *    down an association in an authenticated way only, t=
he
> > -              *    handling of malformed packets should not result in
> > -              *    tearing down the association.
> > -              *
> > -              * This means that if we only want to abort associations
> > -              * in an authenticated way (i.e AUTH+ABORT), then we
> > -              * can't destroy this association just because the packet
> > -              * was malformed.
> > -              */
> > -             if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
> > -                     return sctp_sf_pdiscard(net, ep, asoc, type, arg,=
 commands);
> > -
> > -             SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
> > -             return sctp_stop_t1_and_abort(net, commands, error, ECONN=
REFUSED,
> > -                                             asoc, chunk->transport);
> > -     }
> > +                           &err_chunk))
> > +             return sctp_abort_on_init_err(net, ep, asoc, chunk, arg,
> > +                                           commands, err_chunk);
>
> [High]
> In the original sctp_sf_do_5_1C_ack() the "if (err_chunk) { ... }"
> block is non-controlling: when err_chunk is NULL the code skips the
> block, falls through with error =3D=3D SCTP_ERROR_NO_RESOURCE, consults
> sctp_auth_recv_cid(SCTP_CID_ABORT, asoc) and either pdiscards or runs
> sctp_stop_t1_and_abort() to tear the half-open association down.
>
> [High]
> In the new helper, can the INIT-ACK + NULL err_chunk case still reach
> that path?  Looking at sctp_abort_on_init_err():
>
>   if (!err_chunk)
>           return sctp_sf_tabort_8_4_8(net, ep, asoc, SCTP_ST_CHUNK(0),
>                                       arg, commands);
>
>   ...
>   if (chunk->chunk_hdr->type !=3D SCTP_CID_INIT_ACK) {
>           ...
>   }
>   /* SCTP-AUTH, Section 6.3 ... */
>   if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
>           return sctp_sf_pdiscard(...);
>   SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
>   return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
>                                 asoc, chunk->transport);
>
> [High]
> The !err_chunk early return runs before the INIT-ACK type check, so
> when sctp_verify_init() returns 0 with *errp left as NULL on an
> INIT-ACK, control now goes to sctp_sf_tabort_8_4_8() rather than the
> auth-check + sctp_stop_t1_and_abort() path.
>
> [High]
> Is the NULL-err_chunk case actually reachable on an INIT-ACK?  In
> sctp_process_inv_mandatory() and sctp_process_inv_paramlength() in
> net/sctp/sm_make_chunk.c, *errp is allocated via sctp_make_op_error_space=
()
> or sctp_make_violation_paramlen() and the function returns 0
> unconditionally:
>
>   if (!*errp)
>           *errp =3D sctp_make_op_error_space(asoc, chunk, 0);
>   if (*errp)
>           sctp_init_cause(...);
>   return 0;
>
> So an allocation failure on a malformed INIT-ACK reaches the helper
> with err_chunk =3D=3D NULL.
>
> [High]
> On that path, does the new code skip several actions that the original
> performed?  sctp_sf_tabort_8_4_8() emits an OOTB ABORT and pdiscards;
> it does not stop T1-init, does not call SCTP_CMD_SET_SK_ERR(ECONNREFUSED)=
,
> does not issue SCTP_CMD_INIT_FAILED, does not transition the asoc to
> SCTP_STATE_CLOSED, and does not increment SCTP_MIB_ABORTEDS.
>
> [High]
> As a result, would connect(2) wait for T1-init to exhaust its
> retransmissions instead of receiving ECONNREFUSED promptly, and would
> SCTP_MIB_ABORTEDS no longer be incremented (with SCTP_MIB_IN_PKT_DISCARDS
> being incremented in its place)?
>
> [High]
> Does this also bypass the SCTP-AUTH section 6.3 check quoted in the
> comment?  Previously, when AUTH-ABORT was negotiated and err_chunk
> was NULL, sctp_auth_recv_cid() caused sctp_sf_pdiscard() to be returned
> and no ABORT was emitted on the wire.  In the new path, sctp_sf_tabort_8_=
4_8()
> sends an unauthenticated OOTB ABORT regardless of AUTH negotiation.
>
> [High]
> Finally, does the disposition return value also change from
> SCTP_DISPOSITION_ABORT to SCTP_DISPOSITION_CONSUME on this path?
>
> [High]
> Would moving the chunk->chunk_hdr->type check ahead of the !err_chunk
> early return restore the original semantics for INIT-ACK while keeping
> the sctp_sf_tabort_8_4_8() fallback for INIT?
>
All above is talking about one regression, the (!err_chunk) check should be
after (chunk->chunk_hdr->type !=3D SCTP_CID_INIT_ACK) check.

This is a good catch, and I will fix it on v2.

Thanks.

> [ ... ]
>
> > @@ -6485,6 +6403,61 @@ static void sctp_send_stale_cookie_err(struct ne=
t *net,
> >       }
> >  }
> >
> > +static enum sctp_disposition sctp_abort_on_init_err(
> > +                                     struct net *net,
> > +                                     const struct sctp_endpoint *ep,
> > +                                     const struct sctp_association *as=
oc,
> > +                                     const struct sctp_chunk *chunk,
> > +                                     void *arg,
> > +                                     struct sctp_cmd_seq *commands,
> > +                                     struct sctp_chunk *err_chunk)
> > +{
> > +     enum sctp_error error =3D SCTP_ERROR_NO_RESOURCE;
> > +     struct sctp_packet *packet;
> > +     struct sctp_chunkhdr *ch;
> > +
> > +     if (!err_chunk)
> > +             return sctp_sf_tabort_8_4_8(net, ep, asoc, SCTP_ST_CHUNK(=
0),
> > +                                         arg, commands);
> > +
> > +     ch =3D err_chunk->chunk_hdr;
> > +     packet =3D sctp_abort_pkt_new(net, ep, asoc, arg,
> > +                                 (__u8 *)ch + sizeof(*ch),
> > +                                 ntohs(ch->length) - sizeof(*ch));
> > +
> > +     sctp_chunk_free(err_chunk);
> > +
> > +     if (packet) {
> > +             sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
> > +                             SCTP_PACKET(packet));
> > +             SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
> > +             error =3D SCTP_ERROR_INV_PARAM;
> > +     }
> > +
> > +     if (chunk->chunk_hdr->type !=3D SCTP_CID_INIT_ACK) {
> > +             if (!packet)
> > +                     return SCTP_DISPOSITION_NOMEM;
> > +             return SCTP_DISPOSITION_CONSUME;
> > +     }
> > +     /* SCTP-AUTH, Section 6.3:
> > +      *    It should be noted that if the receiver wants to tear
> > +      *    down an association in an authenticated way only, the
> > +      *    handling of malformed packets should not result in
> > +      *    tearing down the association.
> > +      *
> > +      * This means that if we only want to abort associations
> > +      * in an authenticated way (i.e AUTH+ABORT), then we
> > +      * can't destroy this association just because the packet
> > +      * was malformed.
> > +      */
> > +     if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
> > +             return sctp_sf_pdiscard(net, ep, asoc, SCTP_ST_CHUNK(0), =
arg,
> > +                                     commands);
> > +
> > +     SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
> > +     return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
> > +                                   asoc, chunk->transport);
> > +}

