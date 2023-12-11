Return-Path: <netdev+bounces-56138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2B80DF6C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FD91C2146C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5285C5674A;
	Mon, 11 Dec 2023 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zgq3VvaK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02046D2;
	Mon, 11 Dec 2023 15:23:00 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d9fa8f6535so1327432a34.0;
        Mon, 11 Dec 2023 15:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702336979; x=1702941779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBc3RVMEdIV+PcybiPyI6RRAR6wYLfXV8lTtKJEw3y4=;
        b=Zgq3VvaKPcBE4oT6WtEQq1UCBvuGTxPBgPYOjscwcLD5LmhlRtSrJVDtYYVw9w3MWf
         bD3pvVe9GerwdD8pV8BrkJJ+AI3MIV9HhITHeUzfzXDXu3rD7mi2LBKlPmUDlHcs4kKc
         /z5OwzvCVM6mQxJ0551a//sey5tMrIJiFNcbYOxvCYAVt1FFQf57I9xQQaHcSXUArXY4
         Y7KggPOH3Mj5qeHk77p9zvUQcs3/jLRCIumjfIBE+jdeK/KDV77KlEiNVBFehQJc+THN
         xwFGYRl0rnKvFGF5iPAirCDpB763VSyErdliDW+uA61bql6w6ruKBxjQdPpHv62Zzh/3
         9Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702336979; x=1702941779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBc3RVMEdIV+PcybiPyI6RRAR6wYLfXV8lTtKJEw3y4=;
        b=MbZwjedusbYIjzpPaWm5ZInHbmFz1sPhAHkjj7/BvcFEFEct4VyHv6HFjwFE9XTYUb
         MIJfd//A7A8qiw5UguEGdC3i9a1ILJ5QKR6NxVUsDSf6R+SrKSgRAeyxs2W+KbX4fXYc
         JBGj52qMUlvOcH6HmJa4qp9SJ/CqOdHq2AdHWNPH5z7iYRsnDT76ad6wk+PCYNM+tzId
         SiSjvNa5EgE+3Q01VmvZvsBo2s7JjGadoym+iYyO+iDNeEyQG0AwL3+S96Q/mSFop7Ng
         DetJ3Kou/kZ3ulssA59/RGJAqTcZhpJrgD/CaKS31IUHVObC41vJJynYH/vkl8qVrJCq
         JFaQ==
X-Gm-Message-State: AOJu0Yxy2Gm9ekmWdkDia7FBoxb6C3zm5HRUfXXuA+1tawL4lT3fpbda
	YTKBM+Gq8kI8cOBNNyHyFl0=
X-Google-Smtp-Source: AGHT+IEQZlmCz43qg4ru6VmokJLzle7IU1Z6nd9cFUL/38Wa4PsIMrBGKY1l9OlBOeW2xr4jrMHbvg==
X-Received: by 2002:a9d:6492:0:b0:6da:1b80:7e25 with SMTP id g18-20020a9d6492000000b006da1b807e25mr1532989otl.73.1702336979290;
        Mon, 11 Dec 2023 15:22:59 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id bk40-20020a05620a1a2800b0077da8c0936asm3277617qkb.107.2023.12.11.15.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:22:59 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 7D02327C005B;
	Mon, 11 Dec 2023 18:22:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 18:22:58 -0500
X-ME-Sender: <xms:0pl3ZTUEJSlfeuB_zSL4cK-Qhck1r1HLQpWWPryCJJiiMjuz7nBPUA>
    <xme:0pl3ZbmEXOXgXDLFjm2gB60hEAE4ZtJc-lVuDcdWP0qasvaz6AK0GTJtGJTLZgiNg
    F8V6VZcHrx-mAKGTA>
X-ME-Received: <xmr:0pl3ZfYQj4fFP5l40RE1GB971j22G1iuy3QnmcUYrVDgxFHLq7g_yluzC1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:0pl3ZeWo0nzoAUN3DbMxCZfvfRmmVHdJ4KEn__31QUekvSa6n0GDng>
    <xmx:0pl3Zdlrz-6raDZMgwDy0Jf2F1rboM7ROzpOw1ETnWlCT_N0T9pP1g>
    <xmx:0pl3Zbd9KCRxY59y-csrmFnMrbw3Jg8cef4Ad_T0Atd7rvWa46GwYw>
    <xmx:0pl3ZejMp9tNFggJkBN5tmbd6dH7FSo87DgU7kZisYG1rWed66d14g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 18:22:57 -0500 (EST)
Date: Mon, 11 Dec 2023 15:22:54 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <alice@ryhl.io>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [net-next PATCH] rust: net: phy: Correct the safety comment for
 impl Sync
Message-ID: <ZXeZzvMszYo6ow-q@boqun-archlinux>
References: <20231210234924.1453917-2-fujita.tomonori@gmail.com>
 <20231211194909.588574-1-boqun.feng@gmail.com>
 <c833e8c5-0787-45e6-a069-2874104fa8a7@ryhl.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c833e8c5-0787-45e6-a069-2874104fa8a7@ryhl.io>

On Mon, Dec 11, 2023 at 10:50:02PM +0100, Alice Ryhl wrote:
> On 12/11/23 20:49, Boqun Feng wrote:
> > The current safety comment for impl Sync for DriverVTable has two
> > problem:
> > 
> > * the correctness is unclear, since all types impl Any[1], therefore all
> >    types have a `&self` method (Any::type_id).
> > 
> > * it doesn't explain why useless of immutable references can ensure the
> >    safety.
> > 
> > Fix this by rewritting the comment.
> > 
> > [1]: https://doc.rust-lang.org/std/any/trait.Any.html
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> It's fine if you want to change it,

Does it mean you are OK with the new version in this patch? If so...

> but I think the current safety comment is good enough.

... let's change it since the current version doesn't look good enough
to me as I explained above (it's not wrong, but less straight-forward to
me).

Regards,
Boqun

> 
> Alice

