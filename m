Return-Path: <netdev+bounces-282858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGbEFllY82lfzwEAu9opvQ
	(envelope-from <netdev+bounces-282858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:25:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53C74A3672
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25407300613E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D950423A88;
	Thu, 30 Apr 2026 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoqvG26S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045D40B6F5
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555543; cv=pass; b=obN1i9SsoZeG9DNhvC3E0NcRJCsDxwlWM+5P+MI7oB8ObhpwnZgT4P/+/HjAnOTzF/VOHTtVzDgyfeHkTgub369mK6mnVC2u3HKL9W0XK56BKm3BkVyrdb16Dm8z4GFmd82fVlqKvETa1izT0L+hpjM+pjk6y3VXZ+h8ZYoJbFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555543; c=relaxed/simple;
	bh=fjDOjr8TXD+Uue0jZxdpNWFXMlva8LVFIseujyMS3b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFLI1KRdZOHnE1KQ4BaKKxChL6OhuF3aJmF7pSPgc/A7dUA1xu2S6kGTcWmKlMvpLPP6zUYfovqiJcaCSEH1GZot2Cy9ZeV1Vsmt+LxGe27i+bEZNi8qTHK4Nro8V/RORxNoTNtsVxauphAYAf/+Y+h0fUHJVISskmqpipTLt80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XoqvG26S; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50fbd79350dso7879261cf.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:25:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777555541; cv=none;
        d=google.com; s=arc-20240605;
        b=BHvovZfoy6IauWteiG/2zYtvQdCR9G4DewR6R+TObDRbVwu66NKpEWoh+YMSSIzqHP
         M5cP6s5pd1jbLI1ATRUCgBjt9YvVASmVV3tGfajZCcyT50XgMmXVec6qkkB7kHs/pr/r
         Va8F8Nx6laFiZkr6bA9VwtlQB7dkCnND9AGVdgDot37w3akUOyAay9pR3sbReARvmnbn
         xWuNTJiOohKGJH1gjmvFYHK2RR9cn58ZAZYx3CpzBoVPVmjXA6Na6OB2cdlLIg5DlS5Q
         aKYIhoPnX8PAxl1Gltnc0qUNNks3ilEpWX12DbYcxx2IUcT2w1RGcroSmggl7fuSv/9I
         msig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sO4TTEF1RztUU2dWjILXmaTVXAqjVZ1W2I3M5j3GBw=;
        fh=b2RBH05akX7qkpNx2vtNe9lMUCYXjVrfrYyp7Y6mQ7Y=;
        b=JstvQNvpWV4F9+H22kTGOrszte+ushAsE5V/07VCoXTkRUGOoqGiI9AiexqW5eWNPf
         ykZepq5x0Zbf7f3mFw7s8bvM/hO/d3pBj0aFzVWDhiMRmh1FSOiM29XY5jQEefBK6Nkm
         ZsxcNOmPzvvkbThb83ZEzeNeqqmlbnHZIVY0m27blhMtmL3jRki8QGZF1fNvQioSF/Ba
         Yb3YHnmnkAnoWBp8wRraFyEnNbWQx06G2Jip2BxrAx7M7BalOCU56C+mKJ9l5Elo52ep
         j/A+hG6fJpo5JZ1+6ZyKVOi7nvxuHtyrZsWnrfdWp9htEFZ5LQ1kn0QBh5VjAeDmyJr3
         UBJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777555541; x=1778160341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sO4TTEF1RztUU2dWjILXmaTVXAqjVZ1W2I3M5j3GBw=;
        b=XoqvG26SqGxfRgpNZfU6c63otfPKdKs5ei7LjVLODMTM8yZ54FBtEUwGStLWZou/Uz
         CcJ4kFFv/KsqdAIzVL4+lPkoUjl0+Rrxr8h2aSmLuSdgLYf2RQLsG0zbEACH3F7TJgeA
         SFxXbna9WsuDG4n+J9bYTryBXKygH2CcQdb0K/zmetoajHDHtKLAJGZJ8y8Rxenv/D6q
         i8SLppLtALy7rfCUpxzlPGxVTDU7zgjw7LUmtxgNuf7N1MM3s+Oy1zxtbNJBHFnl4/YD
         ORV/3wnuko3IUuGCTik0kieLNMIXl4udVsKOq3SFojmZdKSj0WIZzSz75NBvpxrBS1BR
         mkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555541; x=1778160341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1sO4TTEF1RztUU2dWjILXmaTVXAqjVZ1W2I3M5j3GBw=;
        b=knStLcYGSi9n7yj6Equs8BNsFfkClQoHaGK4d25S3vRo5m8gsW9zVQXaFhmoj51/P+
         gaDBTOWFuMHPkoA8qGm61SCfjF2kjgSlil0fEg05yPTf+5RbsN2vTpCdcfUQPysWIg9J
         7lrYumUyc0A2cpgmktkOp60darrQG0E1pYd9S6ku5hykvx52MNA/Zr0iiQZw8jlYZJMb
         V/wmb05COioTU6tDiRMAXCu2hSoyoIDmXIkqyB7Sq0evLAu9PvNb4XL6wzZLJoJLBgcf
         Np4f8npnNxn1Ikc20ZGOcutX+UIDWfefLi+ygYgAAGbdJuU57fChI24biLOfFVGABzU5
         7D6w==
X-Forwarded-Encrypted: i=1; AFNElJ+dcKVBt/nLe8wa5arSp9zpPNuUnvCYDEDCbSIQnwFSRX6M00RH8hBHjih7kj0vMIqUssYKlgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkDl1Hepwqd2k6s7Tzxf8uoJzviRkYGbTgFWj1pies45DG2Gqs
	eyzWSKSoMEsW4PzJWLH+ak5D+iZFtTSZk/q8R5kDN40NDFQXRily0of2amtvjmuXetRBY3rA9ey
	+GGTM/ja5QPlU2D+fHySa3iJAiKFuSyQplSRTSyrp
X-Gm-Gg: AeBDieuu7fHm15sTgl2I/EUb/74My+gW+tqgiPa/Jp7toy+Ex3bZPi9dNVwUfZ8GBTT
	sbHjTdXdWNEoZcjPzs3HmG9y14FiUlbvzgbRyROSD3yQfl3DCEH7G1yFkCrhBgnnJbtLOn7vTut
	8f/c/edxGq2nyv01qyRfCBAhWYBUXaai1iYXfa7zFnoA+ECcOFfHNf0vMhdluKNwSS8I0I7++Zq
	NZkdSoig747bRQmtdY949XnDsLOSceosPDa31o3BaTKwHJZLDhtSg8SY7DaIc+BZqq9dl4y31w6
	YytAA6u0Hcdjx/tS+ydm7PtusCfLtRoUOAFNsUCQQWxBEyK55HtagjmboSqxoBjCH8uL3Vo/ugz
	amhMr7DSUMopbYeUIsuuL5l8+ERsehBeFrFhFfhfZ
X-Received: by 2002:a05:622a:487:b0:510:15ea:a78a with SMTP id
 d75a77b69052e-5102aeab53dmr34914051cf.50.1777555538652; Thu, 30 Apr 2026
 06:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429154648.809751-1-daniel@iogearbox.net> <20260430124025.GA971154@shredder>
In-Reply-To: <20260430124025.GA971154@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 06:25:26 -0700
X-Gm-Features: AVHnY4LEPpPfTgZJIq1PZCtk0nbUW6FasrvJrwD-VM4vRBk1vm6D5d8RpRo8KHA
Message-ID: <CANn89iL-niqj79S8Ma7PGboZnr=jrO2BJg=bLNSZeiBv4XCXFQ@mail.gmail.com>
Subject: Re: [PATCH net v5] ipv6: Implement limits on extension header parsing
To: Ido Schimmel <idosch@nvidia.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org, dsahern@kernel.org, 
	tom@herbertland.com, willemdebruijn.kernel@gmail.com, pabeni@redhat.com, 
	justin.iurman@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E53C74A3672
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,herbertland.com,gmail.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282858-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:email]

