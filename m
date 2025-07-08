Return-Path: <netdev+bounces-204983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77998AFCC46
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5430423B98
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D632DCF74;
	Tue,  8 Jul 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikAZ81ZF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4F26CE02;
	Tue,  8 Jul 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981574; cv=none; b=JWjjHXYuSx5oF28SoFrkzuw451N7393OVipSnzwIOn+y0j99luLQxDZAvbouOwXly8q99d8CrBzdwFfBVRzB6ioADI2h4795kcXApt/tczAgQuv0k5McwaQp2oyDMYsvj0VZ6qgNYhxBf3sD9wXKinX55n32biB3mFlnecdAIDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981574; c=relaxed/simple;
	bh=Yw3Oj8jXPI3vGz0t1H7wwj43CNt2Evt/RzxXEtv38fE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Z3tBeemyquARsN/ObY/dcMIWA+urUz7+NsR7Xrl0NZ1Sy9PYV6njrO5sToeacJn7r8+01i3i/Oxp7HOCOghQ0WFAWhV1GcYJ8nGpZZEndzvcmvVGXFrXeWw2hf3Szp2j361ZAuXr7MJodFGkJR2Xc0xKXGxxGR5NKUhvIMH+30Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikAZ81ZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23171C4CEED;
	Tue,  8 Jul 2025 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981573;
	bh=Yw3Oj8jXPI3vGz0t1H7wwj43CNt2Evt/RzxXEtv38fE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ikAZ81ZFry3fjKSFkOtt6InwqkSMqgBxmwTrrpOB+O965t340fbaCF7WDvT0qjwfM
	 vEsmQEQXjE9v5Z85F1EaqY16zggFeksnxdGgC0JJy49PHAd3Eq3VsllMTru1pouXCr
	 6hiTx9ODL8Ds+cFxmRF4X/NIxb7j7k230zOgMraiL15K9dP8t/Vp5zmB09xaHLc8uU
	 NArf9CTLqCRQINvvCkZSqjkAZAXjM5Akv8MsyeuyWK55B+RG5kLlN13fxHEGNYr5mR
	 5QARjGKBx52xLQgxhq7Bx3oW4m5f7Hs+N8ZfBDWYJZ15KaNVPA78kKf8Zoe0AJjDtb
	 iXHgn1+UsB4nQ==
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1F239F40066;
	Tue,  8 Jul 2025 09:32:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 08 Jul 2025 09:32:52 -0400
X-ME-Sender: <xms:Ax5taAQz7_jhkBJqUzeezI4x0XypswLMLklWPAyDyKyLdK5fYgvdTg>
    <xme:Ax5taNxsVK3RTIpFcC3xzNPryqa4GKm3f1nokps2tDF3v3gBpNLdzgFBRPTyo2HJ9
    AkSsAem5SsnpIE92JM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeejjeffteetfeetkeeijedugeeuvdfgfeefiedtudeikeeggeefkefhudfhlefh
    veenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddvgedq
    vdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggvpd
    hnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheptghhvghnhhgrohegudeksehhuhgrfigvihdr
    tghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonheshhhurgifvghird
    gtohhmpdhrtghpthhtoheplhhiuhihohhnghhlohhngheshhhurgifvghirdgtohhmpdhr
    tghpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgifvghirdgtohhmpdhrtghpthhtoh
    epshhhrghmvggvrhgrlhhirdhkohhlohhthhhumhdrthhhohguiheshhhurgifvghirdgt
    ohhmpdhrtghpthhtohepshhhrghojhhijhhivgeshhhurgifvghirdgtohhmpdhrtghpth
    htohepshhhvghnjhhirghnudehsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:BB5taCELDn6mYiYmaFmcAwwJbvzZ-KVX7NMEuFn2Z9YAIFD9WhySYA>
    <xmx:BB5taCRokb4LBOMs_TQd09am5j7eCmE9sOnruVtIx2-O8hcSWEDO5A>
    <xmx:BB5taIMiVDSuvvVvfEmwjvOHuZlptzfWY6wL_gig784Dhb6MuH82FQ>
    <xmx:BB5taPnTe6qxleuKlo-OV37ka_fqU3-p-HwkQ3yKGEjcrPbYrEhL9w>
    <xmx:BB5taKbGSIWOsctkF8s7qsJ83tHV1DIjhsY4deHmuaf8Dc1o52axsI-p>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E4548700065; Tue,  8 Jul 2025 09:32:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0bfca88659d537b7
Date: Tue, 08 Jul 2025 15:32:31 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Jijie Shao" <shaojijie@huawei.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, andrew+netdev@lunn.ch,
 "Simon Horman" <horms@kernel.org>
Cc: "Jian Shen" <shenjian15@huawei.com>, liuyonglong@huawei.com,
 "Hao Chen" <chenhao418@huawei.com>,
 "Jonathan Cameron" <jonathan.cameron@huawei.com>,
 "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
 "Salil Mehta" <salil.mehta@huawei.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <38355e48-8eba-4e1b-8811-969a8ec3a669@app.fastmail.com>
In-Reply-To: <20250708130029.1310872-1-shaojijie@huawei.com>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
Subject: Re: [PATCH net-next 00/11] net: hns3: use seq_file for debugfs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jul 8, 2025, at 15:00, Jijie Shao wrote:
> Arnd reported that there are two build warning for on-stasck
> buffer oversize. As Arnd's suggestion, using seq file way
> to avoid the stack buffer or kmalloc buffer allocating.
>

Thank you for cleaning this up!

Acked-by: Arnd Bergmann <arnd@arndb.de>

