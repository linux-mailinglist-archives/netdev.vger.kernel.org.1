Return-Path: <netdev+bounces-251290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B4D3B834
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4E06300927D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D992E888C;
	Mon, 19 Jan 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="357irtbs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FD221545;
	Mon, 19 Jan 2026 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854296; cv=none; b=G/YU3mgeb2Ira/vAf99iZGB6KTUED4RHvG2+2Ma84Dqqv1ymQ4T7AO8BN3r+o++LUC1k9UVS6MFeYxjmz6YA9tJjZ350gZsfrwVD01CPUukesT5X4m69Xj0MgyYzRFspgKBOci3a+gmt8dO+JRHbUUvr8g1DcrJglotkfqsdfp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854296; c=relaxed/simple;
	bh=Cl9RgR/VnGlwEAEgc/GgJDGA+Ykb7oO1nxZqM++MkGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRp6DSQnNQ4zd+jYKBghl4mMhzMU4ovQfr3S2C8w38tCTowdQnR2ruwTyo5W+N43gBDYpVa8Df8wvNrBdXZijcFNPU3yztU3CZAZa5AhJSBibYU6AVspOvQOS9ep2ZpiM7xHP2mHkxM7s3Vk05YA3URvFjzXksDYuog/kzLAFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=357irtbs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pSuKFtKC7s877XSHGuWqoUFYp2mwqb5QifpnPHtPG7k=; b=357irtbs3pVaYVLBLR2G2/geJR
	xYtOgg3pEf9t/wgDJUcJ0/aqqVfW/bHNBCTjYon1tSUE9DHBmzJINV9WWbjRUZ9Vc824vvNnNSPiW
	rtlTueQkF3+MqwVL+Y9snLQusadysyFu4NfJCFa+Dk3a0pWa/gpP8rcDSX5TA2LLIt+c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vhvnq-003YtS-E8; Mon, 19 Jan 2026 21:24:46 +0100
Date: Mon, 19 Jan 2026 21:24:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: airoha: npu: Add
 firmware-name property
Message-ID: <a19efb66-e90d-4a11-ac26-923a1f3714ba@lunn.ch>
References: <20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org>
 <20260119-airoha-npu-firmware-name-v3-1-cba88eed96cc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-airoha-npu-firmware-name-v3-1-cba88eed96cc@kernel.org>

On Mon, Jan 19, 2026 at 04:32:40PM +0100, Lorenzo Bianconi wrote:
> Add firmware-name property in order to introduce the capability to
> specify the firmware names used for 'RiscV core' and 'Data section'
> binaries. This patch is needed because NPU firmware binaries are board
> specific since they depend on the MediaTek WiFi chip used on the board
> (e.g. MT7996 or MT7992) and the WiFi chip version info is not available
> in the NPU driver. This is a preliminary patch to enable MT76 NPU
> offloading if the Airoha SoC is equipped with MT7996 (Eagle) WiFi chipset.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

