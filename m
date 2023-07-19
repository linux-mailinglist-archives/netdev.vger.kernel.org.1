Return-Path: <netdev+bounces-18798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736B4758ADF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356D0281408
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335AE15D1;
	Wed, 19 Jul 2023 01:33:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94E17C8
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA38C433C8;
	Wed, 19 Jul 2023 01:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689730396;
	bh=cnB634d5MilJx61cRbzEaIgLNrGvhl8lhYE1cM+RK3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=joJppOyiXXcr17Mg9CVU5knqiGd6Wk7zb0/Ghi7YXkFsjmOUhKagdbWS1kjBBZ2nw
	 KvVPD+k6NvIKErN++63eeAU5Jn9uDpbteK6pfLChEkafjptVKkoiT1jS0+hZ52Ol76
	 BDF94l3Zh/g4p1+yZlCr9xyU27X+HPKcf/i7cb6ccShJ30FFmo6i1oq+zkk/lB3ECu
	 gUPZGnzTV0NutlXrUZG4X50Jp7BrrcKWtRPCoxrETTA/V7t4TYXscaBGJptt9EibdD
	 MM7iespl5Wp9rAWI93m9h0MzlP83OV2qPH7pfkPuZNXgtP+/CTTCiJ/R+miawAvdAO
	 cVQw+SxFuJ85g==
Date: Tue, 18 Jul 2023 18:33:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>, Martin Jocic
 <majoc@kvaser.com>
Subject: Re: [PATCH net-next 7/8] can: kvaser_pciefd: Move hardware specific
 constants and functions into a driver_data struct
Message-ID: <20230718183315.27c0cd27@kernel.org>
In-Reply-To: <20230717182229.250565-8-mkl@pengutronix.de>
References: <20230717182229.250565-1-mkl@pengutronix.de>
	<20230717182229.250565-8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 20:22:28 +0200 Marc Kleine-Budde wrote:
> +const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_address_offset = {

> +const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask = {

> +const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops = {

> +const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_data = {

sparse points out the structs in this and subsequent patch should
be static. Would you be able to queue a quick fix on top and resend,
or should we pull as is?

