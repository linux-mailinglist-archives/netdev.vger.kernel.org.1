Return-Path: <netdev+bounces-53728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A37C804464
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8382813CA
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08F20E8;
	Tue,  5 Dec 2023 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuoj8Bfp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6D1B4;
	Mon,  4 Dec 2023 18:00:19 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d226f51f71so56926967b3.3;
        Mon, 04 Dec 2023 18:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701741618; x=1702346418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RARmHBQHLp7Okyt03f3n89xMZ9d0+q/he4xoiCmlIk=;
        b=kuoj8BfpSYCPJhx2Sh8GdpYD8rdyC80r3w94T30x2Sxt0ADJ119g9KNodZImIpOpNL
         awWuu6xf40/Km+4LYGKkS/1YthTb/7BHAny1Z0kJ0ykmYP8fHZ/tXpwQBbevh6RpxAex
         KZhDhF4MLP8F63kiZZccYqb43BTZ0kpyQFKIdOorgfQdBWZr+AV+f/IlzBAnHF8b144M
         dP6QgcrBR2MSDfNjef/ZZPWabdDEZ6rkEVjuEshpJ6nXrp8PdnNq+k1ADYUHJ2AJnh0K
         VckNerDU4+TeAPniU2c0m5SrP3yrvp6+4XHCnV4nMDgCLvacMIgMLbe6t1iNf4IKmMuE
         qRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701741618; x=1702346418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RARmHBQHLp7Okyt03f3n89xMZ9d0+q/he4xoiCmlIk=;
        b=XmIFCdKFQ8ipJtJ8N8E0+tqSSre/dfIPSEBjQ8nHLA/ARBYZiYt0/AavTB0F1lFom9
         OiSisR0kvfW1BjvKBZNYQR2WDMw/klLHeJ7Wo52nMtYYe5RZbhB/BB4B9Rh6bIPLVwGW
         M0yXKlv4m4x2Szwx74Ry3hWbGSYzDl3nssgzC1He4bDIC2DGuM1TjbhwMDG6ul/Ft+Wm
         gAUH0ZyS36fJhxxNHOWWZIIn3OwByyLymTmsv41gbjV6yD+yzKu2eSn/10AEnXOQk2I3
         JZaWcQCDpEnkxAoRYErgslU/W/aELzcGyOfGSzv4zLtvs47t5pjO+14pLtxvyytg7ndB
         I0Vw==
X-Gm-Message-State: AOJu0YxHFQvX4rr64NaSd1kMRuG3YFSvVlg7U0arjO3UGYGu0WSoUbfp
	uk9PSxeRDmhkJkp0GkMqDwc=
X-Google-Smtp-Source: AGHT+IHrwAD2wRe915kSxOCIZ3XqjwHqSBhpjHh6VyToYz8tWrKJ69jopjoFovUFlZXqRlcSMuH+JQ==
X-Received: by 2002:a81:8485:0:b0:5d7:1940:dd7a with SMTP id u127-20020a818485000000b005d71940dd7amr3676043ywf.80.1701741618680;
        Mon, 04 Dec 2023 18:00:18 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x10-20020a0c8e8a000000b0065b13180892sm1678294qvb.16.2023.12.04.18.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 18:00:18 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6EA7327C0054;
	Mon,  4 Dec 2023 21:00:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 04 Dec 2023 21:00:17 -0500
X-ME-Sender: <xms:MYRuZSlYsrHbszK2KB3DXpG8F40DieaHCF3CA-je6D7H2wtP5dPCsQ>
    <xme:MYRuZZ175v9530NARl8k5OzgsQtI7wRst5wsd0kiPpyFUOFrEQemiiENAjMzzyqeq
    VIYr5C50qInlESUMA>
X-ME-Received: <xmr:MYRuZQoIThrRITRxz53ryq78aDQ_t9lYufO0TjARZT-OXSAtGYtq6UNnEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejjedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:MYRuZWnUjaiYBE8wG7V5I5zF4Oa6FDQxy4wg6ctj3_s_rJtot5EmJg>
    <xmx:MYRuZQ2LSUyFRGYSWffPZI-43-Gr9zYYnGsZIjh319Jsc0o9rj-ygw>
    <xmx:MYRuZdt-IIVKKt2-oZTXAbAQ7WibP0lTxU2bVz3uxQ1UIX533OimtA>
    <xmx:MYRuZRIHF-aSoTBTLixRWluClgtcURcX1LgQ5_6tuqzQq5cPXv6jJQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 21:00:16 -0500 (EST)
Date: Mon, 4 Dec 2023 18:00:15 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v9 1/4] rust: core abstractions for network PHY
 drivers
Message-ID: <ZW6EL-4XaoY3n4J9@Boquns-Mac-mini.home>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
 <20231205011420.1246000-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205011420.1246000-2-fujita.tomonori@gmail.com>

On Tue, Dec 05, 2023 at 10:14:17AM +0900, FUJITA Tomonori wrote:
[...]
> +    /// Gets the current link state.
> +    ///
> +    /// It returns true if the link is up.
> +    pub fn is_link_up(&self) -> bool {
> +        const LINK_IS_UP: u64 = 1;
> +        // TODO: the code to access to the bit field will be replaced with automatically
> +        // generated code by bindgen when it becomes possible.
> +        // SAFETY: The struct invariant ensures that we may access
> +        // this field without additional synchronization.
> +        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> +        bit_field.get(14, 1) == LINK_IS_UP

I made a mistake here [1], this should be:

    let bit_field = unsafe { &*(core::ptr::addr_of!((*self.0.get())._bitfield_1)) };
    bit_field.get(14, 1) == LINK_IS_UP

without `core::ptr::add_of!`, `*(self.0.get())` would still create a
temporary `&` to the underlying object I believe. `addr_of!` is the way
to avoid create the temporary reference. Same for the other functions.

[1]: https://lore.kernel.org/rust-for-linux/ZT6fzfV9GUQOZnlx@boqun-archlinux/

Regards,
Boqun

> +    }
> +
> +    /// Gets the current auto-negotiation configuration.
> +    ///
> +    /// It returns true if auto-negotiation is enabled.
> +    pub fn is_autoneg_enabled(&self) -> bool {
> +        // TODO: the code to access to the bit field will be replaced with automatically
> +        // generated code by bindgen when it becomes possible.
> +        // SAFETY: The struct invariant ensures that we may access
> +        // this field without additional synchronization.
> +        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> +        bit_field.get(13, 1) == bindings::AUTONEG_ENABLE as u64
> +    }
> +
> +    /// Gets the current auto-negotiation state.
> +    ///
> +    /// It returns true if auto-negotiation is completed.
> +    pub fn is_autoneg_completed(&self) -> bool {
> +        const AUTONEG_COMPLETED: u64 = 1;
> +        // TODO: the code to access to the bit field will be replaced with automatically
> +        // generated code by bindgen when it becomes possible.
> +        // SAFETY: The struct invariant ensures that we may access
> +        // this field without additional synchronization.
> +        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> +        bit_field.get(15, 1) == AUTONEG_COMPLETED
> +    }
> +
[...]

