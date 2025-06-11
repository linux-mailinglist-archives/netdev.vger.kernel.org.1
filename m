Return-Path: <netdev+bounces-196710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68B9AD6061
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7E2189E68D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A0825BF01;
	Wed, 11 Jun 2025 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/eeaTWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C962367A6;
	Wed, 11 Jun 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675171; cv=none; b=onixadVnpjZhqg7iriU9hf2nCrl6+MBOj8z4Pov7MKdzmr+p6kWDco8MOmyzIhvMQw58Efe1NESCa26Eu52h/rkz9KpeBVUG/4ETGc/V3UUQNOwR8ORSdR8wmfTLCDcLbxubeAfGEmz+JF2HKPBlMp7o5yvDt9X5wgFzj7R/Sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675171; c=relaxed/simple;
	bh=NKTPwkJUs4T8pFNoNiIG6fvQG1EElgaLi5p2/yQ7VCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxbYzBVnzOqGDSGaVJRS0ZBiax1NqxxwF8UUkVXEbzFW3b1NwP3ilBYlFBJ39/lvu6Gki1fYB/E2EqoRxVqj17fPdlPuy/sdL0bBaIQRGEYXkU2G/a7zj0B7t8aUuCKT6qjSgarqeqkkDe2+A9GyZ4FTliswr4UMYJ13pbKfJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/eeaTWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6428CC4CEE3;
	Wed, 11 Jun 2025 20:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749675170;
	bh=NKTPwkJUs4T8pFNoNiIG6fvQG1EElgaLi5p2/yQ7VCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O/eeaTWyc8rX4ZjDCSF/MaPLRF+2jge933ax1G+cF8D2hFYihyuugoR2ExGPsjTKd
	 nOm+WPXYYeOTpHh+yzUAVbtUgSrT5OGktPrS+fqgE1UQB00cxruxz0XiCO6qmaKYti
	 zqvsiXZI1CbxfYelPA+MYb95RayOAgOBmc6LEOQuf20B4P9gMJQgHL12jVtBB36yId
	 wqh+OP569avqm6VFT8QJx+Uljey9Wc3lvWBfSs7P4oDnKlNw0TYuZAc1KLhMbdFu1K
	 R1A5h1eF6Sl5X+3t50aP4WSBHNkOCnpN/2qMd3YoZglehW5+eEfFuyCzZhHJK4/ZFJ
	 4Esq4cBLUGfdA==
Date: Wed, 11 Jun 2025 13:52:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RESEND] net: mdio: mux-gpio: use
 gpiod_multi_set_value_cansleep
Message-ID: <20250611135249.69c88f5d@kernel.org>
In-Reply-To: <55bba029-9243-439d-9f1c-985f48ad2ec8@baylibre.com>
References: <20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com>
	<d4899393-f465-4139-ac3d-8e652c4dd1dc@lunn.ch>
	<55bba029-9243-439d-9f1c-985f48ad2ec8@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 13:40:25 -0500 David Lechner wrote:
> > It is not surprising it did not get picked up when it is mixed in with
> > a lot of other subsystems. Please always post a patchset per
> > subsystem.
> > 
> > This also appears to be version 4.
> > 
> > Since you did not annotate the Subject: line with the tree this is
> > for, i'm not sure the CI system will accept it an run the tests.
> > 
> > https://patchwork.kernel.org/project/netdevbpf/patch/20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com/
> > 
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> OK, I will try again tomorrow with [PATCH net-next v5].

No need, just keep it in mind for the future (CI managed to guess
correctly).

