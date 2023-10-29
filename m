Return-Path: <netdev+bounces-45086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5E7DAD9E
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 19:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8121C20920
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 18:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A901078D;
	Sun, 29 Oct 2023 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuzqnEwn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C376E3214;
	Sun, 29 Oct 2023 18:10:16 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077ACB7;
	Sun, 29 Oct 2023 11:10:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41cbd2cf3bbso39576401cf.0;
        Sun, 29 Oct 2023 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698603014; x=1699207814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5Sm09YaYSpMRER7v4caoauSBqaQdOuYEERsFpsvvfw=;
        b=fuzqnEwnCBEVTIVSvyR+RLwaPqLzWNRqvE7MmAe1YnrjSaOXpwM5B7QVwBlxB7pAVh
         KLf/wUwubBfg8WPJPHM39853WcKCk3XtmKu1diD+08gMsG7StkJhMx8DZy4KB/9htXcK
         qrYQbFOZvnjXRD3WlYH/K+HSqOCCJdf3IN53SoJoZbjZm/kdcOAKhZbelA6khfkKjec9
         WQpXe9K6Ciw8L91nJZxvXUEZRs5jAo8qwId0eUP6lEy/X2ZFZ0kkkXzshZup9n02cpCS
         k3vAR+WJXUFpfPdt0uqG+IfLc/7QRJEXFPxi4duCtU+ErDUdb+VGCOdZE4mBeW9eYA+J
         mOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698603014; x=1699207814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5Sm09YaYSpMRER7v4caoauSBqaQdOuYEERsFpsvvfw=;
        b=Qo6kmQ0H0tkdZBphDr9uwztlp6o6usTJHsjfpfoDf0fjwodjLwQp+ue6hx1D17GbxQ
         i3IbU6e1W/6hE+W8OZQn6Xej9WYVYFehAzJ5WBu+piN2fw+oNzhy3Od6BDmCNe1gyCEG
         7PQ5vmWf/QrB7M5devbyhyBjWMnZeVpeKic1rhOzFYxRjrimwIQ+FinOEFzfTnUj7IVR
         7AupkHGcj5V19RtJx348mBfwvj7DDNsC1tE5/93HfGghtjAKsyFaFl3lYvqMZb2RDwos
         DviU7phvQkDMmxqyh2c9gfyPjc9xECQ6xWNDQPAMHyNWsaX3dSlH8oZNjO8yDxSr6lO2
         FIhQ==
X-Gm-Message-State: AOJu0Yx8436C4fQ9VQBevW8YDRwEvdPri52XOpuPL1dkhN9KhxF9CTbM
	myFMCnyX82g0o4xdjbp7rQE=
X-Google-Smtp-Source: AGHT+IEVEjAWOcYgkvh0ByJqXpweE3D8aXJ+yGcEnCT+3R9gNRzNDMl94zI7D2XhxptmOODVPEXrmA==
X-Received: by 2002:a05:6214:62c:b0:672:6450:f809 with SMTP id a12-20020a056214062c00b006726450f809mr2187687qvx.16.1698603014026;
        Sun, 29 Oct 2023 11:10:14 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c2-20020a0cf2c2000000b0066db331b4cdsm2733989qvm.86.2023.10.29.11.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 11:10:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id F0F2227C005B;
	Sun, 29 Oct 2023 14:10:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 29 Oct 2023 14:10:12 -0400
X-ME-Sender: <xms:BKA-ZTq0y2PLYqgu_Ranq0c_kwxQT_9bU39tu5vJRANQmNqoV6iKNA>
    <xme:BKA-Zdr0FTskPCfS8sUFVWQNCxj57Emw-FAsxKI4a2n717SLV_KuUUQsRQ3bMkwzx
    ihk3YmOQ3oCqlqq-g>
