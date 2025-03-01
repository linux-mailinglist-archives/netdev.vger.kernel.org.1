Return-Path: <netdev+bounces-170914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A2AA4AA12
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 10:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BC216A202
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4A1C5F22;
	Sat,  1 Mar 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KD+efzw6"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CB01BD9C9;
	Sat,  1 Mar 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740822840; cv=none; b=c9JSGlGb9ofFM2Ldl0n/LHwQEo7nqtc677Or6DGg6o1zaVcB9XOuEpgNg08qukpdBC5TZynsyeOfH27LyZlIBGQK0MH4D7L1XJtPoKqNDmnyIa1hRrP6DqegI0VMO9InernlyRST5xO9qvphNJr2E/k1skKIFtlFV1eoHvKsgHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740822840; c=relaxed/simple;
	bh=eqbPsm3op//La9k9/z7JupuB3rmnWYnIHpb/PIC4tVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tb4IUzPrG6flGmQVnWwjhauQGrnqomfMHbN1h6unEpZbov0LlBZXm6xmHv/HOsTqoJRHucHArzodmOYI3zJ0SLGa4jABbROjtGGTuVPrf3PyWiqMq3RhI9h1FQqMipbxseiZ5T4HsmlBN6u2gEo9fOOx2kCAC8eVN8gHlvHZZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KD+efzw6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC07B204D3;
	Sat,  1 Mar 2025 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740822835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRJEoxt60O83ppaAV+LL/miyh/fpyrDqP7zxjnOiPVo=;
	b=KD+efzw6Gx9aL3vkkXqp2yVJUaIn7T+leY97gmNLuJrC8gFLPvpP3aSeeLkw1AlfHbcbij
	e5UBkq/wk9Q155/bzKuYsJ/SBwGFn7UfssPcxyvTJvqW7GdfBsftbTBqR8BYsUdwIpVely
	504F/0upXLq8ow18saZ62POCVbqVwiu68+ab24Y4a8wk5TB51PTFj3XirKt2Nd/utMZmue
	OnG0iBd9DfBAyf1hyJm+j3q4BwhQUGHtdSr0An9bvQ85dwOWnm5IyFxNXzpCBuGM0LG+Ty
	ywdqn5u9/h6xltqAc/Avup1TYVA2BcNPUi+ebq1tNeCa9re5IibnNxPG4IEvkw==
Date: Sat, 1 Mar 2025 10:53:52 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Parthiban Veerasooran
 <parthiban.veerasooran@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net 2/2] net: ethtool: netlink: Pass a context for
 default ethnl notifications
Message-ID: <20250301105352.2951af4c@fedora.home>
In-Reply-To: <20250228182440.3c7f4709@kernel.org>
References: <20250227182454.1998236-1-maxime.chevallier@bootlin.com>
	<20250227182454.1998236-3-maxime.chevallier@bootlin.com>
	<20250228182440.3c7f4709@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelvdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughum
 hgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehprghrthhhihgsrghnrdhvvggvrhgrshhoohhrrghnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 28 Feb 2025 18:24:40 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 27 Feb 2025 19:24:52 +0100 Maxime Chevallier wrote:
> > The only relevant user for now is PLCA, and it very likely that we never
> > ended-up in a situation where the follow-up notif wasn't targeting the
> > correct PHY as :  
> 
> PLCA uses the ethnl_default_* handlers but it seems to operate on PHYs
> now. How does the dump work? Shoehorning the PHY support into
> the ethnl_default_* handlers is starting to look pretty messy.

I agree, that's the less ugly quick solution I could think of :(

So maybe we need some generic PHY dump support for all PHY commands ?

I should probably re-send patch 1 only to fix the crash, and rework the
dump/notify for PHY commands separately if this is OK for you ?

Maxime

