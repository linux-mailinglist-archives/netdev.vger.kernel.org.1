Return-Path: <netdev+bounces-37356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A89E7B4EC8
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 11:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 19A38282A1C
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C948F7A;
	Mon,  2 Oct 2023 09:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816A63DF;
	Mon,  2 Oct 2023 09:14:43 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774DC9D;
	Mon,  2 Oct 2023 02:14:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 23D7A5C023A;
	Mon,  2 Oct 2023 05:14:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 02 Oct 2023 05:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1696238078; x=1696324478; bh=Gi
	67L2nf6jw6VX+/CjPRuyOklRqWd3cHNR+4mWcy4TQ=; b=PklC6y2/Uv3YeyWbWW
	gLHl6SWf1vj2irTu2KZVK+Iv2qntqrls4scjNP2a3Mlh6Me2nVfdkQdxjPJaIOq6
	XqrrdMqHC6OAwc4qy75LN4G9KbmiVoUD0IzkJuWH3zkegmUw66VQtIvf3yyyQLVv
	X8v7T6rEo5y5qZwIgvpilZxNca5UOKuwyGLCCGtjySfZutSF3rlEVf6JixozE6yz
	eTY4urTUyEI7Bm4brSeNQ0GibJ0n74Qp4kWBqUb/61WbzLfh6B+sXr6un116Qx1n
	Kz6CHx0AY/XPjSgGP7dweepXrjP5UNTP6aCgDezkEOe9RCFxyCKpVq5oNenNZcxF
	JiSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1696238078; x=1696324478; bh=Gi67L2nf6jw6V
	X+/CjPRuyOklRqWd3cHNR+4mWcy4TQ=; b=aOHgjYtf9RaA38+X9GwpL6H748EBd
	Ovou/xCCu9FRpGrMItexL+F4ovlhXWYWyb01Oa2nyQFsAlFu8RsmkuTeOx1uQ/8H
	r6+LMKYZwd1dVY7d24nI+D49SVT+FA8ejzSlWENQVyg/RUkveJ4znGovx5I1ssSW
	kyItO//+Q5UDYCtgWPztGmt+Bmpbyojk+ZuhYYGNBf8ihQ2q34mGo4EecCXwjzs4
	JlX4b+2dRbj3QxGLzXql6URJMtVwJapyO0XaL7r7+jq03dstJvU7nR9f7GogWzbm
	Yg89LPHCkH3l9FrFUXPKKgvMX1po9jYtRRlDiS9jX/5lW0BUrCdmC3/8w==
X-ME-Sender: <xms:_YkaZVjvl75UpEFGItU5kjx9DD0T15IgHFbuCg_pW-YOnJBpOmIlaQ>
    <xme:_YkaZaAU0OTISNBNDx3UzI2nBlJ3nJApRJcKrKh4qSN_51gTakfDShzJtWUDCbl_L
    u63Y0hotlqhMQ>
X-ME-Received: <xmr:_YkaZVHgABpuoUUxh-qif-UokYMEoRDYjDd3ovG6ffDQe8xRsJxIM4mag_HgJO6q86YQMxO5-101s6fMaf7UvDjF9yhjqzIR7eB69dxOndc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:_YkaZaS0dyk7rAdcbnrJbeM_TjfEb6rHx5Uf4FIKuxnC2Bur_4V7Gg>
    <xmx:_YkaZSwGty8nKR5QChxmehhuc6vCmoXLsvu9YUQoIGHZLKrxXdYeeQ>
    <xmx:_YkaZQ7F7xlyNlH6gqutbbxOyg3EqsobA4gFHcs6vPqql85_b6sWtQ>
    <xmx:_okaZRl_XNgZZKYf87CQWww-OrHqTN-c_Ycu7TzA63vskmVRTA6k1g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Oct 2023 05:14:37 -0400 (EDT)
Date: Mon, 2 Oct 2023 11:14:36 +0200
From: Greg KH <greg@kroah.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v1 1/3] rust: core abstractions for network PHY drivers
Message-ID: <2023100237-satirical-prance-bd57@gregkh>
References: <20231002085302.2274260-1-fujita.tomonori@gmail.com>
 <20231002085302.2274260-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002085302.2274260-2-fujita.tomonori@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 05:53:00PM +0900, FUJITA Tomonori wrote:
> +/// Corresponds to the kernel's `enum phy_state`.
> +#[derive(PartialEq)]
> +pub enum DeviceState {
> +    /// PHY device and driver are not ready for anything.
> +    Down,
> +    /// PHY is ready to send and receive packets.
> +    Ready,
> +    /// PHY is up, but no polling or interrupts are done.
> +    Halted,
> +    /// PHY is up, but is in an error state.
> +    Error,
> +    /// PHY and attached device are ready to do work.
> +    Up,
> +    /// PHY is currently running.
> +    Running,
> +    /// PHY is up, but not currently plugged in.
> +    NoLink,
> +    /// PHY is performing a cable test.
> +    CableTest,
> +}

I still think these should come straight from the C code, and that
moving them to an enum makes sense to make this possible, but hey, it's
not my subsystem to maintain!  :)

> +/// Wraps the kernel's `struct phy_device`.
> +///
> +/// # Invariants
> +///
> +/// `self.0` is always in a valid state.
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::phy_device>);
> +
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
> +    pub fn id(&mut self) -> u32 {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        unsafe { (*phydev).phy_id }
> +    }

Naming question, why are you making this "id" instead of "phy_id"
like the C code has?  Same for many of these bindings.

> +    /// Returns true if the link is up.
> +    pub fn get_link(&mut self) -> bool {
> +        const LINK_IS_UP: u32 = 1;
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        unsafe { (*phydev).link() == LINK_IS_UP }
> +    }

"get_" normally means to grab a reference, if this isn't matching a C
call, why not just call it link_is_up or to match your other state
checks "is_link_up"?

but hey, I'm just bikeshedding at this point in time, if they maintainer
likes these as-is, keep them :)

thanks,

greg k-h