X-ME-Received: <xmr:BKA-ZQN1rZ5rea3h80UderCfzNWLcDV_aDp0DqhuHAz--5BwuAZ3CzgPo_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleekgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:BKA-ZW7woiQ61Mx4mlAA8JnZx0RsZEftPuVC-QkcIQ5rjOv16tjOtA>
    <xmx:BKA-ZS73DkOSrnWCPBtrR82_YAnJ5RhPn6uff0FwgN7PXazzdAb5pA>
    <xmx:BKA-ZeguwULTzOzGJK4TaqiyN2Bn5N_r0ZBM53vnxXl63YnfxQBRZA>
    <xmx:BKA-ZZZprtFgef0a1-QNpZeAHWDxieIjTnqZc7ybdKyqwqUg98VU7A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Oct 2023 14:10:12 -0400 (EDT)
Date: Sun, 29 Oct 2023 11:09:17 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: benno.lossin@proton.me, andrew@lunn.ch, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <ZT6fzfV9GUQOZnlx@boqun-archlinux>
References: <45b9c77c-e19c-4c06-a2ea-0cf7e4f17422@proton.me>
 <b045970a-9d0f-48a1-9a06-a8057d97f371@lunn.ch>
 <0e858596-51b7-458c-a4eb-fa1e192e1ab3@proton.me>
 <20231029.132112.1989077223203124314.fujita.tomonori@gmail.com>
 <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT6M6WPrCaLb-0QO@Boquns-Mac-mini.home>

On Sun, Oct 29, 2023 at 09:48:41AM -0700, Boqun Feng wrote:
> On Sun, Oct 29, 2023 at 01:21:12PM +0900, FUJITA Tomonori wrote:
> [...]
> > 
> > The current code is fine from Rust perspective because the current
> > code copies phy_driver on stack and makes a reference to the copy, if
> > I undertand correctly.
> > 
> 
> I had the same thought Benno brought the issue on `&`, but unfortunately
> it's not true ;-) In the following code:
> 
> 	let phydev = unsafe { *self.0.get() };
> 
> , semantically the *whole* `bindings::phy_device` is being read, so if
> there is any modification (i.e. write) that may happen in the meanwhile,
> it's data race, and data races are UB (even in C).
> 
> So both implementations have the problem because of the same cause.
> 
> > It's not nice to create an 500-bytes object on stack. It turned out
> > that it's not so simple to avoid it.
> 
> As you can see, copying is not the way to work around this.
> 

An temporary solution is doing the #2 option from Benno, but in Rust and
open code it, like the following:

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 145d0407fe31..f5230ac48014 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -121,10 +121,10 @@ pub fn state(&self) -> DeviceState {
     ///
     /// It returns true if the link is up.
     pub fn is_link_up(&self) -> bool {
-        const LINK_IS_UP: u32 = 1;
+        const LINK_IS_UP: u64 = 1;
         // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
-        let phydev = unsafe { *self.0.get() };
-        phydev.link() == LINK_IS_UP
+        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
+        bit_field.get(14, 1) == LINK_IS_UP
     }
 
     /// Gets the current auto-negotiation configuration.
@@ -132,18 +132,18 @@ pub fn is_link_up(&self) -> bool {
     /// It returns true if auto-negotiation is enabled.
     pub fn is_autoneg_enabled(&self) -> bool {
         // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
-        let phydev = unsafe { *self.0.get() };
-        phydev.autoneg() == bindings::AUTONEG_ENABLE
+        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
+        bit_field.get(13, 1) == bindings::AUTONEG_ENABLE as u64
     }
 
     /// Gets the current auto-negotiation state.
     ///
     /// It returns true if auto-negotiation is completed.
     pub fn is_autoneg_completed(&self) -> bool {
-        const AUTONEG_COMPLETED: u32 = 1;
+        const AUTONEG_COMPLETED: u64 = 1;
         // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
-        let phydev = unsafe { *self.0.get() };
-        phydev.autoneg_complete() == AUTONEG_COMPLETED
+        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
+        bit_field.get(15, 1) == AUTONEG_COMPLETED
     }
 
     /// Sets the speed of the PHY.


Of course, it's not maintainable in longer term since it relies on
hard-coding the bit offset of these bit fields. But I think it's best we
can do from Linux kernel side. It's up to Andrew and Miguel whether this
temporary solution is OK.

Regards,
Boqun

