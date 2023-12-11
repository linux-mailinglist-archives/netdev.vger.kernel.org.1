Return-Path: <netdev+bounces-56148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EA80DF9B
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00F51F21252
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EE156768;
	Mon, 11 Dec 2023 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJehSqNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7438F;
	Mon, 11 Dec 2023 15:40:39 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9dc3215d2so2079407b6e.0;
        Mon, 11 Dec 2023 15:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702338038; x=1702942838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An9f3pD9ktxEC5vYVuGkpZnmGuClEEP+sgZfH08HIZY=;
        b=RJehSqNBLDH7RLccgjxgPs3BVTyIeCAhQ7RCAvS1ZfD3T3iKpuDugSxvYvkJiKrUyU
         bSrfxXgVXPcdsGN7i1IDZVaTt3XgWRizhhILWJUF4yxaUgfrZ8Hnm13vsxHY1igVvMvz
         k5nq4HdNIMwFLq66XDxc7FJdbdXa8v9nhTIHqyPGuBGpOAaYoS7qnaXdCifeQFw2/V1P
         zOFxw9PDMGvLxczFDHLmkO/Z/yrA3EPP+yYVBvCXzPCZpXcizpDNDoPzb1V4sMmDVHVp
         i3l+tq+r6FInNSXUUwV5UUxfrAPbwymnStBpPjA/S5NEu6gZ/e0DMpALVXto953+KSuA
         pwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702338038; x=1702942838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An9f3pD9ktxEC5vYVuGkpZnmGuClEEP+sgZfH08HIZY=;
        b=DPZaZp9eR8qyE9mHsZwzbtmUMeWS1muLOSNgZn3IQZi9iU8s5VXHX5kA2qwmQSLpP8
         WObS1yBIp/uB6tQBCo8I8gqIaYEATrBOyo4xKjY9ykhNvvNwJOymiD+9x/naVauUMPPJ
         EQtYF2oiXZr4CixtH805WnMoCNx81IfMW5Ep7P4Rg8fBtaQAcH5Z1CumBcn4C40+dHA9
         6dwYfPYeMXtPeGL5vaqtv07jeZqJpoVVzbPCF4ze9opsLI0HKkh6AT7YyU0RNNNV5PDv
         P5AMdpqdlU6TAtyLZCiwn7z6TfTZ0WNQIAB/GLepQquKPTVrAAgLCGeA+nN+vKnHg/HQ
         xDHw==
X-Gm-Message-State: AOJu0YyoXAgvZEqOK+0bl0eiWnphGBkIlOd/MJcQ1Qo5hHQ6CYbiOfne
	vz4Ev0UnSBgjZcPl3K9FbZc=
X-Google-Smtp-Source: AGHT+IFJHPF8IEOqOlJhBpLATBxsgeNFt3bsxlY6LmHy8n7Mn5TC8JUiPi3s5bVkCThokCc5ZRndsg==
X-Received: by 2002:a05:6808:3209:b0:3ba:3f5:9b60 with SMTP id cb9-20020a056808320900b003ba03f59b60mr2745600oib.110.1702338038442;
        Mon, 11 Dec 2023 15:40:38 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id z4-20020ac875c4000000b004180fb5c6adsm3577214qtq.25.2023.12.11.15.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:40:38 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id DC5C727C0054;
	Mon, 11 Dec 2023 18:40:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Dec 2023 18:40:37 -0500
X-ME-Sender: <xms:9Z13ZeNDox0tjyPf4dE3uIjmFRPSXYyICYlAEES7mDJ92kgn04t2ZQ>
    <xme:9Z13Zc_1uwQ3fns46-fcM0Q4RZyjUfhmAPZmTcbMY_YQToV3diMkyyhrvDYRrOi2y
    VS8Cw8GPuoAvB6EaA>
X-ME-Received: <xmr:9Z13ZVT7E_est1bu9hQe3EwG0ZMRasSKfLFys33wIaQVfgMFyFz-je6dULdIBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelfedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:9Z13ZevmovUoUj1whlGIbTjF_0hqEnpM9RQZMvXaYnV9ykdir1CYvQ>
    <xmx:9Z13ZWc4u9gn4MVH8L4bteYiyianhTI1ROr68Iv6UgZywaOeaNt2Tg>
    <xmx:9Z13ZS0qPk7qlYGYIE3gNvBbK1PXCFCl9r3q3ftGoO8w_62pMxghxw>
    <xmx:9Z13ZW6Yu4MVcSUyVLB8EhMtvNf3OpFYem1hR0MK5k6MHHTkxBcmEQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 18:40:37 -0500 (EST)
Date: Mon, 11 Dec 2023 15:40:33 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alice@ryhl.io, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZXed8cQLJhDSTuXG@boqun-archlinux>
References: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
 <20231210234924.1453917-2-fujita.tomonori@gmail.com>
 <ccf2b9af-1c8c-44c4-bb93-51dd9ea1cccf@ryhl.io>
 <20231212.081505.1423250811446494582.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212.081505.1423250811446494582.fujita.tomonori@gmail.com>

On Tue, Dec 12, 2023 at 08:15:05AM +0900, FUJITA Tomonori wrote:
[...]
> >> +    /// Reads a given C22 PHY register.
> >> + // This function reads a hardware register and updates the stats so
> >> takes `&mut self`.
> >> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
> >> +        let phydev = self.0.get();
> >> + // SAFETY: `phydev` is pointing to a valid object by the type
> >> invariant of `Self`.
> >> +        // So an FFI call with a valid pointer.
> > 
> > This sentence also doesn't parse in my brain. Perhaps "So it's just an
> > FFI call" or similar?
> 
> "So it's just an FFI call" looks good. I'll fix all the places that
> use the same comment.

I would also mention that `(*phydev).mdio.addr` is smaller than
PHY_MAX_ADDR (per C side invariants in mdio maybe), since otherwise
mdiobus_read() would cause out-of-bound accesses at ->stats. The safety
comments are supposed to describe why calling the C function won't cause
memory safety issues..

Regards,
Boqun

