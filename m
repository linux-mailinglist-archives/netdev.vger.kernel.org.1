Return-Path: <netdev+bounces-45141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D057DB1B4
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 01:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999E31F210FD
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 00:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF4219B;
	Mon, 30 Oct 2023 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVe6GuPZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF2190;
	Mon, 30 Oct 2023 00:20:42 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF14A7;
	Sun, 29 Oct 2023 17:20:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7789a4c01easo283416885a.0;
        Sun, 29 Oct 2023 17:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698625240; x=1699230040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh0qEMgw8kUGUxyaP3+8TT5GZg+SrpIWEti4LnQlQ2c=;
        b=DVe6GuPZoVxWQARU6Rd59vbpx5scQvtD3cSKpxSnfS51o6j7rJlYT2kbB3OC1oE8YG
         Fj9gS3gbzSu+J5QeaBg60S9UTollR/CwNbaGYwFmMjA6lYv5bOOqNkHa3VtCiaTKW0JH
         V6ESXFAqcejAdoGr+PRcpMRTVYjzE0Uh1//p76dubAmZtrUwFoCxMFgJQUhCcQIAeToP
         64SM74mSYiVUQbfl4C9M9wEtGyir1jtmHEkhUYZtGSsbSU+68ihMXi6EGcD9vQqdhC4S
         mAOZPs0GhGbkl93SnxUFcw5A70qjVYAT3p8LLzW/Ph/4rVL4xzCSvOKMFE4E8FvzbVQj
         IQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698625240; x=1699230040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh0qEMgw8kUGUxyaP3+8TT5GZg+SrpIWEti4LnQlQ2c=;
        b=KpV8isJoQkIgC/sjhdW73R7ZgTxsj3yF94ExLpN8TvbDCwvq3wEmOp7/DkAw+ps2BJ
         8B3ndrwy/tQnlFBN/SAepmArSjK3E0OERUNl0l2sDVbX0zH+d2tgvQFeSJ1MV3Sr5Tt9
         niVYbRxKdw5c7og5mS/AQzTyYdntdKMdOxWKE4SBWHwHS0zUFK8+pHXgK99KdWZhjHIu
         43OYQzfm5/JdcXKeWuNlufUA5tAls7A4C7P0S0aVZ6r2Q/wu6Iy7MlIcY98MVjNzi0Hr
         xxEQeg4imVnpxUUKLZQYWAGfavbI3E0XjGpZ024qUMLTiGQakma3rCMQbXyW2gvkaz3P
         VsBg==
X-Gm-Message-State: AOJu0Yw37OEI+TSbF8hqpY1raSkvtmXd12VcDOL6xxaG074B9exnrvTx
	U8PAGNDzMcmj8eVBi9U9BG4=
X-Google-Smtp-Source: AGHT+IHOUTqpyMtPLrt2FH0AB6QE0rP4oBJJlswk1gLq0bWNlvelN0ja8+ZxiNlr7FpuhyW+PlxLHg==
X-Received: by 2002:a05:620a:8b0d:b0:777:ee89:c03a with SMTP id qw13-20020a05620a8b0d00b00777ee89c03amr7507227qkn.77.1698625239805;
        Sun, 29 Oct 2023 17:20:39 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id u11-20020ae9c00b000000b0077892023fc5sm2877026qkk.120.2023.10.29.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 17:20:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id E4F9527C005B;
	Sun, 29 Oct 2023 20:20:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 29 Oct 2023 20:20:38 -0400
X-ME-Sender: <xms:1vY-ZR0MKyo2XawwelfnZ0uCqDy533ojknfIQP8qsXDxGCgzndp92g>
    <xme:1vY-ZYFS6DlsxdIvoTPUKSdSYaKN8AMsT7l3-y-RyvGWHUy0kKMxEP5VbgHVZ-SrR
    kvozn2pdq_AzPqjVA>
X-ME-Received: <xmr:1vY-ZR5fV0aTn0y33LKM_G0dt7LL21sqakp5dVZoiOHu2wY_AkYO4bO1Zu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleelgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeei
    hedvnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqh
    hunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:1vY-Ze3fM2uPnhP7mcg3aUx16w-_MWDkP3pOMomZbhQOIPrxQ20MlA>
    <xmx:1vY-ZUEKBXG6ZvrnLzm9jDaXZiJR0Y_4DHGP73Meybx7UM5GmDojvg>
    <xmx:1vY-Zf9fLvmDl3VvS6FOvG0-Rj2EYUSj4MG4L3LnqWks0wn98zL2Fw>
    <xmx:1vY-Zf1-fzmkIPd1Klq8OhdIktM-2xzkSp4Wk6Lwk9R7x5UaUCntlQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 20:20:38 -0400 (EDT)
Date: Sun, 29 Oct 2023 17:19:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, andrew@lunn.ch, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZT72no2gdASP0STS@boqun-archlinux>
References: <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
 <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
 <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home>
 <20231030.075852.213658405543618455.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030.075852.213658405543618455.fujita.tomonori@gmail.com>

On Mon, Oct 30, 2023 at 07:58:52AM +0900, FUJITA Tomonori wrote:
> On Sun, 29 Oct 2023 09:48:41 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Sun, Oct 29, 2023 at 01:21:12PM +0900, FUJITA Tomonori wrote:
> > [...]
> >> 
> >> The current code is fine from Rust perspective because the current
> >> code copies phy_driver on stack and makes a reference to the copy, if
> >> I undertand correctly.
> >> 
> > 
> > I had the same thought Benno brought the issue on `&`, but unfortunately
> > it's not true ;-) In the following code:
> > 
> > 	let phydev = unsafe { *self.0.get() };
> > 
> > , semantically the *whole* `bindings::phy_device` is being read, so if
> > there is any modification (i.e. write) that may happen in the meanwhile,
> > it's data race, and data races are UB (even in C).
> 
> Benno said so? I'm not sure about the logic (whole v.s. partial). Even

We can wait for Benno's response, but there is an example where Miri
says it's data race:

	https://play.rust-lang.org/?version=stable&mode=release&edition=2021&gist=c7097644aa5f02a0a436e5b8b8624824

> if you read partially, the part might be modified by the C side during
> reading.

If you read the part protected by phy_device->lock, C side shouldn't
modify it, but the case here is not all fields in phy_device stay
unchanged when phy_device->lock (and Rust side doesn't mark them
interior mutable), see the discussion drom Andrew and me.

> 
> For me, the issue is that creating &T for an object that might be
> modified.

The reason a `&phy_device` cannot be created here is because concurrent
writes may cause a invalid phy_device (i.e. data race), the same applies
to a copy.

Regards,
Boqun


