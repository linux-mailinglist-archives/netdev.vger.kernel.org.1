Return-Path: <netdev+bounces-40095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A1A7C5B5C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E77B1C20EA0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F84818635;
	Wed, 11 Oct 2023 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf8lvhVZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C222334;
	Wed, 11 Oct 2023 18:31:08 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6227EA4;
	Wed, 11 Oct 2023 11:31:06 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7af20c488so1855897b3.1;
        Wed, 11 Oct 2023 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697049065; x=1697653865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pROmhzJcl0JhzCQUoJcYCAJN//967qK7eQOeMUViZlk=;
        b=Qf8lvhVZXaU0sqASFkcdRSMpEr8j8flaRbypr7LGSVMITR4EwU7iV1n54tnFH2WYsn
         3rxUW9N32IwwFbfOAVxLb6jZTzEV0TmUmRJoQZNjIoFMBA/+M4DPnfWlmWfUqp9GdZCC
         TgauOHt5dJHjpoR/SBpnYnWTTJ9wP1OOF4J510p2mCgTLkmEKHY4e/gSyFrwsiXm2H8+
         Z9VwseRu2vCu48YRvFywiW+GDQtZm2zJMJgO1EsvnJqWuGFuxKNbstXp2KhBajxH3YBk
         W4Nh8xH6cHYknyoecG6JKDJ+c8X7ArN6aOOEx7HW0yqJ33PZvNFD9XyIvXZY7bvF8caO
         9gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697049065; x=1697653865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pROmhzJcl0JhzCQUoJcYCAJN//967qK7eQOeMUViZlk=;
        b=uahCbK+mChRUMQ74WA4cbU7REftVvfDyOf2huphJwEdTqNHi1jjh1YtzpPh/rgF+br
         lk5pqsssQ8jPsdbLBzr4SVidTAQgD7OiiNa43w7hRpNsVCEr5Yqjgg6hBLwlEqq4eMly
         KbDs3RBtFR2NyPpmbxLXkuv0FKaorWutOMdymQIgV1qi98drzmHyLtMzInddw3jkABip
         ZO5LSbJeQAQ3NeixD8VXXx05uRi9Yhks89BijofZR5RhkqpObAKMS5jNJAcIFO3UuKyW
         0SBbSDwOQQGQbEn9sL5eFhVBGvbzBiIfZDcKudwQ3tKjjyX+0UXcsCZ8AgnaQ06g7Jlo
         KEdA==
X-Gm-Message-State: AOJu0YwBpIxwEuE2zEL0JrGE7Ux+ZR2mdlr5F97PEQFFgjVcTjFByb63
	Sd5QZtg2PewDTDN1AQ+1NnM=
X-Google-Smtp-Source: AGHT+IGPgBNl1XsdqklS6f4h/VEZmBWGjm66godlVncJCwABKfUITz7CCQQExdTtfyOhWq1V+gh2QA==
X-Received: by 2002:a25:21c2:0:b0:d00:cc5b:8a9f with SMTP id h185-20020a2521c2000000b00d00cc5b8a9fmr17976051ybh.16.1697049065490;
        Wed, 11 Oct 2023 11:31:05 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id lf7-20020a0562142cc700b0065d0d0c752csm5853634qvb.116.2023.10.11.11.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:31:05 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id BE18E27C0054;
	Wed, 11 Oct 2023 14:31:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 11 Oct 2023 14:31:04 -0400
X-ME-Sender: <xms:6OkmZZYinfhMVOoEowGORCHwngEwCdyfReTUUK9KZ1jt7cCIwi2txQ>
    <xme:6OkmZQaaOEbNI1TSPMRHrNMKBzxfXgihcSZY-xClDUcTgrVpzvkGcnKy8dqg_5itK
    gnvkntqJixdtJIjpQ>
X-ME-Received: <xmr:6OkmZb9QY-kX13AxfbvJBcREWS0OAuRLqE14mjdBA4Fr7MrtzD0h2OLAq4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:6OkmZXpnzPBzicsAP05_NFysUp-sI-Ck2_CsrPXvmsd9iNU6huBF5g>
    <xmx:6OkmZUpvu5hLdVtc_OBUwu0IeJM17RApovr779xIEQTI4HCdQjzA5g>
    <xmx:6OkmZdR66bKF_gqyR7-ZZRXyWThwPLhjU_7cUvcCm5FmdDfripXg5A>
    <xmx:6OkmZVdZkPHq8IDGhUYmxefJTR9sxlDlwiyO5UvzPBBjv-PM4pXYRQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Oct 2023 14:31:04 -0400 (EDT)
Date: Wed, 11 Oct 2023 11:29:45 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <ZSbpmdO2myMezHp6@boqun-archlinux>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009013912.4048593-2-fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 10:39:10AM +0900, FUJITA Tomonori wrote:
[...]
> +impl Device {
> +    /// Creates a new [`Device`] instance from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// For the duration of the lifetime 'a, the pointer must be valid for writing and nobody else
> +    /// may read or write to the `phy_device` object.
> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
> +        unsafe { &mut *ptr.cast() }
> +    }
> +
> +    /// Gets the id of the PHY.
> +    pub fn phy_id(&mut self) -> u32 {

This function doesn't modify the `self`, why does this need to be a
`&mut self` function? Ditto for a few functions in this impl block.

It seems you used `&mut self` for all the functions, which looks like
more design work is required here.

Regards,
Boqun

> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        unsafe { (*phydev).phy_id }
> +    }
> +
> +    /// Gets the state of the PHY.
> +    pub fn state(&mut self) -> DeviceState {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        let state = unsafe { (*phydev).state };
> +        // FIXME: enum-cast
> +        match state {
> +            bindings::phy_state::PHY_DOWN => DeviceState::Down,
> +            bindings::phy_state::PHY_READY => DeviceState::Ready,
> +            bindings::phy_state::PHY_HALTED => DeviceState::Halted,
> +            bindings::phy_state::PHY_ERROR => DeviceState::Error,
> +            bindings::phy_state::PHY_UP => DeviceState::Up,
> +            bindings::phy_state::PHY_RUNNING => DeviceState::Running,
> +            bindings::phy_state::PHY_NOLINK => DeviceState::NoLink,
> +            bindings::phy_state::PHY_CABLETEST => DeviceState::CableTest,
> +        }
> +    }
> +
[...]

