Return-Path: <netdev+bounces-297902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z6V9KdghKmp6jAMAu9opvQ
	(envelope-from <netdev+bounces-297902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:47:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDEB66DE04
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:47:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=Vvj2oR1X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297902-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297902-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 125FB30237CA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 02:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD82641FC;
	Thu, 11 Jun 2026 02:47:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE89C30FC12
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:47:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781146060; cv=pass; b=CNUmcpvhK8f0Zr6/wGy9LOMH/MKP1szeF0TErT5t5C8l18qR/XYBbw3UqT8YBMTkbAwDtyU2jK7THMH9/slLWF83DZSTaVZboGm1Q6YqyfQkY7BPdpmzOCWIufCraHtWLEq0nUWVBlCkcj19xVzJLFFygs0UCwjzTiGYneMHFKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781146060; c=relaxed/simple;
	bh=x6vh5tb3L8+S6QgCDQ5aHCu0jbDOOsbdS+QIL1xS5UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHgwaN0g1oFk9gVe1MzQkRZJfJ5zNdWwk4sy44w5cdKpKbbPAojD1Ueyq6gQEcobIEMN7zuwIk3adjOwvdtX6+kfdi3dnB5CjD+i+e5Xw1tHvCoqoeXOODdyRIanhZX/plTgxOzWdBr+5N6FZ32YQ4bMFA7ofrrXrYKYn5VCKI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Vvj2oR1X; arc=pass smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c858b5de728so4758475a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 19:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781146059; cv=none;
        d=google.com; s=arc-20240605;
        b=aw2xD00ya8Zn4NbIAYp0BNFCK9kKrM0GBzv/vjktj0HzBPbgwUs6hYOTOc7WgAqawY
         kL4CDrYsx1sXbjnhWDFsjI/N9fSm75YKfXrMcv2kEu+yhiK6pnLurMKl1FSCi+FjwRLh
         geUDNO7yZERPYk0neN7zySbIV1gxj+PnYLzNlJ4Uwbukk+JDeOm41r6HBDGX37kEg7Hb
         d5VtuNdxJTMEzzS427V58XDv6YaqYYCv3HMK6yq7HLwKoscPPtqE5OkvY0STnPETLflY
         b2MHLFYJCe8OQZqFOOyOCywo2AbzRvYujyUvzHt3vYxYIzG7xV8nHpUq7B1Nr52HWYGa
         Mf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsPqAjNDSq55+C7fcw+ysUSml38tK5lHovl+6aPb6Gc=;
        fh=RYM6EB4raZunfZcuejMlNp5Lg+0m3l/XnKFSgK5aUEg=;
        b=b3zdDk0+yjdE8FYGqLl+Ee5WDzhy3OnLnMbrAvx+hmUYph5xIafBe1PiwHy8Qr97HB
         oaf6x2KJ6ruKpldFJcF938IuHJgZi6ZRQERyI8QEKirJaown9pi8kIpnLkjM2RnfCmsO
         STIa5gZBTQOQy0sUvWMNp80viym/7LBBN5pTiVH+9nYWs4ZINrPTLg3qmtaRc8T12VW6
         SnIy6VH5I2yzsOrSbvpaYVti8wnUlfLYr7cvm3Q7/iMSMWDwutu4CpmW0vKFciy5vzzk
         8m/WM4/k1eJDUxDshMWfY9Vqd8kWrg1UGk1+Z3Bj9pTjoeXZUDXGoKLiiPZr+EQd22xi
         HpMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781146059; x=1781750859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsPqAjNDSq55+C7fcw+ysUSml38tK5lHovl+6aPb6Gc=;
        b=Vvj2oR1X/fv/bFnNHRG/gjZ28SFk1+SHfg7AquORaCbKXUjvr/DXG6FeVZAoVyWmlt
         dhpE0xwcmgJIibNMiZpFiogxYknFbCU7LhyG5RxmlZAjtINZAvpEC8u9vCr1v729Cmi9
         tfImvts8Y7cMk6JZZtcprRqiTkVn8JyMhZntRAXi4W0ADvhHE1UKdD4DkVq/VvqvVO8c
         w36kALMlDj0ni80Mkq3GxQyPO8Hej9pNkpg9L5kz24b4zo1V545667QeljW+Mn0VR9Vl
         PU3YlgkkQ/y87XuqAakQTeGmYWtBDK0jy1VYg5MQfjWCKX6Fh7I7vGZ7EWvlFHfz3HPp
         zTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781146059; x=1781750859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TsPqAjNDSq55+C7fcw+ysUSml38tK5lHovl+6aPb6Gc=;
        b=ogkrJXEscIv/3LB2FBkEfiRJaXt4ECGAcaFq32+qnrp/BrmJ8lNTGW4vC1Qpd0glYE
         sfDNVabF8q42WzMepDZLi6YJx0gMti03q+79XKEltPletpgGKn+tagwmIGeP+vGnapbZ
         VedOyLpxj8PvvT5pwjq/2410vRgLrhWsrvHHSL1fbZHlhsaO58ZdrDtN/+FWLKKm1Amr
         1shmFt0B3atxhQdihPHV1pOrTyqIvnRJJmPU7lb+NIHnkKc/Z3Wq9ee8Qg7lBHdsf0mf
         vCHBy/OoaxAmBJSPv89IZY6SZP02cPevlsBYtXv7suu9thxhoYiMIrH740+F2jdaPFR8
         aVWA==
X-Forwarded-Encrypted: i=1; AFNElJ+keHbh8xW1sl5/A3DiszYAavBufl7yzaeiqfiWd4NTdPkcpW8F5EgEABcFq7EBwMY/M9lnzWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKG4Gepq9Io/145HXuHT4Gy+feRuHp3Dbk1MYP0olK8lZao+uY
	4AvfLap8G9Cf4rtFlRSEJ49NIyM0gnmtCWGTLVtR6QDsCseuFWTriQ1rvWY8ugmip437UnqcTWT
	vSDxOeZM773HxIbTeQ/4gU/ZC632J9+A5T9J40Uz7
X-Gm-Gg: Acq92OGwYiYw1awQqhW/YJ9bh/zFHVD/bv4tGtgam0BVPCZ5YcwTYW9MQ6WhaBjdQx/
	wcXoHhiQ5xyIB0OTZU3iYHcmIJMXonbnoxfigX7JDrvQOsGMZsnts9Dep+DGHOy2hOuiW0uL5go
	I1NUi0H79+aHVQ64iwRmsoV2r7/Y2fZ8xeqVaf9pXWdFv4wPPYBMyegMcam45QR+TueMsPEyJa9
	RgfRYG9m/2mtoY/faCRJRC5ZdT9dvMhlsLeMOotxG/NgARFnQbOy5pd2U86ThngKsVae1WcSq+A
	Z05BOY1vqGwiiQUxTg==
X-Received: by 2002:a05:6a20:430d:b0:3b4:b30e:1b4d with SMTP id
 adf61e73a8af0-3b5e3339f82mr745556637.40.1781146059061; Wed, 10 Jun 2026
 19:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610232936.1176094-1-xmei5@asu.edu> <20260610232936.1176094-2-xmei5@asu.edu>
 <1781144329.8069873-2-xuanzhuo@linux.alibaba.com> <CAPpSM+RApuYf3-ui15E+01fWEzUzfh6mgijQyT_+KjusMVxMfw@mail.gmail.com>
 <1781145615.903036-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1781145615.903036-3-xuanzhuo@linux.alibaba.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 10 Jun 2026 19:47:28 -0700
X-Gm-Features: AVVi8Cf5s6nvnKDkPBneLlYXv6u8D4i4SZ3qTpyjInY3qYwcuAbdGVZNvWt0g14
Message-ID: <CAPpSM+Ra96knTzOHO0pFdOtvpOK=Nfh4Xx8TvRExwohuYTqn6A@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet
 frag loop
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com, mst@redhat.com, 
	jasowang@redhat.com, eperezma@redhat.com
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
	TAGGED_FROM(0.00)[bounces-297902-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xuanzhuo@linux.alibaba.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DDEB66DE04

On Wed, Jun 10, 2026 at 7:41=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 10 Jun 2026 19:24:03 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > Thanks for the review. I agree with that as I replied at the end of
> > v1. If we obsolete 2/2 but keep 1/2, is it okay to just leave it as
> > is?
>
> You should post a new version.
>
Thanks for the tips! V3 has been sent out.

Xiang
> Thanks.
>
> >
> > Xiang
> >
> > On Wed, Jun 10, 2026 at 7:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 10 Jun 2026 16:29:36 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> > > > This is a robustness hardening patch. The slow-path frag loop in
> > > > page_to_skb() walks the page chain via page->private until the
> > > > device-reported len is consumed, implicitly trusting that len fits =
the
> > > > chain. It does not stop when the chain is exhausted (page becomes N=
ULL
> > > > at the tail), nor when nr_frags reaches the end of the static
> > > > skb_shinfo()->frags[MAX_SKB_FRAGS] array.
> > > >
> > > > Both bounds are needed: the chain length is big_packets_num_skbfrag=
s + 1
> > > > pages, which for an MTU-driven configuration can be well below
> > > > MAX_SKB_FRAGS, so neither guard implies the other.
> > > >
> > > > Make the loop self-defending so it no longer relies on the caller h=
aving
> > > > validated len: stop once the chain is exhausted, and never index pa=
st
> > > > MAX_SKB_FRAGS. No functional change for well-formed input.
> > >
> > > At this point, we are assuming that len represents the correct packet=
 length. If
> > > there is a bug in the validation, it can be fixed, just like in your =
previous
> > > patch. Indeed, not checking nr_frags is also based on the overall des=
ign.
> > > However, I do not recommend adding this kind of enhancement. If we fo=
llow
> > > this logic, we would end up adding similar code in many other places,=
 which
> > > doesn't make much sense.
> > >
> > > Thanks.
> > >
> > > >
> > > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > > ---
> > > > v2: robustness patch
> > > >
> > > >  drivers/net/virtio_net.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index afe73eda1491..518c22fa1b68 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virt=
net_info *vi,
> > > >       }
> > > >
> > > >       BUG_ON(offset >=3D PAGE_SIZE);
> > > > -     while (len) {
> > > > +     while (len && page) {
> > > >               unsigned int frag_size =3D min((unsigned)PAGE_SIZE - =
offset, len);
> > > > +
> > > > +             if (unlikely(skb_shinfo(skb)->nr_frags >=3D MAX_SKB_F=
RAGS))
> > > > +                     break;
> > > >               skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,=
 offset,
> > > >                               frag_size, truesize);
> > > >               len -=3D frag_size;
> > > > --
> > > > 2.43.0
> > > >

