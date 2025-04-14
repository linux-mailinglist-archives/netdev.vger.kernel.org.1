Return-Path: <netdev+bounces-182229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A61A884BB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A883BAC09
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E62749D8;
	Mon, 14 Apr 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AIH4hTUh"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7F27B4EC
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638222; cv=none; b=bHmA0gBOZ2iNwJlwNFRTIqcamrBaTt9uUsJBh0BZC0G9IiAUHCdIJWn91azO7HzZRY4i2uCfzizQToZWXMDoYBLEYrFtM0nXrDU+aoBrUdXfPSNvd75JSu5tU95E0PEvLQ+KxtJmrFeAK1hfuhKl05RioqR1CcJStIGKUHicbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638222; c=relaxed/simple;
	bh=Gx49b71SlJ4tBbfJnUYpEAjs6QxmArSYk5uevCK8vuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSR+rytd+F0abIS+3WvD0cd+oVj+ASLlGYswOAdqvgB3Z9tZHKMexei4BlbtXdoahIEULa8vMTAL4CJNav6KK9d4/s/4ZZo/V60diieY8cLfSI8OmYNNE/ulFWh8x5zCpFcZxFkKpUoECxxGaTaeSknSsSOCot6yu4Nr2L5rsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AIH4hTUh; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46B8F43B5F;
	Mon, 14 Apr 2025 13:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744638211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gx49b71SlJ4tBbfJnUYpEAjs6QxmArSYk5uevCK8vuw=;
	b=AIH4hTUhIRTZbVGnIigQk3eHxcg+oZHK0qplYKh+ADe4hKMd420t2YfKcFzNX7SGPhdKv3
	YPe3GVrTWZ4M7rybjffWF+aUt42H6lLSN5Xm1/WhZZClbTYYn04hq0yQmt2OlNnbEZ5ulT
	KGQKnZ8PtCL9b2spZsQkw13W2YikfboebGYQ5z/jxvGczbFdX3+2djZohPzgOaB5Aa1yOJ
	ih1sf/IFJMy1246x62TV3JCAQd4oC3H/s1WOe/YdHVLeAEQj3+D+6cmXOl5eA4jZem+O+e
	hpxgCtQ5NT9tz71o4XYtFCWgqs4T5kwhx7edy8xxMwiBAGCb1i4NXSPjJeOX7Q==
Date: Mon, 14 Apr 2025 15:43:30 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2 1/2] ice: add link_down_events statistic
Message-ID: <20250414154330.37509a17@kmaincent-XPS-13-7390>
In-Reply-To: <20250414130007.366132-5-martyna.szapar-mudlaw@linux.intel.com>
References: <20250414130007.366132-2-martyna.szapar-mudlaw@linux.intel.com>
	<20250414130007.366132-5-martyna.szapar-mudlaw@linux.intel.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehmrghrthihnhgrrdhsiigrphgrrhdqmhhuughlrgifsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihhnthgvlhdqfihirhgvugdqlhgrnheslhhishhtshdrohhsuhhoshhlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 14 Apr 2025 15:00:09 +0200
Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> wrote:

> Introduce a link_down_events counter to the ice driver, incremented
> each time the link transitions from up to down.
> This counter can help diagnose issues related to link stability,
> such as port flapping or unexpected link drops.
>=20
> The value is exposed via ethtool's get_link_ext_stats() interface.
>=20
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.c=
om>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

