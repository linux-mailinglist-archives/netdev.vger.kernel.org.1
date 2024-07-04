Return-Path: <netdev+bounces-109266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303FE9279C9
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 17:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE43289568
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84B1B011B;
	Thu,  4 Jul 2024 15:15:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638F1B1427;
	Thu,  4 Jul 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720106129; cv=none; b=WMLY36hBf5Lm0M9JIuxB6A923vzzbkyCRz0nTBeGdqiEPNT/3zUyOIpLvbyUnCK3cV56atvXPq5iytc578Hover2u9gBBa3lnymMpbtEpmac44FFeApf9qmlTYxiK3e4SJg/qdAy3FImuHq/ATQnHO7S9F5IixHYpbIfcSey5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720106129; c=relaxed/simple;
	bh=1y75t4auajT+ALLNErXKMmJu9iQ2u9uJIIGptEDInCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nODdSR+9IsbVEkPaiL1kzjzIvKFBlT/jme+fq1vRlnHoHvUOn71igC3VxUfEBjF3ATYLZRfuEnddrMsqGlIMpVhSG2XzDJFy++siEr4C6B6zE1d8eCCM11GxP6gGgqZzc+8NB9yAeI+Xbq1uD/ukvnQ5iGqwZTjDTDT6zxF/isA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sPOB5-000000000xJ-1mHR;
	Thu, 04 Jul 2024 15:15:19 +0000
Date: Thu, 4 Jul 2024 16:15:15 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix impossible MDIO address and
 issue warning
Message-ID: <Zoa8gyhHZ41ByNll@makrotopia.org>
References: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
 <5c92dcae-ec10-4652-a5e4-3f050774fc8b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c92dcae-ec10-4652-a5e4-3f050774fc8b@gmail.com>

On Thu, Jul 04, 2024 at 04:46:29PM +0200, Florian Fainelli wrote:
> On 7/3/2024 12:44 AM, Daniel Golle wrote:
> > [...]
> > This is imporant also to not break compatibility with older Device Trees
> > as with commit 868ff5f4944a ("net: dsa: mt7530-mdio: read PHY address of
> > switch from device tree") the address in device tree will be taken into
> > account, while before it was hard-coded to 0x1f.
> > 
> > Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > Only tested on BPi-R3 (with various deliberately broken DT) for now!
> 
> This seems like a whole lot of code just to auto-magically fix an issue that
> could be caught with a warning. I appreciate that most of these devices
> might be headless, and therefore having some attempt at getting functional
> networking goes a long way into allowing users to correct their mistakes.

My initial motivation was to preserve compatibility with existing broken
device trees.

I then had given up on it because nobody seemed to care, but have
resumed and completed the patch now that reverting the change taking the
address in DT into account became the only alternative.

In OpenWrt all device trees with broken switch MDIO address have been
fixed long ago... (and we always ship the DT along with the kernel, so
DT backward-compatibility doesn't play a role there)

