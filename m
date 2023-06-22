Return-Path: <netdev+bounces-13185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA44673A8E0
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F4A1C211C4
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9C621065;
	Thu, 22 Jun 2023 19:18:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D91E536
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:18:29 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD2ADC;
	Thu, 22 Jun 2023 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7VEmrQnGXRHXrWZPRkJkOjP72y6Jj4SAv5mBcJAJcwQ=; b=loAZj+yP3rtmbP9MdVjS04Wp4K
	I0bKPeVKRM1eDmATNW/FIYrCl69pSEtPx7EgR8G6gloZrHLBJYnY6gnXlRIJ1wA6b1x0ebQj+A/vG
	ofyh0KtEE7N6rsZn/1ArsTov+AJ9tjfUUkQDag3DVAoQQa7v8uE41RQCgJCwsZ8H7ySo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qCPop-00HIJb-VM; Thu, 22 Jun 2023 21:18:11 +0200
Date: Thu, 22 Jun 2023 21:18:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxim Kochetkov <fido_max@inbox.ru>
Cc: netdev@vger.kernel.org,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Robert Hancock <robert.hancock@calian.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] net: axienet: Move reset before DMA detection
Message-ID: <5e8b2552-0dcb-4683-ad52-57a239517d2d@lunn.ch>
References: <20230622175200.74033-1-fido_max@inbox.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622175200.74033-1-fido_max@inbox.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +	/* Reset core now that clocks are enabled, prior to accessing MDIO */
> +	ret = __axienet_device_reset(lp);
> +	if (ret)
> +		goto cleanup_clk;
> +
>  	/* Autodetect the need for 64-bit DMA pointers.

I would say the comment is now not fully correct. It probably should
be extended to include 64 bit DMA.

	Andrew

