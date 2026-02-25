Return-Path: <netdev+bounces-260714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPNJB2xbnmlrUwQAu9opvQ
	(envelope-from <netdev+bounces-260714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:16:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBAA190C85
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 03:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BF1B3278F88
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3F23EA93;
	Wed, 25 Feb 2026 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqN5V+g6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79DA1FE45D
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984391; cv=pass; b=AjTf6/r7pAmOJ8dX/l9ECtWnhDNnEUFpnL7tqakRxD1uU6Zk2RUVCmeXGgOS2/hkK/MccPv/m3RNklHxQJi+USADFGmfgP5SZgBGowGlA1nLWaf7YxECKtFXe6G7GX040nFUw2bIVcKJSoUnJrbwxOqevKcPzLdgFcwZY2d2S+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984391; c=relaxed/simple;
	bh=C0mgObuGCdALZFtLxXhk51l8QBviikLcMCOIR5kmFvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xoo3GRSaFXyZuuLVxc8vbIBw9aiQ/ip/DapjlRK8RDcoi/XMfPbQzy0ASfiOBva6b4kJ9azS+d7xEvgevaQ3cToeKmoEAbLvMre2oY9kYb/FJckRa6SG7KtkXyksO0M78TQaPl9RgXdnyLDaYymTwR9Gx/efkrNXRSDyIkcuDQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqN5V+g6; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a1b23c05so76636381cf.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 17:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771984389; cv=none;
        d=google.com; s=arc-20240605;
        b=GtMeT6uWYNpYWcbuorpgpI/X3C49ZiO+WwlKErXKxoYZbNzTg6csL5Nc6q2MxTeNdj
         zbXfDisd1SlXQEwEUN+D7wC4xTrH+saJXuMHiNHhY/s/227Uh5LfDYQoXghD3UFDJ5x1
         FnN3m9AXCt+jRiysE7uDaN7V0+X5DPPhK7MUWZsO7wmIZmrnyrLuRBs82bEbcnaFXqMm
         PTkyOkzqyBJWv8zrAtEbf4yG0Nzbm76JC0nZKT9R7szwMXToj0kWWCStL+K0QRwUlfnX
         xH47KYzMFnTqgw5LXcRl0pEood40UYKgy/BFCRpuuevqNud6CgPlQG4Hmg/nsqWB1Et1
         dcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RM2zN9RmIf2LWyhacPOeFCgnfc2/rTz6ZpEpYI1sHT8=;
        fh=62q3/F2kP9eCfnjNj9zmsf8Kt80gjQEWnKqL00ixUsY=;
        b=dTKnFknyam6xHj/16sThuELoa/2F0RiIFDKp2Xj7iZeUfxVcBoemCs7N+rDPhl+LdD
         KLvryA0/Lcq4iLaWEufJPJxpbUErwqMAQVGppHC7YvsKzjgVdJyXfIdNezDrVtS5BGo0
         zRgC1axespSLYaJj81x+Eqa8YTFlT13sBl/z5m6hJkIdOKWeTH0u6MkQiR2u1ti1IQXu
         Ri9NOvVRIIwOp7Y8wsJKJRaqqbtjCiZ9w0T3HQHKE3W66ycXL/LuHnO9xhXZPpsGBg+U
         Sa2GFzPx4R2VH5UeSfMQ650joSIvOsOxFwqjyIYN21+CAZfUJU2QqUPFFoVfy7rbKUHK
         UyQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771984389; x=1772589189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM2zN9RmIf2LWyhacPOeFCgnfc2/rTz6ZpEpYI1sHT8=;
        b=eqN5V+g6SjSNr3xByIZC6GL3QBAcnypS/NC71oEdKqdzYc+jHjteKtVcyzrmafldTA
         WvSLs6wYjGkIa80ugHSpQ76zA3woekGNk+tYQd+Jqk79zmUBZlBKVTbyHIFg8i3phWcZ
         nL4svxTCuUDYj/62fgJx8qoonYHagG1vWfgvaCseh2SldZh0AlqWlZllmgGW129qCS/7
         T23/Ws12q4Pn5XZ6oBZnerLMiSqWnH318t+Vc03yLUQRQkQKt8P99uKNShbqPcvMuU5A
         Q0kTSItmZc2xqZWx6TPYHc6W6jD4Eex+O3yk3ogaB4l6TCxgRnCYld/ZQlp+2TeY+WQV
         pMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771984389; x=1772589189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RM2zN9RmIf2LWyhacPOeFCgnfc2/rTz6ZpEpYI1sHT8=;
        b=FUZpABJb2qdnRkGpbkR1bDJs3cn+Kg3R5E67LtffEEB+zQzz24+QWffR8PhxZVG4Dv
         Mx9UkbjgBBUkOWz4zEUrInDDG/kEYOYY7YtPuPQWNOULB5wLTg2mZDQMKm8VyXOH9Tit
         big9i33tEUe2UyvbQkffXPkIZVRPlyfcqlEgvil1LP3PN5cKqQJdy1MiGFv7zMgAyaQo
         vKKQmkrO4MkvV+KykpwmZ+PNNpPi07ctp2izhttt1k5GyiS2+fP2hyJ06/7dkDbtOVvl
         IUfbQUCKADWoVVFDIFIVM00rWCLssevQUxO/OVx+NShuEwl2suE68buyKWxAxWRaP6cE
         bVzA==
X-Forwarded-Encrypted: i=1; AJvYcCWtL8L9E5EaIrEh6Q6zpVKRuVng3Lcqj9Y0Uv56e8TVDB4VI8gy6/BIPkyIfb/OcC+O+/9wAPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKV6a6yWNHvI59n6ofs1PnEy4WfrmnNGlEekpb3jVgv3pmQkO
	3d+YhywgxtxdSv4IAm0LdxFUtKOf1KYP+F98NTAOg8dX4tp5AQ+A8BBSDkwM5FYyWO2jDY+lFGA
	gVFQhIa+WZwofCa9ed5FFVYxSL+wew+gUgldPGXYN
X-Gm-Gg: AZuq6aL08OXP7MXpMSFibbHBZ9aYz9iYuxMcugAgXTwRq7oAxD+BD22iGePsf+UEhNq
	koT6S9TyVY6bJMH4we7FC7lGnnh16AFAxXPhOL+HbS1Dsx+giXjqy+StJDYGXDUGi5xhFKlukrq
	v6fGQdOvCwt+TiGag4DYR8caeE0GriLhWu0kcvvTzytbUqUnBEKfXJLQttKlGVLT7F/Pl0dvMli
	+dR7U6CHjfeqPVmBhQdR2LG7JLi2vayrGVW79/Dcynsj+fTbb1rE6zelGAMwdQaQMrANL4h857V
	q+w4GMBqKI201taOK/dZ2KA0q1NQyACeE+3Al1HVGg==
X-Received: by 2002:a05:622a:1ba6:b0:4f1:c6be:c853 with SMTP id
 d75a77b69052e-5073a27842dmr10647161cf.25.1771984388362; Tue, 24 Feb 2026
 17:53:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223153342.892477-1-edumazet@google.com> <20260224174909.59f52345@kernel.org>
In-Reply-To: <20260224174909.59f52345@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Feb 2026 02:52:55 +0100
X-Gm-Features: AaiRm51151WKQ92TFPLi_hKiZgz4jkIqnghV1pK8o8k2Fn170njkUP5pnfhJrT0
Message-ID: <CANn89iLjKzLwPirGBY3SzrC33OioPCrnZMcGuP4PGj7GWp39eA@mail.gmail.com>
Subject: Re: [PATCH net-next] ipv6: move ip6_dst_hoplimit() to net/ipv6/ip6_output.c
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-260714-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6FBAA190C85
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 2:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 23 Feb 2026 15:33:42 +0000 Eric Dumazet wrote:
> > Move ip6_dst_hoplimit() to net/ipv6/ip6_output.c so that compiler
> > can (auto)inline it from ip6_xmit().
> >
> > $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> > add/remove: 0/0 grow/shrink: 1/0 up/down: 47/0 (47)
> > Function                                     old     new   delta
> > ip6_xmit                                    1481    1528     +47
> > Total: Before=3D25076476, After=3D25076523, chg +0.00%
>
> allmodconfig is not happy:
>
> ld.lld: error: undefined symbol: ip6_dst_hoplimit
> >>> referenced by xfrm_output.c:348 (/srv/nipa-poller/net-next/wt-0/build=
_clang/../net/xfrm/xfrm_output.c:348)
> >>>               vmlinux.o:(xfrm_outer_mode_output)
> --

Oh well, this maze of config options...

