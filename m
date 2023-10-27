Return-Path: <netdev+bounces-44639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F3F7D8DBE
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294BF1C20CD9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 04:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B5C4424;
	Fri, 27 Oct 2023 04:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEZODO5C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CE44412;
	Fri, 27 Oct 2023 04:26:56 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDB1AD;
	Thu, 26 Oct 2023 21:26:55 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5ac376d311aso12744777b3.1;
        Thu, 26 Oct 2023 21:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698380814; x=1698985614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doe7YWrWJJLJ7oYMXyVmtX9wV3FS+h0xz0bDDyzaqhw=;
        b=OEZODO5Cfzg6gXBwIkDABrGF70/hPsHzMni2yDi5SCzwa6BNmgxZoZE9cYJkQo1I0V
         VQJG73ewuPaOKMC3c3i4ArDjxdg3v5P2yIW5GNGmQ0HpdEZewahdeh8o3m5eUc+4ChCu
         934bHPfi2xe7oWtPh7b56AMj/mjDP4xS2kF9LVP4SxAYKJk/WfNbP4jl5w+mPsHKiMRc
         lUY8LBjhCDfeGFFql+nlfgCTpHuIJazm1cu9n7jRwIdeZS4/l8ThdmLx3g1gVeuB3Hw/
         wVQ7gop0LMF0FmIFoeT7r1R9f7lN0XD1pbqTE88ttB2QPQuajvpo7OS/vpFUZbOnK7Zp
         Uqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698380814; x=1698985614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doe7YWrWJJLJ7oYMXyVmtX9wV3FS+h0xz0bDDyzaqhw=;
        b=nb1x3h+ULJhPMToyRqLAA3SKvMQUgYW09272jvoDso1fShAf2SDglow0rtt6grFieL
         7EdGsWrzuaV56RAcDf8KIlPrE74OnH9+9oG1H0o/n97Z7AtZQhx+HDuigjqED6SaZ1Vt
         vv+FyPis5hNzvdRojmAX9yKtIVyakHky0oYcCgDqAR+UTeidSyBnKCr7T5nCqG6pfQfu
         oXb1uwCGSdKnu5zxzwo+foVHfjb7hD4P5Vsr1p64xIs7J8tptjvV/WYeXYJD8WKC0kbi
         qYPwyNgOmdZuLRKvwsNJ30xsDDZiR9rujrXJLaRjglXq8Nq7x868FyJ02e9/GTDj7z7X
         T6Dg==
X-Gm-Message-State: AOJu0YwKnA6jvYt45MbJXDbeGqTN7dgDFlyXX4XzKAsbxK84OV2al4ZH
	zDXP0Vmfo3DYQ3ngwYxTMig=
X-Google-Smtp-Source: AGHT+IGoZqx/kSfIrValUrw1CKwM1cxje2N35tbksDYlZKJgaWEYy9wPo8oOVgo7foiOWs0zcrAdmA==
X-Received: by 2002:a25:770f:0:b0:da0:93bf:2691 with SMTP id s15-20020a25770f000000b00da093bf2691mr1342930ybc.26.1698380814441;
        Thu, 26 Oct 2023 21:26:54 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v15-20020a25910f000000b00da07d9e47b4sm347213ybl.55.2023.10.26.21.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 21:26:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 1096C27C0054;
	Fri, 27 Oct 2023 00:26:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 27 Oct 2023 00:26:53 -0400
X-ME-Sender: <xms:DDw7ZVM3XIg8bVUYPPa2m3AJuHHVfGeZvsfd-d2Aeg1R1wrxJ_mmyg>
    <xme:DDw7ZX88ciu2gQ7QDLstWm-FdAQ0GeBGi3lkLixchg7hMGqLUhjywTwkouznJ0PPR
    uIBMuGGi229CG0uOA>
X-ME-Received: <xmr:DDw7ZUQ0cgBM2FlviXsGeqHTBHekkxvCoOMqQ5EvzsuvTZ4wo90lovxo6qs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:DDw7ZRvFKDdNQBfbbEAfaJ_dtQdD0KBPyASZs-Cqg3NH2CsdRWAOug>
    <xmx:DDw7ZdfymXjVuGLzxxJVfK8dn2mICaqtoQAtaMnhgqb8miMujmGrWw>
    <xmx:DDw7Zd0r1Hqia4ce9SMBlI84GHmM9yHPdhzTfG3LJbcYPCYP95r79A>
    <xmx:DTw7ZXvkb-hPZH2RVY0anVAnDgP2wHJG_DzHMC2SAnZmE4YX0KNR9w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 00:26:52 -0400 (EDT)
Date: Thu, 26 Oct 2023 21:26:05 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <ZTs73ZBgGZ-oHwF4@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
 <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>
 <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch>
 <ZTsqROr8s18aWwSY@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTsqROr8s18aWwSY@boqun-archlinux>

On Thu, Oct 26, 2023 at 08:11:00PM -0700, Boqun Feng wrote:
[...]
> > likely will be merged. Real problems can be fixed up later, if need
> > be.
> 
> But this doesn't apply to pure API, right? So if some one post a pure
> Rust API with no user, but some tests, and the CI passes, the API won't
> get merged? Even though no review is fine and if API has problems, we
> can fix it later?
> 

I brought this up because (at least) at this stage one of the focus
areas of Rust is: how to wrap C structs and functions into a sound and
reasonable API. So it's ideal if we can see more API proposals.

As you may already see in the reviews of this patchset, a lot of effort
was spent on reviewing the API based on its designed semantics (rather
than its usage in the last patch). This is the extra effort of using
Rust. Is it worth? I don't know, the experiment will answer that in the
end ;-) But at least having an API design with a clear semantics and
some future guards is great.

The review because of this may take longer time than C code, so if we
really want to keep up with netdev speed, maybe we relax the
must-have-in-tree-user rule, so that we can review API design and
soundness in our pace.

Regards,
Boqun

