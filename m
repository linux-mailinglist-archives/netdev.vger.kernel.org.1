Return-Path: <netdev+bounces-301393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WhNiLhOcOmpbBggAu9opvQ
	(envelope-from <netdev+bounces-301393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:45:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC56B8000
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 16:45:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HwWOh4GP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301393-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301393-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA9CC30422E9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C0E3C0A12;
	Tue, 23 Jun 2026 14:45:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404CC37C926
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 14:45:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225935; cv=pass; b=i05NPNbJkeW+A0OhE68Q0UPo54SZ3e/F70hglP3iGR/jnOjqV+nQIXzYPQLKJnWX4Gj0uQ3opwO5Nuyb7nRX5ohadEkqjeEBt9qjMMrpitjCY/jR5fKzlVTn0usRZF5ooa0oWg9XP3Hjq8g50v8tridzdHTLrPifyraVNB+ckG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225935; c=relaxed/simple;
	bh=TWDxtNBN1wtcPoOt7UHbi2xXpEZpXLvOIqhPtM9hZhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT6rLvJw6SIcGi0HDHiMmzTfJesopq0cp65j2ChhONRfJFY82unwMRYvXCuxE4DAB7cqbSTDBeRIsV03GtiJyGRzNKjeGIDwgEBr8JJQooX2Idur9n/H+wqn6ftCRNpMTHzjVdx4+aw0Nh/h9d/N/TMLwvYYRemPRGKnqztJLyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwWOh4GP; arc=pass smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-842848fd613so4682637b3a.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 07:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782225933; cv=none;
        d=google.com; s=arc-20240605;
        b=AOZ6K6uwQzakXntZdXur4C839p+ELEZkjpDKJLwGBp0FsaU/hAFkEdje9CkDCCKHrU
         gH6F4VgPtFx2NziT9myJiTJI0wcMa5x0McU3tiGHqoH3oKzm/KbpoBjSXEl3LMy56i1z
         CqNboyGkJjQigcrTRfYPOPM++ieRLUGZd/5l86Xdyb6MI2jBs6zbL55kBGFzDv2R2pI+
         m41rgZZeyoco5ILGp+YJ97jY7QZ6KkEFKlEuCISgzOTag6uqIFo3huUzgmTqPuoOlCvW
         yuPZzaO+oWFymFIvgM3uHsXyY/euSNlWI0xRm0fnLb3AjKQruGp0gBAyhmrlvBT4wO7q
         UkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7YrJwCPEG0aBXTN15tNlhGW5UegrbPvJCOtLBHc3hwM=;
        fh=bPWtr0gPe0NqD52gA6wscJA50bRcDkbd6O3I13RwQtQ=;
        b=DM44i4U6L+XcsDqNIpCUnl5vElmtu/iUmFeVRBXc/31g6VEhipKMUom22rHUdX8fZQ
         dKkyO5dUXcfTZ+ZiNpDV2QrOyMhEaycqd89tW7e+PQOsFHOjzzvKUtQ956HSiDoCUxOL
         XE5s9UiE8S78eQAuOjPctnJvnTf1OZ9LXXqknyrjoxV1ytwATxcONlNnETfRauuP1kkx
         munU5Kc+sbrdYuWdycfBnsAlAxDJBkPcup6w/CPIw8/33FUSTxf14Oepj7mbeC4u4SCl
         gTT0j3tq3cmtWGsSeH/V9EUhlTC2SfwCCBsO1GyoqQTg7/I9H61jh/AfIGySQZk7NCnd
         oAqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225933; x=1782830733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YrJwCPEG0aBXTN15tNlhGW5UegrbPvJCOtLBHc3hwM=;
        b=HwWOh4GPUuPuXt17QC4afV4QX542hoX3qhnxast2IbB5d11fPuxgXn16q5csSkqky2
         2TTxRvlqGaFpGAAzzmQt4gvHBR/vTTt2dBh+2bnPdLMkxDX0qe6Cansv/ARUZ4d8aJ4k
         wt0rh089K9cDO0wxb6eiWOILb739TV7xT2ts8Ty5XkaN9nmP28v0zou4JAqTFHGnkdOc
         c6ul7cq2sX6r/H8pXjMClf7GjuhyaUFBM6pmWCo3/Gm2ZJ8h72oCuILFElqn0iOUfZm5
         d1j500QZunEEPejKQU7pnflCB8PWJjoCn1O6Senix7dVAQOnXhXz1rPIO6RJmMSwqltA
         2bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225933; x=1782830733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YrJwCPEG0aBXTN15tNlhGW5UegrbPvJCOtLBHc3hwM=;
        b=VTKzbS2j4oQO1mOpX406kdkFEw/sQ2xU+j13DtsdeQlBI6Uij1A2rc0u+j1mQwhC7d
         KX49Sh8XOTxXDemfMIUcWtDouuQL6tT1Bk/lFTaKM2j2DNrJ4OcQh7Vc5pwWBxBLnOJu
         HaG5s02EnUwY/YGo5RuaY1ano/IMH9eJKfdGxrzha6ro6ZxSlfdMoohdzRl8hPf5tYKW
         MeCWlGmkqY1G/DbTRqrK/cQTn1aVd/78OH3XrMwk/wSFmePq+MK329YSX2U923EYSd+A
         69vim/eONb8GpobMyYRD+6CZ9TJA7V9m3gUatgvdOKl8T5JfjSMWjmAFCFT+Prs0BzGj
         WE/g==
X-Gm-Message-State: AOJu0YwIEiL+r0v98jE7amftMuAOryFz+iAOujgCi+REceIqfbkrHnxb
	kkFQ3J7iBRGSjPUZObCeUY1sLKn43jMlosEyfiIE7AnzW/70RFJjPoRo0tHRraM7X2pGQKE4SFm
	ExnjOfA6xPUYt3Z1PPYxUZdq7p8mx/zY=
X-Gm-Gg: AfdE7cnMjhR+VQ5sWtWvqrxL7eMg1ay6ltYIfoLk0t2+13tqv4IDr5Z5qP41/wzxQy1
	SExpAHPbOUhQpAmJrATMtSrG7cdCU0WBhSymTWgiYONI35mSHwlLhVQNkF2NcpY/7TCDs3KZNCO
	BgBrpcHDjUgJVEOfgAUbFoTMPqcqqRk1bNHSu6rbxd91YX6hSgelb4p4pfALsGXDDtVgUYPBrs+
	fFcC06GJ++j7fgAni6xDtZqbhcrmC6mH4Qei7pu96OGMQfQUAvCA69z3t2xpHHQvf5CwzKAIzaR
	F6hEz/W7rfYxnSLXGjxBLulxU/7XYmden/whYWq58qyY3005FXMIz38a7Ut6WBFve+1cTQc=
X-Received: by 2002:a05:6a00:8d94:b0:843:46ee:9de6 with SMTP id
 d2e1a72fcca58-8456245767emr16301017b3a.9.1782225933257; Tue, 23 Jun 2026
 07:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c34fee6105f9051a52f8e774fe4c35f0e6ba0afc.1781968162.git.lucien.xin@gmail.com>
 <20260622165200.1050676-1-horms@kernel.org>
In-Reply-To: <20260622165200.1050676-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 23 Jun 2026 10:45:21 -0400
X-Gm-Features: AVVi8Cf67VBgrz-P6QNs7hqWOu3Y4VT7LWbbJFXjYz-7qpCdYTKbWCeCfYxH9G8
Message-ID: <CADvbK_cN=Sv9SmgdfZ=BFZedY10EmLurRnmv+en2ZQ5QbKvrdw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] sctp: add INIT verification after cookie unpacking
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
	TAGGED_FROM(0.00)[bounces-301393-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15CC56B8000

On Mon, Jun 22, 2026 at 12:52=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> sctp: add INIT verification after cookie unpacking
>
> This commit adds sctp_verify_init() checks in the COOKIE-ECHO processing
> paths sctp_sf_do_5_1D_ce() and sctp_sf_do_5_2_4_dupcook() when
> cookie_auth_enable is disabled, and updates sctp_verify_init() to bound
> the parameter walk against peer_init length rather than chunk->chunk_end.
> On verification failure the new association is freed and an ABORT is
> generated via sctp_abort_on_init_err().
>
> > diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> > index 8c636f045e45..6967e889d1bd 100644
> > --- a/net/sctp/sm_statefuns.c
> > +++ b/net/sctp/sm_statefuns.c
> > @@ -650,11 +650,12 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct n=
et *net,
> >                                        struct sctp_cmd_seq *commands)
> >  {
> >       struct sctp_ulpevent *ev, *ai_ev =3D NULL, *auth_ev =3D NULL;
> > +     struct sctp_chunk *err_chk_p =3D NULL;
> >       struct sctp_association *new_asoc;
> >       struct sctp_init_chunk *peer_init;
> >       struct sctp_chunk *chunk =3D arg;
> > -     struct sctp_chunk *err_chk_p;
> >       struct sctp_chunk *repl;
> > +     enum sctp_cid cid;
> >       struct sock *sk;
> >       int error =3D 0;
> >
> > @@ -728,6 +729,18 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct ne=
t *net,
> >               }
> >       }
> >
> > +     peer_init =3D (struct sctp_init_chunk *)(chunk->subh.cookie_hdr +=
 1);
