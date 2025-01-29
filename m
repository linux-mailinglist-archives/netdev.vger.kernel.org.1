Return-Path: <netdev+bounces-161553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94E3A2247A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DDC1883C7E
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03441E2838;
	Wed, 29 Jan 2025 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T8bbnKHz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE791E1C36
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738178081; cv=none; b=muSa0okkWo9f25+1XkJ99tMiXyS1K1KM8u0RtwakluF7fgkXn/d9m1ulq4E5i3VxsUSy1QPX2tmi0zup0HyRv5Ccz2ABOpBfnUWVbZZEPeCMlh1A0mOFIklfY/ydlncBAieNUQUnS8Lr6bRbpUg3ysOz5BGLZYd9vU+R5cWqAXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738178081; c=relaxed/simple;
	bh=EQHxKuLhNQxdGzHD93B13a+iRXldLmeMfBsGxjsR+fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbbuFFkpvFCNrM4+4hkasxpibT7/6rbbP5mu2/lLL1vVmyMLkAKf6dNktePMwIeT6hb6ydJ1UgfJ36fsoTDONjHZCojDW39Yxf7E9b2v+CwmJ0BIJrITGMXrFQuefHl4rTgOIsRPoVtTxIUAdwO2c4R1K3VOgAvxOLAE9X9UXWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T8bbnKHz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RePCD8csmQd1FQCw+uT83FJgrl3GQ664A7Y3jgIp1WI=; b=T8bbnKHz6Tr9bl626Tc3XzaUNk
	vuk9CoF54MjxX3Lf1YoQNMWKz+zaT6/1i5t00wcHYMOHmumFRouEjCAr5m55k6FXn/AeSuu+87SUT
	s+9TXm/UbJD0yv+tM281a9b2O4lLt1g4jkIK7SIUXHufadVwrso72zaB4rqyQqISHeG4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tdDW5-009Cgg-VN; Wed, 29 Jan 2025 20:14:25 +0100
Date: Wed, 29 Jan 2025 20:14:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "sreedevi.joshi" <joshisre@ecsmtp.an.intel.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>
Subject: Re: [PATCH net] phy: fix null pointer issue in phy_attach_direct()
Message-ID: <fa054892-b501-4e98-a8a5-6fc9acc68be5@lunn.ch>
References: <20250129183638.695010-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129183638.695010-1-sreedevi.joshi@intel.com>

On Wed, Jan 29, 2025 at 12:36:38PM -0600, sreedevi.joshi wrote:
> From: Sreedevi Joshi <sreedevi.joshi@intel.com>
> 
> When attaching a fixed phy to devices like veth

Humm. Zoom out. What is the big picture? Why would a veth need a PHY?

	Andrew

