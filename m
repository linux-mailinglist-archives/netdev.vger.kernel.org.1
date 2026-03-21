Return-Path: <netdev+bounces-270226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEfGDCq7vmlIZAMAu9opvQ
	(envelope-from <netdev+bounces-270226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:37:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E29D2E6237
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 16:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD771303265B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7524C3002D1;
	Sat, 21 Mar 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC+45geI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD22820A9
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774107145; cv=pass; b=gbOfEa7dIWx1DtvI1Kms12/3hQ5UZpNqsQKPmXKOhUBdSJ4GO5fvSx6YsFaur/2LaimU3+iUL+hvJ03H4jS72erA9WA9R2nb1m03SEJiPUcOQ02JV/giJ5RKtd4RX8B5Ho6yfSRLoplaf1onn7YnoDKRCuRVToQwaOUFo0ZcXFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774107145; c=relaxed/simple;
	bh=SEtJ6yJtIAoqvcaZ/EVkK5qmDDYjvbY8ydcE3ETLdNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDDCTlZAh4Ta4y7eMbBYJJksSNuxs6IXFcTz9aVEauX4xIBm6DFp0fZ6V/lmYQ99Ql1UKCW+0c5saFlPNTeD8ZYA4Rs5jOwVwtLfmxtMWYAtjrU8e7OC2anouVx8caS/FuvCQE+pcoGUJRCVxo7KWyvnnVS9841JqLYigTLfrug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jC+45geI; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-668d70fabc4so2856921a12.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 08:32:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774107142; cv=none;
        d=google.com; s=arc-20240605;
        b=XDs1b4YT6SmA1grlJpPSbLccQKffHhn/eE0Flc7oAFHjHFR3JqtCeIbIuNflHs7jAA
         nzYkTMYHHvzlAfb7xpM5G4CET2+vQri1wy2zm8V9B1p3GTejJCsCiQYbbCr2esXSUezl
         u0V7qWgAk6zNCRHsyla6d8xEERlZKmIE0T6INC0RmsdbIK147pvtBKjwOZoJ+aAlXHw8
         EQCIwfhqTjrKb/gkzayDtEwi4O6mz1pV0cdEjgaJCL/Ijl4SzoE5p3lZX/YwCEsUf2Yo
         TUkfgiaSIkZYpvmAj6uDkhawrEiFc+3uvHbIZaOXCm4aKJ0sS/e8VNJz2qS3i4lhScR3
         9mQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6mT6fR8ELfRe+68amXgf8ZcOmPwJOUQA8AQbfdjxqMs=;
        fh=dGbqA15CVJUBrmo3vpQQR3ofGtMi90vMT45d+fP2GAA=;
        b=WaNUAydEJEYnVbb28Ty66CoNC4mclPubBcb15OkCK5J9pByU29OnSr0MOHOM2+oGgy
         P5YimOmCts/m0HH6nUoiWnECA9ANJaI/Czmwt0B1s2o2A6GadGlUYIehl4G7O79NWVeY
         Ajzp7e+4IjpmIUIio9CLUlWxSI47Iw29w5PwYiSRLbV4g6+1xAQbPBiH8WAZO8UobRMz
         skjFEw1ZgjqROhtf3shaHRr3MHKjXvUAB7LYiOsxVyCvnJkW9HfjVDAc0UkomMTasCPX
         wp2D4SpLlUZCqKlEW2Fsd9gLKZLT/E0rc4T4r2yAwL5pbeO7rQKpOzqvgr7dTgUw6O3A
         2XCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774107142; x=1774711942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mT6fR8ELfRe+68amXgf8ZcOmPwJOUQA8AQbfdjxqMs=;
        b=jC+45geIiaGG0JP7wX0qGnIW33vVltjXEl5rcf5kyKalvqN7WxsMIYHzhIhrSXh4fj
         9R4oqdzTjtuHb3stclNs1ji5Tgz+LsTRU3A8QBF3BwVKFMsHQaSBowHfUKYTvzSehFmT
         2nQUb1BVLzbCwjyGTp+AyRdrJGQTZ/smk1J1lBes2VW62aJn9xmnhcb1UwTCGMoDVfyz
         v0/JDF3QFRYAWenAmcCIyzdowVtL9UXImwXF5269fNbo+F+6PyUf++zQJOp0icUu03Jw
         2Kxl/cGbZGnZZZFOlBYZwzgpw1IoAJBALO+50NufMzgd1XfjYCQv56DgORR1LvhgaqbP
         CZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774107142; x=1774711942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mT6fR8ELfRe+68amXgf8ZcOmPwJOUQA8AQbfdjxqMs=;
        b=JDFVcyjIooQeOtxJvUTV+1ye2gtR0Vb1ESSaVzoSdOVsq71G1w/hlylM32ctPlNB+h
         MbouGCb4BoMmU1jOjrimdlVSwYn46je3Zk57JWRZ0ht4f962ubEv2TAznD1wub+WHV+t
         HXjsSxKvR/sPsz55817An2+fiThpSozZ4dZr2GxBCUPj5IwvRUdW1fkWY3nWJuRFM5Xm
         MQg7XHlAN+Ol/gglYnm0CpSnBqBM+KIMEobFTclH8GypDDOQ2zY+giM8sG7HWDVjc1J8
         L2PKZsgXTrDHsbcBx1b4xm6P0eqiTiGuvKb+gezcCkIb/ZRQHm4Y1Mb1GvGdtzJvSywv
         z7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQHx4HaQFoqtc9HyfZFetERalnetfyI5s8vX+AOl07egTmnpcOVB0xqLT8vZ/RzriCXrWCJqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoICtg1KcbTw8R9RFlDcGIhkEvd/Y+Kxu78DdbPXKdlyOlNxDp
	ezNKQ2B+ll3p5+SrgTilOOGK0ZarE1FV2ELGCBi2o5xMOddTsmBCHH34+LkZhonLNEENQ3fe514
	DjT0Q1z8DwazhNIjHcKqn37TmiBF+X4I=
X-Gm-Gg: ATEYQzw5AHGO8kRzLeic/bu3d6KdTvp9TrEvW5PGWIIQmLbswGaF8NbBdxMuFY4u9hx
	u2DXvLy2Tu6kJTovRLP/xDgGdRrl2fSoy5LZvTxQbOJaEMcNxm+cIuhdDlmhO+24OhWAc3jmTWo
	sMeyOc2lmSkxouTYastq+YB/w+4Yw6IbPlUs/yUtTAp32klAvljkEKzES6CxoPmFSUeKZUp0m+X
	k50lYbixp6FG5TrHIgZzJYHxab7F4Y413uZnazKep9ST0b603UadbaeGom4u454gox4sPBAcY9b
	kDN6ZSiTQkatX7OhXlf/BezXA08eNQT8Hp63E9uD+8N81cFxUY0=
X-Received: by 2002:a17:907:994c:b0:b88:5158:d10e with SMTP id
 a640c23a62f3a-b982f26b087mr363258266b.21.1774107141881; Sat, 21 Mar 2026
 08:32:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <willemdebruijn.kernel.c0bb5d182993@gmail.com> <20260320141459.9691-1-yss2813483011xxl@gmail.com>
 <willemdebruijn.kernel.2018fae77325e@gmail.com> <willemdebruijn.kernel.2497131610e6a@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2497131610e6a@gmail.com>
From: Scars <yss2813483011xxl@gmail.com>
Date: Sat, 21 Mar 2026 23:31:55 +0800
X-Gm-Features: AaiRm53Dgu0yuhzbUNldSEqseu1affLDsBeD5YorvmlgtNRjw6AcoHYjS3SD970
Message-ID: <CAMa1Pe4sxiyekrMKV6w5E3SJ1sk1ZzJs7wdepx6oLKGpRsi35A@mail.gmail.com>
Subject: Re: [PATCH net v5] net: use skb_header_pointer() only for DODGY TCPv4
 GSO skbs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270226-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yss2813483011xxl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9E29D2E6237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I instrumented packet_snd(), __virtio_net_hdr_to_skb(), and
gso_features_check() while running the C repro.

In repeated runs, for the same skb, I consistently observed:
- __virtio_net_hdr_to_skb() (NEEDS_CSUM path):
skb_transport_offset=3D88, thlen=3D20, so p_off=3D108;
pskb_may_pull(..., 108) succeeds (headlen=3D172).
- gso_features_check() on the resulting DODGY TCPv4 skb uses
nhoff=3Dskb_network_offset(skb)=3D172.

So the pull checks in __virtio_net_hdr_to_skb() guarantee access up to
p_off, but do not guarantee that the
header at nhoff is safely linear for direct iph->frag_off dereference.

In this run, nhoff=3D=3Dheadlen on the observed packets (IPv4 header
starts at the linear tail boundary). Using
skb_header_pointer() in the DODGY branch avoids this gap.

I did not hit a KMSAN report in this rerun (instrumented/patched
kernel), but the offset mismatch above was
reproducible.

Willem de Bruijn <willemdebruijn.kernel@gmail.com> =E4=BA=8E2026=E5=B9=B43=
=E6=9C=8821=E6=97=A5=E5=91=A8=E5=85=AD 09:36=E5=86=99=E9=81=93=EF=BC=9A
>
> Willem de Bruijn wrote:
> > Guoyu Su wrote:
> > > Syzbot reported a KMSAN uninit-value warning in gso_features_check()
> > > called from netif_skb_features() [1].
> > >
> > > The current direct skb->len check is not sufficient for SKB_GSO_DODGY
> > > packets. In the AF_PACKET/PACKET_VNET_HDR path, packet_snd() can buil=
d
> > > a DODGY GSO skb whose total length is large enough, while the IPv4
> > > header is not fully available as initialized linear data for a direct
> > > iph->frag_off access.
> >
> > The fix looks fine, but the AI review of an earlier revision brings up
> > a good point: __virtio_net_hdr_to_skb calls pskb_may_pull in all paths
> > to ensure the network header is fully in skb linear. What kind of packe=
t
> > is this that managed to escape those checks?
>
> The packets I got out of the C repro just after virtio_net_hdr_to_skb
> look as below.
>
> [   76.539562] vnet_hdr: flags=3D0x75 gso_type=3D0x1 hlen=3D0x6a gso_sz=
=3D0x416d cstart=3D0x58
> [   76.539755] skb len=3D56584 data_len=3D56476 headroom=3D4 headlen=3D10=
8 tailroom=3D0
> [   76.539755] end-tail=3D208 mac=3D(4,76) mac_len=3D0 net=3D(80,12) tran=
s=3D92
> [   76.539755] shinfo(txflags=3D0 nr_frags=3D3 gso(size=3D16749 type=3D3 =
segs=3D0))
> [   76.539755] csum(0x10005c start=3D92 offset=3D16 ip_summed=3D3 complet=
e_sw=3D0 valid=3D0 level=3D0)
> [   76.539755] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0 iif=3D0
> [   76.539755] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
> [   76.539755] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0, =
trans=3D0)
> [   76.540713] dev name=3Dip6gretap0 feat=3D0x0000000e401d4869
> [   76.540843] sk family=3D17 type=3D3 proto=3D0
>
> Clearly fishy. They do have VIRTIO_NET_HDR_F_NEEDS_CSUM set, so we
> know which branch they take.
>
>         skb_reset_mac_header(skb);
>
>         if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
>                 u32 start =3D __virtio16_to_cpu(little_endian, hdr->csum_=
start);
>                 u32 off =3D __virtio16_to_cpu(little_endian, hdr->csum_of=
fset);
>                 u32 needed =3D start + max_t(u32, thlen, off + sizeof(__s=
um16));
>
> // start =3D=3D 88
> // needed =3D=3D 88 + 18 =3D=3D 106
>
>                 if (!pskb_may_pull(skb, needed))
>                         return -EINVAL;
>
>                 if (!skb_partial_csum_set(skb, start, off))
>                         return -EINVAL;
>                 if (skb_transport_offset(skb) < nh_min_len)
>                         return -EINVAL;
>
>                 nh_min_len =3D skb_transport_offset(skb);
>
> // nh_min_len =3D=3D 88
>
>                 p_off =3D nh_min_len + thlen;
>
> // p_off =3D=3D 108
>
>                 if (!pskb_may_pull(skb, p_off))
>                         return -EINVAL;
>
> // headlen =3D=3D 108
>
> At the end of this headlen =3D=3D 108, so all of iphdr should be in
> linear.
>
> Since the syz repro requires repeat it is possible that I simply did
> not capture the right packet, but I don't see the C program vary the
> packet contents.

