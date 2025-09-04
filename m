Return-Path: <netdev+bounces-219841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9518AB43655
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 10:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF1857B5E74
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00142D12E0;
	Thu,  4 Sep 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="cM2iotGX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lgOOfTy3"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6228D2D061B
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976197; cv=none; b=giKJsrhjjZumPtZlCIONgZkWq/LjHoO695wwB8kfsXSJqkSBlLlznzjzJWZDh3tfk52RWq8UEYhF88hQ23N1+g41FNSYUCI+92UsIlYAJWAkwm59faUqU/IDpzGb0mh3UMvTWzRbG9n+7u+r2aP4WWVQw06b9wbwdx+LnjsbMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976197; c=relaxed/simple;
	bh=sKXetZtnyPk0BVKXZ+BUqLNx0KAVF2FTBQY4LjhC+3g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t9fW1eneQGe+2j+bL/WF5l+sInKA3CIrIC3iJLFS+RYttZY5anBEc6VwCRZXX3G1FKxwt/qXEQds23m9fM7dupzgteNnmTD0LIMKf9+FoewM4Tba0Em/8gKgqlShgYU88zAPygxnEU2nDEd9yhO1CpwgoWFawKQYXEM5JomHW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=cM2iotGX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lgOOfTy3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 73DE8EC0212;
	Thu,  4 Sep 2025 04:56:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 04 Sep 2025 04:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756976194;
	 x=1757062594; bh=sKXetZtnyPk0BVKXZ+BUqLNx0KAVF2FTBQY4LjhC+3g=; b=
	cM2iotGXb1LST8wR8ipn4T8GZnr9QxteDOouzmFXKpj1M+FwKstJNuyDUCh2G/Vz
	zX/sRpC83v39FI60cxqRfuTM6fRh3+LIepBQiokniXlO/R/ZY38VKFCr9LuH+KhS
	4LVvoEY1y3LO1qnSP6qV9mkUZ1UorA0qk5et6yR8x4vs1hZ53i1ZG7jbd9s1tQtk
	ETzuw74RO1ly9+nnsKM5fac1BtCmOj/JtA4VWw4qPJoyLpJZ17O+3CX+VbX00leN
	mw674MugljnjfsPhGzPjvDy+IwTfK94OJ4uvHsZYE8/z4ogMmOCbJjbc5YXAgOAP
	XjTTVW6Ofo7yUatpFcuUXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756976194; x=
	1757062594; bh=sKXetZtnyPk0BVKXZ+BUqLNx0KAVF2FTBQY4LjhC+3g=; b=l
	gOOfTy3+gB9rvqu5XlryR+vebh2C/DOLHqueRbo9hBl8J0VarJClsu21HF01VR9N
	6xCDZjAk0Yu5G5Ay1Bw36t5Q5n2Mf5pWSc0jblFcT9Toz9fE9xX1A6W+AKUFi3e1
	5eQSw9cGDSseFmG7TXS2s8Nhg18q9HAmWZxsL/XR0sZCOk+xOP5lFXoeeGERKLMW
	BecWC9HwdHUrosr1c9vaLKnNi8dqktNUvP7Bek+VFv0kxmGjlR6lolKnzrrHvFHc
	YZVTi425C6THbpcELSYX4VHK3GjiNnL31rX83w5hBElx+BfFEmWI9ran8Iaqiy9z
	QNeoveak8196f3gS8tGxQ==
X-ME-Sender: <xms:QlS5aHQRL4MtNp-JtGetX8UG7R0MF0J706t_M52wggn5CmKMcXobNw>
    <xme:QlS5aBbq9srV8-s5VZDZ_Uu0aLA2x6DuNyAFHqleEQ3LYdy2KRrH1fZO819PN0ptF
    hm3Oks6OtH9GowpL0Q>
