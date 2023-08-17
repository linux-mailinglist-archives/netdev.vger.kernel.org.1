Return-Path: <netdev+bounces-28558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D0C77FD0C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905BA1C21445
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BAF171B9;
	Thu, 17 Aug 2023 17:33:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D1113AEE;
	Thu, 17 Aug 2023 17:33:05 +0000 (UTC)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E08E210D;
	Thu, 17 Aug 2023 10:33:03 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d66f105634eso95219276.1;
        Thu, 17 Aug 2023 10:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692293583; x=1692898383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p10Nsn3UUYujdaLPfWNIgLTSpN0yddWofKJcx823OWE=;
        b=nNRbqn1Ejrt8n+5/QMN1sTX3sfbpn4Q+ZYi3x2mtDhr2CIvSrHqrg6AtyEZene+thU
         bteUIhyyRVAUN8lrP0jZziVbksniAAvxHGl7YVAFvo7qZFo+gpHtSJ0wJB6hcoCjjv04
         yzBLjiKiJeM0bc9ExPanYN6jKUE+P/JGlk4p0s0Sw551iJdJ5tuU1+2cLkMnAztqVhOV
         g2mceooq+CFC618VIsUABsxUupz3BebZfZEkZDnMIJo5kXDWbjwF5rFn+lM4FVnZl4zF
         CGPtVvBVq00EN/aTKFld/SY9sh3s+fuebcU1apzxOhq/wYFiZO4xHImJ97MWKUiRytlB
         vwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692293583; x=1692898383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p10Nsn3UUYujdaLPfWNIgLTSpN0yddWofKJcx823OWE=;
        b=evkO2GvCOMBl7H01qhJOcnvUsJAyoHYjeI845soIDRzjctngMFx7kr7aqmYpBaN1Ct
         V6VGIUqf2s2mD+AB1VBsqU4XP2Mo9enQzSPFlGAlRj8MvRJOSThnaxAJ7rli/gbVUH1O
         LBBp5o9OjFSrmqKwQBfMcnjTTMe32JUD5jmcb2ycz8dImBGZsiL0eVNeQlkVNFtbUl03
         bOd19Wf0yuS3oRGiPpHXJ3LhV5NTFj2nzcnngLwsSpu764bxtgkG2rdwjA/tBrvcdpfY
         eNb6aSgIt7BzMAmmNlrpqn5N+cFb+tewEnF3AIBdJm6W1xTL1zLbeHhZhvdfwFPat9yo
         m3IQ==
X-Gm-Message-State: AOJu0Yx8oFgF75ARTxRCJDDpaUOepjI94WFXgyWPxLeLi+fesnmV9586
	QdQyaTElbTlZdbAUUUILfTBvpHy7WL19m4Hr/3s=
X-Google-Smtp-Source: AGHT+IFe+BIU9PEPLSkSj/B85mjLNLWYbhPPrpuD4UDLZFT1jM5uy04aCvzKUcnYdCVFPINeX+rNOMZSn0u0PgfyqIo=
X-Received: by 2002:a25:ca54:0:b0:d71:8813:1e72 with SMTP id
 a81-20020a25ca54000000b00d7188131e72mr233379ybg.46.1692293582793; Thu, 17 Aug
 2023 10:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814092302.1903203-1-dallerivemichele@gmail.com>
 <2023081411-apache-tubeless-7bb3@gregkh> <0e91e3be-abbb-4bf7-be05-ba75c7522736@lunn.ch>
 <CACETy0=V9B8UOCi+BKfyrX06ca=WvC0Gvo_ouR=DjX=_-jhAwg@mail.gmail.com>
 <e3b4164a-5392-4209-99e5-560bf96df1df@lunn.ch> <CACETy0n0217=JOnHUWvxM_npDrdg4U=nzGYKqYbGFsvspjP6gg@mail.gmail.com>
 <20230817084848.4871fc23@kernel.org>
In-Reply-To: <20230817084848.4871fc23@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Aug 2023 19:32:51 +0200
Message-ID: <CANiq72nfAxDzsF6-k3016Gt=ngM4n0W-vgXUi-pacKLMXhjP2A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Rust Socket abstractions
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michele Dalle Rive <dallerivemichele@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Davide Rovelli <davide.rovelli@usi.ch>, rust-for-linux@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 5:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is a bit concerning. You can white out Rust in that and plonk in
> some corporate backed project people tried to cram into the kernel
> without understanding the community aspects. I'm not saying it's
> the same but the tone reads the same.
>
> "The `net` subsystem" have given "the RustForLinux community" clear
> guidance on what a good integration starting point is. And now someone
> else from Rust comes in and talk about supporting OOT modules.
>
> I thought the Rust was just shaking up the languages we use, not the
> fundamentals on how this project operates :|

I am not sure what you mean by "from Rust", but to clarify, Rust for
Linux's focus has never been out-of-tree modules.

In fact, the whole effort since the beginning has been about adding
support for Rust in-tree, unlike other projects that e.g. linked
`rustc`-built object files into an out-of-tree kernel module. We have
also been advising interested parties/newcomers on kernel guidelines
etc.

And, of course, the Rust subsystem is definitely not trying to change
any fundamentals. If it looks like so, then please note that, like any
other subsystem, we may have patch submitters coming from different
backgrounds and not part of the Rust subsystem team.

Cheers,
Miguel

