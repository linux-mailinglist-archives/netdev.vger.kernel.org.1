Return-Path: <netdev+bounces-232242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04566C031C3
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 20:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66E619C4AB9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F48E34B695;
	Thu, 23 Oct 2025 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b2ZJ0HIo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EA34AAF2;
	Thu, 23 Oct 2025 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245880; cv=none; b=Eiapviq/LMh2eCIq0rIC30Rfmia8OfZgPY8X+8AJi/aJZxRWNg3i2l8LyCQrMIaFvOoqWGTkjqYSpC/t6LJFbzaEWxfcwLHtJiWOjfEQlacHVUe+JkAYasUdo7/AWLGwh8nNGYQiOVQql2t7mJtwg1lbV9zFAQcgBnJNg8zu/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245880; c=relaxed/simple;
	bh=XfXm6Lrj1Uo8Yci5XSs111jc6ij/M9ffOuPUTr0cKTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rC8LWXyLq+R2vpJ0SrcczoypkuoldVOT7SX94Wvf+HSAnHU7cwC84ZfAqOs7qe5mYdTC3aeqEwO7glY9jI/3HUAzuiQ1TBPYJXSaRJkDrAlExwCoUXEUo3Wloxwsy1L/5j+vmAEOhqwgk4917okQRMPrzL51rmo5G8xUn6FYVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b2ZJ0HIo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X5+yCSGksFVRNRQf31YBe+wjmkAH6A3Ih7vubn4fPMA=; b=b2ZJ0HIob3ZMvZA80vttAQ1a7H
	iiBQHcFLOAxvT5TaBjA3jDeqeQoQu4TDQEvEa0JDnfiy8/0xYdn4VZr4TpDk24qMUHybPhD+cnZaI
	0od+bZrDEhBVqx/DANgtBZfHCjpzb9B0tS6MG+f/rzsqvuBTsFiXv0bEE+avkj7sDoKY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vC0VS-00BuhZ-FF; Thu, 23 Oct 2025 20:57:50 +0200
Date: Thu, 23 Oct 2025 20:57:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	jonas@kwiboo.se
Subject: Re: [PATCH v2 5/5] MAINTAINERS: add dwmac-rk glue driver to the main
 Rockchip entry
Message-ID: <35567cda-0f49-4784-b873-97e378fcee16@lunn.ch>
References: <20251023111213.298860-1-heiko@sntech.de>
 <20251023111213.298860-6-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023111213.298860-6-heiko@sntech.de>

On Thu, Oct 23, 2025 at 01:12:12PM +0200, Heiko Stuebner wrote:
> The dwmac-rk glue driver is currently not caught by the general maintainer
> entry for Rockchip SoCs, so add it explicitly, similar to the i2c driver.
> 
> The binding document in net/rockchip-dwmac.yaml already gets caught by
> the wildcard match.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

