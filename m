Return-Path: <netdev+bounces-270019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNLUFbCRvWnY+wIAu9opvQ
	(envelope-from <netdev+bounces-270019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:28:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE22DF659
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 19:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3472D3009148
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD403E6DCD;
	Fri, 20 Mar 2026 18:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="HhOgEvoe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F01CD2C
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030949; cv=none; b=Txhke0FQW+GjObkwOAlYKjij/p4Q1T7qV6nb7vGfZw1KBlSkrsrPweMVl4ziR4/p8UeUxrEmhBacorszbaiB5j+uZ8aff6EoPaA1NCJCmwGHqSyEoq5nb0ipkwG8q93j+1IlK6tUv2015MYj6+DrnhKi5dCKrEuPvncB/+BmLOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030949; c=relaxed/simple;
	bh=kbScMxLi7VMWW8uu2LJf1nrML2u8PdwipskxJa66tfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTNgoAujHPGO/w4DFqgzcAabSIgx+Uhzy4iva2xCGgXatuVcifP/BY5CKkuR8yJ4X64NxtHn0D7iLmzW7d5AhlqH3Kh9LSlOpciD7itMwfrfcbAVebY+oJfEqyQBvzGNF76gtr0YGPELF/YAVqE38tqj/khBwwVy4Y+KC9fmYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=HhOgEvoe; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dAeNShXuefm/aROP+nopw1Z/faSIMrUBsveFHVUHNQU=; t=1774030948; x=1774894948; 
	b=HhOgEvoeNfrv4mukB9jLVXJ0B4qJh1pGWAneVi8NAqGpG9L5H5RFWTL+X7C04DVqDGT4LXQc4xZ
	147b/eNmXO4d1a11lUL6LG84YBJNLVX8dFV4QG96adnQ4NsddJk81F24W58hxZ/8WDZsMhQqQhOrt
	mHbTKOYfrqe9OhFaiqyld7imHv+z0UfDhktorqI0UUFdh7YG2LufpRHda2jfNjFXd0v0FVqP6Z0Zk
	MawC1P/VzYqcD1yuPYFMYm4hpxUXVniZ647UnG8RbdJCJ1EwP/7BQc7efYDKgAiZu771g0SrhqgKc
	xk/l+Q3fV+u1ao5NxQXandhmEJAYFBHDiNvA==;
Received: from mail-yw1-f174.google.com ([209.85.128.174]:43236)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1w3eUM-0005Dm-Qc
	for netdev@vger.kernel.org; Fri, 20 Mar 2026 11:22:27 -0700
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-798374d0f44so49039957b3.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 11:22:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfmy2ffEQNG1OjOY2eNIvpsh1PwU6UrJKD6r2bLFmfOp8PqKcgsjgjhzGouAA+T8sww770Yj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBrKFo5jy/RiAsOrfXm0QwV+doSAyB/BUGuywoAQu1/unmTPR
	oIQCDtSQ8tIfg2ocvLXFdcE8Rhdpk27ZG2Vk12kjSr0u0QYAueScEqU6YFcj/TzaNnh6KUPX7gD
	NngEGcsEZQ3Lw1flFPiCt6wP9BfjCGVQ=
X-Received: by 2002:a05:690e:2486:b0:64a:d677:85c with SMTP id
 956f58d0204a3-64e9ce7982emr5713416d50.37.1774030946133; Fri, 20 Mar 2026
 11:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316223228.2611-10-ouster@cs.stanford.edu> <20260318072136.269073-1-pabeni@redhat.com>
In-Reply-To: <20260318072136.269073-1-pabeni@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Fri, 20 Mar 2026 11:21:50 -0700
X-Gmail-Original-Message-ID: <CAGXJAmw5y0Z_237EQ0GGdYMJfMnhMHHcLPstCTXV4Fzh3Z1G_g@mail.gmail.com>
X-Gm-Features: AaiRm516KOTBvGNPPro1LrOqtUdhcm26Hmct5vMUJoYbze5DnR5zthbuDPDvh9A
Message-ID: <CAGXJAmw5y0Z_237EQ0GGdYMJfMnhMHHcLPstCTXV4Fzh3Z1G_g@mail.gmail.com>
Subject: Re: [net-next,v17,09/14] net: homa: create homa_outgoing.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org, netdev@vger.kernel.org, kuba@kernel.org, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 8ae29cfe0e7acab0c1a6d8f3d15a0178
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.stanford.edu:s=cs2308];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cs.stanford.edu : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270019-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.stanford.edu:-];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ouster@cs.stanford.edu,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.400];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0EE22DF659
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 12:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> > +/**
> > + * homa_xmit_unknown() - Send an RPC_UNKNOWN packet to a peer.
> > + * @skb:         Buffer containing an incoming packet; identifies the =
peer to
> > + *               which the RPC_UNKNOWN packet should be sent.
> > + * @hsk:         Socket that should be used to send the RPC_UNKNOWN pa=
cket.
> > + */
> > +void homa_xmit_unknown(struct sk_buff *skb, struct homa_sock *hsk)
> > +{
> > +     struct homa_common_hdr *h =3D (struct homa_common_hdr *)skb->data=
;
> > +     struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> > +     struct homa_rpc_unknown_hdr unknown;
>                                         ^^^^^^^^^^
> Does this code send uninitialized kernel stack memory over the network?
> The struct homa_rpc_unknown_hdr unknown is only partially initialized.
>
> Four fields are set:
>
>         unknown.common.sport =3D h->dport;
>         unknown.common.dport =3D h->sport;
>         unknown.common.type =3D RPC_UNKNOWN;
>         unknown.common.sender_id =3D cpu_to_be64(homa_local_id(h->sender_=
id));
>
> But the remaining fields of homa_common_hdr (sequence, ack[3], doff,
> reserved1, window, checksum, reserved2) are left uninitialized. These tot=
al
> 15 bytes of data.
>
> __homa_xmit_control() copies the entire struct via memcpy():
>
>         h =3D skb_put(skb, length);
>         memcpy(h, contents, length);
>
> and the packet is then transmitted over the network via ip_queue_xmit() o=
r
> ip6_xmit().
>
> This sends uninitialized kernel stack memory contents over the wire, whic=
h is
> an information leak.

Fixed (here and for other calls to __homa_xmit_control).

> > +     struct homa_peer *peer;
> > +
> > +     unknown.common.sport =3D h->dport;
> > +     unknown.common.dport =3D h->sport;
> > +     unknown.common.type =3D RPC_UNKNOWN;
> > +     unknown.common.sender_id =3D cpu_to_be64(homa_local_id(h->sender_=
id));
> > +     peer =3D homa_peer_get(hsk, &saddr);
> > +     if (!IS_ERR(peer))
> > +             __homa_xmit_control(&unknown, sizeof(unknown), peer, hsk)=
;
> > +     homa_peer_release(peer);
>           ^^^^^^^^^^^^^^^^^^^^
>
> Can this dereference an error pointer?  When homa_peer_get() fails and
> returns an ERR_PTR (for example, -ENOMEM from allocation failure or
> rhashtable insert error), homa_peer_release(peer) is called unconditional=
ly on
> the error pointer.
>
> homa_peer_release() calls refcount_dec_and_test(&peer->refs), which
> dereferences the invalid ERR_PTR address.
>
> The IS_ERR check on the previous line correctly guards __homa_xmit_contro=
l
> but does not guard homa_peer_release.

Fixed; shouldn't release the peer after an error.

