Return-Path: <netdev+bounces-175836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0472A67A84
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B5172616
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359BC20C488;
	Tue, 18 Mar 2025 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="037kR/7C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B77462;
	Tue, 18 Mar 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317951; cv=none; b=rmUGQxgfe4hnpWfLrKuuWZAvQHEq7u1rTPOPyI7EQolLjYdh73klJptxHkVr7Pi1EJJJZTKGVNz5oInR8agAVoOiSYJvnu0OtSfxduLtRFEL0hxB/rzKFIwkhG7F2AJxLdHXWjkVLC5NleB7XdPgunNvsynx81SXvjDAsc3CVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317951; c=relaxed/simple;
	bh=Ab/BBqdhakdl4MVtzDihJN6W3NdaerLsIvwDXM/d/7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQ5orjbI8FTHmy7xcVOK1FW7GoQtdZjqBXS3nVgI9MunMt/7PZioKQeBv9llVb4Aq9MOCPixCMijG9tl8CBigfGxXQw2mAkwfQOPRKeXpr3hZeXdSXvjHUU1nPSE4r5HRAW5qYgUir2MAKpDizkKFuSItaKZFWCsVH0VNjtm/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=037kR/7C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U2owTOXrGd8kZO6mxhZbVOSUDy+aaXVwSA0uKNAgyzo=; b=037kR/7CNAERhntSaerYTsSxXT
	iMEngiPACh4W5tnhPPWbOpZ9BAovd1hdkI37vFuHnF5LL5wweoTRnBMfC87tq1ihCQN+fqchLEJQH
	jguZsAr+gStBK31T4hXAmUBT9UExQhsF/tEfPt3eAt8BuXdJtKE/2blQc5Xauu7WnivY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tuaUH-006I2K-Dh; Tue, 18 Mar 2025 18:12:21 +0100
Date: Tue, 18 Mar 2025 18:12:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 8/8] net: phy: fixed_phy: transition to the faux
 device interface
Message-ID: <5ded6e25-111b-4771-9be2-46cfbee27932@lunn.ch>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
 <20250318-plat2faux_dev-v2-8-e6cc73f78478@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-plat2faux_dev-v2-8-e6cc73f78478@arm.com>

On Tue, Mar 18, 2025 at 05:01:46PM +0000, Sudeep Holla wrote:
> The net fixed phy driver does not require the creation of a platform
> device. Originally, this approach was chosen for simplicity when the
> driver was first implemented.
> 
> With the introduction of the lightweight faux device interface, we now
> have a more appropriate alternative. Migrate the device to utilize the
> faux bus, given that the platform device it previously created was not
> a real one anyway. This will get rid of the fake platform device.

You were asked to split this up by subsystem. So why is this 8/8?
There are not 7 other patches for netdev.

Please also take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

