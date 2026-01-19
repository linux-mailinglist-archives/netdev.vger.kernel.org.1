Return-Path: <netdev+bounces-251160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A66D1D3AEC9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A4F305018F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BC038A70C;
	Mon, 19 Jan 2026 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F7y+vxrZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7F0352C4A
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835732; cv=none; b=GFiEQjJuGifetpHIOLhjWdPNKm3OpQ9lpE1OxNvHPh0fnqyOAbG4CTEm08eCQ1No7O6w/45NAPOzed1YsGCEBY5N4fbAg1eHlBtgg0OYRqpFwNCaC9nmO3COL86bUIlXFayzcH3kw4ZV0PqEtTBsF8PRtWJcTUjuBm/alKQZg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835732; c=relaxed/simple;
	bh=EF+qQZyPT/qsuzg53k1VSKJV+VsSYDYEvH4LG0YqI48=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pegl+9OWdrYq3PihCkZOBUGJaW4G2E2wm6SmOsF+VLft5ta5EQQXyvDoyX+l2I3kiSkAjQvHd5bpX7m9d1Jg3BfruREpRMLkaZWcJQngidlHZpHrUfNqd9l99A2sPNcWwyIhtSExLXXcUkvvz60P0TMudULWiC4XiELCeYc+dsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F7y+vxrZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B20194E4217C;
	Mon, 19 Jan 2026 15:15:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7ACB760731;
	Mon, 19 Jan 2026 15:15:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89BF110B6B111;
	Mon, 19 Jan 2026 16:15:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768835727; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=EF+qQZyPT/qsuzg53k1VSKJV+VsSYDYEvH4LG0YqI48=;
	b=F7y+vxrZtCX69fbEjwMcHPuD0RLxU6ivMa1qTosvLSpgg9mwFqhZgm9WHwXgjLVku1yHUX
	DYFzW2p2jUZWa3ISEVED51wynIRvI6sWLl5QmCT+RA1iJ3bUF4DcsTUlvmv8ASP9iYCDEn
	tXkAwfnbZKWQ/2R29T3nKnbh3Lpl4BToUzWWpcHs99vqT7Dnf3Mh5nkdziZe7aXEku/B87
	QiJMf0zc0yA2+tobwRQOELPlavSoiTTPMusy6qqbnFTzDq5ctis1vh3+H8jDvEywrNfHhg
	oyqI52a0kn2wXpExfC9q8czWQvXrYXcud/SXOFdjyXXmvr6IZFXkEXfwUWVrFA==
Message-ID: <821723dc-387c-4d57-aa73-1e5556fed0bc@bootlin.com>
Date: Mon, 19 Jan 2026 16:15:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next] net: stmmac: enable RPS and RBU interrupts
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <E1vgtBc-00000005D6v-040n@rmk-PC.armlinux.org.uk>
 <33b06fd6-3eb3-4eb7-8091-7ebe8a8373ba@bootlin.com>
Content-Language: en-US
In-Reply-To: <33b06fd6-3eb3-4eb7-8091-7ebe8a8373ba@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3


>> I'm not sure why we publish these statistic counters if we don't
>> enable the interrupts to allow them to ever be non-zero.

 [...]

> I personnaly find the stat useful,

Just to elaborate a bit more, I'd say I find it even harmful to have the
stat stay stuck at 0, which would be misleading when debugging while
relying on these counter values, especially if other stmmac flavours
make proper use of it.

Maxime

