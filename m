Return-Path: <netdev+bounces-172334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC456A543D7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575D63A4E22
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 07:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93E81C84B8;
	Thu,  6 Mar 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SuXMt55W"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E5184E;
	Thu,  6 Mar 2025 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741246939; cv=none; b=fJw0OqMzxnrxrc/gyMIkewSzMAo8QQ39rFLy0FuRrMR9RBluLILDT4eURc4Nq6HsNHsgb4v+IbFpIyfBQUNCktkCmkm60J4hRLQOCFzVmMtGGYbmwSsM5WjOFST4otfr+LA7KBhNj8Vo1hBgW9btuoQDLgOtAyebA+Abs/XoJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741246939; c=relaxed/simple;
	bh=F93TNatBfwgiPsBEPPu7EdB4/RZAnlqun61fYvReQWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GsIJ2ijqASYtiLcCqcv0KAGetVJoAIzOMmheW8l6FclYrg0eqdv+PzlaVr14QdTb/JKFa8XyNJTLAH6hXaGY82U/Ia84pPaePloC1Iz08CkGFbMhd2ZhTAxRgRUG9mbEc/E3vqEio+90fswXT35kjvcl3jnqqwLbLFTA5JZFNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SuXMt55W; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0BD7D442CA;
	Thu,  6 Mar 2025 07:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741246928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xoURsCfOKW/dz0Jqi7uXc/ZFxx8fcEUzD+XtCJ3Q3s=;
	b=SuXMt55WxRBIvDxHEMAAOlvC/+AA+n7CeEr5M+yDIrFE5ml2rzwpg1c5GpDq7pwU6lp83B
	Bn+bnzV5UlLIfdz8g7Yovz9VfOw3UNNY2NzFBCaTCrzCyZs1OJUAmv71hZXq0H4i7eXogl
	mDcEPIq3ZxhtM3irJpADhradX2IGZl+oVYjmNoM0Xq+vrx1knAH614E9HwPm644aiDKxin
	W+EVtusIT70HhOjkFspQWVDEmWsjtfSDznxx+PenKppqQwWdEzIIrgD8FCd/JkqvXSpzO8
	BnkiZxUpeITdopx3NvEELgIdYMhXtURLNJu9YbPdDehtMQX/z/FSgec68y11IQ==
Date: Thu, 6 Mar 2025 08:42:01 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next 0/7] net: ethtool: Introduce ethnl dump helpers
Message-ID: <20250306084201.23885f5b@fedora.home>
In-Reply-To: <20250305184749.5519e7a9@kernel.org>
References: <20250305141938.319282-1-maxime.chevallier@bootlin.com>
	<20250305180252.5a0ceb86@fedora.home>
	<20250305184749.5519e7a9@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 5 Mar 2025 18:47:49 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 5 Mar 2025 18:02:52 +0100 Maxime Chevallier wrote:
> > This series will very likely conflict with Stanislav's netdev lock
> > work [2], I'll of course be happy to rebase should it get merged :)  
> 
> Also this doesn't build. Please hold off on reposting for a couple of
> days - because of the large conflict radius the previous few revisions
> of the locking series haven't even gotten into the selftest CI queue :(

Sure no problem. I'll try t figure out what's up with the build in the
meantime, looks like I inverted a few changes that break
bissecatability.

I'll keep an eye on Stanislav's work in the meantime as well.

Thanks,

Maxime

