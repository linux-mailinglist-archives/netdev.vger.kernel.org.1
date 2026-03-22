Return-Path: <netdev+bounces-270296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Z0kmNY9vv2ki4wMAu9opvQ
	(envelope-from <netdev+bounces-270296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 05:26:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF2D2E8325
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 05:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A179E300D6B9
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 04:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4604184524;
	Sun, 22 Mar 2026 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTcJYff1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F9B672
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 04:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774153612; cv=pass; b=f2Y+Td53GthEvON/ZdFvymOYT67Yn/sbUK7ZxQ0yVv0IG3x+8dYWHmeJl/aZ/ilq3+mpmgAAAPAOt98mbK3vGNHYjfLPBmJsKo8ohxqM0FGG3l0HLJ7cBHerZhJc0VFGhXfxszTrhwvBnwHaRMv/QusFcaCXRz4PHSMf5uuiXfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774153612; c=relaxed/simple;
	bh=DXOqwC6s9L15xaXrgZK1d520VE7xR8GodPmXMhTnIRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVehm6ih9yyKOJnnzDr9dK+hKKsUjQJEBn82jn7Pjj4R3tcV6nuWzce0kMeChvZnR6igWc7mmtZ/57ANX3jhHj2qq84qKnTEZTo7sH/0tbS1f8s5njewVYlYnqtIR9eSQMHP9LX2a0nTaQe2IW8RHjc7RizU3CwjpYPBRoh30a4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTcJYff1; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b97c44417ffso171347366b.2
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 21:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774153609; cv=none;
        d=google.com; s=arc-20240605;
        b=Sx8B8n0v+tiso8hzYGcCtT5El1unzXx1hC50nppxHXuw0Kc0CPWLHolhJ9nPMNbL+N
         AvhzKIIO2ESdaqBn4Kra14Z6L85CtcSucsdAranTBlaIUvCcOEK8kLa5IfcDdWvLwOF4
         jO7PuMRHM3xazWaGLfNd20Pl/Zi3OeC0bUg2JBqhJMuT4dU40C8ystJjxRSYf2Q/kDez
         wWlSjxqGHw1BGiFcNt9raVBUBowo6T/NXqz3AifiJoXcikkeiyNrShuNf9LC2Fxry2P7
         T76iKrbCvufqBQoB8jn7RaH42LTSRzYlcE2raRYtdi9wvQvRx3eHBrrj3d9gIJACXQim
         X5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGY7c3s+RjV2GJF2g+nyWk1beTLPuE7vKXwu+2flu+M=;
        fh=cDccIrXeAcZw1w84wHTpUPkYNfn3wpAGG7kgKYOQfWs=;
        b=HBbwt66qyQbCodIkGnOjZever7cCGo2imSl8ITqjbKsKcDZLGdykrS1Vs5eahKCV8h
         QO6B9W2IC8Ni7RvBlpOxbsgOz+lYjtvrXSqkKjngN4xmNu/DHwhfxZlLvA9b8zv0wn3w
         UNCzdO6KruORcnJIO6YaK40QWC2kGS/EpjW40lZ1U/pbS/jpTJx6WwQ4B/dld4shISC5
         C2QME5y/jtIRE0IkEc4ZYfT5nJ2U08JLcwg/i5J9XP+C5btyR6JGC1GCODwXMBS4pRnK
         MFteA9BdwOqDEzvqHyE5wQRO4JVV8apQ49mJzZTIjINaXyjusgYyWzu3caqfgXqn33M6
         4E3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774153609; x=1774758409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGY7c3s+RjV2GJF2g+nyWk1beTLPuE7vKXwu+2flu+M=;
        b=JTcJYff1RxotuJN0xXwj5gKFklVN5wActkBMFT5QG4e9bJlmInif3brxfW3DIKZqUC
         Kt4H7YmNHNWVAcCfZ4XHyUQ9kv/x37KX0Rw9hLSm/PcgHT7mhko7eTWBg74Ge113ZPIg
         g9YWkBj0w0T1BY1X/cPQYm/XxdN1YiAYHbXE89d3S/fNZssIZjt8y8520D+vIHzNePrc
         vXOogS5XpMEDuIQCRqTmHMBT55RJpq3OOLhhBI3NDafPQAmWIiFPk6MZic6PenUWTUX+
         3jIYpBQjQ0uPR3OxnU+b06ETB/1vbcdBDkhypGNi2aWoQstaRDvSq9H8imgZtoSpCGPE
         tJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774153609; x=1774758409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGY7c3s+RjV2GJF2g+nyWk1beTLPuE7vKXwu+2flu+M=;
        b=V0QnZfYs3SeCqAPacn2751gxofT7w9bhdgHLLNdAqP3VaRdkb0HZHFIri+HPJLaBNk
         8tesyK2EdYtFk6zDlpZi4TPvPriyVUeKngmB20UzJUPdXs0/YbDL8Slgetd7bM5aplW3
         HJ1mV30kqzEqk3jNEvX3eUuIN/w9jl3MVhWYlrGZ7nYaM/LXNxKlj2J9ok0f+Encq0pj
         6ijLYJRiHBrC7aar5Tn9C7LgY4/Nm1VuJPMEvvHOnswMnVc1+YVf+cat42D/nNO3dIgz
         iV18MtWd3DYtFFNLKWXBhUK56qt1x42zHZGiYJdmbaY1tJIQi6FIOH6xaSXBB3X8jwCh
         srUg==
X-Forwarded-Encrypted: i=1; AJvYcCXrXWj63tiBEn/Y/KR6e04TlNFC2iBfwRz5x5YOVBLrqprxZjwIkk1SKmWL5UvrdqcfsNVEBnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7sZUKFUzBtJ/5PCT9Ii0U1qVENutSC0Kb1IglpXLxmiMNd1io
	f9b9h/vFFSeSV+w6laBb6yjCvwLPyczro4MwHcY6cbgHJSLV70Q//9C6Muc/9VJ7rOBzfzq3SOP
	NVBT81J1XQcL98rTXvvk6UgADvvHhaXE=
X-Gm-Gg: ATEYQzxjy3Ajjpfm5Mwc28duv1xaQvU2aAOCmDD7couAGf5Dm2jq6V+uHTZa/nnjYUV
	9ErnkORNwcr1ntSvqd+mQXx1hxcCIEL5j2H0fmI2dH2+H/qaugV1ZTREw7auzUM0sp1/z6DO/KV
	Y09GUEObXduWN0yzgVQ1r5eiwPIzlGMtOdyQWwMDz+ZZwKUdTjmNcnyVvzehhrAeErm9FO1jaVp
	nlNGMeBElhISakd0+K6P1BCNjSKhKeRfClhFx6ytXCdFFYF6coJmnKBUr3loChxwMS3+JvmotxS
	+GmszNu+o6GlLXGzNbQZUZcSFWkn1U9O4wM5apNRAIraGyHwbOdd87msoDO2rg==
X-Received: by 2002:a17:907:c992:b0:b93:7d70:20a0 with SMTP id
 a640c23a62f3a-b982f0c0138mr428466266b.4.1774153609110; Sat, 21 Mar 2026
 21:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <willemdebruijn.kernel.c0bb5d182993@gmail.com> <20260320141459.9691-1-yss2813483011xxl@gmail.com>
 <willemdebruijn.kernel.2018fae77325e@gmail.com> <willemdebruijn.kernel.2497131610e6a@gmail.com>
 <CAMa1Pe4sxiyekrMKV6w5E3SJ1sk1ZzJs7wdepx6oLKGpRsi35A@mail.gmail.com> <willemdebruijn.kernel.5c56580eb49@gmail.com>
In-Reply-To: <willemdebruijn.kernel.5c56580eb49@gmail.com>
From: Guoyu Su <yss2813483011xxl@gmail.com>
Date: Sun, 22 Mar 2026 12:26:21 +0800
X-Gm-Features: AaiRm53ry50v7W1J9FpsFXLvLuVcuarRzQS1kQbxZhK0pRUm0MBYNLR5LMnWQvM
Message-ID: <CAMa1Pe5XGeyk4rf7rX+4FjwPzUhxdKEw5Qsi2GwkeOMr6fw6Jg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270296-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 2CF2D2E8325
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Willem, this is a good point.

I reran with instrumentation at two exact points:
1) packet_snd(), immediately after virtio_net_hdr_to_skb() returns
   (net/packet/af_packet.c)
