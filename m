Return-Path: <netdev+bounces-249648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E83D1BD34
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 765173028F7D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CED1B532F;
	Wed, 14 Jan 2026 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E7EXGDLa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19B17BA2;
	Wed, 14 Jan 2026 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350754; cv=none; b=pL1qN69faj9+GJk2cKGk51XrqVn3OZhoKGTG7uxfWe8gd7hnLrYIi21cxP+yfK7wXzK/kfA2ccpmE53+dCUrCRogJekbMmBSz/OisAUx+T/1Rn8yqwjn9zFHd/RuT7YIcDHKH5PFjPRiXGMzMwSjzrtUwCTCFIZupz40URbwEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350754; c=relaxed/simple;
	bh=ZRd8ycP0HInt9domfCK0GgLx5X0qKLG2LlahvqGiNN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xm5aE3ux0wWgdwoCk7fGKLK3s3CltXPBKGEHZYXLNIVub9gKLWgfFUpYuCVIPtx3/+SsiOSXsBtID0dpZJEzZ9aZvfVtTL7Y8oab3/IVKqFOGRh+5xrMksB198G3Hcenxg2EcKMtLe4OZ0WKWliB6sk0nD16FrxfB8IoW3bmNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E7EXGDLa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hmI6L29WAjCZ2TxVqq2qTB2q3gkzS0APUeR8cbfOJrA=; b=E7EXGDLaRjj1x163ec8sFl6Ity
	yraxAfXMZ5fz51Ef7cfJAJZhHkGyPzwJ11Fltk7d+dDc0x5kzc1YV+qwRTH0WbkhLK/BRzmKy5NGA
	D6c71qoyFM/2rKu0KJzslPmBEsCUArR/7HkRYSpM8VVr/tDqDypE9dbvaaCGsdpT9SoY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfooA-002iKC-2E; Wed, 14 Jan 2026 01:32:22 +0100
Date: Wed, 14 Jan 2026 01:32:22 +0100
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
Subject: Re: [PATCH net-next v2 2/2] net: airoha: npu: Add en7581-npu-7996
 compatible string
Message-ID: <75479a93-366d-4540-8f37-be2063594f17@lunn.ch>
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
 <20260113-airoha-npu-firmware-name-v2-2-28cb3d230206@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113-airoha-npu-firmware-name-v2-2-28cb3d230206@kernel.org>

On Tue, Jan 13, 2026 at 09:20:28AM +0100, Lorenzo Bianconi wrote:
> Introduce "airoha,en7581-npu-7996" compatible string in order to
> specify different firmware binaries if the EN7581 SoC is running MT7996
> (Eagle) chipset.
> This is a preliminary patch to enable MT76 NPU offloading for MT7996
> (Eagle) chipset since it requires different binaries with respect to
> the ones used for MT7992 on the EN7581 SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

