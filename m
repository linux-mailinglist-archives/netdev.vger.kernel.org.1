Return-Path: <netdev+bounces-155991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798B6A048B0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B8C1888689
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED771F2C3F;
	Tue,  7 Jan 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lDjijOYi"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F718B494;
	Tue,  7 Jan 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272630; cv=none; b=lMbNibvCDPgGgoSo5Mkc3VftqeJ91wAz6JWPVN2qK5Pak40+WaQmTL5txf/t+09OjHSOL6wxenjjLbXN5l+DORNl5N0zi6ZBXVcDSjMeSvlVA35rBLAk5rJW+7IwpXGhDxEcY/oYj7rTz31CES5JNFhfjihigkzPrh+GxoeGdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272630; c=relaxed/simple;
	bh=/NXKlxfAAW33wS+eohLIUHvryr/dzVvwKlYGG7T8yig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQXVXFmtpOwkKF6XZCSg8vWJVqvZeEUSV0FVw1pBq0yIBUpHiWGP1+D9GMM+I34TBJqulcrcukSlA44XD122EF1w4BI5Jy77f5rtj+l3+DKm+OdOYr2sdzEjjECMtJ25Oa65kKrxIg6VN8nLXs5VCehU9Ht4zqpYY4W7wVmLT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lDjijOYi; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Oo0AFK2EzQ2OwrwFCMPNzHx8Ha8dYNYdRLxBsPZu2ig=; b=lDjijOYiFo0Tz9rfv4QLoNScC0
	/JkEh2Mo1bfS+s9xB2kXiZjOCVfOmsb0kb/MldD/OOId8ryI3y3i5k3KSO/Ezz37/brQyD/+xfcS+
	dFHdn8AE+fz+mSohPFa0UZauCEaSUv+VEDUHILm4oD5Db38RdWxuP3sipBHCokrY7Bo4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVDoW-002JeJ-Oh; Tue, 07 Jan 2025 18:56:24 +0100
Date: Tue, 7 Jan 2025 18:56:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <6d9ea6f5-4ff5-40ed-b470-e40c1f6a5982@lunn.ch>
References: <20250107162350.1281165-1-ninad@linux.ibm.com>
 <20250107162350.1281165-6-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107162350.1281165-6-ninad@linux.ibm.com>

On Tue, Jan 07, 2025 at 10:23:42AM -0600, Ninad Palsule wrote:
> system1 has 2 transceiver connected through the RGMII interfaces. Added
> device tree entry to enable RGMII support.
> 
> ASPEED AST2600 documentation recommends using 'rgmii-rxid' as a
> 'phy-mode' for mac0 and mac1 to enable the RX interface delay from the
> PHY chip.

Why?

Does the mac0 TX clock have an extra long clock line on the PCB?

Does the mac1 TX and RX clocks have extra long clock lines on the PCB?

Anything but rgmii-id is in most cases wrong, so you need a really
good explanation why you need to use something else. Something that
shows you understand what is going on, and why what you have is
correct.

     Andrew