2) gso_features_check(), in the SKB_GSO_DODGY branch before frag_off access
   (net/core/dev.c)

For the same skb, I consistently see (first 20 dumps):
- pkt_after_vnet:
  skb=3D... len=3D56584 headlen=3D172 data_len=3D56412 netoff=3D172 transof=
f=3D88
gso_type=3D0x3
  skb_dump: headroom=3D4, mac=3D(4,172), trans=3D92
- gso_dodgy:
  skb=3D... nhoff=3D172 headlen=3D172 netoff=3D172 transoff=3D88

So in this run, coverage up to p_off on the transport-side does not imply
safe direct access at nhoff on the network-side (nhoff/headlen are
both 172 here).

I agree that validating/dropping malformed packets as early as possible in
virtio_net_hdr_to_skb() would be preferable if we can make that check preci=
se.
This patch addresses the observed safety gap at gso_features_check() for DO=
DGY
packets in the current path.

If helpful, I can share more skb_dump snippets / full serial log.

Willem de Bruijn <willemdebruijn.kernel@gmail.com> =E4=BA=8E2026=E5=B9=B43=
=E6=9C=8822=E6=97=A5=E5=91=A8=E6=97=A5 04:58=E5=86=99=E9=81=93=EF=BC=9A
>
> Scars wrote:
> > I instrumented packet_snd(), __virtio_net_hdr_to_skb(), and
> > gso_features_check() while running the C repro.
> >
> > In repeated runs, for the same skb, I consistently observed:
> > - __virtio_net_hdr_to_skb() (NEEDS_CSUM path):
> > skb_transport_offset=3D88, thlen=3D20, so p_off=3D108;
> > pskb_may_pull(..., 108)
>
> All the above matches the skb_dump from my previous post.
>
> > succeeds (headlen=3D172).
>
> My output shows headlen 108. Here we start to diverge.
>
> > - gso_features_check() on the resulting DODGY TCPv4 skb uses
> > nhoff=3Dskb_network_offset(skb)=3D172.
>
> And I see headroom of 4, so mac at 4, skb->network_header at 80 and
> skb->transport_header at 92. No 172.
>
> That part is key. My measurement is in packet_snd right after
> virtio_net_hdr_to_skb. Where do you see this, and can you perhaps get
> an skb_dump (NOT full_skb, as these are large, just the header
> metadata).
>
> I don't mean to delay the fix. Just, in general, a preferable fix for
> these weird user injected packets is to detect and drop as close to
> kerne entry as possible, meaning in virtio_net_hdr_to_skb, rather than
> have to make the main datapath robust against crazy packets -- which
> comes with branches and other overhead on the legitimate hot path.
>
>
> >
> > So the pull checks in __virtio_net_hdr_to_skb() guarantee access up to
> > p_off, but do not guarantee that the
> > header at nhoff is safely linear for direct iph->frag_off dereference.
> >
> > In this run, nhoff=3D=3Dheadlen on the observed packets (IPv4 header
> > starts at the linear tail boundary). Using
> > skb_header_pointer() in the DODGY branch avoids this gap.
> >
> > I did not hit a KMSAN report in this rerun (instrumented/patched
> > kernel), but the offset mismatch above was
> > reproducible.
> >
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> =E4=BA=8E2026=E5=B9=
=B43=E6=9C=8821=E6=97=A5=E5=91=A8=E5=85=AD 09:36=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Willem de Bruijn wrote:
> > > > Guoyu Su wrote:
> > > > > Syzbot reported a KMSAN uninit-value warning in gso_features_chec=
k()
> > > > > called from netif_skb_features() [1].
> > > > >
> > > > > The current direct skb->len check is not sufficient for SKB_GSO_D=
ODGY
> > > > > packets. In the AF_PACKET/PACKET_VNET_HDR path, packet_snd() can =
build
> > > > > a DODGY GSO skb whose total length is large enough, while the IPv=
4
> > > > > header is not fully available as initialized linear data for a di=
rect
> > > > > iph->frag_off access.
> > > >
> > > > The fix looks fine, but the AI review of an earlier revision brings=
 up
