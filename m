Return-Path: <netdev+bounces-261024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DFgFqokn2mPZAQAu9opvQ
	(envelope-from <netdev+bounces-261024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:34:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B062019ABAF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 17:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B496430B9FB9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856B3D6463;
	Wed, 25 Feb 2026 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0N0xAhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2F3D411D
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772037050; cv=pass; b=bU+UdNeCUH8xccpnzOKPeFFraXM++WNbdlRR0v9O8Ysxi2/YQIOfyujXod9JQrawuLoCvJuMvJIp4TrqB26LP3w/LsMqOMkTlytYbF8TrV5YyQFj7wQOtk4qBH+292ZEZH13so53KPIzW4fSpuBmNWg7OXxfVN5c5lCaTl/NhIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772037050; c=relaxed/simple;
	bh=3BhgU4L3d3Mb8w3H8cisiauldWjQo/B5P7z5b8+Wfic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd0XfGnxyhrj+Pk3vu4hzxV/ESJAC6KePWwIrkZWOhROJTQWCoB94cW/lvkJXYLOMHEj9FVAj5Wzw8lxYOLQ1T6vu7mCbd7QpjZthZG6Xb+cIJJp5lDQPiNfueQQk23DSCufVyKpXomZweLNgTviIItrWGdaVRhFaifa/7bR3Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0N0xAhf; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94d5f90c8b6so3536740241.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 08:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772037049; cv=none;
        d=google.com; s=arc-20240605;
        b=CQr88cHol6f7S0bmjH0I2izYDk3HdkHI50FKX0DwA98UGKYtLqH+wDXHwIxyS6uidY
         PSWc8J6eXF4XoXqAjhtiCZVVfX6iHimZFdpydWV8S4wFyGRiv2mAfQTgdF4xoKp+JyFH
         FE92T4TGZIOuOX2z/jJ29ynBxd4i+iWkFpvX8NdrzggQKeFqYMsoLKnRsscMlDfPsp64
         G+RdUwrGPikRpMW7Z268cuCNoMBBtiDq9E7r+mnf1ifvDMP30/HwxEfUCVpVz94SKmCR
         h5kwtD7KHB4+d12PxZyT3WgPILWSt5PRaZQmKU+/Yo7aBwAGnsQNm5Q7Erc3gsPDomGe
         0nDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Qe49zfHddE2+m1iZCaiKwJBGnyC6CtAngtZaCegJb0=;
        fh=ZdgLj7trqbkgjai7XR0S3wNsvNInt8SRkFMuQHTjKcU=;
        b=YvrTM0glNSEgGEfoOpuJQCI7JHGAQgr1GRe/UUJUgYpuE05bJg2sWnpIYgCafn1avy
         HzVI9OkOM8sN8GGEzKt5zohqeNf3rbjzSbErRneZ/Z6NotrwyOQ2JRjgT0thP2VzRsiv
         5Nxd8PZfb0cs59gAohGJc97HJz2YHkt7fm4Tfgd922z6HGgJMnkAjoThIsL2L7W7Ftgw
         uF2Plsrzaig4P85GlhxUsEo/Y2E7Yar/2c8AZZsad97CPk//rAWaHrOdCfz2ku9glLHd
         Feyo/63IXKQgQ7GnQbeKdidRkyzX28tGQZmNc49sJDXwfVuxC5m/Ni8KGSU5eZhacig+
         nzRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772037049; x=1772641849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qe49zfHddE2+m1iZCaiKwJBGnyC6CtAngtZaCegJb0=;
        b=A0N0xAhfN/PLdjok9F1h3RI1kazjXPFQnYhC+Q6pCkf8srnz1ufB2obc1gM1/N5xX1
         YTP9xvvIDrR5ajF67csTKGjc/qofn3SQaOH0xEdZhPpuIU3g8qWPkSJfTwXlRdi1cJ2X
         +LRmU8r9L4qYGVuw0inSkgiDOh72p+yVKpBq5jGsBPl85YniA14QdYFvLTT6YFwtghqj
         DJWzffXA71vm7bTRHZ2vEAJVcGOkVIdvQ8XAukAY18l3bnJuxvv7bMGfCUR85+/V3zkF
         DzVcJxEqkIbWE2ar1B+8VR+O+DCmCtEV0GQ1YqXY+1ZOnbbxVWTmNCFzrQtbv2JtzMYi
         14BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772037049; x=1772641849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Qe49zfHddE2+m1iZCaiKwJBGnyC6CtAngtZaCegJb0=;
        b=ogb7PLtd5cDcryvd8nIGLTUGkTLPFGuk0sqQ7tVpeI9Vext/6BJeiB4ckH9JMHzquE
         Cw5zHiXxuP6KvVMIKMRcvi6Yt5io78h53QoLDTrZ3x1KmtjFV22vlCFUCHtLdhF5v2l8
         CstfDD3uakJ3JXkkBt5JqsHNg+efgE7VLFSGD9Gy4RTxf811FOo5q0FABn94dEhZFg4H
         SJMjanyVnucfPgKiPjp6x6I7F5ek8UmE0hH2++1eTAeX5ul6IEfaxfKih0ezU8YVmDHr
         rPZUeThKOqWKQjnPFTT9hSB3L2WIi+ttNuZnxB8lxE1nyEznvdoc+rhUXfBiLsfASQ9D
         mstg==
X-Forwarded-Encrypted: i=1; AJvYcCXEFATb3kYoINai3UED0XSo758sjVTBSszkaweo5GI7W3bITZhETZJehlnzZwpQPwyR6fm9cn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKvK5Wc361GmRlCcVvqXXmqX19FCOwBqlAmdTXDhPK3iT49oU/
	zcX+b1BSCW0UD8o4k2qJOZVMeeucTYdI5fZi6Du3Gta0hqKeOCxPj3T+XASEfmGjoW7ZQhStAmy
	s6qOUHQXlF9Xwthv6f3S9A0HRC6VNP/A=
X-Gm-Gg: ATEYQzw2q5HOvi9iGHzhwEqP9DaAn2q/+KE/pmILZg6+4HBji7L645HzhSmY1/zLH2f
	9L5eoJnWcgoVG7dIHI/axk23GipxHGR2xcZcedv/b1npm8JSwO+vFE+R1OeiS9qR3Z/TQaIflDm
	7MMQfeRkdBWDXbe8YWbY55YmQNEuMhXcxjL2WnDId59v5WcvFI7ech5uHNYWgPDyctesxgXHnJ6
	YNUtob0GIu7/zni/Yrn2FRANpp1Fher9wPavEw5DkyWqd0JelhdrzXkyR3bliiYKdnhYnpybUAA
	mcwCgxXk
X-Received: by 2002:a05:6102:3585:b0:5f5:3c00:1813 with SMTP id
 ada2fe7eead31-5feb2ea36cemr8990942137.1.1772037048458; Wed, 25 Feb 2026
 08:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224165435.17648-1-seanwascoding@gmail.com>
 <20260224165435.17648-2-seanwascoding@gmail.com> <55375148-e26f-4d62-8690-c0eae8bb1b39@lunn.ch>
In-Reply-To: <55375148-e26f-4d62-8690-c0eae8bb1b39@lunn.ch>
From: Sean Chang <seanwascoding@gmail.com>
Date: Thu, 26 Feb 2026 00:30:35 +0800
X-Gm-Features: AaiRm51wqt_5ZFcIrlM0pn3TUxq4cQLSELEgu3f2TttRboIi-k-mxs5UMSzZWzQ
Message-ID: <CAAb=EJXj+tsFp+Pm3sOY97YaGBBazWYmfi4j5R-F1+rw9P-+1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] nfs: fix unused variable warning when
 CONFIG_SUNRPC_DEBUG is disabled
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261024-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,lunn.ch:email]
X-Rspamd-Queue-Id: B062019ABAF
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 1:54=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilela=
yout/flexfilelayout.c
> > index 9056f05a67dc..de9e8bad6af2 100644
> > --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> > +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> > @@ -1502,7 +1502,7 @@ static void ff_layout_io_track_ds_error(struct pn=
fs_layout_segment *lseg,
> >  {
> >       struct nfs4_ff_layout_mirror *mirror;
> >       u32 status =3D *op_status;
> > -     int err;
> > +     int err __maybe_unused;
>
> Sorry, but this is ugly. There must be a better way to fix this.
>
> Maybe look at no_printk().
>
> https://elixir.bootlin.com/linux/v6.19.3/source/drivers/video/fbdev/core/=
fbmon.c#L50
>
> #ifdef DEBUG
> #define DPRINTK(fmt, args...) printk(fmt,## args)
> #else
> #define DPRINTK(fmt, args...) no_printk(fmt, ##args)
> #endif
>

You are absolutely right, adding __maybe_unused to every
variable is indeed ugly and repetitive. I investigated the suggestion
of using no_printk(). It provides the same dummy-function
behavior while allowing the compiler to perform type checking
on the arguments. This effectively silences the -Wunused-variable
warnings without generating any machine code.

I propose modifying include/linux/sunrpc/debug.h to update the
stubs for dfprintk and dfprintk_rcu when CONFIG_SUNRPC_DEBUG
is disabled:
- # define dfprintk(fac, fmt, ...)      do {} while (0)
- # define dfprintk_rcu(fac, fmt, ...)  do {} while (0)
+ # define dfprintk(fac, fmt, ...)      no_printk(fmt, ##__VA_ARGS__)
+ # define dfprintk_rcu(fac, fmt, ...)  no_printk(fmt, ##__VA_ARGS__)

Best regards,
Sean

