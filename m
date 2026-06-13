Return-Path: <netdev+bounces-299037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UDzcNle6LWqVjAQAu9opvQ
	(envelope-from <netdev+bounces-299037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:15:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3576C67F9CB
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:15:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=XcsMEE22;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299037-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299037-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51F7F3020D73
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B551334DB46;
	Sat, 13 Jun 2026 20:15:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6635B644
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:15:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381715; cv=pass; b=joMYTP5QECoXCt+fenK6SoNbfOULBwczQDXyOZx0LfOCtatCoVcs+hVKHeve7Dp5owXlyre2e3ydk5bipdIi9NS9abZMZjJhJhzpOIky26cvX4Z76jzc/P/cTMEp2spNX52uZnfGSOBmTGK+ljQQ0HbZsTjizaDc+aYP690D+NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381715; c=relaxed/simple;
	bh=ePGH4CGDlZXPrmEQA5xZMF3lKEmANEf+sW/SF7aVJ1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqKZmrdj++e6ZeV4+hbbOf0qGuZKC7C7n0CG8kV0t1dBSyCookQUl+PIlEujseH9LDEBEiIR2+KxaBUMbv0gm/P2QEQWVdUo5aeuTDoYsyvy+stYdiDh/eHrA9UTzUdieUdiSLAAvlHXr/epdNbfHapUDnYfbn6wsjOPsXBegVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=XcsMEE22; arc=pass smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36d8b644473so1837454a91.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 13:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781381713; cv=none;
        d=google.com; s=arc-20240605;
        b=FxWdJ8Kou4jmZtI6X41AqEQo1gV09BI9igvkltRB5zk5tWzvsM60id7ik+MDBHjYjt
         i+Z6iFwRjm/a5KOvMWaUADAXcQjmrMWRK016t/PKNN9MMEwAaDMExdf68NE3cmEV+vo8
         GTMpwdrZmpeaiXl2IJ/KJl0rvmKFByP9TjCY5c2vPuliFo0ZsT4sIntUPNj39rRmb+jT
         7nDQSe0Z/BlP2lTUHxhCWrGKk3kQbk1F8KbsNVFhZv/IeRtFFERYH4CAr7dEQM4ZsNeX
         fBT+ifgALM658vJeeCtizsQkssH3GsnxvGxYAa2azh9Lp0FEdj8t08o0GWgow7ty0fa+
         WqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CBkdmPdZBk73lVMnTi8CPgubS9GT5yZjHd5e2IMjwN0=;
        fh=gYPdKvazbDIQcrUQBjhb6MF9ZRD1/o+aBxPUe8nVTtQ=;
        b=Jj0XiJ0kSl3plRpUV+gCL0Re+RKe+x34iuPhIL8i/8ZnaVQ9wfRKLpDpzVoLAKAB+h
         lFP08HorvOf2UlOQLJycVUY9DGSqHzaJLetRn9GbIIs3I4u0MN7WZ0k52ZbdIlaCG5vx
         wTnl761h4YqcC2wcO/GgO/EZjPDcnzYXbNX5vq7JIp4/cGS30CLHGWXwCC9oynO7xZa7
         QAd+7RTcAg5FGi7E76QEI0Ah5czOUhV1PlQIna8BtekSiM25VOB7h1FM9kZ/MdRmeiBp
         9ykeUkTOQQlszVd4yJYUjRxeepu3mXS844ENvXMEQvyiiPC089Fe1yVsgZfsVqaPwyUf
         v7BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781381713; x=1781986513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBkdmPdZBk73lVMnTi8CPgubS9GT5yZjHd5e2IMjwN0=;
        b=XcsMEE22BkPi1KcyswyHMF2dvYnCpM0EvlXnaC6zo7eo2ipLxqFUfU335PugQBXLtt
         jLWe05U6d+vGwLb/qDA1t04nSyGodKLIROskXZ5BaQwppC05id9K2elP/VR722bBGrEv
         0bCX2ydn2mB/tA8BKj8wkIdwVg0aTa1wkZdaLCHXE7Y6UtpPRnk0Hc9/LkqhxIUmzWnT
         3G7oAHLCYRy9johvDCUqcExpOfUAxV0Mi57ssZEm0CO8Ns5bvjxiso3QS5rMLuOYEPvx
         sfu284TByI1mKA5FleKV2hDfl/qh3tb7HSxZLgbtXlk9KToG9xjCtEK1qyE+r57b9AVG
         UTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781381713; x=1781986513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBkdmPdZBk73lVMnTi8CPgubS9GT5yZjHd5e2IMjwN0=;
        b=l9WfZSggpb1Yur5WmaVwNZ4Gg36HMhNQoDSEggX85IKXVdfTl/VGyDJzmTKxLS1nn2
         EXISnXLZ7UMmnipldtcJ+TAx79lvaogY8zAafZ/A/SBbXeLVABYpkNl8yaWuOvbz/lDp
         sP3y7Ob+miFCtVOTLXGygMFHZDtT/Y7nk1O9fKto8G7FgJYPzZHraWAzIz6ytEoRHID2
         aiLys3bJoLAobjtuu1XwQjL7DYVKKPOG8pyujUSfoy32HfiBkSRgz9JdarBWVDShSscN
         Y0lMk8uI4wwDpqAwMvxLN8g4f1ohcuZYRQKxtynbpd4B5Z807y26yy2TO5+tnpNWYzAV
         W2fw==
X-Forwarded-Encrypted: i=1; AFNElJ8E7OgpNZ74ffYBB0uh4SZx5Y+BNyZGbqOLC7/7IOB3oa4wi0X+53ho4A9rKqipcedkUfuP68o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsT3vGqtegACl7dgwW37OmuSQy8DmkdPmYUmWxvftzlVPOGZXS
	d43/u/mp3VnL1TXpogUTyBFiIU8hHw1+ADw9dECs6uLZFydXxZdFso5TcS4LVJIg/QZq/PqBoT8
	mV/gFzUXGEoV1MqH+zZuYyzhmKYSel9Pl2NeuJF9n
X-Gm-Gg: Acq92OEBYMnrIu3RKubwZNSW07UjHNU4TG3gjZxdd5YgJm99h4F5nODO6yMJrqvS3mZ
	6ObbAfbHV7Obi5BbgsRb+HL6uXBSMuIOuNwuxsyLR9I+IwvMj+c/Bi21cuSKvvbSNVchqGCjLLm
	aPfiBS8yEQawlBlUMqWKqFlr6FIwrcWnOObsSqXPl0aGamaXf4ZtCTQeXetkFi7bhyP7XkPo91i
	zQKuv1bpmsPtAuWZr1E2EYM3yANuf8ox1BF6ejnBcKh4c+/SH8NmKXdo7FZxL5BFipd1gz8iVVV
	JN0EjV929OK3gfySdS+/gZXf7a5NuPcyCYuLmHI=
X-Received: by 2002:a17:90b:5102:b0:36d:df4f:ab2 with SMTP id
 98e67ed59e1d1-37a036ea6c5mr8876392a91.13.1781381713644; Sat, 13 Jun 2026
 13:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611024616.1408317-1-xmei5@asu.edu> <20260611014519-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260611014519-mutt-send-email-mst@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 13 Jun 2026 13:15:02 -0700
X-Gm-Features: AVVi8CcSRgUFlk_J8E0QCNoWVZMQzkut3tYo8Tc6XpdRmW9vbeCZhKv27M80tXA
Message-ID: <CAPpSM+Q=NM0WeBmZvyOEkyx73VU10AOHQjPbWDSet675B7AnCA@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: fix len check in receive_big()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-299037-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:email,asu.edu:from_mime,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3576C67F9CB

On Wed, Jun 10, 2026 at 10:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Jun 10, 2026 at 07:46:16PM -0700, Xiang Mei wrote:
> > receive_big() bounds the device-announced length by
> > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> > add_recvbuf_big() sets sg[1] to start at offset
> > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> > check allows for the common hdr_len =3D=3D 12 case.
> >
> > A malicious virtio backend can announce a len in that gap.  page_to_skb=
()
> > then walks one frag past the page chain, storing a NULL page->private
> > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> > write past the static frag array and a NULL frag handed up the rx path.
> >
> > Bound len by the size add_recvbuf_big() actually advertised.
> >
> > Fixes: 0c716703965f ("virtio-net: fix received length check in big pack=
ets")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Thanks for the patch! Something small to improve:
>
> > ---
> > v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
> >
> >  drivers/net/virtio_net.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..afe73eda1491 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_d=
evice *dev,
> >                                  struct virtnet_rq_stats *stats)
> >  {
> >       struct page *page =3D buf;
> > +     unsigned long max_len;
>
> Assignment can happen here?
>
> >       struct sk_buff *skb;
> >
> >       /* Make sure that len does not exceed the size allocated in
> >        * add_recvbuf_big.
> >        */
> > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
> > +     max_len =3D vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_=
hdr)) +
> > +               vi->big_packets_num_skbfrags * PAGE_SIZE;
>
> Took me a while to figure out what is going on, but I finally
> understand:
>
>
> Reducing
> (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE
>
> (what we allocated)
>
> by sizeof(struct padded_vnet_hdr) - vi->hdr_len
>
>
> right?
>
> So clearer as:
>
>
>         unsigned long max_len =3D (vi->big_packets_num_skbfrags + 1) * PA=
GE_SIZE -
>         sizeof(struct padded_vnet_hdr) + vi->hdr_len;
>
Right, that's the same value. Yours reads better!

I'll fold this into the next respin. One thing I'd like to settle
first: David suggested storing this in a vi field computed once at the
probe (it's a per-device constant) and just comparing len against it
on the datapath, instead of re-deriving it in receive_big() each time.
I'll wait for his take on that and send a single v4 that covers both.

Xiang

>
>
>
> > +     if (unlikely(len > max_len)) {
> >               pr_debug("%s: rx error: len %u exceeds allocated size %lu=
\n",
> > -                      dev->name, len,
> > -                      (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> > +                      dev->name, len, max_len);
> >               goto err;
> >       }
> >
> > --
> > 2.43.0
>

