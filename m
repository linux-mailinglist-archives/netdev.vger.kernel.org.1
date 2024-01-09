Return-Path: <netdev+bounces-62716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC113828B61
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 18:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2B5286812
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412133B781;
	Tue,  9 Jan 2024 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezUzPnH/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60338DF8
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cca8eb0509so35311161fa.3
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704822198; x=1705426998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IotU0MI4lJDrjZLxB3p/1CapE1lTVUlFwi/kGmRrNos=;
        b=ezUzPnH/r+YHLFSzhTj4ixGB0J6aagZl2wEkDx/ID1mpJLJVVzB7KehyMsW/JSpltn
         e+QsnpqK9Qa472fkBkRwnvSZQAD9rSlTNUAOq4DzG6DZFZUB3/lzsXVFcYxk/DVTMEYd
         GJFjXUnWhqFBdMFW9boxHTfJXcLkNCUlKUIES2DKt/irtGHpWXN13DQXxw/v5jckETMi
         rN5tqvCg/EoroQxof8rvq+NrIPCwxEgN7LSn0z2uY75et1lRQsOMk3OIHiNsoynYOCoa
         sD8bHDRNfwSXfDbBBMwt/miqeU+BZ5adnVs/JSeTQdUAryx61inlE3ECx3dMii0PZ6IJ
         Sztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704822198; x=1705426998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IotU0MI4lJDrjZLxB3p/1CapE1lTVUlFwi/kGmRrNos=;
        b=Un6ERikhMbDl4sV8UlrOiJIonlAcrhDuThYyr1hpJFkhWHiyg1zEvBPFuhZv6+Y3o0
         RxI1+nD+TXUSnMeTndkdTDhrmI0GRJvV/cuiMqhA2ykS4nU3SMOSZ4+sSwSHQZxOtEHr
         QpeA2Uan/mEFCM7DLtQlw7B6AxpE0N8n/jqHFVs77VkcL5/rzNeu5aH3a/US26BHp3D5
         szB4bOVHBeSbizf85pQVyAp7I76RQEK1GPCPKA8mdwkGvJLPS8eV7uasCC5QKqPEbzZO
         c11fNbZxyeEWXZN7FNuJbg2dqDS/DuFFur2JHCUC93xKohhSg1NVRXquPYOkAsjOlzn8
         rPZw==
X-Gm-Message-State: AOJu0YwhmDO6NkYR0wKUQq5uU1UA56svOLIu5xgsNULbbZ83w3dGGd4T
	KPemQPHI5+Imtw6ZvrZNhnaQ9KxkE54OxYf1vGs=
X-Google-Smtp-Source: AGHT+IFytx7ohPypQ9WJ3pFDYURrTkxhy7fp3TaM8NFRnpJh3GE4jRJgIj7KXHBQvLX6QVTtfzmNn4TLyJI9GPuv6cc=
X-Received: by 2002:a2e:2414:0:b0:2cc:9789:3d4c with SMTP id
 k20-20020a2e2414000000b002cc97893d4cmr2097953ljk.37.1704822196861; Tue, 09
 Jan 2024 09:43:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109164517.3063131-1-kuba@kernel.org> <20240109164517.3063131-4-kuba@kernel.org>
 <58364a9e-a191-4406-a186-ccd698b8df4b@lunn.ch>
In-Reply-To: <58364a9e-a191-4406-a186-ccd698b8df4b@lunn.ch>
From: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Date: Tue, 9 Jan 2024 18:43:04 +0100
Message-ID: <CAHzn2R3ouzpsJySX50bVEdAeJ1g4kg726ztQ+8gFKULfAL335A@mail.gmail.com>
Subject: Re: [PATCH net 3/7] MAINTAINERS: eth: mvneta: move Thomas to CREDITS
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <rmk+kernel@armlinux.org.uk>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

wt., 9 sty 2024 o 17:55 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> Hi Russell
>
> On Tue, Jan 09, 2024 at 08:45:13AM -0800, Jakub Kicinski wrote:
> > Thomas is still active in other bits of the kernel and beyond
> > but not as much on the Marvell Ethernet devices.
> > Our scripts report:
> >
> > Subsystem MARVELL MVNETA ETHERNET DRIVER
> >   Changes 54 / 176 (30%)
> >   (No activity)
> >   Top reviewers:
> >     [12]: hawk@kernel.org
> >     [9]: toke@redhat.com
> >     [9]: john.fastabend@gmail.com
> >   INACTIVE MAINTAINER Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>
>
> >  MARVELL MVNETA ETHERNET DRIVER
> > -M:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> >  L:   netdev@vger.kernel.org
> > -S:   Maintained
> > +S:   Orphan
> >  F:   drivers/net/ethernet/marvell/mvneta.*
>
> Do you want to take over?
>
>         Andrew
>

Albeit not asked, I'll respond. I've worked on neta for years and
still have a HW - if you seek for volunteers, you can count me in :)

Best regards,
Marcin

