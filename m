Return-Path: <netdev+bounces-105276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD8B91054D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51326283930
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0141AD4B9;
	Thu, 20 Jun 2024 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="twrQ8+B+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D521AD4A2;
	Thu, 20 Jun 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888411; cv=none; b=hepbVG1xePF13Kl+++UmB/xtlhfxXkvmXk30kFBCWh5V4cJbnrOC0L8oZ0x75pFlXTlkq6UnK8uCy2PtnkvKgwHCutruxvOsWJk14S8pDqa5O5eV+lMcGZyyWQ9uMYBpmgb3cmCJGFjw38c+UH77OMCP3jt/IotmX1qjQniLOiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888411; c=relaxed/simple;
	bh=YqPXYdWHvjU+t2XwcINhuPK7Yn9ha/XqvFUdns0Hehw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfGysH4o+aKCc9MgC1oUxUhHJnz84DP3fD1sCjsxzniitky71QGrbaXNgLUBoMDAVh6Yjg8hT14c8i9LnnrgV1S9ZgB5Iijh8JBlOL2yrJH5UNehuIAGjbR3+byuqBqXbC4IxPxIFhBfOZyUZH2jI+zCBea1KZLr/0WQoG9R8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=twrQ8+B+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tOYpkD0lLTweFuBKac4UCbbj5rai5jbAWkcFPPoP9mo=; b=twrQ8+B+3K62AsXBzI02vUahuD
	gurZLUe3prt/oAlyBC9+/5BHMrTeHsBZ9Vmv0BaFLjdcpcFXQnFQRNG5U9nm3uRX4D9PhxM1SJf+Q
	9t78r4rQj2XwKE5k5tK7gqaYoDK41yp/kck8oaY8/yqgEomCVxkbJHT/TZ3Mns87FdkE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKHOL-000ZWe-C4; Thu, 20 Jun 2024 14:59:53 +0200
Date: Thu, 20 Jun 2024 14:59:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Kamil =?iso-8859-1?Q?Hor=E1k?= - 2N <kamilh@axis.com>,
	Conor Dooley <conor@kernel.org>, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <9f8628dd-e11c-4c91-ad46-c1e01f17be1e@lunn.ch>
References: <20240619150359.311459-1-kamilh@axis.com>
 <20240619150359.311459-4-kamilh@axis.com>
 <20240619-plow-audacity-8ee9d98a005e@spud>
 <20240619163803.6ba73ec5@kernel.org>
 <20240620-eskimo-banana-7b90cddfd9c3@wendy>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-eskimo-banana-7b90cddfd9c3@wendy>

> BTW Jakub, am I able to interact with the pw-bot, or is that limited to
> maintainers/senior netdev reviewers? Been curious about that for a
> while..

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#updating-patch-status

	Andrew

