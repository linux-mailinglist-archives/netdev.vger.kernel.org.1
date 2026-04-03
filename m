Return-Path: <netdev+bounces-275217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB+ZEgQo0Gko4AYAu9opvQ
	(envelope-from <netdev+bounces-275217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:50:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E65398469
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 22:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96DA1301627E
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 20:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFAE3CB2DC;
	Fri,  3 Apr 2026 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3/LUhwA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A902765F8
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249366; cv=pass; b=OdYTY2PUx8uH7NEfMbIIGcWCgLtBbZwzQL/RXi72j1pxR6DejCwC5q4uKvll2cEMp6QrzxzXRDE1Kx9Ir6UuNWdQXrcSg0q7KENzKDnN0rWpKVnQzeeuGYrxhQYvt55FD1at/pi6linQAr/fKk2Tv/Oe4iZM4IXHZ6qdwx99j24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249366; c=relaxed/simple;
	bh=SRdXL9pF0SUpD1GbHqWfstRLkZCuxd7KcF25AXBEL2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8y+MeydWtmVDG+YZoLYX5YmcKu5M7O9ZSFaXymo++sei8c8gQKCniINFsXrzpKphunYzOzDerpGZxWMXOT6Rrop2V78w95imTBidE8n3Bkly2VD2xgLpMh5VhhAAMwtDdOUpuQChyoPFuGv0qdwbBghxizv3BOXdbGn8sRf9ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3/LUhwA; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a48deebe95so22755826d6.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:49:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775249364; cv=none;
        d=google.com; s=arc-20240605;
        b=Lw7leL7ieiQ96sOjiwh0LHK82tqN9T0BwDk1+Pt9WTA/tz3l8sT0YzGLf6m5qZYKKb
         CAYkI9+XZT9+1PcQrX2pF+drI/0vE12a0gUfAh+Ihxv0HEn0ikPnyI7599yubNNhAXBa
         +nCCWsNSvguAslv058nr4GAHzMkSumTiefbNgAggiWmyjjO+GZE9BY45TS4VdUHO7EDx
         t/GS/OyoLHq2mEo8mFoZmSp8fECx2NSIK8Fe+cuGaeQCqltdv6i6zR4ZU+b1gvfbgUN8
         axT7rX7ZNRMhFbieBh5ci14O9WqFdIreT9SsebAABlRJcgt7eQTePbeln48cRU9JjZZM
         ZV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yy7c2R2Sma/liU8WLgBDm2i7Y8h08gG3LXxao9FKCK0=;
        fh=bqBzGrKVq/tgsIlht9Oz0OwVxwkyjbq2jWUVkkdsMgk=;
        b=WUczrjrvrKpLF1H+tqRBiNWLKdWvpijJyMutKkOX9wRAiYH6w6DtwFg91M9UTNv795
         27YEwZY+9wNfK1DlUKX+EE6xDOFdfbh5JzE4c7ydT/aO/H84j0+P0dShl3s+dls+q1gU
         SNcfksl5lCqZo9sXrpANEzBcsEIbzCHxAFmg/0fAxH8iM9rcc0OrQo+nq/fYMvJcfhOW
         m3pKWYfjpLqazDwUOhQ0fxYrAe9oN/IbgVfw1jHe86cPvJI+STwFroO+VQR6FENZXCy3
         KKC2J+lXkBW8rTFc5S/VXms/p14XuELQnHq3nfjaehLm2yLfNTBCHzwjzxq61QeoMfcq
         8jPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775249364; x=1775854164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy7c2R2Sma/liU8WLgBDm2i7Y8h08gG3LXxao9FKCK0=;
        b=l3/LUhwAfPqI+7ElF/BQhZ5WaDd3BCP5QETozIdNYUHBXPTxfMUmfKDjO/IK6BOtxL
         XZQKxyOTFfp23t3gjEwYCDJhrL2I1M6mFRg83g7S6BhJ6UQHoO99ijUy7wpPfuAVxVHi
         FWrXCYQ7OHeARxkSN+uuK8eewJKv41jN/GocIDeudK2WmhgUvEdAs0QhX1xQ6hZCKA+a
         4VYrAGV8vYih/tApWkNYtUrkZVFRA/lq7aZ/CjALgZ42Up5YeQx3G2eUQDfJhUdowU8Y
         oLjbKWl5rHuK/E1uxr5O4W7REMZefGJvXpBcoh6clTZUTmZUWMjBxlS7ddDXi5ZA5Vra
         LVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775249364; x=1775854164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yy7c2R2Sma/liU8WLgBDm2i7Y8h08gG3LXxao9FKCK0=;
        b=IovyWfcr0PrnZJbgmNSKhNLMfr4F0bM5oBJD3o4OtcLzob1jvZlscmMPfPK5pqV9iG
         r/s6+YzGPtesU24u3Syp9HhvrGgp1ckWeCwjpXALQ/pzHiOddAI3MOQ8Qf/mY3Y/rHaL
         YkPleksMXtEzkd9II5OFMsPSDuR18uT/ENEplz1Z5BIjmg0wWyRQ0v/DPmntZ3ypA26i
         gU9sdjh7VK2FT/oU+hE4rNfrkIKp26ayZrjaU2D7dndtR716fAthDt705pccoDxpNF7Z
         AiZdP9nXbrDy8fe7okWQMwD/BMdT+mIRGJc9DlSYZE2yPlb3P/uUicFfgtacCKczb0AC
         MLlA==
X-Forwarded-Encrypted: i=1; AJvYcCVpxzUQ3+BIJBVPzMS3DpH3xtAfyWPWSg1an9DjISLjJ8/DJYgj2RkO2wxT0W+IjvfWJqV7Oxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKUXY0CFh2oEwBzGIn+ZHhxUw2LbB3Onvr1dU/vPIFkTJWVH4
	53O2X4GPN9r4QR5ZtNoapBVkGICkkUKGURTBHmaGgGJH5YDomK/NzVSFHHe6uJlkprs/0+igVdx
	X/pPLvxm1dkhzpGfsqJQ8Z/o466kkZbzwlG+C53Lc
X-Gm-Gg: AeBDieva9FRRVSX9rD+vPjna7sfZU9abup0MDoBVt5xBbwKl2OOlFHKoETlxFNR2JUs
	uzWGC+7VLjZODmY/zjxdJwYYsBZiRYccn96m/BRdorX8cqt6a2NNp81aW1nH/UP8aj/JR/fvm6Z
	Co2yGImI6Mwq9Nt91W6e5h6uvQiiDk3k0twNt5DALuA3v+NOa4OlGXujcC6F0gzMYGc9cScuIIf
	ZN2KD/VE8L/i6SyWITHjKPVNPqAnS6dwQ4z5Vv8FycGlOSSg57kIxmmkfsKYpx2AmZFKEZEb9Ni
	a5xS
X-Received: by 2002:a05:6214:5b8a:b0:89a:98:ff1d with SMTP id
 6a1803df08f44-8a7028a992dmr77311896d6.20.1775249364008; Fri, 03 Apr 2026
 13:49:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com> <20260403043237.3909226-2-edumazet@google.com>
 <CANn89iK00Ttiq6CBkKZ1KdPbVwOgEMYwQP=6PK8fpYf2Fp9mDw@mail.gmail.com>
 <CANn89iLUN1F-NzdCpaPhZBFVZR6KjEuyPNhNXtWr6Hu4BFdyMw@mail.gmail.com> <20260403134732.26e39509@kernel.org>
In-Reply-To: <20260403134732.26e39509@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Apr 2026 13:49:11 -0700
X-Gm-Features: AQROBzDt00PSTM3GCSpg8i7tK_8kvdNKwJ2ZjivX4nxcB0Ey_7PJlEzQZTzIs8I
Message-ID: <CANn89i+SnfFboyNed81NvBDXHMGe6oWgE3AGcGfDb7eqg7z4jA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] net: tso: add tso_features_check()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275217-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B1E65398469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 1:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 3 Apr 2026 00:20:13 -0700 Eric Dumazet wrote:
> > > I forgot that netif_skb_features() uses:
> > >
> > > if (dev->netdev_ops->ndo_features_check)
> > >     features &=3D dev->netdev_ops->ndo_features_check(skb, dev,
> > >                                             features);
> > > else
> > >     features &=3D dflt_features_check(skb, dev, features);
> > >
> > > So I need to call vlan_features_check() from tso_features_check()
> >
> > I could be wrong though, vlan_features_check() is about  skbs with
> > multiple vlan tags,
> > and net/core/tso.c should support them just fine.
>
> But we probably still need to clear NETIF_F_IP_CSUM for example?
> Better safe than sorry. (I won't repeat the sashiko complaints
> assuming you saw those ;))

Ah not yet, let me check ;)

