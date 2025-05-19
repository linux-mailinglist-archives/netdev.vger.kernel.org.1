Return-Path: <netdev+bounces-191577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72652ABC36B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 18:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC74A13AD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916942868B9;
	Mon, 19 May 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skc/SERR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A84286896;
	Mon, 19 May 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670561; cv=none; b=ejLfDgAQahsY0Wc2LU8bqyO1a1ganpRsBqe8mKfwhSFByWcmxBLBBfs+MzPvyt9RtBbZi4GyhiFPOmGXNtLKB9ccCwtdAOGiclhwL3pmXgcjW+esRC01Jx8Ly6nrnLUHQPecMphbKF3y1oM+3nwGPE5BZE6f39aIH35+gkT8kn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670561; c=relaxed/simple;
	bh=Li97ibJu1i6lhzJ/tLMhuWTsxC88CFjJlHWA5uOhlos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIgPHWNYwTIWnSlhe3sZVZtKv1L5fPRmIHVc4oZYXmb6ZS3DVePvg5UCn1QXqzfLddIrxwN8pKt65b1aqGMJ7SprbCB4BO4FmdIQdbIlsFBhQD1MTu7Tn5BJzXN5dfN5TfOIeQMbbjnCYTY+lHI/LuzI3/bfQtc4Kq1OnHODx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skc/SERR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630DEC4CEE4;
	Mon, 19 May 2025 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747670561;
	bh=Li97ibJu1i6lhzJ/tLMhuWTsxC88CFjJlHWA5uOhlos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skc/SERR9kAJqX6L/iCOjvMP1MGlfVjHBcPY/ImjDmPHn+WYpo06XoKZUqL1z+rtQ
	 6ckU9iFhLfgGn0fmp+RhvHfdle25xSHh/cFHCQdQH38Swx44HFgkpjxmNMme6vpIHT
	 3jLsrGz35R/cYSbGrXBhqWFZqQVjh/TbcGGy9wmtwS0lW4J6lLXn9KAT/lQu53kPK+
	 bh6Hpvr1igwytkTDuSCF3lGfga/h3Y59H1ORsBWQLHxDnpy+YjUOMKL3bvXu/zonUG
	 N1m/GLWm3v7UOzELiHzxhVcAoZ/Ur+Y6+nhK52nWQQAXQByIBW1hssWBxJCKQ3XLcn
	 lzVKI36QSGRzw==
Date: Mon, 19 May 2025 17:02:37 +0100
From: Simon Horman <horms@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: Lower random mac address
 error print to info
Message-ID: <20250519160237.GJ365796@horms.kernel.org>
References: <20250516122655.442808-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516122655.442808-1-nm@ti.com>

On Fri, May 16, 2025 at 07:26:55AM -0500, Nishanth Menon wrote:
> Using random mac address is not an error since the driver continues to
> function, it should be informative that the system has not assigned
> a MAC address. This is inline with other drivers such as ax88796c,
> dm9051 etc. Drop the error level to info level.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> This is esp irritating on platforms such as J721E-IDK-GW which has a
> bunch of ethernet interfaces, and not all of them have MAC address
> assigned from Efuse.
> Example log (next-20250515):
> https://gist.github.com/nmenon/8edbc1773c150a5be69f5b700d907ceb#file-j721e-idk-gw-L1588

Reviewed-by: Simon Horman <horms@kernel.org>


