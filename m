Return-Path: <netdev+bounces-56107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C3480DD89
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C45281B52
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546A754FAA;
	Mon, 11 Dec 2023 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryhl.io header.i=@ryhl.io header.b="H9MpjK8V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sUN9LVyH"
X-Original-To: netdev@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D0B9D;
	Mon, 11 Dec 2023 13:50:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 8A50D3202213;
	Mon, 11 Dec 2023 16:50:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 11 Dec 2023 16:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm1; t=
	1702331406; x=1702417806; bh=R0XyqsLmvKi869pkri02kZM+5n5QOAkpElP
	YGKtMfjk=; b=H9MpjK8VaZIcGkgaNxBXwGZz3jiOWipp3CYOAzb9pzrYg7YHuIJ
	hjnYvEWbOz0d8WEOzXfWc9o+1IWcwPRBEHnGPHJvJVMNkelWwoVifx4Ezg0CSaVk
	qDDbJA01B3xNEjKQgl1m7/kvQkHzYzNtjrkDXxcchATLnT2C2bjdXW3Jj5oVKdrH
	gsyWgaougeo6cCXaLNqKqXIfT7ARs1G3lvZfD8E4EM5AxhpNReE7iOrdjwoiOYwM
	hl7g2Y6Va7VzCkWkzekY4p6C1DvpBQOpLWoOsJw3F29YfOiAVx+/rPXz+dEqLgxZ
	s5C/3clnaNjjDUlJ9ncW3cw7oswjol+DfoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1702331406; x=1702417806; bh=R0XyqsLmvKi869pkri02kZM+5n5QOAkpElP
	YGKtMfjk=; b=sUN9LVyHld9iyYGVX+5Ip5AWVbEmWKZ+KeEBb2ZVq55ClEhZ/QZ
	8lBSMBZHcgkFuWD20Zi3tGkfRwyElqJ4b1KfksfZkWrytMF7Ndfei/QMmTKIuBXQ
	1UxsXhfYG8KseWIhmWbEJCHbGcbQAQ9FhBti0sH5bA3hqROpWxklzLtmwKRSfRom
	K2wnYkPyegTzxxM7+TVFJbea5uLfv3yVhjGSOwh85NKvualD3JQm+nptL7BAW3fa
	S8FtRbAW1erCMdejbBp9lBw1412pCkK3faqbmx9e1gM0p26TuIB9CLQlRr1UWMWc
	Xosq4RkgT0pjttVh53c0TM8BuECU0vEA7fw==
X-ME-Sender: <xms:DYR3ZZN1XRWaROGKqgm-oq6NdPo4PyCvIg6iiQxcbh7tndwaEuGDcQ>
    <xme:DYR3Zb895zWFn0sPFJFgwahMSGDewudtWiUU69ARpt4rbcEaGDEs2v4HJ3TYVwE4x
    bx5KmNYhIqp-UOzmQ>
X-ME-Received: <xmr:DYR3ZYQ8YzqYcxZ8HuXvRKh6WNjWj93GCmdjiac8yB1YJSdCuiWJXeZgoAup2nJeg44KrfQA0F8SiTusItZLVWUft3ZXsX6v9PKZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epgedugefftdfhudetleehieeuhffgffffieetuddtkeetveehjeeltdeiueeggfejnecu
    ffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvgesrhihhhhlrdhioh
X-ME-Proxy: <xmx:DYR3ZVvIMourhygDsmfYX4gpGamSBl_DEqNspViWZkw9saEJ06bj3g>
    <xmx:DYR3ZRfVyL6YABrbzv06f6NMXfccR9J_h_rGaL0I9bwu-97iUK_9FA>
    <xmx:DYR3ZR0BEI9lzXuoH125YmEwQGUowCpA1BW7yMROuXgrTXe-2LOpbA>
    <xmx:DoR3ZQxOKr3MzBxe3KjzrzfsV3VC6xMxU_PFa455Be___E3sBtCk6g>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 16:50:03 -0500 (EST)
Message-ID: <c833e8c5-0787-45e6-a069-2874104fa8a7@ryhl.io>
Date: Mon, 11 Dec 2023 22:50:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH] rust: net: phy: Correct the safety comment for
 impl Sync
Content-Language: en-US-large
To: Boqun Feng <boqun.feng@gmail.com>, netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me, wedsonaf@gmail.com,
 aliceryhl@google.com, FUJITA Tomonori <fujita.tomonori@gmail.com>
References: <20231210234924.1453917-2-fujita.tomonori@gmail.com>
 <20231211194909.588574-1-boqun.feng@gmail.com>
From: Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20231211194909.588574-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 20:49, Boqun Feng wrote:
> The current safety comment for impl Sync for DriverVTable has two
> problem:
> 
> * the correctness is unclear, since all types impl Any[1], therefore all
>    types have a `&self` method (Any::type_id).
> 
> * it doesn't explain why useless of immutable references can ensure the
>    safety.
> 
> Fix this by rewritting the comment.
> 
> [1]: https://doc.rust-lang.org/std/any/trait.Any.html
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

It's fine if you want to change it, but I think the current safety 
comment is good enough.

Alice

