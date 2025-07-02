Return-Path: <netdev+bounces-203342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F820AF5845
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F24E188A634
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0A2749DC;
	Wed,  2 Jul 2025 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="prUhDMFn"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81823275842
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462071; cv=none; b=hf9DnsVfi7T3aHjnwiFNEZYnI8BnV0tBv91aCTznB6SLNjbYM5CeWE3UPSsZyG2XxajOawI3OFqE3Ovs8XWqmAzwvt7ngbEkVwj4CGe5aOH7au/gFqHFVfi9fuVW4aIXh531KO6gnnxsAKc0wpncWcl4e5dvVoT5se/t69EMIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462071; c=relaxed/simple;
	bh=o4Iiu/h4IKU21VASavkLOWNZ9A6LagKtunIrmffLpw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sQ+vi6+pJwwofXIsaCwTbg92k1VIsSsdBOHfGte77wfp9RuvBDNs1GP21Q+Qt/xiYWdig4FuxzHXgDZmd9oC456MBSUN92kZe6nmdhf0nFWVBCz0XZnPzPlC//8Q1LVadX96N0XMgJg0QXKugUS3C7oDp2qPZMjCzIDU5IAGL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=prUhDMFn; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F77B43860;
	Wed,  2 Jul 2025 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751462067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eraaOGuJ3zqe10UEa/IIi8D++KNRuKewmJ5vkY4y8HA=;
	b=prUhDMFnA7rQhuRdoNNhCZFu7S9z35XS1w+Egd8oJfhFIrHDxJ3fH70h5dYsd+pe0yO5oU
	mpIy5eb1njqj9zPMyKdMGctduU0+B3LVD25+zraS/cfZn9Vuc6RLTQnjkANoR/1NWvQRMq
	tr3HxB/pRQyPuoiaezTZfno9cBydr4o3zesvGA6SyKGxSxIIbM2VPRybwOzvSPltyIV+6c
	0djoaWfn0WYleuOIeyxOc4dsExC20YslBdTtQPvWDCoZp08NheTXoiPeAmrbCOMrRVHitp
	FeEWeMqjfDOSo/5z+zcCDhXFeZQUsglQq0zZcKB48fbCDjcDz7qKCdwacpwTbQ==
Date: Wed, 2 Jul 2025 15:14:26 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add
 phylink_sfp_select_interface_speed()
Message-ID: <20250702151426.0d25a4ac@fedora.home>
In-Reply-To: <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
	<E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmp
 dhrtghpthhtoheprghlvgigrghnuggvrhdrughuhigtkhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 02 Jul 2025 10:44:34 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Add phylink_sfp_select_interface_speed() which attempts to select the
> SFP interface based on the ethtool speed when autoneg is turned off.
> This allows users to turn off autoneg for SFPs that support multiple
> interface modes, and have an appropriate interface mode selected.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

I don't have any hardware to perform relevant tests on this :(

Maxime

