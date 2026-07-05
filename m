Return-Path: <netdev+bounces-304818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D2YzC+XaSmrZIgEAu9opvQ
	(envelope-from <netdev+bounces-304818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 00:29:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74870BA5C
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 00:29:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=ASQSsxUH;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304818-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304818-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89135300F54E
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 22:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA44372EC5;
	Sun,  5 Jul 2026 22:29:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E9371072
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 22:29:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290593; cv=pass; b=hzUmJyOmTb4Csfh/xMdCXIK9NTCa7GndO43ITu2fsRLPwTLogQggDCpCCfHxshIBG0MnFTrH5izi3OIzg9x61zXGoaFr8jtO4y9LhdVi0aAhumoLABTMeP9oyM5zPJHumPZevYF9mdFikRXdijRhzITO5l5k31R0szetJq23XMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290593; c=relaxed/simple;
	bh=82GO7hu8F510MGdXPvAoDzFO8wfMHHHBy7DdIo/Opy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpsyKwqWT4swHQWoNzY/XhE1M1rclR2a/A7yLkVq3QOF/+KmQeqtmeQ3Ao5as/Szrave9D27tj7AKMA9S7XycHl2k/JpaYs5WOGs4U30iNCbobf/9856br5B5vhekaxkdJd77ZpwJ5IyHmbFvRYwbpKZEaJxD4RCWeuUOY14mAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ASQSsxUH; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-845ea8924a2so2263028b3a.1
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 15:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783290591; cv=none;
        d=google.com; s=arc-20260327;
        b=acaRHpEqtJaatkIA/iXiivSWQVF+Bj+0ncX0d9RkbsBbjCRTk/AP7iwuoUmDppsLuz
         NHe5+uQNeoTwOVhffNTYRmD2+baeK8wNkpLlzVnEnO2a5cAfutC05ti/2ZO0eQwxTT0T
         pv3rl10thum+CO1t7ySz2w1h4CJWf5qbDswIEHcsheCP1u70NxSQ0scp90FumZkXVWBN
         Ba15JaBaQPixcd/sbH/9GGDza5Kz/vAUymPRCRDDfLR218MBcZmXN8YOpREC2FD5cDKl
         tSNgnE+B+WfheX0TWYM693L/EBPMKxO0Uo9b9vkXLGL5GNrcLVwhZoPwv5YkT9AuGRug
         ma1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UA8iUQiEy+NI5b2MnDL6j/liL6MwMgPKJZvHOO3c8b8=;
        fh=ZC8OgoTX8QWxC8VhdrC2XVJrJWez/BAtZXiAFnP606o=;
        b=JjbCw5MnN+mU5raROUnsyLXoU1YtmjladxW/AwnhuNizGoMEIuc8V9798G9/yvEVty
         IzLzLBABvrZy9YNYs8PnbDEovKDsX9BA/n//Zclvf71Odd+iELkV5xNArO/jIeMOePhJ
         o9ap4za9drpnKQTNVOe00TL9sd7MU/Uo7GBnRpQFzvj3wMJFp4BCbw+r7SFCcLjRZKmp
         VO0w7TsjtNJQaTju8avRHz5wkrm5t/1EK/y87kSSoBu3LDV/hrvOpmTf14+gaKEKj60U
         DhPj+t9uDSnH1/9uibosuKQSf9VfREFOo0jx7hBsun8y5BdtC21+rCHUezHTqOcC5YLL
         RzFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783290591; x=1783895391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA8iUQiEy+NI5b2MnDL6j/liL6MwMgPKJZvHOO3c8b8=;
        b=ASQSsxUH6SMnL9CFK99v3bJ93zZdpRXu88KSb93o6ce/cbCT+vSFGgck3j3SiPCXg/
         IcxHQE2Hj4wB+0skXuwkv/eQJ9smzbKhsL2LY75TRKzoxUqEmz+fVI3fI61HbgoQBBXK
         KU8K0n2AUtvLgxcVx/MziiBOJ2jPYD/a+sl3pV6X/xjjh5BOrrLXjDunPbVWA1pqCVJm
         HGygxrfANEmM5gXXFNZR0gwm86TBukDr0zedOrt2G09E6KAbNQHCLi2D58sxrwnlrDN8
         KWSk44vC/A81EH8mFJGUp3E6gs8lDuu0kDd6xHlgcJl/lbZM0p/W7s/3Z05KKOv5eTzU
         Lgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783290591; x=1783895391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UA8iUQiEy+NI5b2MnDL6j/liL6MwMgPKJZvHOO3c8b8=;
        b=JFHTtIJ3DSdqCwM27qtJxYmNN19DxnkTV9AbN5YPKtKZEkugz0ezKTxXa9KzhAKfNf
         j2QDA3RyUomaN1/P5h78u9uzHG51y6M64BFdyfgTNwR5uWP6zM2nNdGtSjiNb5HKNptO
         QDYqeORcVZVtcinV3bZ6yQ8U7HyDBuw/DzjXeTVUtA+nUjUSMm0CtZ4seK+Quw6H0vMj
         PCcpdqUZeMAt3xjPyxsLCTY96eztrcCH8uTGVGA5U3mEFJxZCgZp3phfHBI4b6Sk6n+n
         Hk4XqxEWwpwy1pWauShlO2W5w+RXVUhCnvw33NP3NYUWb98BUyoAUDL1HzN3L+lgTq77
         LDkQ==
X-Forwarded-Encrypted: i=1; AHgh+RoKjivh1BBeQPV1ptt/ePWQCJCwhBZe3Z6x/72mqqh3U47wPYlE2cieOZ/vTf8wqdgIxj+4nZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqdnY99lRkDT/gsJ5mm0KEQPhaTmFdC4KDnZAmSZG5typVhjh
	5BT4DgZWiPfGl4OxFxmzhjeZAj6zWedko8sgoDM2KER9+I+CrHuFisZtWnHzqPqvMLa4QQcHt1L
	WZq0MHaNY8mXFznc2QKDyCVP25U4bXr9L5vw3Ken3
X-Gm-Gg: AfdE7ckVXL4Wp+jmrcZcACT6l3mlTk2v8dmYWgmnC/x68lO+ReF0I6zo5YlAkjExN6Z
	3zuuLonG980yLQ9+6ckqQ8xLdXHpHsUk1ZG9eVgasRij68iTsPJX06KTgxIgEVm895eTl9keEQy
	1JErlMzFnURBoR22eb7hJvTHPj8qwSoQIN4akG4AJPqeFP++7+hRC7k5zbEpbxw9SypJzlH0Nmi
	4ZNXCcvhTMb9sR51Wbk2+I0xPyNDsxrUFBxXF2mMM1mB7CaPfgbgDmaz7wcQVYb4ZYJWbEzMruA
	oJxqlilRutU+FJ+K6yh5G6Sm2g==
X-Received: by 2002:a05:6a00:9a7:b0:847:973b:3cfa with SMTP id
 d2e1a72fcca58-847f6da5baamr6872701b3a.15.1783290591595; Sun, 05 Jul 2026
 15:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705003013.1134430-1-xmei5@asu.edu> <CADvbK_cWUT2ygfBSW6qjgx9_y=bvksqG87Lp8edQcFT+3p9fOA@mail.gmail.com>
In-Reply-To: <CADvbK_cWUT2ygfBSW6qjgx9_y=bvksqG87Lp8edQcFT+3p9fOA@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 5 Jul 2026 15:29:40 -0700
X-Gm-Features: AVVi8Cc5H56GXXzsX9a9BdNE0H538_9lKNQJmhfjK2mq9-dPouAlLRRy1ehet_8
Message-ID: <CAPpSM+SaxP+HOA1aRBdHCTFFN-2q8oPhmN59J-VPV2F5NwJyAA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate the body of a STALE_COOKIE error
 before reading it
To: Xin Long <lucien.xin@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304818-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,asu.edu:from_mime,asu.edu:email,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E74870BA5C

Thanks for the reminder. I didn't notice that Weiming has patched it.
Sorry about that.

Xiang

On Sun, Jul 5, 2026 at 12:13=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Sat, Jul 4, 2026 at 8:31=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > sctp_sf_do_5_2_6_stale() reads the 32-bit Measure of Staleness that
> > follows the error header:
> >
> >         stale =3D ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));
> >
> > without checking that the STALE_COOKIE cause actually carries that
> > 4-byte body. sctp_walk_errors() in the caller only requires
> > err->length >=3D sizeof(struct sctp_errhdr), so a peer can send an 8-by=
te
> > ERROR chunk whose sole STALE_COOKIE cause has length =3D=3D 4 and no bo=
dy.
> > It passes sctp_chunk_length_valid() (>=3D 8) and the error walk, yet th=
e
> > staleness read reaches past the validated cause.
> >
> > When that is the only chunk in the packet the cause ends exactly at
> > skb_tail (sctp_inq_pop() discards only when chunk_end > skb_tail), so
> > the read stays in-bounds of the skb head slab object but past the packe=
t
> > data. The value is folded into the COOKIE_PRESERVATIVE parameter of the
> > retransmitted INIT and reflected to the peer, leaking adjacent kernel
> > slab bytes.
> >
> > Discard the chunk when the staleness field falls outside the validated
> > chunk data.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/sctp/sm_statefuns.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> > index d23d935e128e..e4b4b63162cf 100644
> > --- a/net/sctp/sm_statefuns.c
> > +++ b/net/sctp/sm_statefuns.c
> > @@ -2592,6 +2592,9 @@ static enum sctp_disposition sctp_sf_do_5_2_6_sta=
le(
> >
> >         err =3D (struct sctp_errhdr *)(chunk->skb->data);
> >
> > +       if ((u8 *)err + sizeof(*err) + sizeof(__be32) > chunk->chunk_en=
d)
> > +               return sctp_sf_pdiscard(net, ep, asoc, type, arg, comma=
nds);
> > +
> >         /* When calculating the time extension, an implementation
> >          * SHOULD use the RTT information measured based on the
> >          * previous COOKIE ECHO / ERROR exchange, and should add no
> > --
> > 2.43.0
> >
>
> I think this is a dup of
> https://lore.kernel.org/netdev/20260704033545.2438373-2-bestswngs@gmail.c=
om/.
>
> Thanks.

