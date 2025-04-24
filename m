Return-Path: <netdev+bounces-185457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCBBA9A740
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1861B3A480D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8A20FA81;
	Thu, 24 Apr 2025 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jcypkW7F"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352601B040B;
	Thu, 24 Apr 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485226; cv=none; b=DGG4r3b0iO4/mqSPU3z0AFdDBef/SIZmiJ71InAwhUchJ/L5JzjH/OwHAtOve3a8itnwmgfTSv55awixFnyfKaOcYzYeHMJu34eqzo0Gk+ll24f8pRN8X9Vg+FXHdg+zO19oRjZhePm7GkAezlXyIWqOSuQQFajXBbhoPImQz1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485226; c=relaxed/simple;
	bh=6XlOeIX5DFdyUH7bU5Ran0PxpsOaq5kec09H/AqAeao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDgORbB5BsAwjv/mQ85b/1/Vcjt3d8CsBYqbHB1BW+FICpBhgdidQlmNgXC6Ur1YuUbKjIz0k4pn6rOQLO4nEhevAgsGIbJKAGfhTVGRAjeA2iIoeZhot4+tbP8F0BGb4lq2bEqGhc9pwvmZUnygC66+N0VAjw0zVEhZ178xiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jcypkW7F; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C5751FD49;
	Thu, 24 Apr 2025 09:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745485221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pooxYcLlso5X9PgctTi94ch/h3HZMgeI7AqpszR64TU=;
	b=jcypkW7Fjm85xp6+6OFzcDVNgyKuzZAYFyUrl0btlCMo+PfwciKY0nAzzvdFLIGlLuQI2L
	/NXaCsvzjk9AyLgPB8ebEuQhxMGQeMgDpO81Dvf+WNwK79jKxx3h6LrNZ0fYbx3uiDSXA3
	Abk/vJ70RfIvAI6Bs4n9gSFyFumszcRtuS5nxdfXh1Ep4qgtkvQx5OOYizFh/ICHjYKIm9
	0eii9J9TtWLI5+ysC8IB0bLVbFUdDSSAnnxGpW4uiZDLJuIAaFTmCCWTR2Vka2kdW7l6w2
	3o5LYvUVN59Mv/50tSq5jcby14C2gj6Q0bAP2/fWC+0F1h/DGCU7o/9FJMR21Q==
Date: Thu, 24 Apr 2025 11:00:16 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Biao
 Huang <biao.huang@mediatek.com>, Yinghua Pan <ot_yinghua.pan@mediatek.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, kernel@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 1/2] net: ethernet: mtk-star-emac: fix spinlock
 recursion issues on rx/tx poll
Message-ID: <20250424110016.009acccf@device-40.home>
In-Reply-To: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-1-f3fde2e529d8@collabora.com>
References: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-0-f3fde2e529d8@collabora.com>
	<20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-1-f3fde2e529d8@collabora.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeltdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopeguvghvihgtvgdqgedtrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehlohhuihhsrghlvgigihhsrdgvhihrrghuugestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehnsggusehnsggurdhnrghmvgdprhgtphhtthhopehsvggrnhdrfigrnhhgsehmv
 gguihgrthgvkhdrtghomhdprhgtphhtthhopehlohhrvghniihosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 24 Apr 2025 10:38:48 +0200
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> wrote:

> Use spin_lock_irqsave and spin_unlock_irqrestore instead of spin_lock
> and spin_unlock in mtk_star_emac driver to avoid spinlock recursion
> occurrence that can happen when enabling the DMA interrupts again in
> rx/tx poll.
> 
> ```
> BUG: spinlock recursion on CPU#0, swapper/0/0
>  lock: 0xffff00000db9cf20, .magic: dead4ead, .owner: swapper/0/0,
>     .owner_cpu: 0
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted
>     6.15.0-rc2-next-20250417-00001-gf6a27738686c-dirty #28 PREEMPT
> Hardware name: MediaTek MT8365 Open Platform EVK (DT)
> Call trace:
>  show_stack+0x18/0x24 (C)
>  dump_stack_lvl+0x60/0x80
>  dump_stack+0x18/0x24
>  spin_dump+0x78/0x88
>  do_raw_spin_lock+0x11c/0x120
>  _raw_spin_lock+0x20/0x2c
>  mtk_star_handle_irq+0xc0/0x22c [mtk_star_emac]
>  __handle_irq_event_percpu+0x48/0x140
>  handle_irq_event+0x4c/0xb0
>  handle_fasteoi_irq+0xa0/0x1bc
>  handle_irq_desc+0x34/0x58
>  generic_handle_domain_irq+0x1c/0x28
>  gic_handle_irq+0x4c/0x120
>  do_interrupt_handler+0x50/0x84
>  el1_interrupt+0x34/0x68
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x6c/0x70
>  regmap_mmio_read32le+0xc/0x20 (P)
>  _regmap_bus_reg_read+0x6c/0xac
>  _regmap_read+0x60/0xdc
>  regmap_read+0x4c/0x80
>  mtk_star_rx_poll+0x2f4/0x39c [mtk_star_emac]
>  __napi_poll+0x38/0x188
>  net_rx_action+0x164/0x2c0
>  handle_softirqs+0x100/0x244
>  __do_softirq+0x14/0x20
>  ____do_softirq+0x10/0x20
>  call_on_irq_stack+0x24/0x64
>  do_softirq_own_stack+0x1c/0x40
>  __irq_exit_rcu+0xd4/0x10c
>  irq_exit_rcu+0x10/0x1c
>  el1_interrupt+0x38/0x68
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x6c/0x70
>  cpuidle_enter_state+0xac/0x320 (P)
>  cpuidle_enter+0x38/0x50
>  do_idle+0x1e4/0x260
>  cpu_startup_entry+0x34/0x3c
>  rest_init+0xdc/0xe0
>  console_on_rootfs+0x0/0x6c
>  __primary_switched+0x88/0x90
> ```
> 
> Fixes: 0a8bd81fd6aa ("net: ethernet: mtk-star-emac: separate tx/rx handling with two NAPIs")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---

This looks correct to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

