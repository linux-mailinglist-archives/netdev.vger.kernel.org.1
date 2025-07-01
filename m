Return-Path: <netdev+bounces-202792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF3BAEF039
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB6E7AB84A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE632153E1;
	Tue,  1 Jul 2025 07:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RPCVe6qW"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB9264628;
	Tue,  1 Jul 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356528; cv=none; b=WopNewf9+6UIKd3UDQdV8qbxvrWZC4le2kEgSzFKMAkSQ6JjE8LLFgdiP/gQJAT9KcGPSTKVwY2jrxEeI4tnPLbv7Sessr5SScZdNBB12M0uyQtHimqO8LmZRGAzXNZOdYWTaeqGl6JABi2xpNUvdN7aCvHlJqdtkkWseai6/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356528; c=relaxed/simple;
	bh=9ec1u3X1hswUlL/D+46m55ZLYNmlwFlrlevyxirbW94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANOKtGVKc9F81SQ3D8QugsZquq3VWPQfUTPKVd+jlroqjRpHP7/2OvV8ytA/9Zhj9JKD0dC8X/FwW9LlFas0WfX86eHTfbaTgx090kGIx+3dnj49ovWbA8TJKmltzgTugHIpWg0Wt6w9zETZdFgYVHJ9eZCTzF4a1LptX97koOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RPCVe6qW; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1751356516;
	bh=kVonl+PK1ESVmG9azZvdAt29T3vBY7t0t1HKeM85rhI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=RPCVe6qWMeh0L1KoCAaUpToeJF73nl/4uaOz8Tesl0qQkVZxkF7smEdDfSJZicN5s
	 fxui5Td9gen7am0Z4N9YAqtA5nGts/xMLZA3Ws5sbXKfXFkKXB6sb0d9HGnL6x9VNJ
	 phgkYjSch/FgCZuJpUk4ufBea22s/ZA7lPoN4Hb0=
X-QQ-mid: esmtpgz11t1751356511t3eee1c54
X-QQ-Originating-IP: uIMIDLdsZ/D1XDMaTtdpyHRjJA4q6V7tfk6huzd3aRk=
Received: from mail-yw1-f174.google.com ( [209.85.128.174])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 01 Jul 2025 15:55:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13363238083336646326
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-710bbd7a9e2so30045547b3.0;
        Tue, 01 Jul 2025 00:55:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0bEt/iv64aiNz+f2jdKskcFb2/32SuqHi5zIgUN0ehYP9MzpFdj49uP1QPf5UEn+4uG793Pka@vger.kernel.org, AJvYcCWTc8nspshMCLgdF7o6ZUYzjq7nZ8VSlMa6oe7DwxOlfoLNrBx+yTEVVjbSoMBEr97pX4YgQOxM2xBpgwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxLDX982cRFLjUyVX8vaGxCrc5VAwOSqB+fWm/JMaomNCjiBT
	pJ2+SXnn+t5yoetWS0soNb/H2kwKJlzBczhsjG0Uzb0y4+vsp93BxfHUa61DMUF3uoFqxZRD+eX
	gOgDo3DdbushoPat7Jf8VqaQaBOwKS7g=
X-Google-Smtp-Source: AGHT+IF/JrE6CmFtz4xVWDk4L0eQar4iOXSbDoU2gCX5TO7LfKfgwY1Hcpg+2UwgYT4HAN5Wey2cPhMzu7MT0Sf0EwM=
X-Received: by 2002:a05:690c:319:b0:712:d824:9202 with SMTP id
 00721157ae682-715171471femr202620807b3.9.1751356508652; Tue, 01 Jul 2025
 00:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9EE5B02BB2EF6895+20250623041104.61044-1-wangyuli@uniontech.com>
 <20250623131141.332c631c@kernel.org> <CAC1kPDMkYdPVy-dG3uv92-JG2Ui8BxRqYt2U86ey7fKuJxBa0w@mail.gmail.com>
