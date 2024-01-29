Return-Path: <netdev+bounces-66700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319ED840539
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633B91C226FB
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB8361673;
	Mon, 29 Jan 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADpsDb1y"
X-Original-To: netdev@vger.kernel.org
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F36F61667;
	Mon, 29 Jan 2024 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532232; cv=none; b=DFDBS6xZvHmdBOGUtuFTnqhdejHPrRc+jVLRlx4V37RFDJWFbeK9pMNCKiMypVzvaAH5V8ZQiPDFw9ZMHnO55+qwBvZGt+rgYTwUk4mvEDvgJEFONDaj+X5h3V4DlKMpyJ2d4dKAr1Z6KNxFYJrL1hfYSPFUmL6Hcoa27rNaTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532232; c=relaxed/simple;
	bh=8JHvl0H6ZLu9gZtMeor/rCKrEwR+9VVtAw5oJL9w5tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDgMM2iZUZOaEeIRBAffL+fVxlCT/VgMucIVNp96spH7L5TA6+m71Oj0EUGtzPGTH/DEhn8uuF1fz+ZZZW71lj4NSU/h/qZNuaEg1M0HUUO5bALhIZsPN5p3pfiVG/KlnR1YvYeqqTHDT1YBAuLEcKxo9OZOJ47bwX20CQMmeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADpsDb1y; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 255FB5C00AE;
	Mon, 29 Jan 2024 07:43:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 07:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706532229; x=1706618629; bh=bp/pipxnwgOmSTkoS3C9RemBsqQz
	I/iQDFUJKf+Dm38=; b=ADpsDb1yJZOAOyio1BZdHAl1bXVKZzRd/RcwZtWQjuLh
	Hg6KxNDgsf5teDxr40wAHopm+Nh/J5AJeKWSg8oh4rLCiNOLzSLu7eJP/jC24cGB
	R6hFy0nyglgQLUlMzklrM+Qw6IIAxxMI2asiaSDKglfamDURpUGSV3oVBPLA7187
	MZ4CjwKxBfbiJ6SXQlR7HTbpBAZdEGquQjXSC78AnHn7tBC437f3Sm1+0qoQGvIt
	fuj2DVSgowfy0iFLhRA/Z00yYt+DejqPtyL5li103iRTAvR7kfPrAuBQO6j6aU/O
	qjwX+q+gKQ2kU9P93Q7iE64Swl0MyFp/hyxG18zKdA==
X-ME-Sender: <xms:hJ23ZUozl30O0ZFM4eXmOJG7oIpF7EhmILr_T1lT4DrT3s4zt83D2w>
    <xme:hJ23Zapuow25JEspZ9WQUxd-ohKoUo20VODBUL0U2tY2O1kauv8jlTbGrTs-jgtnH
    7Zi14fyIImsu7s>
X-ME-Received: <xmr:hJ23ZZMyGww3GCOZ2KYP9EcWmx2imACrgJRCna6ij10h4ygRoHAyxch2sLOS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpeehhfdtjedviefffeduuddvffegte
    eiieeguefgudffvdfftdefheeijedthfejkeenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:hJ23Zb4GbPVxa__XK5y0pezgXF9WM3si31bC_4n8SFKz9I8psP7JTw>
    <xmx:hJ23ZT5XecQ8L2BPKVZ4UcaEM_6Xe7t-lPRZDIs-TjJYMhu-phdC0Q>
    <xmx:hJ23Zbh1Gl5aDcA7sNgg9G47NSEp9A6Po9WZCr60SI0tqKhldijdKg>
    <xmx:hZ23ZQjvdjhgmhCtA7nGMob_foW74g1CwXof3ZGHYHvqLZ4zTf7ySw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 07:43:48 -0500 (EST)
Date: Mon, 29 Jan 2024 14:43:46 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] net-next is OPEN
Message-ID: <ZbedgjUqh8cGGcs3@shredder>
References: <20240122091612.3f1a3e3d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122091612.3f1a3e3d@kernel.org>

On Mon, Jan 22, 2024 at 09:16:12AM -0800, Jakub Kicinski wrote:
> If you authored any net or drivers/net selftests, please look around
> and see if they are passing. If not - send patches or LMK what I need
> to do to make them pass on the runner.. Make sure to scroll down to 
> the "Not reporting to patchwork" section.

selftests-net/test-bridge-neigh-suppress-sh should be fixed by:

dnf install ndisc6

selftests-net/test-bridge-backup-port-sh should be fixed by:

https://lore.kernel.org/netdev/20240129123703.1857843-1-idosch@nvidia.com/

selftests-net/drop-monitor-tests-sh should be fixed by:

dnf install dropwatch

