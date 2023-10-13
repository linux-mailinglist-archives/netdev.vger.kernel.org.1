Return-Path: <netdev+bounces-40595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1255E7C7C81
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 06:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A921F201A1
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 04:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F991C3C;
	Fri, 13 Oct 2023 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmz+lOtb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482217EB;
	Fri, 13 Oct 2023 04:17:21 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CAB7;
	Thu, 12 Oct 2023 21:17:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77574dec71bso111881385a.2;
        Thu, 12 Oct 2023 21:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697170638; x=1697775438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vigf1bBPQ+1WoAGs8QeZzRo58H4ASZSs5WvU9Xw1M7s=;
        b=lmz+lOtbLagVcpBvky7qBbpYwZk3iHu295xLmteiJcYEnJ1Uim+UdxnWZLFeA1Pb75
         YnerFt2CmaC28tvXpwEuT7UpQ2rdTfUXeng7qmFzi2Lf19wxlVkQ3kAEQJDOIBNhPSkm
         IN1hGop66d9CPjwRwYHmeC3BVEiCmw3M3+kmvO2cZsBYWfXTHtyKKwHjAqLv/HwS8x6r
         RfOacqZKHA2073j9YvQeHu1pSox3Kp8Z+OqHEEgUUn1cuwi2A8R51I+9BdOiqR6PovJW
         2jT/aHuKayG0Yz1lVioFExGv3Vc7cLflOfT12Ez1i5czLN92k+O0Ny4MvZa5OWpxQiuf
         J5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697170638; x=1697775438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vigf1bBPQ+1WoAGs8QeZzRo58H4ASZSs5WvU9Xw1M7s=;
        b=jSyoW4rXiRDXeWBf2xkSV+ryeni1YY5Tmk+CRj+HX2g7UeOBLL8MVY+kdBKLmUZZye
         45MjDGwWelaH8OBB3lnTtKEDAD73mY9XR+Ty8n0jNsCFKHsgo4LA9cz4ejdAD43FqReX
         U0hzAzLBu/YoUSsCPeHOzReB3ay2iwtPCNUAZQIqW+Aungvq7hIvbKYTBLlAevV3gjfO
         hsC+KiLrgjEKYPmYuvDHMh2bSvVzrSN+pBFhbFFue28QzxF9GThBIV3qNrXQ28TIsLB7
         ZqwlEqzpyq0O8C5yM9do1cXn0runP1aMpTWwUNCooHn4gAbpyZVK7mhlTWB1w3oJc9UG
         QxwA==
X-Gm-Message-State: AOJu0YzAUcNWuentNAfRuFfEZj8mkJuJebcmNwM98bX8xiYVQub5g1wC
	Mhrd491SNjgM+fo8Or/gOQU=
X-Google-Smtp-Source: AGHT+IELhuq4eWpRm5ZrNccU8/tTskXUopVlW6Z/AqaLDIEsNLXsa6f5kxLXif6UwRkfJRXGvEze1w==
X-Received: by 2002:a05:620a:4d8:b0:76e:f73d:5fd3 with SMTP id 24-20020a05620a04d800b0076ef73d5fd3mr25528448qks.72.1697170638364;
        Thu, 12 Oct 2023 21:17:18 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id m9-20020ae9f209000000b007742bc74184sm318873qkg.110.2023.10.12.21.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 21:17:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 632F827C0054;
	Fri, 13 Oct 2023 00:17:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 13 Oct 2023 00:17:17 -0400
X-ME-Sender: <xms:zcQoZc3IVW7QS8mxWQx0rg5nvZ0sGAD8eT9fjrQMjGJedWChJVvmnA>
    <xme:zcQoZXHJ4DdfWxJTvKRMFg4xqH9m_yuWznNmILAkxJVwBMgi4P2TJ7jdF2Z-Tf5s2
    wH5SEaqa2F7ta1QZA>
