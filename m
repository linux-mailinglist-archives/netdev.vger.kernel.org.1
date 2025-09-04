Return-Path: <netdev+bounces-219880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0983FB438C5
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74E1582864
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D99B2BEC20;
	Thu,  4 Sep 2025 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TtMZjazK"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473B5661
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982007; cv=none; b=EYjVuKPIl4fr8YjoggembRLykqh18Uu+nguNgzbi7l0WyYqYtHVKjYi5jhtYRlGb6ZIPkI0O6sTsyKKOZA/06pgQ8I7a826ujeXfh64ymAt15w88bRMdM+MDgNWpW4n0M61Wo1injWEwURKmwV0G6twKzHgwSCLighR5/6qMLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982007; c=relaxed/simple;
	bh=NjbJf+oAzaVSfqbpRClaBTKWISkSDannBo1jz5hnakU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnCTTIAGB3t48TgsXNXhPrKW8JWbkHTkBI5rQSN1CHe/r/xkOzJqAolSHi4gR3P9ttIX7XxOYynjjQIoBQLC8rWKP61B0a5mFoLq67mMg733ia38jdt59sZfGXTYGtwxaujU21+vKmximionSRcGUvB1p5rfLLnhDueht9tB7o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TtMZjazK; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D27037A0053;
	Thu,  4 Sep 2025 06:33:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 04 Sep 2025 06:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756982003; x=1757068403; bh=NjbJf+oAzaVSfqbpRClaBTKWISkSDannBo1
	jz5hnakU=; b=TtMZjazK1WZCVEih8ZXJRPwey+zOGfDb3M7XIwzN7OZztR6DhGb
	SzBK/zjTgWWPBjgauQIOLM/g1+PeOjAMS4h2fUj0j1tyd4hWyncKFcWcjc1hrlG1
	8wjKDAfm7zKClHAupvuxto1ar8NU9N1jW7HbIlka7nI3wdyvUimDGsXe99bgL6jR
	ATMSjBeljpOtnjNKtHHbxu+vmDIQ6LvQOFBWoIbc2uLFCOZn6PTxAHUAriszdlEk
	Z440oHfVOW3WBpwpwRVzkDhUwwu2S2eXNQ36DXWC3/+p90Q7Fh/3/DKn0ImpcxZw
	lkMII3iy1ta1IeEkcw/sunhFn3yjwVnWaXA==
X-ME-Sender: <xms:82q5aNSXfzPeu1miH1U9nYh_QvqVRPXqbOMDc7rlPxF-WjQK4-eQ2A>
    <xme:82q5aCrwEFYG2tTclhNgCRou5yp4A5NPJdZJXQKWnF220PCabuGWFrcKnrzUEc0mp
    d1SgaERI-utlV4>
X-ME-Received: <xmr:82q5aP0Yf3_kcAhcqW0vPJmcZsfYB8NJy8TSSknB_ohzPmMNnMIe0XslGgHbwsg9mqkd3RNC4zNZoYQeglvKh7HZo0E5HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgthhhi
    mhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvghrnh
    epvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstg
    hhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehrihgtrghrugessggvjhgrrhgrnhhordhiohdprhgtphhtth
    hopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehmihhkrgdrfigvshhtvghr
    sggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhdrjhgrmhgv
    thesihhnthgvlhdrtghomhdprhgtphhtthhopeihvghhvgiikhgvlhhshhgssehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdp
    rhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvg
    guuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:82q5aJ5c_qW-b_iVkiIRTyl2qxqNwrNtUy860DjUvZZnq_p5Bo-zhw>
    <xmx:82q5aLScfGKT7EkzofjSvtziH3W6pmnCitX_ZS22YVzwSJcT18Xy1A>
    <xmx:82q5aOWtdqS7dcd_EyBXkk3533eNmM87DB2MHPNGuq7RrFAYNtjphg>
    <xmx:82q5aAFfatJa5Pg4I4FlrEQKS-aH1w44dVa4b1vrRJHYnscj2ZG9fA>
    <xmx:82q5aLZoKCMUb-u8Xy6Csh5msD06-_brVo1X6fa0rtORef3zhcxvlirF>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 06:33:22 -0400 (EDT)
Date: Thu, 4 Sep 2025 13:33:19 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <aLlq79or3c3brul_@shredder>
References: <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
 <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
 <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
 <F42DF57F-114A-4250-8008-97933F9EE5D0@bejarano.io>
 <0925F705-A611-4897-9F62-1F565213FE24@bejarano.io>
 <75EA103A-A9B8-4924-938B-5F41DD4491CE@bejarano.io>
 <aLYAKG2Aw5t7GKtu@shredder>
 <A68375CA-57E1-4F53-877D-480231F07942@bejarano.io>
 <aLfxueDGLngEb7Rw@shredder>
 <E0922A4A-5715-4758-B067-ACB401BDB363@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E0922A4A-5715-4758-B067-ACB401BDB363@bejarano.io>

On Thu, Sep 04, 2025 at 10:56:29AM +0200, Ricard Bejarano wrote:
> My assumption was that, due to CRC checksum failures causing L2 loss at every
> rx end, and because of TCP congestion control back-off, TCP bandwidth drops
> exponentially with the number of hops.
> So the problem is not so much the TCP vs. UDP bandwidth, but the L2 loss
> caused by CRC errors. That L2 loss happens at the rx end because that's when
> CRC checksums are checked and frames are dropped, but other than cable
> problems I can only assume that's a bug in the tx end driver.
> I believe that's why Andrew Lunn pointed at the driver's handling of SKBs with
> fragments as the possible culprit, but the fix breaks the test completely.

If you suspect driver/hardware problems, you can try to disable features
that the driver claims to support and see what helps. You can start by
disabling all of them, see if it works and then try to pinpoint the
actual culprit.

ethtool -K tb0 tcp-segmentation-offload off
ethtool -K tb0 scatter-gather off
ethtool -K tb0 tx-checksum-ipv4 off
ethtool -K tb0 tx-checksum-ipv6 off

I think this should cover it, but you can check the output of "ethtool -k"
and see if there are other hardware related features that are still
enabled.

