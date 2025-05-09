Return-Path: <netdev+bounces-189127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2265FAB089A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 05:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93AE9E5B12
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 03:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB41221542;
	Fri,  9 May 2025 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwQa1Mdw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D51EEE0;
	Fri,  9 May 2025 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760394; cv=none; b=GkoL95qQF3YBlKXvcnDfvhDGg0TyUUHjC1TPGbzjq18a/lrv/5wp5KsAqvzentoW4K3qWoAZlTRd9wJDmmzGDOq7Kq5VNWJ1NPtVAZqOvong5pvKTfljg+LfCsI+lrkV3JgtuYqepOl9T6vZsCovabSztj11UFWQU/WPN8An4SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760394; c=relaxed/simple;
	bh=rvYoCnD/Vbn1WCJh6yA8UpoAs4j9A3g4UDDTPLYIoec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ul4zaKxCOkrB6wQ5GLAoqNNiaUv+Ojn8c7FOUnM5IwDMpSDAVlCNAGugJBr0TWm2Fp4NaMUM9UiEqkIzEZkdD6NCvv8u753+Ew7s10Db+DMBCJmAhSnMr0UV/xFVGRzKc2gV61YCQYxVCXZe5IPC5oDvkcqrMSz0szrTZqaTK+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwQa1Mdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41002C4CEE7;
	Fri,  9 May 2025 03:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746760393;
	bh=rvYoCnD/Vbn1WCJh6yA8UpoAs4j9A3g4UDDTPLYIoec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IwQa1MdwFZSGbFKmCmvyZ5Xcqge2+s8LP5NIf7PU2+tel+c4uXjgg63pIkBWYil3I
	 uYx6bDmNym3bOhcxOK6Cg8lzJ8U3iiqDwfhVR67Q7e4tfD/MiPv+VySHmsqSfnI73I
	 HgfmAhscXk3dzD4WEjLfZpv3nxzlyKrdwSuJBAh+hvF2m2JTiZ0sul95iZ1AoyctDj
	 ZfEOGe7IeVnpHXeQhyxGCXm17d2LlgZWU96x2rca4oFRoTdZ3m8RxfCY9we2cJe0KG
	 F/e/EwZfI9e0+Duo1VfnpGkUuRJxqH8jImmSCgXmS8MAsjWIbe6BZqGsbq44A8vwg0
	 hHzLFoAA3Jj4g==
Date: Thu, 8 May 2025 20:13:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: airoha: Add the capability to
 allocate hw buffers in SRAM
Message-ID: <20250508201312.078a0a37@kernel.org>
In-Reply-To: <20250507-airopha-desc-sram-v1-2-d42037431bfa@kernel.org>
References: <20250507-airopha-desc-sram-v1-0-d42037431bfa@kernel.org>
	<20250507-airopha-desc-sram-v1-2-d42037431bfa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 May 2025 19:48:46 +0200 Lorenzo Bianconi wrote:
> In order to improve packet processing and packet forwarding
> performances, EN7581 SoC supports allocating buffers for hw forwarding
> queues in SRAM instead of DRAM if available on the system.
> Rely on SRAM for buffers allocation if available on the system and use
> DRAM as fallback.

drivers/net/ethernet/airoha/airoha_eth.c:1113:30: warning: incorrect type in assignment (different address spaces)
drivers/net/ethernet/airoha/airoha_eth.c:1113:30:    expected void *q
drivers/net/ethernet/airoha/airoha_eth.c:1113:30:    got void [noderef] __iomem *
-- 
pw-bot: cr

