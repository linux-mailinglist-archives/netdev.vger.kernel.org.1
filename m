Return-Path: <netdev+bounces-195369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF99ACFF39
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8067A26C9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF126A0DB;
	Fri,  6 Jun 2025 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dpuu8/J7"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE627468;
	Fri,  6 Jun 2025 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749201868; cv=none; b=mQWTtAznusWGH+iaDSW9It/lajTPE2Hc3pj4J5FLg5LzU8DIa27Ttkgg2cS23K1Ww0azhjuGTUiwq7kCnsFtRtIeGntvks1Yx/RI8iUscPw83JwWLgq1nse+fqio0PeJlTIEZwOHRUwAqiQNTwKVtb3L0WZ52w6T1NvhGcl8u7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749201868; c=relaxed/simple;
	bh=f+Wxw4EM39rKBgY0c49H2GDg+nabb6mWi/XNe/6zCY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3O6w0Ekqtccr5rCLSWUvitnRxkeTrLmNERxX1Esp9nqLpqvWnvZaXzqWshMWgPMUWfDBdH4S3swFaiT7QIeHKZ46RiwvZKZwPvqU2woGllr6QvpcXp9vfDx0tkkd5eWo0IgjrbcvpyqkI4O4I17rWakMvQd5caFfn+7ewaRR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dpuu8/J7; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73C1843423;
	Fri,  6 Jun 2025 09:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749201858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+Wxw4EM39rKBgY0c49H2GDg+nabb6mWi/XNe/6zCY0=;
	b=Dpuu8/J7iTIRvepQ76q8ahXSHCKRbL8PLInN/k6elyJCxgmevhisDvZIEEx6PPg27bIO9Y
	2Ij0dzH2w02Razsa42UjkCQ6rOr9amM6qkH0o9G06pM8r8vjT6rRiC7OdN8GZDhj9Vigp7
	8v8oFY3TK41DuEEjC9F0FHGlHjaHJKdgjGtizlxUBKgqqtZMRHaLYNBnXVSWj+JXcWGcVB
	L3S0Wky0nRqFoyFobwwfgAUIGslOu6KV9co2hLB0MGDUTQBshtj5FMb+q3SJvMbFCunZCk
	gfuUJdH7Yh9EQGldDmJo98aZWpw0DLBeOR7JcGvE2buGZph8+AeKPsMS1iRN3Q==
Date: Fri, 6 Jun 2025 11:24:11 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net] net: phy: phy_caps: Don't skip better duplex macth
 on non-exact match
Message-ID: <20250606112411.69b1a3f9@fedora>
In-Reply-To: <aEKnQ4haQtcJWzXX@shell.armlinux.org.uk>
References: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
	<ef3efb3c-3b5a-4176-a512-011e80c52a06@redhat.com>
	<20250606101923.04393789@fedora>
	<aEKnQ4haQtcJWzXX@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvuddvrddutdehrdduhedtrddvhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdduvddruddthedrudehtddrvdehvddphhgvlhhopehfvgguohhrrgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughum
 hgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Fri, 6 Jun 2025 09:30:59 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Fri, Jun 06, 2025 at 10:19:23AM +0200, Maxime Chevallier wrote:
> > In reality, the case you're mentioning would be a device that supports
> > 1000/Full, 100/Full and 100/Half, user asks for 1000/Half, and 100/Full
> > would be reported.

> If you're version doesn't come out with a matching speed, then I'm
> afraid it's still broken.

My analysis is wrong, but the new result is right. The patch we're
discussing is correct I think, we do report a matching speed (tested on
an espressobin with manual masking of the linkmodes)

I'll update the doc though.

Maxime