On Thu, Apr 30, 2026 at 5:40=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Wed, Apr 29, 2026 at 05:46:48PM +0200, Daniel Borkmann wrote:
> > ipv6_{skip_exthdr,find_hdr}() and ip6_{tnl_parse_tlv_enc_lim,
> > protocol_deliver_rcu}() iterate over IPv6 extension headers until they
> > find a non-extension-header protocol or run out of packet data. The
> > loops have no iteration counter, relying solely on the packet length
> > to bound them. For a crafted packet with 8-byte extension headers
> > filling a 64KB jumbogram, this means a worst case of up to ~8k
> > iterations with a skb_header_pointer call each. ipv6_skip_exthdr(),
> > for example, is used where it parses the inner quoted packet inside
> > an incoming ICMPv6 error:
> >
> >   - icmpv6_rcv
> >     - checksum validation
> >     - case ICMPV6_DEST_UNREACH
> >       - icmpv6_notify
> >         - pskb_may_pull()       <- pull inner IPv6 header
> >         - ipv6_skip_exthdr()    <- iterates here
> >         - pskb_may_pull()
> >         - ipprot->err_handler() <- sk lookup
> >
> > The per-iteration cost of ipv6_skip_exthdr itself is generally
> > light, but skb_header_pointer becomes more costly on reassembled
> > packets: the first ~1232 bytes of the inner packet are in the skb's
> > linear area, but the remaining ~63KB are in the frag_list where
> > skb_copy_bits is needed to read data.
> >
> > Initially, the idea was to add a configurable limit via a new
> > sysctl knob with default 8, in line with knobs from commit
> > 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination
> > options"), but two reasons eventually argued against it:
> >
> > - It adds to UAPI that needs to be maintained forever, and
> >   upcoming work is restricting extension header ordering anyway,
> >   leaving little reason for another sysctl knob
> > - exthdrs_core.c is always built-in even when CONFIG_IPV6=3Dn,
> >   where struct net has no .ipv6 member, so the read site would
> >   need an ifdef'd fallback to a constant anyway
> >
> > Therefore, just use a constant (IP6_MAX_EXT_HDRS_CNT). All four
> > extension header walking functions are now bound by this limit.
> >
> > Note that the check in ip6_protocol_deliver_rcu() happens right
> > before the goto resubmit, such that we don't have to have a test
> > for ipv6_ext_hdr() in the fast-path.
> >
> > There's an ongoing IETF draft-iurman-6man-eh-occurrences to enforce
> > IPv6 extension headers ordering and occurrence. The latter also
> > discusses security implications. As per RFC8200 section 4.1, the
> > occurrence rules for extension headers provide a practical upper
> > bound which is 8. In order to be conservative, let's define
> > IP6_MAX_EXT_HDRS_CNT as 12 to leave enough room for quirky setups.
> > In the unlikely event that this is still not enough, then we might
> > need to reconsider a sysctl.
> >
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks Daniel!

