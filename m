Return-Path: <netdev+bounces-56106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AD280DD70
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EE71F215E5
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA5C54FA0;
	Mon, 11 Dec 2023 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="u0nosR15";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Om9zE3Zk"
X-Original-To: netdev@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14846BD;
	Mon, 11 Dec 2023 13:46:10 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 16ECE320130E;
	Mon, 11 Dec 2023 16:46:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 16:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1702331166; x=1702417566; bh=I0H14MDzxRsRz541oOemj8AjuDZyVPjSv5i
	mhF2Kghw=; b=u0nosR155FmJSBY4h0CseZz8I8sWbkKS7DR6C40TrFyQhRTbOnz
	RDM5ILKy5N7DkDhxdO93ZJ0Eoj3qgl2sM4aWfacKMmJ+thZU+T7Uhvky4FuUtjha
	6K4J0C1dproqzlrVAzQ44tWzdhlD8bdwMSRHxX8nrzlwJRcpK+cC6Ki2uxRjSgZo
	TIVCpGrnDjSOE0hZC5/NDpzr7C1swa1mDDG3BkMRirLxyQCLH4w0zxWf9+uOh5Gz
	v9QFhSmWUSPR5CJ7zfUrUVMCA2+j14ZbXw7G3kkwB54vmELS9i0LvMo7JqV5zB5W
	OnIUc2v+rjGJcfQAdJYBONrrD7Q0zCheMAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1702331166; x=1702417566; bh=I0H14MDzxRsRz541oOemj8AjuDZyVPjSv5i
	mhF2Kghw=; b=Om9zE3Zk8QrKBsE/+B0799FDzN4KnGsieU8DyKNQeMY0WRx50Ol
	8fyk6CGMvSHlFLBD+UrMFjfYUzKLklTtJ881G6fIPf5tiloDxzHsby88AZXMiTNl
	jL7MTeQbkoLXYZPFcnRBSvxvtmSxHnRatUVVgFwLmHhQ9tTqW+H3vnhFtiCh7p15
	8AhJgykrkHFFZJxT+vhGBbLVB10idPPywyVFVyu9W/n6+GL+s8mVjOhgK0CfpQyo
	efzbXwi3EJ7qxpyot/VnVeemGTxQb8JbTaNGzcC2t+IiQb1yYn+5+EOLbjCfquVf
	/OXMYxYzvToBYCO8gtR2YtStN06mrTVyMxg==
X-ME-Sender: <xms:HYN3ZRk6ujm3RmdrsqQAiDLZpNEG0eK-ayTu2udaecycp8_dHgtqaQ>
    <xme:HYN3Zc1Of2mcBDChc7G59Pw_ivan8SN4b88t4rVFD10YWd16k5xizWTNRpl_L5ZCr
    ohGtpoBy6r30lRQzA>
X-ME-Received: <xmr:HYN3ZXoTXa6YD1MD2AYNAUAMNkFKSeR2D4me1Kj1YMHn8sRBSQcnRALE2wA7qC5B4q6QOXtAf0pBcBfKwaDHaZ8eRfa1KXOrRi4B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    ephfeghfelgeffleegffffveegtdfhleetgeefveeihedufedtffffledufefhgeehnecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdrihho
X-ME-Proxy: <xmx:HYN3ZRlTfOIFTTsBbdSt_cIXA5RG9mNPSejzuJIxxjO6fcxtPbzsQA>
    <xmx:HYN3Zf2b56a1vJ0OednWGGh7yyY4KehyNCNnLh4EkXLtuhnnu9-KzQ>
    <xmx:HYN3ZQtV5dpTcCLuib2v74XmYb_lk-IAQFAzR8YjVkfq42X9jlmwSQ>
    <xmx:HoN3ZYLOv8rg0MKPzEoYI1vIJmAAb9pBYgoN5Wcfta64REtPuWeWJQ>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 16:46:03 -0500 (EST)
Message-ID: <ccf2b9af-1c8c-44c4-bb93-51dd9ea1cccf@ryhl.io>
Date: Mon, 11 Dec 2023 22:46:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 1/4] rust: core abstractions for network PHY
 drivers
Content-Language: en-US-large
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, wedsonaf@gmail.com,
 aliceryhl@google.com, boqun.feng@gmail.com
References: <20231210234924.1453917-1-fujita.tomonori@gmail.com>
 <20231210234924.1453917-2-fujita.tomonori@gmail.com>
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20231210234924.1453917-2-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 00:49, FUJITA Tomonori wrote:
> This patch adds abstractions to implement network PHY drivers; the
> driver registration and bindings for some of callback functions in
> struct phy_driver and many genphy_ functions.
> 
> This feature is enabled with CONFIG_RUST_PHYLIB_ABSTRACTIONS=y.
> 
> This patch enables unstable const_maybe_uninit_zeroed feature for
> kernel crate to enable unsafe code to handle a constant value with
> uninitialized data. With the feature, the abstractions can initialize
> a phy_driver structure with zero easily; instead of initializing all
> the members by hand. It's supposed to be stable in the not so distant
> future.
> 
> Link: https://github.com/rust-lang/rust/pull/116218
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Overall looks fine to me. Just a few comments below that confuse me:

> +    /// Gets the state of PHY state machine states.
> +    pub fn state(&self) -> DeviceState {
> +        let phydev = self.0.get();
> +        // SAFETY: The struct invariant ensures that we may access
> +        // this field without additional synchronization.
> +        let state = unsafe { (*phydev).state };
> +        // TODO: this conversion code will be replaced with automatically generated code by bindgen
> +        // when it becomes possible.
> +        // better to call WARN_ONCE() when the state is out-of-range.

Did you mix up two comments here? This doesn't parse in my brain.
> +    /// Reads a given C22 PHY register.
> +    // This function reads a hardware register and updates the stats so takes `&mut self`.
> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        // So an FFI call with a valid pointer.

This sentence also doesn't parse in my brain. Perhaps "So it's just an 
FFI call" or similar?

Alice

