Return-Path: <netdev+bounces-205423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38213AFEA21
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906C5644330
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A52E0937;
	Wed,  9 Jul 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fe0jgGso"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133562DE20E;
	Wed,  9 Jul 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067450; cv=none; b=Ucrq+hywJfTKoW7b5EE+ZU6Gnf77Tz8umnoKEdKKrHJMqDPrsVQ+/khHtldxxaeCTF+HygJeVD2ZK+2e8/l8XnGlaqq3rXYJflHCiCm8OjRgFjqVxF09qP6sr77hFSPX6lNmtVl62A/JvHgKbPN091vQopRA1BrVfkNjCzv/vrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067450; c=relaxed/simple;
	bh=rQEpJHiChGmpt9oSBghyW3//Ouef5YkU5MtqrIoiTfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZqu9fz8o6HQoem9imK6ZTlMy6zJhLgJa5dLqeq9rvmhsPzCnB1eSiXHlQYGfxOL7hUMPXoeh4nLeWwVV9LspRAVWltIxbtxomF9UtTxpki38d9+l7ORBFACba2IFcOD7sXghaKhxxp3ZXfX5cYfIpI2gcLfuVjgwiNmRtyL5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fe0jgGso; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hQ9HxQ4CL5cwBPjvKDpDZamXchNvQ4T7qK3P3nj85G8=; b=Fe0jgGsoitEJIzGGN64xp/8LbW
	PSANpYST+y4jFNuWxPL1FSw9Flcaw2JOQJMywR6O1NmbtVZaaIcBQ3wgcPIKZTgcvt2Dn424ws8lh
	9BeU8GQk5eVXBWpUMgiEqoUxiNo1BrJuW5CszAKN9N1V4/Fswlmq39ewio9vZF4N7ULg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZUmG-000waz-04; Wed, 09 Jul 2025 15:24:00 +0200
Date: Wed, 9 Jul 2025 15:23:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, horms@kernel.org,
	jacob.e.keller@intel.com, u.kleine-koenig@baylibre.com,
	hkallweit1@gmail.com, BMC-SW@aspeedtech.com
Subject: Re: [net-next v4 4/4] net: ftgmac100: Add optional reset control for
 RMII mode on Aspeed SoCs
Message-ID: <3dee14d4-c8bd-4c27-b9b1-28b449510b84@lunn.ch>
References: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
 <20250709070809.2560688-5-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709070809.2560688-5-jacky_chou@aspeedtech.com>

On Wed, Jul 09, 2025 at 03:08:09PM +0800, Jacky Chou wrote:
> On Aspeed SoCs, the internal MAC reset is insufficient to fully reset the
> RMII interface; only the SoC-level reset line can properly reset the RMII
> logic. This patch adds support for an optional "resets" property in the
> device tree, allowing the driver to assert and deassert the SoC reset line
> when operating in RMII mode. This ensures the MAC and RMII interface are
> correctly reset and initialized.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

