Return-Path: <netdev+bounces-44942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68B7DA433
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 01:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376BBB21547
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13B941218;
	Fri, 27 Oct 2023 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGQu0UEj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2141206;
	Fri, 27 Oct 2023 23:53:22 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B1A1B1;
	Fri, 27 Oct 2023 16:53:21 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-777719639adso188058485a.3;
        Fri, 27 Oct 2023 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698450801; x=1699055601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVNbgFbAwnzJPkDKq/A9IIT8jkIti+zn/ixoBoo61Bw=;
        b=RGQu0UEjTR9wkRI3dBHNQUK6yi8shGfjd1wGiH+v9nNIQEqOaFcXp7MhFn7Sz5cySW
         KZmF6R78uTqDQy5t3N9u3R8koon9isKyUAoct6YffMH8R1uhVobYqq+cXCkeW2aYyDDG
         U0dWZCqvUGayDXlYxtwbNZy/XelC471tWkvUKmNWuDtE/Jqep8Qh1DYQLLcmzf0YSlWt
         lLtA6WkDuEJW+qDa8zIqgLKZRycX/jSaMf4W1tHv1gQvss28IEpemArzGI8W1zNM0Fc3
         j5BaCLdw/82P0sD/X1DjW4pXUTSG8ma+U/hKDgqMXdxu7tCqiBOOB+4Eh0x0ahP4ZKCH
         dHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698450801; x=1699055601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVNbgFbAwnzJPkDKq/A9IIT8jkIti+zn/ixoBoo61Bw=;
        b=oTCpVkIi7selxx3rq1YbdgPZZg9OOa4JcseHu9bgJAGAqXXeRW7GEBT18pGzUwStZg
         GH/kuYWx2NlYd7dNZmRz48+Lp49V7yqeHk4QXvERf02AYHRjiX+4qmBTg9/PQIJnjdXv
         dOOaMokW+1zTKgWuDF8g13yoEe0w7COJtERqZAY5gXg4vahQQniUCTPW6Zbl2qscVUkI
         BVlQL60t9qP+h9gmMn8jDcTUYzahNnRmDq3NrvfQWe1o9LaZj8XicFlC5tMG6Vr/rGaG
         SWHsSye6ffmEzpqW5U9LE1z6lIn1pxihdmrhVjQdH3KR1+7pNnje+XidHBM8iMzr5QYn
         EZ/g==
X-Gm-Message-State: AOJu0Yz8pnzmpBRoW6qmXOsGSHq0MhQdKmJjj66s3XzzsYNzms7VyPju
	eVjqJ262BNwXiJ3Q+7/en/A=
X-Google-Smtp-Source: AGHT+IEyNWoeBDO+2b+5TXoaIxGUmdkkNCHXC/QIfLFmPUwRf/Zl4+znqa4co6pugCfjV3ksJyDWhA==
X-Received: by 2002:a05:6214:27ca:b0:66d:6311:f91f with SMTP id ge10-20020a05621427ca00b0066d6311f91fmr4708172qvb.45.1698450800844;
        Fri, 27 Oct 2023 16:53:20 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id d4-20020a05620a240400b0077402573fb4sm1007923qkn.124.2023.10.27.16.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 16:53:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 4A19127C0054;
	Fri, 27 Oct 2023 19:53:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 27 Oct 2023 19:53:20 -0400
X-ME-Sender: <xms:b008ZW3bZW2-xtyZsOeIzPiLPWFuruyIVnOjTHqQPQoluHwfkJIEIg>
    <xme:b008ZZF39C0wBGpsU5JReOkdH7sj5VDCS1npJaoiufZuAcM5Hb5s6ryA31du9KYEH
    QJa9QUiFD3qU9mBCw>
X-ME-Received: <xmr:b008Ze6GjyNw0yx5ODsFRy8yhBS5L_6UrUmrNTPPJRerOdxLhJz_9Znyn1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepjeffheetffdvveevuefgfeejkefgledvvdevvdetteekffefffeffefgfeei
    hfdtnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgpdhgohgusgholhhtrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsgho
    qhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqd
    dujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihm
    vgdrnhgrmhgv
X-ME-Proxy: <xmx:b008ZX2zoSMBvEHHXRf3eRLW12XFsDaQLiTZp29HLelCDKN-A8X17w>
    <xmx:b008ZZF-m4wD_t27rl2knUrbYojkbGWUEO4aEC3oMSyXjjW43ZVRiw>
    <xmx:b008ZQ_GfX5Hd41VEQjAeILbt45YBu4tym3w9veSbk6G-lwe47DYCw>
    <xmx:cE08ZQ0IHxToX7pFqZLtQgq4_l-Fnw6LKgwTl-i13awfP8_8-RTCyg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 19:53:19 -0400 (EDT)
Date: Fri, 27 Oct 2023 16:52:30 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZTxNPiWeVfFTvxu2@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <ZTwWse0COE3w6_US@boqun-archlinux>
 <ba9614cf-bff6-4617-99cb-311fe40288c1@proton.me>
 <ZTw3_--yDkJ9ZwIP@boqun-archlinux>
 <77c78010-781e-4eb4-a7ba-3e9f9a07bf67@proton.me>
 <ZTxHKCWTAA7T-MJd@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTxHKCWTAA7T-MJd@boqun-archlinux>

[...]
> > [1]: https://play.rust-lang.org/?version=stable&mode=debug&edition=2021&gist=f7c4d87bf29a64af0acc09ff75d3716d
> > 
> > So I think that is fine, but maybe Gary has something else to say about it.
> > 
> 
> Well when `-C opt-level=2`, they are the same:
> 
> 	https://godbolt.org/z/hxxo75YYh

But maybe you are right, no temporary reference in this case.

Regards,
Boqun

