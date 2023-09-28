Return-Path: <netdev+bounces-36797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7F47B1C97
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 18FB1282792
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39E41D698;
	Thu, 28 Sep 2023 12:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BD1118
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 12:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90D4C433C8;
	Thu, 28 Sep 2023 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695904584;
	bh=IFrcf1HPc0zyK3iLaNG9gOuBji+30hPiT2IlRSdShVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmmsEIeoEjtbXkbPElRqp9gu3YYdGTtyOl6LSOrsqPNKvrJFBRvd4hunEGDSG6ofF
	 ovLsJsACNdNoUM4hd6kEo9as/IwAqEZguEWwjdD6NwPRcTMTh+p6xqSvR4RIvgJgu+
	 YmjfMwTxsHXWApRPheJwSj8gVnxWb1CeGP6xT59uHhTjqji5ALA12XRlmJ+pBNfi5g
	 oOPIT6PW5FOMaMZhmhxwhMNd4QU9BAyiKGefbOXgW/CyHLHiQFByktsIztcvENhPAK
	 mwBfGB3UiLqiOg4YWK0090U7eqQduQWo92OJ/J82nX/Ki0ClHfZvG3bsLx2pzrH2Jq
	 dPtXVfiCHHfBA==
Date: Thu, 28 Sep 2023 14:35:56 +0200
From: Simon Horman <horms@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-can@vger.kernel.org,
	=?utf-8?B?SsOpcsOpbWll?= Dautheribes <jeremie.dautheribes@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	sylvain.girard@se.com, pascal.eberhard@se.com
Subject: Re: [PATCH net-next] can: sja1000: Fix comment
Message-ID: <20230928123556.GH24230@kernel.org>
References: <20230922155130.592187-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922155130.592187-1-miquel.raynal@bootlin.com>

On Fri, Sep 22, 2023 at 05:51:30PM +0200, Miquel Raynal wrote:
> There is likely a copy-paste error here, as the exact same comment
> appears below in this function, one time calling set_reset_mode(), the
> other set_normal_mode().
> 
> Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")

I'm not sure this warrants a fixes tag, which implies backporting,
but in any case the tag is correct.

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

The above comment notwithstanding, this seems correct to me.

Reviewed-by: Simon Horman <horms@kernel.org>

