Return-Path: <netdev+bounces-52289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B87FE277
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8637A2827C5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554D4CB5F;
	Wed, 29 Nov 2023 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAR4ren9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBC91715
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:51:40 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5cc7966e731so2552287b3.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701294699; x=1701899499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lViBR9SpWA82qIoSo5wrTmkmUZwdD0BgQqwC/RxmSbw=;
        b=nAR4ren9SEN/Tj8nH/CI3otVqkWNZrgG8Jz9qJnOFbbiXIjnKPucN0MK9phtqIzPCd
         kSS3P80EXw4pOmC2mcr4/I//bQY4GbCmTsrCDxTocGFk7r2PjrCyInb0g/4o9KhyZSpD
         LEH/nY4VSm2iw4Im4bm4dAmpeBOp3hMKS5MDBQ/7oKBSxLHShG4OdIE440lKhA1kROH9
         GNxWjEdpwLDxlAMlecrB/HGoeR73YIyyDgdjyoMVB1D8+16pKkSi9G3PTITrJuAKVi1a
         IZCExXLZBoJyA6ohEUP5U5XTO/YVRuF2CqPqmdEzOsaI7CyivbRtBsenAwdbnH4v6qkt
         29bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294699; x=1701899499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lViBR9SpWA82qIoSo5wrTmkmUZwdD0BgQqwC/RxmSbw=;
        b=ZSsnwwX16HrkdC5pSe4/ZCX5MKHGT3abGmEoRVPmoGLDYsfUEV3SFLYUz2Qnas9e2j
         mtVKaabQoAxeEKG9/kxt9At3nyrWTBXneAipoTVsJw2meutpsiTohOAcL3FIv9mvlRdu
         dka28212b9vk00x8kksx4V/3BxxZBzZiL7EBTQd/PAFP+Obkf1wNiRDT/wu/YsIyEr8L
         NKEbFdLojiUtZdmr0yzCUjJyl98taPc/ywIUkyWVW7Gq9N8+6I/WsKzQt3y1cXZ8Plw7
         m8prxzaGwvyjVKamGbW1oDAjHIItdE+xJL+9ZeUC3o9hU6HLGWQo4PqePqR8OK1VgKc0
         SGBw==
X-Gm-Message-State: AOJu0YxHvCaIZ2Q9PlDl3ZbV/vUVgwRMGJPdQRXmDrzssY1v9yGeUM3R
	6PtC2XHirhLbFt8T486knpOJ0CzeyNGYg0KtNfHmtg==
X-Google-Smtp-Source: AGHT+IEIbmoSawM99+3QnIlJ81XcfXhVpZ/Yo54gbvbmM7iKKAoz6wkOAR1lb8KyMxPsuZXW1XmZ9BJd1gCnWVlPyuU=
X-Received: by 2002:a05:690c:3387:b0:5d0:1a82:9212 with SMTP id
 fl7-20020a05690c338700b005d01a829212mr13278372ywb.14.1701294699564; Wed, 29
 Nov 2023 13:51:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128232135.358638-1-andrew@lunn.ch>
In-Reply-To: <20231128232135.358638-1-andrew@lunn.ch>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Nov 2023 22:51:26 +0100
Message-ID: <CACRpkdZCbT69zMYtBxeLrJvie5XxX99F_wMs974BzFTRmXFZ=Q@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 0/8] DSA LED infrastructure, mv88e6xxx and QCA8K
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 12:21=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:

> Linus, can you rework your code into this for offloading blinking ?
> And test with ports 5 & 6.

I see Vladimir wants some reworking of it into a stand-alone library,
so I will wait a while until it he seems happy, then I will surely do this =
:)

Yours,
Linus Walleij

