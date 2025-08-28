Return-Path: <netdev+bounces-217639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8E6B39618
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D721BA4FEE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 07:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513642D3738;
	Thu, 28 Aug 2025 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="O6pjm2Ev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jSLmWmU3"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21C277C95
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367973; cv=none; b=fQdFp59kVJxt8vFihmjL4AAsXbsImou65WuHGYW0As89hjlXfYSntcXNCnGLpQ1ebKotyOLDqovc25kbp9sKhyDNBrrPcDEQAfLR+Kks11OyjM4DFSF15+MHnoRgk0/wolBuCiC40Yqq7T3k7F6Cb+7yuaphKgjX/lxvH8Rm780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367973; c=relaxed/simple;
	bh=xtF3W4C9qXT6Kmx6qjBDzMmdl68F0egehO8ayBK1Ig8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GXZG2cg9GP1raJNqCJj8IzMWruHTp3DfVbKwdQGocGERK0aIHdc2ThX7f88/vZaU6lfQSjiBlUSmPM90CRqpz7Cz3IU1yi4UHWrg+NbxcgJAjaGsM9rB6SMhw2JArRPMuNnzsWhGPvZysHlOJ5HSbHdcS4dzCxiFviH+kqRwBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=O6pjm2Ev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jSLmWmU3; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E3A93EC0388;
	Thu, 28 Aug 2025 03:59:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 28 Aug 2025 03:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756367969;
	 x=1756454369; bh=xtF3W4C9qXT6Kmx6qjBDzMmdl68F0egehO8ayBK1Ig8=; b=
	O6pjm2Ev5T8CtwqpxkHRIbGncittvbaWwsa7rhCPMYds9PUm/it7jnInSRx4r2PQ
	4zeTs3mLzzsfNU+f2Qnd3ePvMnpVvYEj4l/yQHIdmjxTXvjyke+bjEr7zpAfxswb
	ONLxx9cG+dZUVs9YwwAMY3WLstoUuMUSct6RuI1+gQdGZvFosL/e6+R/70siOOZk
	sCqm5wE452x5gkMWGPP++ez+vwUg7GOLH80eOPVUAKJ26qEAP7EPH5nuHvCDMH35
	TJKDNckhnP9uv8L1vvC8sF4N35ULd7DOVb9IFj82wYY2451W1JKF2ERyi1IqPVqU
	FvoPjKANQRljtfpVlJUuHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756367969; x=
	1756454369; bh=xtF3W4C9qXT6Kmx6qjBDzMmdl68F0egehO8ayBK1Ig8=; b=j
	SLmWmU3GjgiItFloC2eUAn0XG6+rq1YJ/B8xPGyc3uIFqHNHdTVRLWvaN429DTrl
	y5W6cSTd//kbVVBzQ55iz4qtWKp+9V9+CkrAeis9QbhZpmuRN2ZART3tXGGiDIX7
	JStO9PgN/g3QQf7oNKtge/aXnt1Sg05ajTbXDMlIXZlbQHQjhuxrM2P3qpcSkvDK
	JrKFCWbqiQoIlnKR8scvfhg2vgjmjP15kjvMWaDYXd7c7SyeneaC7mysOgvM9PBD
	PiU7AsFMYgL+e4xqAUP3VObwKocn4GqcM5ZbtM5BfraDTB2QBQoXyQDlUMrX7iXs
	qS6JAvIZ+i6OxwzyywleA==
X-ME-Sender: <xms:YQywaD5x5wjdxETdreDu15YU8Xtv1_zK-rk0sJRpp4T11rNpMs5ilA>
    <xme:YQywaGTDjj-lgB-PqAAEOObQxNYnoShVw3xvr5H5HNShiyrKloptJYJ87Zz3OxovX
    aIga9JWwnjITBl0JVA>
X-ME-Received: <xmr:YQywaByBhwRzvqP3hF-ZAl6WJ9qeY534r0Qh-qr5rKxR8GUkxxtFiUlgKeRNoxzGr2aEVyS-erFFMbrsMZN0GLiovjy4MdrzEJgzD8LddRCswQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedthedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtddvnecuhfhrohhmpeftihgtrghr
    ugcuuegvjhgrrhgrnhhouceorhhitggrrhgusegsvghjrghrrghnohdrihhoqeenucggtf
    frrghtthgvrhhnpeethfelkeetffehtdegkeduieevhffgveetvdegtdejhfffjeetleeg
    tefhvefhudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrihgtrghrugessggvjhgrrhgrnhhordhiohdpnhgspghrtghpthhtohepuddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprh
    gtphhtthhopehmihhkrgdrfigvshhtvghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgt
    ohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhitghhrggvlhdrjhgrmhgvthesihhnthgvlhdrtghomhdprhgtphhtthho
    peihvghhvgiikhgvlhhshhgssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvg
    ifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YQywaOqJQY0NU4OY7PBo1XGVIukuzOCmvdjehFqYNHtO6BBHczNFFA>
    <xmx:YQywaE0F-tj8dEacrAz6XrRRmqXrjh5uVOR18eBOHZKSaBGOIWbbgQ>
    <xmx:YQywaOwxrjVUpGw-QtZ5_9eWCCnqDEYbIj31y9xh1EfdL6eK7SatuQ>
    <xmx:YQywaIjPDWxHnJiOTCAwcHofp0YqrHGt_E1EduyX6A8586qUupPnlQ>
    <xmx:YQywaOQtu9BT8VcQn-we9oYx5B8uIqA_PqU-b1jhWkC20IcSc2L5gUpk>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 03:59:28 -0400 (EDT)
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
In-Reply-To: <0925F705-A611-4897-9F62-1F565213FE24@bejarano.io>
Date: Thu, 28 Aug 2025 09:59:25 +0200
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <75EA103A-A9B8-4924-938B-5F41DD4491CE@bejarano.io>
References: <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
 <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
 <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
 <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
 <F42DF57F-114A-4250-8008-97933F9EE5D0@bejarano.io>
 <0925F705-A611-4897-9F62-1F565213FE24@bejarano.io>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81)

Sorry for being annoying, but I'd like to float this back to the top of =
your inbox.

Anything we could further test?

Thanks,
RB=

