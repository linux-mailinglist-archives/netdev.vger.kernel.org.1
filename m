Return-Path: <netdev+bounces-131199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A498D33B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8705A1C21124
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A825D1D0144;
	Wed,  2 Oct 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDY6+OoZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ABB1CFECD;
	Wed,  2 Oct 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872054; cv=none; b=YgsvjurTnbwR/zy6M/lx0PjHBdjyO2SOI4zOQDZ2IR+krMBIKYRaZSzLDWuuiSHFKQFP6nOiKCFFEH/91O+wXoFTLuWHM8KJ7cOch7usKTmuLjCRzFtH+Di3CHjcsqkoMq8uXwbgLvQ9xgc149/JXT0f9lWpEPlTKleC/lVcEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872054; c=relaxed/simple;
	bh=92Pjs11PbwX9iaUGKvlFBITO81xncEIlizO2vN9cH0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QKiteW94jcgPLkUCz7ATjw8up4GsafMGUQu/Z500iwayBQG9qjrgAepoyM8lZcCluA7x/p0iQ8L+//YygnTEhKZbz8SngG/qNHx76L/uEQJ/Jwa+Fgawr4Rd1LuaVJhjSQa0CQjBcuTThue6SxRWiWHmv6nPm+6mnlZ0JY6D4vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDY6+OoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F80C4CEC5;
	Wed,  2 Oct 2024 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727872053;
	bh=92Pjs11PbwX9iaUGKvlFBITO81xncEIlizO2vN9cH0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iDY6+OoZAlK3nJB9i/c3O1yPJdH0AUo8c2Ugo/e5504oPBedLVFddQec4PxNUUf0E
	 5fvZk4dQ5NjUck+hgro1FVX7cplQvaUUOZFNgZJjL3QeLW7bGXITIcjYDUJGOyuztI
	 pp3BTTiBra+RzEHOIp0ywgjDSEF0/MRudI9LWP8vD3PbZIEz5kBhWuSMGxUB9Z2Jq6
	 aiq5dXvfmksoEGE8lAFpRSeYMV9u2En+39md+F1oSDgKRUTJGFzq9klqu85MBmBNpo
	 iGy1VbrIoVY/nK8Wy9wtA3P1xVPnCGm+sAu9nr4BLdIVGQG++E1U+890QYC/KXeiwC
	 TSY9COWZdaUVg==
Date: Wed, 2 Oct 2024 05:27:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Simon Horman <horms@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, thomas.petazzoni@bootlin.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net v2] net: pse-pd: tps23881: Fix boolean evaluation
 for bitmask checks
Message-ID: <20241002052732.1c0b37eb@kernel.org>
In-Reply-To: <20241002052431.77df5c0c@kernel.org>
References: <20241002102340.233424-1-kory.maincent@bootlin.com>
	<20241002052431.77df5c0c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 05:24:31 -0700 Jakub Kicinski wrote:
> On Wed,  2 Oct 2024 12:23:40 +0200 Kory Maincent wrote:
> > In the case of 4-pair PoE, this led to incorrect enabled and
> > delivering status values.  
> 
> Could you elaborate? The patch looks like a noop I must be missing some
> key aspect..

Reading the discussion on v1 it seems you're doing this to be safe,
because there was a problem with x &= val & MASK; elsewhere.
If that's the case, please resend to net-next and make it clear it's
not a fix.

