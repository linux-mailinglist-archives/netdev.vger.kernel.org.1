Return-Path: <netdev+bounces-22057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC93765CD1
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 22:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AED91C216DA
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C661C9E7;
	Thu, 27 Jul 2023 20:03:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC71AA78
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 20:03:25 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C4B30DA;
	Thu, 27 Jul 2023 13:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uoBz22zvA+qLFiterr5fZWk0KWLV8flawrD3Na3jQmk=; b=RKm4hBMGG6P0W1llheMcaUYQ+p
	g9/U8eZXu7+k7VkJ61RHJC1denMqivdMbc6GUYAbHKLWy6T9Zrf4+v4h7vaHvKlGZ14lg67Eamwqp
	AFNnQHoUxO+/vHidtWEhBZ5GGAqdnVYf4uvukAc2ZuWd8xdxSGQyWRrNz1CBKRjxiYCM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qP7Bs-002U7H-8b; Thu, 27 Jul 2023 22:02:28 +0200
Date: Thu, 27 Jul 2023 22:02:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, linux-hwmon@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Adham Faris <afaris@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 1/2] net/mlx5: Expose
 port.c/mlx5_query_module_num() function
Message-ID: <432a3e69-42e2-42fd-91f1-9889a881e23d@lunn.ch>
References: <20230727185922.72131-1-saeed@kernel.org>
 <20230727185922.72131-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727185922.72131-2-saeed@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 11:59:21AM -0700, Saeed Mahameed wrote:
> From: Adham Faris <afaris@nvidia.com>
> 
> Make mlx5_query_module_num() defined in port.c, a non-static, so it can
> be used by other files.
> 
> Issue: 3451280

Which public bug tracker is this from?

      Andrew

