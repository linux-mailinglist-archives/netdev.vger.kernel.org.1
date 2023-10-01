Return-Path: <netdev+bounces-37258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 409047B4757
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id C127CB20978
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CE917728;
	Sun,  1 Oct 2023 12:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8470168B6
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 12:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D5AC433C8;
	Sun,  1 Oct 2023 12:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696162934;
	bh=KEKIGJ8YzKasW9ukSR/+yIY9EqVyIgke9DbyhZEYjFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+UW6dFcaRdFOoLZ8eu0qf9uAYLsCIKFXs3SzihQe2dnCxUI83LjD5C+RUco/Za7q
	 82Du5oMzjqHcCo8qicNOq5egrBuiM3iSpogdRxWffF55x+Ik2oMiVxZDw1Fpapex2m
	 Rrc8VztWiNvU1pu0N79JYsyG2P8/627ZO9ce/CMoGqxfrZzq/WwvWJdAFCQDGE3hgP
	 b9XxdBAdLthYn+xHRAkrl5xFRv8xAsql413u884WMrDUdpnzYFKmNPVAUo9+761Dfk
	 ytTc3/A17/3FPpWoV6Lw6FQ2u0RBW1/c7l9wCs+IXswyrgQRzaWQFUiQ02ZOGKdATf
	 O4nupdDbKHQEQ==
Date: Sun, 1 Oct 2023 14:22:09 +0200
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
Subject: Re: [PATCH v6 01/14] can: m_can: Start/Cancel polling timer together
 with interrupts
Message-ID: <20231001122209.GJ92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-2-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-2-msp@baylibre.com>

On Fri, Sep 29, 2023 at 04:12:51PM +0200, Markus Schneider-Pargmann wrote:
> Interrupts are enabled/disabled in more places than just m_can_start()
> and m_can_stop(). Couple the polling timer with enabling/disabling of
> all interrupts to achieve equivalent behavior.
> 
> Cc: Judith Mendez <jm@ti.com>
> Fixes: b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>


