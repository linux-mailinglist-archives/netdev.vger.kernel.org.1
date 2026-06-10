Return-Path: <netdev+bounces-297850-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s3PEMcfoKWrsfQMAu9opvQ
	(envelope-from <netdev+bounces-297850-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261866D3C5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:44:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=m3SRT+06;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297850-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297850-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46A533093A8A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07B0369D7C;
	Wed, 10 Jun 2026 22:44:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA53164BA
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:44:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131450; cv=pass; b=mHlrXXMlV95qkakhrUXcIkiRNQg/yrMn/68hdvnG72AoQ/bE01pWitzIamF2wwlveT9YRf5dxoK2PfxF3J80GQ9l6YK/RPAa+BvIGo48PnRIug493Xsqt3WcAEtLaMqvNLeiNgGpfeW6rbcTT/B+c5U9u5BDhGiS5jLGrdUrsIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131450; c=relaxed/simple;
	bh=br20ZOx5+JfsJTf3ObD/E7biiXwgMeTM26yhtT8hmaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJhLZE6jNIhZ1EFbvNrkE556VPkw+jsw3I88bB0XL+135D0RG6GqDH0Y0AslcDReQkw7cD3Jbfop7En1FgRyKexRfZBlY8CzkNEhga6MNFf3+l7ypaZkEMcSqxfP3OI1VtVRyRpgS6njhIL1p9BJoINMWtb7GuHMNuVfRbBVd6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=m3SRT+06; arc=pass smtp.client-ip=209.85.219.53
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccf01ba514so61135526d6.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781131448; cv=none;
        d=google.com; s=arc-20240605;
        b=ZQ/CNQYpWnSI2+xBKzamxr3A0lUAHDN7Ph1ZRTLXfdBnOmuRGc4cCfIrrcCAbo/I7R
         uPPMh5zRC3hOs/utmr29N9OUsCU/dryfhJh8Nc3ujz2m9v+GrQBgYGsLeYiluac3hgmv
         fA7UInelIkL6madRbSdo/yWiRxlrwu/msMxh88vXtXT2ja/oQCRwPuVdTNqVC/Ffy6tb
         Jl+7IE6geEdvWmHGOz2evUTtvgJjmSLgeM+siefBpKaRBCjJkSAqyxAWTyYymUOD/LEX
         7c1gdDRbCx9/xNmbMKOZoLgM13qY2pcX6G1C+mVP+kLb4gFRFwUqpTXcxAU+rSx7yqqp
         VyaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H+9ItBe9lxcsMAXxEA8xORo0f4DOTn6OB37cmsN38zA=;
        fh=cLHzcLkcNhE+3jjaQvEbXPEgBKwHl3d8j/J0jWMy8SE=;
        b=Nn1pWCEcLYNCiX/Og1QRf+FLDlnG2NXn0SQayk5YrrzZNC/7YVKNQICfH9xwDMhajF
         4cSMHcGiu6bYZi903wPMpeq6eEV1e2tTjaiKl0tN6KMrC6htF/QD4idqSwEdzn0jIxcK
         ETaYtLfm1yDytyQaRtWVJ0okvtEvZ4OWWWXVdhRh2xR0OBkrnyssjmHTkEYkg3JrKoN9
         dvkzL22NqdGtMb4LhG4p6H7EiPJ54fIdVFnVAIduUCZORfEcr5c/gebJg/Ehs8cTjvtk
         XUGAmzf6/GzwdkIb6392x0cG6KwcQWPnRVLN4ocTx06D6/X6mkfjQldqy5iJ7J/xpKuV
         mXZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781131448; x=1781736248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+9ItBe9lxcsMAXxEA8xORo0f4DOTn6OB37cmsN38zA=;
        b=m3SRT+06aZAT6HTQo/sP+VcRE3Wgd8lxukkJ5gUKDFETHz/VYHnVhIWNBWtq16I3BK
         fI2iHspzmrG5j6s0Mrqe4BaJ7E8Pjv1Ev8eHJ2e/N0jJR/+02rnjOcmdJH3zq3NAYp/s
         Jxf07xePH3CGpJ1xh/gI77FgygeO+fHsVHqUU6pFXcbm1cgM0mYf3116jr+yWduBwShJ
         4ozoexKOZtVcA2+xbb3mvhfdRjg2sLpqgh3tQMHS1OZNxyBc4cr3BoXd+MjfFn5xskXX
         y3p88z8nFODJY9KX2hhvXykhHu8MAC1KyJI2V5hg7bzg/n4RDqPIceYcocTHFYvhQHjh
         t9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781131448; x=1781736248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+9ItBe9lxcsMAXxEA8xORo0f4DOTn6OB37cmsN38zA=;
        b=AoDEl9PhybrvVnmtaTVTdb1ExiRyWul+WyxLMip2Gg2cf9eX07V4kUVqZuCNZvtbem
         9k+yymSQD/HFxytk2yhvzXxeuueVWxcLbJf+XS+IuyV84sNuLGYVUx8uYh6wc5nQG3tq
         Pd6aVRkrQqeVZZLqdI9sPFr3l99eLSgBOmhmTeapHZMRnYvsXML1aBRlZ2gHp3IZ64JL
         YXbDT/5dgLhN76NuSbuaQbZoFBZYjnzspQfF/u80YGKEz6iNcBn1RicvXutQm6MfQJxQ
         nheg2Tnx6zvNYqvSc0XV5X7hXhMA5iU2bJ6gx7TVtjm9nBbfz9ve94b/pVLOUm4EM38a
         oU9A==
X-Forwarded-Encrypted: i=1; AFNElJ/foieW8+eI+Uz/y9MtPMCgWyhvOIrSQmgdRvZD8+d1U2jnT7mgRR7/pvBS4CbT2FPs+La0lgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyHbIkUWLGeBOWhXHQIQZK2uFOxgUz3vKG+wQSjWaaNjouD1X
	p36tUG5aqVu4TfocRH92gVDw/FWOZFuLqQvxzBemfHQ5IZYFBoywkSxG/yIqh/oDH247w+scNBC
	tke5RhBiC9HiyVtNm6ZyZJsCGsJEzhnQmRtmxAauJ
X-Gm-Gg: Acq92OFxBpOmKDKq2SmKrSzrCCSd2K6ohrGnuyEChoLxO2EIOqe5mGuMf0l9BQxJs3R
	RK2Olvh6t0afkLdckebXGN86ZkDNC8/CM6NCO9AipbrX2P4AbWG7pUdyqngQrFF/3s8e/2gN4yx
	662YfwOMX9gfcXs1klI27LtYVfwdXExrEoQadlNLjzjaYvFQP/qudB3wrTlyFfmeAwHpnyEqlpQ
	fMBbh/YtrKLM4z2U4wJI7KYdUmj4sgiMCDIAOXHZ5v/kiRGmFYhQYsVjfzIB3DKRqGWtz8kyAz3
	2p+B7gun5XqcLrQJLrZm09SG/dEbbNPbxImNr8uTtc+7CTDxZMfQ
X-Received: by 2002:a05:6214:2346:b0:8ac:7d43:f88d with SMTP id
 6a1803df08f44-8d1d4ce4492mr3920606d6.0.1781131448284; Wed, 10 Jun 2026
 15:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610221606.1091465-1-xmei5@asu.edu> <20260610181911-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260610181911-mutt-send-email-mst@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 10 Jun 2026 15:43:56 -0700
X-Gm-Features: AVVi8Cf4mx5kl6MBvN9Gs2AR7WfDTm5JmMFtZi116xPgZJQCsmqqvhdrImRjBvw
Message-ID: <CAPpSM+RWNGnugK1+Oo53jsPXd5bTtf-NPzqW2UNo9Y0GQBs_sw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-297850-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:dkim,asu.edu:email,asu.edu:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2261866D3C5

Thanks for the quick reply. It comes faster than my reproduction email!

On Wed, Jun 10, 2026 at 3:22=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jun 10, 2026 at 03:16:06PM -0700, Xiang Mei wrote:
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
> > Bound len by the size add_recvbuf_big() actually advertised.
> >
> > Fixes: 0c716703965f ("virtio-net: fix received length check in big pack=
ets")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Let's instead (or additionally?), bound the frags array index.
>
> Seems more robust.

Good call! I'll keep the length tightening in receive_big() and also
harden the page_to_skb() frag loop. So it can't index past
MAX_SKB_FRAGS or walk a NULL chain page, independent of what length
the caller validated. v2 will have both.

>
> > ---
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

