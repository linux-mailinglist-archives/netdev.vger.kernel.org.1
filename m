Return-Path: <netdev+bounces-222843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD75B567C9
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 12:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DA0189A177
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36A1DF723;
	Sun, 14 Sep 2025 10:31:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEF4487BE;
	Sun, 14 Sep 2025 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757845861; cv=none; b=nMPn+OE2za/+PeaV1faFupfnj9e93RSBEK16zU+7X2iYEWMxfWeLM4h6pIbJzvAfD955KfSywzWGQMqpuhbSAh+YG8JUeqLKnsRKMn2MNT4PaEAhqUcZlRnG9QRWIiNNH/i+X1Iyl05cE3LjLwqhA8dzOA4ReVcoNezepGnu8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757845861; c=relaxed/simple;
	bh=YFMVFVKRndRZpMY+xLg+MtDUEnvjTsFhtHdbGuHbBTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz4peapzkV8qMsta0nZEgf2M+vdr2UugqeWYilwHn04reb5gqPS7MKmmjoDV6Io/LjbWXRkNQ6oQVWUa9d9Jd+wNthu6T81tb8GFGgrIt5B9ktTheYc14Ucvl3Q8GJGYp5sBVqwRsbHjbIqKhGdPbFWvApR9djFhnd8yiyCBlDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id E745F340EE4;
	Sun, 14 Sep 2025 10:30:58 +0000 (UTC)
Date: Sun, 14 Sep 2025 18:30:49 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Vivian Wang <uwu@dram.page>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v12 0/5] Add Ethernet MAC support for SpacemiT K1
Message-ID: <20250914103049-GYA1238190@gentoo.org>
References: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914-net-k1-emac-v12-0-65b31b398f44@iscas.ac.cn>

Hi Andrew, Jakub

On 12:23 Sun 14 Sep     , Vivian Wang wrote:
> SpacemiT K1 has two gigabit Ethernet MACs with RGMII and RMII support.
> Add devicetree bindings, driver, and DTS for it.
> 
> Tested primarily on BananaPi BPI-F3. Basic TX/RX functionality also
> tested on Milk-V Jupiter.
> 
> I would like to note that even though some bit field names superficially
> resemble that of DesignWare MAC, all other differences point to it in
> fact being a custom design.
> 
> Based on SpacemiT drivers [1]. These patches are also available at:
> 

I know this series has been iterated several versions, and Vivian is working
hard on this.. but since it's quite close to rc6, I'd like to query if
there is any chance to take it in for v6.18? don't want to be pushy, so I'm
totally fine if it's too late and have to postpone to next merge window..

P.S. I'd just want to see emac/ethernet accepted since it's last bit for
a minimal headless system..

Thanks

-- 
Yixun Lan (dlan)

