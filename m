Return-Path: <netdev+bounces-42787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B77D025C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739C61C20ABD
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE1638DF7;
	Thu, 19 Oct 2023 19:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gjSoU+ev"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E932C64
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 19:19:08 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C6CF
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:19:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so2924a12.0
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697743145; x=1698347945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M35J9+mo8ViD6zKG+gflflxQQXEv/0GdI1T1iOOJTE=;
        b=gjSoU+evaiUzpTGvnxpznsAHhZSGNKIRstHHRgiaegwZpmD4MXXzFVRPhqifBiMQGY
         Gx60t3Dj686Aee2bbzNTSoeGSbi1QpOXuflRHtcuq/WtToEoeoWp2aou0tcz1g6JDuhW
         qx6G9AW7HyELA++Jq3mGxNRW/sQWMTxsc3RKpyNPfAB+b4rVApK7yKleYmxvWpYdfWVj
         w61gxgcfPYQE25ObnKK7NedvTouR9q4WOpgwh5V/nWvWDb3t6WGo6eADSOZjYecXyPyh
         Q1zMSZ/CUXo16oXGNRbEZ/NKX5atc60UqMgeKs11x8KZbdPYiCH7CLfMoCDf9wk64KbZ
         Q9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697743145; x=1698347945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9M35J9+mo8ViD6zKG+gflflxQQXEv/0GdI1T1iOOJTE=;
        b=Shz6zp1PWbkaTglmhuF625aoSNdOWMsYBpbWEK5ZlVklxLmvgES9uwzLeoUIBq5qgd
         npoZplMnuVoRdKpr4FvVzTfsdPfcoQ0LiHA+GbX7RncRQtsOJkqGYe7CYe4yubikf6Gl
         ctookBAkclJAq+T/Q0dMZzrnYam+SHdq9tR4KKqvmSaNJCd3YfdW6XGcB/ycqj5VYcpU
         OZtNXR3ENXrViFfS12tcl25Fw5Bmox9fmc2WmCa1zI8hbjePWeesgKrrkuI9rvo5vJnW
         N0BxqIDgu+0OuIzboY24WLBgjIv2GKxsDz4C3q1iyeb0hNGLVZsK3cvwCExuPLwyh2BW
         xuCw==
X-Gm-Message-State: AOJu0YwSvkMn3Vxc0E7uaHkfrRx9s0Dri8UvRavGVBLqpVt0EudHzbrE
	EGVeIVEgGEPFhE+am9smvev0ruYsI5bGmG2mlRNrfQ==
X-Google-Smtp-Source: AGHT+IFXFdfD0xBHa+nA4KMhSQ3qBrEe/0ONa6Aus0g6tpGDfwdelBbkMbYa4zIHLyAMr+YfiWHKEQIVe7lTTOlILxA=
X-Received: by 2002:a50:950d:0:b0:52e:f99a:b5f8 with SMTP id
 u13-20020a50950d000000b0052ef99ab5f8mr11321eda.7.1697743145068; Thu, 19 Oct
 2023 12:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019112457.1190114-1-edumazet@google.com> <CALvZod4PiVHUvsWuLcv=1r9HWGj+my49Xy676AMG4=qFZbcfSw@mail.gmail.com>
 <CAAvCjhhPYeAVzisrjWJ052USt-7LtADAYQbH6QoGyisLnWJX9g@mail.gmail.com>
In-Reply-To: <CAAvCjhhPYeAVzisrjWJ052USt-7LtADAYQbH6QoGyisLnWJX9g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 19 Oct 2023 21:18:51 +0200
Message-ID: <CANn89iK4xS=Z7k7zH=ZyVjbFstkJ+b_cqTex9h2o===zwR1tPg@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: do not leave an empty skb in write queue
To: Dmitry Kravkov <dmitryk@qwilt.com>
Cc: Shakeel Butt <shakeelb@google.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 9:14=E2=80=AFPM Dmitry Kravkov <dmitryk@qwilt.com> =
wrote:
>
> On Thu, Oct 19, 2023 at 9:01=E2=80=AFPM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > +Abel Wu
> >
> > On Thu, Oct 19, 2023 at 4:24=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > Under memory stress conditions, tcp_sendmsg_locked()
> > > might call sk_stream_wait_memory(), thus releasing the socket lock.
> > >
> > > If a fresh skb has been allocated prior to this,
> > > we should not leave it in the write queue otherwise
> > > tcp_write_xmit() could panic.
>
> Eric, do you have a panic trace accidentally? Thanks

I have no panic yet. It would be a bit tricky to trigger I think,
but a bit of clever fault injection could do this.

