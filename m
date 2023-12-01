Return-Path: <netdev+bounces-53066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C248012C3
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44FC1B215B7
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E45101E;
	Fri,  1 Dec 2023 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DPIsJR1T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8345D129
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:30:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso2925459a12.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701455438; x=1702060238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cv2Uee2oIziALezonnt1Q9SYpgaVQLza5Azfx+pJao=;
        b=DPIsJR1TxC9i/XKb5UNCALzuewCVdiNO0BAxxBk8zAb2wUfLfUGLu6vk02sF5NBGT7
         hVTQVUZZaetlZEaCkTRg1ln/Xk9FHdJfr39K0TWamJloEBu/5yoaa1M7v90Fl+nS3HjA
         eKdbLG2geqq40z6qCpo+zNbFGfHcrs3C1BjIyZ1r842LkwAts7tcG8XEIsQU8KeuU9TA
         rtYtC29Ou457Yh5Biux9LgH2kwva58bPbwDDskuCqN3eBhsDQVnuT4N9XpuZi4eaqyXn
         YPMobU3dhwacS6RLputzP7GjhJQH08LlUc8+1RvecLdQOJY5JAMZNNsB8lqbI9HmuMcT
         xc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455438; x=1702060238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cv2Uee2oIziALezonnt1Q9SYpgaVQLza5Azfx+pJao=;
        b=f0Rw4+4Tyb+y1UDBme/e6Qd5LNgFVqwaKjfslX+1Kq3GvZJBsLkfF9CPEnQNWbCt2T
         mRB1tXzJbRmC5QEgjiNWzkSBxlfRNruUF405nM4hpE/KTXjbY58QtWnpbBPTIYE8JDAY
         WigusKSpeQoWu1ocF7AsrvPgYMw3wlUa1el3L6uKoLIjrSE7MTohkWhXRCR1E7w/vhpV
         kEMj2B0Q5aFyHnXJfW66b7RmNqfEABnH68mhkphX7U3neMXtJW+BfS3NgCfWA/8s0ARr
         taRkPxrsrab58tFE9irMllp1JvoKOsQCXrhKBOVZNR1/xiVPBWlbf63s7Zeqsx/yZWZt
         OcCQ==
X-Gm-Message-State: AOJu0Yxx+96QgdY2XYb+bbdYYh3D0opH3WcOxCUtuj4SZqhrIXG7yoKU
	Vdkg9WzFI0V9C0rZYWbtiTWpA9cVahi+/JvgHXGUjw==
X-Google-Smtp-Source: AGHT+IGWSDZTLPUhUxs9cJ/sDJr5Poc0NUX2A6DsxCgLTqdYrxJewgcmhq31tvPFbnQaRKG9qX3tYM7yIjoPY8ai5eU=
X-Received: by 2002:a17:906:c9c2:b0:a19:a19b:c704 with SMTP id
 hk2-20020a170906c9c200b00a19a19bc704mr883176ejb.84.1701455437997; Fri, 01 Dec
 2023 10:30:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZWobMUp22oTpP3FW@debian.debian> <CANn89iLLnXVBvajLA-FLwBSN4uRNZKJYAvwvKEymGsvOQQJs1A@mail.gmail.com>
 <CAO3-Pbq04ZphnB42bSoVDc8sgQ+GbRaqPtXOscsSMC5tXm8UdA@mail.gmail.com>
In-Reply-To: <CAO3-Pbq04ZphnB42bSoVDc8sgQ+GbRaqPtXOscsSMC5tXm8UdA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 1 Dec 2023 12:30:27 -0600
Message-ID: <CAO3-PbqD5Fpf9ddYFt4OvaT-4fq505X9LfBK0oKareJB+z65gw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] packet: add a generic drop reason for receive
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 12:19=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> On Fri, Dec 1, 2023 at 11:51=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > >         bool is_drop_n_account =3D false;
> >
> > Why keeping is_drop_n_account  then ?
>
> Good catch, thanks! Will send a v3 to fix up.
> Meanwhile, I noticed it is compiled with the
> -Wno-unused-but-set-variable flag, is there a reason why we disable
> this warning?

I found the answer in scripts/Makefile.extrawarn. Good to learn how this wo=
rks!

>
> Yan