> > +     cid =3D peer_init->chunk_hdr.type;
> > +     if (!sctp_sk(sk)->cookie_auth_enable &&
> > +         !sctp_verify_init(net, ep, asoc, cid, peer_init, chunk,
> > +                           &err_chk_p)) {
> > +             sctp_association_free(new_asoc);
> > +             return sctp_abort_on_init_err(net, ep, asoc, cid, arg, co=
mmands,
> > +                                           err_chk_p);
> > +     }
>
> [Critical]
> When cookie_auth_enable is disabled the cookie HMAC is not validated by
> sctp_unpack_cookie(), so every byte of the embedded INIT (including
> peer_init->chunk_hdr.type) is attacker-controlled.  Is it safe to feed
> that byte directly into both sctp_verify_init() and
> sctp_abort_on_init_err() as cid?
>
> Inside the COOKIE-ECHO body the embedded chunk is by RFC always an INIT.
> Could the cid argument be hard-coded to SCTP_CID_INIT (or
> peer_init->chunk_hdr.type be validated against SCTP_CID_INIT before use)
> instead of trusting the wire byte?
>
> Two attacker-reachable consequences look possible if cid is forged to
> SCTP_CID_INIT_ACK (3) and the STATE_COOKIE parameter is omitted:
>
> sctp_verify_init() then returns 0 via this branch with *errp populated:
>
>         if ((SCTP_CID_INIT_ACK =3D=3D cid) && !has_cookie)
>                 return sctp_process_missing_param(asoc, SCTP_PARAM_STATE_=
COOKIE,
>                                                   chunk, errp);
>
> control transfers to sctp_abort_on_init_err(net, ep, asoc, cid, ...) with
> cid =3D=3D SCTP_CID_INIT_ACK and a non-NULL err_chunk.  After sending the
> ABORT packet, that helper falls through to its out: label because
> cid =3D=3D SCTP_CID_INIT_ACK:
>
>         if (cid !=3D SCTP_CID_INIT_ACK) {
>                 if (!packet)
>                         return SCTP_DISPOSITION_NOMEM;
>                 return SCTP_DISPOSITION_CONSUME;
>         }
>
> out:
>         ...
>         return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
>                                       asoc, chunk->transport);
>
> In the sctp_sf_do_5_1D_ce() context, asoc is typically NULL (the function
> itself opens with if (asoc && !sctp_vtag_verify(chunk, asoc))).  Can the
> SCTP_CMD_NEW_STATE / SCTP_CMD_TIMER_STOP / SCTP_CMD_INIT_FAILED commands
> queued by sctp_stop_t1_and_abort() against a NULL asoc be dispatched
> without the sideeffect interpreter dereferencing asoc?
>
> > @@ -2205,6 +2219,19 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
> >       switch (action) {
> >       case 'A': /* Association restart. */
> >       case 'B': /* Collision case B. */
> > +             peer_init =3D (struct sctp_init_chunk *)
> > +                             (chunk->subh.cookie_hdr + 1);
> > +             cid =3D peer_init->chunk_hdr.type;
> > +             if (!sctp_sk(ep->base.sk)->cookie_auth_enable &&
> > +                 !sctp_verify_init(net, ep, asoc, cid, peer_init, chun=
k,
> > +                                   &err_chk_p)) {
> > +                     sctp_association_free(new_asoc);
> > +                     return sctp_abort_on_init_err(net, ep, asoc, cid,=
 arg,
> > +                                                   commands, err_chk_p=
);
> > +             }
> > +             if (err_chk_p)
> > +                     sctp_chunk_free(err_chk_p);
> > +             fallthrough;
>
> [Critical]
> The same attacker-controlled cid is propagated here as well.  In
> sctp_sf_do_5_2_4_dupcook() asoc is the existing established association.
> With a forged cid of SCTP_CID_INIT_ACK and missing STATE_COOKIE, can a
> single unauthenticated COOKIE-ECHO drive sctp_abort_on_init_err() into
> its out: path and have sctp_stop_t1_and_abort() tear down the established
> asoc and report ECONNREFUSED to the application?
>
> Would constraining the verification to the well-defined INIT case (for
> example, hard-coding SCTP_CID_INIT or rejecting any cid !=3D
> SCTP_CID_INIT before calling sctp_verify_init()/sctp_abort_on_init_err())
> avoid both of these paths?

I will place a check in sctp_unpack_cookie() for such malformed packets:

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index d5ee81934d93..8adac9e0cd66 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1761,6 +1761,8 @@ struct sctp_association *sctp_unpack_cookie(
        bear_cookie =3D &cookie->c;

        ch =3D (struct sctp_chunkhdr *)(bear_cookie + 1);
+       if (ch->type !=3D SCTP_CID_INIT)
+               goto malformed;
        chlen =3D ntohs(ch->length);
        if (chlen < sizeof(struct sctp_init_chunk))
                goto malformed;

Thanks.