> > > > a good point: __virtio_net_hdr_to_skb calls pskb_may_pull in all pa=
ths
> > > > to ensure the network header is fully in skb linear. What kind of p=
acket
> > > > is this that managed to escape those checks?
> > >
> > > The packets I got out of the C repro just after virtio_net_hdr_to_skb
> > > look as below.
> > >
> > > [   76.539562] vnet_hdr: flags=3D0x75 gso_type=3D0x1 hlen=3D0x6a gso_=
sz=3D0x416d cstart=3D0x58
> > > [   76.539755] skb len=3D56584 data_len=3D56476 headroom=3D4 headlen=
=3D108 tailroom=3D0
> > > [   76.539755] end-tail=3D208 mac=3D(4,76) mac_len=3D0 net=3D(80,12) =
trans=3D92
> > > [   76.539755] shinfo(txflags=3D0 nr_frags=3D3 gso(size=3D16749 type=
=3D3 segs=3D0))
> > > [   76.539755] csum(0x10005c start=3D92 offset=3D16 ip_summed=3D3 com=
plete_sw=3D0 valid=3D0 level=3D0)
> > > [   76.539755] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D0 iif=
=3D0
> > > [   76.539755] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
> > > [   76.539755] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > > [   76.540713] dev name=3Dip6gretap0 feat=3D0x0000000e401d4869
> > > [   76.540843] sk family=3D17 type=3D3 proto=3D0
> > >
> > > Clearly fishy. They do have VIRTIO_NET_HDR_F_NEEDS_CSUM set, so we
> > > know which branch they take.
> > >
> > >         skb_reset_mac_header(skb);
> > >
> > >         if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
> > >                 u32 start =3D __virtio16_to_cpu(little_endian, hdr->c=
sum_start);
> > >                 u32 off =3D __virtio16_to_cpu(little_endian, hdr->csu=
m_offset);
> > >                 u32 needed =3D start + max_t(u32, thlen, off + sizeof=
(__sum16));
> > >
> > > // start =3D=3D 88
> > > // needed =3D=3D 88 + 18 =3D=3D 106
> > >
> > >                 if (!pskb_may_pull(skb, needed))
> > >                         return -EINVAL;
> > >
> > >                 if (!skb_partial_csum_set(skb, start, off))
> > >                         return -EINVAL;
> > >                 if (skb_transport_offset(skb) < nh_min_len)
> > >                         return -EINVAL;
> > >
> > >                 nh_min_len =3D skb_transport_offset(skb);
> > >
> > > // nh_min_len =3D=3D 88
> > >
> > >                 p_off =3D nh_min_len + thlen;
> > >
> > > // p_off =3D=3D 108
> > >
> > >                 if (!pskb_may_pull(skb, p_off))
> > >                         return -EINVAL;
> > >
> > > // headlen =3D=3D 108
> > >
> > > At the end of this headlen =3D=3D 108, so all of iphdr should be in
> > > linear.
> > >
> > > Since the syz repro requires repeat it is possible that I simply did
> > > not capture the right packet, but I don't see the C program vary the
> > > packet contents.
>
>

