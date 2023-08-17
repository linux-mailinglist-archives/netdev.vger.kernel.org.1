Return-Path: <netdev+bounces-28429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 976B177F683
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50474281F2D
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AB412B7D;
	Thu, 17 Aug 2023 12:39:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3771912B73
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:39:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019D2D71
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zKCohhNBZilA6BqA2yXOwMjFv+jyhhjNfp3vuxcwPQo=; b=oM7k/1SeKKDOkWdvW2JTwkRWbC
	nemn4jTpVx4sAmZ5V+ALkc7UTbr0GUfsYyejh7G44Q70seYsqF+/0pxHyHVx1hy7/vWKvg4UxN8Dt
	YpuPK+DSpVcafP56vLUhmrvLLe/1BqzGXU/tqLl7ZlCjXKO/iMz+TiVk6GOPbYGjSTr0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWcHd-004NGy-GZ; Thu, 17 Aug 2023 14:39:25 +0200
Date: Thu, 17 Aug 2023 14:39:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
	bryan.whitehead@microchip.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, mdf@kernel.org, pgynther@google.com,
	Pavithra.Sathyanarayanan@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: phy: fixed_phy: Fix return value
 check for fixed_phy_get_gpiod
Message-ID: <28f38d27-31a0-4369-b11d-69e94ad91e0c@lunn.ch>
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
 <20230817121631.1878897-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817121631.1878897-2-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 08:16:28PM +0800, Ruan Jinjie wrote:
> Since fixed_phy_get_gpiod() return NULL instead of ERR_PTR(),
> if it fails, the IS_ERR() can never return the error. So check NULL
> and return ERR_PTR(-EINVAL) if fails.
> 
> Fixes: 71bd106d2567 ("net: fixed-phy: Add fixed_phy_register_with_gpiod() API")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

