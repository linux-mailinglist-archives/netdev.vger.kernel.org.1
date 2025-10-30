Return-Path: <netdev+bounces-234456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512AC20C8D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FAAC4F2ADC
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C3927F759;
	Thu, 30 Oct 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qvNcPDRh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182427F195;
	Thu, 30 Oct 2025 14:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761836036; cv=none; b=aGmoRbXLmc5jTJimxddfYda6nBU8Iw26wXsQDBEUUYm9TNPysFGQa9CwmHiCi8nBIKM2yeOcewhdznk/tXsvnjC8gTSOEo5Fj7aSxYHNyNJfvZ7rtcXRGtya5ZJuTriWxmhNUUDWYIkP9HqGpN12dVT6cSrETibsAVFb9NUhkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761836036; c=relaxed/simple;
	bh=nb8d7w8la803yo5UP2oJCicx+U4WvvvQT7Uug6wtgmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLTFytLnh43JwQk0zpauQcVDOzo6FnU7B7+C3kB8kXc8ghF7P4Q4zIAX0mJa5vY6ENo8Tqobml7BXrMpT2w3DxtIXcWh1Z2Em/mYBLTogVWtBIc9fdy0iaQzykJjnaOyCZZzYq8bi/h7b2hbkjLL9DjpvY/fv3zszYzOObFny/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qvNcPDRh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kj7qOkOQBYxTY25+TU8TMzDFc8CdJqCAS3UHxTj/Oeg=; b=qvNcPDRha2U/HuBozi6InB/chZ
	gNOFo+/oeujtyI0ZobhIQLf0+hJXc7tXWfMuUgxc8dFeSqhuU1XY7qFwHCWoSj+HtVJ+zDYBZ8NbS
	XGQBk1ZDgudSv+IVQjZ/I3B7Zkmz6VJUJvXzbdgxNqqHEo7EDU5/ngKjhCx7FQpGC4oA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vEU27-00CWHk-5r; Thu, 30 Oct 2025 15:53:47 +0100
Date: Thu, 30 Oct 2025 15:53:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: microchip_t1s: configure link
 status control for LAN867x Rev.D0
Message-ID: <3ecf0e2a-37ea-4d2c-96a5-b83a03cc77c2@lunn.ch>
References: <20251030102258.180061-1-parthiban.veerasooran@microchip.com>
 <20251030102258.180061-3-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030102258.180061-3-parthiban.veerasooran@microchip.com>

On Thu, Oct 30, 2025 at 03:52:58PM +0530, Parthiban Veerasooran wrote:
> Configure the link status in the Link Status Control register for
> LAN8670/1/2 Rev.D0 PHYs, depending on whether PLCA or CSMA/CD mode
> is enabled. When PLCA is enabled, the link status reflects the PLCA
> status. When PLCA is disabled (CSMA/CD mode), the PHY does not support
> autonegotiation, so the link status is forced active by setting
> the LINK_STATUS_SEMAPHORE bit.
> 
> The link status control is configured:
> - During PHY initialization, for default CSMA/CD mode.
> - Whenever PLCA configuration is updated.
> 
> This ensures correct link reporting and consistent behavior for
> LAN867x Rev.D0 devices.
> 
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