In-Reply-To: <CAC1kPDMkYdPVy-dG3uv92-JG2Ui8BxRqYt2U86ey7fKuJxBa0w@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Tue, 1 Jul 2025 15:54:57 +0800
X-Gmail-Original-Message-ID: <0F513DA3FF23E8A1+CAC1kPDNE+io5=KEXZkLq5DOQi2qzBEmgAwOj6x4qvhiNmC1rtQ@mail.gmail.com>
X-Gm-Features: Ac12FXxOBex4Jesig6QUABAVCPRvvFOqEWQBN0RMoBwV77dRdQuVcwEsTNxzev8
Message-ID: <CAC1kPDNE+io5=KEXZkLq5DOQi2qzBEmgAwOj6x4qvhiNmC1rtQ@mail.gmail.com>
Subject: Re: [PATCH] nfp: nfp_alloc_bar: Fix double unlock
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Jakub Kicinski <kuba@kernel.org>, WangYuli <wangyuli@uniontech.com>, louis.peens@corigine.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, viro@zeniv.linux.org.uk, oss-drivers@corigine.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	guanwentao@uniontech.com, niecheng1@uniontech.com, 
	Jun Zhan <zhanjun@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Mtnmbwz1r7Eqqjl1CQl6m32qcgPJFhDXzPap09HT4oh6a0GfGQS9QuZT
	D8Q56fOUGzNceoSYjYYLfA+5NzFTmlCOI7zv+kE29qfBXvB2yMFkZb6E1nrH5AcFHh+Xo8U
	PrWaEKdPgXqtQAuT75YacrRTQ8b7z1rrNVjggNi/VItZjX3fydy5WkKadTfym2Xy4Si50wV
	XxJMbGzZk2PT/kEON8wIlDceyNlaq93c0yuLbUU40yyRPtq3u1L3ed77bdUYaxO6CMAbMBK
	o+yhQmLnpmgdMoOAZqsgBgEllHj2FnsJrKZ7VNDtAputjLasCs1wzWzhv/m8MoLXhwS0Rtn
	9OM0nykb9D3uozgkmt+ZMzHGmTi2nHkrbdp7Q3Ry75WCyN10HbDculP7ypLVv7SEUKwY3oG
	oGnxCiQiZmSGXMNXY9G9lw95Ix8Qa4U1Rxuv6cBprk9uqBF4Q0SkKv5L30J4ieHWQg+2xKE
	o98rBjsF+OrhijPsdcpmObgxssOEslik6Uw+vlqRxq2wmAqb5R43piHH31WyBHL8QURT1Ba
	zlzMDS6rtwY+gPujmvXAAb9JzlwzVTBEMal/KE8o1mcnmqgNOaUdQTjtmpcqWJnoY8D3yQC
	xe8mbgv5Xtbtdbv9/C8t6kRtl25+dR4QxnJU8r4CHeJh5wjV5/FV3Y/17nEFe+UKYHonoll
	53jHkbF9bEuFsuPIEjKVSuB8c4nnKm/an1HBIF8/FvSmj7rF+CJO0kEkKW2K0+7vRhP+EQh
	iNZCh75ccuFmTDS1WpqSv8e7UOxXyohF+cn2NovW+PvwQhlaMmiGn810IiGQ+NxIb6n3Ej4
	dkkXIpD5WA76M3gis1d/MHMdmol2gHGOBXAPS4O7GCNzm5TOmG2PdJ57sElTm3+BkzYxlBx
	BNofIoB+vPY2Lymi/wp0aZ0sBQowpwP9HdTLH9Sub4KB3kSCzUIYLKljDAva05zU1R14E+j
	xdgH9mBP17Req7KEBXXIL1ub3Kya4Vwq5QBFTDkfyjwYg+yO6+ndC22M2o/8rDxE8kIzJ7n
	3D2wjvaQR21a5ass+7pW8l7PHfY9QUol8LaAF4ynwfNftaIRdm4f4tSVsfCt3hWVQS/54zy
	BzVqGZS8aNW3cFO77qvK2jNQJMZ/mJSVPXJWfkwg7XXNNlWEuc+2Lo=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Tue, Jul 1, 2025 at 3:45=E2=80=AFPM Chen Linxuan <chenlinxuan@uniontech.=
com> wrote:
>
> On Tue, Jun 24, 2025 at 4:12=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 23 Jun 2025 12:11:04 +0800 WangYuli wrote:
> > > The lock management in the nfp_alloc_bar function is problematic:
> > >
> > >  *1. The function acquires the lock at the beginning:
> > > spin_lock_irqsave(&nfp->bar_lock, irqflags).
> > >
> > >   2. When barnum < 0 and in non-blocking mode, the code jumps to
> > > the err_nobar label. However, in this non-blocking path, if
> > > barnum < 0, the code releases the lock and calls nfp_wait_for_bar.
> > >
> > >   3. Inside nfp_wait_for_bar, find_unused_bar_and_lock is called,
> > > which holds the lock upon success (indicated by the __release
> > > annotation). Consequently, when nfp_wait_for_bar returns
> > > successfully, the lock is still held.
> > >
> > >   4. But at the err_nobar label, the code always executes
> > > spin_unlock_irqrestore(&nfp->bar_lock, irqflags).
> > >
> > >   5. The problem arises when nfp_wait_for_bar successfully finds a
> > > BAR: the lock is still held, but if a subsequent reconfigure_bar
> > > fails, the code will attempt to unlock it again at err_nobar,
> > > leading to a double unlock.
> >
> > I don't understand what you're trying to say.
> > If you think your analysis is correct please provide a more exact
> > execution path with a code listing.
>
> In nfp_alloc_bar(), if
>
> - find_matching_bar() fails to find a bar
> - find_unused_bar_noblock also fails to find a bar
> - nonblocking =3D=3D false
> - nfp_wait_for_bar returns 0
>
> In this situation, when executing nfp_bar_get(nfp, &nfp->bar[barnum]),
> the code does not hold &nfp->bar_lock.
> We referred to similar logic in other drivers:
> https://elixir.bootlin.com/linux/v6.13/source/sound/usb/line6/driver.c#L5=
65
> It seems that a lock should be acquired here again.

Sorry, I found that find_unused_bar_and_lock already re-locks it. I
didn't notice it before. Please ignore the entire thread.

>
> > --
> > pw-bot: cr
> >
> >

