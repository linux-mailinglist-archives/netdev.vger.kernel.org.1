Return-Path: <netdev+bounces-44838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982007DA12C
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 21:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A8E1C210F9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19B73D3B1;
	Fri, 27 Oct 2023 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxW6ekIX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0213D38B;
	Fri, 27 Oct 2023 19:10:35 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB9CE1;
	Fri, 27 Oct 2023 12:10:33 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b3f55e1bbbso1539411b6e.2;
        Fri, 27 Oct 2023 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698433833; x=1699038633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxvIjQdVa06LKaV9Nu0kZXGR351C/x8779nzEl3SZRc=;
        b=BxW6ekIXSJtkmzEo3CZIVM0t7pMOdJpPjuxBxC0P5ALA/DtGqZDc8jUjVR3Pn2lc7C
         2DBlgdTUEN95MPMcSY/cTuszWpR8/AnY0+IzCDmsgCLTEbXxMeMFrgcYeihDlUNdoTHx
         ghsqHrXBbcN2VtsyDwKB/qxCP1yIpJn3ip9z1r+F00Rz0oGOzt/MHfSNao+tvJ7PF9LV
         TG/h3Ow+FT9lNFdyGv14CnA1/UDnj/tpTCWWE3GX8iI4mw24n745qBohr0R1sFwjRz9x
         2VwJP0czo+e+NKN99zYTEnr1oV6UeY1E53ylu4m3UecjcVX3mBC8j8n+Lg51rhnq1kTg
         akWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698433833; x=1699038633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxvIjQdVa06LKaV9Nu0kZXGR351C/x8779nzEl3SZRc=;
        b=jbBdYtikZNZG82Fwdq0mAIF+ujIzj5wByczg650c4DoXNOyxLbuelMwd+vmEEEiv/v
         emkG7oYmE8lkOJ2BjZf6dzjvOABpW7HCLftYYq5GXrmE2pd5EoanSo2Jr2lx7voNbY0B
         6e5kPWQfz9MBHAiLyJvjyOv1lXrah+LDNMfW4KqWTms6Va72dLIOn4C5dPuQrj1ICD+L
         ZLqJ5KR1obhp0GL+ADH1bRf8aifPPbl1Jh2bO1/PrWx4td3PqYkiQF2+HxW88WLeLaix
         88su5Fr7tyBWBvGrICpypGhgLH+eC8X7FB4DMjVvUw+BTTlxgnBYtotVC20cgixl84py
         wSSw==
X-Gm-Message-State: AOJu0YwovMDbv5PC892Bok5j07czzsNQMPb/QzIwaU9FM2oRnifuoVGO
	xBFZBq1z8nHiJGJOMmdnrD/7npkFs4Y=
X-Google-Smtp-Source: AGHT+IH9/gqsXSNkD5ozlrDAwevpEhjz/n9VvOuMskz8+IFagr3VNqVwfxtZzBCxEedYzObrOjQF5w==
X-Received: by 2002:a05:6808:308c:b0:3af:709c:1b2b with SMTP id bl12-20020a056808308c00b003af709c1b2bmr4291602oib.32.1698433833033;
        Fri, 27 Oct 2023 12:10:33 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id v71-20020a25abcd000000b00da082362238sm899292ybi.0.2023.10.27.12.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:10:32 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id CD38727C0054;
	Fri, 27 Oct 2023 15:10:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 15:10:31 -0400
X-ME-Sender: <xms:Jws8ZaSZEkJRnDBu0OwipSod2L0YkkUzO6n6C1uF9_Lq2Eo-A4Kd9g>
    <xme:Jws8ZfzeGvvsoYh8IYMKd4QpvzSFfaACWL_Q8KC8gHnyjNFuPwB_8RFITXN9PZp2O
    Q317fFndy2K0xFFOA>
X-ME-Received: <xmr:Jws8ZX2xdx55fE9l3xOwD-huokLR1rTbshdSkUH9lLxyLm93CpVpgPAiOaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Jws8ZWBMjMzAe2OTg8krkWQAUHsYgfYZwnrBwRwtpCgoosiRb-rB1Q>
    <xmx:Jws8ZTiJHglPF-WDWrFWR7fQvVfe3iHlgV82PenQ6usD0bf0IIGo1A>
    <xmx:Jws8ZSpZz-EH3c0AHdTt-OUPTtiE5fqsBYJzgSJhrAei-H6rDoXOxA>
    <xmx:Jws8ZTggKnQ8GD-ceupxhCS8EvhOczhPF4fuWRQwkXOO3NRFmoZcMQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 15:10:30 -0400 (EDT)
Date: Fri, 27 Oct 2023 12:09:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZTwK9c0sf8sxNgdr@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026001050.1720612-2-fujita.tomonori@gmail.com>

On Thu, Oct 26, 2023 at 09:10:46AM +0900, FUJITA Tomonori wrote:
[...]
> +config RUST_PHYLIB_ABSTRACTIONS
> +        bool "PHYLIB abstractions support"

bool "Rust PHYLIB abstractions support"

maybe? Make it easier for menuconfig users to know this is the option
to enable Rust support.

Regards,
Boqun

> +        depends on RUST
> +        depends on PHYLIB=y
> +        help
> +          Adds support needed for PHY drivers written in Rust. It provides
> +          a wrapper around the C phylib core.
> +
[...]

