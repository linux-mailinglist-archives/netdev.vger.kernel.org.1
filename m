Return-Path: <netdev+bounces-72644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7639859081
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 16:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E602829E0
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4637C0AF;
	Sat, 17 Feb 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TzCVrEVa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDB69DE6
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708183626; cv=none; b=GAgy83MFYFXsOCAsxOZsH1Ex/LkXufXKCIh6TFkrMGqGrw5YgqBSXfcZI9zLDK/ypofH2rhkEv2BeFwEhJSBSx9swyUGQUncV+GcIO294Lq9tpKSM5it6zI2XooqRR0GKTiLlPVEnblhgY8SN8xy8pp4v14DsF4utJEiBQEim00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708183626; c=relaxed/simple;
	bh=Fkqosf6rlqfG1yts10Y7gKXXGBycWBLBVTbdmLV3ypU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TohozaWPk+gF6DwCgekM4C+7XAXT4ctABl6cjEHOD9QnLhqIfpuf37dLadEknTpOcKrChGcwIUN1kGA4fQUuizlMx/qkii5H+UshpUszZ0vyeaa2g5jCgs2TUy7pcfccJ5frAue8umZYz7azUCIKvJssZO1QtD5Ejg0JxetgF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TzCVrEVa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OBBcsezXWRqUCDpGjGDVio9JDAAnsa9027V1MmvXDXM=; b=TzCVrEVaaSi+lX7MKcOht9xck6
	xRkAt8V5JZUBRmERiC5j1O6V4Ji+jFg8utH8QVvXwTZztGUx8DCattEC+q6s6ZmQYAitOwkARcHEy
	9yKnYmrsZHBooCsy2vOvPMEPifvlsIAojLXASmryeFE6xkdE6drL9xRSP4D9ha6yZB8E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbMaw-0084FS-Oy; Sat, 17 Feb 2024 16:27:14 +0100
Date: Sat, 17 Feb 2024 16:27:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Shyam-sundar.S-k@amd.com, Sudheesh Mavila <sudheesh.mavila@amd.com>
Subject: Re: [PATCH v5 net-next 3/5] amd-xgbe: add support for new XPCS
 routines
Message-ID: <3dec13a2-5f99-43dc-955c-c4ef60e3259c@lunn.ch>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
 <20240214154842.3577628-4-Raju.Rangoju@amd.com>
 <20240214172730.379344e5@kernel.org>
 <2024021518-germinate-carol-12c2@gregkh>
 <ae48aa95-15c5-09a0-a24c-eefb8c1b35f7@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae48aa95-15c5-09a0-a24c-eefb8c1b35f7@amd.com>

> Hi Greg,
> 
> Thanks for your inputs on this. We will work with our legal team to see if
> we can use GPLv2 instead of dual license.

Another option would be to throw away all this code and just use
phylink, which already has a driver for XPCS. Might be cheaper than
talking to lawyers :-)

	 Andrew

