Return-Path: <netdev+bounces-37262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B327B4764
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B262B281B1C
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF517738;
	Sun,  1 Oct 2023 12:24:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74617728
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 12:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49926C433C7;
	Sun,  1 Oct 2023 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696163039;
	bh=zJS4fl4hoO5MV5pbbaYUd5H72daENnK1zXJQdRl/ElI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doMOT0mw6srqcZdv8v2PINB5rjvBCAvjveqkzrKPUe/oVjSleQyd03I4mx0DuHulN
	 N21Q8X8bEuyVSmk3EwBq7MyyUFI5F9ASzrtcTJuV5+Gk646kbVqBL4iTaUF3r/yCG5
	 KaqsiMEhucptmON5hA1CE3tNlJEROBpUriDqNfXU3z11h+Yl/7+7sXNvjzub+IwK1l
	 fLgBceqjgdm1NMR5Y1sAQEbcOU2RTzsRoB4H27lCWYLOVeQt59jzl6OjZcYu4QJBws
	 4khDodCtuUvD2PTp2crdypYkMQwp+4OE/lU9O0vXZPQ6F9T+5hU2VIi0wwR0i2IRu0
	 mcwNHmoAavqyQ==
Date: Sun, 1 Oct 2023 14:23:55 +0200
From: Simon Horman <horms@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Julien Panis <jpanis@baylibre.com>,
	Judith Mendez <jm@ti.com>
Subject: Re: [PATCH v6 06/14] can: m_can: Add rx coalescing ethtool support
Message-ID: <20231001122355.GN92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-7-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-7-msp@baylibre.com>

On Fri, Sep 29, 2023 at 04:12:56PM +0200, Markus Schneider-Pargmann wrote:
> Add the possibility to set coalescing parameters with ethtool.
> 
> rx-frames-irq and rx-usecs-irq can only be set and unset together as the
> implemented mechanism would not work otherwise. rx-frames-irq can't be
> greater than the RX FIFO size.
> 
> Also all values can only be changed if the chip is not active.
> 
> Polling is excluded from irq coalescing support.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>


