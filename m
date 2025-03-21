Return-Path: <netdev+bounces-176776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63247A6C1AE
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBB3189B3CF
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543682309A7;
	Fri, 21 Mar 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q4Tha0S4"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5853822FE13;
	Fri, 21 Mar 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578665; cv=none; b=kfPPRErATyXv3txotxNCxrnP/UBWSwGKbKhjFfvWGR5czTrluS2MjxusANTnjWSTVn2ymfhnuXJvqz1xU+j9YH/jcFNDhoGxM7wHtOltfaxr2MBOJ62bbv/KPfXqW0V7vlTM/9NF61Zwu8S/STnaTQGgjVoHfOio0YEEepBYJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578665; c=relaxed/simple;
	bh=EAkBRbLJ8Hcxz1m1vYEqTZwqiAioOSm5wFn+H86utSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRkWBJIrv2wt0OC9mFTBOdoLpVveuv+XwWQnguj6zxBI2a8kH2toR4OrD3NzjTSbB8A8C07CTlp/7/J/Z3Dwb8Q0oQtBq3s061bb7TaHQ53klrio11ouWMna+wU9n0Zt4WdFtUKfD+8+vUoftxuLBH49ISQbAun2KCdvLOlge9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q4Tha0S4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83333443F9;
	Fri, 21 Mar 2025 17:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742578659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCmbo9znt/hVAs/q3GMt2S44hNUyvBa9oyLpz3NlID8=;
	b=Q4Tha0S4tQ46kQZbn+uER6WLuRbC9i4sYiQ63dJNEepsIprvb5esRSHyTdk8sQ0pyjH6xK
	AdEq+hFb+2ev9WzP4MRJRMoxu2LKsLB7Emv6hJVTGPAcB62vQM5/ajwd1XUT8avdJg60W/
	yE4xGytRnA5Nkf7rLDey2m4kgnMmF8NuPUPVNuTz0vqxFmGivMkGhW4dJx8xTiv6evqdoU
	/DJDbSsb66wvhVHXLDuIxc5cQsRcpQqwVc5hNImAzPAeBKKl8q+QH8oXYD/W2DRozZyAcL
	LUWzu1nZ7O4V060JdLl2FQi3w5qI970nrYzI5U+eXUwfgG4k9yXCGFlEFYcxeg==
Date: Fri, 21 Mar 2025 18:37:37 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Russell King
 <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: Add dedicated entries for
 phy_link_topology
Message-ID: <20250321183737.594b665c@fedora.home>
In-Reply-To: <08d9509a-3291-4856-8129-1e440df10b29@redhat.com>
References: <20250313153008.112069-1-maxime.chevallier@bootlin.com>
	<08d9509a-3291-4856-8129-1e440df10b29@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedujeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepk
 hhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 21 Mar 2025 17:05:08 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 3/13/25 4:30 PM, Maxime Chevallier wrote:
> > The infrastructure to handle multi-phy devices is fairly standalone.
> > Add myself as maintainer for that part as well as the netlink uAPI
> > that exposes it.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> 
> I'd like to have Jakub on-board here. He should be back soonish, so
> let's keep this patch around a little more
> 
> Note that MAINTAINER changes go via the 'net' tree.

Ah sorry about that, I missed this bit of process. I'll resubmit on
'net' if Jakub acks this :)

Maxime


