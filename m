Return-Path: <netdev+bounces-304813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FsItAgStSmqPFwEAu9opvQ
	(envelope-from <netdev+bounces-304813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:14:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 582A070AE2C
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 21:14:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VjmgcWQD;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304813-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304813-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049CD3013A9E
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 19:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E647381EB8;
	Sun,  5 Jul 2026 19:13:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E281B369D67
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 19:13:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278798; cv=pass; b=llgV49Mg00naONQpxYy2WHcKcXKSD/FdgKlxvNgH6xABWpVWHz5ehNpRKbXIme15fBvj5hZh2O5DbBhqK/U9Na+X00y64D0IB9mdSnMS/rQMhrt5dx2Zn58Z4EKYoXgkIltQGtgma3zn7LyXApfuKfKZOTbZgnL41yEoOBNwTGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278798; c=relaxed/simple;
	bh=FSJgX2aJq38TJqvi01KAyCAWflKXEkyZJPxt103MZhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HulpRyXSL5XCz4WTKWBVzi62cfo2hNK9ERFNgGz+mioynwV7E8xwnPF2UqQIUjmdqB+SXKmKaEP/wtbtXz3+IAqtPVEv/xY89i9jC2wcpEGKJmfpJeKvNZiPNv9V/RZssNPeMg+b0o2S6FdWbv3yh5B6OZSFPm5uF75XEtA8O/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjmgcWQD; arc=pass smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8479f1a86ecso1381683b3a.1
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 12:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783278796; cv=none;
        d=google.com; s=arc-20260327;
        b=T5cKUCl+Pi+faDCqZIU70hDooDdXicWOOOu66fHLYtIzIgbpeouuF3m9byJbuLNstK
         2Uu6LZfPqxqg6w2JOp/ErkRy5fg5NZrE4YRsqPCwUBFBB2z7LcL4GT0//AymxBw8hfXC
         ylGRArAuT2/HRYg0XK/Q+erHfCun4p3KxLos3E4DTzA0hu4uTIleWnac9UTEQVGF+izq
         VCx3ADjDFSRVCMUXRSIn7B4Z7f78X+/xVaSEdJT+Wo5msCl3bLZBVl7x8HlGkrgKMBZN
         pK3M+ZeY5ySDw15Q3WdWoBQEerkzH5vHRSgGADpdg8NDR3hdtR7pWTQNITUu/WCA53IJ
         1oAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQ9CpAFvWWrF141vt/3zJnBZKZaAv9ntmcauJ7Q288Y=;
        fh=Nhevv084E/r3t24sBGxWWH4duP/zhNiqQhyJUK+dQwc=;
        b=F0QCqU9wKLyr7qPAKNnTwz3/liqT71uyVQcfoEaDTwNOWExx4UHcHvGLFSThO11e69
         D9IpGncPZ3PPFLWawtCHBxu45GX7PlrBq8cqOr6aFC3zpQORzBCh+K4KPSTNK0yxUMjj
         KoUppp7O4po5SW0NAR+c+j+KKJ0jAkpgqWIDHYXirEuTKw/0eb+/IJIc67z47KNtktjC
         UrS0bcT0bDsLUaXXcYiEJlY7ywlswlNViUeBKLp4/RpZ7h+DaRhlMhVU3AcuZ45J8odj
         yBv2x5pHZUL3PfClfSOjsvMJWuOlkoWqTR3iSQFdbjDv0ZnEB7TobUzKC0Wzch+kpw7i
         3URg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278796; x=1783883596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ9CpAFvWWrF141vt/3zJnBZKZaAv9ntmcauJ7Q288Y=;
        b=VjmgcWQDKJccj00sMqosFkl0FIniSEhMby3zQTA5tkVVbLdSZI0hoA8OsBs16d9x56
         uvHo8z1xaTEp8sV02sUtq3XEOxp2XMCOcG/0Cn6nDk7hjtTBgqWHEyAXK7RuuA99Adst
         Q6psl0zMHnjwVNKDoDDbtZ2nvY9Pf74u+9QkucXgKUEniormolplgd1u2px+oDz/g/L8
         FCTiem0NhyhL2CZZrc0zsFZRykSvn+SNrRk0VWRq3+0RrWyfPQv4MgpbSg8qVpim3GGt
         xLx9lCMgnfKQdduNKkJOrTZCEg7ckgvlDJdoEZhskN+BOCFMJAMMjM4fZbNuKl6QA2X3
         C+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278796; x=1783883596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQ9CpAFvWWrF141vt/3zJnBZKZaAv9ntmcauJ7Q288Y=;
        b=AhwfR9h39LU08YUL5NYsKX7kCIFCr3/JpQNIQDPtz+CkkVMs9Yv/pU7hneh8hLUU72
         lhqnMYVYia6//f3wFdE9+DIDEUlUUB974H8421SurFaDorBZt7Tr2CJoz1Qbl2SCjlgJ
         b82W8fEBRckPSVfUDqe+5EJ0O0GBLeBaKt5ldv2ZrkKFW28rSmQ1SsCQ2qiAiWf5RJVj
         tkrU/rF+AeKKuNSZ46UIcnKHP0MA8kouYzCStgyF6X2kf15HztRPAjqLETPFfbbXCzZX
         fJ9kADNn+K9p7W1GCYM9cfP/Fsr6LvzGNyQNmI0P3OoKigl+VnsTYjHgcmRqvfVxChvh
         07Tw==
X-Forwarded-Encrypted: i=1; AHgh+RqjfLByX71mf6EkNAFKpM5mMOoO1ECRd4lKaoUEZ+0b6dFxxjvEsc6AOruFBm5U4QbS2skogOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVgj7EwzgqMzPOM3IC2kimD3FIZCE+5Jvs+bqmmWFVtfjkBGy
	VndXyOvLzftd2aljHhQbDsGbawSd+kWxC1VJudPrhAJxVQDron1RA0ehGxF8e7ze3/WpYtRIbYP
	J/Qm/l1XGkksQKB3RHnJpH4xppckzkshC/oYR
X-Gm-Gg: AfdE7cllQcIgjt+1TmDpN4e5rsnjk7huNCiDos+GLLeYYiaYw/fUogTdoFVymM4IUn4
	unHPNaBbAOOD2Arpb6XA1B2ploT2vpluIeusy85/FUavVAkYW8zRuWBs5oUYd4zbWHvB7oghN2s
	/wOl0B8K8Q+lqC73Y7QCV7zoyXwTIPW/Tttenc1r20olacqEyz8t902fAz9/GW/VedPnEtN1RKA
	tvaKF1Max7wtyuHtGhK9hiL6qJKv6vW/aNR1pM8ThmX0js/zV1D5zlw2Z5WEXzqRdMy//jf2q0L
	8MDdyR6h6oSiI0K52nT1jeqvyIV8ky0areuTUcgbp+ff5ds2U516JBsHLU/40BXRjwFUFr37G6M
	sH0scV/nc
X-Received: by 2002:a05:6a00:440c:b0:846:d484:945a with SMTP id
 d2e1a72fcca58-847f6f737c0mr6874374b3a.53.1783278796335; Sun, 05 Jul 2026
 12:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705003013.1134430-1-xmei5@asu.edu>
In-Reply-To: <20260705003013.1134430-1-xmei5@asu.edu>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 5 Jul 2026 15:13:04 -0400
X-Gm-Features: AVVi8Cfte7ya4M0inTOXBNlj7tfEYuc9tp7a8uuizOHEqaE06iX2_70pA9HTj90
Message-ID: <CADvbK_cWUT2ygfBSW6qjgx9_y=bvksqG87Lp8edQcFT+3p9fOA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate the body of a STALE_COOKIE error
 before reading it
To: Xiang Mei <xmei5@asu.edu>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304813-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 582A070AE2C

On Sat, Jul 4, 2026 at 8:31=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> sctp_sf_do_5_2_6_stale() reads the 32-bit Measure of Staleness that
> follows the error header:
>
>         stale =3D ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));
>
> without checking that the STALE_COOKIE cause actually carries that
> 4-byte body. sctp_walk_errors() in the caller only requires
> err->length >=3D sizeof(struct sctp_errhdr), so a peer can send an 8-byte
> ERROR chunk whose sole STALE_COOKIE cause has length =3D=3D 4 and no body=
.
> It passes sctp_chunk_length_valid() (>=3D 8) and the error walk, yet the
> staleness read reaches past the validated cause.
>
> When that is the only chunk in the packet the cause ends exactly at
> skb_tail (sctp_inq_pop() discards only when chunk_end > skb_tail), so
> the read stays in-bounds of the skb head slab object but past the packet
> data. The value is folded into the COOKIE_PRESERVATIVE parameter of the
> retransmitted INIT and reflected to the peer, leaking adjacent kernel
> slab bytes.
>
> Discard the chunk when the staleness field falls outside the validated
> chunk data.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/sctp/sm_statefuns.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index d23d935e128e..e4b4b63162cf 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -2592,6 +2592,9 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale=
(
>
>         err =3D (struct sctp_errhdr *)(chunk->skb->data);
>
> +       if ((u8 *)err + sizeof(*err) + sizeof(__be32) > chunk->chunk_end)
> +               return sctp_sf_pdiscard(net, ep, asoc, type, arg, command=
s);
> +
>         /* When calculating the time extension, an implementation
>          * SHOULD use the RTT information measured based on the
>          * previous COOKIE ECHO / ERROR exchange, and should add no
> --
> 2.43.0
>

I think this is a dup of
https://lore.kernel.org/netdev/20260704033545.2438373-2-bestswngs@gmail.com=
/.

Thanks.

