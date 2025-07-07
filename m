Return-Path: <netdev+bounces-204482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6D8AFACB3
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406C11670B7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C512221C177;
	Mon,  7 Jul 2025 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qG5pfSUO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3001DC9A3;
	Mon,  7 Jul 2025 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872153; cv=none; b=mdFuFGAspPFGZZJZHKL3U25YTq9L7vqfq6reEX6kD0nl+TgrX7JPev2DHJtq5UfdRCF8Kt8vM9ZxfAp1kap12uQ2Bxazy5BxK+dsqFIrvFXgCs4UvC3s8fbXqCmV287/T8ViM93jV75zuCsJlsfXGFxg6rIDkM4of65xlAXa15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872153; c=relaxed/simple;
	bh=S1UTgehB4MPmn84p3V9HOqZpYRl7v/ht9OhQV+Nr504=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K37ewQdNcqezE9yahbyzT+QS33L6byqAfubfGZRVhrVT5Y088jJZ6DZXYnHGgJgBE2NJcBiHI6fRlOZBNi9yNTvXIIrujSQO6y4apVihxDKF361pm+yG2CucAGOXdSLn042Ra9hdeYHoLbExO+DARtMRaSoVCzMT2ksk7hU+yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qG5pfSUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960E2C4CEE3;
	Mon,  7 Jul 2025 07:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751872153;
	bh=S1UTgehB4MPmn84p3V9HOqZpYRl7v/ht9OhQV+Nr504=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qG5pfSUOmBaq8lNU2TWtv0QM43A9NYz9tVpSmKYXdASiAJ84lcEl9cgy7RKtWtO4W
	 h9SAmhlRpN4bD1ZtRL8TIppC5Q+obq5kRppsoZMBXRsGMFRqlaXMv0QX2vC/m536CV
	 6qwvKiHsPr0bC5UfkpdtSlYYjWyqdjvSz1vQz7MI2unOWoxcesknabRbv+j8mSzCyq
	 Jykj3Gxi5uPaTy2QtbaEum0nebTWNBUyOI0+9loMzIL9a44DunwjnwKgAT/i8XBd8r
	 daSW0YTwu30bakF91aoBCKtaFDOHB/b4NEqmG36ZvfDPBr7t3SMSrtXolkmKWSR+u0
	 ed+kOs13WejjA==
Date: Mon, 7 Jul 2025 09:09:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/7] net: airoha: npu: Add NPU wlan memory
 initialization commands
Message-ID: <20250707-agile-aardwolf-of-politeness-29fead@krzk-bin>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
 <20250705-airoha-en7581-wlan-offlaod-v2-2-3cf32785e381@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250705-airoha-en7581-wlan-offlaod-v2-2-3cf32785e381@kernel.org>

On Sat, Jul 05, 2025 at 11:09:46PM +0200, Lorenzo Bianconi wrote:
> +
>  struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
>  {
>  	struct platform_device *pdev;
> @@ -493,6 +573,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
>  	npu->ops.ppe_deinit = airoha_npu_ppe_deinit;
>  	npu->ops.ppe_flush_sram_entries = airoha_npu_ppe_flush_sram_entries;
>  	npu->ops.ppe_foe_commit_entry = airoha_npu_foe_commit_entry;
> +	npu->ops.wlan_init_reserved_memory = airoha_npu_wlan_init_memory;

I cannot find in your code single place calling this (later you add a
wrapper... which is not called either).

All this looks like dead code...

Best regards,
Krzysztof


