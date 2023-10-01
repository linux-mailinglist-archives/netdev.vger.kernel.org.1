Return-Path: <netdev+bounces-37261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3907B475F
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 14:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 04CBE281AEF
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485117734;
	Sun,  1 Oct 2023 12:23:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E551772E
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 12:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07EFC433C8;
	Sun,  1 Oct 2023 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696163019;
	bh=bGLLx3W/04YDixrwTRJ2+yQqyEYUWpZQHtkoZLDsy3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caoR0sLj5VpWHHsGJ1M4cEFL/G+xaKIL0fGS7ecUE24Tb0AQbuHTYmPt6fWfYI4kE
	 TK13OC9lhMsw2OW16ainYYFdxcogJHS+ARuInHIEWuyjI9jHE6Q+X14xZOJeqLBBC0
	 6aMr8i0vUsfeE2LX5ueOwWGWxQmEJkox6EiSZcpREpvgNJnbJK9JK2SW88GNZm0ERR
	 A6F/MYDc/1BP5eP8cBXGYjfbGzhOch4YcnT/nE21yXD4dA/+oGBHXQ7bbATZ5J1Djb
	 LjnANZrLCxfiCTxiIGqs+xVi76QJWjtivfn4LJLzk705GgEdVULago4+TBeZIJXwYx
	 f9Up9PwAIu++Q==
Date: Sun, 1 Oct 2023 14:23:34 +0200
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
Subject: Re: [PATCH v6 05/14] can: m_can: Implement transmit coalescing
Message-ID: <20231001122334.GM92317@kernel.org>
References: <20230929141304.3934380-1-msp@baylibre.com>
 <20230929141304.3934380-6-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929141304.3934380-6-msp@baylibre.com>

On Fri, Sep 29, 2023 at 04:12:55PM +0200, Markus Schneider-Pargmann wrote:
> Extend the coalescing implementation for transmits.
> 
> In normal mode the chip raises an interrupt for every finished transmit.
> This implementation switches to coalescing mode as soon as an interrupt
> handled a transmit. For coalescing the watermark level interrupt is used
> to interrupt exactly after x frames were sent. It switches back into
> normal mode once there was an interrupt with no finished transmit and
> the timer being inactive.
> 
> The timer is shared with receive coalescing. The time for receive and
> transmit coalescing timers have to be the same for that to work. The
> benefit is to have only a single running timer.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Simon Horman <horms@kernel.org>


