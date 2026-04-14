Return-Path: <netdev+bounces-278273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPcoFKCi3Wl8hAkAu9opvQ
	(envelope-from <netdev+bounces-278273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 04:12:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7D3F4EB7
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 04:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 691823028F60
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FED1308F38;
	Tue, 14 Apr 2026 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv+84OCX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979818872A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776132764; cv=pass; b=PiuF+cBdUXvXcMGuJjGgBJL69sapq3MQiiCnqGJGl+sTKpSoM/1OJediVfBdcgfTdNM13u9u3PFzGGeyDuUFav3xXLsv/HOZp2TAVV6bNM70RNJgDYr5e96AMui0qnEPN1JnVxUWI4ALijAPyUxskBkhiq9RHy8pdS5piH5oqQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776132764; c=relaxed/simple;
	bh=uQhJnqXW39QNnTn2yfuaqysKB1o+I1UlAWVvzizO5X4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQarF/j+wyZit/It2D/meBlrt4AV+VmmCDLxcGmOhO6EvIZWKgk1YcOxVHFl59QKORR89ZZBPmQyH0cxOlOcvvIPDqv9Lo/WZiLRyv3m1oAdKrPRWMgBfNyDJaXBhqqk6EeXXZ5mup/+aIDaWvOiJ5/HMMD+r7B9q69xwWdF+r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nv+84OCX; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7947cf097c1so44209907b3.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 19:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776132762; cv=none;
        d=google.com; s=arc-20240605;
        b=WgxHj+kgpyt4JNsBt1aO3IszgB6QxRwvfXOZNVQk+1DQ+JZBiYCWdSuF6sP3/Fjip1
         /BgSg8McVi1UPhoOCGHCXyPK/VPL9J+WpHgN44zkLT4djMIIXs58OFEDHjKpqM9cQ/I9
         gGxpX6gWC6acZPJ22VnPKIr6HC7aBqU2sKlrEvCrIF8rROsYAxyI1hjW5OUJuqbvmL+U
         Gq/ryut5g6/xbiZ9UGK0F/gt1k0XdYqtT5n2pzdCIF70am90AQcOgaxmZJDid8FK0aBn
         241ApxQ8FEopEzvrB4HzZe7f2FZXbPp6PspyPVvbY5R99u/AZ7SQtkkK/IDZEtWWFSQl
         nP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Z7N2pD1e6icI9qoA/6v3VO3cO5yRoS+4/iiWELpFd4=;
        fh=TSWa/m4kyCfsdUwon4c13LRion5NGfQjRewQrze1UNk=;
        b=fbT1Zklm965FnaHcUIHj+Og2QpOKeShLLeyZiwAMfWL6dJK81pXrRYGkzlRlaIkeZu
         R+rTFMIV61KsnXc44oT4ok0eLa5krqiiCgMoV5BUuATVLSlMdQdDPBGoFjOUAo2RmymU
         V+z0GUHTNTT/RlPjnM3if3t06De0vpuZljA31ofDdwuHZ5Jel/O/GcQ7UIgq2k1UcdV4
         VGKonNWogR0uYW/DQcyVqhwFcHDq3bwdS86gLmJIT5UhSQ3t7idckLudJ9/BmuCrPzJB
         YEjIs528j+wkmIsQuDld+0clQaDuhG59EhUlqr1c4HOdr7YOEtv5mjbM7HxQBpBaR8sn
         7KzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776132762; x=1776737562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z7N2pD1e6icI9qoA/6v3VO3cO5yRoS+4/iiWELpFd4=;
        b=nv+84OCXNJiG4BA0KxTnzITCOufooEwxA3jSBexF/vDkW11vG0fK851erkPd6uQUol
         GYlIZBUtbRWxMXzQpqNAPPiNuGWDL4Dk/MSHejQpyK6bf70byZz1LSJG2PgdqLTQp0q5
         0ppUhGAe4mcSXOJQgD+4zE+f1mfF8iloPckE170E52RBceCyDoMAVPo/i8r+N9MMtYYd
         kyPueO7eLH49X5J/06/HL6xjlz/zy5z2lDeVL5fyOSio47efDG99F6hqX5j0SYwbdmtd
         Otw6AyIcTL0pHgBMTPI63gRSWcsPwsSO0ykxU12btgT/O2TEkEscX7kMmv7nTGaNdpP2
         CGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776132762; x=1776737562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Z7N2pD1e6icI9qoA/6v3VO3cO5yRoS+4/iiWELpFd4=;
        b=m0iWrs9bNM4m+Z438bSF4lw0XHZ+5In8Hp9nrFDmnuRdvmUUEo3Hc98tkO+dgBlfXT
         b6rpO8ckQ0tDb7x2Exko0bqqLj8+dihRL2AIXwUwlzPoOzEhd4slIEtUbJ/Exe6QiLfB
         rDInlLNM13ZzA5QmfNdyqEMu/1oL3PvzK15xlZIq4Douv8yMmTEip3961rUdAfKLc9FX
         oqofxXVoPc5zLyqtMQ+nfp/682L9CecOipUgpYUpS2DASHlUS3GnovN8NsvA//tWPUkx
         L1HFzGU3aFFThmTBC8hMMfKchKoZSNIMkEC5BMh7ZEIDabAVwPINWxcZ/8ZJ4Ulh0wNU
         Yrzw==
X-Forwarded-Encrypted: i=1; AFNElJ+JiR2jRhJcv1uAh/gpj+5CXD4uBZy0KDaUnQ0HIzU31PHtTYIIjOnX0cwXgE77AKtH1azeX+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Lm0jXOwaXUFwCRTuPGmvEcu0FDEejqBbWWNkDpd1U20GSilr
	8Oq2XcAS2Nu2eVnnPJetZTKxcM3BvAFGaI92S6BaO09NbUm9u6Auqh+Yw6L0CNPUlKdYLG4OlFs
	gkyWWZMtdebh4SYrZz7VeCb+Yu7qFxy0=
X-Gm-Gg: AeBDievfrAkhp+rRh9jX54HWK9zoRrKZSvgQe5jsdNxgQdjH8aXG4XNFwFP8GGqz/Zn
	blHplT14/NjbupGhDW9dqPBBHIUTUA0JMEgb+QXk2GjYRyXWPEpb1HZOOtnomPB0P7/RgsgbJEX
	QRSJQt4HxKzZoS64yD9RbQOly3qNlOc7jTPMa5u3mRGQIGqkwAQIg01oztOrnV3zAVsWtzOsEFI
	CnDpZsPMNtXXFzCUzqgpWsi5iuOKFekTzMxXP9lUU645oh8aBjK8tco/HQ9OncEcbED40LOYPA8
	dPcUTCl5wCYyMfzrNeyzhofs/cnPGVaw5QXxSft5KFgMXhnbKSGCYdtE1yZB6TfjbW/RZUx0+kP
	bddIYikY=
X-Received: by 2002:a05:690c:388:b0:79c:bb82:612a with SMTP id
 00721157ae682-7af6fcef9a1mr176673497b3.17.1776132762043; Mon, 13 Apr 2026
 19:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412020809.35465-1-kartikey406@gmail.com> <adzwiKOPptwbNp7Y@krikkit>
 <CADhLXY5a7QCdp7NXC07fma905O8YJ4jPcbbdK0=kFgD3d2AF-A@mail.gmail.com> <adz_CeDItDjznfWo@krikkit>
In-Reply-To: <adz_CeDItDjznfWo@krikkit>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 14 Apr 2026 07:42:27 +0530
X-Gm-Features: AQROBzBazy_jkwLewCfLFniWoEnnFgMIhd8gNrC5p6sZXhTMQffMEeAwRm__L2k
Message-ID: <CADhLXY43xGjy5L9qaTKzzvikRJxpef6rxekXHEce2umVuaRksQ@mail.gmail.com>
Subject: Re: [PATCH] xfrm: fix memory leak in xfrm_add_policy()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, leon@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+901d48e0b95aed4a2548@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278273-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,901d48e0b95aed4a2548];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: BFD7D3F4EB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 8:04=E2=80=AFPM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> Ok. Then you should wait 2 weeks until the merge window is over:
> https://lore.kernel.org/netdev/20260412142250.131bf997@kernel.org/
>
> and use "[PATCH ipsec-next]" as prefix for the cleanup patch (+ drop
> the syzbot references).
>

Hi Sabrina,

Thanks for the guidance.  I have submitted patch v3.

Thanks

Deepanshu

