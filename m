Return-Path: <netdev+bounces-194213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A92AC7E21
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7009A42067
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872122A4C5;
	Thu, 29 May 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="EVKOxJgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nKz488em"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B34A06
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522742; cv=none; b=j3yj1AihpLOFKhgj1lfjvf4V67MoFnwJfIT+7lWdiQbLoqkV1DI783anD+hMhbXSpf3yl1atKAmXmbxVmhdcK5FzQ9WOD0pqlwHy9NE9TiyGr9AOb5U3594xFmZ/kAU/6gKfshcjeucPq814ojwRvDQwFMEu1bqjguwacZCznDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522742; c=relaxed/simple;
	bh=ygyzvz1iJiz73Tgi2evP5cN7Yw0aVq6NuYCUauEmqfM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LBXm0J5KsCkrG8XtuWpCscVWgMliN004x3bxtoEaN6NUE2oSM2ZdHdMQlbQP2DYVqAgE07IkPss9B315TGgEg6qjveAiEoUGN7GfPi3H7WhPVMWoELCi2IDfeChyqUUHMO+wNNLLteRH9TA77wpKkx4YkVsgxyqyY0y47W1p1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=EVKOxJgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nKz488em; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FF07114014D;
	Thu, 29 May 2025 08:45:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 29 May 2025 08:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748522738;
	 x=1748609138; bh=ygyzvz1iJiz73Tgi2evP5cN7Yw0aVq6NuYCUauEmqfM=; b=
	EVKOxJgZjnRc4CrL8IK3Ud2xTCoEGQLFlif3LbBSmlDjhodLsyjZZp1RBDHGTVX1
	vgJDrSTIgQkyC9iipTtg/p+Lgw6kqzQACFSYCP4a+d4N01VZOrni2cBwdJzzudAn
	itxztZsiIePpbLcFPbpPiBkPqTYxC3sAcv201VAjMoyDVx0K+++uLC7gU9/s029j
	dx32eJqGYuCJJ6y/IhfH/Zvqtq89f+f8JQbJqc/HGMnW3Pmb1nt/ZAA901qMv/Ma
	ypE0aLfRVywXHX5op+R6qDzaGe7TYvCMxsRISKeb/lz8AAGIP7jZI/pcZKLOa+rN
	pm222wmOBHzE/0wMdz/cvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748522738; x=
	1748609138; bh=ygyzvz1iJiz73Tgi2evP5cN7Yw0aVq6NuYCUauEmqfM=; b=n
	Kz488emP0DyhUOTPyn4I8utMnpeYWY2dZTU7dkk1kSFYhw0rGHI2zZQUqzQv76Ts
	0INCHZ9v2hswdkWIS7ATIV9cyhUj/k4TZG9pHgbmZAyk8EHCB+ZzXHOpWHRV/seg
	a80KAQc+cb/xoE9ISnIf8GzzHUrYZpy6fxqF+1EUTUH5lOpkT5OYY8wR7H7JIm4P
	eG7Q8tCAWdWHHTHe5oYICSt93nDJIHHk5piF1gCNiMh8JMN7QFFzh7ofAPCxm5Zo
	rLnf/xV92iRXocK0SZcJB9DxvpXL0rVH7DVZjPzKdvFZCfBB0oJsz8xRq6S3pEXy
	mToZcCxzhQRgtKoii6uUQ==
X-ME-Sender: <xms:8VY4aMInJkGZ5-IKPEUrJnZ-_v7EnHITN-jX0rkoHzXQdBTBVyFOgA>
    <xme:8VY4aMJVxS9S1dzfk5vOffkI7eYfIcMyPHCNn9r8zwTKRzoNBRhl-BmJ_8E-XMazM
    NgMxqnO-r9ZOx1yF_4>
X-ME-Received: <xmr:8VY4aMsnSuRQ1W-ACHRtQ78erGZLsCh1D5BFsJFQFSihi8yQq8axQPbWgI18FflvwPfTb2NY8oDJMvWy0jrKY_rvW9Pt8RusIHERcrI0g4s-XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddviedujeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnheptefh
    leekteffhedtgeekudeivefhgfevtedvgedtjefhffejteelgeethfevhfdunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegs
    vghjrghrrghnohdrihhopdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepmhhikhgr
    rdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgr
    vghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohephigvhhgviihkvghlsh
    hhsgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehl
    uhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprh
    gtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8VY4aJa_WtHZtCP936qs_Ov6JGo9xSojazkz4dATziwl9rCmkMT6gQ>
    <xmx:8VY4aDYbUJry5ZBNZ09uH7FeK4Ipsns4XfsyRbh8vRjRglfez4DBbg>
    <xmx:8VY4aFC2PBddA0V7-giWQmBG030g93b_70xJ7Y4sMhYoszdrWlw7Ng>
    <xmx:8VY4aJYRA1UE2BigHd6SQft2OMQpXmSOldiPW_wY2JSvUdA5fN8egQ>
    <xmx:8lY4aLgm5qLP8WP_vy1u_v75vAH9MW80S6suEI_TcP9_-dx479UXzErJ>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 08:45:36 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
From: Ricard Bejarano <ricard@bejarano.io>
In-Reply-To: <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
Date: Thu, 29 May 2025 14:45:34 +0200
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
Message-Id: <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
References: <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
 <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
 <0b6cf76d-e64d-4a35-b006-20946e67da6e@lunn.ch>
 <8672A9A1-6B32-4F81-8DFA-4122A057C9BE@bejarano.io>
 <c1ac6822-a890-45cd-b710-38f9c7114272@lunn.ch>
 <38B49EF9-4A56-4004-91CF-5A2D591E202D@bejarano.io>
 <09f73d4d-efa3-479d-96b5-fd51d8687a21@lunn.ch>
 <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

> It's interesting, however, that the number of TCP packets is exactly =
twice
> that of the number of non-linear sk_buffs we saw in tbnet_start_xmit. =
Not that
> it's suspicious, if anything (and because we see those TCP packets in =
blue) it
> tells us that the handling of non-linear skbs is not the problem in
> tbnet_start_xmit.
> But why twice? Or is this a red herring?

I've confirmed that all UDP skb's we transmit are linear.
All non-linear skb's are TCP.


