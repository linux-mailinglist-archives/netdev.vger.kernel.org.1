Return-Path: <netdev+bounces-35401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A989B7A9499
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 15:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383D9281B47
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E713BB65D;
	Thu, 21 Sep 2023 13:18:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D42B641
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77002C4E66F;
	Thu, 21 Sep 2023 13:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695302328;
	bh=MQmDcrstvVZY6kP40oKfTwDz3+GADNbB6xrGhKqtNWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6ypGZ2LXHS25WVtSQxLI5ff8jnb4+RBGEIa0dSL+FH9YHplFSwurc1OuT0UjsT63
	 RsLHsVQ+l4sPhSAMZKhJZl8yWpEIUgIqScF4g0/U87ecw1zTMgIcRnNQxftsTPbiMv
	 9nWpfgWorIWn+V9Qcydb7anewyFKwvi9Bf4voOkSrZ5GE854CJCdJSAEQKbi0Rb8q+
	 dT8PU1ixceAAnL0hbaJsKd7TMctC4JMUFgngXx2yQ7EeFgVGj6+NslN8LYM8WwRRGt
	 PTXNmAAFotmZjsAmahKs7EcIdOYbsKVGh65/XBirb6R6e11JuQJTOsaGlKBbAVMGZA
	 xkun8OAHmZ85A==
Date: Thu, 21 Sep 2023 14:18:40 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: tcan4x5x: Fix id2_register for tcan4553
Message-ID: <20230921131840.GM224399@kernel.org>
References: <20230919095401.1312259-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919095401.1312259-1-msp@baylibre.com>

On Tue, Sep 19, 2023 at 11:54:01AM +0200, Markus Schneider-Pargmann wrote:
> Fix id2_register content for tcan4553. This slipped through my testing.
> 
> Reported-by: Sean Anderson <sean.anderson@seco.com>
> Closes: https://lore.kernel.org/lkml/a94e6fc8-4f08-7877-2ba0-29b9c2780136@seco.com/
> Fixes: 142c6dc6d9d7 ("can: tcan4x5x: Add support for tcan4552/4553")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>


