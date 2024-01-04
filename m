Return-Path: <netdev+bounces-61687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D319F824A3D
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 22:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466431F2312B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1F2C69E;
	Thu,  4 Jan 2024 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="0wrlx6Ro";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aLmis7P4"
X-Original-To: netdev@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA52C69C
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 901A95C0225;
	Thu,  4 Jan 2024 16:24:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Jan 2024 16:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704403472; x=1704489872; bh=FuxpsY5jeS
	vpTkli4rj6MNEPdXzuQ9JwBhF1S0cCqs4=; b=0wrlx6RoKv/ox1lP7BUuyH71zP
	YalJt93obvTKWXa8UrUSsP2+48VZ8i40hUp9/gIxIMRCPm1MvAlHn99jgPpKfLK5
	++jvnDjeo/yMAHSR3orXTfoIwmDz1hzNFQYNdEOw6mlc4BXylg3yqUEBibAdzkGv
	u/myHshcVB6qKKrZIvgSY6Y29zfSpSTqDhxeyzRXaegdLUSVm8v4qXfKZCOnkhkk
	PdMkry/tPHIrX2NpssIrusNNOMTja9EGZGIHpRin/qMEz1vd8ESs4tK9ON7ujlkw
	SYEKiKbF+fjJrRA3NRgobPhcowsnUdJe3gTIjgIQKHwu22ADoOeMuaM6l2zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704403472; x=1704489872; bh=FuxpsY5jeSvpTkli4rj6MNEPdXzu
	Q9JwBhF1S0cCqs4=; b=aLmis7P4dz5+UCSMOi1Uxt7NjEWLRRy/vNnPS6bxvgf6
	2HlMGDSb60gcwGhFsWbYZxgLKfQwtsM4GgnRHOljRUaglgZh6UnENp/0Jz1BefLK
	Jvt1NkxxfjR0XzHy9dOQ9mf9gpI+w6syk2Rvc+esMo94LSsFxcME5cVNmd8ZVD6C
	30dJecdF9QBhL4mzxZ4LiEiwf8zXBr6kzMe3d/uc03cDRQLQSNaoe11gstHBGpE2
	YIa4rUhbSajBU40fj5w/sXbDKhD7X1jgM/u51fwcwPz4O5yZ3e9+NVBMRgQiVPK0
	8Dxfvqj2S71bieTBHAOe6Quit132TiirZjnJWwPL6Q==
X-ME-Sender: <xms:ECKXZZrTSqXTBVIGkOoxa28dYX_MCI55Zf1SAsTcLBfYCS6EbbcB2Q>
    <xme:ECKXZbqQ5oBqzz3D2fbKu6lSIibhfjzxrVDcz9jfNCTp2qnkGhgAXMwFCDjp5rvFA
    5912IUQryFwb1eOVHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ECKXZWMTC7d1PVfXH8UyIGtGokRYRjowNPfIx3jibFMwX0KduAu7dA>
    <xmx:ECKXZU6fSeHWg0flSZO_yQeXrL7pYvUQULx582hyY5Kevk4BdIAP8Q>
    <xmx:ECKXZY6spM0shGH929FQ2EslLp46mDbJngyqSaMTRLfoY9EzuuuMcg>
    <xmx:ECKXZT2VicbW36ISyOQ8o945uoD0ECmbx2H3Q7YJn1jbZGRG826fJA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0F734B6008D; Thu,  4 Jan 2024 16:24:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e1a09d9-6617-4612-ac56-ec18a01df902@app.fastmail.com>
In-Reply-To: <d055aeb5-fe5c-4ccf-987f-5af93a17537b@gmail.com>
References: <d055aeb5-fe5c-4ccf-987f-5af93a17537b@gmail.com>
Date: Thu, 04 Jan 2024 22:24:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Realtek linux nic maintainers" <nic_swsd@realtek.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: fix building with CONFIG_LEDS_CLASS=m
Content-Type: text/plain

On Wed, Jan 3, 2024, at 16:52, Heiner Kallweit wrote:
> When r8169 is built-in but LED support is a loadable module, the new
> code to drive the LED causes a link failure:
>
> ld: drivers/net/ethernet/realtek/r8169_leds.o: in function 
> `rtl8168_init_leds':
> r8169_leds.c:(.text+0x36c): undefined reference to 
> `devm_led_classdev_register_ext'
>
> LED support is an optional feature, so fix this issue by adding a Kconfig
> symbol R8169_LEDS that is guaranteed to be false if r8169 is built-in
> and LED core support is a module. As a positive side effect of this change
> r8169_leds.o no longer is built under this configuration.
>
> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202312281159.9TPeXbNd-lkp@intel.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

This has survived a day of randconfig builds

Tested-by: Arnd Bergmann <arnd@arndb.de>

