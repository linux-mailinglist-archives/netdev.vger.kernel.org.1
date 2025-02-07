Return-Path: <netdev+bounces-163910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B0A2BFFB
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9568316A110
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129361DDA36;
	Fri,  7 Feb 2025 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1dD8iEi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26511CDFCC
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738922041; cv=none; b=ZaF93LO3/jyQONHAwBpP7OHxJVxvI/fBdLJlbDsTF72a5Oolg+KK3BLArDSqB40z0Gc+pjazGOk6FIBDO0MTVVf4PVO6qld+m6rLcQpHHD46pMH3YbqsbdujWk7uMLHuns/pnMPkfUzulFQt5CWfy3vPDsWHaa2LRD8GRMFqibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738922041; c=relaxed/simple;
	bh=SMnb8T4b5TuxAOZm6vnEDTESOeG4ZN+XH+8hM3Pq5vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK29ejZUdXWY0sgYreY4CciZJz86pcCFOmClsugYc+XrAri6KgIpoYHeQPTqYzv9cwdaPicUL/nbyUHv5MziKA4Umz2XSFTss4JLXZcB9hbYfCkS4EGEF/6gakitWZQezmQbYRoU2uA10/YiVU8I7kc6urByJ1MS0IYWIKO5Muc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1dD8iEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B1AC4CED1;
	Fri,  7 Feb 2025 09:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738922040;
	bh=SMnb8T4b5TuxAOZm6vnEDTESOeG4ZN+XH+8hM3Pq5vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z1dD8iEi0jm8GwoVPPOVpEoAWVfigwMMcfGfy7j1P3uhBDZ1MA+jql9g4dxhVJOX0
	 jzwhuQfbdUmHB6npUhWZG6wzRdCj/iXIf1s9ZDiq/7b4ul8YCzKY4czHi72UOfZ7hQ
	 ygNA/7+KGnxaYCiXb3v93YDxppgOrMxdbLMxS4P1zVSJZdjMW/3eQr+GzGQBHaqVJ5
	 tSTockakVPYQ8g6iDAGwOgqHzlG+8Im521c9dvgzcgu2I2gJTKTaxB0d0SUorcoGTu
	 iogz+qAteULNM5b58fHRSJ3hBrKCcWVhK0Ub74lEWr6zT21HFyEj8oqquFZwoevUCa
	 o0+9Mok+U5VXA==
Date: Fri, 7 Feb 2025 09:53:55 +0000
From: Simon Horman <horms@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH net-next v2 7/7] net: ibm: emac: Use
 of_get_available_child_by_name()
Message-ID: <20250207095355.GI554665@kernel.org>
References: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
 <20250205124235.53285-8-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205124235.53285-8-biju.das.jz@bp.renesas.com>

On Wed, Feb 05, 2025 at 12:42:27PM +0000, Biju Das wrote:
> Use the helper of_get_available_child_by_name() to simplify
> emac_dt_mdio_probe().
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Dropped using _free()

Reviewed-by: Simon Horman <horms@kernel.org>


