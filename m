Return-Path: <netdev+bounces-90146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CBD8ACDED
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BE61F2136F
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 13:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824214F122;
	Mon, 22 Apr 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Cm0hEvLG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5514658A;
	Mon, 22 Apr 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791633; cv=none; b=hjRaUStNoFP8a44myOL3EkMbHqQlOHHLVP/XjomwCNYLNXk1j9h8YkU8Fnhpnnejv3JFOCjM0qWruW2GcKSU2kuU7U3oeOxNp4uR40LA5i2cHxbCnOvbvpIaVEhtjULfkfQA4cugjcsh6ks3M4WpdAyZ4lNONlbm/9FQgBcD9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791633; c=relaxed/simple;
	bh=TJQh1ADD/TSrkcvnzZ7emzpjU95BZJD0dcxvuRp3blU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9SucA9ow4AXlrCbE+YX04xggtZfjJWyhiWkzHiemk/a/d3tE5abpaHbPgL6pgme1p+udRHwinNECDQAkgpALbeJDTCwiFUNGK5T4D+PoQCx5mu6x0t/5dhfEVdWX+m93M0MywYre5fPqRXayGDEc1tKclA2cCnbCuSPlsOdZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Cm0hEvLG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lqh3lXxat5JOwnSVIY/snEUX8+W3d9tAXaIgm8E4lbo=; b=Cm0hEvLG2ypeXAORhOA9NzpDqX
	6x0tKb/MQiOVS1N63AnNu9EvUgti59UAbmqpiTXqgU3YdZMuiueyooE+vrZNiteIJqFR71cyR+GSJ
	9YevbPv0+q9XcVL9Z8s7ge0XuVY9g3kH4ym05S0A1weASH0eH6DopDO30afbSUcXQiUo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rytUP-00DcPY-7u; Mon, 22 Apr 2024 15:13:45 +0200
Date: Mon, 22 Apr 2024 15:13:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 1/3] net: pse-pd: pse_core: Add missing kdoc
 return description
Message-ID: <bd88df2b-0e7b-48fd-8f5b-701df58458b4@lunn.ch>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
 <20240422-fix_poe-v1-1-811c8c0b9da7@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-fix_poe-v1-1-811c8c0b9da7@bootlin.com>

On Mon, Apr 22, 2024 at 02:50:48PM +0200, Kory Maincent (Dent Project) wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Add missing kernel documentation return description.
> This allows to remove all warning from kernel-doc test script.
> 
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

