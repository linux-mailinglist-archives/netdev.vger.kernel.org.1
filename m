Return-Path: <netdev+bounces-100016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 639BB8D7754
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 19:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA20F1F21248
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C2159168;
	Sun,  2 Jun 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1UPtJBVF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1075E2A1B0;
	Sun,  2 Jun 2024 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717350055; cv=none; b=tPl0kcIX91t7fIe+l9XhMdteBgv83y4XSobgxSYkjrAJOF0VvfQCAnGvopPe7jy089ifMYDZL9GC4nPJXdm985JGz57fkoTzaNWsK7hnZMleG9F0+1SkbhnDGCzUGsvsLJB1ecFOS1gSALxG8oe5vLxEzGEHsvmjJPFRa+20K74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717350055; c=relaxed/simple;
	bh=3BmgOrrjJchJf7GHFENjnfP4rkhQa1cvwI3O27JLrJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djDp4D0GxvGfIndcPPaQwiY4t29ueTsBNcErkeEPirP3TUBty8sFF1gQam7rbrHzrgsPEWYbOrgmn9zgGaIDMbD/sE5iJC2aA1s+vLn1OWyAqkmTj+oH56vcAIof869Ldh5sBgyY+qSEE49bcLLJDLqnKyc/3jivlJyazTBt7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1UPtJBVF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BQZdOztJv9zJbupc+nFnNkwvaoesiKaBWBz4tDGOyKU=; b=1UPtJBVF5HkvdqGjhhD6dO8D6a
	nvj6EMNZeuaymn1t+hvWa52SatxftWE4YNz8SQTq7Jno+RNW/josUe9Xr03QP6sgD2lrNdtlzzC5z
	BTS+DeERH3hl5QzExuLbPjF6eOjI9j3GEVA9dopKrLCV5ZgtYlDbBlgWhq9qUO2nx5cc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sDpCH-00GeHn-I0; Sun, 02 Jun 2024 19:40:45 +0200
Date: Sun, 2 Jun 2024 19:40:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu
Subject: Re: [PATCH net-next 3/3] net: airoha: Introduce ethernet support for
 EN7581 SoC
Message-ID: <9efb0c64-d3b2-478b-953e-94ef8be3ddec@lunn.ch>
References: <cover.1717150593.git.lorenzo@kernel.org>
 <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d63e7706ef7ae12aade49e41bb6d0bb6b429706.1717150593.git.lorenzo@kernel.org>

> +static void airoha_remove(struct platform_device *pdev)
> +{
> +	struct airoha_eth *eth = platform_get_drvdata(pdev);
> +	int i;
> +
> +	debugfs_remove(eth->debugfs_dir);
> +
> +	airoha_qdma_for_each_q_rx(eth, i) {
> +		struct airoha_queue *q = &eth->q_rx[i];
> +
> +		netif_napi_del(&q->napi);
> +		airoha_qdma_clenaup_rx_queue(q);
> +		page_pool_destroy(q->page_pool);
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(eth->q_tx_irq); i++)
> +		netif_napi_del(&eth->q_tx_irq[i].napi);
> +	for (i = 0; i < ARRAY_SIZE(eth->q_tx); i++)
> +		airoha_qdma_clenaup_tx_queue(&eth->q_tx[i]);
> +}

You don't appear to unregister the netdev. remove() should basically
be the reverse of probe().

    Andrew

