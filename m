Return-Path: <netdev+bounces-169319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EB4A4370D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02C03BAB23
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9837225E46F;
	Tue, 25 Feb 2025 08:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pj3jIVHo"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38625E464;
	Tue, 25 Feb 2025 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471033; cv=none; b=mA7IG6TohXjtlxxRAby6n5r1u9e6DaMkIzn6DkQnr1bOUZpP+qiuzHrP6UBhIWmt5ynLJd/gipXBpa8p7CeJgdhrLagU49vVCa/QM/lIaOJi616XpkHDx+UkgcXR3wu69necJVd8Pazhfd7+JZyEHGkpxz+g7jGOAtZ7ZQz9sBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471033; c=relaxed/simple;
	bh=+svhfhYuJY7OVs+rmd1ZfwBLwkNKNJf0d25JfNojUlY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wq+gWndfymIWYEofF/wr1h0WEo62+qivxybFnuEvzAXYXram2D28eoa9E6dTHJricg8VBIB1WZA54VygdGO5OyRTi/gzQ3uS7bBC0Ry0EMKzI3iAtm6dVRVPCqH3nvlS5mI98+V/6iOGqECZgwlvfxZvCNfY4I+gLMZxBw3UgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pj3jIVHo; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD84544367;
	Tue, 25 Feb 2025 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740471029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi+Na0fzjBWz9wqBgnbiA7m300Bd7Wdc0xgW8pAyLxE=;
	b=Pj3jIVHoLwdm61MlRS5kqdr8Oumi0jTCd+jmjq5fz7CESRhuqmw4lb5It5k3vaPjkSJMWa
	KHA4RkOw09deCogM8X5t01+5JDLgH9a/M8YbVMT/I6v2IQBd2tWo6dUeLlsxOPb8kfRaD9
	NdKfLoNuklBCsI7jsU7FUU5I8vHaDXr4BLKzQa5UexeXFj4FmJslmStstHVY55fR3ljyC2
	GYcpzOLjii/iYEY3TWRCqreuHgnDnUp8xCnrdHMHZ40xrMP2imqoCSB9ynWBkMA2v/rh41
	mnjqbQEiWhRdYJa8fc3m5vO0fz+VtxtLb12KkF8kXWFof8GsBp+w16oC3YU5tw==
Date: Tue, 25 Feb 2025 09:10:27 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Harshal Chaudhari <hchaudhari@marvell.com>
Cc: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: mvpp2: cls: Fixed Non IP flow, with vlan tag
 flow defination.
Message-ID: <20250225091027.1af0384c@fedora.home>
In-Reply-To: <20250225042058.2643838-1-hchaudhari@marvell.com>
References: <20250225042058.2643838-1-hchaudhari@marvell.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekuddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehhtghhrghuughhrghrihesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopehmrghrtghinhdrshdrfihojhhtrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnu
 higrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 24 Feb 2025 20:20:58 -0800
Harshal Chaudhari <hchaudhari@marvell.com> wrote:

> Non IP flow, with vlan tag not working as expected while
> running below command for vlan-priority. fixed that.
> 
> ethtool -N eth1 flow-type ether vlan 0x8000 vlan-mask 0x1fff action 0 loc 0
> 
> Fixes: 1274daede3ef ("net: mvpp2: cls: Add steering based on vlan Id and priority.")
> Signed-off-by: Harshal Chaudhari <hchaudhari@marvell.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you,

Maxime

