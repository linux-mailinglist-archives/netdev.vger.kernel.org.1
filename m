Return-Path: <netdev+bounces-39181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C61D7BE45F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC617281A9D
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B14C358A6;
	Mon,  9 Oct 2023 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liiarnDT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA1358AA;
	Mon,  9 Oct 2023 15:16:14 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0841705;
	Mon,  9 Oct 2023 08:15:56 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so358182276.2;
        Mon, 09 Oct 2023 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696864555; x=1697469355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNfa9ngWsoUr5JXXkiZZBItRB2muHYsooM4F1rWOsy0=;
        b=liiarnDTDedVZ2b2Ca3c9B5ElDpfHkRsoVUKFHwC5tZDk9BNsFDtRuUEKPpBuD9O12
         vZ+9aOQkwnLKZxUeGi49DJQWLVxt7cYeFwheSsHfiGbvLqC0WkChdNLSfZ8OW7IXMo5i
         0QSM17ARiS3l5NioiQjZM0TjcQtAUPzQY9HWWqTzp2B9Uvj3d4rJ8W+xnvv0gN++ELXk
         RwYE/TJ2zk2FhdHSMQLldk1/eBL0LjLFLyXdn3qXq6RYh57rpN+Xelxry2h6jSnXilRl
         n3y2wV8EG4GWsXpkPH40h4FxBMscvjiOe1B0aNHScQWtgEGRByGSbhiNqFUkyJQNboGw
         GjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864555; x=1697469355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNfa9ngWsoUr5JXXkiZZBItRB2muHYsooM4F1rWOsy0=;
        b=e9/M6lTFrWc5q+J8pLobQouApSbJbbC4YZnrWcmJKgOfjgBBZ4XsuIdsH1lDm4VIrM
         SXQRLGPibjYu1JJ51y76LOKL6v3ej1pomnDulei1N/SMnyicU/mrAM0dcQoRVccaIzNu
         bpeNJEeWBmjje0xnbCsV4+8z9E2CyZhtBtFhLwnEqspoQtFQR3WJvdC9yinpNqwFSas4
         /0Ak8N0TRpyg47ldLdWC020skgg2LXS4b+40ClkeiAH6mVt5mpFV9mWN0q2AwEcqGAHy
         NVls44msc5V2OMREsg+LdcD59HeCH0B0cPvsjpxlk3D/+61E8EkayJXJmcitgzr5B5QO
         X7pQ==
X-Gm-Message-State: AOJu0YwbX7oyB8oAvWjfxaggdpFYGaOrpa+K7dcezdWNEDYM5xA4X4CR
	9CJb4mVDyOYvPczodTjlR8WjkFUKXfgFmkkJZl0=
X-Google-Smtp-Source: AGHT+IHqaZGiB8Pe6bUZvB9TVUBJUwoTZcMdDmuLOwflXkLXcqd8QQcApG0OKNhOKfJjLO4KFhgSGmM9d7UHZrqgIgE=
X-Received: by 2002:a25:d84d:0:b0:d85:e4c4:4778 with SMTP id
 p74-20020a25d84d000000b00d85e4c44778mr14993484ybg.0.1696864555358; Mon, 09
 Oct 2023 08:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch> <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
 <2023100916-crushing-sprawl-30a4@gregkh> <CANiq72nfN2e8oWtFDQ1ey0CJaTZ+W=g10k5YKukaWqckxH7Rmg@mail.gmail.com>
 <2023100907-liable-uplifted-568d@gregkh> <CANiq72=A_HMc3nwxk-EGzuDGRBSCfdzKGj=M-snbd8cidQLfuQ@mail.gmail.com>
 <2023100926-polygon-robin-8327@gregkh>
In-Reply-To: <2023100926-polygon-robin-8327@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 17:15:44 +0200
Message-ID: <CANiq72ncF-EzRGNDPQAkwFNkYHdWb9FLMLbGnKx=PkghbPvcaw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	Andrea Righi <andrea.righi@canonical.com>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> Is anyone working on the needed compiler changes for this to work
> properly on x86?

I don't know, I will ask.

Cheers,
Miguel

