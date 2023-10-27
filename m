Return-Path: <netdev+bounces-44634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 478227D8D51
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 05:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BBB5B212F9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 03:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E71857;
	Fri, 27 Oct 2023 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUW3D+Nn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16123B8;
	Fri, 27 Oct 2023 03:11:51 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D594129;
	Thu, 26 Oct 2023 20:11:49 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a92782615dso13210017b3.2;
        Thu, 26 Oct 2023 20:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698376308; x=1698981108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fjWCh4ETLFzq56czybOQUtQJUTqrn1p5OJTO0/P1Ts=;
        b=YUW3D+NnMtN3ggAhR9h5tDfmcFWlvDSUM7ZOqYh4w4RRf0nGJghI6P9pa0RcUndZPl
         AfNxn/KvHZ2vlt8GQEz+N8HOuXTftUtgLhHC2ZrlJt41m4AF6eEITPLWYZMAIV26nuJY
         usowM8xeIup9ZEA5x/q6GTHLuP9k9/rizp14TjngqYJWO9Cd7lI02CdIdMHaHeWmOQ1H
         ZBM2PdroovgpJoegp11riJCr0vBI/OM7VdlWdh7VLuGyH7f/ufDEV+wEQ5+gdI43PLgd
         bqEwDiHY2PyCdCp9lHqgTs2VpaLkolW3Rb9v0PmXi63w4KF5FcUHhwiebuvdHwS/4Tu8
         m+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698376308; x=1698981108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fjWCh4ETLFzq56czybOQUtQJUTqrn1p5OJTO0/P1Ts=;
        b=pX+EDFrb5VpLnPESivtWnrlYzh/XfnCaWaMZLbxLC5xbosHKWzjG+GYKryYKo4Tsh9
         AfXV0IbOYpxS4jpAZUrUXoNE+RzBo7DwicDaHAS6uKotWpx667Rxs/JpJEZjuSWYakEw
         Z11ltHaoVnUTwvRTmLxT0uHxDCw+2+OqZth0uh7Via93a+n+JlkEJJb4A/xneOTCcboG
         ZrD9zE1nvpHsKd3C+cRzfb6TYqRORhUvmrdA8qpWMODjdPRWdFK00exgWxTnzUUR6Z/8
         Zz2uM5McLMMqXCH+ribMJwtUAj227LRWO+JUTK/JXWXGn3kWvllZdfHsAuBRButS2+jM
         oNgA==
X-Gm-Message-State: AOJu0YxaLjQ+Q+Ly7wy3F5OmkG0pDBHjpd6votf9gM1cfHN1lMCnqW3K
	cHNVF1h7tMcyYWBhQL1G9Ki+03iWSRk=
X-Google-Smtp-Source: AGHT+IFzp8iCTafGSzvQkoar9f6CfJpsiSdoGtPPHD24/lBWt3tZeH9VdFgZMo8BEui3zl3n6gXmNA==
X-Received: by 2002:a25:2648:0:b0:d9a:5fb6:7425 with SMTP id m69-20020a252648000000b00d9a5fb67425mr1236137ybm.20.1698376308464;
        Thu, 26 Oct 2023 20:11:48 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w72-20020a25df4b000000b00d9cb16d7749sm319357ybg.21.2023.10.26.20.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 20:11:48 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 8DDFA27C005A;
	Thu, 26 Oct 2023 23:11:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 26 Oct 2023 23:11:47 -0400
X-ME-Sender: <xms:cyo7ZVRsDRJWrSmaUbRvRZP5Dm8ASy2ucsNDfQQWMZ7YtBeeiMQfEQ>
    <xme:cyo7ZeyzcLz54KFEVu0kEgNvMnRj5pka1EnAN1vB3ucHQ1UfZ4coSILS4g1D1fWps
    F5VNSrftvGjwqvYjA>
X-ME-Received: <xmr:cyo7Za37kvreVQtyGUdSEYUxhtLhhwTXgmfeSuuGffgFfkses9YsZ6JwmMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleefgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:cyo7ZdACEg3xa4pZ7dSVI5xQtFer6lejmgdKC75F9QCFkZzeFxYwAw>
    <xmx:cyo7ZejWNfMSbMDpFH7sdBMvCs6VtqHZJm4iV54HSmSxUNErc1BWbA>
    <xmx:cyo7ZRqNx7ud_6bRG5IttLUmcmB5Qr6rJIHJAlSFIHBHKZozfB2c-g>
    <xmx:cyo7ZSgRX7OFf9-IR5GNXcqNVgssyNZyL6YYy-Q8PFm4uLfCM4XCag>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Oct 2023 23:11:46 -0400 (EDT)
Date: Thu, 26 Oct 2023 20:11:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 0/5] Rust abstractions for network PHY drivers
Message-ID: <ZTsqROr8s18aWwSY@boqun-archlinux>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <CANiq72mktqtv2iZSiE6sKJ-gaee_KaEmziqd=a=Vp2ojA+2TPQ@mail.gmail.com>
 <e167ba14-b605-453f-b67d-b807baffc3e1@lunn.ch>
 <ZTsbG7JMzBwcYzhy@Boquns-Mac-mini.home>
 <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c40722eb-e78a-467d-8f91-ef9e8afe736d@lunn.ch>

On Fri, Oct 27, 2023 at 04:47:17AM +0200, Andrew Lunn wrote:
> > I wonder whether that actually helps, if a reviewer takes average four
> > days to review a version (wants to give accurate comments and doesn't
> > work on this full time), and the developer send a new version every
> > three days, there is no possible way for the developer to get the
> > reviews.
> > 
> > (Honestly, if people could reach out to a conclusion for anything in
> > three days, the world would be a much more peaceful place ;-))
> 
> May i suggest you subscribe to the netdev list and watch it in action.
> 

I'm sorry, I wasn't questioning about the process of netdev, I respect
the hard work behind that. I was simply wondering whether sending out a
new version so quickly is a good way to kick reviewers... it's sometimes
frustating to see new version post but old comments were not resolved,
it rather discourages reviewers..

> It should also be noted, patches don't need reviews to be merged. If
> there is no feedback within three days, and it passes the CI tests, it

Do the CI tests support Rust now? Does Tomo's patch pass CI? Looks like
something we'd like to see (and help).

> likely will be merged. Real problems can be fixed up later, if need
> be.

But this doesn't apply to pure API, right? So if some one post a pure
Rust API with no user, but some tests, and the CI passes, the API won't
get merged? Even though no review is fine and if API has problems, we
can fix it later?

Regards,
Boqun

> 
> 	Andrew
> 

