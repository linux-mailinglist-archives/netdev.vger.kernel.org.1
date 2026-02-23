Return-Path: <netdev+bounces-260155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG5fCByenGmyJgQAu9opvQ
	(envelope-from <netdev+bounces-260155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:36:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEDC17B96B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D18203011340
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E8330D38;
	Mon, 23 Feb 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+9utGVv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A0304BDA
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871769; cv=pass; b=Kx3kH1/6uN4alBIR4T6z1SKIq5Ke1O7CxIdQH4tZalNGxRGlgQvQigge+WNT8ETZnDJTj5InPcyPaYfPdRjgnh6bW0YbiLecGYSble6GOJwkpJ7fq4hqptYg+iqNqgVSSloS1z5oRa8m82on2ihi32CwcCTT302ljlsT6ArofS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871769; c=relaxed/simple;
	bh=M7ZJMFfCM8mCPg1W7cxhhkZ7Y20C7LwylvpulbvG1aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzcJUmMKk5aRc0m0pdtTad7gZ7m2bFh2NuN2ncFA6U5AFgdozsJTl5iCpspPMauyqiLHKCj2CVmYyjQsE1jC2cenT449EQ3vHiESRCt/FVicl8wSO9X702n1yD2dg5ERrRFozBP30YhCXjIBaSzsheteyXHzF0F2HjR8CdeEJSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S+9utGVv; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso4510820eec.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:36:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771871767; cv=none;
        d=google.com; s=arc-20240605;
        b=DCFK093HfVaUpI/61nq606tsIqdmjlVFo+68xX8RALHseoYW6S15E+Ltx9ni7QZjR0
         epjKdsiDNsLGYn4ma0BVbXVMaWb1r5cURk7c7rANN28gn5H6WtP/87Z0JytRKvGkEwtf
         lPwaVm2EkNDtu9n5KsouMX1sfcujF7IgzXh2XNr2qQJLADhSzMM7UnZv8o+A9PYuuSyL
         91GyXzlr8g3BszoI+4/U3bD5jiU1rlUccbSVHK0z63WLyQVKIV+wCW2Sc42ID5KwsLsQ
         HyvMm6zxjrERzjOvGBKP23hhOx9drXY7xw953IKeBiNaBXZs1Tv5V006Gtllp8S43zBr
         bsfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QncaDTP2TLLIzblcHYuXIxDw0aZBW8kecnTra9PX5Kc=;
        fh=9WMU3YBzrCWIf+X+JXT7LjUFriElcXRG3ZmayZxWFjA=;
        b=TyzNkiUxrx8Xpo//2ev2MDoNrfT7RInNSAWfaZCAbln5bG+H8UP5DLSz/7nMbBY+28
         4pkrLDQnzzL/qa4kat1spfJfklbwWM+kxHkHgMI2+Fbk3tAE+L255tQB0wUQnPtVyYYA
         LtrhjqTD/MGy0HUc6pd0e8j3L5bbiV1L20ZNAtOYT8eRBBXagVXVsqzpzIN+7Qq9w3hJ
         x5BpKmYXwCm6D8T4aNctDp1DH67s9NfmlUcVusygkQBAyCv5LrPHib2B6zHLCnfBXzWp
         HcI4y9Bxopg5Sq2Uyt4Iaht1mCUjhxSILyy7DpfwRJ1SrgidxLQhJr92Mmo/UMdP1g/y
         SqsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771871767; x=1772476567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QncaDTP2TLLIzblcHYuXIxDw0aZBW8kecnTra9PX5Kc=;
        b=S+9utGVvY8QaEJAB4/sO/7Ro7B5SpTUuGS+p+OiHJD5c1Lp/FYYRBJ1aQ68ZcSoDkb
         zkoAg3sQuZnVIDTPwJFikN0rpLJfP36HOIT6reJGhsQTGejn+NssETLO1j1NVaXZzVw8
         CP0u7WjsWcUUVozJEEgIkunROOcy+Qr4Triq2/zzMIk9C39yjvAA9tjn5o5pzFDF5VS1
         /072h7+ZVoR9grQXFFaaIvJQUPTn67CgHwqFSY88qGSU64F2u00baN3h3oyvuj17Loqm
         ydMz1xuKkK9XnP5iFlQyi5LP8L4EdUkFf6knIHC6RfGrxskYkBAwIgnzepVJqvBdd/zS
         w7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871767; x=1772476567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QncaDTP2TLLIzblcHYuXIxDw0aZBW8kecnTra9PX5Kc=;
        b=Fw3dV6/gkN5brTnqFo5GhmXoQpwBA37cbCNQntsKOj43VY3d3SYEu+IUq4wESqwzrR
         3F886Tr/NISfYOtkzY0LovNhieZWonD+nL7a93P0NZ4EzPrPm2T7NeE5Mm2p9fz8i5zv
         H+uCV0iy5pNh9UOm71BewSMfHGbuYsp4hSdxsXAi6uJx9ScBg3wPg7yw30dpznFQg2ay
         9BxnLuw66F3rNuo0BlpS8Y3kd+hQB5J45yEV2F1eCD8mgmqYr+wUTO7VWwErowXCwv/g
         p+3ltlfllHilvWrtQHD4i3DoRjBrf+ovE00Deb0xqBav3ZSRH99rHJ7Nh2VBzzI0dfEl
         aUDg==
X-Forwarded-Encrypted: i=1; AJvYcCVqayMEQ9w/dX+9LTqgCUnzjBIbdVo0KNOU+20zi1KKp943OjK1UjcpYlmAL+G8p9L/U776LY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMiVCkrwyuZeFOZnXh6W5eZvH1QyM/kkGHfbq0TrLgelQHbQ4
	fgdthCmN3Q714GEtRiytmiGeOdSJrsHKZfw4Fmea920R52UzHpQnvd0SjjJxTUGX0k/Wack5/lm
	XQdY0yaG1yTh8eVGwDiJwe4iE3Y8Z8EoK6qA+89ql
X-Gm-Gg: ATEYQzz81xYZJep545qO11OKQugGnNvQyjEGXjds5CDIohhBSAB+GeRR67eR+GEZVco
	9gIZQFWuJ+zHkGQME2jgDnZ+oN30NE3J6tXSsugNsWC0UVXk6dCuwtr6EeAq4TSSBhKuyytgT4A
	QBDja6R6A9AhRwDAPmYpWpt9hdMkk08ExRLXVBTuQKWtCsXtOm6v0MTzhjhcXcoxEEeebwj/GIx
	5yhPr09whTtYnOKbfeTvX7nakGHapUNtRKYRK4IoqjLEUpIlQ1pti9jjU0aK9+0EdQAJFFK9nVf
	nsAErbWPcS2CxcD/EjK6mEgWnXFTT2smQvZhx8KA7irkkLUJckAQxCzBgSonNbn/fTPaCImYJgN
	AKLXim8o=
X-Received: by 2002:a05:7301:9f0a:b0:2b7:38cf:c2fd with SMTP id
 5a478bee46e88-2bd7bd6f31bmr3090601eec.26.1771871766980; Mon, 23 Feb 2026
 10:36:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222195016.705157-1-kuniyu@google.com> <20260222195016.705157-2-kuniyu@google.com>
 <CANn89i+vRqFU9RL0cbvczxVcK_x8sMVDvr-wDeszPirmaDHYgg@mail.gmail.com>
In-Reply-To: <CANn89i+vRqFU9RL0cbvczxVcK_x8sMVDvr-wDeszPirmaDHYgg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 10:35:55 -0800
X-Gm-Features: AaiRm530kNQv9aTI7Y2AYtuCtPX3ZbOJNOgfZ3CHYFSybMZuBg-9k9UfXcdj4tE
Message-ID: <CAAVpQUC8nnu7JW1Py2x=scm8af5Vt+Z+b4a7gtvLkZRS_nWUwg@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/2] ipmr: Fix mr_mfc.unres.unresolved corruption
 in ipmr_cache_resolve().
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260155-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBEDC17B96B
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:15=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sun, Feb 22, 2026 at 8:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > mr_mfc.unres.unresolved is filled by skb_queue_tail() under
> > spin_lock_bh(&mfc_unres_lock) in ipmr_cache_unresolved().
> >
> > ipmr_cache_resolve() is called from ipmr_mfc_add() after
> > releasing the spinlock, so nothing protects the queue.
> >
> > Let's use skb_dequeue() instead.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/ipmr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > index 131382c388e9..62fe54cf7705 100644
> > --- a/net/ipv4/ipmr.c
> > +++ b/net/ipv4/ipmr.c
> > @@ -1002,7 +1002,7 @@ static void ipmr_cache_resolve(struct net *net, s=
truct mr_table *mrt,
> >         struct nlmsgerr *e;
> >
> >         /* Play the pending entries through our router */
> > -       while ((skb =3D __skb_dequeue(&uc->_c.mfc_un.unres.unresolved))=
) {
> > +       while ((skb =3D skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) =
{
> >                 if (ip_hdr(skb)->version =3D=3D 0) {
> >                         struct nlmsghdr *nlh =3D skb_pull(skb,
> >                                                         sizeof(struct i=
phdr));
> > --
> > 2.53.0.371.g1d285c8824-goog
>
> Are you sure this is needed ?
>
> ipmr_mfc_add()
> ..
>     if (found) {
>       ipmr_cache_resolve(net, mrt, uc, c);
>      ipmr_cache_resolve(net, mrt, uc, c); // This would still be racy
>   }
>
> My understanding of this code is that ipmr_mfc_add() removed uc from
> &mrt->mfc_unres_queue
> under the mfc_unres_lock spinlock protection.

Ah you are right, maybe I missed the list_del() somehow.

Thank you!

