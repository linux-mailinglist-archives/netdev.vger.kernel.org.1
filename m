Return-Path: <netdev+bounces-45081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D060F7DAD47
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C58B20C42
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E920BD2E8;
	Sun, 29 Oct 2023 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYCcOS7D"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907EBCA46;
	Sun, 29 Oct 2023 16:48:46 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29203BD;
	Sun, 29 Oct 2023 09:48:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66cfd874520so23887736d6.2;
        Sun, 29 Oct 2023 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698598124; x=1699202924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrJHYqPsGjpCVZNZq+4SKKUIZPykXEAa2/KtTyJxlHo=;
        b=ZYCcOS7D6m2recgavIZ9hQJprh31+Je8ybrbWl076b7NMCv602j9FMAi0f2RiF3eCm
         i51NlO4cslSElCP+VRsI36HRAc5636e+8mcpB5UogOUYlXnCgYUrDEYShMKtj7a7tSrE
         LyhjAWTXetULFRBhXq84ir5OAzKsykwCsYY1itMBNTIa4IjS+51cTwX3RtjlBVHf2yrf
         Gh9ua19R3Ddhwmb2JnJQwdOYk0IQZKo1b8ui7KEAfgT9SuyyG0FvglvI4H6C9cKGDtBg
         4ym6C9Wi+n6sfNHibITU7mN7e4MzvPERkWzFnY8OvL4HDrOrxxlnT6BD7h/26UtXwBXK
         Bpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698598124; x=1699202924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrJHYqPsGjpCVZNZq+4SKKUIZPykXEAa2/KtTyJxlHo=;
        b=ZTiq9tl5VaX65Qyvb+6qkWL33kFr51/TgKbPI/Qcu0BsOaTay29SUZ5nK1yMNO0CcQ
         JI+FqaiX9lOQZuQxXTL1f84U6F0x86cuuHgE0HVn2sKRQF6+iHSxbjYGLwOZD7E2JyPp
         86RW3zgAIccjEUQZRo4U1Ec5WBYIG6kFAqRl/zD7LmqOJykeHVXp6nyUM1gZ2P56OOzt
         3l+YL/GUJd45iGxUdc74aaNkgxfYdxzPdfAXWe6YQFpu+o8mJadlnThfS8rhtxXS2dJV
         FVKm2eERkeYUbwfuYlz61RnFruL0CjUaHMcImkTzMSu0prSYCWWNwDEbqKH9YLKrUF8s
         xgBA==
X-Gm-Message-State: AOJu0YxaRnDvqKHe/a7byZlcZ/jUVxKGOYHQQYxWkdq3o619qZ++YwK7
	epkjLYausrwYGuMWC1n4LI4=
X-Google-Smtp-Source: AGHT+IF6E1N0OxP5x9lYEZkWXEcifaKtACfYTIHu6QC6r7XTuxwpfzjXpGS7/XrPgvgmAAXvEWDUyg==
X-Received: by 2002:a05:6214:2488:b0:658:22f8:4e51 with SMTP id gi8-20020a056214248800b0065822f84e51mr13775390qvb.1.1698598124205;
        Sun, 29 Oct 2023 09:48:44 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id qs16-20020a05620a395000b00767e98535b7sm2581628qkn.67.2023.10.29.09.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 09:48:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6690927C0060;
	Sun, 29 Oct 2023 12:48:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 29 Oct 2023 12:48:43 -0400
X-ME-Sender: <xms:64w-ZYjAWoD3C9A9gg8Zw2k5nNQPfo9RRZ5NctYQJ4geLeVXvjN4mA>
    <xme:64w-ZRBG9OQO-oNzPBAxSZiHpnkQm672ZtkffAgyzg8A28EbrInmru3FTPe_DHM7S
    zh3pnr7yfm3eM5msg>
X-ME-Received: <xmr:64w-ZQGNFGFJRy0tIFxJAW-rMTS_ek7LItVL9b_7A5_RyHUHpqW88GvArvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:64w-ZZRbPuwkYFSlDtJZhem6txUfI4WX2XobUc1wLJDUrxr2nOjMdg>
    <xmx:64w-ZVy6h52wMZ-kZXuPfrqK6msZElBIIXRBU0rPpqxKjHxScgmVlw>
    <xmx:64w-ZX6d7xlNkWeq1ktBMYjh0rzcCA9Jlo7cT59mBPre0z596Ypmzw>
    <xmx:64w-ZUx0O7y6jQr4AblM7YxYHBX6cIIJDTIzqrrMN62c6prQycBQYQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 12:48:42 -0400 (EDT)
Date: Sun, 29 Oct 2023 09:48:41 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, andrew@lunn.ch, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home>
References: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
 <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
 <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
 <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>

On Sun, Oct 29, 2023 at 01:21:12PM +0900, FUJITA Tomonori wrote:
[...]
> 
> The current code is fine from Rust perspective because the current
> code copies phy_driver on stack and makes a reference to the copy, if
> I undertand correctly.
> 

I had the same thought Benno brought the issue on `&`, but unfortunately
it's not true ;-) In the following code:

	let phydev = unsafe { *self.0.get() };

, semantically the *whole* `bindings::phy_device` is being read, so if
there is any modification (i.e. write) that may happen in the meanwhile,
it's data race, and data races are UB (even in C).

So both implementations have the problem because of the same cause.

> It's not nice to create an 500-bytes object on stack. It turned out
> that it's not so simple to avoid it.

As you can see, copying is not the way to work around this.

Regards,
Boqun


