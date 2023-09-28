Return-Path: <netdev+bounces-36700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528547B1557
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EA251280F75
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A331A80;
	Thu, 28 Sep 2023 07:50:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9DE30FAE
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 07:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED51C433C7;
	Thu, 28 Sep 2023 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695887444;
	bh=FDCqZCAloUgFy83qeaM98dMcfkYWTD/rX6/C78mV2A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WH0KmnRd2D2TDARyQf3rvTLFNsmRMEUX0BXIGJa1+u020hunr3zKtkKam7ihuK4YQ
	 Z1rDLiTA/VTzyIVFzOOjcUSAyOQNC1phkLkdCIPRZRnEUYDT76ow0K2YUK/d0dkhBs
	 ooZ1AWpwfvTPXtWux5t1o2sIxk7oBczVXC5kAqIhWb/AYxiitEQPQoORjObR0mZFQI
	 M9ZqyP9kcjzE7YtwjAC+cmioUxjpbgRQEma7U50VHay5IlWncl3VtQ1Igh2u+/3gJ2
	 qZQbxfXtPMZM54mMpkRVdJmmhH0t27CVtj/aeUY2lxmLcNMqzw/kqGg2Nskqht5P2o
	 WwKK6ZwH6/hfw==
Date: Thu, 28 Sep 2023 13:20:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	Vignesh Raghavendra <vigneshr@ti.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3 net] dmaengine: ti: k3-udma-glue: clean up
 k3_udma_glue_tx_get_irq() return
Message-ID: <ZRUwUBRvs+bkfOgW@matsya>
References: <4c2073cc-e7ef-4f16-9655-1a46cfed9fe9@moroto.mountain>
 <bf2cee83-ca8d-4d95-9e83-843a2ad63959@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2cee83-ca8d-4d95-9e83-843a2ad63959@moroto.mountain>

On 26-09-23, 17:06, Dan Carpenter wrote:
> The k3_udma_glue_tx_get_irq() function currently returns negative error
> codes on error, zero on error and positive values for success.  This
> complicates life for the callers who need to propagate the error code.
> Also GCC will not warn about unsigned comparisons when you check:
> 
> 	if (unsigned_irq <= 0)
> 
> All the callers have been fixed now but let's just make this easy going
> forward.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