X-ME-Received: <xmr:zcQoZU6jPWnwGhCyskolGqYvYCk7HzSnDPN8M7yUsijPFzqwDPZJGOP-edw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeeh
    vdegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:zcQoZV0IwqStDMU5wEH57SEpFfCaY_1sPdfQ_rSRYGW1G_S_jLg4Dg>
    <xmx:zcQoZfHhIBLr6Cp2O8VSQN_e7sym4Sj-bkp7KVizRp3Ua1dT5NGc-w>
    <xmx:zcQoZe9VEQxJzwdC6sOdMiBDBSawwXJT2lLISS04qoR18h5YvLRjiA>
    <xmx:zcQoZe2RQ4v4iR3z8BIpZm4Fg6EMhQQSAxsqUH5cYieZKm1SCnAEhQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Oct 2023 00:17:16 -0400 (EDT)
Date: Thu, 12 Oct 2023 21:17:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, tmgross@umich.edu,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <ZSjEyn-YNJiXPT4I@Boquns-Mac-mini.home>
References: <20231012.160246.2019423056896039320.fujita.tomonori@gmail.com>
 <ZSeckzvOTyre3SVM@boqun-archlinux>
 <CALNs47tKwVE_GF-kec_mAi2NZLe53t2Jcsec=vsoJXT01AYLQQ@mail.gmail.com>
 <20231012.165810.303016284319181876.fujita.tomonori@gmail.com>
 <f3fa33f8-f4b0-463c-8ba3-5f0a8b8f6788@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3fa33f8-f4b0-463c-8ba3-5f0a8b8f6788@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 09:10:41AM +0000, Benno Lossin wrote:
> On 12.10.23 09:58, FUJITA Tomonori wrote:
> > On Thu, 12 Oct 2023 03:32:44 -0400
> > Trevor Gross <tmgross@umich.edu> wrote:
> > 
> >> On Thu, Oct 12, 2023 at 3:13 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>
> >>> If `Device::from_raw`'s safety requirement is "only called in callbacks
> >>> with phydevice->lock held, etc.", then the exclusive access is
> >>> guaranteed by the safety requirement, therefore `mut` can be drop. It's
> >>> a matter of the exact semantics of the APIs.
> >>>
> >>> Regards,
> >>> Boqun
> >>
> >> That is correct to my understanding, the core handles
> >> locking/unlocking and no driver functions are called if the core
> >> doesn't hold an exclusive lock first. Which also means the wrapper
> >> type can't be `Sync`.
> >>
> >> Andrew said a bit about it in the second comment here:
> >> https://lore.kernel.org/rust-for-linux/ec6d8479-f893-4a3f-bf3e-aa0c81c4adad@lunn.ch/
> > 
> > resume/suspend are called without the mutex hold but we don't need the
> > details. PHYLIB guarantees the exclusive access inside the
> > callbacks. I updated the comment and drop mut in Device's methods.
> 
> The details about this stuff are _extremely_ important, if there is a
> mistake with the way `unsafe` requirements are written/interpreted, then
> the Rust guarantee of "memory safety in safe code" flies out the window.
> The whole idea is to offload all the dangerous stuff into smaller regions
> that can be scrutinized more easily and for that we need all of the details.
> 

Thank Benno for calling this out.

After re-read my email exchange with Tomo, I realised I need to explain
this a little bit. The minimal requirement of a Rust binding is
soundness: it means if one only uses safe APIs, one cannot introduce
memory/type safety issue (i.e. cannot have an object in an invalid
state), this is a tall task, because you can have zero assumption of the
API users, you can only encode the usage requirement in the type system.

Of course the type system doesn't always work, hence we have unsafe API,
but still the soundness of Rust bindings means using safe APIs +
*correctly* using unsafe APIs cannot introduce memory/type safety
issues.

Tomo, this is why we gave you a hard time here ;-) Unsafe Rust APIs must
be very clear on the correct usage and safe Rust APIs must not assume
how users would call it. Hope this help explain a little bit, we are not
poking random things here, soundness is the team effort from everyone
;-)

Regards,
Boqun

> What would be really helpful for me, as I have extremely limited
> knowledge of the C side, would be an explaining comment in the phy
> abstractions that explains the way the C side phy abstractions work. So
> for example it would say that locking is handled by the phy core and (at
> the moment) neither the Rust abstractions nor the driver code needs to
> concern itself with locking. There you could also write that `resume` and
> `suspend` are called without the mutex being held. We don't really have a
> precedent for this (as there have been no drivers merged), but it would be
> really helpful for me. If this exists in some other documentation, feel
> free to just link that.
> 
> -- 
> Cheers,
> Benno
> 
> 