X-ME-Received: <xmr:QlS5aERCnhhywpfNVMgz_0niMHruEJFA_773qCU-XRQ-zSPPLyPORVBR79jtfLxC-wSjtNtygukztzAnTDVk7-jvInuMs5X9KlzxIImd18atvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    eptggguffhjgffvefgkfhfvffosehtqhhmtdhhtddvnecuhfhrohhmpeftihgtrghrugcu
    uegvjhgrrhgrnhhouceorhhitggrrhgusegsvghjrghrrghnohdrihhoqeenucggtffrrg
    htthgvrhhnpeethfelkeetffehtdegkeduieevhffgveetvdegtdejhfffjeetleegtefh
    vefhudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hrihgtrghrugessggvjhgrrhgrnhhordhiohdpnhgspghrtghpthhtohepuddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehiughoshgthhesihguohhstghhrdhorhhgpd
    hrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepmhhikhgrrdif
    vghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehnvg
    htuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghl
    rdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohephigvhhgviihkvghlshhhsg
    esghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhn
    nhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:QlS5aA9qZoncYw7CCVo1JnbXGgrCNrdskxc_zsEzhlr2IhyKYMwYDQ>
    <xmx:QlS5aEgN6gjRIzMHnxtDBDVxTipDlLtoQfSRI8nhja5kWSX4ZElWFA>
    <xmx:QlS5aBaRR4o41lH46UQFUad5Qw8MB8QxDyKvBXz5XhZCDMVXeoWWEg>
    <xmx:QlS5aJ_HyDPBJy7V4TY9C0WwDI53PXcqVGs2aaAAa6_Ki-F3fMEE7w>
    <xmx:QlS5aNiX3XOZGidTPVN5bJPWBHKCUeNHURqblAFlp1FP1AdO11071YWI>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 04:56:32 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
From: Ricard Bejarano <ricard@bejarano.io>
In-Reply-To: <aLfxueDGLngEb7Rw@shredder>
Date: Thu, 4 Sep 2025 10:56:29 +0200
Cc: Andrew Lunn <andrew@lunn.ch>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0922A4A-5715-4758-B067-ACB401BDB363@bejarano.io>
References: <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
 <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
 <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
 <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
 <F42DF57F-114A-4250-8008-97933F9EE5D0@bejarano.io>
 <0925F705-A611-4897-9F62-1F565213FE24@bejarano.io>
 <75EA103A-A9B8-4924-938B-5F41DD4491CE@bejarano.io>
 <aLYAKG2Aw5t7GKtu@shredder>
 <A68375CA-57E1-4F53-877D-480231F07942@bejarano.io>
 <aLfxueDGLngEb7Rw@shredder>
To: Ido Schimmel <idosch@idosch.org>
X-Mailer: Apple Mail (2.3826.700.81)

> I wrote that it can happen with forwarded traffic, not necessarily
> bridged traffic. Section 6 from here [1] shows that you get 900+ Mb/s
> between blue and purple with UDP, whereas with TCP you only get around
> 5Mb/s.

My assumption was that, due to CRC checksum failures causing L2 loss at =
every
rx end, and because of TCP congestion control back-off, TCP bandwidth =
drops
exponentially with the number of hops.
So the problem is not so much the TCP vs. UDP bandwidth, but the L2 loss
caused by CRC errors. That L2 loss happens at the rx end because that's =
when
CRC checksums are checked and frames are dropped, but other than cable
problems I can only assume that's a bug in the tx end driver.
I believe that's why Andrew Lunn pointed at the driver's handling of =
SKBs with
fragments as the possible culprit, but the fix breaks the test =
completely.

> Assuming you are talking about [2], it shows 16763 errors out of =
6360635
> received packets. That's 0.2%.

Those were aggregated counters, they include multiple tests including =
some
below the ~250-300Mb/s threshold where loss begins to appear.

> I suggest removing the custom patches and re-testing with TSO disabled
> (on both red and blue). If this doesn't help, you can try recording
> packet drops on blue like I suggested in the previous mail.

Disabling TSO on both ends didn't change the iperf results. I currently =
have
no bandwidth to do the perf tests.

Thanks,
RB=

