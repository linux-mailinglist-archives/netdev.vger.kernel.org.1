Return-Path: <netdev+bounces-240573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB2C76548
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8415D4E118B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F792D9EFA;
	Thu, 20 Nov 2025 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4JDKEuaY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A01E5B95;
	Thu, 20 Nov 2025 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763672997; cv=none; b=F80L66+bf9uQkxKHySBVeXYjGbvu+2dPkcuX061ADM4oHiKSfA7N92sJmstXBUSNc7UnwSDEeH/lReJIjajF0YHz7H4rNMIefHxq5n6v9qpQDp89fLO4oSrX3ncnKgHa15E3DPaGmX1blpM5ZDi7GXWAR/dDUgcCHAhv4Q4n1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763672997; c=relaxed/simple;
	bh=+dWRGLQVOY7c4fmK55xcECXf2NWQWgjny7dAWXYGSvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmOI1UteOgQUYZGWIht+EP41txA7BcitJULXMkN5OnC6wa9Rrsx8rQ2NAtqPQK8SuUp5fbXL5e72BwCogCCvmNVoRrT8aeIiLdyx2u7gaYXMUE2pQkKg1dcMTdQK1SIXNJlAZbupqlWYhDUXangnUMAz7I1BNiHAqitXYTgxYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4JDKEuaY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VL+dgfFJaJObXef1+NwBUjf2BvSPGC9sMwQo64LaXKc=; b=4JDKEuaY9gDbNRJ0y1i9Sc3Kmq
	P6GJ5tqKs8OYW+92B8fDosEbT4qnXx9EV/zKO6AaXTwWp9hPuNEWIWAOWc+BJd/Sfp36W8BLiCErQ
	4efNnXhltm1CHDBh01lmUA335Klso0Rz1uBSqHZY0Te6APQWyqPtWK3zFK4zEYDvFbjs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vMBuC-00Eg2Z-5n; Thu, 20 Nov 2025 22:09:28 +0100
Date: Thu, 20 Nov 2025 22:09:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chen Minqiang <ptpt52@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: mediatek: fix MT7531 reset polarity and
 reset sequence
Message-ID: <f8e9184a-2b29-461a-907b-9e17856b5d89@lunn.ch>
References: <20251120162225.13993-1-ptpt52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120162225.13993-1-ptpt52@gmail.com>

On Fri, Nov 21, 2025 at 12:22:24AM +0800, Chen Minqiang wrote:
> The MT7531 reset pin is active-low, but multiple MediaTek boards describe
> the reset-gpios property without GPIO_ACTIVE_LOW or incorrectly mark it
> as active-high. With an active-low GPIO, gpiod_set_value(1) drives the
> line low (assert reset) and gpiod_set_value(0) drives it high (deassert).
> 
> Update all affected DTS files to explicitly use GPIO_ACTIVE_LOW so that
> the reset polarity matches the hardware design.
> 
> Additionally, adjust the mt7530 driver reset sequence to correctly assert
> reset by driving the GPIO low first, wait for the reset interval, and
> then deassert reset by driving the GPIO high.
> 
> Boards fixed:
>  - mt7622-bananapi-bpi-r64
>  - mt7622-rfb1
>  - mt7986a-bananapi-bpi-r3
>  - mt7986a-rfb
>  - mt7986b-rfb
> 
> This ensures the MT7531 receives a proper low-to-high active-low reset
> pulse and initializes reliably.

Please add a comment to the commit message about backwards/forwards
compatibility, how this is safe when booting an old DT blob on a new
kernel. Or a new DT blob on an old kernel. We don't expect regressions
in such cases, and it is good to indicate in the commit message you
have thought about this and don't expect problems.

    Andrew

---
pw-bot: cr

