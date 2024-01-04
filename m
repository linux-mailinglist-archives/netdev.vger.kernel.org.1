Return-Path: <netdev+bounces-61567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7BA8244A5
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38339284A30
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7F624211;
	Thu,  4 Jan 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="l3cjGmd4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C22421C;
	Thu,  4 Jan 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8zmGyqeDx3dP5JdwSkl8tks0Ch6L5pRsGnicC54gDsA=; b=l3cjGmd4+NPaKAZk5qw+Lwcibq
	LvMwl323sJxscAABixxkHcWyXGnV1XGDPp46+2e9uBCcEC6vOb74OXeidmfb0+wqIz6MeMIdpFzm3
	cQTFBHepwDPo7fEzn2GY3SeyxE353XufyZJ1jHxTRPqKWl+E1emCMykxgGbDFgFyrnoo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLPJl-004MOG-1j; Thu, 04 Jan 2024 16:07:33 +0100
Date: Thu, 4 Jan 2024 16:07:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, f.fainelli@gmail.com, olteanv@gmail.com,
	hauke@hauke-m.de, kurt@linutronix.de, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, arinc.unal@arinc9.com,
	daniel@makrotopia.org, Landen.Chao@mediatek.com, dqfext@gmail.com,
	sean.wang@mediatek.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com, clement.leger@bootlin.com,
	george.mccollister@gmail.com, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next] net: fill in MODULE_DESCRIPTION()s for DSA tags
Message-ID: <b55e40ca-2d76-40c5-a0be-67f22cfde332@lunn.ch>
References: <20240104143759.1318137-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104143759.1318137-1-kuba@kernel.org>

On Thu, Jan 04, 2024 at 06:37:59AM -0800, Jakub Kicinski wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to all the DSA tag modules.
> 
> The descriptions are copy/pasted Kconfig names, with s/^Tag/DSA tag/.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

