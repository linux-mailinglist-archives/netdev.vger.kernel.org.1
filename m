Return-Path: <netdev+bounces-185460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52903A9A787
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B216F7B226B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2D1C8639;
	Thu, 24 Apr 2025 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jOzEvNZE"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62A1BD9E3;
	Thu, 24 Apr 2025 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745486190; cv=none; b=K6jOD/y1+kBJfKeWhzBNTDLcKNElrlYznT9/U3wNrmXS/aQlQESy20K9F8rcNcMK8fDKnVHbYQZTmQL8fOgNckpoHNevWxR107I6yOrNY5FZTn6l3hBul+IOgatB4YdpNaIO8wZXB36gOWwWm/kc/IWfm52OQpeV8+TTM4EbWWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745486190; c=relaxed/simple;
	bh=g/SM5fos9s1JWgDeomN4ApobEUC9D4OEO0rlFYul9D8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzh6RtQvp6TJ0yaYweAHZP2dq2wJrl4ajn9GqCzvEy6yzF9d1yLXLslSPDKfypMaEVAyONKFnwuPwjbSfTPQlb0hRMeyVV7kNc1wh/nPKEWzOvoHif2/uJYr/xx+CsVusm7imD8JoDTQRoxZ1k7IHXAbsUHxj8Y2OofpbaW9Kpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jOzEvNZE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5C60439EB;
	Thu, 24 Apr 2025 09:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745486186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfTMyxnIB01quA/V2nunnWHVUVFti2y/BX9X/pdrGWY=;
	b=jOzEvNZEShCzsxTs+NkBn1qOJdqxA8tHkP08L2Lg6qAXRL/5ijL0AN/edPlIv/jmiSmARl
	NS8waoNweatYVMlJWYeHqQ4afL9NF36QodTJy5W/g3V3N+bfMFZ9pEL9xyF6Q4/NXGPMAu
	zreIAtnVZ73Ff1kZzA+DZb4UsChwu9yPMkmp6eDzvmVymwn9GHvUkLgDmk+ZIPh/sbPdDI
	abEzn7l+jHbpLFF2IsSSutGq8smCtIwtFMVqCrx6d+eT+MUKvvaEetsN82PPVjK9cTe+xs
	y4BKUkoBslN4Uq/+QWbZcxGwXZpJe4eHVUq7z7Oqb0NZ8I1loxiTym8acAgUyA==
Date: Thu, 24 Apr 2025 11:16:23 +0200
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
Subject: Re: [PATCH net v2 2/2] net: ethernet: mtk-star-emac: rearm
 interrupts in rx_poll only when advised
Message-ID: <20250424111623.706c1acc@device-40.home>
In-Reply-To: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-2-f3fde2e529d8@collabora.com>
References: <20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-0-f3fde2e529d8@collabora.com>
	<20250424-mtk_star_emac-fix-spinlock-recursion-issue-v2-2-f3fde2e529d8@collabora.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeltdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopeguvghvihgtvgdqgedtrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehlohhuihhsrghlvgigihhsrdgvhihrrghuugestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehnsggusehnsggurdhnrghmvgdprhgtphhtthhopehsvggrnhdrfigrnhhgsehmv
 gguihgrthgvkhdrtghomhdprhgtphhtthhopehlohhrvghniihosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Thu, 24 Apr 2025 10:38:49 +0200
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com> wrote:

> In mtk_star_rx_poll function, on event processing completion, the
> mtk_star_emac driver calls napi_complete_done but ignores its return
> code and enable RX DMA interrupts inconditionally. This return code
> gives the info if a device should avoid rearming its interrupts or not,
> so fix this behaviour by taking it into account.
> 
> Fixes: 8c7bd5a454ff ("net: ethernet: mtk-star-emac: new driver")
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

I'm unsure wether this counts as a bugfix, as no bug was
seen, and there are quite a few divers that already ignore the return
from napi_complete_done().

I don't think the patch is wrong, but maybe it should be sent to
net-next :/

Maxime

