Return-Path: <netdev+bounces-138532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2F59AE058
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A5CB240D3
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A378F16DC36;
	Thu, 24 Oct 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjatKlAA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7EE1B3930
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761274; cv=none; b=I7z5cGF4OCB/vhIZvGnURdqAJGRCT2b+NhDz0u+KSGg3jmUV/XecumEhqqL40Gdl1rfrP6ADtIZiDAFLtyyeCve9ie07ywH26NFEvq19YmufJsyKv2JKBk/c86ongtHy1MLl0tMDDbKA0jaiQj+pMXCeeDQjP0nqA4QalBd3nRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761274; c=relaxed/simple;
	bh=yBfz3EgduySwTFpnNerIzVboNzwmg/ifnCAQdO1XLss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6zpzQgAcAb4ipCVezrbnAzcnwaHFdfj/s0Aj1EF6raFnnKs7ar4R5EY5/iPq4wETcWkqFSFU3O6bushVf5CpHkch9bEdPqSeSOexBKaX836zWeHMUmgVT7EtI0WaoiITh76W2a/LbpAljDApxB67m1Tx32W3Gu9ehrodi7X2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjatKlAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CADC4CEC7;
	Thu, 24 Oct 2024 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729761274;
	bh=yBfz3EgduySwTFpnNerIzVboNzwmg/ifnCAQdO1XLss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjatKlAAQB5wpHOvzrPK6ZOaeTy0VRbfrL1byjzZs/GFachwAuGCUiXgyWf5sFeVE
	 0t3p5e2W5WdC9JAroBGACK6+4LNTTjJkQAYkwiVIYNcP/6sZHVgClxyayfoda9qdiH
	 GrzvR6JOD8TGpzjrsjzL/R+z4VGDwHsHfJ6ckdVVByJlAgCSpl/0L7UAOi/x1lYyfp
	 Rw48qnksZEpYNFNWn80ogZ0qoVMCkcdXYBVVthquVy0NsGHBd99SWP+z/9blfqti9c
	 zGDZ8ajSIK+p+XOeX1xqMQqLrjgn75e8n7buUC1dBa0LpECn90YBm5WP8fL6p4FvCF
	 sfDvdPj3tNpYA==
Date: Thu, 24 Oct 2024 10:14:30 +0100
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phylink: simplify phylink_parse_fixedlink()
Message-ID: <20241024091430.GJ402847@kernel.org>
References: <E1t3Fh5-000aQi-Nk@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1t3Fh5-000aQi-Nk@rmk-PC.armlinux.org.uk>

On Tue, Oct 22, 2024 at 03:17:07PM +0100, Russell King (Oracle) wrote:
> phylink_parse_fixedlink() wants to preserve the pause, asym_pause and
> autoneg bits in pl->supported. Rather than reading the bits into
> separate bools, zeroing pl->supported, and then setting them if they
> were previously set, use a mask and linkmode_and() to achieve the same
> result.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Simon Horman <horms@kernel.org>

