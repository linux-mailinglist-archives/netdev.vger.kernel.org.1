Return-Path: <netdev+bounces-299731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RZjxCOjRMGqiXgUAu9opvQ
	(envelope-from <netdev+bounces-299731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:32:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C9868BE9F
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:32:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=W1lA7UJo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299731-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299731-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F86E304DBB1
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462F33CBE9A;
	Tue, 16 Jun 2026 04:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73443CB2FC
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 04:30:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584210; cv=pass; b=RI0huL9EMKqK3SgZZFjl0AxWWrt83G5fGPbD+wo5ixjNHe+nul+CjcbObYgALC9Bw9I9Msx5cDRi5D/tZDc5aaEzkipDAGtdMBr+fzOVFbqMxd0X+/VkhZpbQ29y+JfAzTxzUGSrbL7dkCyEiJxoQXdpu2D+d6mAV651saLVvVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584210; c=relaxed/simple;
	bh=Iy6jgVqcBBs4rASBrLNQoYJQZJL3ZQB2WUBZma5U/+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyUaqncnzZemLscVKjCaZSuEMHpSAOz7opWAiE0OovahFa04tqUbNap+fHCOEJDmAlB1gbu2OcczwiaDe+bcp05SPNps8aOOpsaBWQnPSNhQxdCNF/zdhEZfMX7LROmN7nsBqO+U+JyA8Hl7Ae/8oo8L5Tb3oU4Ua1q3V54+Rp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=W1lA7UJo; arc=pass smtp.client-ip=209.85.216.44
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso2448356a91.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 21:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781584208; cv=none;
        d=google.com; s=arc-20240605;
        b=GIHI8lLaIVc7uMmH2Dc0MC25o6ZBg5adA4Zvj3poRaSFfK1Qcz4OjkM2ZU4+38jFJN
         5q76fFATDeEtCVvzCrZ02YKMIs+0CsJV+VYG254+0H4ILSK2/7HyHthmkLaSw9lG8Bog
         buztb/fg+bMW1ypOkU65H479v06wg1OATLBZdLiEimFECL5lmca+pEG+KHbu4iKGaA71
         ywb7QU0W93pjubA+LY0/T0r5Hru82cdpJ2X+66/r4kvN15VMBQxrfdMHg8pFt6EwHg69
         Zc08xhsu410xzfrWwtC6Rf0iLVlDk+Q8dXYZlfK7xQByhRL2rFTqqtxyt6350/v1pORG
         5zKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ppX4qdYU5rXRtx2iPmU/w5gI+2dV9fiMI5XfuWrU7yA=;
        fh=+ynbtrF6afbP9SGyfjtAhEg+2iFOz9cTAPE95DFFPvY=;
        b=ii2OMTDs8bOLUfZ3MYdqgfp6ShtaQrGtsCTe0nD3M10IEoXrNkTB4W9p6ed/9bXvdJ
         VzGiViRR2Giv89WCVlCagvF5ydpuEtD1TZsaYQ3zrYjd4it4g7fktI4FN2v12fIajYJt
         BdjH3PDIhSLthYJsbtZbdSn9nvAcIzzW4zgaQC8FxdPweEwzc70m3dETEDVI9WlwSDOQ
         eKHeIRFdSY1KWd9sYQUkvO8I0efaWyfS7s14l3GPAGpToNmR24pgAilQk4rJVdhaEMd8
         FP8TyWhspKNV0Bh44nzM3zdnuiqpMhMbGuOktl9VUKQqqY1hkcNuEbk+9yL5rIFyRDEd
         plUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781584208; x=1782189008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppX4qdYU5rXRtx2iPmU/w5gI+2dV9fiMI5XfuWrU7yA=;
        b=W1lA7UJoOLKyB3MqY6v+SzQqOaX39uTvBznaZwrsH6Ls5D7bvy44ipbTauPRF3elYS
         z29NWv1BY38cDNY1Qkdg9fpnyV40YkJUAnZkODqRkzU09wCwbe5uiUBWTKiq2DAPF6Sn
         1UumehgTGwDHSS3o7tEiYGlCCmN/k6/jpZdkTgeWzpudsUEEY8LgMZ3zTfD1+YYxB56d
         7nDBNq0tFrClPzzg9jhsU6MJO5DV/SxT7I12/YAC13g22SUmesSPGdXuwuAGhuSkVBSK
         TnlKHy2iXmRYy4wBBsMyvFOLWWCAOjek8lYBYxhYXBBJfUOu1ko71zYTA5LNJsLZ3UKU
         qYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781584208; x=1782189008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ppX4qdYU5rXRtx2iPmU/w5gI+2dV9fiMI5XfuWrU7yA=;
        b=M7txi0xbiy/7AFzCzF+YCnlKtxCLhTBitFr0YpE6bFkoe3tsLJ73Q8UdgQvvoqfD3R
         H94xf2nIlJwCgVTvT/+xyvHUXviVRtYrx9Ts4h+D8huDHnkDnIP2GRIciQWQ2LwRN54D
         +ClUiJt5sxiOCxnpFXo57NscV70sk3ILVM+0L0RlOwBIBosucOIuDd2+ttb89U6wovrK
         C1upDE+sOkngiAaS5Y5FXrBm5XdF9VhlEBpegl05Lq1sElWriPxbE3TmNjpxPP1IRWPt
         ApXYdCKlO+eB9gx+femQs3Ub4wQBFQCtkYVMI8RiZogIUykProCyphOGNRMq0TEZQZql
         pmFQ==
X-Forwarded-Encrypted: i=1; AFNElJ/q3O5MewkDKBWMC4bnlSQGdcu8eBdqtL2R4MszmNh0ZwnT+g4Zh3WugcZ4H/9pN5CmZ36vexc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/cKssMsULIott3TBj/EwZycPE4EwG7l7+JCuB74KxgI8DrQl
	owjgATiMhxluL40hfpS4hICuDrx+O1GIKMWlqmxOFEQyZEWOrPvWiVp+LEJ82tk/tkg9qC70Qlx
	Iyf88hTxX65UD9af1a7vuelDypEyjUWNATWfB5t3w
X-Gm-Gg: Acq92OFhEZJLN4I7vpU6yIceD1uDrSLiLfNKyHcNqYuh/IWFffpVsFL0gx236qvgpJd
	VvPssUHapQDy1HLYDkpTmGH4LPndlPGczBJcUiyOmKGz9LDxTk67XyrkpVEL/vwhzrJZfvi1k+U
	sdiYvjUMKev7qDzIdDrqYjdUsTR1QxvYo/ahzOeHBh42dKmg7S2IWD1R3HaI3uuykCgyVCdu/F1
	U0/5lHrk0egjabcYzD9grUjZ5Nc+HaAZi8z6zpMZsXl6A6bGjcpIkV6CnwX+gRuYsKPPJZfFJlW
	IuVG2Y4=
X-Received: by 2002:a17:90b:53cb:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-37c2bce7aedmr12427842a91.16.1781584208118; Mon, 15 Jun 2026
 21:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611024616.1408317-1-xmei5@asu.edu> <20260611014519-mutt-send-email-mst@kernel.org>
 <CAPpSM+Q=NM0WeBmZvyOEkyx73VU10AOHQjPbWDSet675B7AnCA@mail.gmail.com> <20260614152904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260614152904-mutt-send-email-mst@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 15 Jun 2026 21:29:57 -0700
X-Gm-Features: AVVi8Cc2s0GQzec-BSWAkyi2kv832yJ1_God0icULI6-YQFhGMfJc-Yqjq-xTJs
Message-ID: <CAPpSM+S5zwZLuEu7CBbFBtJgBJ+668x2RMNaVS7jPr--YiURWA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299731-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,alibaba.com:email,asu.edu:dkim,asu.edu:email,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77C9868BE9F

On Sun, Jun 14, 2026 at 12:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Sat, Jun 13, 2026 at 01:15:02PM -0700, Xiang Mei wrote:
> > On Wed, Jun 10, 2026 at 10:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Wed, Jun 10, 2026 at 07:46:16PM -0700, Xiang Mei wrote:
> > > > receive_big() bounds the device-announced length by
> > > > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loos=
e:
> > > > add_recvbuf_big() sets sg[1] to start at offset
> > > > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > > > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > > > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than th=
e
> > > > check allows for the common hdr_len =3D=3D 12 case.
> > > >
> > > > A malicious virtio backend can announce a len in that gap.  page_to=
_skb()
> > > > then walks one frag past the page chain, storing a NULL page->priva=
te
> > > > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bo=
unds
> > > > write past the static frag array and a NULL frag handed up the rx p=
ath.
> > > >
> > > > Bound len by the size add_recvbuf_big() actually advertised.
> > > >
> > > > Fixes: 0c716703965f ("virtio-net: fix received length check in big =
packets")
> > > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > Thanks for the patch! Something small to improve:
> > >
> > > > ---
> > > > v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
> > > >
> > > >  drivers/net/virtio_net.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index f4adcfee7a80..afe73eda1491 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct n=
et_device *dev,
> > > >                                  struct virtnet_rq_stats *stats)
> > > >  {
> > > >       struct page *page =3D buf;
> > > > +     unsigned long max_len;
> > >
> > > Assignment can happen here?
> > >
> > > >       struct sk_buff *skb;
> > > >
> > > >       /* Make sure that len does not exceed the size allocated in
> > > >        * add_recvbuf_big.
> > > >        */
> > > > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_=
SIZE)) {
> > > > +     max_len =3D vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_v=
net_hdr)) +
> > > > +               vi->big_packets_num_skbfrags * PAGE_SIZE;
> > >
> > > Took me a while to figure out what is going on, but I finally
> > > understand:
> > >
> > >
> > > Reducing
> > > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE
> > >
> > > (what we allocated)
> > >
> > > by sizeof(struct padded_vnet_hdr) - vi->hdr_len
> > >
> > >
> > > right?
> > >
> > > So clearer as:
> > >
> > >
> > >         unsigned long max_len =3D (vi->big_packets_num_skbfrags + 1) =
* PAGE_SIZE -
> > >         sizeof(struct padded_vnet_hdr) + vi->hdr_len;
> > >
> > Right, that's the same value. Yours reads better!
> >
> > I'll fold this into the next respin. One thing I'd like to settle
> > first: David suggested storing this in a vi field computed once at the
> > probe (it's a per-device constant) and just comparing len against it
> > on the datapath, instead of re-deriving it in receive_big() each time.
> > I'll wait for his take on that and send a single v4 that covers both.
> >
> > Xiang
>
> I don't mind.
Thanks, Michael,

V4 has been sent.

Xiang
>
> > >
> > >
> > >
> > > > +     if (unlikely(len > max_len)) {
> > > >               pr_debug("%s: rx error: len %u exceeds allocated size=
 %lu\n",
> > > > -                      dev->name, len,
> > > > -                      (vi->big_packets_num_skbfrags + 1) * PAGE_SI=
ZE);
> > > > +                      dev->name, len, max_len);
> > > >               goto err;
> > > >       }
> > > >
> > > > --
> > > > 2.43.0
> > >
>

