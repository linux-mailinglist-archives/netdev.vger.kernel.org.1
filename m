Return-Path: <netdev+bounces-170208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBBFA47CD0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E3E1890119
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8424B5AE;
	Thu, 27 Feb 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HN5IATKy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zjYRfjCx"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC8270048;
	Thu, 27 Feb 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657911; cv=none; b=r+EM+xvPPFEtsAzr47rSFYS70HxDNrfbUU6cgXQ3gejkMPnYf5cy8hk17IhY5A8NBccdJ512nKXjUc3gcPjgO69ODEBoVWKxzDEhqZ7zBoXPjouAZ/O5w2GTTIcbQIXIzx3+HnIbyZq2bwKarBy7FVgkdeY5E/R0WGSlw+4Z528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657911; c=relaxed/simple;
	bh=8pN9ZtJpWnad92ETYOWFrypWE7zqctvEixPpkbJ7xl0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZZNYHdfECyGvE+Owi8weJndMfFezcAjSzc7rzjSzvalFyiQRtS7bRiZAELgLZP+KfwcysPP+oEQ+3GOopP6KwYVGo1DBB3KGUVq29LGZP4CSZAfmqjE2ACq6yuprafm9hFEZ8TrfG3Qp2ny8ql+DZnBZLLfHITYYTfvBiA6D9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HN5IATKy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zjYRfjCx; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id F04A21140163;
	Thu, 27 Feb 2025 07:05:07 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Thu, 27 Feb 2025 07:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740657907;
	 x=1740744307; bh=wR1yJ7+sfWbEGLOYHNHHr2Z5z5K7L8QPIipqy40eWks=; b=
	HN5IATKyqc2W4FueNuOQhB//31RcdqjDp6IGbejFqjp8X49ngbkIUeef+Vz3uFka
	LHT/XQ5GPhnxy/qD6Mgn75DGQDBbehVPsjd2w2M0GFdU9jpMhsv/+SXOkd7NhENw
	Ydkz/7h/LYp2iszauo0vQIcRcAo5GOjG/uV6DBCem24qzbZzhbpZggJhVUfJdEk4
	nurDYGfnHuVr4GPgA4TcCd+PWGMy5JUQLKfdhZkp2pIZqqj1nH924dVwF+6jidez
	L5T0oSIb/PQ84xdBrMAQ4Eor6VisqUENCKeK91FrOGW4jR9pKpnVvpHrO+9H9Vg2
	GpKK3HZSh90Bu8VQbo8zvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740657907; x=
	1740744307; bh=wR1yJ7+sfWbEGLOYHNHHr2Z5z5K7L8QPIipqy40eWks=; b=z
	jYRfjCxJ2cPXcbh5P5cSNeAlGxJqU0E7HiFSuPuUtjBOPbSuaCy4/I1rgl7R1uGL
	6COMISQyRMu2tQFFKITm9SljU+FCpVyldGhgF5hhBibiHmaDjx75Swd/Zs3P4YOt
	EDPavd5j3dVfG/hjujLoAO2WSBYFg61lHBz6eSQfj/YGj8hWqYXI2WXUDOpe2s53
	JIlvYT4wbcwb0ezNaYnU8msVwjGmpHZsrsFIbyD8K7UTttIP+hrfaooZDzqCcySL
	KpnTf7kO1A0p+qyoQhmHnmz75pc46lTMVNIGbLU0qxqk4Pf872DEQs5c47z51vG+
	qHydthYNUmFQu9L062iIw==
X-ME-Sender: <xms:8lTAZ7KqEZSAM3nBSCA8Xk2nhBCGCYTf3o8IUb0K78u_DlwvzfA0ZQ>
    <xme:8lTAZ_K17-qWr38d6amvOensD6RaEB5GHjDzrOcoH4-aNrPQdvnIqsU5Roa1wZyNc
    aziUw3nXHn4v2W1S8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnh
    highessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhl
    ohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgifvghirdgtohhmpdhrtghpthht
    ohepshhhrghojhhijhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepshhhvghnjh
    hirghnudehsehhuhgrfigvihdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8lTAZzs8APRGeCK3xKVQLOEZzJ1mN53J34GxAQEI_jMuij28X512XA>
    <xmx:8lTAZ0YTfg_4FfIRrXYYkdP1caULsA3qkVo55TTmf0bYKXEG8V3LWg>
    <xmx:8lTAZybdypKjL98ayHQ1Og_jG--RTGRWv7RqRIDq_KC_z2hirIzn0A>
    <xmx:8lTAZ4Dp_hYygRJJJgA7nPpl3lXaDI9x2SB-m9b5IgK6j7YcGzrVVQ>
    <xmx:81TAZ6o2w1SVZVGrvyhEbSb-HmYZLJ1tKKNDO5LwngpgwaRiWqLixpsf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C122A2220076; Thu, 27 Feb 2025 07:05:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 13:03:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jijie Shao" <shaojijie@huawei.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Jian Shen" <shenjian15@huawei.com>, "Salil Mehta" <salil.mehta@huawei.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: "Simon Horman" <horms@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Message-Id: <c28e16ce-d535-4af4-972b-e19376833235@app.fastmail.com>
In-Reply-To: <3e477135-981f-49bd-8e54-0c3ecdcc8a19@huawei.com>
References: <20250225163341.4168238-1-arnd@kernel.org>
 <da799a9f-f0c7-4ee0-994b-4f5a6992e93b@huawei.com>
 <c0a3d083-d6ae-491e-804d-28e4c37949d7@app.fastmail.com>
 <3e477135-981f-49bd-8e54-0c3ecdcc8a19@huawei.com>
Subject: Re: [PATCH 1/2] net: hisilicon: hns_mdio: remove incorrect ACPI_PTR annotation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 27, 2025, at 12:53, Jijie Shao wrote:
>
> if CONFIG_ACPI is disabled, ACPI_PTR() will return NULL, so
> hns_mdio_acpi_match is unused variable.
>
>
> So use #ifdef is possible and has no side effects, and many drivers do so.

Those should be cleaned up eventually, but that is separate from
the build warning.

> Of course, it also seems possible to remove ACPI_PTR(),
> But I'm not sure if it's okay to set a value to acpi_match_table if 
> CONFIG_ACPI is disabled.

Setting .acpi_match_table and .of_match_table unconditionally
is the normal case. Historically we had some drivers that
used of_match_ptr() to assign the .of_match_table in order
to allow drivers to #ifdef out the CONFIG_OF portion of the
driver for platforms that did not already use devicetree
based probing.

There are basically no platforms left that have not been
converted to devicetree yet, so there is no point in
micro-optimizing the kernel size for that case, but the
(mis)use of of_match_ptr() has been copied into drivers
after that, and most of the ACPI_PTR() users unfortunately
copied from that when drivers started supporting both.

     Arnd

