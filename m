Return-Path: <netdev+bounces-299733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2Q0dJz7dMGpjYAUAu9opvQ
	(envelope-from <netdev+bounces-299733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:21:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED85468C1C4
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 07:21:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=scq9pCPF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299733-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299733-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FEE930465F5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 05:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BE53CF1E2;
	Tue, 16 Jun 2026 05:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1B63CF1EA
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:20:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587251; cv=pass; b=aLyN2Ld6E8Dnyy9wojxMtRA5pLxawHbhD5FzJWVanUCtYejxMLD9fWsTG3GU8phxBlf+c5CLuLPSxJ54D+DPPZY4116VlSp8ShbnfIs9VI8xO3l4C7mGEekyRgSAsWHvGguaERSImgrFGwEaAbdecW2/PUh5VBrZfOxljomM0FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587251; c=relaxed/simple;
	bh=1pTesxFWXzYuQxgGfaOTCXBTp1da8jVGIAPtlmYLgsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHkBGqXprk6v2OI6mJ1qzQTWi0H5vLh0q6QR4U6rB2s6NuKu+F5Zw7/CLkC7435ExsxC/QEtqq4xTVMK65BR5MvOKD8cUGckcpBEeLBjN6DgyN/Z3H32TF+KviHnNzTZeDP1Ur+NXn1Qutiznyg1v89Vah7wYQw+IQc31RB0PPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=scq9pCPF; arc=pass smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b9328c4aso30265415ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781587249; cv=none;
        d=google.com; s=arc-20240605;
        b=b8hfQ7PmpTGL2QErpbJu7MdWDDpoM4IBaa5k3+x/Aa8qBtW+WlwqoE0K3j5QZoXzA8
         t6ZsHvhdCwM97WSknSafzmh+NsZMAJRxSks0gwNqjX3ZX2heLDYwd1EiBZJSX9iaER0K
         f1g1LJM9x1v4L1kcpVOE1H5vwRYThEG8qNHrr+CpRmLzmmDN5N3dScXVWS78yo1x9GAS
         06TP+lK6kesLxPLQ0R8m/muTFcInYF9CVF217+5qftFUx7OCtGwtI2nnsWoOa4Y0ioSc
         Oh9Vu23frg2NjZOPM0+BsMimBBEwB03UNOCsPI9EtSTR7f3QxvjMEIJyvaytdWrH7P1O
         RDCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOBfkW3s2HtntFIC62qbBB3es6YF5T0ky4hO2DWBBro=;
        fh=fdIpp2vvAwr0ln0b6V9m3kEYbe+uGYBzNQYzDtjUOAI=;
        b=bc90tzx4wSXmTnf5pTuC284G4bo/ag8binqQjSD4rkVfMh7A/2HyyBBt7rCMU7/d+V
         w6flDL3lk5WSoDlFpkuV4OIc9UrPK+8Z3QklhE3svlsOy0aVv9AdINaUOsfset9PxokS
         1IbTug8g/+XRlSOVqsfa1PiVWcGlc8sOjc2ZPMFW43UGdPAnbIaAAPMmOGC2uqtvS8rL
         Ii3uMnNBSeXANJqOFKRRD5E6a++ACkH7+jn2pGMI7FPNkwSle9OqTu2z23e4uSSgzXaR
         xXYy0Xn5fbItcaGoTCkCNy54qRMMue+g92pP6EFpaP2nOr2frCsCJC8pcmTbkEXimTeX
         LU5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781587249; x=1782192049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOBfkW3s2HtntFIC62qbBB3es6YF5T0ky4hO2DWBBro=;
        b=scq9pCPFLQ5ED5CqsQ9uuq6jh72UTkhQNiDHUmyAdtGPyRqmcLQ+hU/oON+FbRLj2F
         bExDFHleQlpyyPIDwXc+T65M2TSGTYv1L+NG8Od1wZes3HBSbZJO6rIk56paGtzJ1RH+
         jaTVXL97IiLIZFXXBPE0EMrhO/T7CNzPo9oiviRibP8F+GxRNqWeznqkPeIR5JPSmfLO
         xeeU1EChGBf2RLcEPT/XFL7sY/pSZXKBf6IueLPwnXUJv2iXC9d9pafD/3A7knle9gqS
         bRpl3MWq3X78zJZS7kBCh8tvOSqF+TPQPsUxS0cassjk4SPw7ubOJeSO4QDr6nYS+8ic
         134g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781587249; x=1782192049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOBfkW3s2HtntFIC62qbBB3es6YF5T0ky4hO2DWBBro=;
        b=mwJftZH7PDpHe3GChXRts2oCJxzaDvwSmR5loOBgYF8j81jh7FmTP7XTDYaQCzZEKq
         r2j78FvBvzDGKSpqWVJHRl722AFDcdnw9MAkgHZVO+BdTmOoLypNVmKuzSHsIzNaXwnt
         ZXFUfKkfOpaX1FQQvb6A1p2y+30uHQakFeMhO+QjiWQD2soEKXY+ZMbKd0Sbr8TWIKPe
         9/4yrBbuz7kUZAtAxIvJBxzwyv8t6YR4Ug1K83pbvSa83nF2SjY+knkuNyr/3Hjp6M4+
         y1cnrRtjoCxlZ3J6wLlti0aAwEzcdArpvqvNIWIebjTIDst6qbOI+WoMpZkSUmDqWmvG
         vEwg==
X-Forwarded-Encrypted: i=1; AFNElJ/G1wuRHxDR59YODVp3F5w8/zs5On0LLIDTuQY6qUOPdIBVwy35/kZGAaHM/GHTnoP/moIuv4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5usM5Hf1v6vRH/2j9uYLYIdYPW2chGnjmpf/EooR68nwkt/PK
	5FdntlVpBrr6DIIWsNSm3og3o2j6CK/SM4H25KY7JlOnC/WcyHpszkhGDAQkKTO0FseyxhlpHNC
	H7wsiYL4Sj4yPGNU8pFFDvil5RrZ94/UC1AjWv9Ci7OOgsqUzJdlGU136OQQ=
X-Gm-Gg: Acq92OFzGtDF8597zCV11Xth1fNBGaiV61j8Y7JtSyiW9xucCmUJwMKuPn4MbNLPPSZ
	vOevcy2cIDKeOmvcMXH6lY+dUDTE7tHlgcdjzWqfIYF9MFdhZZ5Q01myZTN9jklc9zDHRI43sZJ
	qUEwm+H6CjTD6XB/fqgtbcr5NeiZGaI1FBNB4GhEYMgmOtF8cReA+orXensNn3b/Fv2xUr84uUP
	eKSYm9Ww3fgD046yW3ZFXvNEVQUSM43eM8OhlLqkwMMk9C9szBr7B7ATWVilJBVW58g8gy8WBUV
	mUp0Sv8=
X-Received: by 2002:a17:903:19e5:b0:2bf:128d:f7ff with SMTP id
 d9443c01a7336-2c69a15d10cmr23423855ad.16.1781587249076; Mon, 15 Jun 2026
 22:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616042837.2249468-1-xmei5@asu.edu> <20260616003903-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260616003903-mutt-send-email-mst@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 15 Jun 2026 22:20:38 -0700
X-Gm-Features: AVVi8CdHw4FBskNeiNkd-2Q0mi8e2wV3bqRPKnGfF77ZInLfXHYM-ueHGQy0ANM
Message-ID: <CAPpSM+SxTkCn6VPXCpKO64op5-w=w5+BhQOrfAVeOK8d7cc88A@mail.gmail.com>
Subject: Re: [PATCH net v4] virtio-net: fix len check in receive_big()
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
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-299733-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:email,asu.edu:from_mime,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED85468C1C4

On Mon, Jun 15, 2026 at 9:40=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 15, 2026 at 09:28:37PM -0700, Xiang Mei wrote:
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
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> > ---
> > v4: use easy to understand math to compute the max_len
> > v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
>
> I still feel 2/2 is good defence in depth but it can be
> pursued separately.
Thanks, Michael. I'll leave 2/2 out of this series.
Appreciate the review.

Xiang
>
> > v2: add additiona check as 2/2
> >
> >  drivers/net/virtio_net.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index f4adcfee7a80..8f4562316aaa 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1999,15 +1999,16 @@ static struct sk_buff *receive_big(struct net_d=
evice *dev,
> >                                  struct virtnet_rq_stats *stats)
> >  {
> >       struct page *page =3D buf;
> > +     unsigned long max_len =3D (vi->big_packets_num_skbfrags + 1) * PA=
GE_SIZE -
> > +                             sizeof(struct padded_vnet_hdr) + vi->hdr_=
len;
> >       struct sk_buff *skb;
> >
> >       /* Make sure that len does not exceed the size allocated in
> >        * add_recvbuf_big.
> >        */
> > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
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

